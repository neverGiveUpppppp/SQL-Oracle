------------------------------------------------------------------------------
----------------------------------PROCEDURE-----------------------------------
------------------------------------------------------------------------------
                                                                  /*22.03.24 */
-- PROCEDURE 
-- PL/SQL 저장 객체
-- PROCEDURE 프로시져명


CREATE TABLE EMP_DUP -- 테이블 생성
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_DUP; -- 데이터 잘 들어갔는지 확인 조회



-- 자료 몇개 지워보고 확인해볼 것

CREATE OR REPLACE PROCEDURE DEL_ALL_EMP -- PRCEDURE 프로시져명
IS -- 프로시져를 만들건데 프로시져는 이렇게 생겼어의 IS
BEGIN 
    DELETE FROM EMP_DUP;
END;
/
-- Procedure DEL_ALL_EMP이(가) 컴파일되었습니다.


-- 실행방법 2가지
-- 방법1
-- EXECUTE 프로시져명;
EXECUTE DEL_ALL_EMP;
-- 방법2
-- EXEC 프로시져명;
EXEC DEL_ALL_EMP;

SELECT * FROM EMP_DUP; -- 다시 조회해보면 자료 삭제됨

SELECT * FROM USER_SOURCE;

COMMIT;


-- 입력한 사번에 해당하는 사원 삭제
CREATE OR REPLACE PROCEDURE DEL_EMP_ID
IS
BEGIN 
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
END;
/
-- Procedure DEL_EMP_ID이(가) 컴파일되었습니다.
EXEC DEL_EMP_ID; -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
-- 처음에는 200이 있으니 삭제 되지만, 두번째부터는 계속 200만 삭제하게되는 코드가 됨
-- 처음 200 받으면서 이 값이 고정이 되어버림. 위의 코드는 잘못된 코드
-- 강의시간 11:15-28
SELECT * FROM EMPLOYEE; 
/*유저소스 확인해보면 내가 입력 200이 그대로 들어가 있음
내가 의도한건 프로시듀를 실행할 때마다 
몇번을 지울거냐고 물어보길 원했는데
컴파일 할 때 실행할 때 부터 값을 받아왔고 그게 고정으로 진행되어 왔다는 것

원래 의도한건 내가 입력한 사번 하나만 지우는게 아니라 프로시저를 실행할 때마다 몇번 지울지
물어보길 바랬던건데, 프로시져를 만들면서 몇번을 지울지 입력 받게끔 만들었기에 200 입력하면
DEL EMP ID라는 프로시져에 200이 들어가있는 상태로 컴파일이 되어버림

읽어 온 사번이 컴파일 시 고정되기에
사용자 입력코드 위치가 잘못된 걸 알게됬다. 그럼 어디에 넣어야할까?
EXEC 실행할 때 값을 넣을 수 있도록 해야함


*/

-- 이 때문에
-- 매개변수를 사용할 것임

CREATE OR REPLACE PROCEDURE DEL_EMP_ID(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
IS
BEGIN 
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/
EXEC DEL_EMP_ID('&사번'); -- 입력한 값이 여기 '&사번'으로 들어감. 즉, 매개변수가 된다. 다시 인자가 되어
                         -- 이 '&사번'의 데이터가 위 PROCEDURE 프로시져명(V_EMP_ID...)의 V_EMP_ID로 들어감

SELECT * FROM EMPLOYEE; 

-- 강의시간 11:20-40
ROLLBACK;


------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- PROCEDURE 매개변수

-- IN 매개변수 : 프로시저 내부에서 사용할 '변수'
-- OUT 매개변수 : 프로시저 외부에서 사용할 '변수'
--               외부라함은 내가 정의한 프로시저 밖을 의미


-- 사용자가 입력한 사번으로 사원의 이름, 급여, 보너스 조회하는 SELECT_EMP_ID 프로시져 생성
-- 이름,급여,보너스를 프로시저 밖에서도 쓸 수 있도록 하는게 의도

-- 매개변수 미적용
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(V_EMP_ID/*변수명*/ EMPLOYEE.EMP_ID%TYPE)  
IS                                          
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE; -- 변수선언
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_NAME,SALARY,NVL(BONUS,0) -- NVL : 보너스 NULL처리용
    INTO EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID/*변수명*/; -- V_EMP_ID : 안에서 실행되서 IN 매개변수에 포함됨
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME);
    DBMS_OUTPUT.PUT_LINE(SALARY);
    DBMS_OUTPUT.PUT_LINE(BONUS); 
    
END;
/

EXECUTE SELECT_EMP_ID('&사번'); 
-- EXEC 옆에 주석 달면 에러발생
-- 프로시저 외부에서 조회 가능


--    EMP_NAME EMPLOYEE.EMP_NAME%TYPE; -- 전부 IN 매개변수
--    SALARY EMPLOYEE.SALARY%TYPE;
--    BONUS EMPLOYEE.BONUS%TYPE;

-- 매개변수 적용
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(
                    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
                    EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE, -- OUT 매개변수 넣기에 
                    SALARY OUT EMPLOYEE.SALARY%TYPE,
                    BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS                                          
BEGIN
    SELECT EMP_NAME,SALARY,NVL(BONUS,0) -- 셀렉트한 결과를 인투에 담에놓고 위에 아웃에서 쓰겠다는 것
    INTO EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID/*변수명*/; -- V_EMP_ID : 안에서 실행되서 IN 매개변수에 포함됨
END;
/
-- 바인드 변수
-- SQL에 사용값을 전달할 수 있는 통로 역할(밖에 있는 것과 연결해주는 것)
VARIABLE VAR_EMP_NAME VARCHAR2(30); 
VAR VAR_SALARY NUMBER; 
VAR VAR_BONUS NUMBER;  
-- VARIABLE <- 바인드 변수
-- VAR라고만 써도 OK
-- 변수 생성

PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;

EXECUTE SELECT_EMP_ID('&사번', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS); 
-- 참조 // 콜론 꼭 붙일 것

/*
위 코드의 개념 원리 정리 다시 설명
강의시간 2:23-2:28
아웃 매개변수 
밖에 있는 변수랑 연결할 바인드 변수랑 연결해 놓은 것
바 샐, 네임 이랑 CREATE의 샐,네임이랑 각각 연결해놓은 것
아웃 매개변수 수만큼 바인드 변수와 연결하겠다해서 EXEC에 :으로 참조
결과값이 VARIABLE VAR VAR에 담기고 PRINT를 이용하여 이를 확인한 것

*/


------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- FUNCTION

-- PROCEDURE랑 비슷한데  PROCEDURE는 반환값X
-- FUNCTION은 반환값 O
-- 프로시저와 동일하지만 반환 값이 존재함


-- 216번 사원의 이름 출력
CREATE OR REPLACE FUNCTION SELECT216
RETURN EMPLOYEE.EMP_NAME%TYPE -- 뭘 반환할껀지 리턴타입을 정해줘야함
IS -- 리턴타입은 변수 VARCHAR2,NUMBER도 가능하고 위에처럼 레퍼런스로도 가능
    NAME EMPLOYEE.EMP_NAME%TYPE; --변수 설정 및 받아온거 저장
BEGIN
    SELECT EMP_NAME
    INTO NAME -- 네임 받아온거 집어넣자 //
    FROM EMPLOYEE
    WHERE EMP_ID = 216;

    RETURN NAME; -- 의미 : 무엇을 리턴할래? NAME을 리턴하겠다
END;
/
-- 밖에서 변수로 사용할꺼니 VARIABLE 만들어주자
VARIABLE NAME216 VARCHAR2(30);
-- == VAR
EXEC :NAME216 := SELECT216;
-- NAME216에 값을 집어 넣겠다고 := 해준다
PRINT NAME216;
-- 차태연 


-- 사번을 입력받아 해당 사원의 연봉을 계산하고 리턴하는 BONUS_CALC 함수 생성 후 연봉 출력
-- 연봉은 보너스 포함 (강의시간 3:20-3:35)

CREATE OR REPLACE FUNCTION BONUS_CALC (V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
                                     
RETURN NUMBER
IS
    V_SALARY EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
    CALC_SAL NUMBER; -- 연봉계산한 변수
BEGIN 
    SELECT SALARY, NVL(BONUS, 0)
    INTO V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    CALC_SAL := (V_SALARY + (V_SALARY * V_BONUS)) * 12;
    RETURN CALC_SAL; -- 최종적으로 반환하고 싶은 것
END;
/

VARIABLE VAR_YSAL NUMBER;

EXEC :VAR_YSAL := BONUS_CALC('&사번');
PRINT VAR_YSAL;


--SELECT문에서 함수 호출해 오는 방법도 있음
SELECT EMP_ID, EMP_NAME, BONUS_CALC(EMP_ID)
FROM EMPLOYEE
WHERE BONUS_CALC(EMP_ID) > 3000000;



------------------------------------------------------------------------------







------------------------------------------------------------------------------
------------------------------------------------------------------------------




------------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------