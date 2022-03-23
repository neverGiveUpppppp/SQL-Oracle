/*

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


-- 04.JOIN ★★★


---- <JOIN의 필요성> ----
-- 사번, 사원명, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;
-- Q.김혜수씨는 어떤 부서에 속해있나요? 
-- A.D5요. 근데 D5는 무슨 부서일까? 
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT; -- D1-9까지 부서 타이틀 반환
-- 해외영업1부
-- 여러 절차를 걸쳐 조회하기에 불편
-- EMPLOYEE 테이블만 가지고는 내가 원하는 정보를 다 얻기가 어렵다

/*
JOIN이란?
하나 이상의 테이블에서 데이터를 조회하기 위해 사용
여러개의 테이블들을 연결하여 데이터를 조회



<JOIN 세부 종류>
1.내부 조인
데이터가 ‘같은 부분’끼리 연결
위의 특성 때문에 해당하지 않는 데이터는 제외하고 반환됨
    1)오라클 전용구문 
        FROM절에 해당 테이블 모두 기술
        테이블끼리 연결하는 부분은 WHERE을 통해 연결
    2)ANSI 표준구문
        FROM절에 해당되는 테이블 모두 기술
        JOIN 구문 이용 
            JOIN + ON : 두 데이터값이 다른 이름일 때
            JOIN + USING : 두 데이터값이 같은 이름일 때
            but, 이름이 같더라도 JOIN + ON 사용가능

2.외부 조인
데이터가 같지 않은 행도 조인에 포함
내부 조인의 공통 데이터만 추출하는 특성에서 한쪽만 충족하는 데이터를 더 가져 올 수 있게 한 조인
    1)오라클 전용구문
        맞춰주는 테이블(기준이 아닌 테이블)의 컬럼 쪽에 (+)
    2)ANSI 표준구문 : 좀 더 LEFT, RIGHT 직관적
        LEFT OUTER JOIN
        RIGHT OUTER JOIN
        FULL OUTER JOIN : 양쪽 다 기준
        (OUTER)는 생략 가능


*/

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--1.내부조인(Inner join)
--    1)오라클 전용 구문
--          컬럼명이 같으면 어느 테이블 컬럼인지 지정해줘야함 : 테이블명.컬럼명으로 지정
--    2)ANSI 표준 구문
--          내가 연결할 컬럼의 이름이 다를 때 = ON 사용
--          내가 연결할 컬럼이 이름이 같을 때 = USING 사용
--               컬럼 이름이 같다고 해서 무조건 USING 사용? X  


-- 사번, 이름, 부서코드, 부서명
-- 오라클 전용 구문

SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID -- 결과값 21개. 부서코드가 NULL인 직원은 제외됨. INNER JOIN의 한계. 
ORDER BY DEPT_ID;         -- OUTER JOIN으로 보완 가능


-- ANSI 표준 구문
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE              
    JOIN DEPARTMENT; -- ERROR : missing keyword

SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE               -- 오라클 전용구문과 차이
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); -- JOIN과 ON 세트로 같이써야함
                                             -- WHERE절이 조건절인건 여전함


-- 사번, 사원명, 직급코드, 직급명 // 각 사원에 대한 직급명 조회
-- 오라클 전용 구문
-- ANSI 표준 구문
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);


-- 모범 답안
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE,JOB_NAME
FROM EMPLOYEE, JOB     /*JOB.JOB_CODE도 가능*/               
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;  -- 23행 // 200	선동일	J1 

 
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE 
    JOIN JOB ON(EMPLOYEE.JOB_CODE = JOB.JOB_CODE);
             /*JOB.JOB_CODE도 가능*/
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
    JOIN JOB USING(JOB_CODE); -- USING으로 대체 가능
                              -- USING이 같은 컬럼명 쓴다는걸 명시하기에 테이블 명시필요X


-- 테이블명 EMPLOYEE가 길어서 별칭을 연결해서 사용해보자
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_NAME
FROM EMPLOYEE E, JOB J    /*JOB.JOB_CODE도 가능*/               
WHERE E.JOB_CODE = J.JOB_CODE;

-- 부서명과 해당 부서의 지역명 조회
-- 오라클 전용 구문
-- ANSI 표준 구문


-- 모범답안
SELECT DEPT_TITLE,  LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
     JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

---RE
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
    JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE);




------------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------2.외부조인(Outer join)-----------------------------
------------------------------------------------------------------------------
/*
내부 조인의 한계
매칭이 안되는 값이 있으면 조인해서 가져올 수 없는 한계
내부조인 개념이 일치하는 것을 가져오는 것

 2.외부조인(Outer join)
 컬럼 값이 일치하지 않는 행도 조인에 포함시킴
 아우터 조인은 무조건 명시해야함. 이너조인과 헷갈릴 수 있기 때문

★양쪽 테이블의 매칭된 데이터 + 가져오길 원하는 한쪽 집합의 데이터★

종류
1.LEFT (OUTER) JOIN
2.RIGHT (OUTER) JOIN
3.FULL (OUTER) JOIN
    - 오라클 구문은 풀아우터 조인 사용불가
- (OUTER) : 생략가능
    

*/ 

-- INNER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); -- 21행 : DEPT_CODE가 NULL인 사람은 제외(매칭X)
    

--1.LEFT (OUTER) JOIN

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- DEPT_ID(+)
-- 기준점이 되는 테이블이 아닌 JOIN되는 테이블에 (+) 추가

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE -- 기준 : EMPLOYEE 테이블
    LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 23행 : NULL 2개 -> 22 이오리 23 하동운 NULL


-- 내부조인과 차이
-- 내부조인에서는 부서코드가 NULL인 직원은 제외되고 21행 나왔지만
-- LEFT OUTER JOIN은 NULL인 직원 2명도 포함했기에 23행 출력
 
/* 
내 기준으로 왼쪽에 있는 얘를 기준으로 삼겠다
즉 EMPLOYEE가 기준
디파트가 임플한테 맞춰주는 것. 
그래서 오라클 전용구문에서 표기가 기준점이 되는 테이블이 아닌 조이하는 테이블(+) 붙임
ex)WHERE DEPT_CODE = DEPT_ID(+);


<강사쌤 설명>
--레프트 라이트 조인 기준으로 왼쪽이면 임플로이 오른쪽이면 디파트
--레프트는 임플이 기준이라 임플로이 전부를 출력함(23개행). 내부조인 하면 하동운,이오리 안나옴.
--임플이 기준이라 NULL값도 출력을 해줌
--디파트가 임플 맞춰줘야함->23개행이 나올 수 있도록 

<내가 한 이해>
레프트 라이트 조인 기준으로 왼쪽이면 임플로이 오른쪽이면 디파트
임플로이에는 EMP_NAME에서 사원명 가져오는데 이게 23명이고,
디파에서는 DEPT_TITLE에서 부서명 가져오는데 이건 21개. 부서배정이 아직인 2명이
NULL로 나오는데 임플 기준이라 23행 맞춰줘야하니 부서명이 없는 2명은 NULL로 표시

 
Q.EMPLOYEE안에 DEPT_CODE가 있으니까 DEPT_CODE안에 NULL이 있어도 일단 쓰고, 
  DEPARTMENT를 DEPT_CODE에 맞춰서 나온거죠,,?
A.YES

*/

 
 
--2.RIGHT (OUTER) JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT     -- 기준점 : DEPARTMENT 테이블
WHERE DEPT_CODE(+) = DEPT_ID; -- EMPLOYEE의 DEPT_CODE에 (+)추가
                              -- 맞춰주는 쪽한테 (+)를 추가시키는 것. 즉 기준이 아닌 쪽에 추가
-- 24행 출력 : (NULL) 해외영업3부 (NULL) 마케팅부 (NULL) 국내영업부
-- NULL 3개

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    RIGHT OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);--24개행 // NULL 3개 포함
       -- OUTER 생략가능
       
---RE
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;
       
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
       
/*
Q.
그니까 내부조인으로는 원래 양쪽테이블에 일치하는 값만 가져왔는데
즉 교집합 AND 조건이었는데
레프트나 라이트는 두 테이블 중 하나의 조건만 맞아도
가져온다는거가 핵심 개념 맞나요?
A. 교집합이 아닌 매칭시켜주는 개념
★양쪽 테이블의 매칭된 데이터 + 가져오길 원하는 한쪽 집합의 데이터★
까지 출력해서 23행,24행 나온
LEFT는 왼쪽 기준점이라해서 employee 가져온거고
RIGHT는 오른쪽 department를 기준으로 잡아서 21행보다 행이 더 나온
*/


--3.FULL (OUTER) JOIN
-- 둘 다 기준이 된다
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE(+) = DEPT_ID(+); -- ERROR :  a predicate may reference only one outer-joined table
-- 오라클 구문으로는 기준을 하나만 정할 수 있어 풀아우터조인은 사용불가


SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); --26개행 //NULL3개//
                                    -- 부서가 정해지지않은 사원 + 부서에 직원이 없는 부서도 포함
-- 26행 출력 : 
-- LEFT의 부서배정안된 22이오리23하동운 NULL 데이터 + RIGHT의 부서만 있고 직원 없는 
-- (NULL) 해외영업3부,마케팅부,국내영업부해서 
-- 내부조인 결과 21행에 LEFT 2행+ RIGHT 3행 = 21+2+3= 총26행


---RE
-- 오라클 전용구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);
-- ANSI 표준구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-------------------------------다른 JOIN 종류----------------------------------
------------------------------------------------------------------------------

/*
다른 JOIN 종류
다중 조인, 교차 조인(CROSS JOIN = CARTESIAN PRODUCT), 비등가 조인(NON-EQUI JOIN), 자체(SELF) 조인 등 있다.
다중 조인이 가장 중요하고 많이 사용
교차조인 거의 안쓰고, 자체(SELF)조인은 심심치 않게 보인다


내부,외부 조인 = 등가 조인
데이터가 같은 부분끼리 연결해서 쓰기에 등가 조인

※ 등가란? 
가치나 중요도가 동등


<비등가 조인>
크다 작다 > <와 같이 어떤 범위 안에 들어가 있게끔 하는게 비등가 조인

전제 : EMPLOYEE TABLE에 SAL_GRADE.SAL_LEVEL이 없다
        (SAL_GRADE 컬럼 안에 SAL_LEVEL데이터가 없다면?)
목적 : EMPLOYEE TABLE에 SAL_GRADE.SAL_LEVEL이 없다는 전제하에 
        급여 등급을 보고 싶다
SAL_GRADE하고 조인할 예정
*/

SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL
FROM EMPLOYEE
    JOIN SAL_GRADE ON(SALARY >= MIN_SAL AND SALARY <= MAX_SAL);
-- 범위로 들어가게 만들었기에 비등가 조인
--    JOIN SAL_GRADE ON(SALARY BETWEEB MIN_SAL AND MAX_SAL); -- BETWEEN AND로 대체가능

---RE
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE S
WHERE SALARY >= S.MIN_SAL AND SALARY <= S.MAX_SAL;
-- 오라클 구문은 비등가 조인 안됨?
========================
========================


------------------------------------------------------------------------------
------------------------------------------------------------------------------

/*
<자체(SELF) 조인>
자체(SELF)조인 : 내가 나의 테이블에 조인하는 것

조인 : 하나 이상의 테이블을 연결해서 조회하는 것
    - 자체 조인 때문에 하나 이상이라고 한 것. 지금까지 배운건 다 2개였지만


*/

-- 각 사원들의 관리자 조회
-- EMP 테이블에서 EMP_ID랑 MANAGER_ID 체크해보자
-- 풀이 과정
SELECT EMP_ID, EMP_NAME 사원이름 , DEPT_CODE, MANAGER_ID, EMP_NAME 관리자이름
--FROM EMPLOYEE;
FROM EMPLOYEE, EMPLOYEE; -- 셀프 조인이라 임플 하나 더 추가
-- ORA-00918: column ambiguously defined
-- EMP_ID, EMP_NAME 등 같은 테이블이 2개라 모호할 수 밖에. 
-- 해결책 : 컬럼에 어느 테이블인지 지정이 들어야가함 -> 별칭
--   ↓ ↓ ↓   
SELECT E.EMP_ID, E.EMP_NAME 사원이름 ,E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME 관리자이름 -- 사원 기준에서 나의 관리자를 볼 것은 E.을 붙인다
-- 사원의 정보 + 해당 사원을 담당하는 매니저ID출력이라 여기까지는 E.이고 여기에 추가로 매너저의 이름을 붙이는거기에 M.MANAGER_ID 추가
FROM EMPLOYEE E, EMPLOYEE M; -- E.EMPLOYEE는 사원의 초점 // M.EMPLOYEE는 관리자의 초점
-- 조건이 없어서 모든 사원이 반환됨. 조건절 WHERE문 추가ㄱㄱ

-- 모범 답안
-- 오라클 전용구문
SELECT E.EMP_ID, E.EMP_NAME 사원이름 ,E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME 관리자이름 
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID
ORDER BY EMP_ID; -- SELECT에 EMP_ID가 하나라 경로지정 필요X // 별칭 지정하면 E. 붙여야함
-- ANSI 표준구문
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME
FROM EMPLOYEE E
    JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);



------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 다중 조인

-- 다중 조인 작성 방법 및 순서 
-- 1)조인시킬 테이블 뽑아서 적는다                                EX) EMPLOYEE, DEPARTMENT,LOCATION
-- 2)이 테이블들에서 연결시킬 고리인 공통되는 데이터 도출하여 적는다  EX) LOCATION_ID = LOCAL_CODE, DEPT_ID = DEPT_CODE


-- 사번, 이름, 부서코드, 부서명, 지역이름(LOCAL_NAME)
-- 오라클 전용구문
-- ANSI 표준구문
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT,LOCATION;


SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT,LOCATION
WHERE LOCATION_ID = LOCAL_CODE -- EMPLOYEE ↔ DEPARTMENT
      AND DEPT_ID = DEPT_CODE; -- DEPARTMENT ↔ LOCATION


SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)     -- EMPLOYEE ↔ DEPARTMENT
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE); -- DEPARTMENT ↔ LOCATION
-- 

-- 다중 조인시, 유의사항 
-- 순서
-- 
-- 위의 다중조인 코드를 순서바꿔해서 한번해보자. 어떤 결과가 나오나
-- 오라클 전용구문은 순서 바꿔도 문제X
-- ANSI 표준구문은 에러
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT,LOCATION
WHERE DEPT_ID = DEPT_CODE -- DEPARTMENT ↔ LOCATION
      AND LOCATION_ID = LOCAL_CODE; -- EMPLOYEE ↔ DEPARTMENT -- 문제 X


SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)  -- EMPLOYEE ↔ DEPARTMENT였던 것을 -> 바꿨다
    JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE);    -- error : ORA-00904: "LOCATION_ID": invalid identifier
-- ERROR 원인
-- JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE) 자체가 비교를 
-- DEPARTMENT테이블과  LOCATION 테이블의 컬럼을 하는거라 순서가 바뀌면 대상이 바뀌기에 에러발생할 수 밖에
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)  -- LOCATION테이블을 가운데 두고 싶다면 
    JOIN EMPLOYEE ON(DEPT_ID = DEPT_CODE); -- DEPARTMENT테이블을 가장 처음으로 올리면 된다
    
    
    
    
-- 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름 ,직급명, 부서명, 근무 지역명, 급여
-- 오라클 전용구문
-- ANSI 표준구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME, SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE J.JOB_CODE = E.JOB_CODE
        AND E.DEPT_CODE = D.DEPT_ID
        AND D.LOCATION_ID = L.LOCAL_CODE -- 여기까지 조인 조건
        AND JOB_NAME = '대리' -- 직급이 대리이며 아시아 지역 근무 직원 조회 조건
        AND LOCAL_NAME LIKE 'ASIA%'; -- 216	차태연	대리	인사관리부	ASIA1	2780000


SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE JOB_NAME = '대리'
    AND LOCAL_NAME LIKE 'ASIA%'; -- 216	차태연	대리	인사관리부	ASIA1



    
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------






