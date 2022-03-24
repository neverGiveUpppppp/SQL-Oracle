/*
------------------------------------------------------------------------------
----------------------------------ALTER --------------------------------------
------------------------------------------------------------------------------

-- ALTER 
객체 수정

컬럼 추가/삭제, 제약조건 추가/삭제, 컬럼 자료형 변경, 디폴트값 변경
테이블명/컬럼명/제약조건명 변경


*/
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------


-- 컬럼 추가/삭제/수정

SELECT * FROM DEPT_COPY; -- DEPT_ID, DEPT_TITLE, LOCATION_ID 조회가능
--컬럼 추가
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20)); 
-- CNAME 컬럼 추가 후 위에서 SELECT로 조회하면 CNAME컬럼 추가된거 확인 가능

ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '한국'); -- DEFAULT로 한국 지정
-- DEFAULT로 한국 지정 : 아무것도 안넣으면 NULL이 아닌 한국으로 값이 잡힘
-- 위에서 SELECT로 조회하면 LCNAME컬럼값이 한국


------------------------------------------------------------------------------


--컬럼 수정

DESC DEPT_COPY; -- 조회 : DEPT_COPY테이블

ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3) -- 자료형 변경
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2) -- 크기 변경
MODIFY CNAME CHAR(25) -- 자료형, 크기 둘 다 한번에 변경가능 // CNAME VARCHAR2(20) -> CHAR(25)
MODIFY LNAME DEFAULT '미국';-- DEFAULT값도 변경가능      // LNAME VARCHAR2(40) -> DEFAULT
-- LNAME은 여전히 한국. 생성할 때 들어간 값이기 때문.
-- 여기서 값을 추가를 하면 그때 바뀌게됨
INSERT INTO DEPT_COPY
VALUES('D10','생산부','L2',NULL,DEFAULT);-- D10이 한국->미국으로 변경

SELECT * FROM DEPT_COPY; -- D10이 한국to미국으로 변경됨

-- 크기 : 16바이트
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);
-- ORA-01441: cannot decrease column length because some value is too big
-- 크기 수정할 때는 안에 데이터의 크기가 어떤지를 보고 수정해야함


------------------------------------------------------------------------------


-- 컬럼 삭제

-- 데이터가 들어있어도 데이터 삭제가능
-- 롤백하더라도 삭제된 컬럼이 복원되지는 않음

-- 테이블에 있는 모든컬럼을 지울수는 없다
-- 테이블에 적어도 1개의 컬럼은 남아있어야함

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;
-- 데이터가 들어있어도 데이터 삭제가능
-- 롤백하더라도 삭제된 컬럼이 복원되지는 않음

/*WHY?
강의시간 12:38-12:40 설명 못들은 부분
DML
크리에이트 알터 드랍은 한번 실행이 되면 바로 커밋이 된다고 생각할 것
바로 확정이 되는거기에 롤백이 먹히지 않는다*/

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;
/*
-- ERROR : ORA-12983: cannot drop all columns in a table
12983. 00000 -  "cannot drop all columns in a table"
*Cause:    An attempt was made to drop all columns in a table.
*Action:   Ensure that at least one column remains in the table after
           the drop column operation.*/
-- 테이블에 있는 모든컬럼을 지울수는 없다
-- 테이블에 적어도 1개의 컬럼은 남아있어야함


CREATE TABLE TB1 (
    PK1 NUMBER PRIMARY KEY,
    COL1 NUMBER,
    CHECK(PK1 > 0 AND COL1 >0 )
);

ALTER TABLE TB1
DROP COLUMN PK1;
/*ORA-12991: column is referenced in a multi-column constraint
12991. 00000 -  "column is referenced in a multi-column constraint"
*Cause:    An attempt was made to drop a column referenced by some
           constraints.
*Action:   Drop all constraints referencing the dropped column or
           specify CASCADE CONSTRAINTS in statement.
*/ -- 제약 조건이 들어가있어 삭제 할 수 없다



------------------------------------------------------------------------------



/*강의시간 12:45-50 코드 확인
*/

ALTER TABLE TB1
DROP COLUMN COL1;


-- 제약 조건과 함께 컬럼 삭제
ALTER TABLE TB1
DROP COLUMN PK1 CASCADE CONSTRAINTS;

SELECT * FROM TB1;



------------------------------------------------------------------------------

-- 제약 조건 추가

-- DEPT_COPY의 DEPT_ID칼럼에 PRIMARY KEY(DCOPY_DID_PK),
-- DPET_TITLE칼럼에 UNIQUE(DCOPY_DTITLE_UQ),
-- LNAME컬럼에 NOT NULL(DCOPY_LNAME_NN) 추가
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_DID_PK PRIMARY KEY(DEPT_ID);
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_DTITLE_UQ UNIQUE(DEPT_TITLE);
ALTER TABLE DEPT_COPY MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;

-- 공통 축약 : ALTER TABLE DEPT_COPY
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_DID_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_DTITLE_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL; -- Table DEPT_COPY이(가) 변경되었습니다.
-- 수정 확인
-- DCOPY_DID_PK	Primary_Key, DCOPY_DTITLE_UQ	Unique, DCOPY_LNAME_NN	Check


------------------------------------------------------------------------------

-- 제약조건 삭제

ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_DID_PK; -- Table DEPT_COPY이(가) 변경되었습니다.


-- 제약조건 한번에 여러개 삭제 + 축약
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_DTITLE_UQ
DROP CONSTRAINT SYS_C007062
MODIFY LNAME NULL; -- LNAME을 NULL로 변경 = 제약조건 삭제
-- 삭제 완료. SYS_C007063	Check 하나 남음


------------------------------------------------------------------------------


SELECT * FROM DEPT_COPY;
-- 컬럼명 변경
-- RENAME A TO B : A를 B로 컬럼명 변경
ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME; -- RENAME A TO B : A를 B로 이름변경

-- 제약조건 이름 변경
ALTER TABLE DEPT_COPY
RENAME CONSTRAINT SYS_C007063 TO DCOPY_LID_NN; -- Table DEPT_COPY이(가) 변경되었습니다.
-- DEPT_COPY테이블의 제약조건명이 SYS_C007063인 데이터의 이름을 DCOPY_LID_NN으로 변경한다는 의미


------------------------------------------------------------------------------


-- 테이블명 변경
ALTER TABLE DEPT_COPY 
--RENAME DEPT_COPY TO DEPT_TEST;
RENAME TO DEPT_TEST;
-- 테이블 이름이 ALTER TABLE 옆에 써있기에 RENAME 다음 테이블명 생략됨


-- 테이블 삭제
-- 테이블만 지우면 제약조건은 남은 채로 테이블만 삭제될 수 있다
DROP TABLE DEPT_TEST
CASCADE CONSTRAINTS; -- 제약조건 같이 삭제하는 코드







------------------------------------------------------------------------------







