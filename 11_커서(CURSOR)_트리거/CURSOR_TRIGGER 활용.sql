-- CURSOR
SELECT ORDERID
      ,GET_BOOKNAME(BOOKID) AS BOOKNAME
      ,GET_CUSTNAME(CUSTID) AS NAME,
      SALEPRICE, ORDERDATE
FROM ORDERS
ORDER BY ORDERID DESC;


-- TRIGGER
-----------------------------------------------------
--INSERT 동작확인 테스트 
SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT * FROM BOOK_LOG;
--INSERT TRIGGER 동작 여부 확인 
INSERT INTO BOOK VALUES(30,'데이터베이스의 이해', 'ITBOOK',25000);
ROLLBACK; --입력 취소하면 트리거에 의해 입력된 LOG 데이터도 함께 취소처리

INSERT INTO BOOK VALUES(30,'데이터베이스의 이해', 'ITBOOK',25000);
COMMIT; --입력 작업 확정
INSERT INTO BOOK VALUES(31,'데이터베이스의 이해2','ITBOOK',30000);
COMMIT;
---------------------------------------
--UPDATE 동작확인 테스트 
SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT * FROM BOOK_LOG;
UPDATE BOOK 
    SET BOOKNAME = '오라클 '|| BOOKNAME
        ,PUBLISHER = 'IT_BOOK'
        ,PRICE = PRICE + 10000
WHERE BOOKNAME LIKE '%데이터베이스%';
COMMIT;
-----------------------------------
--DELETE 동작확인 테스트 
SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT * FROM BOOK_LOG;
DELETE BOOK 
WHERE BOOKNAME LIKE '%데이터베이스%';
COMMIT;


