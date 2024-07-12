DROP DATABASE IF EXISTS `AM_JDBC_2024_07`;
CREATE DATABASE `AM_JDBC_2024_07`;
USE `AM_JDBC_2024_07`;

SHOW TABLES;

CREATE TABLE article(
                        id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        regDate DATETIME NOT NULL,
                        updateDate DATETIME NOT NULL,
                        title CHAR(100) NOT NULL,
                        `body` TEXT NOT NULL
);

INSERT INTO article
SET regDate = NOW(),
    updateDate = NOW(),
    title = CONCAT('제목', SUBSTRING(RAND() * 1000 FROM 1 FOR 2)),
    `body` = CONCAT('내용1', SUBSTRING(RAND() * 1000 FROM 1 FOR 2));


SELECT CONCAT ('제목', ' 1');  # 문자열을 이어붙여주는 함수

SELECT RAND();      #0부터 1까지 실행할때마다 랜덤값 ex)0.123432
SELECT RAND() * 10; #0부터 1까지 실행한 값에 10을 곱한것 ex)1.23432

SELECT SUBSTRING(RAND() * 10 FROM 1 FOR 1);

SELECT * FROM article;

SELECT * FROM article ORDER BY id DESC;

SELECT * FROM article ORDER BY id DESC;

CREATE TABLE `member`(
                         id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         regDate DATETIME NOT NULL,
                         updateDate DATETIME NOT NULL,
                         loginId CHAR(30) NOT NULL,
                         loginPw CHAR(200) NOT NULL,
                         `name` CHAR(100) NOT NULL
);

INSERT INTO `member`
SET regdate = NOW(),
    updateDate = NOW(),
    loginId = 'test1',
    loginPw = 'test1',
    `name` = 'name1';

INSERT INTO `member`
SET regdate = NOW(),
    updateDate = NOW(),
    loginId = 'test2',
    loginPw = 'test2',
    `name` = 'name2';

INSERT INTO `member`
SET regdate = NOW(),
    updateDate = NOW(),
    loginId = 'test3',
    loginPw = 'test3',
    `name` = 'name3';