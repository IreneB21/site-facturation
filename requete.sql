-- Commencer une transaction pour la première facture
START TRANSACTION;

-- Insertion d'une facture fictive pour l'utilisateur avec l'ID 1
INSERT INTO `invoice` (
    `total_amount`, `bill_status`, `due_at`, `user_name`, `user_address`, 
    `user_siret`, `user_bank_details`, `client_siret`, `client_name`, 
    `client_address`, `created_at`, `user_id`
) VALUES (
    1000.00, 'Unpaid', '2024-07-01', 'John Doe', '123 Rue de l\'Exemple', 
    '12345678901234', 'FR7630004000031234567890143', '56789012345678', 
    'Entreprise Alpha', '456 Avenue de la Liberté', '2024-06-12', 1
);

-- Insertion des produits associés à la facture nouvellement créée
INSERT INTO `product` (`name`, `quantity`, `price`, `invoice_id`)
VALUES ('Ordinateur Portable', 2, 100.00, LAST_INSERT_ID()),
       ('Imprimante', 3, 150.00, LAST_INSERT_ID()),
       ('Souris sans fil', 1, 200.00, LAST_INSERT_ID());

-- Valider la transaction
COMMIT;

-- Commencer une transaction pour la deuxième facture
START TRANSACTION;

-- Insertion d'une facture fictive pour l'utilisateur avec l'ID 1
INSERT INTO `invoice` (
    `total_amount`, `bill_status`, `due_at`, `user_name`, `user_address`, 
    `user_siret`, `user_bank_details`, `client_siret`, `client_name`, 
    `client_address`, `created_at`, `user_id`
) VALUES (
    1500.00, 'Paid', '2024-07-10', 'John Doe', '123 Rue de l\'Exemple', 
    '12345678901234', 'FR7630004000031234567890143', '67890123456789', 
    'Entreprise Beta', '789 Boulevard de la République', '2024-06-12', 1
);

-- Insertion des produits associés à la facture nouvellement créée
INSERT INTO `product` (`name`, `quantity`, `price`, `invoice_id`)
VALUES ('Moniteur 27 pouces', 5, 300.00, LAST_INSERT_ID()),
       ('Clavier mécanique', 2, 450.00, LAST_INSERT_ID()),
       ('Casque audio', 1, 150.00, LAST_INSERT_ID());

-- Valider la transaction
COMMIT;

-- Commencer une transaction pour la troisième facture
START TRANSACTION;

-- Insertion d'une facture fictive pour l'utilisateur avec l'ID 1
INSERT INTO `invoice` (
    `total_amount`, `bill_status`, `due_at`, `user_name`, `user_address`, 
    `user_siret`, `user_bank_details`, `client_siret`, `client_name`, 
    `client_address`, `created_at`, `user_id`
) VALUES (
    2000.00, 'Unpaid', '2024-07-20', 'John Doe', '123 Rue de l\'Exemple', 
    '12345678901234', 'FR7630004000031234567890143', '78901234567890', 
    'Entreprise Gamma', '123 Place de la Concorde', '2024-06-12', 1
);

-- Insertion des produits associés à la facture nouvellement créée
INSERT INTO `product` (`name`, `quantity`, `price`, `invoice_id`)
VALUES ('Tablette', 3, 600.00, LAST_INSERT_ID()),
       ('Smartphone', 4, 200.00, LAST_INSERT_ID()),
       ('Chargeur rapide', 1, 400.00, LAST_INSERT_ID());

-- Valider la transaction
COMMIT;

-- Commencer une transaction pour la quatrième facture
START TRANSACTION;

-- Insertion d'une facture fictive pour l'utilisateur avec l'ID 1
INSERT INTO `invoice` (
    `total_amount`, `bill_status`, `due_at`, `user_name`, `user_address`, 
    `user_siret`, `user_bank_details`, `client_siret`, `client_name`, 
    `client_address`, `created_at`, `user_id`
) VALUES (
    2500.00, 'Paid', '2024-07-30', 'John Doe', '123 Rue de l\'Exemple', 
    '12345678901234', 'FR7630004000031234567890143', '89012345678901', 
    'Entreprise Delta', '456 Chemin des Étoiles', '2024-06-12', 1
);

-- Insertion des produits associés à la facture nouvellement créée
INSERT INTO `product` (`name`, `quantity`, `price`, `invoice_id`)
VALUES ('Serveur NAS', 6, 250.00, LAST_INSERT_ID()),
       ('Disque dur externe', 2, 700.00, LAST_INSERT_ID()),
       ('Routeur Wi-Fi', 1, 300.00, LAST_INSERT_ID());

-- Valider la transaction
COMMIT;
