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

