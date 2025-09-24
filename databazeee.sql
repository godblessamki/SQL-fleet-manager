CREATE DATABASE ProjektAutobazar;
USE ProjektAutobazar;

CREATE TABLE Auta (
id INT AUTO_INCREMENT PRIMARY KEY,
znacka VARCHAR(50) NOT NULL,
model VARCHAR(50) NOT NULL,
rok_vyroby VARCHAR(50) NOT NULL
);

CREATE TABLE Zakaznici (
id INT AUTO_INCREMENT PRIMARY KEY,
jmeno VARCHAR(50) NOT NULL,
prijmeni VARCHAR(50) NOT NULL,
telefonni_cislo INT NOT NULL
);
CREATE TABLE Rezervace (
    id INT AUTO_INCREMENT PRIMARY KEY,
    zakaznik_id INT NOT NULL, -- Vazba na Zakaznici
    auto_id INT NOT NULL, -- Vazba na Auta
    datum_od DATE NOT NULL,
    datum_do DATE NOT NULL,
    stav ENUM('rezervováno', 'vráceno', 'zrušeno') DEFAULT 'rezervováno',
    FOREIGN KEY (zakaznik_id) REFERENCES Zakaznici(id) ON DELETE CASCADE,
    FOREIGN KEY (auto_id) REFERENCES Auta(id) ON DELETE CASCADE
);

CREATE TABLE Servisy (
    id INT AUTO_INCREMENT PRIMARY KEY,
    auto_id INT NOT NULL, -- Vazba na Auta
    datum_servisu DATE NOT NULL,
    popis VARCHAR(255) NOT NULL,
    cena DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (auto_id) REFERENCES Auta(id) ON DELETE CASCADE
);
CREATE TABLE Kategorie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL UNIQUE,
    popis VARCHAR(255)
);
CREATE TABLE Pojisteni (
    id INT AUTO_INCREMENT PRIMARY KEY,
    auto_id INT NOT NULL,
    typ_pojisteni ENUM('povinné ručení', 'havarijní', 'kombinované') NOT NULL,
    platnost_od DATE NOT NULL,
    platnost_do DATE NOT NULL,
    cena DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (auto_id) REFERENCES Auta(id) ON DELETE CASCADE
);
CREATE TABLE Zamestnanci (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jmeno VARCHAR(50) NOT NULL,
    prijmeni VARCHAR(50) NOT NULL,
    pozice VARCHAR(50),
    telefonni_cislo VARCHAR(15),
    email VARCHAR(100) UNIQUE
);
CREATE TABLE Jizdy (
    id INT AUTO_INCREMENT PRIMARY KEY,
    auto_id INT NOT NULL,
    zakaznik_id INT NOT NULL,
    zamestnanec_id INT, -- Zaměstnanec odpovědný za předání/vrácení auta
    datum_zapujceni DATE NOT NULL,
    datum_vraceni DATE,
    stav_pri_vraceni VARCHAR(255),
    cena_celkem DECIMAL(10, 2),
    FOREIGN KEY (auto_id) REFERENCES Auta(id) ON DELETE CASCADE,
    FOREIGN KEY (zakaznik_id) REFERENCES Zakaznici(id) ON DELETE CASCADE,
    FOREIGN KEY (zamestnanec_id) REFERENCES Zamestnanci(id) ON DELETE SET NULL
);
CREATE TABLE Ceniky (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kategorie_id INT,
    auto_id INT,
    cena_za_den DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (kategorie_id) REFERENCES Kategorie(id) ON DELETE SET NULL,
    FOREIGN KEY (auto_id) REFERENCES Auta(id) ON DELETE SET NULL
);
CREATE TABLE Pokuty (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jizda_id INT NOT NULL,
    popis VARCHAR(255) NOT NULL,
    castka DECIMAL(10, 2) NOT NULL,
    datum DATE NOT NULL,
    FOREIGN KEY (jizda_id) REFERENCES Jizdy(id) ON DELETE CASCADE
);



-- Data pro tabulku Auta
INSERT INTO Auta (znacka, model, rok_vyroby) 
VALUES
('Škoda', 'Octavia', '2015'),
('Volkswagen', 'Golf', '2018'),
('Toyota', 'Corolla', '2020'),
('Ford', 'Focus', '2017'),
('Hyundai', 'i30', '2022'),
('BMW', 'X5', '2019'),
('Peugeot', '208', '2021'),
('Tesla', 'Model 3', '2023');

-- Data pro tabulku Zakaznici
INSERT INTO Zakaznici (jmeno, prijmeni, telefonni_cislo)
VALUES
('Jan', 'Novák', 123456789),
('Petr', 'Svoboda', 987654321),
('Anna', 'Dvořáková', 456789123),
('Lucie', 'Novotná', 789123456),
('Tomáš', 'Horák', 654987321),
('Kateřina', 'Malá', 321654987),
('Michal', 'Bureš', 159753456),
('Eva', 'Králová', 951357852);

-- Data pro tabulku Rezervace
INSERT INTO Rezervace (zakaznik_id, auto_id, datum_od, datum_do, stav)
VALUES
(1, 1, '2025-01-01', '2025-01-07', 'rezervováno'),
(2, 2, '2025-01-03', '2025-01-10', 'vráceno'),
(3, 3, '2025-01-05', '2025-01-12', 'zrušeno'),
(4, 4, '2025-01-10', '2025-01-15', 'rezervováno'),
(5, 5, '2025-01-15', '2025-01-20', 'vráceno'),
(6, 6, '2025-01-18', '2025-01-25', 'zrušeno'),
(2, 1, '2025-01-05', '2025-01-08', 'rezervováno'), -- Překrývající rezervace
(7, 7, '2025-01-20', '2025-01-30', 'rezervováno');

-- Data pro tabulku Kategorie
INSERT INTO Kategorie (id, nazev, popis)
VALUES
(1, 'Malá auta', 'Kompaktní vozidla vhodná do města.'),
(2, 'SUV', 'Sportovně užitková vozidla.'),
(3, 'Luxusní auta', 'Vysoce komfortní a výkonná auta.'),
(4, 'Dodávky', 'Vozidla pro přepravu nákladu.'),
(5, 'Elektromobily', 'Vozidla poháněná elektrickou energií.');

-- Data pro tabulku Pojisteni
INSERT INTO Pojisteni (id, auto_id, typ_pojisteni, platnost_od, platnost_do, cena)
VALUES
(1, 1, 'povinné ručení', '2025-01-01', '2026-01-01', 5000.00),
(2, 2, 'havarijní', '2025-01-01', '2026-01-01', 8000.00),
(3, 3, 'kombinované', '2025-01-01', '2026-01-01', 12000.00),
(4, 4, 'povinné ručení', '2025-01-01', '2026-01-01', 4500.00),
(5, 5, 'havarijní', '2025-01-01', '2026-01-01', 7000.00),
(6, 6, 'kombinované', '2025-01-01', '2026-01-01', 10000.00),
(7, 7, 'kombinované', '2024-12-01', '2025-12-01', 9500.00); -- Různá platnost pojištění

-- Data pro tabulku Zamestnanci
INSERT INTO Zamestnanci (id, jmeno, prijmeni, pozice, telefonni_cislo, email)
VALUES
(1, 'Karel', 'Novotný', 'Technik', '123456789', 'karel.novotny@email.cz'),
(2, 'Pavel', 'Horák', 'Operátor', '987654321', 'pavel.horak@email.cz'),
(3, 'Jana', 'Malá', 'Manažer', '456789123', 'jana.mala@email.cz'),
(4, 'Eva', 'Nová', 'Administrátor', '654321987', 'eva.nova@email.cz'),
(5, 'Michal', 'Kučera', 'Řidič', '741852963', 'michal.kucera@email.cz');

-- Data pro tabulku Jizdy
INSERT INTO Jizdy (id, auto_id, zakaznik_id, zamestnanec_id, datum_zapujceni, datum_vraceni, stav_pri_vraceni, cena_celkem)
VALUES
(1, 1, 1, 1, '2025-01-01', '2025-01-07', 'Bez poškození', 3500.00),
(2, 2, 2, 2, '2025-01-03', '2025-01-10', 'Mírné poškození nárazníku', 4500.00),
(3, 3, 3, 3, '2025-01-05', '2025-01-12', 'Bez poškození', 4000.00),
(4, 4, 4, 4, '2025-02-01', '2025-02-08', 'Poškozená kapota', 5000.00);

-- Data pro tabulku Ceniky
INSERT INTO Ceniky (id, kategorie_id, auto_id, cena_za_den)
VALUES
(1, 1, 1, 500.00),
(2, 2, 2, 1000.00),
(3, 3, 3, 1500.00),
(4, 4, 4, 700.00),
(5, 5, 5, 1200.00),
(6, 3, 6, 2000.00), -- Oprava kategorie pro BMW X5
(7, 5, 8, 2500.00); -- Tesla Model 3 zařazená jako elektromobil

-- Data pro tabulku Pokuty
INSERT INTO Pokuty (id, jizda_id, popis, castka, datum)
VALUES
(1, 1, 'Překročení rychlosti', 1000.00, '2025-01-08'),
(2, 2, 'Špatné parkování', 500.00, '2025-01-11'),
(3, 3, 'Jízda bez dálniční známky', 2000.00, '2025-01-13'),
(4, 4, 'Nepřipoutaný řidič', 1500.00, '2025-02-09'),
(5, 4, 'Nezaplacené parkování', 800.00, '2025-02-10');
