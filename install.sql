CREATE TABLE IF NOT EXISTS `user_clothes` (
  `id` int AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `skin` varchar(255) NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` varchar(255) NOT NULL DEFAULT '0',
  `face_texture` varchar(255) NOT NULL DEFAULT '0',
  `hair` varchar(255) NOT NULL DEFAULT '0',
  `hair_texture` varchar(255) NOT NULL DEFAULT '0',
  `shirt` varchar(255) NOT NULL DEFAULT '0',
  `shirt_texture` varchar(255) NOT NULL DEFAULT '0',
  `pants` varchar(255) NOT NULL DEFAULT '0',
  `pants_texture` varchar(255) NOT NULL DEFAULT '0',
  `shoes` varchar(255) NOT NULL DEFAULT '0',
  `shoes_texture` varchar(255) NOT NULL DEFAULT '0',
  `vest` varchar(255) NOT NULL DEFAULT '0',
  `vest_texture` varchar(255) NOT NULL DEFAULT '0',
  `bag` varchar(255) NOT NULL DEFAULT '0',
  `bag_texture` varchar(255) NOT NULL DEFAULT '0',
  `hat` varchar(255) NOT NULL DEFAULT '0',
  `hat_texture` varchar(255) NOT NULL DEFAULT '0',
  `mask` varchar(255) NOT NULL DEFAULT '0',
  `mask_texture` varchar(255) NOT NULL DEFAULT '0',
  `glasses` varchar(255) NOT NULL DEFAULT '0',
  `glasses_texture` varchar(255) NOT NULL DEFAULT '0',
  `gloves` varchar(255) NOT NULL DEFAULT '0',
  `gloves_texture` varchar(255) NOT NULL DEFAULT '0',
  `jacket` varchar(255) NOT NULL DEFAULT '0',
  `jacket_texture` varchar(255) NOT NULL DEFAULT '0',
  `gloves` varchar(255) NOT NULL DEFAULT '0',
  `gloves_texture` varchar(255) NOT NULL DEFAULT '0',
  `ears` varchar(255) NOT NULL DEFAULT '0',
  `ears_texture` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT fk_user_clothes FOREIGN KEY(identifier) REFERENCES users(identifier) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



UPDATE users SET isFirstConnection = 1;
