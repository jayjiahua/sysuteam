CREATE SCHEMA IF NOT EXISTS `web_course` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `web_course` ;

DELETE FROM Users;
DELETE FROM Activities;

INSERT INTO Activities(name, content, start_time) VALUES ("**personal_activity**", "**personal_activity**", "9999-99-99");
UPDATE Activities SET id = 0 WHERE name = "**personal_activity**";

INSERT INTO Role(id) VALUES (1);
INSERT INTO Role(id) VALUES (2);
