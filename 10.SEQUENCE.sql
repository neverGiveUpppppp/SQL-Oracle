------------------------------------------------------------------------------
------------------------------------SEQUENCE----------------------------------
------------------------------------------------------------------------------

/*


    <정리 개괄>

시퀸스 구조
CREATE SEQUENCE 시퀸스명
[ START WITH n ]    -- 시작 값 지정, 생략하면 자동 1 지정
[ INCREMENT BY n ]  -- 다음 값에 대한 증가치, 생략하면 자동 1 지정
[ MAXVALUE n | NOMAXVALUE ] -- 발생시킬 최대값, NOMAXVALUE일 경우 10의 27제곱까지 가능
[ MINVALUE n | NOMINVALUE ] -- 발생시킬 최소값, 10의 26제곱까지 가능
[ CYCLE | NOCYCLE ] -- 반복| 노반복 : 값 순환여부. 싸이클 넘어가면 다시 시작숫자로 회귀
[ CACHE 바이트 크기 | NOCACHE ]

시퀸스 생성 : CREATE SEQUENCE 시퀸스명;
시퀸스 사용 : INSERT INTO 테이블명(시퀸스명.NEXTVAL,'선동일',...)
-- CURRVAL,NEXTVAL
시퀸스 수정 : ALTER SEQUENCE 시퀸스명;
시퀸스 삭제 : DROP SEQUENCE 시퀸스명;
시퀸스 전체 리스트 조회 : SELECT * FROM USER_SEQUENCES;


------------------------------------------------------------------------------



-- < SEQUENCE >
자동 번호 발생기
순차적으로 정수 값을 자동 생성
PK(PRIMARY KEY=고유식별자)를 자동 증가시키는 역할

게시판 글번호에 많이 쓴다


-- 구조
CREATE SEQUENCE sequence_name
[ START WITH n ]    -- 시작 값 지정, 생략하면 자동 1 지정
[ INCREMENT BY n ]  -- 다음 값에 대한 증가치, 생략하면 자동 1 지정
[ MAXVALUE n | NOMAXVALUE ] -- 발생시킬 최대값, NOMAXVALUE일 경우 10의 27제곱까지 가능
[ MINVALUE n | NOMINVALUE ] -- -발생시킬 최소값, 10의 26제곱까지 가능
[ CYCLE | NOCYCLE ] -- 반복| 노반복 : 값 순환여부. 싸이클 넘어가면 다시 시작숫자로 회귀
[ CACHE 바이트 크기 | NOCACHE ] -- 캐시 메모리 사용. 사용하면 좀 더 빠르지만 1씩 잘 증가하다가 갑자기 20씩 증가하거나 그럴 때가 있다
    -- 생성한 값을 저장하고 가져오다보니 캐시를 사용한다고 했을 때 1씩 증가하겠다 
    -- 순차적으로 증가해놓고 싶은 값에서 갑자기 20씩 증가할 수 있는 상황이 발생할 수 있어서 
    -- 물론 이게 20씩 뛴게 문제가 되는건 아니지만 1씩 순차적으로 증가하기를 원하면 
    -- 노캐시를 쓰는게 좋다. 노캐시 쓴다고 많이 느린 건 아니다


-- START WITH : 시퀀스 시작 값
-- INCREMENT BY : 시퀀스 증가 값
-- MAXVALUE : 시퀀스 최대 값
-- MINVALUE : 시퀀스 최소 값
-- CYCLE : 최대값 도달 시 순환 여부, NOCYCLE은 증가완료시 에러를 유발한다.
-- CACHE : 메모리상에서 시퀀스값을 관리(CACHE)할지 여부를 결정
--         기본값은 20, 원하는 숫자만큼 미리 만들어 캐시로 상주시킨다
--				/ NOCACHE :설정은 메모리상에서 시퀀스값을 관리하지 않는다


*/
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- SEQUENCE 생성

CREATE SEQUENCE SEQ_EMPID
START WITH 300 
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE; -- Sequence SEQ_EMPID이(가) 생성되었습니다.
-- 의미: 시퀸스 이름 SEQ_EMPID는 300으로 시자개서 5씩 증가하며 
-- 최대치 310까지 작동하고 값을 순환시키지 않는다. 캐시메모리 사용X


SELECT * FROM USER_VIEWS;     -- 전체 뷰를 조회할 수 있는 코드
SELECT * FROM USER_SEQUENCES; -- 전체 시퀸스를 조회할 수 있는 코드

------------------------------------------------------------------------------



-- SEQUENCE 사용

-- CURRVAL
-- NEXTVAL


-- 시퀸스명.CURRVAL : 현재 생성된 시퀀스 값
--                  마지막으로 NEXTVAL에 의해 호출된 값이 저장됨. 그래서 현재값이라고 부르는 것
-- 시퀸스명.NEXTVAL : 시퀸스를 다음 값으로 증가시킨 값 = 기존 시퀀스값에서 증가치만큼 증가한 값
--                  다음 값으로 증가시키기도 하지만 최초로 시퀸스를 실행시키기도 함
--                  NEXTVAL로 처음 실행시켜줘야하고 처음 실행해서 만들어진 값이 CURRVAL로 들어간다
    
    
    
    
--SEQ_EMPID에 대한 '현재 값' 조회
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- ERROR : ORA-08002: sequence SEQ_EMPID2.CURRVAL is not yet defined in this session
-- 원인 : 아직 시퀸스명.NEXTVAL로 시퀸스를 실행시키지 않아서 에러. NEXTVAL에서 CURRVAL로 최초값을 받아오자.
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300 // 305 // 310 누를 때마다 5씩 값 증가되서 출력됨. 최대치설정이310이라 멈춤
-- 최대치 다다랐을 때 에러메세지
-- ORA-08004: sequence SEQ_EMPID.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- 최대치 MAXVALUE가 310까지 설정되어있어 더이상 인스턴스화 할 수 없음



-- 시퀸스 SEQ_EID 생성
-- 단, 시작값은 300이고 최대값은 10000, 순환하지 않고 캐시 메모리 사용 안하며 증가 숫자는 1

CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE; -- Sequence SEQ_EID이(가) 생성되었습니다.


INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, '남나눔','891023-1540123','nam@n.n','01022223333','D2','J7','S1',
        50000000,0.1,200,SYSDATE, NULL, DEFAULT);
-- VALUES의 첫값인 고유식별자(PK, PRIMARY KEY) 자리에 시퀸스가 많이 쓰인다

-- 많이 하는 실수
CREATE TABLE EX(
    E_ID NUMBER DEFAULT SEQ_EID.NEXTVAL,
    E_NAME VARCHR2(30)
); -- NEXTVAL을 INSERT에 사용하는 건 문제 없다
   -- ORA-00984: column not allowed here
   -- 11g에서는 에러발생 // 19C는 테이블 생성시 시퀸스 사용 가능
INSERT INTO EX VALUES(DEFAULT, '1'); -- INSERT
SELECT * FROM EX;
   

------------------------------------------------------------------------------
-- 시퀸스 수정

-- ALTER SEQUENCE 시퀸스명

-- 객체라 수정 가능
-- 객체라 ALTER로 수정
-- START WITH 값 수정불가 (나머지 설정들을 수정 가능)

ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
CYCLE; -- 캐시 사용안할꺼라 수정 안할 것임
-- Sequence SEQ_EMPID이(가) 변경되었습니다.

-- 수정 됬는지 SELECT로 확인
SELECT * FROM USER_SEQUENCES; -- SEQ_EMPID	1	400	10	Y	N	0	320

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300 310 ... 400 1 // 맥스치400까지 갔다가 
                                    -- CYCLE 옵션설정해뒀기에 MINVALUE인 1부터 다시시작




------------------------------------------------------------------------------



------------------------------------------------------------------------------

/*
CREATE SEQUENCE seq_empno
START WITH 1000
INCREMENT BY 1
CACHE 20; -- CACHE 20 사용
SELECT seq_empno.NEXTVAL FROM dual; -- 1000 1001 1002





CREATE SEQUENCE SEQ_EMPID2
START WITH 300 
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT SEQ_EMPID2.CURRVAL FROM DUAL;
SELECT SEQ_EMPID2.NEXTVAL FROM DUAL;

DROP SEQUENCE SEQ_EMPID2;


ROLLBACK;

*/
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

------------------------------------------------------------------------------







