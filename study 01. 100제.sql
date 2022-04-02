



--SELECT 문제
--1. EMPLOYEE 테이블의    사번, 이름, 급여   조회
SELECT EMP_NO, EMP_NAME,SALARY
FROM EMPLOYEE;
--2. EMPLOYEE 테이블의    모든    정보    조회
SELECT * FROM EMPLOYEE;
--3. JOB 테이블의   모든    정보   조회
SELECT * FROM JOB;
--4. JOB 테이블의   직급    이름   조회
SELECT JOB_NAME FROM JOB;
--5. DEPARTMENT 테이블의    모든    정보    조회
--6. EMPLOYEE 테이블의    직원    명, 이메일, 전화번호, 고용일    조회
--7. EMPLOYEE 테이블의    고용일, 사원    이름, 월급    조회
--8. EMPLOYEE 테이블에서    직원    명, 급여, 연봉    조회(연봉    = 급여*12)
SELECT EMP_NAME,SALARY,SALARY*12
FROM EMPLOYEE;
--9. EMPLOYEE 테이블에서    직원    명, 연봉, 보너스를    추가한    연봉    조회
SELECT EMP_NAME,SALARY,SALARY*12
FROM EMPLOYEE;
--10.EMPLOYEE  테이블에서      이름,  연봉,  총수령액(보너스      포함),  실수령액(총수령액-(연봉*세금 3%)) 조회
SELECT EMP_NAME 이름,SALARY 급여,SALARY*12-(SALARY*12*0.03) 총수령액, SALARY*12 연봉
FROM EMPLOYEE;
--11.EMPLOYEE  테이블에서      이름,  고용일,  근무일수(오늘      날짜      -  고용일)  조회,  오늘      날짜: SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE 근무일수, SYSDATE 오늘
FROM EMPLOYEE;
--12.EMPLOYEE 테이블에서    직원의    직원    번호, 사원    명, 급여, 단위    조회
--13.EMPLOYEE 테이블에서    직원의    직급    코드    조회
--14.EMPLOYEE 테이블에서    직원의    직급    코드를    중복    없이    조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;
--15.EMPLOYEE 테이블에서    직원의    부서    코드를    중복    없이    조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;
--16.EMPLOYEE 테이블에서    부서    코드가    'D9'인    직원의    이름, 부서    코드    조회
SELECT EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';
--17.EMPLOYEE 테이블에서    급여가    4000000 이상인    직원의    이름, 급여    조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;
--18.EMPLOYEE 테이블에서    부서    코드가    ‘D9’가    아닌    사원의    사번, 이름, 부서    코드    조회
SELECT EMP_ID, EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';
--19.EMPLOYEE  테이블에서    퇴사    여부가    N인    직원을    조회하고    근무    여부를    재직중으로    표시하 고    사번, 이름, 고용일, 근무    여부    조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, ENT_YN 재직중
FROM EMPLOYEE
WHERE ENT_YN = 'N' ;
--20.EMPLOYEE 테이블에서    월급이    3000000이상인    사원의    이름, 월급, 고용일    조회
--21.EMPLOYEE 테이블에서    SAL_LEVEL이   ‘S1’인    사원의    이름, 월급, 고용일, 연락처    조회
--
--22.EMPLOYEE 테이블에서    실수령액(총수령액    - (연봉*세금%3))이    5천만원    이상인    사원의    이름, 급여, 실수령액, 고용일    조회
--23.EMPLOYEE  테이블에서    부서    코드가    ‘D6’이고    급여를    3000000보다    많이    받는    직원의    이름, 부서    코드, 급여    조회
--24.EMPLOYEE  테이블에서    부서    코드가    ‘D6’이거나    급여를    3000000보다    많이    받는    직원의    이 름, 부서   코드, 급여    조회
--25.EMPLOYEE  테이블에서    급여를    3500000  이상    6000000  이하를    받는    사원의    사번,  이름,  급 여, 부서코드, 직급코드
--26.EMPLOYEE테이블에    월급이    4000000이상이고    JOB_CODE가    ‘J2’인    사원의    전체    내용    조회
--27.EMPLOYEE 테이블에    DEPT_CODE가    ‘D9’이거나    ‘D5’인    사원    중에    고용일이    02년    1월    1일보 다    빠른   사원의    이름, 부서코드, 고용일   조회
--28.EMPLOYEE  테이블에서    급여를    3500000  미만    6000000  초과를    받는    사원의    사번, 이름,  급 여, 부서코드, 직급코드
--29. EMPLOYEE 테이블에    고용일이    90/01/01 ~ 01/01/01인    사원의    전체    내용을    조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';
--30. EMPLOYEE 테이블에서    성이    ‘전’씨인    사원의    사번, 고용일    조회
--31. EMPLOYEE 테이블에서    이름이    '하'가    포함된    직원의    이름, 주민번호, 부서코드    조회
--32. EMPLOYEE 테이블에서    전화번호    4번째    자리가    9로    시작하는    사원의    사번, 이름, 전화번호 조회
--33. EMPLOYEE  테이블에서    이메일    중    _의    앞    글자가    3자리인    이메일    주소를    가진    사원의    사 번, 이름, 이메일    주소    조회
SELECT EMP_ID,EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___!_%' ESCAPE '!';
--34. EMPLOYEE 테이블에서    이름    중    김씨    성을    가지지    않은    사원의    사번, 이름, 고용일   조회
--35. EMPLOYEE 테이블에서    이름    끝이    '연'으로    끝나는    사원    조회
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
--36. EMPLOYEE 테이블에서    전화번호    처음    세자리가    010이    아닌    사원의    이름, 전화번호    조회
SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';
--37. EMPLOYEE  테이블에서     메일주소     _의     앞이     4자이면서     DEPT_CODE가     ‘D9’     또는     ‘D6’이고, 
-- 고용일이    90/01/01 ~ 00/12/01이고, 급여가   2700000만    이상인    사원의    전체    정보    조회
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____!_%' ESCAPE '!'
        AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
        AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
        AND SALARY >= 2700000;
        
--38. EMPLOYEE 테이블에서    보너스를    받지    않는    사원의    사번, 이름, 급여, 보너스    조회
SELECT EMP_ID, EMP_NAME, SALARY,  NVL(BONUS, 0)---------------------
FROM EMPLOYEE
WHERE BONUS = 0;
--39. EMPLOYEE 테이블에서    보너스를    받는    사원의    사번, 이름, 급여, 보너스    조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;
--40. EMPLOYEE  테이블에서 관리자도 없고 부서 배치도 받지 않은 직원의 이름,  관리자,  부서코드    조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--41. EMPLOYEE  테이블에서    부서    배치를    받지    않았지만    보너스를    지급받는    직원의    이름,  보너 스, 부서코드   조회
SELECT EMP_NAME,BONUS,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
--42. ‘D6’부서와   ‘D9’부서원들의    이름, 부서코드, 급여    조회
--43. 직급   코드가   ‘J1’, ‘J2’, ‘J3’, ‘J4’인    사람들의    이름, 직급    코드, 급여    조회
SELECT EMP_NAME, JOB_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1','J2','J3','J4');
--44. EMPLOYEE 테이블에서    사번, 이름, 급여를    연결해서    조회    (EX. 200선동일8000000)
SELECT EMP_ID||EMP_NAME||SALARY
FROM EMPLOYEE;
--45. EMPLOYEE 테이블에서    '사원    명의    월급은    급여    원입니다' 형식으로    조회
SELECT '사원명 '||EMP_NAME||'의 월급은 급여 '|| SALARY||'원입니다'
FROM EMPLOYEE;
--
--
--
--FUNCTION 문제
--1. EMPLOYEE  테이블에서    사원    명,  입사일-오늘,  오늘-입사일    조회    (단,  별칭은    근무일수1,  근 무일수2로   하고    모두    정수    처리(내림)와    양수로    처리)
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE - SYSDATE)) 근무일수1 , FLOOR(ABS(SYSDATE - HIRE_DATE)) 근무일수2
FROM EMPLOYEE;
--2. EMPLOYEE 테이블에서    사번이    홀수인    직원들의    정보    모두    조회
SELECT *
FROM EMPLOYEE
--WHERE MOD(EMP_ID,2) = 1;
WHERE MOD(EMP_ID,2) != 0;
--3. EMPLOYEE 테이블에서    근무연수가    20년    이상인    직원    정보    조회
SELECT *
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 20;
--4. EMPLOYEE 테이블에서    사원    명, 입사일, 입사한    달의    근무일    수    조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)-HIRE_DATE "입사한 달의 근무일수"
FROM EMPLOYEE;
--5. EMPLOYEE 테이블에서    사원의    이름, 입사    연도, 입사    월, 입사일    조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)-HIRE_DATE "입사한 달의 근무일수"
FROM EMPLOYEE;
--6. EMPLOYEE테이블에서    사원의    이름,  입사일,  근무연수    조회    (단,  근무연수는    현재    연도    - 입 사연도로    조회)
SELECT EMP_NAME, HIRE_DATE, EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) 근무연수
FROM EMPLOYEE;
--7. EMPLOYEE 테이블에서    사원    명, 급여(\9,000,000 형식) 조회
SELECT EMP_NAME ,TO_CHAR(SALARY,'L9,000,000') 급여
FROM EMPLOYEE;
--8. EMPLOYEE 테이블에서    이름, 입사일(2022년    3월    15일    (화) 형식) 조회
SELECT EMP_NAME,TO_CHAR(HIRE_DATE, 'YYYY"년" FMMM"월" DD"일" (DY)')
FROM EMPLOYEE;
--9. 직원의 급여를 인상하고자 한다. 직급코드가 ‘J7’인 직원은 급여의 10%를 인상하고, 직급코 드가 ‘J6’인 직원은 급여의 15%를 인상하고, 
-- 직급코드가 ‘J5’인 직원은 급여의 20%를 인상 하며, 그 외 직급의 직원은 급여의 5%만 인상하며, 직원 테이블에서 직원명,  직급코드,  급 여, 인상급여(위 조건)을 조회
SELECT EMP_NAME, JOB_CODE, SALARY, 
        DECODE JOB_CODE WHEN 'J7' THEN SALARY*0.1
               JOB_CODE WHEN 'J6' THEN SALARY*0.15
               JOB_CODE WHEN 'J5' THEN SALARY*0.2
               ELSE SALARY*0.05
        END;
               
        '인상급여'
FROM EMPLOYEE
WHERE JOB_CODE = 
--10. EMPLOYEE 테이블에서    전    사원의    급여    총합    조회
--11. EMPLOYEE 테이블에서    남자사원의    급여    총합    조회
--12. EMPLOYEE 테이블에서    전    사원의    급여    평균    조회
--13. EMPLOYEE 테이블에서 전 사원의 보너스 평균 (단, BONUS가 NULL인 사원은 0으로 처리)
--14. EMPLOYEE 테이블에서    최소    급여와    최대    급여    조회
--15. 부서   코드가   있는    사원    수    (NULL 제외) 조회
--
--
--GROUP BY HAVING 문제
--1. 부서    별   급여    합계    조회
--2. EMPLOYEE 테이블에서 부서, 부서 별 급여 합계, 부서 별 급여 평균, 부서 별 인원 수 조회
--3. EMPLOYEE 테이블에서    부서코드와    보너스    받는    사원    수    조회
--4. EMPLOYEE 테이블에서    직급코드와    보너스    받는    사원    수    조회
--5. EMPLOYEE 테이블에서    성별과    성별    별    급여    평균(정수처리(내림)), 급여    합계, 인원    수    조회 (인원    수로   내림차순)
--6. EMPLOYEE 테이블에서    부서    코드별로    같은    직급인    사원의    급여    합계    조회
--7. 부서    코드와   급여    3000000이상인    직원의    그룹    별    평균    급여    조회
--8. 부서    코드와   급여    평균    3000000이상인    그룹   별    평균    급여    조회
--9. 부서    별   급여    합계    중    9000000을    초과하는    부서코드와    급여    합계    조회
--10. EMPLOYEE  테이블에서    각    부서    코드마다    직급    코드    별    급여    합,  부서    별    급여    합,  총합 조회
--11. EMPLOYEE  테이블에서    DEPT_CODE가    ‘D5’이거나    급여가    3000000을    초과하는    직원의    사 번, 이름, 부서코드, 급여    조회
--
--
--
--JOIN 문제
--내부    조인(INNER JOIN) : 일치하지    않는    컬럼    값은    제외시킴 1. 사번, 사원   명, 부서코드    조회
--2-1.   사번, 이름, 부서코드, 부서    명    조회(오라클    전용    구문) 2-2.   사번, 이름, 부서코드, 부서    명    조회(ANSI 표준    구문)
--3-1.    사번, 사원    명, 직급    코드, 직급    명    조회(오라클    전용    구문) 3-2.    사번, 사원    명, 직급    코드, 직급    명    조회(ANSI 표준    구문) 4-1.    부서   명과   해당    부서의    지역    명    조회(오라클    전용    구문)
--
--
--
--4-2.    부서   명과   해당    부서의    지역    명    조회(ANSI 표준    구문)
--5. 오라클    전용    구문    ANSI 표준    구문으로    바꾸기
--SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);
--6. 오라클    전용    구문    ANSI 표준    구문으로    바꾸기
--SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;
--7. 오라클    전용    구문에선    FULL [OUTER] JOIN 안    됨. 아래    구문    실행해도    에러    남. 그러니까 밑에    구문을    ANSI 표준으로    바꿔주셈.
--SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID(+);
--8-1.   사번, 이름, 부서    코드, 부서    명, 지역    이름(LOCAL_NAME) 조회(오라클    전용    구문) 8-2.   사번, 이름, 부서    코드, 부서    명, 지역    이름(LOCAL_NAME)(ANSI 표준    구문)
--SUBQUERY 문제
--서브    쿼리(SUBQUERY) :  메인    쿼리를    위해    보조    역할을    하는    쿼리이며,  쿼리    안에    쿼리가    포 함되어   있음.
--1. 첫    번째   구문과    두    번째    구문    합쳐주셈.
--①
--SELECT DEPT_CODE FROM EMPLOYEE
--WHERE EMP_NAME = '노옹철';
--②
--
--SELECT EMP_NAME FROM EMPLOYEE
--WHERE DEPT_CODE = 'D9';
--2. 전    직원의   평균    급여보다    많은    급여를   받고    있는    직원의    사번, 이름, 직급    코드, 급여    조회
--3. 노옹철    사원의   급여보다    많이    받는    직원의    사번, 이름, 부서코드, 직급코드, 급여    조회
--4. 가장    적은   급여를    받는    직원의    사번, 이름, 직급코드, 부서코드, 급여    입사일    조회
--5. 부서    별   급여    합계    중    가장    큰    부서의   부서    명, 급여    합계
--6. 부서    별   최고    급여를    받는    직원의    이름, 직급    코드, 부서코드, 급여    조회
--7. 관리자와    일반    직원에    해당하는    사원    정보    추출    : 사번, 이름, 부서명, 직급, 구분(관리자/직 원)
--8. 대리    직급의    직원들    중에서    과장    직급의    최소    급여보다    많이    받는    직원의    사번, 이름, 직급, 급여    조회
--9. 차장    직급의   급여    중    가장    큰    값보다   많이    받는    과장    직급의    사번, 이름, 직급, 급여    조회
--10.퇴사한    여직원과    같은    부서, 같은    직급에    해당하는    사원의    이름, 직급    코드, 부서코드, 입사 일    조회
--11.자기    직급의    평균    급여를    받고    있는    직원의    사번,  이름,  직급    코드,  급여    조회    (단, 급여    평 균은    십   만원    단위로    계산    : TRUNC(컬럼    명, -5))
--12.전    직원   중    급여가    높은    상위    5명의   이름, 급여    조회
--13.전    직원   중    급여가    높은    상위    5명의   이름, 급여    조회









