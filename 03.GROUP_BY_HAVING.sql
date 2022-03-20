

/*

함수(FUNCTION)

함수(FUNCTION) 두 종류
A.단일 행 함수
B.그룹 함수

A.단일 행 함수
    1.문자 관련 함수 : LENGTH, INSTR,LPAD,LTRIM,TRIM,SUBSTR, CONCAT,REPLACE
    2.숫자 관련 함수 : ABS,MOD,ROUND,CEIL,FLOOR/TRUNC
    3.날짜 관련 함수 : MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY,LAST_DAT,EXTRACT
    4.형변환 함수 : TO_CHAR, TO_DATE, TO_NUMBER
    5.null처리 함수 : NVL, NVL2, NULLIF 
    6.선택 함수 : DECODE, CASE WHEN THEN
B.그룹함수
SUM, AVG, MIN/MAX, COUNT

-----------------------------------------------------------------------
-----------------------------------------------------------------------

<SELECT문의 구조>
SELECT
FROM
WHERE 
GROUP BY
HAVING
ORDER BY

<SELECT문의 구조>
SELECT : 컬럼명 AS 별칭, 계산식, 함수식       -> 조회하고자 하는 컬럼 기술
FROM : 테이블 명                           -> 컬럼이 속해 있는 테이블 기술
WHERE : WHERE 컬럼명|함수식 비교연산자 비교값 -> SELECT에 조건식 설정
GROUP BY : 그룹으로 묶을 컬럼명              -> 그룹함수가 적용될 그룹 기술
HAVING : 그룹함수식 비교연산자 비교값         -> 그룹함수에 조건식 설정
ORDER BY : 컬럼명|별칭|컬럼 순번 정렬방식 [NULLS FIRST | LAST]; -> 정렬 조건 기술
    - SELECT에서 별칭을 써두었다면, 별칭으로도 정렬 가능


<실행순서>
1)FROM : 실행해서 판을 깔고
2)WHERE : 조건 추려내고 보고 싶은 컬럼들만 취함
3)GROUP BY
4)HAVING
5)SELECT
6)ORDER BY

<SELECT문 실행순서 및 사용형식>
1. FROM 테이블명 - 조회 대상 컬럼이 있는 테이블명 기술
2. WHERE 컬럼명 연산자 조건 - 행을 선택하는 조건을 기술
3. GROUP BY 컬럼명 } 계산식 - 그룹묶을 컬럼명, 계산식 기술
4. HAVING 그룹함수 연산자 비교값 - 그룹묶은 값들을 그룹함수로 계산후 선택을 위한 조건기술
5. SELECT * | [DISTINCT] 컬럼명, 계산식 [AS] 별칭
6. ORDER BY 컬럼명 | 별칭 | 컬럼순서 [ASC] | DESC

*/

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- ORDER BY
-- 정렬
-- 오름차순 ASC / 내림차순 DESC
--   생략 가능  /   생략 불가
-- 오름차순에서 NULL은 마지막에 배치
-- 내림차순에서 NULL은 첫 배치

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
--ORDER BY EMP_NAME ASC;   -- 이름으로 오름차순(ASC)
--ORDER BY EMP_NAME;       -- ASC는 생략가능. 
--ORDER BY EMP_NAME DESC;  -- DESC는 생략 불가. 명시적
--ORDER BY DEPT_CODE;      -- NULL이 들어가 있는 값은 나중에 배치한 상태로 오름차순
ORDER BY DEPT_CODE DESC NULLS FIRST; -- NULL을 먼저 배치 후 내림차순
ORDER BY DEPT_CODE DESC NULLS LAST;  -- 오름차순일 때는 NULL을 나중에 배치하는게 기본, 내림차순일 때는 NULL을 먼저 배치하는게 기본

-- 별칭으로 정렬해보자
SELECT EMP_ID, EMP_NAME, SALARY 급여, DEPT_CODE -- 급여 : 별칭
FROM EMPLOYEE
--ORDER BY SALARY;
ORDER BY 급여;
ORDER BY 급여 DESC;
ORDER BY 2 DESC; -- 2는 EMP_NAME 대해
ORDER BY 3 DESC; --  3은 SALARY에 대해 내림차순
-- 셀렉트가 오더바이보다 먼저 진행. 그래서 별칭을 읽어올 수 있는 것. 아래 실행순서 참조
-- ORDER BY 이외에 별칭을 읽을 수 있는게 없다. 코드 내 실행 순서 때문
-- 별칭은 컬럼이 아니라 없는 데이터를 가져올려하니 에러 : invailid identifier

/*
실행순서
1)FROM부터 실행해서 판을 깔고
2)WHERE 통해서 조건 추려내고
보고 싶은 컬럼들만 취함
3)GROUP BY
4)HAVING
5)SELECT
6)ORDER BY
*/


------------------------------------------------------------------------------
------------------------------------------------------------------------------
--------------------------------GROUP BY--------------------------------------
------------------------------------------------------------------------------


-- GROUP BY
-- 그룹함수으로 묶을 기준을 제안하는 것
-- 그룹함수가 적용될 그룹 기술


-- 부서 별 급여 합계 조회
SELECT SUM(SALARY), DEPT_CODE -- ERROR : not a single-group group function
FROM EMPLOYEE; -- 위 메세지에서의 SINGLE은 여러행 그룹은 ...?
-- 싱글과 그룹 함께 사용할 수 없다는 의미 // 결과가 하나만 나와야하는 그룹함수인데 여러행이 나오는 단일 행 함수와 혼용 불가
-- 싱글 : SUM(SALARY)
-- 그룹 : DEPT_CODE

-- 부서 별 급여 합계한다고하면 먼저 부서별로 그룹부터 나눌 것
-- 각각의 부서 그룹의 샐러리 합계 구해나아갈 것. 
-- 컴한테 어떤 것들을 그룹 지을지 알려줘야 계산할 수 있다

-- 각 그룹으로 묶게 될 것은 DEPT_CODE



SELECT SUM(SALARY), DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- DEPT_CODE로 그룹 짓는다
--ORDER BY DEPT_CODE; -- 순서까지 정렬해서 보고 싶으면 ORDER BY 추가



-- EMPYLOEE테이블에서 부서 별 급여 합계, 급여 평균, 인원 수를 조회
SELECT DEPT_CODE, SUM(SALARY), AVG(SALARY), COUNT(*) -- ERROR : not a single-group group function
FROM EMPLOYEE;
-- DEPT_CODE : 일반 함수
-- SUM, AVG, COUNT는 그룹함수
-- 위의 둘은 같이 쓸 수 없다
SELECT DEPT_CODE, SUM(SALARY), AVG(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;  -- 그룹화 할 때는 그룹화의 기준이 되는 컬럼은 가능해보임

-- BONUS로 그룹지어보기
SELECT BONUS, SUM(SALARY)합계, AVG(SALARY) 평균, COUNT(*) 수
FROM EMPLOYEE
GROUP BY BONUS; 
SELECT BONUS, SUM(BONUS), AVG(BONUS), COUNT(*)
FROM EMPLOYEE
GROUP BY BONUS; 
-- 그룹지어지는 대상과 일반함수와 같아야한다. 
-- GROUP BY에 넣을 컬럼명과 SELECT 오른쪽 컬럼명이 같아야함


-- EMPLOYEE테이블에서 부서코드와 보너스 받는 사원수 조회
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 보너스가 NULL이라도 0으로 출력


SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL -- 결과에 어떤 영향이? 
GROUP BY DEPT_CODE      -- D2부서에서 보너스 받는 사람이 없는데 이게 안나옴. 위와 대조됨
ORDER BY DEPT_CODE;

SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
--WHERE BONUS IS NOT NULL -- WHERE절이 없으면 COUNT(*)는 사람수를 카운트함
GROUP BY DEPT_CODE;  

--EMPLOYEE테이블에서 직급코드, 보너스를 받는 사원수 조회
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE90
GROUP BY JOB_CODE;
-- 보너스 안받는 사람을 안보고 싶다면, WHERE BONUS IS NOT NULL 추가 



--EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리(보통 내림하라는 의미)), 급여합계, 인원 수 조회(인원수로 내림차순)
-- 데이터에 직접적으로 없는 데이터를 GROUP BY해서 평균,합계,수 조회해야함, COUNT(*) 인원수, 
--SELECT SUBSTR(EMP_NO,8,1), FLOOR(AVG(SALARY)), SUM(SALA
SELECT SUBSTR(EMP_NO,8,1), FLOOR(AVG(SALARY)), SUM(SALARY)RY), COUNT(SALARY) 인원수, 
        CASE WHEN SUBSTR(EMP_NO, 8,1) = 1 THEN '남'
             WHEN SUBSTR(EMP_NO, 8,1) = 2 THEN '여'
             END "성별"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1) -- 문자를 반환하니 컬럼명 대체가능인듯
ORDER BY 인원수 DESC;
--ORDER BY 4 DESC;
--ORDER BY COUNT(SALARY)DESC;

-- 모범 답안
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'남','여') 성별, 
        FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) 인원수
FROM EMPLOYEE
--GROUP BY SUBSTR(EMP_NO,8, 1)
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),1,'남','여')
ORDER BY 인원수 DESC;


-- EMPLOYEE테이블에서 부서 코드별로 같은 직급인 사원의 급여 합계 조회
-- 부서별, 동 직급별 2개의 그룹핑 필요
-- 모범 답안
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE;
--ORDER BY DEPT_CODE;


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
GROUP BY JOB_CODE; -- ERROR : Only one clause allowed per query block




------------------------------------------------------------------------------
------------------------------------HAVING------------------------------------
------------------------------------------------------------------------------

-- HAVING
-- 조건절
-- 비슷 = WHERE
-- 차이 WHERE 대상 일반 컬럼
--     HAVING 대상 GROUP BY의 데이터


-- 1)부서 코드와 급여 3000000이상인 직원의 그룹 별 평균 급여 조회
-- 2)부서 코드와 급여 평균 3000000이상인 그룹 별 평균급여 조회

-- 1)부서 코드와 급여 3000000이상인 직원의 그룹 별 평균 급여 조회
-- 모범 답안
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000 
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


-- 2)부서 코드와 급여 평균 3000000이상인 그룹 별 평균급여 조회
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000 -- ERROR : group function is not allowed here
GROUP BY DEPT_CODE;

-- 모범답안
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;


SELECT DEPT_CODE, SALARY, AVG(SALARY), COUNT(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, SALARY -- 샐러리도 추가 그룹핑. 없을 때랑 결과값이 나오는 로직 차이는?
HAVING AVG(SALARY) >= 3000000;


-- 부서 별 급여 합계 중 900000을 초과하는 부서코드와 급여 합계 조회
-- 모범 답안
SELECT DEPT_CODE, SUM(SALARY) -- 부서코드와 급여 합계 조회라 셀렉트로 조회할 항목 2개
FROM EMPLOYEE
GROUP BY DEPT_CODE      -- 어떨 때 그룹을 복수로 나누지?
HAVING SUM(SALARY) > 900000
ORDER BY DEPT_CODE;


------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- ROLLUP, CUBE
-- 집계 함수 : 그룹별 산출한 결과물을 집계하는 함수
-- 집계 함수를 쓴다는건 산출한 결과물들을 가지고 집계해주는거 맞구나 생각드는데 근데
--
-- 롤업 큐브 차이점
-- 롤업은 인자로 전달받은 것 중 첫번째 한번만 집계
-- 큐브는 인자로 지정된 모든 것들에 대해 중간 집계
--      ex)ROLLUP : GROUP BY로 그루핑된 첫그룹의 종류별로 합계 반환
--      ex)CUBE : GROUP BY로 그루핑된 첫그룹의 종류별로 합계 반환한 후, 두번째 그룹의 합계 또 반환

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
--GROUP BY JOB_CODE           -- 각 직급 코드별 합계 7행
--GROUP BY ROLLUP(JOB_CODE) -- 롤업이나 큐브코드 추가시 행이 하나 더 생김. 마지막행의 데이터는 총합
GROUP BY CUBE(JOB_CODE) --
ORDER BY JOB_CODE;


--EMPLOYEE테이블에서 각 부서코드마다 직급코드 별 급여 합, 부서 별 급여 합, 총합 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;


-- ROLLUP
-- 그룹별로 중간 집계처리하는 함수
-- 인자로 전달받은 그룹 중 가장 먼저 지정한 그룹에만 중간 집계처리
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- CUBE
-- 그룹별 산출한 결과를 집계하는 함수
-- 롤업은 인자로 전달받은 것 중 첫번째 한번만 집계
-- 큐브는 인자로 지정된 모든 것들에 대해 중간 집계

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY JOB_CODE;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------SET OPERATION----------------------------------
------------------------------------------------------------------------------


-- SET OPERATION : 집합 연산자
-- 두 개 이상의 테이블에서 조인을 사용하지 않고 연관된 데이터를 조회하는 방법

-- 종류
-- UNION : 합집합 OR조건
-- INTERSECT : 교집합 AND조건
-- MINUS : 차집합 A-B
-- 쿼리의 결과와 쿼리의 결과를 하나로 합쳐 해당 함수의 적용, 결과를 반환

-- 합집합 A OR B
-- 교집합 A AND B 공통분모
-- 차집합 A - B
-- 여집합 A B를 제외한 나머지

-- UNION : 합집합 OR조건
-- INTERSECT : 교집합 AND조건
-- MINUS : 차집합 A-B
-- UNION ALL : AND조건 + OR조건(중복된 행 추가조회)
-- 

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- UNION : 합집합
-- 두 쿼리를 결과를 하나로 합쳐 OR조건으로 반환
-- 왜 사용? WHERE절에 조건을 다 쓰거나 OR로 처리하기 힘들 경우
-- UNION 미적용
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200; -- 선동일
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201; -- 송종기
-- UNION 적용
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200 
UNION
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201; -- 선동일 ,송종기
--같은방법
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201 OR EMP_ID = 200; -- 선동일 ,송종기


-- EMPLOYEE테이블에서 DEPT_CODE가 D5이거나 급여가 300000을 초과하는 
-- 직원의 사번, 이름, 부서코드, 급여조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 300000;
-- UNION 적용
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 300000;

------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- INTERSECT : 교집합
-- 쿼리의 결과와 쿼리의 결과를 하나로 합쳐 OR조건 적용, 결과를 반환
-- INTERSECT 사용
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 300000;

--집합연산자에서 SELECT 절은 동일해야 되고 FROM절은 달라도 대나요?
-- 가능
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_ID_200
UNION
SELECT JOB_CODE
FROM JOB
WHERE JOB_NAME = '대리';

------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- MINUS : 차집합
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- DEPT코드가 D5이면서 연봉이 3000000초과인 사람을 도출하는 코드

-- UNINON ALL
-- 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------






















------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------









