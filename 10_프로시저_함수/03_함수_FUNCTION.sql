/*함수(FUNCTION)
CREATE OR REPLACE FUNCTION FUNCTION1 (
  PARAM1 IN VARCHAR2 --파라미터(옵션)
) RETURN VARCHAR2 --리턴 데이터 타입 선언(필수)
AS 
BEGIN
  RETURN NULL; --리턴값(필수)
END;
----------------------
--리턴 데이터 타입 선언 필요(필수)
RETURN 데이터유형 

--프로그램 마지막(중간)에 값 리턴하는 RETURN문 필요(필수)
RETRUN 리턴값;

************************/
--BOOKID로 책제목 확인 함수(파라미터값:BOOKID, RETURN값 : BOOKNAME)
create or replace FUNCTION GET_BOOKNAME(
    IN_ID IN NUMBER
) RETURN VARCHAR2 --리턴데이터 타입
AS
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
BEGIN
    SELECT BOOKNAME INTO V_BOOKNAME
    FROM BOOK 
    WHERE BOOKID = IN_ID;
    
    RETURN V_BOOKNAME;
END;
--------------------------------
--함수의 사용(SELECT, WHERE 절에서 사용) 
--동작여부 확인용
SELECT GET_BOOKNAME(12) FROM DUAL;
-- SELECT 절에서 사용 
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID) FROM BOOK ORDER BY BOOKID;
-----
SELECT O.*, GET_BOOKNAME(BOOKID) 
AS BOOKNAME FROM ORDERS O;
------------
--WHERE 절에서 함수 사용
SELECT O.*, GET_BOOKNAME(O.BOOKID) AS BOOKNAME FROM ORDERS O
WHERE GET_BOOKNAME(O.BOOKID) LIKE '%축구%';
--=======================================
--(실습) 고객 ID값을 받아서 고객명을 돌려주는 함수 작성(CUSTOMER 테이블 사용) 
-- 함수명 : GET_CUSTNAME
-- GET_CUSTNAME 함수 사용해서 고객명 검색 여부 확인해보기
-------------------
-- ORDERS 테이블 데이터 조회
---- GET_BOOKNAME, GET_CUSTNAME 함수사용 주문(판매)정보와 책제목, 고객명 조회
--------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION GET_CUSTNAME (
    IN_ID NUMBER
) RETURN VARCHAR2
AS
    V_NAME CUSTOMER.NAME%TYPE;
BEGIN
    SELECT NAME INTO V_NAME 
    FROM CUSTOMER
    WHERE CUSTID = IN_ID;
    
    RETURN V_NAME;
END;

-----------------------
-- GET_CUSTNAME 함수 사용해서 고객명 검색 여부 확인해보기
SELECT GET_CUSTNAME(CUSTID) FROM CUSTOMER;
SELECT GET_CUSTNAME(1) FROM DUAL;
SELECT GET_CUSTNAME(3) FROM DUAL;
-- ORDERS 테이블 데이터 조회
SELECT O.*, GET_CUSTNAME(CUSTID) AS NAME FROM ORDERS O;
---- GET_BOOKNAME, GET_CUSTNAME 함수사용 주문(판매)정보와 책제목, 고객명 조회
SELECT GET_CUSTNAME(CUSTID) AS NAME, GET_BOOKNAME(BOOKID) AS BOOKNAME, O.* FROM ORDERS O;

SELECT GET_CUSTNAME(CUSTID) AS NAME, GET_BOOKNAME(BOOKID) AS BOOKNAME, O.* FROM ORDERS O 
WHERE GET_BOOKNAME(BOOKID) LIKE '%축구%';

SELECT GET_CUSTNAME(CUSTID) AS NAME, GET_BOOKNAME(BOOKID) AS BOOKNAME, O.* FROM ORDERS O 
WHERE GET_CUSTNAME(CUSTID) LIKE '김%';
----------------
SELECT O.*, (SELECT BOOKNAME FROM BOOK) AS BOOK_NAME
          , GET_CUSTNAME(O.CUSTID) AS CUST_NAME
        FROM ORDERS O;