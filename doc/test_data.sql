CREATE SCHEMA IF NOT EXISTS `web_course` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `web_course` ;

DELETE FROM Users;
DELETE FROM Activities;

INSERT INTO Users(username, password, nick_name) VALUES ("test1", "test1", "测试1");
INSERT INTO Users(username, password, nick_name) VALUES ("test2", "test2", "测试2");
INSERT INTO Users(username, password, nick_name) VALUES ("test3", "test3", "测试3");
INSERT INTO Users(username, password, nick_name) VALUES ("test4", "test4", "测试4");
INSERT INTO Users(username, password, nick_name) VALUES ("test5", "test5", "测试5");
INSERT INTO Users(username, password, nick_name) VALUES ("test6", "test6", "测试6");

INSERT INTO Activities(name, content, start_time) VALUES ("**personal_activity**", "**personal_activity**", "9999-99-99");
UPDATE Activities SET id = 0 WHERE name = "**personal_activity**";

INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 1", "This is Activity 1.", "2015-06-01", "2015-06-02");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 2", "This is Activity 2.", "2015-06-02", "2015-06-03");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 3", "This is Activity 3.", "2015-06-03", "2015-06-04");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 4", "This is Activity 4.", "2015-06-04", "2015-06-05");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 5", "This is Activity 5.", "2015-06-05", "2015-06-06");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 6", "This is Activity 6.", "2015-06-06", "2015-06-07");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 7", "This is Activity 7.", "2015-06-07", "2015-06-08");

INSERT INTO Role(id) VALUES (1);
INSERT INTO Role(id) VALUES (2);
