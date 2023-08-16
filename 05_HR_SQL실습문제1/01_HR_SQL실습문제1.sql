/* ** 실습문제 : HR유저(DB)에서 요구사항 해결 **********
--1) 사번(employee_id)이 100인 직원 정보 전체 보기
--2) 월급(salary)이 15000 이상인 직원의 모든 정보 보기
--3) 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
--4) 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
--5) 이름(first_name)이 john인 사원의 모든 정보 조회
--6) 이름(first_name)이 john인 사원은 몇 명인가?
--7) 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
--8) 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
--9) 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
--10) 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
---------------------------------
--11) 직종별 최대 월급여 검색
--12) 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
--13) 직종별 평균급여 이상인 직원 조회
*****************************/
SELECT * FROM EMPLOYEES;
--1) 사번(employee_id)이 100인 직원 정보 전체 보기
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

--2) 월급(salary)이 15000 이상인 직원의 모든 정보 보기
SELECT * FROM EMPLOYEES WHERE SALARY >= 15000;

--3) 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY FROM EMPLOYEES WHERE SALARY >= 15000;

--4) 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY FROM EMPLOYEES WHERE SALARY <= 10000
ORDER BY SALARY DESC;

--5) 이름(first_name)이 john인 사원의 모든 정보 조회
---------JOHN, John, john --------------
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = INITCAP('JOHN'); --데이터가 표준화 된 경우 입력값을 동일한 형태로 
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'John';

--6) 이름(first_name)이 john인 사원은 몇 명인가?
SELECT COUNT(*) FROM EMPLOYEES WHERE FIRST_NAME = 'John';

--7) 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
SELECT * FROM EMPLOYEES WHERE HIRE_DATE 
BETWEEN TO_DATE('2008/01/01','YYYY/MM/DD') AND TO_DATE('2008/12/31','YYYY/MM/DD') 
ORDER BY HIRE_DATE;

SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME, SALARY , HIRE_DATE 
FROM EMPLOYEES 
WHERE TO_CHAR(HIRE_DATE,'YYYY') = '2008'
ORDER BY HIRE_DATE;

SELECT  EMPLOYEE_ID,CONCAT(FIRST_NAME, LAST_NAME), SALARY FROM EMPLOYEES
WHERE HIRE_DATE LIKE '2008%' ;

--8) 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME, SALARY , HIRE_DATE 
FROM EMPLOYEES 
WHERE SALARY >=20000 AND SALARY <= 30000
ORDER BY HIRE_DATE;

SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME, SALARY , HIRE_DATE 
FROM EMPLOYEES 
WHERE SALARY BETWEEN 20000 AND 30000
ORDER BY HIRE_DATE;

SELECT EMPLOYEE_ID, SALARY, CONCAT(LAST_NAME,FIRST_NAME) FROM EMPLOYEES 
WHERE SALARY >=20000 AND SALARY <= 30000;

--9) 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NULL;

--10) 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
SELECT MAX(SALARY)FROM EMPLOYEES WHERE JOB_ID ='IT_PROG';

------------------------
--11) 직종별 최대 월급여 검색
SELECT JOB_ID, MAX(SALARY) AS MAX 
FROM EMPLOYEES 
GROUP BY JOB_ID
ORDER BY MAX(SALARY);

SELECT JOB_ID, COUNT(*) AS COUNT, SUM(SALARY) AS SUM, AVG(SALARY) AS AVG, MIN(SALARY) AS MIN ,MAX(SALARY) AS MAX 
FROM EMPLOYEES 
GROUP BY JOB_ID
ORDER BY MAX(SALARY);

-- +)조인 활용도 가능 
SELECT E.JOB_ID ,J.MAX_SALARY 
FROM EMPLOYEES E JOIN JOBS J ON E.JOB_ID = J.JOB_ID
ORDER BY JOB_ID;

--12) 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
SELECT JOB_ID, MAX(SALARY) AS MAX 
FROM EMPLOYEES 
GROUP BY JOB_ID
HAVING MAX(SALARY) >= 10000
ORDER BY MAX(SALARY);

--13) 직종별 평균급여 이상인 직원 조회
SELECT JOB_ID, AVG(SALARY) AVG_SALARY
FROM EMPLOYEES GROUP BY JOB_ID;

-----조인(직원테이블 + 직종별 평균급여)
--별칭 필수-> 오류 x
SELECT E.EMPLOYEE_ID, E.SALARY, J.* FROM
(SELECT JOB_ID, AVG(SALARY) AS AVG FROM EMPLOYEES GROUP BY JOB_ID) J  --서브쿼리 :가상테이블(인라인 뷰)
INNER JOIN EMPLOYEES E ON J.JOB_ID =  E.JOB_ID  --조인조건
WHERE J.AVG <= E.SALARY --검색(선택)조건
ORDER BY J.JOB_ID
;

--서브쿼리 방식으로 찾기 
SELECT * 
FROM EMPLOYEES
WHERE SALARY >= (6461)
ORDER BY SALARY;

--상관 서브쿼리 방식으로 찾기 
SELECT * 
FROM EMPLOYEES E
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = E.JOB_ID)
ORDER BY SALARY;

SELECT AVG(SALARY) FROM EMPLOYEES; --회사평균급여
