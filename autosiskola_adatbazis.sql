-- Adatbázis létrehozása (ha még nem létezik)
CREATE DATABASE IF NOT EXISTS autosiskola;
USE autosiskola;

-- Táblák létrehozása
DROP TABLE IF EXISTS TANULÓ_TANFOLYAM;
DROP TABLE IF EXISTS VIZSGA;
DROP TABLE IF EXISTS ÓRA;
DROP TABLE IF EXISTS TANFOLYAM;
DROP TABLE IF EXISTS JÁRMŰ;
DROP TABLE IF EXISTS OKTATÓ;
DROP TABLE IF EXISTS TANULÓ;

CREATE TABLE TANULÓ (
    tanulo_id INT PRIMARY KEY AUTO_INCREMENT,
    nev VARCHAR(100) NOT NULL,
    cim VARCHAR(255),
    telefonszam VARCHAR(20),
    szuletesi_datum DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE OKTATÓ (
    oktato_id INT PRIMARY KEY AUTO_INCREMENT,
    nev VARCHAR(100) NOT NULL,
    telefonszam VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    alkalmazas_datum DATE
);

CREATE TABLE JÁRMŰ (
    rendszam VARCHAR(10) PRIMARY KEY,
    marka VARCHAR(50) NOT NULL,
    modell VARCHAR(50) NOT NULL,
    gyartasi_ev INT,
    tipus VARCHAR(20)
);

CREATE TABLE TANFOLYAM (
    tanfolyam_id INT PRIMARY KEY AUTO_INCREMENT,
    nev VARCHAR(100) NOT NULL,
    ar DECIMAL(10, 2),
    orak_szama INT
);

CREATE TABLE ÓRA (
    ora_id INT PRIMARY KEY AUTO_INCREMENT,
    tanulo_id INT NOT NULL,
    oktato_id INT NOT NULL,
    rendszam VARCHAR(10) NOT NULL,
    datum DATE NOT NULL,
    kezdes_ido TIME NOT NULL,
    befejezes_ido TIME NOT NULL,
    FOREIGN KEY (tanulo_id) REFERENCES TANULÓ(tanulo_id),
    FOREIGN KEY (oktato_id) REFERENCES OKTATÓ(oktato_id),
    FOREIGN KEY (rendszam) REFERENCES JÁRMŰ(rendszam)
);

CREATE TABLE VIZSGA (
    vizsga_id INT PRIMARY KEY AUTO_INCREMENT,
    tanulo_id INT NOT NULL,
    tipus VARCHAR(50) NOT NULL,
    datum DATE NOT NULL,
    sikeres BOOLEAN,
    FOREIGN KEY (tanulo_id) REFERENCES TANULÓ(tanulo_id)
);

CREATE TABLE TANULÓ_TANFOLYAM (
    tanulo_tanfolyam_id INT PRIMARY KEY AUTO_INCREMENT,
    tanulo_id INT NOT NULL,
    tanfolyam_id INT NOT NULL,
    beiratkozas_datum DATE NOT NULL,
    statusz VARCHAR(20),
    FOREIGN KEY (tanulo_id) REFERENCES TANULÓ(tanulo_id),
    FOREIGN KEY (tanfolyam_id) REFERENCES TANFOLYAM(tanfolyam_id)
);

-- TANULÓ tábla
INSERT INTO TANULÓ (nev, cim, telefonszam, szuletesi_datum, email) VALUES
('Kis János', 'Budapest, Fő utca 1.', '06301234567', '2002-05-10', 'janos.kis@example.com'),
('Nagy Anna', 'Debrecen, Kossuth tér 5.', '06209876543', '2001-11-22', 'anna.nagy@example.com'),
('Szabó Péter', 'Szeged, Petőfi Sándor sugárút 10.', '06705551122', '2003-03-15', 'peter.szabo@example.com'),
('Horváth Eszter', 'Pécs, Jókai utca 8.', '06309998877', '2000-08-01', 'eszter.horvath@example.com'),
('Kovács Bence', 'Győr, Baross Gábor út 2.', '06201112233', '2004-01-28', 'bence.kovacs@example.com');

-- OKTATÓ tábla
INSERT INTO OKTATÓ (nev, telefonszam, email, alkalmazas_datum) VALUES
('Fazekas László', '06304445566', 'laszlo.fazekas@example.com', '2018-09-01'),
('Molnár Katalin', '06207778899', 'katalin.molnar@example.com', '2020-03-15'),
('Tóth Gábor', '06702223344', 'gabor.toth@example.com', '2022-06-20');

-- JÁRMŰ tábla
INSERT INTO JÁRMŰ (rendszam, marka, modell, gyartasi_ev, tipus) VALUES
('ABC-123', 'Suzuki', 'Swift', 2019, 'Manuális'),
('DEF-456', 'Volkswagen', 'Golf', 2021, 'Manuális'),
('GHI-789', 'Toyota', 'Yaris', 2020, 'Automata'),
('JKL-012', 'Opel', 'Astra', 2018, 'Manuális');

-- TANFOLYAM tábla
INSERT INTO TANFOLYAM (nev, ar, orak_szama) VALUES
('B kategória', 180000, 30),
('AM kategória', 50000, 10),
('A1 kategória', 120000, 20);

-- ÓRA tábla
INSERT INTO ÓRA (tanulo_id, oktato_id, rendszam, datum, kezdes_ido, befejezes_ido) VALUES
(1, 1, 'ABC-123', '2025-04-17', '08:00:00', '08:50:00'),
(2, 2, 'DEF-456', '2025-04-17', '09:00:00', '09:50:00'),
(1, 1, 'ABC-123', '2025-04-17', '10:00:00', '10:50:00'),
(3, 3, 'GHI-789', '2025-04-18', '14:00:00', '14:50:00'),
(4, 2, 'DEF-456', '2025-04-18', '16:00:00', '16:50:00'),
(2, 1, 'ABC-123', '2025-04-19', '11:00:00', '11:50:00');

-- VIZSGA tábla
INSERT INTO VIZSGA (tanulo_id, tipus, datum, sikeres) VALUES
(1, 'Elmélet', '2025-05-10', TRUE),
(2, 'Gyakorlat', '2025-05-15', FALSE),
(3, 'Elmélet', '2025-06-01', TRUE),
(1, 'Gyakorlat', '2025-06-05', TRUE),
(4, 'Elmélet', '2025-06-10', FALSE);

-- TANULÓ_TANFOLYAM tábla
INSERT INTO TANULÓ_TANFOLYAM (tanulo_id, tanfolyam_id, beiratkozas_datum, statusz) VALUES
(1, 1, '2025-03-01', 'Folyamatban'),
(2, 1, '2025-03-15', 'Folyamatban'),
(3, 2, '2025-04-01', 'Befejezve'),
(4, 1, '2025-04-05', 'Folyamatban'),
(5, 3, '2025-04-10', 'Folyamatban');
