CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

CREATE TABLE roles (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);
INSERT INTO roles (nome) 
VALUES 
("Client"),
("Client Vip"),
("Product Manager"),
("Order Manager"),
("Customer Service"),
("Accounting and Finance"),
("Admin"),
("Owner");

CREATE TABLE notify_messages (
	notify_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    user_id INT,
    message VARCHAR(255)
);

CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE KEY,
    email VARCHAR(255) NOT NULL UNIQUE KEY,
    profile_img VARCHAR(255),
    password_hash VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    address VARCHAR(255),
    phone VARCHAR(255),
    shopping INT,
    gender VARCHAR(50),
    cpf VARCHAR(20) UNIQUE KEY,
    cards INT,
    created_at DATETIME DEFAULT NOW() NOT NULL
);
ALTER TABLE users MODIFY COLUMN password_hash VARCHAR(255) NOT NULL;
ALTER TABLE users ADD messages INT;
ALTER TABLE users ADD FOREIGN KEY (messages) REFERENCES notify_messages(notify_id);
ALTER TABLE users ADD classe VARCHAR(255);
ALTER TABLE notify_messages ADD FOREIGN KEY (user_id) REFERENCES users(user_id);
INSERT INTO users (fullname, username, email, profile_img, password_hash, date_of_birth, address, phone, gender, cpf, created_at)
VALUES 
    ("User 1", "user1", "user1@example.com", "profile1.jpg", "password1", '1990-01-01', "123 Main St", "Shopping Center", "Male", "123456789", NOW()),
    ("User 2", "user2", "user2@example.com", "profile2.jpg", "password2", '1985-02-15', "456 Elm St", "Local Mall", "Female", "987654321", NOW()),
    ("User 3", "user3", "user3@example.com", "profile3.jpg", "password3", '1992-04-30', "789 Oak St", "Downtown Plaza", "Male", "112233445", NOW()),
    ("User 4", "user4", "user4@example.com", "profile4.jpg", "password4", '1988-07-22', "101 Pine St", "Fashion Outlet", "Female", "998877665", NOW()),
    ("User 5", "user5", "user5@example.com", "profile5.jpg", "password5", '1995-09-10', "202 Cedar St", "Supermarket", "Male", "334455667", NOW()),
    ("User 6", "user6", "user6@example.com", "profile6.jpg", "password6", '1987-11-12', "303 Maple St", "Mall Complex", "Female", "556677889_1", NOW()),
    ("User 7", "user7", "user7@example.com", "profile7.jpg", "password7", '1993-03-25', "404 Walnut St", "Shopping Center", "Male", "112233445_1", NOW()),
    ("User 8", "user8", "user8@example.com", "profile8.jpg", "password8", '1991-06-18', "505 Birch St", "Fashion Outlet", "Female", "998877665_1", NOW()),
    ("User 9", "user9", "user9@example.com", "profile9.jpg", "password9", '1989-08-06', "606 Oak St", "Local Mall", "Male", "334455667_1", NOW()),
    ("User 10", "user10", "user10@example.com", "profile10.jpg", "password10", '1994-12-09', "707 Pine St", "Supermarket", "Female", "556677889_2", NOW());
    
select * from users;
describe users;
CREATE TABLE credit_cards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    card_number VARCHAR(20) NOT NULL,
    card_holder_name VARCHAR(100) NOT NULL,
    expiration_date DATE NOT NULL,
    cvv VARCHAR(3) NOT NULL,
    billing_address VARCHAR(255) NOT NULL,
    is_default BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

ALTER TABLE users ADD FOREIGN KEY (cards) REFERENCES credit_cards(card_id);

INSERT INTO credit_cards (card_number, card_holder_name, expiration_date, cvv, billing_address, is_default, user_id) 
VALUES 
('1234 5678 9101 1120', 'Carlos Miguel', '2029-12-01', '123', 'São Paulo, SP', 1, 1);


CREATE TABLE users_roles (
    role_id INT UNSIGNED,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE colors (
    colors_id INT PRIMARY KEY AUTO_INCREMENT,
    name_color VARCHAR(15)
);

INSERT INTO colors (name_color) VALUES
    ('Azul'),
    ('Preto'),
    ('Branco'),
    ('Vermelho'),
    ('Verde');

CREATE TABLE images (
    images_id INT PRIMARY KEY AUTO_INCREMENT,
    url VARCHAR(255)
);

CREATE TABLE promos (
    promos_id INT PRIMARY KEY AUTO_INCREMENT,
    discount_percentage INT NOT NULL,
    end_date DATE NOT NULL
);
INSERT INTO promos (discount_percentage, end_date) VALUES (30, '2023-10-30');
CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text TEXT NOT NULL,
    user_id INT NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    rating DOUBLE NOT NULL,
    timespost TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
INSERT INTO comments (comment_text, user_id, product_id, timespost ) VALUES 
("Achei ridiculo pra falar a verdade", 10, 3, 2.5, now());

CREATE TABLE product (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(45) NOT NULL,
    summary TEXT NOT NULL,
    quantidy INT NOT NULL,
    sold INT,
    price INT DEFAULT 0,
    state BOOLEAN DEFAULT TRUE,
    category VARCHAR(15) NOT NULL,
    sizes VARCHAR(100),
    brand VARCHAR(100),
    guarantee VARCHAR(100),
    variation VARCHAR(100),
    assessment DOUBLE DEFAULT 0,
    parcelable BOOLEAN DEFAULT FALSE,
    max_installments INT,
    interest_rate DOUBLE,
    update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    created_at DATETIME DEFAULT NOW() NOT NULL,
    cor_id INT,
    FOREIGN KEY (cor_id) REFERENCES colors(colors_id),
    promotion INT,
    FOREIGN KEY (promotion) REFERENCES promos(promos_id)
);
ALTER TABLE product ADD classe VARCHAR(255);
ALTER TABLE users
DROP COLUMN classe;
select * from product;
describe product;
CREATE TABLE product_images (
    product_id INT UNSIGNED,
    url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

ALTER TABLE comments ADD FOREIGN KEY (product_id) REFERENCES product(id);


INSERT INTO product (title, summary, quantidy, sold, price, state, category, sizes, brand, guarantee, variation, assessment, parcelable, max_installments, interest_rate, cor_id, created_at, update_at)
VALUES
    ('Camiseta Estampada', 'Camiseta com estampa moderna e cores vibrantes.', 100, 50, 25.0, true, 'Camisetas', 'S, M, L', 'Marca Nike', '1 ano', 'Estampa 1', 4.5, false, 0, 0, 1, NOW(), NOW());

INSERT INTO product (title, summary, quantidy, sold, price, state, category, sizes, brand, guarantee, variation, assessment, parcelable, max_installments, interest_rate, cor_id, created_at, update_at)
VALUES
    ('Camiseta Estampada', 'Camiseta com estampa moderna e cores vibrantes.', 100, 50, 25.0, true, 'Camisetas', 'S, M, L', 'Marca Nike', '1 ano', 'Estampa 1', 4.5, false, 0, 0, 1, NOW(), NOW()),
    ('Calça Jeans Skinny', 'Calça jeans ajustada ao corpo, estilo moderno.', 80, 30, 45.0, true, 'Calças', 'S, M, L', 'Marca Fashion', '2 anos', 'Azul Escuro', 4.2, true, 12, 0.03, 2, NOW(), NOW()),
    ('Tênis Esportivo', 'Tênis esportivo para corridas e atividades físicas.', 120, 80, 70.0, true, 'Tênis', '38, 39, 40, 41, 42', 'Marca Esportiva', '1 ano', 'Preto', 4.7, false, 0, 0, 2, NOW(), NOW());

INSERT INTO product_images (product_id, url)
VALUES
    (4, "calca.jpg"),
    (4, "calca2.jpg");
    
CREATE TABLE buy_product(
    solicitation_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_buy INT,
    FOREIGN KEY (user_buy) REFERENCES users(user_id),
    product_buy INT UNSIGNED NOT NULL,
    FOREIGN KEY (product_buy) REFERENCES product(id),
    guarantee VARCHAR(100),
    variation VARCHAR(100),
    size VARCHAR(100),
    payment_method VARCHAR(50),
    card INT,
    FOREIGN KEY (card) REFERENCES credit_cards(card_id),
    status_product VARCHAR(50),
    shipping_address TEXT,
    paid BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT NOW() NOT NULL
);

INSERT INTO buy_product(user_buy, product_buy , guarantee, variation,payment_method , shipping_address, paid, created_at) VALUES 
(4, 3, " 1 Mês", "Estampa 1", "Credit Card", "São Paulo, SP", 0, now());

ALTER TABLE users ADD FOREIGN KEY (shopping) REFERENCES buy_product(solicitation_id);

-- Inserir produtos OK
-- Relacionar imagens aos produtos OK
-- Criação de Usuarios OK
-- Relacionar cartões aos usuarios OK
-- Criado Cargos OK
-- Relação  Cargos e Usuarios 	OK
-- comentarios de usuarios sobre produtos OK