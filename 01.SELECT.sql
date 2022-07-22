/*
 테이블(table)이란?

데이터베이스 내의 모든 데이터를 테이블을 통해 저장

행(record)와 열(column)으로 이루어진 데이터베이스 객체

테이블 = 표

행=가로=ROW

열=세로=COLUMN
*/

/*
-- SELECT : 데이터 조회




--RESULT SET : SELECT구문으로 데이터를 조회한 결과물

ex) 해당 조건에 맞지않는 결과값이 없으면 0행으로 나올 수도 있다

RESULT SET의 결과는 ‘0행’ 이상 `

ex) 해당 조건에 맞지않는 결과값이 없으면 0행으로 나올 수도 있다


SELECT 컬럼명

SELECT 컬럼명[, ... ] - 복수 조회가능 // 뭐에 대해 조회할건지 알려줘야하니 컬럼명을 지정.

FROM 테이블명; // 조회하고자 하는 컬럼이 포함된 테이블명 기술

SELECT 컬럼명 FROM 테이블명;




*/


-- EMPLOYEE 테이블의 사번,이름,급여 조회

SELECT EMP_ID,EMP_NAME,SALARY FROM EMPLOYEE;

SELECT EMP_ID,EMP_NAME, SALARY
FROM EMPLOYEE;

--EMPLOYEE 테이블의 모든 정보 조회
SELECT EMP_ID,EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY,
        BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN FROM EMPLOYEE ;
    
SELECT * -- * : 전체
FROM EMPLOYEE;

/*
-- 실습 문제 --
1.JOB 테이블의 모든 정보 조회
2.JOB 테이블의 직급 이름 조회
3.DEPARTMENT 테이블의 모든 정보 조회
4.EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 고용일 조회
5.EMPLYEE 테이블의 고용일, 사원이름, 월급 조회
*/

--1.JOB 테이블의 모든 정보 조회
-- 방법1
SELECT * FROM JOB;
-- 방법2
SELECT JOB_CODE,JOB_NAME FROM JOB; 

--2.JOB 테이블의 직급 이름 조회
SELECT JOB_NAME FROM JOB;

--3.DEPARTMENT 테이블의 모든 정보 조회
-- 방법1
SELECT * FROM DEPARTMENT;
-- 방법2
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID FROM DEPARTMENT;

--4.EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE FROM EMPLOYEE;

--5.EMPLYEE 테이블의 고용일, 사원이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME,SALARY FROM EMPLOYEE;



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


--컬럼 값 산술 연산
--EMPLOYEE테이블에서 직원명, 연봉 조회(연봉 = 급여*12)
SELECT EMP_NAME, SALARY, SALARY*12 -- 연봉
FROM EMPLOYEE;

--EMPLOYEE테이블에서 직원명, 연봉, 보너스를 추가한 연봉 조회
-- 방법1
SELECT EMP_NAME, SALARY * 12, (SALARY+SALARY*BONUS)*12
FROM EMPLOYEE;
--  수식에 NULL이 있으면 결과값에 NULL이 나옴 
-- 방법2 : 별칭추가
SELECT EMP_NAME 이름, SALARY * 12 연봉, SALARY*(1+BONUS)*12 AS 보너스
FROM EMPLOYEE;

/*
------------실습문제------------
1.EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액-(연봉*세금3%)) 조회
2.EMPLOYEE테이블에서 이름, 고용일, 근무일수(오늘 날짜 - 고용일) 조회 
 - 오늘날짜 SYSDATE
*/
--(SALARY+SALARY*BONUS)*12
SELECT EMP_NAME 이름, SALARY * 12 연봉,SALARY *(1+BONUS)*12 "총수령액(보너스포함)", 
        SALARY *(1+BONUS)*12 - SALARY*12*0.03 AS 실수령액
FROM EMPLOYEE;

SELECT EMP_NAME,HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


/*
-- 컬럼 별칭
-- 컬럼명  AS 별칭 / 컬럼명 AS “별칭” / 컬럼명 별칭 / 컬럼명 “별칭”
쌍따옴표( "" )를 무조건 붙여야하는 조건
1)별칭에 특수문자가 들어갈 경우
    - 언더바(_)는 특수문자로 취급하지 않는다
2)별칭이 숫자로 시작할 경우
쌍따옴표 = 더블 쿼테이션(” ”)
    EX) 직원 명 ←띄어쓰기 공백 특수문자라 “직원 명”으로 적어줘야한다
    EX) SALARY*12 AS 연봉*/
    
SELECT EMP_NAME "직원 명", SALARY * 12 급여,SALARY *(1+BONUS)*12 총수령액, SALARY *(1+BONUS)*12 - SALARY*12*0.03 실수령액
FROM EMPLOYEE;

SELECT EMP_NAME,HIRE_DATE, SYSDATE-HIRE_DATE AS 근무일수
FROM EMPLOYEE;


/*
리터럴(literal)
값 자체 ‘ ‘

오라클에서 리터럴 값을 제외한 나머지는 대소문자를 구분하지 않는다.

오라클에서는 문자,문자열,데이트 상관없이 다 싱글쿼테이션(’ ‘)으로 감싸준다
데이터 타입에 상관없이 별칭(””) 외에는 다 싱글쿼테이션으로 감싼다
*/ 

-- EMPLOYEE 테이블에서 직원의 직원 번호, 사원명, 급여, 단위 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' "단위"
FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, SALARY, '원입니다' "단위"
FROM EMPLOYEE;
-- 별칭 : "" 
-- 리터럴을 싱글쿼테이션으로 처리한다 : ' '
-- '원'이라는 컬럼을 보여주고 싶지않으면 더블쿼테이션""으로 단위써주자

-- EMPLOYEE테이블에서 직원의 직급 코드 조회
SELECT JOB_CODE, '직급코드'
FROM EMPLOYEE;

select emp_name, email
from employee
where email like 'bang%'; -- bang으로 시작하는 email 다 조회
-- 결과 : 방명수 bang ns@kh.kr
-- 오라클은 대소문자 구분안해서 소문자로 써도 되나 리터럴에서는 엄격히 구분하기에 주의

SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE 'BANG%';
-- 결과 : 없음
-- 리터럴은 대소문자 철저히 구별하기에 대문자 BANG으로 시작하는 EMAIL이 없어서 안나온 것



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- DISTINCT : 중복제거
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원의 부서 코드를 중복 없이 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- DISTINCT는 한번만 쓸 수 있다
-- null값도 중복제거함
--SELECT DISTINCT DEPT_CODE, DISTINCT DEPT_CODE - error
--FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
-- 두 컬럼의 결과값의 교집합 값만 중복제거함
-- ex) D9 J1 둘 다 같아야 중복 제거

/*
SELECT 컬럼명 -- 조회하고자 하는 컬럼명 기술
FROM 테이블명 -- 조회하고자 하는 컬림이 포함된 테이블명 기술
WHERE 조건식; -- 행을 선택하는 조건 기술, 조건을 만족하는 행만 반환
             -- 조건식 복수로 붙여서 사용가능. 복수라도 WHERE절 한개만 기술




------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- 비교연산자
>, <, >=, <=, = ,!= 

크다, 작다, 크거나 같다
같다 : =
같지않다 : != , ^= , <>
*/
--EMPLOYEE테이블에서 부서코드가 'D9'인 직원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; 
-- '' 없이 D9만 쓰면 컬럼으로 인지하게 됨
-- 'd9'라고 써도 안됨. 리터럴은 대소문자 구분


-- 급여가 4000000이상인 직원의 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= '4000000'; -- ''로 감싸도 숫자로 인지잘한다. '' 없어도 됨

-- EMPLOYEE테이블에서 부서코드가 D9이 아닌 사원의 사번, 이름, 부서코드조회
SELECT EMP_NO, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9'; -- != //  ''이랑 대소문자 구별 주의
WHERE DEPT_CODE ^= 'D9'; -- ^=
WHERE DEPT_CODE <> 'D9'; -- <>

-- 오라클에서의 아니다 부정 표시 3가지
-- != 
-- ^=
-- <>

-- EMPLOYEE 테이블에서 퇴사 여부가 N인 직원을 조회하고 근무 여부를 재직중으로 표시
-- 사번,이름, 고용일, 근무여부 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '재직중' "근무여부"
FROM EMPLOYEE 
WHERE ENT_YN = 'N';


-------------- 실습문제 --------------
--1.EMPLOYEE테이블에서 월급이 3000000이상인 사원의 이름, 월급, 고용일 조회
--2.EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
--3.EMPLOYEE테이블에서 실수령액(총수령액-(연봉*세금3%))이 5천만원 이상인 
--  사원의 이름, 급여, 실수령액, 고용일 조회


--1.EMPLOYEE테이블에서 월급이 3000000이상인 사원의 이름, 월급, 고용일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

--2.EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

--3.EMPLOYEE테이블에서 실수령액(총수령액-(연봉*세금3%))이 5천만원 이상인 
--  사원의 이름, 급여, 실수령액, 고용일 조회
SELECT EMP_NAME 이름, SALARY "급여", SALARY *(1+BONUS)*12 - SALARY*12*0.03 AS 실수령액, HIRE_DATE AS "고용일"
FROM EMPLOYEE
WHERE SALARY *(1+BONUS)*12 - SALARY*12*0.03 >= 5000000;
-- 컬럼 산술연산으로 뽑아낸 값을 조건식의 기준 데이터에 사용가능


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- 논리 연산자 AND OR
-- EMPLOYEE 테이블에서 부서코드가 D6이고 급여를 3000000보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 3000000;



-- EMPLOYEE 테이블에서 부섴드가 D6이거나 급여를 3000000보다 많이 받는 직원의 이름,부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY > 3000000;


-- EMPLOYEE 테이블에서 급여를 3500000이상 6000000이하를 받는 사원의 사번, 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;


-- 1.EMPLOYEE 테이블에서 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
-- 2.EMPLOYEE 테이블에 DEPT_CODE가 D9이거나 D5인 사원 중에 고용일이 02년 1월 1일보다 빠른 사원의
--   이름, 부서코드, 고용일 조회

SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D5' AND HIRE_DATE < '02/01/01';
-- 날짜를 기준으로 조건식을 쓴다면 ''로 감싸줘야한다
-- 기준일보다 작은게 빠른 것. 오늘보다 내일이 더 큰 숫자
-- 이 코드는 틀린 코드
-- 자바나 SQL이나 OR AND는 AND가 우선순위로 먼저 연산
-- ex) WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND HIRE_DATE < '02/01/01';
-- OR를 먼저 연산하고 싶다면 소괄호를 쳐줄 것


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- BETWEEN AND
-- ~이상 ~이하

-- EMPLOYEE 테이블에서 급여를 3500000이상 6000000이하를 받는 사원의 사번, 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 반대로 급여를 3500000미만 6000000초과를 받는 사원의 사번, 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
-- WHERE SALARY < 3500000 OR SALARY > 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
-- NOT 위치 둘 다 가능


-------실습문제-------
-- 1.EMPLOYEE 테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
-- 시간의축을 가로선상에 놓고 보면 시간과 연산자 사용계산이 쉬워짐
SELECT *
FROM EMPLOYEE
-- WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

/*
-- LIKE
비교하려는 값이 특정 패턴을 만족시키는지 조회
ex) 이멜에 i가 들어가는 것을 조회, 이름이 김씨가 들어간 사람들 조회

와일드카드 2종류
 _ : 1글자
 % : 0글자 이상

ex)
'_' (한글자)
'__' (두글자)
'___' (세글자)

 '글자%' : 글자로 시작하는 값
    글자 뒤로 뭐가와도 ok
    ex) 글자최고, 글자(공백), 글자왕, 글자
 '%글자' : 글자로 끝나는 값
    글자 앞에 뭐가와도 ok
    ex) 먹글자, 한글은 글자, (공백)글자
 '글%자' : 글로 시작해서 자로 끝나는 값
    글과 자 사이 뭐가와도 ok
    ex)글씨를 잘쓰자, 글자, 글과자, 글(공백)자
 '%글자%' : 글자가 포함되어있는 값
        ex) 한글자값, 먹글자, 글자, 한두글자

 
*/

--EMPLOYEE 테이블에서 성이 전씨인 사원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';
-- WHERE EMP_NAME LIKE '전__';
-- 도 가능하나 이름이 세글자인 사람들만 가능해서 이름이 두글자나 네글자이상이면 정확도가 떨어짐

--EMPLOYEE 테이블에서 이름이 '하'가 포함된 직원의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';



--EMPLOYEE 테이블에 전화번호 4번째 자리가 9로 시작하는 사원의 사번, 이름, 전화번호 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';
-- 전번 양식 : 01012345678
-- 010 세자리 + 9로 시작하는 네번지째 자릿수

--EMPLOYEE 테이블에서 이메일 중 _의 앞 글자가 3자리인 이메일 주소를 가진 사원의 사번, 이름, 이메일 주소 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '___%'; -- 언더바_가 들어간 이메일 출력. 앞글자 2개도 4개 전부 출력
WHERE EMAIL LIKE '___!_%' ESCAPE '!';
-- ESCAPE의 기준이 되는 코드는 ' '안에서 설정 가능? YES
-- ESCAPE의 ' '안에 어떤 코드이던 들어가서 설정 가능?
/*
LIKE를 쓸 때 패턴!
와일드카드 : _ %
각각 한글자,와 0글자 이상을 나타내는 와일드 카드

세글자 자릿수 언더바 3개 + 검색하고자 하는 데이터로의 언더바 1개 = 총4개의 언더바
검색하고자 하는 패턴의 문자와 와일드 카드가 일치할 경우에는 패턴과 와일드 카드를 구분하지 못하기 때문에
ESCAPE OPTION을 통해 구분해준다
 - 패턴(데이터)으로 쓸 것 앞에 구분기호 사용

*/


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



--  ESCAPE 식별자

-- EMPLOYEE테이블에서 김씨 성이 아닌 직원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%';
--WHERE NOT EMP_NAME LIKE '김%';
-- NOT 순서 : 해당 컬럼명 앞뒤 둘 다 가능

/*
WHERE EMP_NAME != '김%'; 
 = 혹은 != '김%'으로 검색하면 '김%' 데이터자체를 검색
LIKE '김%' 뒤에 어떤게 오든 상관없다
LIKE와 사용하는 % _ 는 와일드카드 적용받는다    
    LIKE는 문자에 대한 패턴 검색하는 것

!= '김%'에서는 이름이 김%인 사람을 찾는 것(리터럴 김% 데이터를 찾는 것)
    여기서 %는 와일드카드로 적용이 되지 않고 그냥 순수 기호 %인 것

*/

    
-----------실습문제-----------
--1.EMPLOYEE 테이블에서 이름 끝이 '연'으로 끝나는 사원 이름 조회
--2.EMPLOYEE 테이블에서 전화번호 처음 세자리가 010이 아닌 사원의 이름, 전화번호 조회
--3.EMPLOYEE 테이블에서 메일주소 _의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고
--  고용일이 90/01/01 ~ 00/12/01이고, 급여가 2700000만 이상인 사원의 전체 정보 조회

SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
-- WHERE NOT PHONE LIKE '010%';

SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____ _%' ESCAPE ' ' 
--WHERE EMAIL LIKE '____!_%' ESCAPE '!'
    AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
    AND HIRE_DATE >= '90-01-01' AND HIRE_DATE <= '00/12/01'
    -- AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
    AND SALARY >= 270000;
-- OR보다 AND연산이 먼저
-- ESCAPE 식별자






------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- IS NULL
-- IS NOT NULL
-- 컬럼값이 NULL이냐
-- 컬럼값이 NULL이 아니냐

--EMPLOYEE 테이블에서 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;
--WHERE BONUS = NULL; 값 안나옴
--WHERE BONUS = (null); 값 안나옴

--EMPLOYEE 테이블에서 보너스를 받는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
-- WHERE NOT BONUS IS NULL; 
-- NOT은 컬렴명 앞에 붙어도 가능

--WHERE BONUS NOT LIKE '%(null)%';


-- EMPLOYEE 테이블에서 관리자도 없고 부서 배치도 받지 않은 직원의 이름, 관리자, 부서코드 조회
-- EMPLOYEE 테이블에서 부서 배치를 받지 않았지만 보너스를 지급받는 직원의 이름,  보너스, 부서코드 조회

SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--IN
-- 목록에 일치하는 값이 있으면 TRUE가 되어 값 반환
-- 목록에 일치하는 값이 있으면 TRUE를 반환



-- D6부서와 D9부서원들의 이름, 부서코드, 급여 조회
-- 직급코드가 J1, J2, J3, J4인 사람들의 이름, 직급코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D9';
WHERE DEPT_CODE IN ('D6','D9');
-- 소괄호로 처음 들어가서 D6를 맞딱들이고 각 조건 체크해서 반환. 다음 D9체크


SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
--WHERE JOB_CODE = 'J1' OR JOB_CODE = 'J2'
--        OR JOB_CODE = 'J3' OR JOB_CODE = 'J4';
WHERE JOB_CODE IN ( 'J1','J2','J3','J4');


-- 위의 두 쿼리를 IN 사용
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D9');





------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- 연결 연산자 ||
-- 자바에서의 or논리연산자의 기호가 SQL에서는 연결연산자
-- EMPLOYEE테이블에서 사번, 이름, 급여를 연결해서 조회 (EX. 200선동일8000000)

SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;
SELECT EMP_ID || EMP_NAME || SALARY 전체결과
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 ' "사원명"의 월급은 "급여"원입니다' 형식으로 조회
SELECT EMP_NAME ||'의 월급은'|| SALARY||'원입니다'
FROM EMPLOYEE;
--문장으로 연결해서 쓰고 싶을 경우 필요



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------











