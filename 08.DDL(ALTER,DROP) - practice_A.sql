/*
------------------------------------------------------------------------------
----------------------------------ALTER --------------------------------------
------------------------------------------------------------------------------

-- ALTER 
객체 수정

컬럼 추가/삭제, 제약조건 추가/삭제, 컬럼 자료형 변경, 디폴트값 변경
테이블명/컬럼명/제약조건명 변경


*/

-- 컬럼 추가/삭제/수정

SELECT * FROM UC;

-- 추가
ALTER TABLE UC ADD (PHONE NUMBER);
ALTER TABLE UC ADD (NATIONALITY VARCHAR2(20) DEFAULT '한국');
-- 컬럼 PHONE, NATIONALITY 추가완료. NATIONALITY 지정안하면 기본값으로 한국


DESC UC;
-- 수정
ALTER TABLE UC
MODIFY USER_ID VARCHAR2(30)
MODIFY GENDER CHAR(3) -- ERROR : ORA-01441: cannot decrease column length because some value is too big
MODIFY NATIONALITY DEFAULT '미국';  -- 바꿀 자료형의 크기가 들어있는 데이터보다 작으면 에러

-- 삭제
ALTER TABLE UC
DROP COLUMN PHONE; -- PHONE 컬럼 삭제


-- 제약 조건과 함께 컬럼 삭제
ALTER TABLE UC
DROP COLUMN USER_NAME CASCADE CONSTRAINT;

DESC UC;

------------------------------------------------------------------------------
------------------------------------------------------------------------------

ALTER TABLE TB1
DROP COLUMN COL1;


-- 제약 조건과 함께 삭제
ALTER TABLE TB1
DROP COLUMN PK1 CASCADE CONSTRAINTS;

SELECT * FROM TB1;

-- 제약 조건 추가
ALTER TABLE UC ADD CONSTRAINT UC_GEN_UQ UNIQUE(GENDER);

-- 제약조건 삭제
ALTER TABLE UC DROP CONSTRAINT UC_GEN_UQ;

-- 제약조건 한번에 여러개 삭제
ALTER TABLE UC
DROP CONSTRAINT SYS_C007129
DROP CONSTRAINT SYS_C007130
DROP CONSTRAINT SYS_C007127; -- GENDER의 CHECK 남여조건 빼고 제약조건 다 삭제

-- 컬럼명 변경
-- RENAME A TO B : A를 B로 컬럼명 변경
ALTER TABLE UC
RENAME COLUMN GENDER TO GENDER2;
ALTER TABLE UC
RENAME COLUMN GENDER2 TO GENDER;

-- 제약조건 이름 변경
ALTER TABLE UC
RENAME CONSTRAINT SYS_C007128 TO UC_CHECK1; 

DESC UC;
------------------------------------------------------------------------------

--테이블명 변경
ALTER TABLE DEPT_COPY
RENAME TO DEPT_COPY2;

--테이블 삭제
DROP TABLE DEPT_COPY;
--테이블+제약조건 삭제
DROP TABLE DEPT_COPY
CASCADE CONSTRAINTS;

------------------------------------------------------------------------------



------------------------------------------------------------------------------

