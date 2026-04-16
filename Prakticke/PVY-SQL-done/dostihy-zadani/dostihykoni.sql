-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Ned 29. bře 2015, 16:57
-- Verze serveru: 5.6.16
-- Verze PHP: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáze: `dostihykoni`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `dostih`
--

CREATE TABLE IF NOT EXISTS `dostih` (
  `iddostih` int(11) NOT NULL,
  `nazev` varchar(100) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `misto` varchar(45) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `cas_konani` datetime NOT NULL,
  `druh_dostihu` enum('Rovinový dostih','Prekážkový dostih','Klusácký dostih') CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL DEFAULT 'Prekážkový dostih',
  `delka` int(10) unsigned NOT NULL,
  PRIMARY KEY (`iddostih`),
  KEY `misto` (`misto`),
  KEY `nazev` (`nazev`),
  KEY `cas` (`cas_konani`),
  KEY `druh` (`druh_dostihu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Vypisuji data pro tabulku `dostih`
--

INSERT INTO `dostih` (`iddostih`, `nazev`, `misto`, `cas_konani`, `druh_dostihu`, `delka`) VALUES
(1, 'Cena CK MARTIN TOUR', 'Lysá nad Labem', '2013-09-21 16:15:00', 'Rovinový dostih', 1700),
(2, 'Cena prezidenta republiky', 'Praha', '2014-10-26 15:00:00', 'Rovinový dostih', 3200),
(3, 'Cena EŽ PRAHA', 'Praha', '2014-10-26 14:20:00', 'Prekážkový dostih', 3300),
(4, 'Velká cena EXPA NAILS', 'Praha', '2014-10-05 16:05:00', 'Rovinový dostih', 1600),
(5, 'Cena FC PANTER KOLESA', 'Kolesa', '2014-08-16 18:00:00', 'Prekážkový dostih', 3300),
(6, 'Cena společnosti AUTO IN', 'Pardubice', '2012-05-26 13:05:00', 'Prekážkový dostih', 2800);

-- --------------------------------------------------------

--
-- Struktura tabulky `jezdec`
--

CREATE TABLE IF NOT EXISTS `jezdec` (
  `idjezdec` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prijmeni` varchar(20) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `jmeno` varchar(20) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `vaha` decimal(4,1) DEFAULT NULL,
  `pohlavi` enum('muž','žena') CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL DEFAULT 'muž',
  `licence` enum('ANO','NE') CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `kariera` text CHARACTER SET utf8 COLLATE utf8_czech_ci,
  PRIMARY KEY (`idjezdec`),
  KEY `jmeno` (`prijmeni`,`jmeno`),
  KEY `narozeni` (`vaha`),
  KEY `pohlavi` (`pohlavi`),
  KEY `licence` (`licence`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Vypisuji data pro tabulku `jezdec`
--

INSERT INTO `jezdec` (`idjezdec`, `prijmeni`, `jmeno`, `vaha`, `pohlavi`, `licence`, `kariera`) VALUES
(1, 'Pejšková', 'Helena', '54.0', 'žena', 'ANO', 'počet startů: 314, počet vítězství: 31, zisk: 1 534 775 Kč, úspěšnost: 9,87%\r\n'),
(2, 'Murzabayev', 'Bauyrzhan', '54.0', 'muž', 'ANO', 'počet startů: 517, počet vítězství: 72,	\r\nzisk: 4 859 535 Kč, úspěšnost: 13,93%	'),
(3, 'Chaloupka', 'Jiří', '59.0', 'muž', 'ANO', 'počet startů: 3371, počet vítězství: 374, zisk: 34 423 701 Kč, úspěšnost:	11,09%'),
(4, 'Korečková', 'Vendula', '52.5', 'žena', 'ANO', 'počet startů: 1246, počet vítězství: 98, zisk: 7 257 026 Kč, úspěšnost: 7,87%'),
(5, 'Zatloukal', 'Milan', '57.0', 'muž', 'ANO', 'počet startů: 1518, počet vítězství: 172, zisk: 14 825 880 Kč, úspěšnost:	11,33%'),
(6, 'Foret', 'Petr', '57.4', 'muž', 'NE', NULL),
(7, 'Myška', 'Jaroslav', '66.2', 'muž', 'NE', 'počet startů: 5, počet vítězství: 244, zisk: 32 517 550 Kč, úspěšnost:	20,00%'),
(8, 'Kubík', 'Michal', '64.0', 'muž', 'ANO', NULL),
(9, 'Andrés', 'Dušan', '58.0', 'muž', 'NE', 'počet startů: 4451, počet vítězství: 641,\r\nzisk: 59 823 769 Kč, úspěšnost:	14,40%'),
(10, 'Bartoš', 'Josef', '63.0', 'muž', 'ANO', NULL);

-- --------------------------------------------------------

--
-- Struktura tabulky `kun`
--

CREATE TABLE IF NOT EXISTS `kun` (
  `idkun` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jmeno_kone` varchar(45) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `narozeni` date NOT NULL,
  `pohlavi` enum('klisna','valach') CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `staj_zkratka_staje` varchar(3) NOT NULL,
  PRIMARY KEY (`idkun`),
  KEY `fk_kun_staj1_idx` (`staj_zkratka_staje`) USING BTREE,
  KEY `jmeno` (`jmeno_kone`),
  KEY `narozeni` (`narozeni`),
  KEY `pohlavi` (`pohlavi`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Vypisuji data pro tabulku `kun`
--

INSERT INTO `kun` (`idkun`, `jmeno_kone`, `narozeni`, `pohlavi`, `staj_zkratka_staje`) VALUES
(1, 'Daily Hit', '2011-04-05', 'klisna', 'NAU'),
(2, 'Sapsiree', '2010-02-28', 'klisna', 'PER'),
(3, 'Kobi', '2010-04-11', 'klisna', 'GEW'),
(4, 'Feraclos', '2010-03-23', 'valach', 'GEW'),
(5, 'Texalita', '2009-04-29', 'klisna', 'NAU'),
(6, 'Aztek', '2010-02-02', 'valach', 'GEW'),
(7, 'Autor', '2011-03-03', 'valach', 'NAU'),
(8, 'Zeus', '2009-03-03', 'valach', 'PER'),
(9, 'Audiant', '2009-08-23', 'valach', 'NAU'),
(10, 'Torgon', '2010-05-08', 'valach', 'NAU'),
(11, 'Remino', '2009-03-05', 'valach', 'NAU');

-- --------------------------------------------------------

--
-- Struktura tabulky `kun_v_dostihu`
--

CREATE TABLE IF NOT EXISTS `kun_v_dostihu` (
  `kun_idkun` int(10) unsigned NOT NULL,
  `dostih_iddostih` int(11) NOT NULL,
  `jezdec_idjezdec` int(10) unsigned NOT NULL,
  `umisteni` int(10) unsigned DEFAULT NULL,
  `cas` time DEFAULT NULL,
  PRIMARY KEY (`kun_idkun`,`dostih_iddostih`),
  KEY `fk_kun_has_dostih_dostih1_idx` (`dostih_iddostih`),
  KEY `fk_kun_has_dostih_kun1_idx` (`kun_idkun`),
  KEY `fk_kun_has_dostih_jezdec1_idx` (`jezdec_idjezdec`),
  KEY `umisteni` (`umisteni`),
  KEY `cas` (`cas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Vypisuji data pro tabulku `kun_v_dostihu`
--

INSERT INTO `kun_v_dostihu` (`kun_idkun`, `dostih_iddostih`, `jezdec_idjezdec`, `umisteni`, `cas`) VALUES
(1, 4, 1, 1, '00:01:40'),
(2, 2, 1, 3, '00:03:37'),
(2, 4, 2, 2, '00:01:41'),
(3, 1, 4, 1, '00:01:48'),
(3, 4, 3, 3, '00:01:42'),
(4, 1, 5, 2, '00:01:49'),
(4, 2, 3, 2, '00:03:35'),
(5, 1, 2, 3, '00:01:50'),
(6, 2, 6, 1, '00:03:34'),
(8, 3, 8, 1, '00:03:54'),
(8, 5, 8, 1, '00:03:45'),
(8, 6, 9, 1, '00:03:21'),
(9, 3, 7, 4, '00:03:57'),
(9, 5, 7, 3, '00:03:47'),
(9, 6, 3, 4, '00:03:25'),
(10, 3, 9, 3, '00:03:56'),
(10, 6, 8, 2, '00:03:22'),
(11, 3, 10, 2, '00:03:55'),
(11, 5, 10, 2, '00:03:46'),
(11, 6, 5, 3, '00:03:24');

-- --------------------------------------------------------

--
-- Struktura tabulky `staj`
--

CREATE TABLE IF NOT EXISTS `staj` (
  `zkratka_staje` varchar(3) NOT NULL,
  `nazev_staje` varchar(30) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  PRIMARY KEY (`zkratka_staje`),
  KEY `nazev` (`nazev_staje`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Vypisuji data pro tabulku `staj`
--

INSERT INTO `staj` (`zkratka_staje`, `nazev_staje`) VALUES
('GEW', 'Gest.Westerberg'),
('NAU', 'Naughton R.J.'),
('PER', 'Stall Perlen');

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `kun`
--
ALTER TABLE `kun`
  ADD CONSTRAINT `fk_kun_staj1` FOREIGN KEY (`staj_zkratka_staje`) REFERENCES `staj` (`zkratka_staje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Omezení pro tabulku `kun_v_dostihu`
--
ALTER TABLE `kun_v_dostihu`
  ADD CONSTRAINT `fk_kun_has_dostih_dostih1` FOREIGN KEY (`dostih_iddostih`) REFERENCES `dostih` (`iddostih`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_kun_has_dostih_kun1` FOREIGN KEY (`kun_idkun`) REFERENCES `kun` (`idkun`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_kun_has_dostih_jezdec1` FOREIGN KEY (`jezdec_idjezdec`) REFERENCES `jezdec` (`idjezdec`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
