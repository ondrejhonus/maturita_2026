-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Stř 11. úno 2026, 22:58
-- Verze serveru: 10.4.32-MariaDB
-- Verze PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `rockalbums`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `alba_delka_pres` (IN `p_minuty` INT)   BEGIN
    SELECT 
        a.album_name,
        SEC_TO_TIME(SUM(TIME_TO_SEC(t.track_length))) AS delka
    FROM albums a
    JOIN tracks t ON a.album_id = t.album_id
    GROUP BY a.album_id
    HAVING SUM(TIME_TO_SEC(t.track_length)) > p_minuty * 60;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pridat_album_s_zanrem` (IN `p_nazev` VARCHAR(255), IN `p_rok` YEAR, IN `p_label` VARCHAR(255), IN `p_rating` DECIMAL(3,2), IN `p_band_id` INT, IN `p_genre_id` INT)   BEGIN
    DECLARE v_album_id INT;

    START TRANSACTION;

    INSERT INTO albums(album_name, release_year, label, rating, cover_image, band_id)
    VALUES (p_nazev, p_rok, p_label, p_rating, '', p_band_id);

    SET v_album_id = LAST_INSERT_ID();

    INSERT INTO albumgenres(album_id, genre_id)
    VALUES (v_album_id, p_genre_id);

    COMMIT;

    SELECT v_album_id AS nove_album;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `statistika_kapely` (IN `p_band_id` INT)   BEGIN
    SELECT 
        b.band_name,
        COUNT(DISTINCT a.album_id) AS pocet_alb,
        COUNT(DISTINCT m.member_id) AS pocet_clenu,
        AVG(a.rating) AS prumerny_rating
    FROM bands b
    LEFT JOIN albums a ON b.band_id = a.band_id
    LEFT JOIN members m ON b.band_id = m.band_id
    WHERE b.band_id = p_band_id
    GROUP BY b.band_id;
END$$

--
-- Funkce
--
CREATE DEFINER=`root`@`localhost` FUNCTION `vek_kapely_pri_vydani` (`p_album_id` INT) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE v_vek INT;

    SELECT a.release_year - b.year_formed
    INTO v_vek
    FROM albums a
    JOIN bands b ON a.band_id = b.band_id
    WHERE a.album_id = p_album_id;

    RETURN v_vek;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabulky `albumgenres`
--

CREATE TABLE `albumgenres` (
  `album_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Vypisuji data pro tabulku `albumgenres`
--

INSERT INTO `albumgenres` (`album_id`, `genre_id`) VALUES
(1, 1),
(1, 8),
(2, 1),
(2, 8),
(3, 1),
(3, 8),
(4, 3),
(4, 9),
(5, 3),
(5, 9),
(6, 3),
(6, 9),
(7, 1),
(7, 8),
(8, 1),
(8, 8),
(9, 1),
(9, 8),
(10, 2),
(11, 2),
(12, 2),
(13, 3),
(14, 3),
(15, 3),
(16, 1),
(16, 6),
(17, 1),
(17, 6),
(18, 2),
(18, 9),
(19, 1),
(20, 6),
(21, 6),
(22, 5),
(22, 7),
(23, 5),
(23, 7),
(24, 5),
(24, 7),
(25, 5),
(25, 7),
(26, 1),
(27, 1),
(28, 1),
(28, 6),
(29, 1),
(29, 6),
(30, 1),
(30, 6),
(31, 1),
(31, 6),
(32, 5),
(33, 5),
(34, 5),
(35, 5),
(36, 4),
(37, 4),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 5),
(43, 5),
(44, 1),
(44, 6),
(45, 1),
(45, 6);

-- --------------------------------------------------------

--
-- Struktura tabulky `albums`
--

CREATE TABLE `albums` (
  `album_id` int(11) NOT NULL,
  `album_name` varchar(255) NOT NULL,
  `release_year` year(4) NOT NULL,
  `label` varchar(255) NOT NULL,
  `rating` decimal(3,2) NOT NULL,
  `cover_image` text NOT NULL,
  `band_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Vypisuji data pro tabulku `albums`
--

INSERT INTO `albums` (`album_id`, `album_name`, `release_year`, `label`, `rating`, `cover_image`, `band_id`) VALUES
(1, 'Led Zeppelin IV', '1971', 'Atlantic Records', 4.90, '', 1),
(2, 'Led Zeppelin II', '1969', 'Atlantic Records', 4.40, '', 1),
(3, 'Physical Graffiti', '1975', 'Swan Song Records', 4.30, '', 1),
(4, 'Abbey Road', '1969', 'Apple Records', 4.80, '', 2),
(5, 'The White Album', '1968', 'Apple Records', 4.60, '', 2),
(6, 'Sgt. Pepper\'s Lonely Hearts Club Band', '1967', 'Parlophone Records', 4.70, '', 2),
(7, 'Sticky Fingers', '1971', 'Rolling Stones Records', 4.60, '', 3),
(8, 'Exile on Main St.', '1972', 'Rolling Stones Records', 4.50, '', 3),
(9, 'Let It Bleed', '1969', 'Decca Records', 4.40, '', 3),
(10, 'The Dark Side of the Moon', '1973', 'Harvest Records', 4.90, '', 4),
(11, 'The Wall', '1979', 'Harvest Records', 4.80, '', 4),
(12, 'Wish You Were Here', '1975', 'Harvest Records', 4.70, '', 4),
(13, 'The Doors', '1967', 'Elektra Records', 4.40, '', 5),
(14, 'Strange Days', '1967', 'Elektra Records', 4.30, '', 5),
(15, 'L.A. Woman', '1971', 'Elektra Records', 4.20, '', 5),
(16, 'Back in Black', '1980', 'Albert Productions', 4.70, '', 6),
(17, 'Highway to Hell', '1979', 'Albert Productions', 4.50, '', 6),
(18, 'A Night at the Opera', '1975', 'EMI Records', 4.90, '', 7),
(19, 'News of the World', '1977', 'EMI Records', 4.60, '', 7),
(20, 'Master of Puppets', '1986', 'Elektra Records', 4.90, '', 8),
(21, 'Metallica (The Black Album)', '1991', 'Elektra Records', 4.70, '', 8),
(22, 'Nevermind', '1991', 'DGC Records', 4.80, '', 9),
(23, 'In Utero', '1993', 'DGC Records', 4.70, '', 9),
(24, 'Ten', '1991', 'Epic Records', 4.70, '', 10),
(25, 'Vs.', '1993', 'Epic Records', 4.50, '', 10),
(26, 'Toys in the Attic', '1975', 'Columbia Records', 4.60, '', 11),
(27, 'Aerosmith', '1973', 'Columbia Records', 4.40, '', 11),
(28, 'Appetite for Destruction', '1987', 'Geffen Records', 4.90, '', 12),
(29, 'Use Your Illusion I', '1991', 'Geffen Records', 4.50, '', 12),
(30, 'Paranoid', '1970', 'Vertigo Records', 4.80, '', 13),
(31, 'Black Sabbath', '1970', 'Vertigo Records', 4.60, '', 13),
(32, 'Californication', '1999', 'Warner Bros. Records', 4.70, '', 14),
(33, 'By the Way', '2002', 'Warner Bros. Records', 4.50, '', 14),
(34, 'OK Computer', '1997', 'Parlophone', 4.90, '', 15),
(35, 'Kid A', '2000', 'Parlophone', 4.80, '', 15),
(36, 'London Calling', '1979', 'CBS', 4.90, '', 16),
(37, 'The Clash', '1977', 'CBS', 4.70, '', 16),
(38, 'My Generation', '1965', 'Brunswick Records', 4.60, '', 17),
(39, 'Who\'s Next', '1971', 'Track Records', 4.80, '', 17),
(40, 'Hotel California', '1976', 'Asylum Records', 4.80, '', 18),
(41, 'Desperado', '1973', 'Asylum Records', 4.50, '', 18),
(42, 'Murmur', '1983', 'I.R.S. Records', 4.70, '', 19),
(43, 'Automatic for the People', '1992', 'Warner Bros. Records', 4.90, '', 19),
(44, 'Machine Head', '1972', 'Purple Records', 4.70, '', 20),
(45, 'Deep Purple In Rock', '1970', 'Harvest Records', 4.60, '', 20);

--
-- Triggery `albums`
--
DELIMITER $$
CREATE TRIGGER `kontrola_ratingu` BEFORE UPDATE ON `albums` FOR EACH ROW BEGIN
    IF NEW.rating < 0 OR NEW.rating > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating musí být mezi 0 a 5';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `kontrola_roku_alba` BEFORE INSERT ON `albums` FOR EACH ROW BEGIN
    DECLARE v_rok_vzniku YEAR;

    SELECT year_formed
    INTO v_rok_vzniku
    FROM bands
    WHERE band_id = NEW.band_id;

    IF NEW.release_year < v_rok_vzniku THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Album nemůže být vydáno před vznikem kapely';
    END IF;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `log_zmeny_ratingu` AFTER UPDATE ON `albums` FOR EACH ROW BEGIN
    IF OLD.rating <> NEW.rating THEN
        INSERT INTO album_audit(album_id, old_rating, new_rating)
        VALUES (OLD.album_id, OLD.rating, NEW.rating);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabulky `album_audit`
--

CREATE TABLE `album_audit` (
  `audit_id` int(11) NOT NULL,
  `album_id` int(11) DEFAULT NULL,
  `old_rating` decimal(3,2) DEFAULT NULL,
  `new_rating` decimal(3,2) DEFAULT NULL,
  `changed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `bands`
--

CREATE TABLE `bands` (
  `band_id` int(11) NOT NULL,
  `band_name` varchar(255) NOT NULL,
  `year_formed` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Vypisuji data pro tabulku `bands`
--

INSERT INTO `bands` (`band_id`, `band_name`, `year_formed`) VALUES
(1, 'Led Zeppelin', '1968'),
(2, 'The Beatles', '1960'),
(3, 'The Rolling Stones', '1962'),
(4, 'Pink Floyd', '1965'),
(5, 'The Doors', '1965'),
(6, 'AC/DC', '1973'),
(7, 'Queen', '1970'),
(8, 'Metallica', '1981'),
(9, 'Nirvana', '1987'),
(10, 'Pearl Jam', '1990'),
(11, 'Aerosmith', '1970'),
(12, 'Guns N’ Roses', '1985'),
(13, 'Black Sabbath', '1968'),
(14, 'Red Hot Chili Peppers', '1983'),
(15, 'Radiohead', '1985'),
(16, 'The Clash', '1976'),
(17, 'The Who', '1964'),
(18, 'The Eagles', '1971'),
(19, 'R.E.M.', '1980'),
(20, 'Deep Purple', '1968');

-- --------------------------------------------------------

--
-- Struktura tabulky `genres`
--

CREATE TABLE `genres` (
  `genre_id` int(11) NOT NULL,
  `genre_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Vypisuji data pro tabulku `genres`
--

INSERT INTO `genres` (`genre_id`, `genre_name`) VALUES
(1, 'Hard Rock'),
(2, 'Progressive Rock'),
(3, 'Psychedelic Rock'),
(4, 'Punk Rock'),
(5, 'Alternative Rock'),
(6, 'Heavy Metal'),
(7, 'Grunge'),
(8, 'Blues Rock'),
(9, 'Art Rock');

-- --------------------------------------------------------

--
-- Struktura tabulky `members`
--

CREATE TABLE `members` (
  `member_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `birth_date` date NOT NULL,
  `death_date` date DEFAULT NULL,
  `band_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Vypisuji data pro tabulku `members`
--

INSERT INTO `members` (`member_id`, `first_name`, `last_name`, `birth_date`, `death_date`, `band_id`) VALUES
(1, 'Robert', 'Plant', '1948-08-20', NULL, 1),
(2, 'Jimmy', 'Page', '1944-01-09', NULL, 1),
(3, 'John', 'Paul Jones', '1946-01-03', NULL, 1),
(4, 'John', 'Bonham', '1948-05-31', '1980-09-25', 1),
(5, 'John', 'Lennon', '1940-10-09', '1980-12-08', 2),
(6, 'Paul', 'McCartney', '1942-06-18', NULL, 2),
(7, 'George', 'Harrison', '1943-02-25', '2001-11-29', 2),
(8, 'Ringo', 'Starr', '1940-07-07', NULL, 2),
(9, 'Mick', 'Jagger', '1943-07-26', NULL, 3),
(10, 'Keith', 'Richards', '1943-12-18', NULL, 3),
(11, 'Charlie', 'Watts', '1941-06-02', '2021-08-24', 3),
(12, 'Roger', 'Waters', '1943-09-06', NULL, 4),
(13, 'David', 'Gilmour', '1946-03-06', NULL, 4),
(14, 'Richard', 'Wright', '1943-07-28', '2008-09-15', 4),
(15, 'Nick', 'Mason', '1944-01-27', NULL, 4),
(16, 'Jim', 'Morrison', '1943-12-08', '1971-07-03', 5),
(17, 'Ray', 'Manzarek', '1939-02-12', '2013-05-20', 5),
(18, 'Robby', 'Krieger', '1946-01-08', NULL, 5),
(19, 'John', 'Densmore', '1944-12-01', NULL, 5),
(20, 'Roger', 'Daltrey', '1944-03-01', NULL, 17),
(21, 'Pete', 'Townshend', '1945-05-19', NULL, 17),
(22, 'John', 'Entwistle', '1944-10-09', '2002-06-27', 17),
(23, 'Keith', 'Moon', '1946-08-23', '1978-09-07', 17),
(24, 'Freddy', 'Mercury', '1946-09-05', '1991-11-24', 7),
(25, 'Brian', 'May', '1947-07-19', NULL, 7),
(26, 'Roger', 'Taylor', '1949-07-26', NULL, 7),
(27, 'John', 'Deacon', '1951-08-19', NULL, 7),
(28, 'Kurt', 'Cobain', '1967-02-20', '1994-04-05', 9),
(29, 'Dave', 'Grohl', '1969-01-14', NULL, 9),
(30, 'Krist', 'Novoselic', '1965-05-16', NULL, 9),
(31, 'Eddie', 'Vedder', '1964-12-23', NULL, 10),
(32, 'Mike', 'McCready', '1966-04-05', NULL, 10),
(33, 'Stone', 'Gossard', '1966-07-20', NULL, 10),
(34, 'Jeff', 'Ament', '1963-03-10', NULL, 10),
(35, 'Matt', 'Cameron', '1962-11-28', NULL, 10),
(36, 'Anthony', 'Kiedis', '1962-11-01', NULL, 14),
(37, 'Flea', 'Balzary', '1962-10-16', NULL, 14),
(38, 'John', 'Frusciante', '1970-03-05', NULL, 14),
(39, 'Chad', 'Smith', '1961-10-25', NULL, 14),
(40, 'Steven', 'Tyler', '1948-03-26', NULL, 11),
(41, 'Joe', 'Perry', '1950-09-10', NULL, 11),
(42, 'Tom', 'Hamilton', '1951-12-31', NULL, 11),
(43, 'Brad', 'Whitford', '1952-02-23', NULL, 11),
(44, 'Joey', 'Kramer', '1950-06-21', NULL, 11),
(45, 'Axl', 'Rose', '1962-02-06', NULL, 12),
(46, 'Slash', 'Hudson', '1965-07-23', NULL, 12),
(47, 'Duff', 'McKagan', '1964-02-05', NULL, 12),
(48, 'Dizzy', 'Reed', '1963-06-18', NULL, 12),
(49, 'Richard', 'Fortus', '1966-11-17', NULL, 12),
(50, 'Frank', 'Ferrer', '1966-03-25', NULL, 12),
(51, 'Thom', 'Yorke', '1968-10-07', NULL, 15),
(52, 'Jonny', 'Greenwood', '1971-11-05', NULL, 15),
(53, 'Colin', 'Greenwood', '1969-06-26', NULL, 15),
(54, 'Ed', 'O\'Brien', '1968-04-15', NULL, 15),
(55, 'Philip', 'Selway', '1967-05-23', NULL, 15),
(56, 'Ozzy', 'Osbourne', '1948-12-03', NULL, 13),
(57, 'Tony', 'Iommi', '1948-02-19', NULL, 13),
(58, 'Geezer', 'Butler', '1949-07-17', NULL, 13),
(59, 'Bill', 'Ward', '1948-05-05', NULL, 13),
(60, 'Anthony', 'Kiedis', '1962-11-01', NULL, 14),
(61, 'Flea', 'Balzary', '1962-10-16', NULL, 14),
(62, 'Chad', 'Smith', '1961-10-25', NULL, 14),
(63, 'John', 'Frusciante', '1970-03-05', NULL, 14),
(64, 'Joe', 'Strummer', '1952-08-21', NULL, 16),
(65, 'Mick', 'Jones', '1955-06-26', NULL, 16),
(66, 'Paul', 'Simonon', '1955-12-15', NULL, 16),
(67, 'Topper', 'Headon', '1955-05-30', NULL, 16),
(68, 'Don', 'Henley', '1947-07-22', NULL, 18),
(69, 'Glenn', 'Frey', '1948-11-06', '2016-01-18', 18),
(70, 'Joe', 'Walsh', '1947-11-20', NULL, 18),
(71, 'Timothy', 'Schmit', '1947-10-30', NULL, 18),
(72, 'Michael', 'Stipe', '1960-01-04', NULL, 19),
(73, 'Peter', 'Buck', '1956-12-06', NULL, 19),
(74, 'Mike', 'Mills', '1958-12-17', NULL, 19),
(75, 'Bill', 'Berry', '1958-07-31', NULL, 19),
(76, 'Ian', 'Gillan', '1945-08-19', NULL, 20),
(77, 'Roger', 'Glover', '1945-11-30', NULL, 20),
(78, 'Jon', 'Lord', '1941-06-09', '2012-07-16', 20),
(79, 'Ian', 'Paice', '1948-06-29', NULL, 20),
(80, 'Ritchie', 'Blackmore', '1945-04-14', NULL, 20);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `pocet_clenu_skupin`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `pocet_clenu_skupin` (
`skupina` varchar(255)
,`pocet_clenu` bigint(21)
);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `pocty_alb_skupin`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `pocty_alb_skupin` (
`skupina` varchar(255)
,`zalozeni` year(4)
,`pocet_alb` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabulky `tracks`
--

CREATE TABLE `tracks` (
  `track_id` int(11) NOT NULL,
  `track_name` varchar(255) NOT NULL,
  `track_length` time NOT NULL,
  `album_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Vypisuji data pro tabulku `tracks`
--

INSERT INTO `tracks` (`track_id`, `track_name`, `track_length`, `album_id`) VALUES
(1, 'Black Dog', '00:04:54', 1),
(2, 'Rock and Roll', '00:03:40', 1),
(3, 'The Battle of Evermore', '00:05:51', 1),
(4, 'Stairway to Heaven', '00:08:02', 1),
(5, 'Misty Mountain Hop', '00:04:38', 1),
(6, 'Four Sticks', '00:04:44', 1),
(7, 'Going to California', '00:03:31', 1),
(8, 'When the Levee Breaks', '00:07:07', 1),
(9, 'Whole Lotta Love', '00:05:34', 2),
(10, 'What Is and What Should Never Be', '00:04:46', 2),
(11, 'The Lemon Song', '00:06:19', 2),
(12, 'Thank You', '00:04:49', 2),
(13, 'Heartbreaker', '00:04:14', 2),
(14, 'Living Loving Maid (She\'s Just a Woman)', '00:02:39', 2),
(15, 'Ramble On', '00:04:34', 2),
(16, 'Moby Dick', '00:04:20', 2),
(17, 'Bring It On Home', '00:04:20', 2),
(18, 'Custard Pie', '00:04:13', 3),
(19, 'The Rover', '00:05:37', 3),
(20, 'In My Time of Dying', '00:11:04', 3),
(21, 'Houses of the Holy', '00:04:01', 3),
(22, 'Trampled Under Foot', '00:05:35', 3),
(23, 'Kashmir', '00:08:37', 3),
(24, 'In the Light', '00:08:44', 3),
(25, 'Bron-Yr-Aur', '00:02:06', 3),
(26, 'Down by the Seaside', '00:05:14', 3),
(27, 'Ten Years Gone', '00:06:31', 3),
(28, 'Night Flight', '00:03:36', 3),
(29, 'The Wanton Song', '00:04:06', 3),
(30, 'Boogie with Stu', '00:03:51', 3),
(31, 'Black Country Woman', '00:04:24', 3),
(32, 'Sick Again', '00:04:42', 3),
(33, 'Come Together', '00:04:20', 4),
(34, 'Something', '00:03:03', 4),
(35, 'Maxwell\'s Silver Hammer', '00:03:27', 4),
(36, 'Oh! Darling', '00:03:26', 4),
(37, 'Octopus\'s Garden', '00:02:51', 4),
(38, 'I Want You (She\'s So Heavy)', '00:07:47', 4),
(39, 'Here Comes the Sun', '00:03:05', 4),
(40, 'Because', '00:02:45', 4),
(41, 'You Never Give Me Your Money', '00:04:02', 4),
(42, 'Sun King', '00:02:26', 4),
(43, 'Mean Mr. Mustard', '00:01:06', 4),
(44, 'Polythene Pam', '00:01:12', 4),
(45, 'She Came In Through the Bathroom Window', '00:01:57', 4),
(46, 'Golden Slumbers', '00:01:31', 4),
(47, 'Carry That Weight', '00:01:36', 4),
(48, 'The End', '00:02:19', 4),
(49, 'Her Majesty', '00:00:23', 4),
(50, 'Back in the U.S.S.R.', '00:02:43', 5),
(51, 'Dear Prudence', '00:03:56', 5),
(52, 'Glass Onion', '00:02:17', 5),
(53, 'Ob-La-Di, Ob-La-Da', '00:03:08', 5),
(54, 'Wild Honey Pie', '00:00:52', 5),
(55, 'The Continuing Story of Bungalow Bill', '00:03:14', 5),
(56, 'While My Guitar Gently Weeps', '00:04:45', 5),
(57, 'Happiness Is a Warm Gun', '00:02:43', 5),
(58, 'Martha My Dear', '00:02:28', 5),
(59, 'I\'m So Tired', '00:02:03', 5),
(60, 'Blackbird', '00:02:18', 5),
(61, 'Piggies', '00:02:04', 5),
(62, 'Rocky Raccoon', '00:03:33', 5),
(63, 'Don\'t Pass Me By', '00:03:50', 5),
(64, 'Why Don\'t We Do It in the Road?', '00:01:41', 5),
(65, 'I Will', '00:01:46', 5),
(66, 'Julia', '00:02:54', 5),
(67, 'Birthday', '00:02:42', 5),
(68, 'Yer Blues', '00:04:01', 5),
(69, 'Mother Nature\'s Son', '00:02:48', 5),
(70, 'Everybody\'s Got Something to Hide Except Me and My Monkey', '00:02:24', 5),
(71, 'Sexy Sadie', '00:03:15', 5),
(72, 'Helter Skelter', '00:04:29', 5),
(73, 'Long, Long, Long', '00:03:04', 5),
(74, 'Revolution 1', '00:04:15', 5),
(75, 'Honey Pie', '00:02:41', 5),
(76, 'Savoy Truffle', '00:02:54', 5),
(77, 'Cry Baby Cry', '00:03:02', 5),
(78, 'Revolution 9', '00:08:22', 5),
(79, 'Good Night', '00:03:11', 5),
(80, 'Sgt. Pepper\'s Lonely Hearts Club Band', '00:02:02', 6),
(81, 'With a Little Help from My Friends', '00:02:44', 6),
(82, 'Lucy in the Sky with Diamonds', '00:03:28', 6),
(83, 'Getting Better', '00:02:48', 6),
(84, 'Fixing a Hole', '00:02:36', 6),
(85, 'She\'s Leaving Home', '00:03:35', 6),
(86, 'Being for the Benefit of Mr. Kite!', '00:02:37', 6),
(87, 'Within You Without You', '00:05:04', 6),
(88, 'When I\'m Sixty-Four', '00:02:37', 6),
(89, 'Lovely Rita', '00:02:42', 6),
(90, 'Good Morning Good Morning', '00:02:41', 6),
(91, 'Sgt. Pepper\'s Lonely Hearts Club Band (Reprise)', '00:01:18', 6),
(92, 'A Day in the Life', '00:05:33', 6),
(93, 'Brown Sugar', '00:03:49', 7),
(94, 'Sway', '00:03:51', 7),
(95, 'Wild Horses', '00:05:42', 7),
(96, 'Can\'t You Hear Me Knocking', '00:07:15', 7),
(97, 'You Gotta Move', '00:02:32', 7),
(98, 'Bitch', '00:03:36', 7),
(99, 'I Got the Blues', '00:03:54', 7),
(100, 'Sister Morphine', '00:05:31', 7),
(101, 'Dead Flowers', '00:04:03', 7),
(102, 'Moonlight Mile', '00:05:56', 7),
(103, 'Rocks Off', '00:04:31', 8),
(104, 'Rip This Joint', '00:02:22', 8),
(105, 'Shake Your Hips', '00:02:59', 8),
(106, 'Casino Boogie', '00:03:33', 8),
(107, 'Tumbling Dice', '00:03:45', 8),
(108, 'Gimme Shelter', '00:04:30', 9),
(109, 'Love in Vain', '00:04:19', 9),
(110, 'Country Honk', '00:03:09', 9),
(111, 'Live with Me', '00:03:33', 9),
(112, 'Let It Bleed', '00:05:27', 9),
(113, 'Speak to Me', '00:01:30', 10),
(114, 'Breathe', '00:02:43', 10),
(115, 'On the Run', '00:03:30', 10),
(116, 'Time', '00:06:53', 10),
(117, 'The Great Gig in the Sky', '00:04:15', 10),
(118, 'In the Flesh?', '00:03:16', 11),
(119, 'The Thin Ice', '00:02:27', 11),
(120, 'Another Brick in the Wall, Part 1', '00:03:21', 11),
(121, 'The Happiest Days of Our Lives', '00:01:46', 11),
(122, 'Another Brick in the Wall, Part 2', '00:03:59', 11),
(123, 'Shine On You Crazy Diamond (Parts I–V)', '00:13:32', 12),
(124, 'Welcome to the Machine', '00:07:31', 12),
(125, 'Have a Cigar', '00:05:08', 12),
(126, 'Wish You Were Here', '00:05:34', 12),
(127, 'Shine On You Crazy Diamond (Parts VI–IX)', '00:12:29', 12),
(128, 'Break On Through (To the Other Side)', '00:02:29', 13),
(129, 'Soul Kitchen', '00:03:35', 13),
(130, 'The Crystal Ship', '00:02:34', 13),
(131, 'Twentieth Century Fox', '00:02:33', 13),
(132, 'Alabama Song (Whisky Bar)', '00:03:20', 13),
(133, 'Strange Days', '00:03:11', 14),
(134, 'You\'re Lost Little Girl', '00:03:03', 14),
(135, 'Love Me Two Times', '00:03:18', 14),
(136, 'Unhappy Girl', '00:02:02', 14),
(137, 'Horse Latitudes', '00:01:37', 14),
(138, 'The Changeling', '00:04:21', 15),
(139, 'Love Her Madly', '00:03:39', 15),
(140, 'Been Down So Long', '00:04:41', 15),
(141, 'Cars Hiss By My Window', '00:04:12', 15),
(142, 'L.A. Woman', '00:07:49', 15),
(143, 'Hells Bells', '00:05:12', 16),
(144, 'Shoot to Thrill', '00:05:17', 16),
(145, 'What Do You Do for Money Honey', '00:03:35', 16),
(146, 'Given the Dog a Bone', '00:03:31', 16),
(147, 'Let Me Put My Love Into You', '00:04:15', 16),
(148, 'Highway to Hell', '00:03:28', 17),
(149, 'Girls Got Rhythm', '00:03:23', 17),
(150, 'Walk All Over You', '00:05:09', 17),
(151, 'Touch Too Much', '00:04:26', 17),
(152, 'Beating Around the Bush', '00:03:56', 17),
(153, 'Death on Two Legs (Dedicated to...)', '00:03:43', 18),
(154, 'Lazing on a Sunday Afternoon', '00:01:07', 18),
(155, 'I\'m in Love with My Car', '00:03:05', 18),
(156, 'You\'re My Best Friend', '00:02:52', 18),
(157, 'We Will Rock You', '00:02:02', 19),
(158, 'We Are the Champions', '00:03:00', 19),
(159, 'Sheer Heart Attack', '00:03:27', 19),
(160, 'All Dead, All Dead', '00:03:10', 19),
(161, 'Spread Your Wings', '00:04:34', 19),
(162, 'Battery', '00:05:12', 20),
(163, 'Master of Puppets', '00:08:35', 20),
(164, 'The Thing That Should Not Be', '00:06:36', 20),
(165, 'Welcome Home (Sanitarium)', '00:06:27', 20),
(166, 'Disposable Heroes', '00:08:16', 20),
(167, 'Enter Sandman', '00:05:32', 21),
(168, 'Sad But True', '00:05:25', 21),
(169, 'Smells Like Teen Spirit', '00:05:02', 22),
(170, 'In Bloom', '00:04:15', 22),
(171, 'Serve the Servants', '00:03:37', 23),
(172, 'Scentless Apprentice', '00:03:48', 23),
(173, 'Once', '00:03:52', 24),
(174, 'Even Flow', '00:04:54', 24),
(175, 'Go', '00:03:13', 25),
(176, 'Animal', '00:02:49', 25),
(177, 'Toys in the Attic', '00:03:07', 26),
(178, 'Uncle Salty', '00:04:09', 26),
(179, 'Make It', '00:03:41', 27),
(180, 'Somebody', '00:03:46', 27),
(181, 'Welcome to the Jungle', '00:04:34', 28),
(182, 'It\'s So Easy', '00:03:23', 28),
(183, 'Live and Let Die', '00:03:04', 29),
(184, 'War Pigs/Luke\'s Wall', '00:07:57', 30),
(185, 'Paranoid', '00:02:48', 30),
(186, 'Black Sabbath', '00:06:20', 31),
(187, 'The Wizard', '00:04:24', 31),
(188, 'Around the World', '00:03:58', 32),
(189, 'Parallel Universe', '00:04:31', 32),
(190, 'By the Way', '00:03:37', 33),
(191, 'Universally Speaking', '00:04:19', 33),
(192, 'Airbag', '00:04:44', 34),
(193, 'Paranoid Android', '00:06:23', 34),
(194, 'Everything in Its Right Place', '00:04:11', 35),
(195, 'Kid A', '00:04:44', 35),
(196, 'London Calling', '00:03:19', 36),
(197, 'Brand New Cadillac', '00:02:09', 36),
(198, 'Janie Jones', '00:02:08', 37),
(199, 'Remote Control', '00:03:03', 37),
(200, 'Out in the Street', '00:02:31', 38),
(201, 'The Good\'s Gone', '00:04:02', 38),
(202, 'Baba O\'Riley', '00:05:08', 39),
(203, 'Bargain', '00:05:34', 39),
(204, 'Hotel California', '00:06:31', 40),
(205, 'New Kid in Town', '00:05:04', 40),
(206, 'Doolin-Dalton', '00:03:27', 41),
(207, 'Twenty-One', '00:02:11', 41),
(208, 'Radio Free Europe', '00:04:05', 42),
(209, 'Talk About the Passion', '00:03:23', 42),
(210, 'Drive', '00:04:31', 43),
(211, 'Try Not to Breathe', '00:03:50', 43),
(212, 'Highway Star', '00:06:08', 44),
(213, 'Maybe I\'m a Leo', '00:04:51', 44),
(214, 'Speed King', '00:05:52', 45),
(215, 'Bloodsucker', '00:04:10', 45);

-- --------------------------------------------------------

--
-- Struktura pro pohled `pocet_clenu_skupin`
--
DROP TABLE IF EXISTS `pocet_clenu_skupin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pocet_clenu_skupin`  AS SELECT `b`.`band_name` AS `skupina`, count(`m`.`member_id`) AS `pocet_clenu` FROM (`members` `m` join `bands` `b` on(`b`.`band_id` = `m`.`band_id`)) GROUP BY `b`.`band_id` ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `pocty_alb_skupin`
--
DROP TABLE IF EXISTS `pocty_alb_skupin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pocty_alb_skupin`  AS SELECT `b`.`band_name` AS `skupina`, `b`.`year_formed` AS `zalozeni`, count(0) AS `pocet_alb` FROM (`bands` `b` join `albums` `a` on(`b`.`band_id` = `a`.`band_id`)) GROUP BY `b`.`band_id` ;

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `albumgenres`
--
ALTER TABLE `albumgenres`
  ADD PRIMARY KEY (`album_id`,`genre_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- Indexy pro tabulku `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`album_id`),
  ADD KEY `band_id` (`band_id`),
  ADD KEY `ix_release_year` (`release_year`),
  ADD KEY `ix_album_name` (`album_name`(10));

--
-- Indexy pro tabulku `album_audit`
--
ALTER TABLE `album_audit`
  ADD PRIMARY KEY (`audit_id`);

--
-- Indexy pro tabulku `bands`
--
ALTER TABLE `bands`
  ADD PRIMARY KEY (`band_id`),
  ADD KEY `ix_band_name` (`band_name`(10));

--
-- Indexy pro tabulku `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`genre_id`),
  ADD KEY `ix_genre_name` (`genre_name`(10));

--
-- Indexy pro tabulku `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`),
  ADD KEY `band_id` (`band_id`),
  ADD KEY `ix_first_name` (`first_name`(10)),
  ADD KEY `ix_last_name` (`last_name`(10));

--
-- Indexy pro tabulku `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`track_id`),
  ADD KEY `album_id` (`album_id`),
  ADD KEY `ix_track_name` (`track_name`(10));

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `albums`
--
ALTER TABLE `albums`
  MODIFY `album_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT pro tabulku `album_audit`
--
ALTER TABLE `album_audit`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `bands`
--
ALTER TABLE `bands`
  MODIFY `band_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pro tabulku `genres`
--
ALTER TABLE `genres`
  MODIFY `genre_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pro tabulku `members`
--
ALTER TABLE `members`
  MODIFY `member_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT pro tabulku `tracks`
--
ALTER TABLE `tracks`
  MODIFY `track_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `albumgenres`
--
ALTER TABLE `albumgenres`
  ADD CONSTRAINT `albumgenres_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`),
  ADD CONSTRAINT `albumgenres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`);

--
-- Omezení pro tabulku `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_ibfk_1` FOREIGN KEY (`band_id`) REFERENCES `bands` (`band_id`);

--
-- Omezení pro tabulku `tracks`
--
ALTER TABLE `tracks`
  ADD CONSTRAINT `tracks_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
