SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG FROM STUDENT ORDER BY ID;

SELECT * FROM STUDENT ORDER BY ID;
--UPDATE
SELECT * FROM STUDENT WHERE ID = '2023002';
UPDATE STUDENT
    SET NAME = '홍길동UPD'
        , KOR = 99
        , ENG = 97
        , MATH = 86
WHERE ID = '2023002';
--DELETE
DELETE FROM STUDENT
WHERE ID = '2023005';

------------------------

SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG
FROM STUDENT 
WHERE ID ='2023001'
;
SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG
FROM STUDENT 
WHERE ID ='2023002'
;
SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG
FROM STUDENT 
WHERE ID ='2023003';
-----------------------------
--PREPARED STATEMENT 방식 
SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG
FROM STUDENT 
WHERE ID =:id
;
