DROP TABLE IF EXISTS `joueurs_bans`;
CREATE TABLE IF NOT EXISTS `joueurs_bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `nom` varchar(255) NOT NULL DEFAULT 'Citizen',
  `date` varchar(255) NOT NULL DEFAULT '2010-04-06',
  `heure` varchar(255) NOT NULL DEFAULT '12:05:07',
  `verif` varchar(255) NOT NULL DEFAULT 'oui',
  `bandef` varchar(255) NOT NULL DEFAULT 'Non',
  `raison` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
COMMIT;