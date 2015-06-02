CREATE SCHEMA IF NOT EXISTS `web_course` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `web_course` ;

DELETE FROM Users;
DELETE FROM Activities;

INSERT INTO Users(username, password) VALUES ("test1", "test1");
INSERT INTO Users(username, password) VALUES ("test2", "test2");
INSERT INTO Users(username, password) VALUES ("test3", "test3");
INSERT INTO Users(username, password) VALUES ("test4", "test4");
INSERT INTO Users(username, password) VALUES ("test5", "test5");
INSERT INTO Users(username, password) VALUES ("test6", "test6");


INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 1", "This is Activity 1.", "2015-06-01", "2015-06-02");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 2", "This is Activity 2.", "2015-06-02", "2015-06-03");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 3", "This is Activity 3.", "2015-06-03", "2015-06-04");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 4", "This is Activity 4.", "2015-06-04", "2015-06-05");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 5", "This is Activity 5.", "2015-06-05", "2015-06-06");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 6", "This is Activity 6.", "2015-06-06", "2015-06-07");
INSERT INTO Activities(name, content, start_time, end_time) VALUES ("Activity 7", "This is Activity 7.", "2015-06-07", "2015-06-08");
