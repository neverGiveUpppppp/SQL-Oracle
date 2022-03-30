

/*
DDL(Date Definition language) : 데이터 정의어  - CREATE, ALTER, DROP

DML (Data Manipulation Language) :  데이터 조작어 - INSERT, UPDATE,DELETE,SELECT(DQL)

TCL(Transaction Ccontrol Language) : 트랜잭션 제어 - COMMIT, ROLLBACK





INSERT(데이터 삽입), UPDATE(데이터 수정),DELETE(데이터 삭제),SELECT(DQL)


------------------------------------------------------------------------------
---------------------------------INSERT--------------------------------------
------------------------------------------------------------------------------

-- INSERT
데이터 삽입 = 행 추가 → 테이블 행 개수 증가

원래 인서트 뒤에 ()가 들어가야함 . 컬럼 지정

*/

-- INSERT : 컬럼명 모두 지정
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,
            SAL_LEVEL, SALARY, BONUS, MANAGER_ID,HIRE_DATE, ENT_YN, ENT_DATE)
VALUES(900,'강건강','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,'N',NULL);                      
            
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- INSERT 시, 컬럼명 생략가능 조건           
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
     
DROP TABLE EMP_01;

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

-- 테이블의 컬럼 전부가 아닌 원하는 데이터만 삽입가능
INSERT INTO EMP_01(EMP_ID) VALUES(998);
INSERT INTO EMP_01(EMP_ID,EMP_NAME) VALUES(999,'남나눔'); 

SELECT * FROM EMP_01;
-- 데이터 조회 결과 : 999	남나눔 (NULL) <- DEPT_TITLE에 부서명 안넣어둬서 NULL


-- 서브쿼리로 데이터 INSERT하기
INSERT INTO EMP_01(
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE
            LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);
-- INSERT 두번시키면 중복데이터 두번 들어감
SELECT * FROM EMP_01; -- 25행


------------------------------------------------------------------------------
--참조:5.1. SQL 활용 (자체교재)


-- INSERT ALL
-- INSERT 시 서브쿼리가 사용하는 테이블이 같은 경우 한 번에 삽입 가능
-- 예시 2개

-- WHEN 절에 지정한 조건을 만족하는 데이터를 테이블을 지정해 삽입


-- 데이터는 필요 없이 구조만 따고 싶을 때 쓰는 코드        
-- 데이터는 없이 컬럼들만 전부 따오게 됨
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
-- EMP_MANAGER테이블에 EMPLOYEE 테이블에 있는 부서코드가 D1인 직원을 조회해
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

-- INSERT ALL로 한번에 
INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID -- 서브쿼리
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
-- INSERT ALL + SUBQUERY로 위 문제의 두 테이블을 한번에 추가    
-- INSERT ALL 각 테이블 조건에 맞게 INSERT


-- 서브쿼리로 INSERT 시, 언제 AS쓰고 언제 소괄호()쓸까? =========================
-- CREATE(DDL)에는 AS // INSERT(DML)에는 ()?
-- INSERT INTO 테이블명(들어갈 데이터출처)
INSERT INTO EMP_DEPT_D1 -- 삽일 할 대상 : EMP_DEPT_D1 테이블
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE -- 삽입할 데이터 : ID,NAME,DEPT_CODE, HIREDATE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
-- SQL 오류: ORA-00926: missing VALUES keyword
-- FROM EMPLOYEE에 있는 데이터를  EMP_DEPT_D1테이블에 삽입하는데
-- INSERT INTO 삽입당할 테이블명(끌어올 데이터)
-- 즉, 제대로된 데이터값을 넣지 않아 에러난 것. 
-- 아래가 정답
INSERT INTO EMP_DEPT_D1( -- 삽일 할 대상 : EMP_DEPT_D1 테이블
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE -- 삽입할 데이터 : ID,NAME,DEPT_CODE, HIREDATE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1');   




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
-- UPDATE 테이블명 SET 컬럼명 [WHERE]

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;


--DEPT_COPY테이블에서 DEPT_ID가 D9인 행의 DEPT_TITLE을 전략기획팀으로 수정
UPDATE DEPT_COPY -- 뭘 수정할지?
SET DEPT_TITLE = '전략기획팀' -- 어떻게 수정할지?
WHERE DEPT_ID = 'D9';
-- D9가 총무부에서 전략기획팀으로 변경됨

ROLLBACK;
COMMIT;
-- 업데이트에서 중요한 것
-- 업데이트에서 자주하는 실수 : WHERE절 빼먹기
-- WHERE절을 꼭 추가해서 원하는 부분만 수정할 것



CREATE TABLE EMP_SALARY
AS SELECT EMP_ID,EMP_NAME, SALARY, BONUS  -- SUBQUERY를 이용한 테이블 생성
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;

-- 값 수정할 것
-- 방명수 사원의 급여와 보너스를 유재식 사원과 동일하게 수정
SELECT * FROM EMP_SALARY -- 두 사원의 정보 조회해서 급여와 보너스 체크
WHERE EMP_NAME IN('방명수','유재식'); -- 204	유재식	3400000	0.2 // 214	방명수	1380000

-- 업데이트 2가지 코드 방법
-- 방법1 - 각각 업데이트
-- 방법2 - 한번에 업데이트하는 방법

UPDATE EMP_SALARY
-- 방법1 : 각각 업데이트
SET SALARY = (SELECT SALARY
              FROM EMP_SALARY
              WHERE EMP_NAME = '유재식'),
    BONUS = (SELECT BONUS
             FROM EMP_SALARY
             WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';
-- 각각 업데이트
SELECT * FROM EMP_SALARY -- 두 사원의 정보 조회해서 급여와 보너스 체크
WHERE EMP_NAME IN('방명수','유재식'); -- 204	유재식	3400000	0.2 // 214	유재식	3400000	0.2
-- 변경완료 : 두 사원이 동일한 급여,보너스

-- 방법2 : 한번에 업데이트하는 방법
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY,BONUS
                      FROM EMP_SALARY
                      WHERE EMP_NAME = '유재식')
WHERE EMP_NAME IN('노옹철','정중하','전형돈','하동운');
-- 4행 업뎃완료
SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN('방명수','유재식','노옹철','정중하','전형돈','하동운');
-- 변경성공 : 전원 동일 급여,보너스



--EMP_SALARY테이블에서 아시아 지역에 근무하는 직원의 보너스를 0.3으로 변경
-- 아시아 근무하는 직원 조회
-- 풀어본 것
--UPDATE EMP_SALARY
--SET BONUS = 0.3
--WHERE LOCAL_NAME = 'ASIA1' OR LOCAL_NAME = 'ASIA2' OR LOCAL_NAME = 'ASIA3';
---- 아시아 근무하는 직원 조회
--SELECT * FROM LOCATION, EMPLOYEE 
----WHERE LOCAL_NAME = 'ASIA1' OR LOCAL_NAME = 'ASIA2' OR LOCAL_NAME = 'ASIA3'; 
--WHERE LOCAL_NAME LIKE 'ASIA%';


-- 모범답안
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS, LOCAL_NAME
FROM EMP_SALARY
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID -- EMP_NAME도 가능하지만 동명이인이 있을 수 있으니 ID로 확실히 구별
                 FROM EMP_SALARY
                    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
                 WHERE LOCAL_NAME LIKE 'ASIA%';

COMMIT;

-- 업데이트 시 주의사항
-- NOT NULL 제약조건에 NULL 집어넣으면 에러발생할 것
-- 이와 마찬가지로 중요한 주의할 점

-- EMPLOYEE테이블에 DEPT_CODE에 외래키 제약조건 추가
-- 참조 테이블은 DEPARTMENT, 참조 컬럼은 DEPARTMENT의 기본키
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT; -- 컬럼명 생략가능
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);

UPDATE EMPLOYEE
SET DEPT_CODE = '0'
WHERE DEPT_CODE ='D6';
-- ERROR : ORA-02291: integrity constraint (KH.SYS_C007066) violated - parent key not found
-- 부모테이블에 없는 값을 참조해서 에러 - DEPARTMET에 값이 0인게 없기에 에러

COMMIT;
------------------------------------------------------------------------------
-----------------------------------DELETE------------------------------------
------------------------------------------------------------------------------

-- DELETE
-- 행 자체 삭제
-- 행 개수 감소


-- DELETE 제약조건 무시
-- 기본적으로는 부모 참조 자식 테이블 있으면 삭제 불가

-- DELETE로 삭제한거는 롤백으로 복원 가능
-- TRUNCATE는 롤백으로 복원 불가능

SELECT * FROM EMLOYEE;

DELETE FROM EMPLOYEE;
DELETE FROM EMPLOYEE WHERE EMP_NAME = '강건강';

ROLLBACK;



DELETE FROM EMP_SALARY;
SELECT * FROM EMP_SALARY;
ROLLBACK;


COMMIT;
------------------------------------------------------------------------------

-- TRUNCATE
-- DELETE보다 속도가 빠르며, 영구삭제
TRUNCATE TABLE EMP_SALARY; -- Table EMP_SALARY이(가) 잘렸습니다. // ROLLBACK으로 복원 불가


-- 삭제 안되는 이유
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- ORA-02292: integrity constraint (KH.SYS_C007066) violated - child record found
-- 원인 :D1을 참조하는 자식 데이터가 있어서

-- SYS_C007066 이 제약조건을 잠깐 비활성화 시킬 것임
ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT SYS_C007066 CASCADE; -- 제약조건 DISABLE로 비활성화 시킴

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1'; -- 1개 행 이(가) 삭제되었습니다.

ROLLBACK;

-- 제약조건 활성화
ALTER TABLE EMPLOYEE
ENABLE CONSTRAINT SYS_C007066;


------------------------------------------------------------------------------







------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



























