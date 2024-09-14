--CREATE TABLE `users` (
--  `id` bigint(20) NOT NULL AUTO_INCREMENT,
--  `name` varchar(40) NOT NULL,
--  `username` varchar(15) NOT NULL,
--  `email` varchar(40) NOT NULL,
--  `password` varchar(100) NOT NULL,
--  `created_at` datetime DEFAULT NULL,
--  `updated_at` datetime DEFAULT NULL,
--  PRIMARY KEY (`id`),
--  UNIQUE KEY `uk_users_username` (`username`),
--  UNIQUE KEY `uk_users_email` (`email`)
--) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
--
--CREATE TABLE `roles` (
--  `id` bigint(20) NOT NULL AUTO_INCREMENT,
--  `name` varchar(60) NOT NULL,
--  PRIMARY KEY (`id`),
--  UNIQUE KEY `uk_roles_name` (`name`)
--) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
--
--
--CREATE TABLE `user_roles` (
--  `user_id` bigint(20) NOT NULL,
--  `role_id` bigint(20) NOT NULL,
--  PRIMARY KEY (`user_id`,`role_id`),
--  KEY `fk_user_roles_role_id` (`role_id`),
--  CONSTRAINT `fk_user_roles_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
--  CONSTRAINT `fk_user_roles_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
--) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
--
--CREATE TABLE `polls` (
--  `id` bigint(20) NOT NULL AUTO_INCREMENT,
--  `question` varchar(140) NOT NULL,
--  `expiration_date_time` datetime NOT NULL,
--  `created_at` datetime DEFAULT NULL,
--  `updated_at` datetime DEFAULT NULL,
--  `created_by` bigint(20) DEFAULT NULL,
--  `updated_by` bigint(20) DEFAULT NULL,
--  PRIMARY KEY (`id`)
--) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
--
--CREATE TABLE `choices` (
--  `id` bigint(20) NOT NULL AUTO_INCREMENT,
--  `text` varchar(40) NOT NULL,
--  `poll_id` bigint(20) NOT NULL,
--  PRIMARY KEY (`id`),
--  KEY `fk_choices_poll_id` (`poll_id`),
--  CONSTRAINT `fk_choices_poll_id` FOREIGN KEY (`poll_id`) REFERENCES `polls` (`id`)
--) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
--
--CREATE TABLE `votes` (
--  `id` bigint(20) NOT NULL AUTO_INCREMENT,
--  `user_id` bigint(20) NOT NULL,
--  `poll_id` bigint(20) NOT NULL,
--  `choice_id` bigint(20) NOT NULL,
--  `created_at` datetime DEFAULT NULL,
--  `updated_at` datetime DEFAULT NULL,
--  PRIMARY KEY (`id`),
--  KEY `fk_votes_user_id` (`user_id`),
--  KEY `fk_votes_poll_id` (`poll_id`),
--  KEY `fk_votes_choice_id` (`choice_id`),
--  CONSTRAINT `fk_votes_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
--  CONSTRAINT `fk_votes_poll_id` FOREIGN KEY (`poll_id`) REFERENCES `polls` (`id`),
--  CONSTRAINT `fk_votes_choice_id` FOREIGN KEY (`choice_id`) REFERENCES `choices` (`id`)
--) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE users (
  id SERIAL PRIMARY KEY,  -- Use SERIAL for auto-incrementing ids in PostgreSQL
  name VARCHAR(40) NOT NULL,
  username VARCHAR(15) NOT NULL,
  email VARCHAR(40) NOT NULL,
  password VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  UNIQUE (username),  -- Define unique constraints without `UNIQUE KEY`
  UNIQUE (email)
);

CREATE TABLE roles (
  id SERIAL PRIMARY KEY,  -- Use SERIAL for auto-incrementing ids
  name VARCHAR(60) NOT NULL,
  UNIQUE (name)
);

CREATE TABLE user_roles (
  user_id BIGINT NOT NULL,
  role_id BIGINT NOT NULL,
  PRIMARY KEY (user_id, role_id),  -- Composite primary key
  FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE CASCADE,  -- Foreign keys in PostgreSQL
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE polls (
  id SERIAL PRIMARY KEY,
  question VARCHAR(140) NOT NULL,
  expiration_date_time TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  created_by BIGINT DEFAULT NULL,
  updated_by BIGINT DEFAULT NULL
);

CREATE TABLE choices (
  id SERIAL PRIMARY KEY,
  text VARCHAR(40) NOT NULL,
  poll_id BIGINT NOT NULL,
  FOREIGN KEY (poll_id) REFERENCES polls (id) ON DELETE CASCADE
);

CREATE TABLE votes (
  id SERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL,
  poll_id BIGINT NOT NULL,
  choice_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  FOREIGN KEY (poll_id) REFERENCES polls (id) ON DELETE CASCADE,
  FOREIGN KEY (choice_id) REFERENCES choices (id) ON DELETE CASCADE
);