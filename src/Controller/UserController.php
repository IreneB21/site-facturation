<?php

namespace App\Controller;

use App\Model\UserManager;

class UserController extends AbstractController
{
    private UserManager $userManager;

    public function __construct()
    {
        parent::__construct();
        $this->userManager = new userManager();
    }

    /**
     * Display infos page
     */
    public function index()
    {
        // Vérifier si l'utilisateur est connecté
        $this->startSession();
        if (!$this->getSession('user_id')) {
            // Rediriger vers la page de connexion si non connecté
            header('Location: /login');
            exit();
        }

        $errors = [];

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $user = array_map('htmlentities', array_map('trim', $_POST));

            if (
                empty($user['siret']) || !preg_match(
                    '/^[0-9]{14}$/',
                    $user['siret']
                )
            ) {
                $errors[] = 'Le numéro de Siret doit être renseigné et comporter 14 chiffres.';
            }
            if (
                empty($user['firstname'])
            ) {
                $errors[] = 'Le prénom doit être renseigné.';
            }
            if (
                empty($user['lastname'])
            ) {
                $errors[] = 'Le nom doit être renseigné.';
            }
            if (
                empty($user['address'])
            ) {
                $errors[] = 'L\'adresse postale doit être renseignée.';
            }
            if (
                empty($user['bank_details']) || !preg_match(
                    '/^[A-Z]{2}[0-9]{2}[A-Z0-9]{11,30}$/',
                    $user['bank_details']
                )
            ) {
                $errors[] = 'Veuillez entrer un IBAN valide.';
            }

            // Si pas d'erreurs, insérer les informations puis redirection vers le dashboard
            if (empty($errors)) {
                // Insertion  des informations pro
                $this->userManager->insertOrUpdateInfos($user, $_SESSION['user_id']);

                // Redirection vers le dashboard
                header('Location: /dashboard');
                exit;
            }
        }

        return $this->twig->render('Infos/infos.html.twig', [
            'errors' => $errors,
            'infos' => $this->userManager->getUserInfos($_SESSION['user_id']),
        ]);
    }

    /**
     * Delete a user
     */
    public function delete()
    {
        // Vérifier si l'utilisateur est connecté
        $this->startSession();
        if (!$this->getSession('user_id')) {
            // Rediriger vers la page de connexion si non connecté
            header('Location: /login');
            exit();
        }

        // Suppression du compte
        $this->userManager->delete($_SESSION['user_id']);

        // Redirection vers le dashboard
        header('Location: /logout');
        exit;
    }

    /**
    * Display Password Page
    */
    public function password()
    {
        // Vérifier si l'utilisateur est connecté
        $this->startSession();
        if (!$this->getSession('user_id')) {
            // Rediriger vers la page de connexion si non connecté
            header('Location: /login');
            exit();
        }

        $errors = [];

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $user = array_map('htmlentities', array_map('trim', $_POST));

            if (empty($user['old_password']) || !preg_match('/^[A-Za-zÀ-ÿ0-9 \'.,!@#$%^&*()_-]+$/', $user['old_password'])) {
                $errors[] = 'L\'ancien mot de passe doit être renseigné et contenir des caractères valides.';
            }

            if (empty($user['new_password']) || !preg_match('/^[A-Za-zÀ-ÿ0-9 \'.,!@#$%^&*()_-]+$/', $user['new_password'])) {
                $errors[] = 'Le nouveau mot de passe doit être renseigné et contenir des caractères valides.';
            }

            // Si pas d'erreurs, vérifier l'ancien mot de passe
            if (empty($errors)) {
                $currentPassword = $this->userManager->getPasswordByUserId($_SESSION['user_id']);

                if (password_verify($user['old_password'], $currentPassword)) {
                    // Si l'ancien mot de passe est correct, changer le mot de passe
                    $newPasswordHash = password_hash($user['new_password'], PASSWORD_BCRYPT);
                    $this->userManager->updatePassword($newPasswordHash, $_SESSION['user_id']);

                    // Redirection
                    header('Location: /logout');
                    exit();
                } else {
                    $errors[] = 'L\'ancien mot de passe est incorrect.';
                }
            }
        }

        return $this->twig->render('Infos/password.html.twig', [
            'errors' => $errors,
        ]);
    }
}
