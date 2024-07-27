<?php

namespace App\Model;

use PDO;

class SearchManager extends AbstractManager
{
    public const TABLE = 'invoice';

    public function search(string $searchRequest, int $userId): array
    {
        // Normaliser la chaîne de recherche en utilisant UTF-8 et ignorer la casse
        $searchRequest = mb_strtolower($searchRequest, 'UTF-8');
        $searchRequest = "%" . $searchRequest . "%";

        $query = "SELECT created_at, status, client_name, total_amount, id
                FROM " . self::TABLE . "
                WHERE (LOWER(client_name) LIKE :searchRequest COLLATE utf8_general_ci
                    OR LOWER(status) LIKE :searchRequest COLLATE utf8_general_ci
                    OR CAST(total_amount AS CHAR) LIKE :searchRequest
                    OR CAST(created_at AS CHAR) LIKE :searchRequest)
                AND user_id = $userId
                ORDER BY created_at DESC, total_amount DESC";
        $searchStatement = $this->pdo->prepare($query);
        $searchStatement->bindValue(':searchRequest', $searchRequest, PDO::PARAM_STR);
        $searchStatement->execute();

        return $searchStatement->fetchAll(PDO::FETCH_ASSOC);
    }
}
