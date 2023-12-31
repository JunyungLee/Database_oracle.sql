--(실습)
SELECT ABS (-15) FROM DUAL; --15
SELECT CEIL(15.7) FROM DUAL; --16 <-> FLOOR
SELECT COS(3.14159) FROM DUAL; ---0.99999999999647923060461239250850048324
SELECT FLOOR(15.7) FROM DUAL; --15 <-> CEIL
SELECT LOG(10,100) FROM DUAL; --2
SELECT MOD(11,4) FROM DUAL; --3 (나머지)
SELECT POWER(3,2) FROM DUAL; --9
SELECT ROUND(15.7) FROM DUAL; --16 (자리수 이하 반올림)
SELECT SIGN(-15) FROM DUAL; ---1 (음수, 양수, 0) 
SELECT TRUNC(15.7) FROM DUAL; --15 (소수점 자리 자르기)
SELECT CHR(67) FROM DUAL; --C (ASCII코드 문자 반환) 
SELECT CONCAT('HAPPY', ' Birthday') FROM DUAL; --HAPPY Birthday (문자열 붙이기)
SELECT LOWER('Birthday') FROM DUAL; --birthday 
SELECT LPAD('Page 1', 15, '*.') FROM DUAL; --*.*.*.*.*Page 1
SELECT LTRIM('Page 1', 'ae') FROM DUAL; --Page 1
SELECT REPLACE('JACK', 'J','BL') FROM DUAL; --BLACK
SELECT RPAD('Page 1', 15, '*.') FROM DUAL; --Page 1*.*.*.*.*
SELECT RTRIM('Page 1', 'ae') FROM DUAL; --Page 1
SELECT SUBSTR('ABCDEFG',3,4) FROM DUAL; --CDEF (문자열 일부추출)
SELECT TRIM(LEADING 0 FROM '00AA00') FROM DUAL; --AA00
SELECT UPPER('Birthday') FROM DUAL; --BIRTHDAY
SELECT ASCII('A') FROM DUAL; --65
SELECT INSTR ('CORPORATE FLOOR', 'OR', 3,2) FROM DUAL; --14
SELECT LENGTH('Birthday') FROM DUAL; --8
SELECT SYSDATE, ADD_MONTHS('2014/05/21', 1) FROM DUAL; --2023/08/09 , 2014/06/21
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL; --2023/08/09, 2023/08/31
SELECT SYSDATE, NEXT_DAY(SYSDATE, '화') FROM DUAL; --2023/08/09, 2023/08/15
SELECT SYSDATE, ROUND(SYSDATE) FROM DUAL; --2023/08/09, 2023/08/10 
SELECT SYSDATE, TO_CHAR(SYSDATE) FROM DUAL; --날짜 -> 문자열로 형변환
SELECT '123', TO_CHAR(123) FROM DUAL; -- 숫자 -> 문자열로 형변환
SELECT SYSDATE, TO_DATE('12 05 2014', 'DD-MM-YYYY') FROM DUAL; --2023/08/09 -> 2014/05/12
SELECT '12.3', TO_NUMBER('12.3') FROM DUAL; -- 문자 -> 숫자로 형변환
--DECODE = IF ELSE 와 비슷한 기능 -> EX) DECODE(조건컬럼명, '조건', '조건이 TRUE면 출력', '조건이 FALSE면 출력'(생략가능))
--DECODE 다중 조건 사용  : SELECT DECODE ([조건컬럼], [조건1], [조건1_TRUE], [조건2], [조건2_TRUE]) FROM TABLE; 
SELECT DECODE(1,1,'aa','bb') FROM DUAL; -- aa
--오라클에서 특정값인 경우 NULL로 치환 -> NVL함수와 반대 
--비교값이 같으면 NULL, 다르면 칼럼의 값 반환
SELECT NULLIF(123,345) FROM DUAL; --비교값이 다르기 때문에 칼럼의 값 123 반환
--QUERY NULL처리 : NULL처리 함수 (DATA 값이 NULL 값일때 임의 설정값으로 처리)
SELECT NVL(NULL, 123) FROM DUAL; -- DATA 값: NULL , 임의 설정값 : 123 => 123







