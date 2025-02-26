-- Création de la table USER
CREATE TABLE `user` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Création de la table INFO
CREATE TABLE `info` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `firstname` VARCHAR(255) NOT NULL,
    `lastname` VARCHAR(255) NOT NULL,
    `siret` CHAR(14) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `bank_details` VARCHAR(34) NOT NULL,
    `user_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Création de la table INVOICE
CREATE TABLE `invoice` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `total_amount` DECIMAL(10,2) NOT NULL,
    `status` VARCHAR(255) DEFAULT 'à encaisser',
    `due_at` DATE NOT NULL,
    `user_name` VARCHAR(255) NOT NULL,
    `user_address` VARCHAR(255) NOT NULL,
    `user_siret` CHAR(14) NOT NULL,
    `user_bank_details` VARCHAR(255),
    `client_siret` CHAR(14),
    `client_name` VARCHAR(255),
    `client_address` VARCHAR(255),
    `created_at` DATE NOT NULL,
    `user_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Création de la table PRODUCT
CREATE TABLE `product` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `quantity` INT NOT NULL,
    `price` DECIMAL(10,2) NOT NULL,
    `invoice_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`invoice_id`) REFERENCES `invoice`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Création de l'évènement de mise à jour du statut dans INVOICE
CREATE EVENT update_invoice_status
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE invoice
    SET status = 'à relancer'
    WHERE due_at < CURDATE() AND status != 'payée';

    UPDATE invoice
    SET status = 'à encaisser'
    WHERE due_at >= CURDATE() AND status != 'payée';
END;