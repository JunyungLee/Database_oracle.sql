--TABLE JOIN : 2개 이상의 테이블 데이터를 연결해서 1개의 테이블인것처럼 사용
SELECT * FROM CUSTOMER WHERE CUSTID = 1; --박지성
SELECT * FROM ORDERS WHERE CUSTID = 1; 

--CUSTOMER, ORDERS TABLE 데이터 동시 조회(검색) 
--(주의) SELECT절에 동일 컬럼명 2개가 올 수 없다. 별칭 사용해서 다른이름으로 변경 처리 (AS OR  )
SELECT * FROM CUSTOMER, ORDERS --조인테이블
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --조인조건 
  AND CUSTOMER.NAME = '박지성'; --선택조건(찾을조건)  
--------------------
--테이블 별칭(alias) 사용 : 테이블명을 간단하게 사용하기
--(주의) 테이블 별칭 사용시 테이블명 대신 반드시 별칭을 사용해야 한다 
SELECT * FROM CUSTOMER C , ORDERS O --조인테이블에 대한 별칭(alias) 사용
WHERE C.CUSTID = O.CUSTID --조인조건
AND C.NAME = '박지성'; -- 선택조건(찾을조건) : UNIQUE COLUMN = 별칭 사용 생략 가능 

--표준 조인 쿼리문 
SELECT * FROM CUSTOMER C INNER JOIN ORDERS O --조인테이블
              ON C.CUSTID = O.CUSTID --조인조건
    WHERE C.NAME = '박지성'; --선택조건(찾을조건)
-----



