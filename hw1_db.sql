-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 28, 2022 alle 23:54
-- Versione del server: 10.4.21-MariaDB
-- Versione PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hw1_db`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `hw1_follow`
--

CREATE TABLE `hw1_follow` (
  `followerId` int(11) NOT NULL,
  `followed` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `hw1_follow`
--

INSERT INTO `hw1_follow` (`followerId`, `followed`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `hw1_postlike`
--

CREATE TABLE `hw1_postlike` (
  `userid` int(11) NOT NULL,
  `postid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Trigger `hw1_postlike`
--
DELIMITER $$
CREATE TRIGGER `ADD_LIKE` AFTER INSERT ON `hw1_postlike` FOR EACH ROW UPDATE hw1_posts set likes = likes + 1 WHERE postid = NEW.postid
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `REMOVE_LIKE` AFTER DELETE ON `hw1_postlike` FOR EACH ROW UPDATE hw1_posts SET LIKES = LIKES - 1 where postid = OLD.postid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `hw1_posts`
--

CREATE TABLE `hw1_posts` (
  `postid` int(11) NOT NULL,
  `postTitle` varchar(256) NOT NULL,
  `postUrl` varchar(256) NOT NULL,
  `postUser` int(11) NOT NULL,
  `date` date NOT NULL,
  `url_yt` varchar(256) DEFAULT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `url_an` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `hw1_posts`
--

INSERT INTO `hw1_posts` (`postid`, `postTitle`, `postUrl`, `postUser`, `date`, `url_yt`, `likes`, `url_an`) VALUES
(1, 'Parassita', 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/large/bx30401-siY6wmwnHFi6.png', 1, '2022-05-29', NULL, 0, 'http://anilist.co/manga/30401'),
(2, 'Parassita', 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/large/bx30401-siY6wmwnHFi6.png', 1, '2022-05-29', NULL, 0, 'http://anilist.co/manga/30401'),
(3, '123', 'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx20-E3YH5W6sz6H7.jpg', 1, '2022-05-29', NULL, 0, 'http://anilist.co/anime/20');

-- --------------------------------------------------------

--
-- Struttura della tabella `hw1_users`
--

CREATE TABLE `hw1_users` (
  `id` int(11) NOT NULL,
  `username` varchar(256) NOT NULL,
  `password` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `nome` varchar(256) NOT NULL,
  `cognome` varchar(256) NOT NULL,
  `image` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `hw1_users`
--

INSERT INTO `hw1_users` (`id`, `username`, `password`, `email`, `nome`, `cognome`, `image`) VALUES
(1, 'vince', '3f29e1b2b05f8371595dc761fed8e8b37544b38d56dfce81a551b46c82f2f56b', 'vincentlop98@gmail.com', 'Vincent', 'Loparo', 'http://151.97.9.184/bellia_alessandro/hw1/uploads/vecteezy_beautiful-pink-rose-stems-isolated-on-white-background_.jpg');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `hw1_follow`
--
ALTER TABLE `hw1_follow`
  ADD KEY `followerId` (`followerId`),
  ADD KEY `followed` (`followed`);

--
-- Indici per le tabelle `hw1_postlike`
--
ALTER TABLE `hw1_postlike`
  ADD KEY `hw1_postlike_ibfk_1` (`postid`),
  ADD KEY `userid` (`userid`);

--
-- Indici per le tabelle `hw1_posts`
--
ALTER TABLE `hw1_posts`
  ADD PRIMARY KEY (`postid`),
  ADD KEY `hw1_posts_ibfk_1` (`postUser`);

--
-- Indici per le tabelle `hw1_users`
--
ALTER TABLE `hw1_users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `hw1_posts`
--
ALTER TABLE `hw1_posts`
  MODIFY `postid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `hw1_users`
--
ALTER TABLE `hw1_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `hw1_follow`
--
ALTER TABLE `hw1_follow`
  ADD CONSTRAINT `hw1_follow_ibfk_1` FOREIGN KEY (`followerId`) REFERENCES `hw1_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hw1_follow_ibfk_2` FOREIGN KEY (`followed`) REFERENCES `hw1_users` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `hw1_postlike`
--
ALTER TABLE `hw1_postlike`
  ADD CONSTRAINT `hw1_postlike_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `hw1_posts` (`postid`) ON DELETE CASCADE,
  ADD CONSTRAINT `hw1_postlike_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `hw1_users` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `hw1_posts`
--
ALTER TABLE `hw1_posts`
  ADD CONSTRAINT `hw1_posts_ibfk_1` FOREIGN KEY (`postUser`) REFERENCES `hw1_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
