------------------------------------------------------------------------------
---------------------------------TRIGGER--------------------------------------
------------------------------------------------------------------------------

-- TRIGGER

-- 테이블이나 뷰가 DML(INSERT, UPDATE, DELETE)에 의해 변경될 경우 
-- 자동으로 실행될 내용을 저장한 '객체'

-- 방아쇠가 당기면 또 다른 일을 진행하는 것

-- 참조 관계에 있는 두 테이블에서 하나의 테이블에 삽입,삭제,갱신 등의 연산으로 
-- 테이블의 내용이 바뀌었을 때 데이터의 일관성과 무결성 유지를 위해서 
-- 이와 관련된 테이블도 연쇄적으로 변경이 이루어질 수 있도록 하는 것을 말한다.


/*

-- 종류
SQL문의 실행 시기에 따른 분류
    BEFORE TRIGGER : SQL문 실행 전 트리거 실행
    AFTER  TRIGGER : SQL문 실행 후 트리거 실행
SQL문의 영향을 받는 ROW에 따른 분류
    STATEMENT TRIGGER : DEFAULT TIGGER, 전체적으로 한 번만 진행
    ROW TRIGGER : SQL문 각 ROW에 한 번씩 실행 // 각 행만 진행
        FOR EACH ROW 옵션 작성해야 인식
            OLD 참조 전의 열의 값 ex)UPDATE 전의 데이터, DELETE를 할 자료
            NEW 참조 후의 열의 값 ex)UPDATE 후의 데이터, INSERT를 할 자료


-- 표현식

CREATE [OR REPLACE] TRIGGER 트리거명 
BEFORE | AFTER -- SQL 실행 전일지 후일지 지정
INSERT| UPDATE | DELETE  -- UPDATE 전인지 후인지 등
ON 테이블명
[FOR EACH ROW] -- STATEMENT인지 ROW TRIGGER인지 지정
[WHEN 조건]

DECLARE
    선언부
BEGIN
    실행부
EXCEPTION
    예외처리부
END;
/

[] : 생략가능

*/
------------------------------------------------------------------------------


-- EMPLOYEE테이블에 사원이 추가되면 '신입사원이 입사했습니다'라는 
-- 문구를 자동 출력하는 TRG_01 트리거 생성
-- 사원 추가되면 //' ' 문장 자동 출력 //트리거 생성

CREATE OR REPLACE TRIGGER TRG_01
AFTER -- 뭐에 대한 애프터? INSERT 
INSERT -- 어디에 대한 INSERT AFTER? 
ON EMPLOYEE
-- CREATE OR REPLACE TRIGGER TRG_01
-- AFTER INSERT ON EMPLOYEE
BEGIN
     DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다');
END;
/
-- TRIGGER 생성

INSERT INTO EMPLOYEE VALUES(908,'남나눔','740214-1210121','nam@n.n','01022223333',
                            'D5','J3','S5',3000000,0.1,200,SYSDATE,NULL,DEFAULT);
                            
SELECT * FROM EMPLOYEE; -- 908 추가됬는지 확인       

/*
강의시간 4:10-20
트리거가 많이 사용되는 부분이 있음
변화

입출고에서 많이사용
재고해서 +10
출고 -5
대표적이고 널리쓰임

*/
-- 상품 정보 테이블
CREATE TABLE PRODUCT(
    PCODE NUMBER PRIMARY KEY, -- 상품 코드
    PNAME VARCHAR2(30),       -- 상품 이름
    BRAND VARCHAR2(30),       -- 브랜드  
    PRICE NUMBER,             -- 가격
    STOCK NUMBER DEFAULT 0    -- 재고
);
-- 입출고 상세 이력 테이블
CREATE TABLE PRO_DETAIL(
    DCODE NUMBER PRIMARY KEY,   -- 상세 코드
    PCODE NUMBER,               -- 상품 코드
    PDATE DATE,                 -- 상품 입출고일
    AMOUNT NUMBER,              -- 입출고 개수
    STATUS VARCHAR2(10) CHECK(STATUS IN('입고','출고')), -- 상태
    FOREIGN KEY(PCODE) REFERENCES PRODUCT
);

-- PK 고유식별자용 시퀸스 생성
CREATE SEQUENCE SEQ_PCODE;
CREATE SEQUENCE SEQ_DCODE;

INSERT INTO PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '꼬깔콘','롯데',2000,DEFAULT);
INSERT INTO PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '홈런볼','해태',2500,DEFAULT);
INSERT INTO PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '포켓몬빵','삼립',1500,DEFAULT);
    
SELECT * FROM PRODUCT;

-- 입고되면 입고한 만큼 STOCK 증가
-- 출고되면 출고한 만큼 STOCK 감소
-- 트리거를 안쓰면 매 주문마다 변동한 만큼 업뎃 구문 만들어야함

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON PRO_DETAIL -- 입출고 행이 추가되면이라 애프터
FOR EACH ROW -- 한 행마다 // ROW TRIGGER 쓰면 OLD/NEW를 지정해줘야함
BEGIN -- PRO_DETAIL에 상품(코드)가 추가되면 쓰여질 트리거를 코딩 중
     -- 트리거 어떤거를 보고 결정이 될까? STATUS 스테이터스에 수량 기록(입출고)이 다 나와있음
    -- 상품이 입고된 경우
    -- 상품이 출고된 경우

    -- 상품이 입고된 경우
    IF :NEW.STATUS = '입고' -- 새로 넣은(:NEW) STATUS가 입고면 THEN 조건 해라는 의미. 
    THEN                   -- 이 NEW는 지금 넣어진 행을 의미하고 ROW TRIGGER OLD/NEW의 그 NEW.
        UPDATE PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT -- STOCK에 새로 들어온 양(:NEW.AMOUNT)만큼 SET해달라는 의미. 
        WHERE PCODE = :NEW.PCODE; -- :NEW는 ROW TRIGGER에서만 쓰이는 레퍼런스
    END IF;
    
    -- 상품이 출고된 경우
    IF :NEW.STATUS = '출고'
    THEN
        UPDATE PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE; 
    END IF;
END;
/

SELECT * FROM PRODUCT;    -- 현재 물품 재고 조회
SELECT * FROM PRO_DETAIL; -- 입출고 상세 기록 조회

INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 20, '입고'); -- 3번물품 포켓몬빵
-- INSERT만 했는데 TRIGGER 덕에 SELECT * FROM PRODUCT;조회해보면 포켓몬 20이 추가되어있음
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 5, '입고'); -- 1번물품 꼬깔콘
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 10, '입고');

INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 19, '출고'); -- -19되서 포켓몬 1개남음 // SELECT * FROM PRODUCT;
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 2, '출고');

SELECT * FROM PRODUCT;    -- 현재 물품 재고 조회
SELECT * FROM PRO_DETAIL; -- 입출고 상세 기록 조회

SELECT * FROM USER_TRIGGERS; -- 전체 트리거 확인 코드

-----------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------







------------------------------------------------------------------------------
------------------------------------------------------------------------------




------------------------------------------------------------------------------
------------------------------------------------------------------------------
