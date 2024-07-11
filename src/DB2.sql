# 19강 문제 연습

# a5 데이터베이스 삭제/생성/선택
DROP DATABASE IF EXISTS `a5`;
CREATE DATABASE `a5`;
USE `a5`;

# 부서(dept) 테이블 생성 및 홍보부서 기획부서 추가
CREATE TABLE dept (
                      id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                      PRIMARY KEY(id),
                      regDate DATETIME NOT NULL,
                      `name` CHAR(100)NOT NULL
);

ALTER TABLE dept MODIFY COLUMN `name` CHAR(100) NOT NULL UNIQUE;

INSERT INTO dept
SET regDate = NOW(),
`name` = '홍보';

INSERT INTO dept
SET regDate = NOW(),
`name` = '기획';

# 사원(emp) 테이블 생성 및 홍길동사원(홍보부서), 홍길순사원(홍보부서), 임꺽정사원(기획부서) 추가
CREATE TABLE emp(
                    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                    PRIMARY KEY(id),
                    regDate DATETIME NOT NULL,
                    `name` CHAR(100) NOT NULL,
                    deptName CHAR(100) NOT NULL
);

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길동',
deptName = '홍보';

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길순',
deptName = '홍보';

INSERT INTO emp
SET regDate = NOW(),
`name` = '임꺽정',
deptName = '기획';

SELECT * FROM dept;
SELECT * FROM emp;

# 홍보를 마케팅으로 변경
SHOW TABLES;

SELECT * FROM dept;
SELECT * FROM emp;

UPDATE dept
SET `name` = '마케팅'
WHERE `name` = '홍보';

UPDATE emp
SET deptName = '마케팅'
WHERE deptName = '홍보';


# 마케팅을 홍보로 변경
UPDATE dept
SET `name` = '홍보'
WHERE `name` = '마케팅';

UPDATE emp
SET deptName = '홍보'
WHERE deptName = '마케팅';

# 홍보를 마케팅으로 변경
# 구조를 변경하기로 결정(사원 테이블에서, 이제는 부서를 이름이 아닌 번호로 기억)
ALTER TABLE emp ADD COLUMN deptId INT(10) UNSIGNED NOT NULL;

SELECT * FROM emp;

UPDATE emp
SET deptId = 1
WHERE deptName = '홍보';

UPDATE emp
SET deptId = 2
WHERE deptName = '기획';

ALTER TABLE emp DROP COLUMN deptName;

# 사장님께 드릴 인명록을 생성
SELECT *
FROM emp;

# 사장님께서 부서번호가 아니라 부서명을 알고 싶어하신다.
# 그래서 dept 테이블 조회법을 알려드리고 혼이 났다.
SELECT *
FROM dept;

# 사장님께 드릴 인명록을 생성(v2, 부서명 포함, ON 없이)
# 이상한 데이터가 생성되어서 혼남
SELECT emp.*, dept.name AS '부서명'
FROM emp
         INNER JOIN dept;

# 사장님께 드릴 인명록을 생성(v3, 부서명 포함, 올바른 조인 룰(ON) 적용)
# 보고용으로 좀 더 편하게 보여지도록 고쳐야 한다고 지적받음
SELECT emp.*, dept.name AS '부서명'
FROM emp
         INNER JOIN dept
                    ON dept.id = emp.deptId;

# 사장님께 드릴 인명록을 생성(v4, 사장님께서 보시기에 편한 칼럼명(AS))
SELECT emp.id AS '사원번호',
DATE(emp.regDate) AS '입사일',
emp.name AS '사원명',
dept.name AS `부서명`
FROM emp
    INNER JOIN dept
ON dept.id = emp.deptId`dept`
ORDER BY `부서명`;
#######################################################################################################################

# 20강 문제 연습 - 한 테이블에 모든 데이터가 있을 경우
DROP DATABASE IF EXISTS mall;

CREATE DATABASE mall;

USE mall;

CREATE TABLE t_shopping(
                           id INT(5) PRIMARY KEY AUTO_INCREMENT,
                           userId CHAR(30) NOT NULL,
                           userPw CHAR(30) NOT NULL,
                           userName CHAR(30) NOT NULL,
                           address CHAR(50) NOT NULL,
                           pname CHAR(50) NOT NULL,
                           price INT(5) NOT NULL
);

INSERT INTO t_shopping
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '운동화',
price = 1000000;

INSERT INTO t_shopping
SET userId = 'user2',
userPw = 'pass2',
userName = '설현',
address = '서울',
pname = '코트',
price = 100000;

INSERT INTO t_shopping
SET userId = 'user3',
userPw = 'pass3',
userName = '원빈',
address = '대전',
pname = '반바지',
price = 30000;

INSERT INTO t_shopping
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
address = '대구',
pname = '스커트',
price = 15000;

INSERT INTO t_shopping
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
address = '부산',
pname = '코트',
price = 100000;

INSERT INTO t_shopping
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
address = '울산',
pname = '티셔츠',
price = 9000;

INSERT INTO t_shopping
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
address = '울산',
pname = '운동화',
price = 200000;

INSERT INTO t_shopping
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '코트',
price = 100000;

INSERT INTO t_shopping
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
address = '울산',
pname = '스커트',
price = 15000;

INSERT INTO t_shopping
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '운동화',
price = 1000000;

INSERT INTO t_shopping
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
address = '부산',
pname = '모자',
price = 30000;

SELECT *
FROM t_shopping;

# 1. 손흥민의 주문 개수는? ???	#COUNT : 행의 갯수 세는 키워드
SELECT COUNT(*)
FROM t_shopping
WHERE userName = '손흥민';

# 2. 손흥민이 산 상품은? ???	#DISTINCT : 중복제거 키워드
SELECT DISTINCT pname
FROM t_shopping
WHERE userName = '손흥민';

# 3. 스커트를 산 사람은? ???
SELECT userId,userName
FROM t_shopping
WHERE pname = '스커트';

# 4. 가장 많이 주문한 사람의 아이디와 이름, 주문개수는? ???	#GROUP BY : 기준
SELECT userId, userName, COUNT(*)
FROM t_shopping
GROUP BY userName
ORDER BY COUNT(*) DESC
    LIMIT 1;

# 5. 소지섭이 사용한 총 금액은? ???
SELECT SUM(price) AS '소지섭이 사용한 총 금액'
FROM t_shopping
WHERE userName = '소지섭';
#######################################################################################################################

# 20강 문제 연습 - 테이블이 나뉘었을 경우
DROP DATABASE IF EXISTS mall;

CREATE DATABASE mall;

USE mall;

CREATE TABLE t_order(
                        id INT(5) PRIMARY KEY AUTO_INCREMENT,
                        userNo INT(5) NOT NULL,
                        productNo INT(5) NOT NULL
);

CREATE TABLE t_user(
                       id INT(5) PRIMARY KEY AUTO_INCREMENT,
                       userId CHAR(200) NOT NULL,
                       userPw CHAR(200) NOT NULL,
                       userName CHAR(50) NOT NULL,
                       addr CHAR(200) NOT NULL
);

CREATE TABLE t_product(
                          id INT(5) PRIMARY KEY AUTO_INCREMENT,
                          pname CHAR(100) NOT NULL,
                          price INT(10) NOT NULL
);

INSERT INTO t_product
SET pname = '운동화',
price = 1000000;

INSERT INTO t_product
SET pname = '코트',
price = 100000;

INSERT INTO t_product
SET pname = '반바지',
price = 30000;

INSERT INTO t_product
SET pname = '스커트',
price = 15000;

INSERT INTO t_product
SET pname = '코트',
price = 100000;

INSERT INTO t_product
SET pname = '티셔츠',
price = 9000;

INSERT INTO t_product
SET pname = '운동화',
price = 200000;

INSERT INTO t_product
SET pname = '모자',
price = 30000;



INSERT INTO t_user
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
addr = '런던';

INSERT INTO t_user
SET userId = 'user2',
userPw = 'pass2',
userName = '설현',
addr = '서울';

INSERT INTO t_user
SET userId = 'user3',
userPw = 'pass3',
userName = '원빈',
addr = '대전';

INSERT INTO t_user
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
addr = '대구';

INSERT INTO t_user
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
addr = '부산';

INSERT INTO t_user
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
addr = '울산';


INSERT INTO t_order
SET userNo = 1,
productNo = 1;

INSERT INTO t_order
SET userNo = 2,
productNo = 2;

INSERT INTO t_order
SET userNo = 3,
productNo = 3;

INSERT INTO t_order
SET userNo = 4,
productNo = 4;

INSERT INTO t_order
SET userNo = 5,
productNo = 5;

INSERT INTO t_order
SET userNo = 6,
productNo = 6;

INSERT INTO t_order
SET userNo = 6,
productNo = 7;

INSERT INTO t_order
SET userNo = 1,
productNo = 5;

INSERT INTO t_order
SET userNo = 4,
productNo = 4;

INSERT INTO t_order
SET userNo = 1,
productNo = 1;

INSERT INTO t_order
SET userNo = 5,
productNo = 8;

SELECT * FROM t_order;
SELECT * FROM t_user;
SELECT * FROM t_product;

# 1. 손흥민의 주문 개수는? ???
SELECT * FROM t_order;
SELECT * FROM t_user;
SELECT * FROM t_product;

SELECT * FROM t_user WHERE userName = '손흥민';
SELECT COUNT(*) FROM t_order WHERE userNo = 1;

## 0711 추가
SELECT COUNT(*) AS '손흥민의 주문 개수'
FROM t_order
         INNER JOIN t_user
                    ON t_order.userNo = t_user.id
WHERE t_user.userName = '손흥민';

# 2. 손흥민이 산 상품은? ???
SELECT * FROM t_order;
SELECT * FROM t_user;
SELECT * FROM t_product;

SELECT * FROM t_user
WHERE userName = '손흥민';

SELECT * FROM t_order
WHERE userNo = 1;

SELECT pname FROM t_product
WHERE id = 1 OR id = 5;

## 위 아래 같은 것
SELECT pname FROM t_product
WHERE id IN (1,5);

## 0711 추가
## 3테이블 join 원형
SELECT *
FROM t_order AS o
         INNER JOIN t_user AS u
                    ON o.userNo = u.id
         INNER JOIN t_product AS p
                    ON o.productNo = p.id;

SELECT DISTINCT p.pname
FROM t_order AS o
         INNER JOIN t_user AS u
                    ON o.userNo = u.id
         INNER JOIN t_product AS p
                    ON o.productNo = p.id
WHERE u.userName = '손흥민';

SELECT p.pname, COUNT(*)
FROM t_order AS o
         INNER JOIN t_user AS u
                    ON o.userNo = u.id
         INNER JOIN t_product AS p
                    ON o.productNo = p.id
WHERE u.userName = '손흥민'
GROUP BY p.id;

# 3. 스커트를 산 사람은? ???
SELECT * FROM t_order;
SELECT * FROM t_user;
SELECT * FROM t_product;

SELECT * FROM t_product
WHERE pname = '스커트';

SELECT * FROM t_order
WHERE productNo = 4;

SELECT * FROM t_user
WHERE id = 4;

##0711 추가
SELECT o.id AS '주문 번호' , o.userNo AS '회원 번호' ,u.userName AS '주문자'
FROM t_order AS o
         INNER JOIN t_user AS u
                    ON o.userNo = u.id
         INNER JOIN t_product AS p
                    ON o.productNo = p.id
WHERE p.pname = '스커트';


# 4. 가장 많이 주문한 사람의 아이디와 이름, 주문개수는? ???
SELECT * FROM t_order;
SELECT * FROM t_user;
SELECT * FROM t_product;

SELECT userNo, COUNT(UserNo)
FROM t_order
GROUP BY userNo
ORDER BY COUNT(userNo) DESC
    LIMIT 1;

SELECT userId, userName FROM t_user
WHERE id = 1;

##0711 추가
SELECT u.userId AS '아이디', u.userName AS '이름' , COUNT(*) AS '주문갯수'
FROM t_order AS o
         INNER JOIN t_user AS u
                    ON o.userNo = u.id
         INNER JOIN t_product AS p
                    ON o.productNo = p.id
GROUP BY u.id
ORDER BY COUNT(*) DESC      #count(*)을 기준으로 내림차순으로 정렬
LIMIT 1;

# 5. 소지섭이 사용한 총 금액은? ???
SELECT * FROM t_order;
SELECT * FROM t_user;
SELECT * FROM t_product;

SELECT * FROM t_user
WHERE userName = '소지섭';

SELECT * FROM t_order
WHERE userNo = 5;

SELECT SUM(price) FROM t_product
WHERE id IN(5,8);

##0711 추가
SELECT SUM(price) AS '소지섭이 사용한 금액'
FROM t_order AS o
         INNER JOIN t_user AS u
                    ON o.userNo = u.id
         INNER JOIN t_product AS p
                    ON o.productNo = p.id
WHERE u.userName = '소지섭';
#######################################################################################################################
#22강 문제 - 상황에 맞는 SQL을 작성해주세요, SUM, MAX, MIN, COUNT

# a6 DB 삭제/생성/선택
DROP DATABASE IF EXISTS `a6`;
CREATE DATABASE `a6`;
USE `a6`;

# 부서(홍보, 기획)
CREATE TABLE dept (
                      id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                      PRIMARY KEY(id),
                      regDate DATETIME NOT NULL,
                      `name` CHAR(100)NOT NULL
);

INSERT INTO dept
SET regDate = NOW(),
`name` = '홍보';

INSERT INTO dept
SET regDate = NOW(),
`name` = '기획';

# 사원(홍길동/홍보/5000만원, 홍길순/홍보/6000만원, 임꺽정/기획/4000만원)
CREATE TABLE emp (
                     id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                     PRIMARY KEY(id),
                     regDate DATETIME NOT NULL,
                     `name` CHAR(50) NOT NULL,       #사원명
                         deptName CHAR (100) NOT NULL,   #부서명
                         salary INT(100) NOT NULL        #급여
);

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길동',
deptName = '홍보',
salary = 5000;

INSERT INTO emp
SET regDate = NOW(),
`name` = '홍길순',
deptName = '홍보',
salary = 6000;

INSERT INTO emp
SET regDate = NOW(),
`name` = '임꺽정',
deptName = '기획',
salary = 4000;

SELECT * FROM emp;
# 사원 수 출력
SELECT COUNT(*) AS '사원 수'
FROM emp;

# 가장 큰 사원 번호 출력
SELECT id AS '가장 큰 사원번호'
FROM emp
ORDER BY id DESC
    LIMIT 1;

# 가장 고액 연봉
SELECT MAX(salary) AS '가장 고액 연봉'
FROM emp;

# 가장 저액 연봉
SELECT MIN(salary) AS '가장 저액 연봉'
FROM emp;

# 회사에서 1년 고정 지출(인건비)
SELECT * FROM emp;

SELECT SUM(salary) AS '1년 고정지출(인건비)'
FROM emp;

# 부서별, 1년 고정 지출(인건비)
SELECT deptName AS '부서명' , SUM(salary) AS '1년 고정지출(인건비)'
FROM emp
GROUP BY deptName;

# 부서별, 최고연봉
SELECT deptname AS '부서명' , MAX(salary) AS '최고연봉'
FROM emp
GROUP BY deptname;


# 부서별, 최저연봉
SELECT deptName AS '부서명' , MIN(salary) AS '최저연봉'
FROM emp
GROUP BY deptname;

# 부서별, 평균연봉
SELECT deptName AS '부서명' , AVG(salary) AS '평균연봉'
FROM emp
GROUP BY deptname

SELECT * FROM emp;

### 구조를 변경, 사원테이블에서 부서를 번호로 기억
ALTER TABLE emp ADD COLUMN deptId INT(10) UNSIGNED NOT NULL AFTER deptName;

UPDATE emp
SET deptId = 1
WHERE deptName = '홍보';

UPDATE emp
SET deptId = 2
WHERE deptName = '기획';

ALTER TABLE emp DROP COLUMN deptName;


# 부서별, 부서명, 사원리스트, 평균연봉, 최고연봉, 최소연봉, 사원수
## V1(조인 안한 버전)
SELECT
    deptId,
    GROUP_CONCAT(`name`) AS '사원리스트',
        AVG(salary) AS '평균연봉',
        MAX(salary) AS '최고연봉',
        MIN(salary) AS '최소연봉',
        COUNT(*) AS '사원수'
FROM emp
GROUP BY deptId;

## V2(조인해서 부서명까지 나오는 버전)
SELECT
    dept.name AS '부서명',
        GROUP_CONCAT(emp.`name`) AS '사원리스트',
        CONCAT(ROUND(AVG(salary),0), '만원') AS '평균연봉',
        CONCAT(MAX(salary), '만원') AS '최고연봉',
        CONCAT(MIN(salary), '만원') AS '최소연봉',
        COUNT(*) AS '사원수'
FROM emp
         INNER JOIN dept             #dept 테이블을 join
ON dept.id = emp.deptId     #dept 테이블의 id와, emp테이블의 deptId가 같은 것만
GROUP BY deptId;

## V3(V2에서 평균연봉이 5000이상인 부서로 추리기)
SELECT
    dept.name AS '부서명',
        GROUP_CONCAT(emp.`name`) AS '사원리스트',
        CONCAT(ROUND(AVG(salary),0), '만원') AS '평균연봉',
        CONCAT(MAX(salary), '만원') AS '최고연봉',
        CONCAT(MIN(salary), '만원') AS '최소연봉',
        COUNT(*) AS '사원수'
FROM emp
         INNER JOIN dept
                    ON dept.id = emp.deptId
GROUP BY deptId
HAVING AVG(salary) >= 5000;     #그룹의 조건은 having 사용

## V4(V3에서 HAVING 없이 서브쿼리로 수행)
### HINT, UNION을 이용한 서브쿼리
# SELECT *
                                                  # FROM (
                                                             #     select 1 AS id
#     union
#     select 2
#     UNION
#     select 3
# ) AS A

SELECT * FROM emp;
SELECT * FROM dept;

SELECT
    dept.name AS '부서명',
        GROUP_CONCAT(emp.`name`) AS '사원리스트',
        CONCAT(ROUND(AVG(salary),0), '만원') AS '평균연봉',
        CONCAT(MAX(salary), '만원') AS '최고연봉',
        CONCAT(MIN(salary), '만원') AS '최소연봉',
        COUNT(*) AS '사원수'
FROM emp
         INNER JOIN dept
                    ON dept.id = emp.deptId
GROUP BY deptId
HAVING AVG(salary) >= 5000;

SELECT *
FROM (
         SELECT

#######################################################################################################################
    # 22강 문제 풀기
             DROP DATABASE IF EXISTS scott;

CREATE DATABASE scott;

USE scott;

CREATE TABLE DEPT (
                      DEPTNO DECIMAL(2),
                      DNAME VARCHAR(14),
                      LOC VARCHAR(13),
                      CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO)
);
CREATE TABLE EMP (
                     EMPNO DECIMAL(4),
                     ENAME VARCHAR(10),
                     JOB VARCHAR(9),
                     MGR DECIMAL(4),
                     HIREDATE DATE,
                     SAL DECIMAL(7,2),
                     COMM DECIMAL(7,2),
                     DEPTNO DECIMAL(2),
                     CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
                     CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);
CREATE TABLE SALGRADE (
                          GRADE TINYINT,
                          LOSAL SMALLINT,
                          HISAL SMALLINT
);
INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,STR_TO_DATE('17-12-1980','%d-%m-%Y'),800,NULL,20);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,STR_TO_DATE('20-2-1981','%d-%m-%Y'),1600,300,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,STR_TO_DATE('22-2-1981','%d-%m-%Y'),1250,500,30);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,STR_TO_DATE('2-4-1981','%d-%m-%Y'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,STR_TO_DATE('28-9-1981','%d-%m-%Y'),1250,1400,30);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,STR_TO_DATE('1-5-1981','%d-%m-%Y'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,STR_TO_DATE('9-6-1981','%d-%m-%Y'),2450,NULL,10);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,STR_TO_DATE('13-7-1987','%d-%m-%Y')-85,3000,NULL,20);
INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,STR_TO_DATE('17-11-1981','%d-%m-%Y'),5000,NULL,10);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,STR_TO_DATE('8-9-1981','%d-%m-%Y'),1500,0,30);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,STR_TO_DATE('13-7-1987', '%d-%m-%Y'),1100,NULL,20);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,STR_TO_DATE('3-12-1981','%d-%m-%Y'),950,NULL,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,STR_TO_DATE('3-12-1981','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,STR_TO_DATE('23-1-1982','%d-%m-%Y'),1300,NULL,10);
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);


#1. 사원 테이블의 모든 레코드를 조회하시오.
SELECT *
FROM EMP;

#2. 사원명과 입사일을 조회하시오.
SELECT ENAME AS '사원명', HIREDATE AS '입사일'
FROM EMP;

#3. 사원번호와 이름을 조회하시오.
SELECT EMPNO AS '사원번호', ENAME AS '이름'
FROM EMP;

#4. 사원테이블에 있는 직책의 목록을 조회하시오. (hint : distinct, group by)
SELECT * FROM DEPT;
SELECT DISTINCT JOB AS '직책'
FROM EMP;

#5. 총 사원수를 구하시오. (hint : count)
SELECT COUNT(*) AS '사원수'
FROM EMP;

#6. 부서번호가 10인 사원을 조회하시오.
SELECT *
FROM EMP
WHERE DEPTNO = 10;

#7. 월급여가 2500이상 되는 사원을 조회하시오.
SELECT *
FROM EMP
WHERE SAL >= 2500;

#8. 이름이 'KING'인 사원을 조회하시오.
SELECT *
FROM EMP
WHERE ENAME = 'KING';

#9. 사원들 중 이름이 S로 시작하는 사원의 사원번호와 이름을 조회하시오. (hint : like)
SELECT EMPNO AS '사원번호', ENAME AS '이름'
FROM EMP
WHERE ENAME
          LIKE 'S%';

#10. 사원 이름에 T가 포함된 사원의 사원번호와 이름을 조회하시오. (hint : like)
SELECT EMPNO AS '사원번호', ENAME AS '이름'
FROM EMP
WHERE ENAME
          LIKE '%T%';

#11. 커미션이 300, 500, 1400 인 사원의 사번,이름,커미션을 조회하시오. (hint : OR, in )
SELECT EMPNO AS '사원번호', ENAME AS '이름', COMM AS '커미션'
FROM EMP
WHERE COMM IN (300, 500, 1400);

#12. 월급여가 1200 에서 3500 사이의 사원의 사번,이름,월급여를 조회하시오. (hint : AND, between)
SELECT EMPNO AS '사원번호', ENAME AS '사원명', SAL AS '월급여'
FROM EMP
WHERE SAL BETWEEN 1200 AND 3500;

#13. 직급이 매니저이고 부서번호가 30번인 사원의 이름,사번,직급,부서번호를 조회하시오.
SELECT ENAME AS '이름', EMPNO AS '사원번호', JOB AS '직급' , DEPTNO AS '부서번호'
FROM EMP
WHERE JOB = 'MANAGER' AND DEPTNO = '30';

#14. 부서번호가 30인 아닌 사원의 사번,이름,부서번호를 조회하시오. (not)
SELECT EMPNO AS '사원번호', ENAME AS '이름', DEPTNO AS '부서번호'
FROM EMP
WHERE NOT DEPTNO = '30';

#15. 커미션이 300, 500, 1400 이 모두 아닌 사원의 사번,이름,커미션을 조회하시오. (hint : not in)
SELECT EMPNO AS '사원번호', ENAME AS '이름', COMM AS '커미션'
FROM EMP
WHERE COMM NOT IN (300, 500, 1400);

#16. 이름에 S가 포함되지 않는 사원의 사번,이름을 조회하시오. (hint : not like)
SELECT EMPNO AS '사원번호', ENAME AS '이름'
FROM EMP
WHERE ENAME
          NOT LIKE '%S%';

#17. 급여가 1200보다 미만이거나 3700 초과하는 사원의 사번,이름,월급여를 조회하시오. (hint : not, between)
SELECT * FROM EMP;
SELECT EMPNO AS '사원번호', ENAME AS '이름', SAL AS '월급여'
FROM EMP
WHERE SAL NOT BETWEEN 1200 AND 3700;

#18. 직속상사가 NULL 인 사원의 이름과 직급을 조회하시오. (hint : is null, is not null)
SELECT * FROM EMP;

SELECT ENAME AS '이름', JOB AS '직급'
FROM EMP
WHERE MGR IS NULL;


#19. 부서별 평균월급여를 구하는 쿼리 (hint : group by, avg())
SELECT DEPTNO AS '부서번호', AVG(SAL) AS '평균월급여'
FROM EMP
GROUP BY DEPTNO;

#20. 부서별 전체 사원수와 커미션을 받는 사원들의 수를 구하는 쿼리 (hint : group by, count())
SELECT DEPTNO AS '부서번호', COUNT(*) AS '전체 사원수', COUNT(COMM)  AS '커미션 받는 사원 수'
FROM EMP
GROUP BY DEPTNO;

#21. 부서별 최대 급여와 최소 급여를 구하는 쿼리 (hint : group by, min(), max())
SELECT DEPTNO AS '부서번호', MAX(SAL) AS '최대 급여', MIN(SAL) AS '최소 급여'
FROM EMP
GROUP BY DEPTNO;

#22. 부서별로 급여 평균 (단, 부서별 급여 평균이 2000 이상만) (hint : group by, having)
SELECT DEPTNO AS '부서번호', AVG(SAL) AS '평균월급여'
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000;

#23. 월급여가 1000 이상인 사원만을 대상으로 부서별로 월급여 평균을 구하라. 단, 평균값이 2000 이상인 레코드만 구하라. (hint : group by, having)
SELECT DEPTNO AS '부서번호', AVG(SAL) AS '평균월급여'
FROM EMP
WHERE SAL >= 1000
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000;

#24. 사원명과 부서명을 조회하시오. (hint : inner join)
SELECT * FROM DEPT;
SELECT * FROM EMP;

SELECT EMP.ENAME AS '사원명' ,DEPT.DNAME AS '부서명'
FROM EMP
         INNER JOIN DEPT
                    ON DEPT.DEPTNO = EMP.DEPTNO;

#25. 이름,월급여,월급여등급을 조회하시오. (hint : inner join, between)
SELECT EMP.ENAME AS '이름', EMP.SAL AS '월급여', SALGRADE.GRADE AS '월급여등급'
FROM EMP
         INNER JOIN SALGRADE
WHERE EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL;

#26. 이름,부서명,월급여등급을 조회하시오.
SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

SELECT EMP.ENAME AS '이름' , DEPT.DNAME AS '부서명' , SALGRADE.GRADE AS '월급여등급'
FROM EMP
         INNER JOIN DEPT
                    ON EMP.DEPTNO = DEPT.DEPTNO
         INNER JOIN SALGRADE
                    ON EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL;

#27. 이름,직속상사이름을 조회하시오. (hint : self join
SELECT EMP1.ENAME AS '이름', EMP2.MGR AS '직속상사이름'
FROM EMP EMP1
JOIN EMP EMP2
ON EMP1.EMPNO = EMP2.EMPNO;

#28. 이름,직속상사이름을 조회하시오.(단 직속 상사가 없는 사람도 직속상사 결과가 null값으로 나와야 함) (hint : outer join)
###외부OUTER 조인. A LEFT JOIN B는 조인 조건에 만족하지 못하더라도 왼쪽 테이블 A의 행을 나타내고 싶을 때 사용한다.
###반대로 A RIGHT JOIN B는 조인 조건에 만족하지 못하더라도 오른쪽 테이블 B의 행을 나타내고 싶을 때
SELECT EMP1.ENAME AS '이름', EMP2.MGR AS '직속상사이름'
FROM EMP EMP1
LEFT OUTER JOIN EMP EMP2
ON EMP1.EMPNO = EMP2.EMPNO;

#29. 이름,부서명을 조회하시오.
#단, 사원테이블에 부서번호가 40에 속한 사원이 없지만 부서번호 40인 부서명도 출력되도록 하시오. (hint : outer join)
SELECT EMP.ENAME , DEPT.DNAME
FROM EMP
RIGHT OUTER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

#서브 쿼리는 SELECT 문 안에서 ()로 둘러싸인 SELECT 문을 말하며 쿼리문의 결과를 메인 쿼리로 전달하기 위해 사용된다.
#사원명 'JONES'가 속한 부서명을 조회하시오.
#부서번호를 알아내기 위한 쿼리가 서브 쿼리로 사용.
SELECT DEPTNO FROM DEPT # 부서번호 알아내는 쿼리.....

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT DEPTNO FROM DEPT WHERE DEPTNO = 10;
SELECT

SELECT DEMP.DNAME   # 부서명 // 사원 JONES 가 속한...
FROM EMP
WHERE (SELECT DEPTNO FROM DEPT INNER JOIN EMP WHERE EMP.ENAME = JONES)

SELECT DEPTNO FROM DEPT INNER JOIN EMP ON WHERE EMP.ENAME = JONES


#30. 10번 부서에서 근무하는 사원의 이름과 10번 부서의 부서명을 조회하시오. (hint : sub query)
SELECT EMP.ENAME, DEPT.DNAME
FROM (SELECT DEPTNO FROM DEPT WHERE DEPTNO = 10);

#31. 평균 월급여보다 더 많은 월급여를 받은 사원의 사원번호,이름,월급여 조회하시오. (hint : sub query)


#32. 부서번호가 10인 사원중에서 최대급여를 받는 사원의 사원번호, 이름을 조회하시오. (hint : sub query)



