
------------------------------------------------------------------------------
-------------------------------DDL------------------------------------------
--------------------------------------------------------------------
/*
CREATE

1.테이블 만들기

테이블 = 객체

CREATE TABLE

테이블 DB의 가장 기본적인 객체
테이블 생성은 객체생성

*/
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),  -- 컬럼명 컬럼의 // 데이터타입(데이터크기)
    MEMBER_PWD VARCHAR2(20), -- MEMBER_PWD  // VARCHAR2(20)
    MEMBER_NAME VARCHAR2(20)
);

/*
데이터 타입
문자 : CHAR(크기[바이트/문자]), VARCHAR2(크기[바이트/문자]), NVARCHAR, LOB
    CHAR : 고정 문자열 자료형 (최대 2000byte)
    VARCHAR2 : 가변 문자열 자료형 (최대 40000byte)
    ex. CHAR(10) : 바이트 / CHAR(10char) : 문자
            한글 3글자          한글 10글자
    ex. CHAR(10char)                 VS   VARCHAR2(10) 
    안녕하세요_ _ _ _ _(공백5자리가 유지) //  안녕하세요(공백 유지X)
    → 위의 공백 유지 여부가 CHAR와 VARCHAR2의 차이


    NVARCHAR : 문자 개수 자체를 길이로 계산하는 자료형 --> 다양한 언어가 들어가는 유니코드에 적합
    LOB : CLOB/BLOB 두종류가 있고, 기가까지 저장가능. CLOB을 좀 더 많이 쓴다

숫자 : NUMBER[(P,S)]
크기(길이)를 집어 넣을 수 있는 인자가 있다
    NUMBER : 최고 40자리
    
    NUMBER(크기) : 길이 지정 가능
                P : 최대 자리수 / S : 소수점 자리수
                EX).NUMBER(4,3) --> 최대 4자리수, 소수점 3자리까지 허용
    
날짜 - DATE : 날짜와 시간을 저장하는 날짜형 데이터 타입
    - TIMESTAMP : DATE형 의 확장된 형태로 밀리초 단위까지 표현 가능한 데이터 타입

*실무가면 툴인 developer프로그램보다 cmd창을 더 많이 이용할 것

*/


-- 컬럼에 주석달기
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원 아이디'; 
-- 코드 의미 : MEMEBER테이블 MEMBER_ID라는 컬럼에 '회원 아이디'라고 주석을 달겠다
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원 비밀번호'; 
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원 이름'; 
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원 네임'; -- 덮어씀


-- CMD에서 작성한 테이블 확인 방법
-- 방법1
SELECT * FROM USER_TABLES; -- 사용자가 작성한 테이블을 확인하는 뷰
-- 방법2
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-- 방법3
DESC MEMBER;




------------------------------------------------------------------------------
----------------------------------제약조건(CONSTRAINTS)------------------------
------------------------------------------------------------------------------



/*

<제약조건(CONSTRAINTS)>
테이블 작성 시, 각 컬럼마다 값 기록에 대한 제약 조건 설정 가능
    ex) null 값 받을 수 있는지 여부, 주민번호 Number 타입만 받도록 설정
    
사용목적 : 데이터 무결성 보장
    데이터 무결성이란?
    데이터 정확성, 일관성, 유효성이 유지되는 것


*/

DESC USER_CONSTRAINTS; -- 사용자가 작성한 제약조건 확인 뷰

SELECT * FROM USER_CONSTRAINTS;

/*
-- 제약조건 종류
NOT NULL : 데이터에 NULL 허용 X
UNIQUE : 중복된 값 허용 X
PRIMARY KEY : NOT NULL + UNIQUE ← 고유 식별자로 사용 : 각 컬럼을 식별할 수 있는 고유 식별자
FOREIGN KEY : 외부 테이블에서 참조해 온 컬럼값이 존재하면 허용
CHECK :  데이터 값의 범위나 조건을 지정해 설정한 값만 허용

한 컬럼에 제약조건 여러개 가능



NOT NULL : 데이터에 NULL 허용 X
UNIQUE : 중복된 값 허용 X
PRIMARY KEY : NOT NULL + UNIQUE ← 고유 식별자로 사용 : 각 컬럼을 식별할 수 있는 고유 식별자
    - PRIMARY KEY로 고유 식별자로 사용. 이 지정한 걸로 행 구분이 되기에 중요
FOREIGN KEY : 외부 테이블에서 참조해 온 컬럼값이 존재하면 허용

*/

-- 제약조건 테스트 START
-- 테이블 생성
CREATE TABLE USER_NOCONST(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOCONST VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- 1 행 이(가) 삽입되었습니다.
INSERT INTO USER_NOCONST VALUES(NULL, NULL, NULL, NULL,NULL,NULL,NULL);
-- 1 행 이(가) 삽입되었습니다.
-- 아무런 제약조건이 없기에 데이터 추가가 가능했음


CREATE TABLE P_USER_NOCONST(
    USER_NO NUMBER,
    USER_ID VARCHAR(20),
    USER_PWD VARCHAR(20),
    USER_NAME VARCHAR(20),
    GENDER VARCHAR(20),
    PHONE VARCHAR(20),
    EMAIL VARCHAR(20)
);

INSERT INTO P_USER_NOCONST VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO P_USER_NOCONST VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- 중복 삽입 가능

-- NULL 데이터에 제약조건 설정해보자

CREATE TABLE P_USER_NOTNULL(
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20)NOT NULL,
    USER_PWD VARCHAR2(30)NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR(20),
    PHONE VARCHAR(20),
    EMAIL VARCHAR(20)
);
INSERT INTO P_USER_NOTNULL VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO P_USER_NOTNULL VALUES(NULL, NULL, 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- ORA-01400: cannot insert NULL into ("KH"."P_USER_NOTNULL"."USER_NO")
-- "P_USER_NOTNULL"테이블의 "USER_NO"컬럼에서 NULL CONSTRAINT 조건 때문에 막힘
INSERT INTO P_USER_NOTNULL VALUES(2, 'user02', NULL, '강건강','남','010-1111-2222','kang@k.k');
-- ORA-01400: cannot insert NULL into ("KH"."P_USER_NOTNULL"."USER_PWD")
-- 제약 조건에 NOT NULL 걸어둔게 USER_NAME까지만이라 여기부터는 NULL이어도 삽입가능


-------------------------------------------------------------------------------------------


-- UNIQUE

-- 중복된 값 허용 X
-- 컬럼레벨, 테이블레벨 둘 다 설정가능


--중복제한걸기
CREATE TABLE P_USER_UNIQUE(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE,
    -- 컬럼레벨에서 제약조건 설정함. UNIQUE 제약조건 추가 // 컬럼레벨 : 컬럼에 제약조건 집어 넣은 것
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);
INSERT INTO P_USER_UNIQUE VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');



INSERT INTO P_USER_UNIQUE VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO P_USER_UNIQUE VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- ERROR : ORA-00001: unique constraint (KH.SYS_C007021) violated
-- 유니크 제약조건이 위반됨. SYS_C007021 이부분이 제약조건 이름. 
-- 테이블의 해당 컬럼가서 제약조건 탭에 CONSTRAINT_NAME에 제약조건 이름이 있고 여기서 확인가능
-- DEVELOPER에서는 위처럼 확인가능하고 아래는 CMD


INSERT INTO P_USER_UNIQUE VALUES(2, 'user02', 'pass02', '강건강','남','010-1111-2222','kang@k.k');
-- 1 행 이(가) 삽입되었습니다.


CREATE TABLE P_USER_UNIQUE2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID) -- 테이블 레벨 : 아래에 제약조건 지정하는 것
    -- NOT NULL 제약조건은 테이블 레벨의 제약 조건 설정 불가능 -> 무조건 컬럼 레벨에서만 사용가능
);
INSERT INTO P_USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- 1 행 이(가) 삽입되었습니다.
INSERT INTO P_USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- ORA-00001: unique constraint (KH.SYS_C007049) violated
-- KH계정의 SYS_C007049 제약조건 위반

CREATE TABLE P_USER_UNIQUE3 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO,USER_ID) -- 컬럼 2개를 하나로 묶기
); -- 컬럼1개 지정과 차이가 뭘지 해보자
INSERT INTO P_USER_UNIQUE3 VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO P_USER_UNIQUE3 VALUES(1, 'user02', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO P_USER_UNIQUE3 VALUES(2, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO P_USER_UNIQUE3 VALUES(2, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- ORA-00001: unique constraint (KH.SYS_C007050) violated
-- 위의 3개는 삽입이 잘됬지만 마지막것만 3번줄이랑 겹쳐서 에러
-- UNIQUE(USER_NO,USER_ID)에서 USER_NO,USER_ID 둘을 한세트로 보고 
-- 두 값이 다 같아야 조건이겹치는 걸로 본다.


------------------------------------------------------------------------------
-- < 제약조건 이름짓기>


CREATE TABLE P_CONS_NAME(
    CONS_TEST1 VARCHAR(20) CONSTRAINT PCN_CT1_NN NOT NULL, -- 제약조건 이름 짓기
    CONS_TEST2 VARCHAR(20) CONSTRAINT PCN_CT2_UQ UNIQUE,-- 유니크 컬럼레벨, 테이블레벨 둘 다 설정가능
    CONS_TEST3 VARCHAR(20),
    CONSTRAINT PCN_CT3_UK UNIQUE(CONS_TEST3)-- 유니크 컬럼레벨, 테이블레벨 둘 다 설정가능
);
-- CN_TD1_NN 의미
--    CN : 테이블 이름
--    TD1 : 컬럼 이름
--    NN : (제약조건) NOT NULL 의미
--    UQ(UK) : (제약조건) UNIQUE

INSERT INTO P_CONS_NAME VALUES('Z','A','B');
-- 테이블에서 제약조건 탭에 보면 CONSTRAINT_NAME에 이름이 바뀐 것을 확인할 수 있다

------------------------------------------------------------------------------












