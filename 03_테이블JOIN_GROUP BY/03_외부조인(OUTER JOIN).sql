--(번외) 고객 중 한 권도 구입 안 한 사람은 누구??
--고객테이블에는 있는데, 주문(판매) 테이블에 없는 사람
-------
--(방법1) MINUS : 차집합 처리 
SELECT CUSTID FROM CUSTOMER --1,2,3,4,5
MINUS 
SELECT CUSTID FROM ORDERS; --1,1,2,3,4,1, ....
-----
--(방법2) 서브쿼리(SUB QUERY-부분쿼리)
SELECT * FROM CUSTOMER
WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS);
----
--(방법3) 외부조인(OUTER JOIN)
--고객 중 한번도 구입내역이 없는 고객 명단 구하기
SELECT * FROM CUSTOMER C, ORDERS O WHERE C.CUSTID = O.CUSTID; --INNER JOIN 
------------
SELECT C.CUSTID, C.NAME, C.ADDRESS, C.PHONE, O.ORDERID, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O 
WHERE C.CUSTID = O.CUSTID(+) --조인조건(LEFT OUTER JOIN): 오른쪽에 부족한 부분 표시
AND O.ORDERID IS NULL --찾을(검색,선택)조건
; 
--표준 SQL(LEFT OUTER JOIN)
SELECT C.CUSTID, C.NAME, C.ADDRESS, C.PHONE
    --, O.ORDERID, O.SALEPRICE, O.ORDERDATE 
FROM ORDERS O LEFT OUTER JOIN CUSTOMER C --좌측기준
    ON O.CUSTID = C.CUSTID 
WHERE O.ORDERID IS NULL
;

--RIGHT OUTER JOIN 
SELECT C.CUSTID, C.NAME, C.ADDRESS, C.PHONE
    --, O.ORDERID, O.SALEPRICE, O.ORDERDATE
FROM ORDERS O  RIGHT OUTER JOIN CUSTOMER C --우측기준
     ON O.CUSTID = C.CUSTID
WHERE O.ORDERID IS NULL
; 
--외부조인(우측기준)
SELECT C.CUSTID, C.NAME, C.ADDRESS, C.PHONE, O.ORDERID, O.SALEPRICE, O.ORDERDATE
FROM ORDERS O,CUSTOMER C  
WHERE O.CUSTID(+) = C.CUSTID  --조인조건(RIGHT OUTER JOIN) - 우측기준
AND O.ORDERID IS NULL --찾을(검색,선택)조건
; 
------------------------
--조인(JOIN, INNER JOIN, 내부조인): 조인테이블 모두에 존재하는 데이터 검색
--외부조인(OUTER JOIN) : 어느 한 쪽에만 존재하는 데이터 검색
-------------------
--DEPT TALBE 
CREATE TABLE DEPT (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);

INSERT INTO DEPT VALUES('10','총무부');
INSERT INTO DEPT VALUES('20','급여부');
INSERT INTO DEPT VALUES('30','IT부');
COMMIT;
-------------------
--DEPT1 TALBE
CREATE TABLE DEPT1 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);

INSERT INTO DEPT1 VALUES('10','총무부');
INSERT INTO DEPT1 VALUES('20','급여부');
COMMIT;
---------------------
--DEPT2 TALBE
CREATE TABLE DEPT2 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);

INSERT INTO DEPT2 VALUES('20','급여부');
INSERT INTO DEPT2 VALUES('30','IT부');
COMMIT;
--====================================
SELECT * FROM DEPT;
SELECT * FROM DEPT1;
SELECT * FROM DEPT2;

--LEFT OUTER JOIN :좌측 테이블 기준 (모두표시)
SELECT * FROM DEPT D, DEPT1 D1
WHERE D.ID = D1.ID(+)
;

SELECT * FROM DEPT D LEFT OUTER JOIN DEPT1 D1
ON D.ID = D1.ID;

--RIGHT OUTER JOIN :우측 테이블 기준(우측테이블 데이터 모두 표시)
SELECT * FROM DEPT2 D2, DEPT D
WHERE D2.ID(+) = D.ID
;

SELECT * FROM DEPT2 D2 RIGHT OUTER JOIN DEPT D
ON D2.ID = D.ID;

--FULL OUTER JOIN(표준 SQL)
SELECT * FROM DEPT1 D1 FULL OUTER JOIN DEPT2 D2
ON D1.ID = D2.ID
ORDER BY D1.ID;
-------------------------------------
--(실습) DEPT1, DEPT2 테이블 사용해서 
--1.DEPT1에는 있고, DEPT2에는 없는 데이터 찾기 (LEFT OUTER JOIN)
--2.DEPT1에는 없고, DEPT2에는 있는 데이터 찾기 (RIGHT OUTER JOIN)
-------------------

--1.DEPT1에는 있고, DEPT2에는 없는 데이터 찾기 (LEFT OUTER JOIN)
--ORACLE SQL
SELECT * FROM DEPT1 D1, DEPT2 D2
WHERE D1.ID = D2.ID(+)
AND D2.ID IS NULL;

--표준 SQL
SELECT * FROM DEPT1 D1 LEFT OUTER JOIN DEPT2 D2
ON D1.ID = D2.ID
WHERE D2.ID IS NULL;

--2.DEPT1에는 없고, DEPT2에는 있는 데이터 찾기 (RIGHT OUTER JOIN)
--ORACLE SQL
SELECT * FROM DEPT1 D1, DEPT2 D2
WHERE D1.ID(+) = D2.ID
AND D1.ID IS NULL; 

--표준 SQL
SELECT * FROM DEPT1 D1 RIGHT OUTER JOIN DEPT2 D2
ON D1.ID = D2.ID
WHERE D1.ID IS NULL;

