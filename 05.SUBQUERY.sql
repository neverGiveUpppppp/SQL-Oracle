`
/*

<SELECT문 실행순서 및 사용형식>
1. FROM 테이블명 - 조회 대상 컬럼이 있는 테이블명 기술
2. WHERE 컬럼명 연산자 조건 - 행을 선택하는 조건을 기술
3. GROUP BY 컬럼명 } 계산식 - 그룹묶을 컬럼명, 계산식 기술
4. HAVING 그룹함수 연산자 비교값 - 그룹묶은 값들을 그룹함수로 계산후 선택을 위한 조건기술
5. SELECT * | [DISTINCT] 컬럼명, 계산식 [AS] 별칭
6. ORDER BY 컬럼명 | 별칭 | 컬럼순서 [ASC] | DESC

------------------------------------------------------------------------------
------------------------------------------------------------------------------


05.SUBQUERY
메인 쿼리를 위해 '보조역할'을 하는 쿼리

쿼리 안에 쿼리가 속해있는 형태


기호 : 소괄호()


서브쿼리 유형
1)단일 행 서브쿼리
2)다중 행 서브쿼리
3)다중 열 서브쿼리
4)다중 행 다중 열 서브쿼리
5)상관 서브쿼리, 스칼라 서브쿼리 <- 얘네들은 잘몰라도


서브쿼리 위치
1)WHERE절
2)FROM절


*/

/*
종류
인라인 뷰, 스칼라 서브쿼리, 기타

SELECT절에 작성이 되면 스칼라 서브쿼리
FROM절에 작성되면 인라인 뷰 서브쿼리
*/    
    
-- 부서코드가 노옹철 사원과 같은 소속의 직원명단 조회
-- SUBQUERY 없이
-- 1)사원명이 노옹철인 사원의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; -- D9

--2) D9부서코드에 속해있는 직원 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; -- 선동일 송종기 노옹철
-- 1)2)를 합쳐서 한번에 해볼 것


-- SUBQUERY 적용
-- 최종적으로 궁금한 것을 메인쿼리로
-- 결론을 얻기 위해 돕는 쿼리를 서브쿼리로 둬야한다
-- 메인쿼리 2번 서브쿼리 1번
SELECT EMP_NAME  --궁금한 내용인 메인부터 작성
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D9' -- 위에서는 검색해서 D9을 알았지만 원래는 D9라는걸 모르기 때문에 노옹철사원의 부서코드를 받아올 수 있는 코드를 넣어야한다
WHERE DEPT_CODE = (SELECT DEPT_CODE         -- ORA-00936: missing expression
                    FROM EMPLOYEE           -- 서브쿼리 임을 알리기 위해 소괄호를 해줘야한다
                    WHERE EMP_NAME = '노옹철'); -- 선동일 송종기 노옹철
                

-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
-- 1)전 직원의 평균 급여를 먼저 알아야한다
-- 2) 평균 보다 많이 받는 직원 조회

--1)전 직원의 평균 급여를 먼저 알아야한다
SELECT AVG(SALARY)
FROM EMPLOYEE;  -- 3047662.60869565217391304347826086956522

-- 2) 평균 보다 많이 받는 직원 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522; -- 9행
--WHERE SALARY >AVG(SALARY); -- ERROR

-- 3) 1)+2)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE); -- 8행

------------------------------------------------------------------------------
------------------------------------------------------------------------------
/*
서브쿼리 유형
1)단일 행 서브쿼리
2)다중 행 서브쿼리
3)다중 열 서브쿼리
4)다중 행 다중 열 서브쿼리
5)상관 서브쿼리, 스칼라 서브쿼리 <- 얘네들은 잘몰라도됨



1)단일 행 서브쿼리 : 서브쿼리의 결과 수가 1개일 때(행 하나)
2)다중 행 서브쿼리 : 서브쿼리의 결과 수가 여러개 일 때
3)다중 열 서브쿼리 : 서브쿼리의 SELECT절에 나열된 항목 수가 여러개일 때 (다중 열이라는게 컬럼이 여러개는 의미)
4)다중 행 다중 열 서브쿼리 : 조회 결과 행 수와 열 수가 여러 개일 때
5)상관 서브쿼리, 스칼라 서브쿼리 <- 얘네들은 잘몰라도됨


EX)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE); -- 8행
-> 단일 행 서브쿼리 
전체 구문의 결과가 아닌 서브쿼리문에서의 결과 수에 따라이기에 1행이므로 단일 행 서브쿼리

*/

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 1)단일 행 서브쿼리
--일반 연산자를 많이 사용
--메인쿼리 조건절 WHERE문의 컬럼명과 서브쿼리 안 SELECT의 컬럼명 일치 필수

-- 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서코드, 직급코드 , 급여 조회
--1) 노옹철 사원의 급여
--2) 많이 받는 직원의 사번, 이름, 부서코드, 직급코드 , 급여

--1) 노옹철 사원의 급여
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; -- 3700000

--2) 많이 받는 직원의 사번, 이름, 부서코드, 직급코드 , 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3700000;

-- 3) 1)+2)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY -- WHERE SALARY랑 서브쿼리 안 SELECT의 SALARY랑 같아야한다. 컬럼명 일치 필수
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철'); -- 4행 : 200	선동일	D9	J1	8000000


SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE); -- 8행



-- 가장 적은 급여를 받는 직원의 사번, 이름, 직급코드, 부서코드, 급여, 입사일 조회
--1)가장 적은 급여
--2)가장 적은 급여를 받는 직원
SELECT MIN(SALARY)
FROM EMPLOYEE; -- 1380000

SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE); -- 214	방명수	J7	D1	1380000	10/04/04


-- 부서 별 급여 합계 중 가장 큰 부서의 부서명, 급여 합계
--1)급여 합계가 가장 큰 부서
--2)급여 합계가 가장 큰 부서의 부서명, 급여 합계

--1)부서별 급여 합계
SELECT MAX(SUM(SALARY)) -- 각부서별 합계를 SUM(SALARY)로 구하고 이중 가장 크다는 조건을 MAX로 처리
FROM EMPLOYEE
GROUP BY DEPT_CODE;     -- 17700000

--2)급여 합계가 가장 큰 부서의 부서명, 급여 합계
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE -- 지정한 그룹에서 급여 합계 조건을 걸기 위해 HAVING
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE); -- 총무부	17700000
                      
 
    
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 2)다중행 서브쿼리 
 일반 연산자 사용
 다중행 서브쿼리에서 써야하는 연산자를 사용해야함
 IN / NOT IN : 여러 개 결과 값 중 하나라도 일치하는 값이 있다면/없다면
 > ANY, < ANY : 여러 개 결과 값 중 하나라도 큰/작은 경우 ->가장 작은 값보다 크기만 하면된다/최대값보다 작냐
 > ALL, < ALL : 모든 값보다 큰/작은 경우 -> 최대값보다 크다/최소값보다 작다?                 // > <크다 작다 의미
 EXISTS/ NOT EXISTS : 값이 존재하는/존재하지 않는 경우

-- 전에 배웠던 IN과 같은 IN
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID IN(200,201,202,205);



-- 부서별 최고 급여를 받는 직원의 이름, 직급코드,부서코드 급여 조회
--1)부서별 최고 급여
--2) 1)을 이용하여 부서 별 최고 급여 받는 직원의 정보 조회

--1)부서별 최고 급여
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--2) 1)을 이용하여 부서 별 최고 급여 받는 직원의 정보 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)-- 서브쿼리가 다중 행
                FROM EMPLOYEE
                GROUP BY DEPT_CODE); -- 7행

-- 관리자와 일반 직원에 해당하는 사원 정보 추출 : 사번, 이름, 부서명,직급,구분(관리자/직원)
--1)관리자에 해당하는 사원 번호 조회
--2)관리자에 해당하는 직원 정보
--3)사원에 해당하는 직원 정보 조회
--4) 2,3을 합쳐야한다


--1)관리자에 해당하는 사원 번호 조회
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL; -- NULL은 필요없기에 제거

--2)관리자에 해당하는 직원 정보
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' 구분
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) -- DEPT_TITLE이 NULL인 직원이 안나오니 외부조인 추가 필요함
    JOIN JOB USING(JOB_CODE) -- 결과가 다나오기에 서브쿼리로 조건 붙이자
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL); -- 6행

--3)사원에 해당하는 직원 정보 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사원' 구분
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
    JOIN JOB USING(JOB_CODE) 
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID -- 관리자 아니면 나머지는 일반 사원일테니 NOT IN으로 처리
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL); -- 17행
                        
 --4) 2,3을 합쳐야한다
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' 구분
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);
UNION -- OR 써서 바꿀 수도 있겠지만 엄청 복잡할테니 간단하게 UNION으로 해결
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사원' 구분
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
    JOIN JOB USING(JOB_CODE) 
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID -- 관리자 아니면 나머지는 일반 사원일테니 NOT IN으로 처리
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);

-- SELECT절에도 서브쿼리가 들어갈 수 있다
-- CASE WHEN 버젼
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
        CASE WHEN EMP_ID IN(SELECT DISTINCT MANAGER_ID
                                    FROM EMPLOYEE
                                    WHERE MANAGER_ID IS NOT NULL) THEN '관리자'
            ELSE '직원'
        END 구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE); -- 23행


-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의 사번, 이름, 직급, 급여 조회
--1)대리 직급
--2)과장직급의 최소급여
--3)과장직급의 최소급여보다 많이 받는 직원정보

----1)대리 직급
--SELECT JOB_CODE, JOB_NAME
--FROM JOB
--WHERE JOB_CODE = 'J6';
--
----2)과장직급의 최소급여
--SELECT SALARY, MIN(SALARY)
--FROM EMPLOYEE, G
--GROUP BY JOB;

-- 모범 답안
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='대리'
    AND SALARY > (SELECT MIN(SALARY)
                        FROM EMPLOYEE
                                JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '과장'); -- 5행


-- 최소급여보다 크다 -> ANY로 표현 가능
-- 모범 답안
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
    AND SALARY > ANY(SELECT SALARY -- ANY 사용
                    FROM EMPLOYEE
                        JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '과장'); -- 5행

                        
-- 차장 직급의 급여 중 가장 큰 값보다 많이 받는 과장 직급의 사번, 이름, 직급, 급여 조회
-- 일반연산자 없이 작성
--1) 차장 직급의 최대 급여
--2) 보다 많이 받는 과장 직급의 정보

----1) 차장 직급의 최대 급여
--SELECT MAX(SALARY)
--FROM EMPLOYEE
--GROUP BY JOB_CODE
--HAVING JOB_CODE = 'J4'; -- 2800000

-- 모범 답안
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
        AND SALARY > (SELECT MAX(SALARY)
                        FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '차장'); -- 215	대북혼	과장	3760000

-- 가장 큰값보다 크다 -> ALL 사용
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
        AND SALARY > ALL (SELECT SALARY
                        FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '차장'); -- 215	대북혼	과장	3760000





------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- 다중 열 서브쿼리

-- 서브쿼리의 SELECT절에 나열된 항목 수가 여러개일 때 (다중 열이라는게 컬럼이 여러개는 의미)



-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급 코드, 부서코드, 입사일 조회
--1)퇴사한 여직원의 부서, 직급
--2)이에 해당하는 사원 정보

--1)퇴사한 여직원의 부서, 직급
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO,8,1) = 2; -- 1행 2열 : D8	J6 <- 열이 여러개라 다중 열
        
--2)퇴사한 여직원과 같은 부서/직급((D8/J6)에 해당하는 사원 정보 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2) -- 3행 4열 // 셋 중 한명은 퇴사한 여직원. 지워주자.
    AND EMP_NAME != (SELECT EMP_NAME -- 퇴사한 여직원 정보 제거 코드
                    FROM EMPLOYEE
                    WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8,1)=2); -- 2행 4열 // 장쯔위	J6	D8	15/06/17 전형돈	J6	D8	12/12/12


-- 다른 버전
-- 같은 부서, 직급
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2)
        AND JOB_CODE = (SELECT JOB_CODE
                        FROM EMPLOYEE
                        WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2)
        AND EMP_NAME != (SELECT EMP_NAME
                        FROM EMPLOYEE
                        WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2); -- 2행 4열 : 장쯔위	J6	D8	15/06/17 전형돈	J6	D8	12/12/12




------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 다중 행 다중 열 서브쿼리

-- 조회 결과 행 수와 열 수가 여러 개일 때

-- 자기 직급의 평균 급여를 받고 있는 직원의 사번 이름, 직급코드, 급여 조회
-- 단, 급여 평균은 십만원 단위로 계산 : TRUNC(컬럼명, -5)
--1)자기 직급의 평균 급여
--2)이 직원들의 사번 이름, 직급코드, 급여 조회

--1)자기 직급의 평균 급여
-- 직급 평균 급여가 자기 급여와 맞는지도 확인필요
SELECT JOB_CODE, TRUNC(AVG(SALARY),-5)
FROM EMPLOYEE
GROUP BY JOB_CODE;


--2)이 직원들의 사번 이름, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY),-5)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE); -- 2행 4열 : 210	윤은해	J7	2000000



------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- 인라인 뷰 
--FROM절에 서브쿼리 사용하는 것
-- 많이 씀

-- 인라인 뷰 예시
SELECT *
FROM(SELECT EMP_NAME, SALARY, BONUS -- FROM절 서브쿼리 = 인라인 뷰
     FROM EMPLOYEE);

-- SELECT *로 전체 조회라해도 FROM절부터 조건을 먹여서 원하는 것만 데이터를 SELECT *로 보내니 전체가 다 나오지 않는다


-- ROWNUM
-- 순위 설명
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; 
-- ROWNUM은 모든 셀렉트절에 숨어 있다.
-- 질의 결과로 맨 왼쪽에 뜨는 1 2 3 숫자들을 따로 뽑고 싶다면(?)
-- ROW NUM 사용
-- 조회된 행에 대해 1부터 번호를 매겨있음(행 번호)


--별도의 ORDER BY 절을 기술하지 않는다면, 내부적으로 ROWNUM의 순서에 따라 정렬
--ROWNUM은 내부적으로 이미 부여받은 값이기 때문에 ORDER BY 절을 통해 순서를 바꾸더라도 값은 변하지 않는다
-- ex)
SELECT ROWNUM, EMP_NO, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;




-- 전 직원 중 급여가 높은 상위 5명의 순위,이름, 급여 조회
--1) 급여 상위 5명

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE 
WHERE ROWNUM <= 5
ORDER BY SALARY DESC; -- 5행 출력
-- ROWNUM이 내림차순 정렬이 안되어 있다. 물론 SALARY는 잘되어있음

-- WHERE절 빼면 차이는?
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE 
ORDER BY SALARY DESC; -- 23행 출력
-- 5행과 23행 출력 그리고 순서 정렬 안맞음. 
-- WHY?
-- ROWNUM은 번호가 매겨주는건데 FROM절에서 번호를 매긴다 ★★★★★
-- 판이 다 깔리고 ROWNUM이 이때 생성됨

/*
SELECT문의 실행순서
1)FROM : 판깔기
2)WHERE : 조건
3)GROUP BY
4)HAVING
5)SELECT
6)ORDER BY

판이 깔리면 ROWNUM이 생성됨
SALARY 기준 내림차순 정렬
로우넘이 이미 생성되고 ORDER BY에 따라서 정렬이 마지막이라 로우넘 생성 후 다시 재정렬하기에
로우넘이 섞일 수 밖에 없음
로우넘을 이용할려면 프롬절에서부터 붙으므로 프롬절에서부터 급여로 내림차순이 되어있도록 프롬절을 바꾸면 된다
이때 인라인 뷰를 이용해서 프롬절에 서브쿼리를 만들어줘서 해결가능

인라인뷰는 1회성의 서브쿼리이다. 보통 FROM절에서 사용하며, 
테이블처럼 취급하면 된다.

상위 몇명 이러면 로우넘 필수
프롬절에서 로우절 붙음
->그럼 뭘해야할까?
->프롬절에서 급여로 정렬 // 판을 내가 원하는데로 미리 깔아주는 것 // 4:00-4:10 강의시간

*/
-- 인라인 뷰 예시
SELECT *
FROM(SELECT EMP_NAME, SALARY, BONUS -- FROM절 서브쿼리 = 인라인 뷰
     FROM EMPLOYEE);

-- SELECT *로 전체 조회라해도 FROM절부터 조건을 먹여서 원하는 것만 데이터를 SELECT *로 보내니 전체가 다 나오지 않는다
-- 

-- 강의시간
-- 4:13-20
SELECT *
FROM(SELECT EMP_NAME 이름, SALARY, BONUS -- FROM절 서브쿼리 = 인라인 뷰
     FROM EMPLOYEE --23행
     WHERE EMP_NAME LIKE '%송%')
WHERE EMP_NAME = '송종기';
--WHERE 이름 = '송종기';
--WHERE EMP_ID = 201; -- ERROR

SELECT SALARY, 이름
FROM(SELECT EMP_NAME 이름, SALARY, BONUS -- FROM절 서브쿼리 = 인라인 뷰
     FROM EMPLOYEE --23행
     WHERE EMP_NAME LIKE '%송%')
WHERE 이름 = '송종기';




-- 전 직원 중 급여가 높은 상위 5명의 순위, 이름, 급여 조회
SELECT ROWNUM, *    -- ERROR : ORA-00936: missing expression // 애초에 받을 수 없는 문법
FROM(SELECT EMP_NAME, SALARY -- 컬럼이 너무 많으면 아스트로 써야할 때는 어떻게 할까?
    FROM EMPLOYEE 
    ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

SELECT ROWNUM, MYFROM.*           -- 별칭 사용하면 아스트로* 사용가능
FROM(SELECT EMP_NAME, SALARY      -- 컬럼이 너무 많으면 아스트로 써야할 때는 어떻게 할까?
    FROM EMPLOYEE 
    ORDER BY SALARY DESC) MYFROM  -- 별칭 사용하면 아스트로* 사용가능
WHERE ROWNUM <= 5;  -- 5행 : 로우넘&급여 둘 다 정렬됨


-- 모범 답안
SELECT ROWNUM, EMP_NAME, SALARY
FROM(SELECT EMP_NAME, SALARY
     FROM EMPLOYEE
     ORDER BY SALARY DESC )
WHERE ROWNUM <= 5;
-- 별칭 추가
SELECT ROWNUM 순위,이름,급여
FROM(SELECT EMP_NAME 이름, SALARY 급여
     FROM EMPLOYEE
     ORDER BY 급여 DESC )
WHERE ROWNUM <= 5;

 -- 안에 있는 컬럼 하나하나 지정안해도 되는 방법
SELECT ROWNUM, EMP_NAME , SALARY
FROM(SELECT  * -- 서브쿼리 SELECT * 처리
     FROM EMPLOYEE
     ORDER BY SALARY DESC )
WHERE ROWNUM <= 5;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
/*
-- RANK() OVER / DENSE_RANK() OVER
순위를 매기는 함수
-- 뭐를 가지고 순위를 매길건지 OVER뒤에 기술. RANK()는 비워둘 것

 둘의 차이
 공동순위 이후에 다음번호 차이
 RANK() OVER : 동일한 순위 이후의 등수를 동일한 인원 수만큼 건너뛰고 계산
      ex)19위 2명 이후 다음 등수 21위
 DENSE_RANK() OVER : 중복되는 순위 이후의 등수를 바로 다음 등수로 계산
      ex) 19위 2명 이후 다음 등수 20위

*/

-- RANK() OVER
SELECT RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY -- 정렬 기준을 오버뒤에 기술
FROM EMPLOYEE; -- 23행 : 1	선동일	8000000
-- FROM절에도 사용가능. 굳이 인라인뷰를 사용할  필요X
-- 19위 2명 이후 다음 등수 21위

------------------------------------------------------------------------------


-- DENSE_RANK() OVER
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
FROM EMPLOYEE;
-- 19위 2명 이후 다음 등수 20위











------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------







