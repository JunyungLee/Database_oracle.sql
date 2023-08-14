/* *************************
데이터 정의어
- DDL(Data Definition Language) : 데이터를 정의하는 언어
- CREATE(생성), DROP(삭제), ALTER(수정)
- {}반복가능, []생략가능, | 또는(선택) = or
CREATE TABLE 테이블명 (
    {컬럼명 데이터 타입 (데이터 타입 <-크기 지정도 가능
    // column명, 데이터 타입 : 자바와 반대) 
        [NOT NULL | UNIQUE | DEFAULT 기본값 | CHECK 체크조건]
    }
    [PRIMARY KEY 컬럼명] 
    {[FOREIGN KEY 컬럼명 REFERENCES 테이블명(컬럼명)]
    [ON DELETE [CASCADE | SET NULL]
    }
);
-----------------------------------------------
<제약조건 5종류>
- NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
-----------------------------------------------
컬럼의 기본 데이터 타입(문자열, 숫자, 날짜)
- VARCHAR2(n) : 문자열 가변길이
- CHAR(n) : 문자열 고정길이
- NUMBER(p, s) : 숫자타입 p:전체길이, s:소수점이하 자리수
    예) (5,2) : 정수부 3자리, 소수부 2자리 - 전체 5자리
- DATE : 날짜형 년,월,일 시간 값 저장

문자열 처리 : UTF-8 형태로 저장
- 숫자, 알파벳 문자, 특수문자 : 1 byte 처리(키보드 자판 글자들)
- 한글 : 3 byte 처리
***************************/

/******************************************
제약조건 (Constraint) 
- 올바른 데이터만 들어오게 해주기 위해 사용(잘못된 데이터는 못들어 차단-에러발생)
- 데이터의 정확성과 일관성을 보장하기 위해 각 칼럼에 정의하는 규칙
- 딕셔너리에 저장됨
- 테이블 생성시 무결성 제약조건을 정의하여 프로그래밍 과정을 단순화
- 데이터베이스 서버에 의해 무결성 제약조건이 관리되어 데이터 오류 발생 가능성을 줄여줌
- 일시적으로 활성화(ENABLE) 또는 비활성화(DISABLE) 할 수 있다.

<제약조건 5종류>
- NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
1. NOT NULL : Null값 포함할수 없음
2. UNIQUE : 중복되는 값 오면 안됨
    (중복되는 것 없어야 하므로, 서버프로세스가 기존 데이터를 찾아야 한다. 오래걸림 - 해결 : 인덱스)
3. CHECK : 해당 칼럼에 저장 가능한 데이터 값의 범위나 조건 지정
4. PRIMARY KEY(기본키) : 고유 값 (NOT NULL + 유니크)
5. FOREIGN KEY(외래키-참조) : 해당 칼럼 값은 참조되는 테이블의 칼럼 값 중 하나와 일치하거나 Null을 가짐
    - 자식 테이블 : 다른 테이블의 값을 참조하는 테이블
    - 외래키(foreign key): 부모테이블의 값을 참조하는 자식테이블의 칼럼
    - 부모 테이블 : 다른 테이블에 의해 참조되는 테이블
    - 참조키(reference : 자식 테이블에서 참조하는 부모 테이블의 칼럼
************************************************/
--DDL문 사용 테이블 생성
CREATE TABLE MEMBER ( -- 테이블 저장공간 정의 (DEFINITION) 
    ID VARCHAR2 (20) PRIMARY KEY, --NOT NULL + UNIQUE : 둘다 적용 //컬럼명 + 데이터 타입 + 크기지정
    NAME VARCHAR2(30) NOT NULL, 
    PASSWORD VARCHAR2 (20) NOT NULL, 
    PHONE VARCHAR2 (20), 
    ADDRESS VARCHAR2 (300)
);
---
--DML : INSERT, UPDATE, DELETE, SELECT 
--테이블 컬럼명을 명시적으로 지정해서 데이터 입력
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG', '홍길동', '1234');

--DCL : ROLLBACK, COMMIT
--ROLLBACK; -- 임시 처리된 작업 취소 처리 
COMMIT; --임시 처리된 작업 최종 적용

------------------------------
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG2', '홍길동2', '1234'); --unique constraint (MYSTUDY.SYS_C006999) violated
COMMIT;

--키중복 데이터 입력시 : ORA-00001: unique constraint (MYSTUDY.SYS_C006999) violated
--INSERT INTO MEMBER (ID, NAME, PASSWORD)--> HONG 이름 이미 있기 때문에 안됨 (KEY 중복)
--VALUES ('HONG', '홍길동2', '1234');

--제약조건 NOTNULL COLUMN DATA 미입력 오류
INSERT INTO MEMBER (ID, NAME)
VALUES('HONG3', '홍길동3'); 
--문법적으로는 오류가 없지만 cannot insert NULL into ("MYSTUDY"."MEMBER"."PASSWORD")
--MYSTUDY에 있는 MEMBER에 있는 PASSWORD가 NULL이 입력되어 있지 않음
---------------------------------------------------------------------------------
SELECT * FROM MEMBER; -- TABLE에 있는 모든 DATA + 모든 COLUMN = SELECT ALL FROM MEMBER; *: WILD CARD
SELECT ID,PASSWORD, NAME, PHONE FROM MEMBER; --TABLE 작성시 순서 상관없음
---------
-- 입력 : 컬럼명 명시적으로 쓰지 않고 INSERT문 작성
-- 테이블 모든 컬럼 사용 + 컬럼 순서대로 데이터 입력 (테이블 생성시점의 순서) 
INSERT INTO MEMBER 
VALUES('HONG3','홍길동3','1234','010-1234-1234','서울');
COMMIT;

INSERT INTO MEMBER
VALUES('HONG4','홍길동4','1234','서울시','010-1234-1234'); --데이터 잘못 입력 (TYPE과 크기만 체크하기 때문) 
COMMIT;
----------------------
--COLUMN을 명시적으로 작성 시 해당 COLUMN에 1:1 매칭 되어 데이터 입력
INSERT INTO MEMBER(ID, NAME, PASSWORD, ADDRESS, PHONE)
VALUES ('HONG5','홍길동5','1234','010-1111-1111','서울시');
COMMIT;

SELECT * FROM MEMBER;
-----------
--수정1 : HONG4 전화번호 '010-1111-1234' 변경
--수정2 : HONG4 주소 '서울시'로 변경
--수정/삭제 : WHERE절 필수!
SELECT * FROM MEMBER WHERE ID = 'HONG4';
UPDATE MEMBER SET PHONE = '010-1111-1234' WHERE ID = 'HONG4';
UPDATE MEMBER SET ADDRESS = '서울시' WHERE ID = 'HONG4';
COMMIT;
--------------------
--SQL 작성 형식 1 -맨 앞에 일치시키기
UPDATE MEMBER 
SET PHONE = '010-1111-1234' 
    ADDRESS = '서울시';
WHERE ID = 'HONG4'
; 
-- SQL 작성 형식 2 - SQL 내용 시작위치에 일치시키기
UPDATE MEMBER
   SET PHONE = '010-1111-1234',
       ADDRESS = '서울시'
 WHERE ID = 'HONG4'
;
-- SQL 작성 형식 3 - 탭 또는 일정간격 들여쓰기
UPDATE MEMBER
    SET PHONE = '010-1111-1234'.
        ADDRESS = '서울시'
    WHERE ID = 'HONG4' 
;    
-----------------
--삭제 :HONG5 데이터 삭제 
SELECT * FROM MEMBER WHERE ID = 'HONG5';
DELETE FROM MEMBER WHERE ID = 'HONG5';
COMMIT;
--------
SELECT * FROM MEMBER WHERE NAME = '홍길동';
UPDATE MEMBER 
SET NAME = '홍길동'
WHERE ID = 'HONG4'
;
COMMIT;
--삭제 : 이름이 '홍길동'인 사람 삭제 
SELECT * FROM MEMBER WHERE NAME = '홍길동';
DELETE FROM MEMBER WHERE NAME = '홍길동';
COMMIT;
--=====================================
/* (실습) 입력, 수정, 삭제, 조회(검색)
■입력
 - 아이디: HONG8
 - 이름: 홍길동8
 - 암호: 1111 
 - 주소: 서울시 강남구
■조회(검색) : 이름이 '홍길동8'인 사람의 아이디, 이름, 주소, 전화번호 조회
■수정 : 아이디가 HONG8 사람의
    전화번호 : 010-8888-8888
    암호 : 8888
    주소 : 서울시 강남구 역삼동
■ 삭제 : 아이디가 HONG2 인 사람    
********************************/
--입력 (INSERT)
INSERT INTO MEMBER (ID, NAME, PASSWORD,ADDRESS)
VALUES ('HONG8', '홍길동8', '1111', '서울시 강남구');
COMMIT;

--조회 (SELECT)
SELECT * FROM MEMBER WHERE NAME = '홍길동8';

--수정 (UPDATE)
SELECT *FROM MEMBER WHERE NAME = '홍길동8';
UPDATE MEMBER SET PHONE = '010-8888-8888',
                  PASSWORD = '8888',
                  ADDRESS = '서울시 강남구 역삼동'
WHERE NAME = '홍길동8';
COMMIT;

--삭제(DELETE)
SELECT * FROM MEMBER WHERE ID = 'HONG2';
DELETE FROM MEMBER WHERE ID = 'HONG2';
COMMIT;
















