
------------------------------------------------------------------------------
-------------------------------DDL------------------------------------------
--------------------------------------------------------------------
/*
CREATE`

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
DB 데이터 타입
1.문자 : CHAR(크기[바이트/문자]), VARCHAR2(크기[바이트/문자]), NVARCHAR, LOB
2.숫자 : NUMBER[(P,S)]
3.날짜 : DATE, TIMESTAMP

1.문자 : CHAR(크기[바이트/문자]), VARCHAR2(크기[바이트/문자]), NVARCHAR, LOB
    CHAR : 고정 문자열 자료형 (최대 2000byte)
    VARCHAR2 : 가변 문자열 자료형 (최대 40000byte)
    ex. CHAR(10) : 바이트 / CHAR(10char) : 문자
            한글 3글자          한글 10글자
    ex. CHAR(10char)                 VS   VARCHAR2(10) 
    안녕하세요_ _ _ _ _(공백5자리가 유지) //  안녕하세요(공백 유지X)
    → 위의 공백 유지 여부가 CHAR와 VARCHAR2의 차이


    NVARCHAR : 문자 개수 자체를 길이로 계산하는 자료형 --> 다양한 언어가 들어가는 유니코드에 적합
    LOB : CLOB/BLOB 두종류가 있고, 기가까지 저장가능. CLOB을 좀 더 많이 쓴다

2.숫자 : NUMBER[(P,S)]
크기(길이)를 집어 넣을 수 있는 인자가 있다
    NUMBER : 최고 40자리
    
    NUMBER(크기) : 길이 지정 가능
                P : 최대 자리수 / S : 소수점 자리수
                EX).NUMBER(4,3) --> 최대 4자리수, 소수점 3자리까지 허용
    
3.날짜 - DATE : 날짜와 시간을 저장하는 날짜형 데이터 타입
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
-- 작성한 전체 테이블 확인 코드 3가지
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
    데이터 무결성(or무결점 integrity constraint)이란?
    데이터 정확성, 일관성, 유효성이 유지되는 것


*/
-- 사용자가 작성한 제약조건 확인 뷰 2가지
DESC USER_CONSTRAINTS; 

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


-- NULL 데이터에 제약조건 설정해보자
CREATE TABLE USER_NOTNULL(
    USER_NO NUMBER NOT NULL, -- 컬럼 옆에 제약조건 설정 : 컬럼 레벨에서 설정했다고 말한다
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOTNULL VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- 1 행 이(가) 삽입되었습니다.
INSERT INTO USER_NOTNULL VALUES(NULL, NULL, NULL, NULL,NULL,NULL,NULL);
-- ERROR : ORA-01400: cannot insert NULL into ("KH"."USER_NOTNULL"."USER_NO")
-- ("KH"."USER_NOTNULL"."USER_NO") 의미 : KH계정에 "USER_NOTNULL"의 테이블에 "USER_NO"컬럼에 삽입 불가
INSERT INTO USER_NOTNULL VALUES(2, NULL, NULL, NULL,NULL,NULL,NULL);
-- ERROR : ORA-01400: cannot insert NULL into ("KH"."USER_NOTNULL"."USER_ID")-- 에러발생지점 : USER_ID
INSERT INTO USER_NOTNULL VALUES(2, 'user02', NULL, NULL,NULL,NULL,NULL);
-- ERROR : ORA-01400: cannot insert NULL into ("KH"."USER_NOTNULL"."USER_PWD")-- 에러발생지점 : USER_PWD
INSERT INTO USER_NOTNULL VALUES(2, 'user02', 'pass02', NULL,NULL,NULL,NULL);
-- ERROR : ORA-01400: cannot insert NULL into ("KH"."USER_NOTNULL"."USER_NAME")-- 에러발생지점 : USER_NAME
INSERT INTO USER_NOTNULL VALUES(2, 'user02', 'pass02', '남나눔',NULL,NULL,NULL);
-- 1 행 이(가) 삽입되었습니다.
-- 제약 조건에 NOT NULL 걸어둔게 USER_NAME까지만이라 여기부터는 NULL이어도 삽입가능


-------------------------------------------------------------------------------------------


-- UNIQUE

-- 중복된 값 허용 X
-- 컬럼레벨, 테이블레벨 둘 다 설정가능

SELECT * FROM USER_NOCONST;
INSERT INTO USER_NOCONST VALUES(1, 'user01','pass01','강건강','남','010-1111-2222','kang@k.k');

--중복제한걸기
CREATE TABLE USER_UNIQUE(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE, -- 컬럼레벨에서 제약조건 설정함. UNIQUE 제약조건 추가 // 컬럼레벨 : 컬럼에 제약조건 집어 넣은 것
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_UNIQUE VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO USER_UNIQUE VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- ERROR : ORA-00001: unique constraint (KH.SYS_C007021) violated
-- 유니크 제약조건이 위반됨. SYS_C007021 이부분이 제약조건 이름. 
-- 테이블의 해당 컬럼가서 제약조건 탭에 CONSTRAINT_NAME에 제약조건 이름이 있고 여기서 확인가능
-- DEVELOPER에서는 위처럼 확인가능하고 아래는 CMD
SELECT *
FROM USER_CONSTRAINTS C1
    JOIN USER_CONSTRAINTS C2 USING(CONSTRATINS_NAME)
WHERE C1.TABLE_NAME = 'USER_UNIQUE';
-- 제약조건명으로 확인하는 방법
SELECT *
FROM USER_CONSTRAINTS C1
    JOIN USER_CONSTRAINTS C2 USING(CONSTRATINS_NAME)
WHERE C1.CONSTRATINS_NAME_NAME = 'SYS_C007021';


-- 2:00 - 2:03 강의시간
-- 내츄럴 조인,CONSTRAINTS C1,C2


INSERT INTO USER_UNIQUE VALUES(2, 'user02', 'pass02', '강건강','남','010-1111-2222','kang@k.k');
-- 1 행 이(가) 삽입되었습니다.


CREATE TABLE USER_UNIQUE2(
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


INSERT INTO USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- 1 행 이(가) 삽입되었습니다.
INSERT INTO USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- ERROR :ORA-00001: unique constraint (KH.SYS_C007022) violated
INSERT INTO USER_UNIQUE2 VALUES(2, 'user02', 'pass02', '강건강','남','010-1111-2222','kang@k.k');
-- 1 행 이(가) 삽입되었습니다.

CREATE TABLE USER_UNIQUE3 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO, USER_ID) -- 컬럼 2개 묶기
);  -- UNIQUE에 컬럼 2개를 같이 묶어서 넣을 때 효과는?
    -- USER_NO, USER_ID인 1,’USER01’을 하나로 보기 때문에 두 조건 다 만족되어야 유니크 제약조건이 발동된다


INSERT INTO USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO USER_UNIQUE2 VALUES(2, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- 아이디가 중복임에도 행 삽입성공
INSERT INTO USER_UNIQUE VALUES(1, 'user02', 'pass02', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO USER_UNIQUE2 VALUES(2, 'user02', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO USER_UNIQUE2 VALUES(2, 'user02', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- ORA-00001: unique constraint (KH.SYS_C007050) violated
-- 위의 3개는 삽입이 잘됬지만 마지막것만 4번줄이랑 겹쳐서 에러
-- UNIQUE(USER_NO,USER_ID)에서 USER_NO,USER_ID 둘을 한세트로 보고 
-- 두 값이 다 같아야 조건이겹치는 걸로 본다.



------------------------------------------------------------------------------
-- < 제약조건 이름짓기>

CREATE TABLE CONS_NAME(
    TEST_DATA1 VARCHAR2(20) CONSTRAINT CN_TD1_NN NOT NULL, -- 제약조건 이름 짓기
    TEST_DATA2 VARCHAR2(20) CONSTRAINT CN_TD2_UQ UNIQUE, -- 유니크 컬럼레벨, 테이블레벨 둘 다 설정가능
    TEST_DATA3 VARCHAR2(20),
    CONSTRAINT CN_TD3_UK UNIQUE(TEST_DATE3) -- 유니크 컬럼레벨, 테이블레벨 둘 다 설정가능
);
-- CN_TD1_NN 의미
--    CN : 테이블 이름
--    TD1 : 컬럼 이름
--    NN : (제약조건) NOT NULL 의미
--    UQ(UK) : (제약조건) UNIQUE

INSERT INTO CONS_NAME VALUES('Z','A','B');


------------------------------------------------------------------------------

-- PRIMARY KEY

-- PRIMARY KEY : NOT NULL + UNIQUE -> 고유 식별자 역할
-- 컬럼레벨, 테이블레벨 둘 다 설정가능
-- NOT NULL + UNIQUE -> **고유 식별자 역할**
-- 한 테이블 당 한번만 설정 가능
--    (고유 식별자는 고유한거니 하나만 가능. 컬럼마다 있다면 고유식별 불가능해지니)

CREATE TABLE USER_PRIMARYKEY (
    USER_NO NUMBER CONSTRAINT UP_UPO_PK PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

--DROP TABLE USER_PRIMARYKEY; -- 잘못만들어서 삭제하고 재생성

INSERT INTO USER_PRIMARYKEY VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO USER_PRIMARYKEY VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- ERROR : ORA-00001: unique constraint (KH.UP_UPO_PK) violated
-- 중복 에러 // 1에 대한 PRIMARY KEY 제약조건 설정했는데 위의 에러메세지는 왜 유니크일까?
INSERT INTO USER_PRIMARYKEY VALUES(NULL, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- ORA-01400: cannot insert NULL into ("KH"."USER_PRIMARYKEY"."USER_NO")
-- NULL에 대한 PRIMARY KEY 제약조건 설정했는데 위의 에러메세지는 왜 NULL일까?

-- PRIMARY KEY에 대한 에러메시지는 유니크,널에 대해 뜨는게 맞다. 둘의 합이기 때문


CREATE TABLE USER_PRIMARYKEY2 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT UP2_UNO_UI_PK PRIMARY KEY(USER_NO, USER_ID) -- 테이블 레벨
);
-- 프라이머리 키 테이블 당 한번만 사용가능
-- 위에 유니크에서 컬럼 2개를 하나로 묶어서 넣었을 때, 두 데이터를 하나로 보고 넣기 때문에 충돌X
-- PRIMARY KEY도 마찬가지

INSERT INTO USER_PRIMARYKEY2 VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO USER_PRIMARYKEY2 VALUES(1, 'user02', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO USER_PRIMARYKEY2 VALUES(2, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
INSERT INTO USER_PRIMARYKEY2 VALUES(2, 'user02', 'pass01', '강건강','남','010-1111-2222','kang@k.k');
-- 중복 없이 4개 다 삽입 성공


------------------------------------------------------------------------------

-- FOREIGN KEY 
-- 참조
-- 외부 테이블에서 참조해 온 컬럼. 이 컬럼값이 존재하면 허용
-- 테이블 레벨, 컬럼 레벨 둘 다 설정가능

-- 부모테이블 : 참조 당하는 테이블
-- 자식테이블 : 참조하는 테이블


CREATE TABLE USER_GRADE (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '일반회원');
INSERT INTO USER_GRADE VALUES(20, '우수회원');
INSERT INTO USER_GRADE VALUES(30, '특별회원');


CREATE TABLE USER_FOREIGNKEY  (
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT UF_GC_FK FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
    -- USER_GRADE(GRADE_CODE)를 참조하고 있는 (GRADE_CODE). FOREIGN KEY를 써서 이부분을 컴에게 인지시킴
);

INSERT INTO USER_FOREIGNKEY VALUES(1, 'user01', 'pass01', '강건강','남','010-1111-2222','kang@k.k',10);
INSERT INTO USER_FOREIGNKEY VALUES(2, 'user02', 'pass02', '남나눔','남','010-1111-2222','nam@k.k',10);
INSERT INTO USER_FOREIGNKEY VALUES(3, 'user03', 'pass03', '도대담','남','010-1111-2222','do@k.k',30);
INSERT INTO USER_FOREIGNKEY VALUES(4, 'user04', 'pass04', '류라라','여','010-1111-2222','ryu@k.k',NULL);
-- 참조하는 테이블(=부모테이블)의 참조 컬럼 값 외에 null 값도 가능
INSERT INTO USER_FOREIGNKEY VALUES(5, 'user05', 'pass05', '문미미','여','010-1111-2222','moon@k.k',50);
-- ERROR : ORA-02291: integrity constraint (KH.UF_GC_FK) violated - parent key not found
-- 무결점 제약조건(integrity constraint)위반 : 부모테이블에 없는 값을 참조해서 에러발생


COMMIT; -- 데이터 확정


DELETE FROM USER_GRADE -- 데이터삭제
WHERE GRADE_CODE = 10;
-- ERROR : ORA-02292: integrity constraint (KH.UF_GC_FK) violated - child record found
-- 무결점 제약조건(integrity constraint)위반 : 자식테이블이 존재해서 지울 수 없다
-- 이유 : GRADE_CODE = 10가 부모테이블이고 얘를 참조하고 있는 자식테이블 때문에 삭제 불가
-- 제약조건이 걸려있으면 삭제 불가

DELETE FROM USER_GRADE -- 데이터삭제
WHERE GRADE_CODE = 20; -- 얘는 삭제 가능
-- 20은 참조하는 자식이 없어서 삭제 가능

ROLLBACK; -- 마지막 COMMIT한 상태로 되돌림
-- 테이블 데이터에서 삭제되고 복구 되는 것을 새로고침해서 확인가능


------------------------------------------------------------------------------

-- <제약조건이 걸려있어도 삭제할 수 있는 방법>
-- ON DELETE SET NULL
-- 부모 키 삭제 시 자식 키를 NULL로 변경

CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE2 VALUES(10, '일반회원');
INSERT INTO USER_GRADE2 VALUES(20, '우수회원'); 
INSERT INTO USER_GRADE2 VALUES(30, '특별회원');

CREATE TABLE USER_FOREIGNKEY2(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT UF2_GC_FK FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL -- ON DELETE SET NULL : 부모 키 삭제 시 자식 키를 NULL로 변경
);/* ERROR 발생
ORA-02264: name already used by an existing constraint
02264. 00000 -  "name already used by an existing constraint"
*Cause:    The specified constraint name has to be unique.
*Action:   Specify a unique constraint name for the constraint.
*/

-- 테이블을 잘못생성해서 사용 :DROP TABLE
-- DROP TABLE USER_FOREIGNKEY2 CASCADE CONSTRAINTS; -- 제약조건까지 같이 지우는 DROP

INSERT INTO USER_FOREIGNKEY2 VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang@k.k', 10);
INSERT INTO USER_FOREIGNKEY2 VALUES(2, 'user02', 'pass02', '남나눔', '남', '010-2222-3333', 'nam@n.n', 10);
INSERT INTO USER_FOREIGNKEY2 VALUES(3, 'user03', 'pass03', '도대담', '남', '010-3333-2222', 'do@d.d', 30);
INSERT INTO USER_FOREIGNKEY2 VALUES(4, 'user04', 'pass04', '류라라', '여', '010-2222-1111', 'ryu@r.r', NULL);

COMMIT; -- 데이터 확정

-- 삽입한 데이터 잘 들어갔는지 확인
SELECT * FROM USER_GRADE2;
SELECT * FROM USER_FOREIGNKEY2;


DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10; -- 1 행 이(가) 삭제되었습니다.
-- 위에 SELECT * FROM USER_GRADE2; 명령문 실행해보면 리스트에서 삭제된 걸 확인가능
-- 위에 SELECT * FROM USER_FOREIGNKEY2; 명령문 실행해보면 10이 들어가있던 값이 삭제됨

-- ON DELETE SET NULL
-- 부모 키 삭제 시 자식 키를 NULL로 변경

/*
-- 코드 꼬이면 써볼 것
-- 일괄 삭제 후 재생성...
DROP TABLE USER_FOREIGNKEY CASCADE CONSTRAINTS;
DROP TABLE USER_FOREIGNKEY2 CASCADE CONSTRAINTS;
DROP TABLE USER_FOREIGNKEY3 CASCADE CONSTRAINTS;
DROP TABLE USER_GRADE CASCADE CONSTRAINTS;
DROP TABLE USER_GRADE2 CASCADE CONSTRAINTS;
DROP TABLE USER_GRADE3 CASCADE CONSTRAINTS;
*/

------------------------------------------------------------------------------


-- ON DELETE CASCADE
-- 부모 키 삭제 시, 자식 키도 함께 삭제

CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
-- 부모테이블 USER_GRADE3에 값 넣기 : INSERT
INSERT INTO USER_GRADE3 VALUES(10, '일반회원');
INSERT INTO USER_GRADE3 VALUES(20, '우수회원');
INSERT INTO USER_GRADE3 VALUES(30, '특별회원');

CREATE TABLE USER_FOREIGNKEY3(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT UF3_GC_FK FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
    -- ON DELETE CASCADE : 부모 키 삭제 시, 자식 키도 함께 삭제
);

INSERT INTO USER_FOREIGNKEY3 VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang@k.k', 10);
INSERT INTO USER_FOREIGNKEY3 VALUES(2, 'user02', 'pass02', '남나눔', '남', '010-2222-3333', 'nam@n.n', 10);
INSERT INTO USER_FOREIGNKEY3 VALUES(3, 'user03', 'pass03', '도대담', '남', '010-3333-2222', 'do@d.d', 30);
INSERT INTO USER_FOREIGNKEY3 VALUES(4, 'user04', 'pass04', '류라라', '여', '010-2222-1111', 'ryu@r.r', NULL);


COMMIT; -- 데이터 확정

-- 삽입한 데이터 잘 들어갔는지 확인
SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FOREIGNKEY3;


DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10; 
-- 위에 SELECT * FROM USER_GRADE3; 명령문 실행해보면 리스트에서 삭제된 걸 확인가능
-- 위에 SELECT * FROM USER_FOREIGNKEY3; 명령문 실행해보면 10이 들어가있던 값이 삭제됨
-- 10이 들어간 데이터가 전부 삭제되어있다



------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- CHECK
-- 
-- 데이터 값의 범위나 조건을 지정해 설정한 값만 허용

CREATE TABLE USER_CHECK(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10)CHECK(GENDER IN('남','여')), -- GENDER에 남과 여만 들어가게 제약조건 생성
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);


INSERT INTO USER_CHECK VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang@k.k');
INSERT INTO USER_CHECK VALUES(2, 'user02', 'pass02', '남나눔', '남자', '010-2222-3333', 'nam@n.n');
-- ERROR : ORA-02290: check constraint (KH.SYS_C007063) violated
-- 원인 : '남'과 '여'만 들어가게끔 제약 걸어놨는데 '남자'를 넣었기에 에러 발생



-- 이번엔 테이블 레이블 넣어보자

CREATE TABLE USER_CHECK2(
    TEST_NUMBER NUMBER,
    CONSTRAINT UC2_TN_CK CHECK(TEST_NUMBER >0 )
);


INSERT INTO USER_CHECK2 VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang@k.k');
INSERT INTO USER_CHECK2 VALUES(2, 'user02', 'pass02', '남나눔', '남자', '010-2222-3333', 'nam@n.n');
-- ERROR : ORA-02290: check constraint (KH.SYS_C007063) violated
-- 원인 : '남'과 '여'만 들어가게끔 제약 걸어놨는데 '남자'를 넣었기에 에러 발생


INSERT INTO USER_CHECK2 VALUES(10);
INSERT INTO USER_CHECK2 VALUES(-1);


-- [실습 문제] --
-- 실습 문제 파일 줄테니 문제 내용은 나중에 복붙하자. 일단 노션 스샷참고
-- 풀어본 것
--CREATE TABLE USER_TEST(
--    USER_NO NUMBER PRIMARY KEY,
--    USER_ID VARCHAR2(20) CONSTRAINT UQ_UT_USERID UNIQUE,
--    USER_PWD VARCHAR2(20) CONSTRAINT NN_UT_USERPWD NOT NULL,
--    PNO VARCHAR2(20)CONSTRAINT UQ_UT_PNO UNIQUE CONSTRAINT NN_UT_PNO NOT NULL ,
--    GENDER VARCHAR2(3)CONSTRAINT CK_UT_GENDER CHECK(GENDER IN('남','여')), -- GENDER에 남과 여만 들어가게 제약조건 생성
--    PHONE VARCHAR2(20) CONSTRAINT AA,
--    ADDRESS VARCHAR2(100)CONSTRAINT  BB,
--    STATUS VARCHAR2(3) CONSTRAINT NN_UT_STATUS NOT NULL CONSTRAINT CK_UT_STATUS CHECK(STATUS IN('Y','N'))
--);    
--INSERT INTO USER_TEST VALUES(1, 'user01', 'pass01', '000101-3010101', '남', '010-1111-2222', '서울','Y');
--INSERT INTO USER_TEST VALUES(2, 'user02', 'pass01', '000101-3010101', '남', '010-1111-2222', '서울','Y');

DROP TABLE USER_TEST CASCADE CONSTRAINTS;

-- 모범 답안
CREATE TABLE USER_TEST(
    USER_NO NUMBER CONSTRAINT PK_UT_USERNO PRIMARY KEY,
    USER_ID VARCHAR2(20) CONSTRAINT UQ_UT_USERID UNIQUE,
    USER_PWD VARCHAR2(20) CONSTRAINT NN_UT_USERPWD NOT NULL, -- 
    PNO VARCHAR2(20)CONSTRAINT NN_UT_PNO NOT NULL, -- 제약조건 2개적용인데 테이블 레벨 이용할 것
    GENDER VARCHAR2(3)CONSTRAINT CK_UT_GENDER CHECK(GENDER IN('남','여')), -- GENDER에 남과 여만 들어가게 제약조건 생성
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(100),
    STATUS VARCHAR2(3) CONSTRAINT NN_UT_STATUS NOT NULL,
    CONSTRAINT UQ_UT_PNO UNIQUE(PNO),
    CONSTRAINT CK_UT_STATUS CHECK(STATUS IN('Y','N'))
);    

COMMENT ON COLUMN USER_TEST.USER_NO IS '회원번호';
COMMENT ON COLUMN USER_TEST.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_TEST.USER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN USER_TEST.PNO IS '주민번호';
COMMENT ON COLUMN USER_TEST.GENDER IS '성별';
COMMENT ON COLUMN USER_TEST.PHONE IS '전화번호';
COMMENT ON COLUMN USER_TEST.ADRESS IS '주소';
COMMENT ON COLUMN USER_TEST.STATUS IS '탈퇴여부';
    
INSERT INTO USER_TEST VALUES(1, 'user01', 'pass01', '000101-3010101', '남', '010-1111-2222', '서울','N');
INSERT INTO USER_TEST VALUES(2, 'user02', 'pass02', '000101-3010102', '남', '010-1111-2222', '서울','N');
INSERT INTO USER_TEST VALUES(3, 'user03', 'pass03', '000101-3010103', '남', '010-1111-2222', '서울','N');
INSERT INTO USER_TEST VALUES(4, 'user04', 'pass04', '000101-3010104', '남', '010-1111-2222', '서울','N');
INSERT INTO USER_TEST VALUES(5, 'user05', 'pass05', '000101-3010105', '남', '010-1111-2222', '서울','N');


SELECT * FROM USER_TEST;




------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- SUBQUERY를 이용한 테이블 생성


CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;


CREATE TABLE EMPLOYE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME 
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYE_COPY2;


------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- ALTER
-- 테이블 수정
-- 테이블 생성 후 제약조건 뒤에 추가 가능

/*
ADD UNIQUE(컬럼명);
ADD PRIMARY KEY(컬럼명);
ADD FOREIGN KEY(참조받을 자식테이블 컬럼명) REFERENCE**S** 부모테이블명(참조할 컬럼명);
MODIFY 컬럼명 NOT NULL;

*/

-- 이미 테이블 만든거에 제약조건 뒤에 추가 가능
-- 삭제 후 재생성인 아닌 추가기능
-- 그럼 이때 제약조건은 어디로 걸까? 컬럼에
-- 컬럼은 테이블 변경과 같은 얘기
-- 테이블은 객체이므로 테이블(=객체) 수정은 ALTER 사용
CREATE TABLE USER_GRADE4(
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(30)
); -- Table USER_GRADE4이(가) 생성되었습니다.
ALTER TABLE USER_GRADE4 ADD PRIMARY KEY(GRADE_CODE);
-- Table USER_GRADE4이(가) 변경되었습니다.

-- 제약조건 이름 테이블 생성 후 추가하고 싶다면?
ALTER TABLE USER_GRADE4 ADD CONSTRAINT UG4_GC_PK PRIMARY KEY(GRADE_CODE);






------------------------------------------------------------------------------


-- 제약조건 이름 테이블 생성 후 추가하고 싶다면?
-- ALTER TABLE 

CREATE TABLE USER_FOREIGNKEY4(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),    -- UNIQUE
    USER_PWD VARCHAR2(30),   -- NOT NUL
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),     -- CHECK
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER        -- FOREIGN KEY
);

ALTER TABLE USER_FOREIGNKEY4 ADD UNIQUE(USER_ID);      -- UNIQUE 제약조건 추가
ALTER TABLE USER_FOREIGNKEY4 MODIFY USER_PWD NOT NULL; -- NOT NULL 같은 경우 MODIFY 뒤에 기술
ALTER TABLE USER_FOREIGNKEY4 ADD CHECK (GENDER IN('남','여'));
ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4(GRADE_CODE);

ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4; --(GRADE_CODE) 삭제
--(GRADE_CODE) 생략
-- 참조하는 테이블에 컬럼명 명시해줘야하는거 아닌가?
-- 생략이 가능한 경우가 있다
-- 조건 : 참조하는 테이블에 PRIMARY KEY를 가지고 참조하면 컬럼명 생략가능

COMMIT;


-- <미니 실습 문제>
-- DEPARTMENT 테이블의 LOCATION_ID에 외래키 제약조건 추가
-- 참조 테이블은 LOCATION, 참조 컬럼은 LOCATION의 기본키


ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);
-- 둘 다 정답


ROLLBACK;



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

/*
DDL(Date Definition language) : 데이터 정의어  - CREATE, ALTER, DROP

DML (Data Manipulation Language) :  데이터 조작어 - INSERT, UPDATE,DELETE,SELECT(DQL)

TCL(Transaction Ccontrol Language) : 트랜잭션 제어 - COMMIT, ROLLBACK





INSERT(데이터 삽입), UPDATE(데이터 수정),DELETE(데이터 삭제),SELECT(DQL)


-- INSERT
데이터 삽입 = 행 추가 → 테이블 행 개수 증가

원래 인서트 뒤에 ()가 들어가야함 . 컬럼 지정

*/

INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,
            SAL_LEVEL, SALARY, BONUS, MANAGER_ID,HIRE_DATE, ENT_YN, ENT_DATE)
VALUES(900,'강건강','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,'N',NULL);                      
            
SELECT * FROM EMPLOYEE;

ROLLBACK;

DELETE
            
-- 테이블의 모든 컬럼에 값을 넣을 때는 컬럼명 명시를 생략 가능            
-- INSERT 시, 컬럼명을 생략하려면 테이블에 있는 컬럼 순서를 정확히 지켜서 넣어야 함
INSERT INTO EMPLOYEE -- 컬럼명 명시부분 삭제
VALUES(900,'강건강','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,'N',NULL);            
-- ORA-01841: (full) year must be between -4713 and +9999, and not be 0
-- 원인 : ENT_YN,ENT_DATE의 순서를 바꿔서 에러발생
-- 컬럼명을 명시하는 경우에는 명시한 순서를 따라 데이터를 넣으면 되고, 
-- 생략 시에는 테이블에 있는 컬럼명 순서을 따라야 한다        
        
        
INSERT INTO EMPLOYEE -- 컬럼명 명시부분 삭제
VALUES(900,'강건강','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,NULL,'N');          
        
SELECT * FROM EMPLOYEE;
COMMIT;
     

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_01(EMP_ID,EMP_NAME) VALUES(999,'남나눔'); 
-- 테이블의 컬럼 전부가 아닌 원하는 데이터만 삽입가능
SELECT * FROM EMP_01;
-- 데이터 조회 결과 : 999	남나눔 (NULL) <- DEPT_TITLE에 부서명 안넣어둬서 NULL

-- 서브쿼리로 INSERT하기
INSERT INTO EMP_01(
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE
            LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);
SELECT * FROM EMP_01; -- 25행


------------------------------------------------------------------------------
--참조:5.1. SQL 활용 (자체교재)


-- INSERT ALL
-- INSERT 시 서브쿼리가 사용하는 테이블이 같은 경우 한 번에 삽입 가능
-- 예시 2개

-- WHEN 절에 지정한 조건을 만족하는 데이터를 테이블을 지정해 삽입
        
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID,EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0; 
-- WHERE절 : 조건을 받는 곳. 1 = 0이라는건 1이 0이 아니기에 결과값은 FALSE
-- 결과값이 FALSE이기에 선택된 컬럼만 있고 데이터는 없는 상태인 것
-- 즉, WHERE절의 1=0 조건을 만족하는 행이 없으므로, 비어있는 테이블이 생성된다
-- 이 코드를 쓰는 목적 : 데이터는 필요 없이 구조만 따고 싶을 때

SELECT * FROM EMP_DEPT_D1;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0; -- 구조만 따옴

SELECT * FROM EMP_MANAGER;



-- EMP_DEPT_D1 테이블에 EMPLOYEE 테이블에 있는 부서코드가 D1인 직원을 조회해
-- 사번, 이름, 소속부서, 입사일 삽입
-- EMP_MANAGER테이블에 EMPLOYEE 테이블ㅇ 있는 부서코드가 D1인 직원을 조회해
-- 사번, 이름, 관리자 사번 삽입

INSERT INTO EMP_DEPT_D1(
            SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
            FROM EMPLOYEE
            WHERE DEPT_CODE = 'D1');
INSERT INTO EMP_MANAGER(
            SELECT EMP_ID, EMP_NAME,MANAGER_ID
            FROM EMPLOYEE
            WHERE DEPT_CODE = 'D1');

SELECT * FROM EMP_DEPT_D1;
SELECT * FROM EMP_MANAGER;
-- 위는 INSERT로 데이터를 각각 넣은 것
ROLLBACK;

INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME,MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID -- 서브쿼리
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
-- INSERT ALL + SUBQUERY로 위 문제의 두 테이블을 한번에 추가    
-- INSERT ALL 각 테이블 조건에 맞게 INSERT



-- EMPLOYEE테이블의 구조를 복사하여 사번, 이름, 입사일, 급여를 기록할 수 있는
-- 테이블 EMP_OLD와 EMP_NEW 생성
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;


-- EMPLOYEE테이블의 입사일 기준으로 2000년 1월 1일 이전에 입사한 사원의
-- 사번, 이름, 입사일, 급여는 EMP_OLD테이블에,
-- 2000년 1월 1일 이후에 입사한 사원의 사번, 이름, 입사일, 급여는 EMP_NEW테이블에 삽입
-- 방법1 : 각각 INSERT
-- 방법2 : INSERT ALL

-- INSERT ALL 방법1
INSERT ALL -- 두 테이블 조건이 달라서 WHEN을 한번에 묶을 수가 없다
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

-- INSERT ALL 방법2
INSERT ALL -- 두 테이블 조건이 달라서 WHEN을 한번에 묶을 수가 없다
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
ELSE -- 조건이 이전 아니면 이후이기에 ELSE처리 가능
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
-- SELECT * -- VALUES에서 컬럼명 지정하기 때문에 SELECT * 지정도 문제X
FROM EMPLOYEE;


COMMIT;


------------------------------------------------------------------------------
---------------------------------UPDATE--------------------------------------
------------------------------------------------------------------------------


-- UPDATE

-- 수정
-- 데이터 수정이라 전체 행에는 변화X

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;


--DEPT_COPY테이블에서 DEPT_ID가 D9인 행의 DEPT_TITLE을 전략기획팀으로 수정
UPDATE DEPT_COPY -- 뭘 수정할지?
SET DEPT_TITLE = '전략기획팀' -- 어떻게 수정할지?
WHERE DEPT_ID = 'D9';
-- D9가 총무부에서 전략기획팀으로 변경됨



------------------------------------------------------------------------------






------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------






























