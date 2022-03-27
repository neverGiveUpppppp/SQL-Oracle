------------------------------------------------------------------------------
--------------------------------PL/SQL(절차형 SQL)-----------------------------
------------------------------------------------------------------------------
/*

PL/SQL ( Procedural Language extension to SQL) = 절차형 SQL
오라클 자체에 내장되어있는 절차적 언어

절차적 언어(Procedural Language)란?
반복문,if문 같은 것들이 절차적으로 사용되는 코드들임
절차적 논리, 계산 같은 것들이 sql에서 사용되는 것

변수의 정의, 조건처리, 반복처리(반복문) 등을 지원하여 PL/SQL을 통해서 SQL의 단점 보완

PL/SQL의 구조
1.선언부(DECLARE SECTION)          :   DECLARE
2.실행부(EXECUTABLE SECTION)       :   BEGIN
3.예외처리부(EXCEPTION SECTION)     :   EXCEPTION

1.선언부(DECLARE SECTION)      : 변수, 상수 선언하는 부분 
        -> DECLARE로 시작
2.실행부(EXECUTABLE SECTION)   : 제어문, 함수 정의 등 로직을 기술 하는 부분 
        -> BEGIN으로 시작
3.예외처리부(EXCEPTION SECTION) : 예외 발생 시, 해결할 수 있는 문장 기술 부분 
        -> EXCEPTION으로 시작
        
선언부,예외처리부 생략가능
 - 필요에 따라 안 쓸 수도 있다는 의미
 
자바로 보면 
System.out.println("안녕");

String hello = "안녕";
System.out.println(hello);


*/

SET SERVEROUTPUT ON; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLOW WORLD');
END;
/ 
-- / 포함해서 위 코드 옆에 주석 달면 에러 발생
-- SET SERVEROUTPUT ON; : 출력 결과에 뜨게끔 하는 코드
-- SP2-0265: serveroutput은 ON 또는 OFF로 설정되어야 합니다.
--      -> 주석이 위아래 옆 없어야한다. 시작부터 끝까지 안에 주석도 없어야해서 밖으로 빼줄 것 
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
-- 엔드로 끝나는게 맞는데 여기 문장이 끝이다라는 의미로 /까지 적어줘야함


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- 선언부 작성

/*
-- 자바코드로 예시
-- 이 자바코드를 선언부로 작성해 볼 것임

-선언부
int empId;
String empName;
final int PI = 3.14; -- 선언 초기화 같이하면 선언부 쪽

-실행부
empId = 888;        -- 값 초기화 부분도 실행부로 본다.
empName = "도대담";  
System.out.println("empId : " + empId;
System.out.println("empName : " + empName);
System.out.println("PI : " + PI);

*/

-- 선언부
DECLARE -- 변수설정 // 변수 3개
    EMP_ID NUMBER;          -- 얘는 따로따로 직접 지정해서 쓴 것
    EMP_NAME VARCHAR(30);   -- 따로 쓰는게 아닌 참조해서 쓰는 방법도 있음
    PI CONSTANT NUMBER := 3.14; -- 상수 넘버. 오라클에서의 상수는 CONSTANT
                                -- 오라클의 대입연산자 : :=
-- 실행부                                
BEGIN
    EMP_ID := 888;
    EMP_NAME := '도대담';

    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/ 
-- / 옆에 주석달면 안된다


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DECLARE  -- 변수설정
	변수명 참조할테이명.참조할컬럼명%TYPE
BEGIN
	SELECT EMP_ID,EMP_NAME,SALARY, BONUS -- 끌어올 테이블의 컬럼명
	INTO 변수명 -- (DECLARE에 보낼)변수명, 변수명
	FROM EMPLOYEE -- 끌어올 테이블명
	WHERE EMP_ID = '&사번';

	DBMS_OUTPUT.PUT_LINE('사번:' || (출력할)변수명); -- (출력할)변수명)
    
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


-- 참조 : %TYPE + INTO

-- EMP_ID의 정보를 참조해 올 것임
-- 선언부
DECLARE -- 변수설정 // 변수 2개
    EMP_ID EMPLOYEE.EMP_ID%TYPE; -- EMPLOYEE테이블의 EMP_ID의 데이터를 참조하겠다
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE; -- %TYPE
-- 실행부
BEGIN
    SELECT EMP_ID, EMP_NAME -- EMP ID,NAME을 위에 DECLARE의 EMP ID,NAME에다 넣고 싶으면?
    INTO EMP_ID, EMP_NAME   -- INTO 사용
    FROM EMPLOYEE
    WHERE EMP_ID = 200;
    -- 사용자에게 INPUT 받기(SCANNER)
    WHERE EMP_ID = '&EMP_ID'; -- 205입력 // EMP_ID 205 EMP_NAME : 정중하 // 정상출력
    WHERE EMP_ID = '&사번';    -- 윗줄과 같은 의미
    
    --출력해보자
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID);      -- EMP_ID : 200
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);-- EMP_NAME : 선동일

END;
/


/* 문제
레퍼런스 변수로 EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY를 선언하고
EMPLOYEE 테이블에서 사번, 이름, 직급코드, 부서코드, 급여를 조회하고
선언한 레퍼런스 변수에 담아 출력하시오
단, 입력받은 이름과 일치하는 조건의 직원을 조회하세요.                               
*/
DECLARE -- 변수 5개
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&EMP_NAME'; -- '&' : 사용자 입력(Scanner)
    --WHERE EMP_NAME = '&사원명'; -- 사원 명 띄어쓰기하면 에러
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE ' || DEPT_CODE); 
    DBMS_OUTPUT.PUT_LINE('JOB_CODE ' || JOB_CODE); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || SALARY); 
END;
/
/* -- 출력 결과
EMP_ID 209
EMP_NAME 심봉선
DEPT_CODE D5
JOB_CODE J3
SALARY 3500000
*/

-------------------------------------------------------------------------------


--변수를 많이 쓴다면?


-- %ROWTYPE
-- 한 행 전체를 가지고 오는 레퍼런스
-- 변수명 참조할테이블명%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE; -- 앞에 타입에 맞는 변수명을 기술
BEGIN                   -- EMPLOYEE 한행 다 들어간 레퍼런스
    SELECT * INTO E     -- E : 변수명
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || E.EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || E.EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || E.SALARY);
    
END;
/
-- 선언부 생략 가능하니 각각 세미콜론(;)으로 마침을 해줘야한다


-- 변수명 설정
DECLARE  -- 변수설정 // 변수 4개
    EI EMPLOYEE.EMP_ID%TYPE;    -- EI
    EN EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID,EMP_NAME,SALARY, BONUS
    INTO EI,EN,SAL, BNS -- INTO에 들어갈 것들은 변수명임!!
    FROM EMPLOYEE       -- INTO에 EMP_ID를 받을 변수명 설정 : EI
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('사번:' || EI); -- EI
END;
/    

------------------------------------------------------------------------------
-----------------------------------조건문--------------------------------------
------------------------------------------------------------------------------

-- 조건문

-- IF ~ THEN ~ END IF;
-- IF ~ THEN ~ END IF = 자바 단일 IF문

DECLARE
    E EMPLOYEE%ROWTYPE; -- 앞에 타입에 맞는 변수명을 기술
BEGIN
    SELECT * INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || E.EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || E.EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || E.SALARY);
    
END;
/

-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
-- 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다.' 출력
-- 일단 IF문 없이
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,SALARY,BONUS
    INTO EMP_ID,EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('BONUS ' || BONUS);
END;
/
-- IF문 추가
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,SALARY,BONUS
    INTO EMP_ID,EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || SALARY);
    
    IF(BONUS = 0) -- IF는 변수 지칭 // 변수 BONUS를 가지고와서 사용 
    -- IF BONUS = 0 -- 소괄호 생략 가능
    -- IF BONUS IS NULL
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('BONUS ' || BONUS * 100 || '%'); -- 보너스 % 보이게하기
END;
/

-- NVL 추가 응용
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,SALARY,NVL(BONUS, 0) -- NVL :NULL 대신 출력할 문자
    INTO EMP_ID,EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('BONUS ' || BONUS);
END;
/
------------------------------------------------------------------------------

-- IF ~ THEN ~ ELSE ~ END IF
-- IF ~ THEN ~ ELSE ~ END IF == IF ~ ELSE문


-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 부서명, 소속 출력
-- TEAM 변수를 만들어 소속이 KO인 사원은 국내팀, 아닌 사원은 해외팀으로 저장

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);  -- TEAM 변수 생성
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
--    FROM EMPLOYEE, DEPARTMENT, LOCATION ======================================
--    WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID,===== 오라클전용 구문은 왜 사용안되는가?
--          DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE, == WHERE절 못쓰기 때문?
--          EMP_ID = '&EMP_ID';
    FROM EMPLOYEE 
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&EMP_ID';
    
    IF NATIONAL_CODE = 'KO'     -- IF ELSE문
        THEN TEAM := '국내팀';   -- IF ~ THEN ~ ELSE ~ END IF
    ELSE TEAM := '해외팀';       -- DMBS_OUTPUT.PUT_LINE문보다 앞에 와야 IF문 적용됨
    END IF;

    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM); -- NATIONAL_CODE에서 TEAM으로 변경
END;
/

-- 변수명 바꿔서 다시한번
DECLARE
    EI EMPLOYEE.EMP_ID%TYPE;
    EN EMPLOYEE.EMP_NAME%TYPE;
    DT DEPARTMENT.DEPT_TITLE%TYPE;
    NC LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EI, EN, DT, NC
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&사번';
    
    IF NC = 'KO'
        THEN TEAM := '국내팀';
    ELSE TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EI); 
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EN); 
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DT);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || NC);   
END;
/


-- 사용자에게 사번을 받아와 그 사원의 전체 정보를 VEMP에 저장
-- VEMP를 이용하여 연봉 계산(보너스가 있는 사원은 보너스도 포함하여 계산)
-- 연봉 계산 결과 값은 YSALARY에 저장
-- 급여 이름 연봉(\1,000,000 형식)으로 출력
-- (IF없이 NVL문으로도 가능)

DECLARE
    VEMP EMPLOYEE%ROWTYPE; -- 사원 전체 불러오는거라 %ROWTYPE
    YSALARY NUMBER;
BEGIN             
    SELECT *      -- VEMP변수에서 해당 사원1명의 전체정보를 불러오기에(SELECT에서 *전체 불러오기 때문에)
    INTO VEMP     -- VEMP.컬럼명으로 원하는 정보를 명시해서 불러와야한다
    FROM EMPLOYEE -- ex) VEMP.SALARY VEMP.DEPT_CODE
    WHERE EMP_ID = '&EMP_ID';
    
    IF VEMP.BONUS IS NOT NULL   
        THEN YSALARY := VEMP.SALARY * (1+ VEMP.BONUS) * 12;
    ELSE YSALARY := VEMP.SALARY * 12;
    -- YSALRY := VEMP.SALARY * (1+ NVL(VEMP.BONUS, 0)) * 12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.SALARY || ' ' || VEMP.EMP_NAME || ' ' ||
                         TO_CHAR(YSALARY, 'FML999,999,999'));  -- FM : 공백제거 // L : 시스템설정 국가의 화폐단위
END;
/



------------------------------------------------------------------------------

-- IF~ THEN~ ELSIF~ THEN~ ELSE~ END IF
-- IF~ THEN~ ELSIF~ THEN~ ELSE~ END IF == IF~ ELSE IF~ ELSE문


-- 점수를 입력받아 SCORE 변수에 저장
-- 90점 이상이면 A, 80이상이면 B, 70이상은 C, 60점 이상은 D, 그 미만은 F 처리하여 GRADE 변수에 저장
-- 출력형식 : 당신의 점수는 N점이고, 학점은 M학점입니다.

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);   
BEGIN
    SCORE := '&점수'; -- 대입연산자 :=
    
    IF SCORE >= 90
        THEN GRADE := 'A';
    ELSIF SCORE >=80
        THEN GRADE := 'B';
    ELSIF SCORE >= 70
        THEN GRADE := 'C';
    ELSIF SCORE >= 60
        THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점이고 학점은 ' || GRADE ||'학점입니다.');
END;
/





------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- CASE~ WHEN~ THEN~ END(SWITCH문)

-- 프로그램 재실행 후 프린트만 찍히고 다른 내용들이 안나온다면,
-- SET SERVEROUTPUT ON; 코드 찍어주고 하면 다 잘나올 것

-- IF문은 THEN마다 세미콜론( ; )이 들어가지만 CASE WHEN THEN END문은 안들어가고 마지막 END에만


-- 사원 번호를 입력하여 해당 사원의 사번,이름,부서명 출력
-- 선언부
DECLARE -- 변수설정 // 변수 2개
    EMP EMPLOYEE%ROWTYPE; -- EMPLOYEE테이블의 EMP_ID의 데이터를 참조하겠다
    DNAME DEPARTMENT.DEPT_TITLE%TYPE;
-- 실행부
BEGIN
    SELECT * INTO EMP    
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
-- 방법1
--    DNAME := CASE
--                WHEN EMP.DEPT_CODE = 'D1' THEN '인사관리부'
--                WHEN EMP.DEPT_CODE = 'D2' THEN '회계관리부'
--                WHEN EMP.DEPT_CODE = 'D3' THEN '마케팅부'
--                WHEN EMP.DEPT_CODE = 'D4' THEN '국내영업부'
--                WHEN EMP.DEPT_CODE = 'D5' THEN '해외영업1부'
--                WHEN EMP.DEPT_CODE = 'D6' THEN '해외영업2부'
--                WHEN EMP.DEPT_CODE = 'D7' THEN '해외영업3부'
--                WHEN EMP.DEPT_CODE = 'D8' THEN '기술지원부'
--                WHEN EMP.DEPT_CODE = 'D9' THEN '총무부'
--                ELSE '배정X'
--            END;
-- 방법2
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '인사관리부'
                WHEN 'D2' THEN '회계관리부'
                WHEN 'D3' THEN '마케팅부'
                WHEN 'D4' THEN '국내영업부'
                WHEN 'D5' THEN '해외영업1부'
                WHEN 'D6' THEN '해외영업2부'
                WHEN 'D7' THEN '해외영업3부'
                WHEN 'D8' THEN '기술지원부'
                WHEN 'D9' THEN '총무부'
                ELSE '배정X'
            END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID||' '||EMP.EMP_NAME||' ' ||DNAME);
    
END;
/

------------------------------------------------------------------------------
--------------------------------------반복문-----------------------------------
------------------------------------------------------------------------------

-- 반복문


-- BASIC LOOP
-- LOOP ~ END LOOP;
-- 반복할 내용을 작성하고 마지막에 반복을 벗어날 조건 명시
-- FOR문과 다르게 단순 반복만


-- 1~5까지 순차적 출력
DECLARE
    N NUMBER := 1; -- 값 초기화
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;         -- i+1처럼 값 증가
-- 방법1        
--        IF N > 5 THEN EXIT; -- 반복문 종료 조건
--        END IF;
-- 방법2
        EXIT WHEN N > 5;    -- 반복문 종료 조건
    END LOOP;
END;
/
-- 1~5까지 세로로 정상출력됨



-- 반복 종료 방법 2가지
/*
-- 방법1        
IF N > 5 THEN EXIT; -- 반복문 종료 조건
END IF;
-- 방법2
EXIT WHEN N > 5;
*/
------------------------------------------------------------------------------

-- FOR LOOP

-- 특별한 목적이 있지 않는 이상 DECLARE 선언부가 필요X
-- 가데이터를 넣어서 미리 돌려보기 위해 FOR LOOP을 써서 가데이터를 많이 넣는데 사용한다

-- 1~5까지 순차적 출력
BEGIN
    FOR N IN 1..5   -- 의미 1부터 5까지 // .. 2개 점 3개쓰며 에러발생
    LOOP            --  N은 자동적으로 NUMBER타입의 변수 설정됨
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 5~1까지 출력
BEGIN
    FOR N2 IN REVERSE 5..1  -- 기본적으로 앞 숫자가 작아야 FOR문이 돌게된다. 
    LOOP                    -- REVERSE 붙일 것
        DBMS_OUTPUT.PUT_LINE(N2);
    END LOOP;
END;
/
-- REVERSE 추가 전 FOR N2 IN 5..1로만 출력하면,
-- PL/SQL 프로시저가 성공적으로 완료되었습니다. 뜨지만 아무것도 안뜬다

-- 현업 사용 예시
-- 가데이터 넣기

-- 모범 답안
BEGIN
    FOR N2 IN REVERSE 1..5  -- 기본적으로 앞 숫자가 작아야 FOR문이 돌게된다. 
    LOOP                    -- REVERSE 붙일 것
        DBMS_OUTPUT.PUT_LINE(N2);
    END LOOP;
END;
/

BEGIN
    FOR N IN 1..30   
    LOOP            
        INSERT INTO TB1 VALUES(I); -- -- 가데이터 넣기
    END LOOP;
END;
/

-- FOR문 조건 안에서 연산가능
BEGIN
    FOR N IN 2..8/2 -- FOR문 안에서 연산가능
    LOOP
        DBMS_OUTPUT.PUT_LINE('---'||N||'단---');    
        FOR NN IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(N||' x '||NN||' = '||N*NN);
        END LOOP;
    END LOOP;
END;
/
------------------------------------------------------------------------------

-- WHILE LOOP

-- 변수 값 초기화 시, 덮어쓰기 가능
-- ex)위에 코드에서 N 이미 사용했지만 아래서 다시 값 초기화해서 사용됨

-- 1~5까지 순차적 출력
DECLARE
    N NUMBER := 1; -- 값 초기화
BEGIN
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;     -- N + 1의 LOOP 안 위치 중요. 기억!
    END LOOP;
END;
/

-- 5~1까지 출력
DECLARE
    N NUMBER := 5; -- 값 초기화
BEGIN
    WHILE N >= 1
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N - 1;     -- N - 1의 LOOP 안 위치 중요. 기억!
    END LOOP;
END;
/


-- 구구단 출력
-- 짝수 단 출력
-- 1)WHILE문
-- 2)FOR문 - WHILE문
-- 3)WHILE문 - FOR문

-- 1-9단 FOR문 출력
BEGIN
    FOR N IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE('---'||N||'단---');
        FOR M IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(N||' x '||M||' = '||N*M );
        END LOOP;
    END LOOP;
END;
/

-- 1-9단 WHILE문 출력
DECLARE
    N NUMBER := 1;
    NN NUMBER := 1;
BEGIN
    WHILE N <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE('---'||N||'단---'); 
        
        DECLARE
            NN NUMBER := 1;
        BEGIN   
            WHILE NN <= 9
            LOOP
            DBMS_OUTPUT.PUT_LINE(N||' x '||NN||' = '||N*NN);
            NN := NN + 1;
            END LOOP;    
            N := N + 1;
        END;
    END LOOP;
END;
/
-- 짝수 단 출력



COMMIT;
------------------------------------------------------------------------------
----------------------------예외 처리(EXCEPTION)--------------------------------
------------------------------------------------------------------------------

-- 예외 처리(EXCEPTION)
-- NO_DATA_FOUND : SELECT문이 데이터 행을 반환하지 못할 때
-- DUP_VAL_ON_INDEX : UNIQUE 제약조건이 들어간 컬럼에 중복 값이 들어갔을 때
--                      DUPLICATE VALUE ON INDEX
-- ZERO_DIVIDE : 0으로 나눌 때


-- DUP_VAL_ON_INDEX
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&사번' -- 201 인풋
    WHERE EMP_ID = 200;
    -- ERROR : ORA-00001: unique constraint (KH.EMPLOYEE_PK) violated
    -- 예외처리 해보자
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/


-- NO_DATA_FOUND
DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT EMP_NAME INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID = 0;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('조회 결과가 없습니다');
END;
/


------------------------------------------------------------------------------




------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------










