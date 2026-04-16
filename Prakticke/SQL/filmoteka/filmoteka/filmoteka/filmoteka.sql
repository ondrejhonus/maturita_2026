-- phpMyAdmin SQL Dump
-- version 3.2.2.1deb1
-- http://www.phpmyadmin.net
--
-- Počítač: localhost
-- Vygenerováno: Čtvrtek 08. dubna 2010, 13:48
-- Verze MySQL: 5.1.37
-- Verze PHP: 5.2.10-2ubuntu6.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáze: `filmoteka`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `filmy`
--

CREATE TABLE IF NOT EXISTS `filmy` (
  `idfilmy` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazev` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `rok` year(4) DEFAULT NULL,
  `delka` int(3) DEFAULT NULL,
  `obsah` text COLLATE utf8_unicode_ci,
  `plakat` longblob,
  `hodnoceni` smallint(1) DEFAULT '0',
  `format` enum('černobílý','barevný','3D') COLLATE utf8_unicode_ci DEFAULT 'barevný',
  `idzanr` int(11) NOT NULL,
  PRIMARY KEY (`idfilmy`),
  KEY `nazev` (`nazev`),
  KEY `rok` (`rok`),
  KEY `fk_idzanr` (`idzanr`),
  KEY `hodnoceni` (`hodnoceni`),
  KEY `format` (`format`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Vypisuji data pro tabulku `filmy`
--

INSERT INTO `filmy` (`idfilmy`, `nazev`, `rok`, `delka`, `obsah`, `plakat`, `hodnoceni`, `format`, `idzanr`) VALUES
(1, 'Vetřelec', 1979, 112, 'V první části kultovní sci-fi ságy se setkáváme se Sigourney Weaver v roli statečné Ripleyové, která jako jediná z posádky vesmírné lodi Nostromo zůstává naživu v souboji s hrůznou bytostí, jejíž zárodek se dostal na palubu z líhně na neznámé planetě.', NULL, 5, 'barevný', 9),
(2, 'Gladiátor', 2000, 149, 'Římský generál Maximus (Russell Crowe) opět dovedl své legie k vítězství na bitevním poli. Válka je vyhrána a Maximus sní o domově. Nepřeje si nic jiného, než se vrátit k ženě a svému synovi. Umírající vládce Marcus Aurelius (Richard Harris) pro něj nicméně má ještě jeden úkol. Žádá, aby se generál ujal vlády. Commodus (Joaquin Phoenix), dědic trůnu, žárlí na vládcovu přízeň Maximovi a nařizuje Maximovu popravu, včetně jeho rodiny. Maximus sice o vlásek unikne smrti, ale těžce zraněného ho "zachrání" otrokáři. Maximus se tak dostane do gladiátorské školy a v aréně jeho sláva den ode dne roste. Nyní přichází do Říma, aby pomstil vraždu ženy a svého syna, aby zabil nového císaře - Commoda. Poznal, že jediná moc, silnější než vládcova, je vůle lidu. Cesta, která vede k naplnění Maximovy pomsty je stát se největším hrdinou celé říše.', NULL, 4, 'barevný', 5),
(3, 'Americký gangster', 2007, 157, 'Čtyři ikony filmového průmyslu se sešly u kolébky akčního dramatu Americký gangster, který aspiruje na jeden z nejsilnějších zážitků, jež si v roce 2008 odnesete z kina. Oscary ověnčení herci Russell Crowe (Gladiátor, Insider: Muž, který věděl příliš mnoho) a Denzel Washington (Training Day, Hurikán v ringu) se spojili s oscarovým scenáristou Stevem Zaillianem (Schindlerův seznam, Gangy New Yorku) a neméně úspěšným režisérem Ridleym Scottem (Gladiátor, Černý jestřáb sestřelen).', NULL, 5, 'barevný', 1),
(4, 'Schindlerův seznam', 1993, 195, 'Film podle skutečných událostí, které do své knihy sepsal Thomas Keneally natočil slavný režisér židovského původu Steven Spielberg, který za film dostal svého prvního režijního Oscara své kariéry. Splnil tím "povinnost" vůči ostatním židům a sám za tržby filmu nevzal do vlastní kapsy ani dolar.', NULL, 5, 'černobílý', 5),
(5, 'Indiana Jones a Chrám zkázy', 1984, 114, 'Volné pokračování Dobyvatelů ztracené archy, které se však odehrává o rok dřív, roku 1935. Indiana se tentokrát v šanghajském klubu zaplete s čínským gangsterským bossem. Ve hře je zprvu "jen" stará čínská socha a vzácný diamant, záhy však i samotný Jonesův život.', NULL, 4, 'barevný', 3),
(6, 'Postřižiny', 1980, 93, 'Mozaika humorně laděných událostí začíná jedním z malých rituálů, kterými si koření spokojené manželství Francin a Maryška.', NULL, 5, 'barevný', 4),
(7, 'Slavnosti sněženek', 1983, 83, 'Nezapomenutelný spor dvou mysliveckých spolků nad zastřeleným kancem. Povídka je vlastně portrétní miniaturou sousedů, s nimiž Bohumil Hrabal žil uprostřed chatové oblasti v Kersku nedaleko Prahy. Většina literárních postav má svůj reálný a živý předobraz. S neopakovatelným vypravěčským stylem spisovatele a skvělou profesionální technikou režiséra se před vašima očima rozvíjí nostalgická, ale především hluboce lidská freska žánrových příběhů lidí a lidiček žijících v Polabí. ', NULL, 5, 'barevný', 4),
(8, 'Romance pro křídlovku', 1966, 86, 'Byly to pouhé čtyři takty z Herkulových lázní na křídlovku, které přiměly hosta odcházejícího pozdě večer z venkovské hospody, aby si pozorněji prohlédl hráče. Tak se po třiceti letech setkají dva muži, jež před lety spojovala láska k dívce od kolotočů.', NULL, 4, 'černobílý', 2);

-- --------------------------------------------------------

--
-- Struktura tabulky `staty`
--

CREATE TABLE IF NOT EXISTS `staty` (
  `zkratka_statu` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `nazev_statu` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`zkratka_statu`),
  KEY `nazev` (`nazev_statu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vypisuji data pro tabulku `staty`
--

INSERT INTO `staty` (`zkratka_statu`, `nazev_statu`) VALUES
('CZE', 'Česká republika'),
('TCH', 'Československo'),
('ITA', 'Itálie'),
('GER', 'Německo'),
('NZL', 'Nový Zéland'),
('USA', 'Spojené státy americké'),
('GBR', 'Velká Británie');

-- --------------------------------------------------------

--
-- Struktura tabulky `umelci`
--

CREATE TABLE IF NOT EXISTS `umelci` (
  `idumelci` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prijmeni` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `jmeno` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `narozeni` date DEFAULT NULL,
  `zkratka_statu` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idumelci`),
  KEY `fk_umelci_staty` (`zkratka_statu`),
  KEY `jmeno_umelce` (`prijmeni`,`jmeno`),
  KEY `narozeni` (`narozeni`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Vypisuji data pro tabulku `umelci`
--

INSERT INTO `umelci` (`idumelci`, `prijmeni`, `jmeno`, `narozeni`, `zkratka_statu`) VALUES
(2, 'Scott', 'Ridley', '1937-11-30', 'GBR'),
(3, 'Weaver', 'Sigourney', '1949-10-08', 'USA'),
(4, 'Hurt', 'John', '1940-01-22', 'GBR'),
(5, 'Crowe', 'Russell', '1964-04-07', 'NZL'),
(6, 'Zaillian', 'Steve', NULL, 'USA'),
(7, 'Washington', 'Danzel', '1954-12-28', 'USA'),
(8, 'Spielberg', 'Steven', '1946-12-18', 'USA'),
(9, 'Kingsley', 'Ben', '1943-12-31', 'GBR'),
(10, 'Ford', 'Harrison', '1942-07-13', 'USA'),
(11, 'Menzel', 'Jiří', '1938-02-23', 'CZE'),
(12, 'Hrušínský (st.)', 'Rudolf', '1920-10-17', 'CZE'),
(13, 'Hanzlík', 'Jaromír', '1948-02-16', 'CZE'),
(14, 'Vávra', 'Otakar', '1911-02-28', 'CZE');

-- --------------------------------------------------------

--
-- Struktura tabulky `umelci_ve_filmech`
--

CREATE TABLE IF NOT EXISTS `umelci_ve_filmech` (
  `idfilmy` int(10) unsigned NOT NULL,
  `idumelci` int(10) unsigned NOT NULL,
  `role` enum('herec','režisér','kameraman','scénárista','jiná') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'herec',
  PRIMARY KEY (`idfilmy`,`idumelci`),
  KEY `fk_filmy_has_umelci_filmy1` (`idfilmy`),
  KEY `fk_filmy_has_umelci_umelci1` (`idumelci`),
  KEY `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vypisuji data pro tabulku `umelci_ve_filmech`
--

INSERT INTO `umelci_ve_filmech` (`idfilmy`, `idumelci`, `role`) VALUES
(1, 3, 'herec'),
(1, 4, 'herec'),
(2, 5, 'herec'),
(3, 5, 'herec'),
(3, 7, 'herec'),
(4, 9, 'herec'),
(5, 10, 'herec'),
(6, 12, 'herec'),
(6, 13, 'herec'),
(7, 13, 'herec'),
(8, 13, 'herec'),
(1, 2, 'režisér'),
(2, 2, 'režisér'),
(3, 2, 'režisér'),
(4, 8, 'režisér'),
(5, 8, 'režisér'),
(6, 11, 'režisér'),
(7, 11, 'režisér'),
(8, 14, 'režisér'),
(3, 6, 'scénárista'),
(4, 6, 'scénárista');

-- --------------------------------------------------------

--
-- Struktura tabulky `zanry`
--

CREATE TABLE IF NOT EXISTS `zanry` (
  `idzanr` int(11) NOT NULL AUTO_INCREMENT,
  `nazev_zanru` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idzanr`),
  KEY `zanr` (`nazev_zanru`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Vypisuji data pro tabulku `zanry`
--

INSERT INTO `zanry` (`idzanr`, `nazev_zanru`) VALUES
(3, 'fantasy'),
(5, 'historický'),
(8, 'jiný'),
(4, 'komedie'),
(7, 'pohádka'),
(6, 'psychologický'),
(2, 'romantický'),
(9, 'sci-fi'),
(1, 'thriller');

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `filmy`
--
ALTER TABLE `filmy`
  ADD CONSTRAINT `fk_idzanr` FOREIGN KEY (`idzanr`) REFERENCES `zanry` (`idzanr`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Omezení pro tabulku `umelci`
--
ALTER TABLE `umelci`
  ADD CONSTRAINT `fk_umelci_staty` FOREIGN KEY (`zkratka_statu`) REFERENCES `staty` (`zkratka_statu`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Omezení pro tabulku `umelci_ve_filmech`
--
ALTER TABLE `umelci_ve_filmech`
  ADD CONSTRAINT `fk_filmy_has_umelci_filmy1` FOREIGN KEY (`idfilmy`) REFERENCES `filmy` (`idfilmy`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_filmy_has_umelci_umelci1` FOREIGN KEY (`idumelci`) REFERENCES `umelci` (`idumelci`) ON DELETE NO ACTION ON UPDATE NO ACTION;
