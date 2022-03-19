
--------------------------- 함수(FUNCTION)------------------------------

/*
22.03.14

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

---------------------------------------------------------------------------
---------------------------------------------------------------------------


 1.단일 행 함수
n개의 데이터를 넣으면 n개가 나오는 것
n개의 값을 읽어서 n개의 결과 리턴

2.그룹 함수
n개의 데이터를 넣으면 1개 나오는 것
n개의 값을 읽어 1개의 결과 리턴


Q. SELECT절에 단일 행 함수와 그룹 함수를 함께 사용할 수 있다/없다?
A. 없다

WHY?
result set의 결과는 테이블이었다
단일행 쓰면 여러 결과가 나오는데 그룹은 하나의 테이블이 나온다
같이 쓰면 테이블 하나가 제대로 안나오게 됨

-- SELECT절에 단일 행 함수와 그룹함수를 함께 사용할 수 없다
결과 행의 개수가 다르기 때문


함수를 사용할 수 있는 위치
SELECT 절
WHERE 절
GROUP BY 절
HAVING 절
ORDER BY 절
( 사실상 프론트빼고 다 가능)


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

-- 1.단일 행 함수
-- 1)문자 관련 함수
-- LENGTH / LENGTHB
-- 인자 : 문자,숫자,특수기호, 컬럼명 
-- B = BYTE
-- LENGTH  : 길이
-- LENGTHB : 글자의 바이트 사이즈 반환 
--      한글 : 3 byte
--      영어, 숫자, 특수기호 : 1 byte


SELECT LENGTH('AAAB') FROM DUAL;   -- 4
SELECT LENGTHB('AAAB') FROM DUAL;  -- 4
SELECT LENGTH('컴퓨터') FROM DUAL;  -- 3
SELECT LENGTHB('컴퓨터') FROM DUAL; -- 9

SELECT LENGTH(EMAIL), LENGTH(EMAIL) FROM EMPLOYEE;
-- 리터럴값도 가능하지만 컬럼도 가능

SELECT LENGTH(EMP_NAME), LENGTH(EMAIL) FROM EMPLOYEE;  -- 3	   15
-- 이름, 이메일 -> 길이, 바이트 사이즈

SELECT LENGTHB(EMP_NAME), LENGTHB(EMAIL) FROM EMPLOYEE; -- 9	15
SELECT EMP_NAME, LENGTHB(EMP_NAME), LENGTHB(EMP_NAME) FROM EMPLOYEE; -- 길이B 9
        
SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
        EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;



------------------------------------------------------------------------------
------------------------------------------------------------------------------


--  INSTR
-- 해당 문자열이 처음 나온 위치 인덱스번호 반환(ZERO-INDEX X)
-- INSTR(’문자열’or컬럼명, ‘찾아낼 문자‘,  시작 index, 2번째인자인 문자가 몇번째 나오는 문자인지)

--1번째 인자 : 찾을 문자열 or 컬럼명
--2번째 인자 : 첫번째 중에 찾고 싶은 문자
--3번째 인자 : 몇번째부터 읽기 시작할 것이냐. 안적으면 1부터 시작
--4번째 인자 : ' '의 문자가 세번째인자로부터 세기 시작해서 "몇번째로 나오는 문자인가”
--    1,2번째 인자는 리터럴( ‘ ‘ )로 감싼다
 
-- 없는 문자열은 0반환 // 만약, 제로인덱스였다면 -1반환
-- AABAACAABBAA
SELECT INSTR('AABAACAABBAA','A') FROM DUAL;   -- 1
SELECT INSTR('AABAACAABBAA','A',3) FROM DUAL; -- 4
SELECT INSTR('AABAACAABBAA','A',1,3) FROM DUAL; -- 4
SELECT INSTR('AABAACAABBAA','A',1,2) FROM DUAL; -- 2

SELECT INSTR('AABAACAABBAA','B') FROM DUAL;     -- 3
SELECT INSTR('AABAACAABBAA','B',1,1) FROM DUAL; -- 3
SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL; -- 9
SELECT INSTR('AABAACAABBAA','B',9,2) FROM DUAL; -- 10

-- 코딩해설 : 7번쨰부터 읽기 시작해서 B가 처음 나올 때까지 읽어서, 처음 나오는 B의 위치 반환해
 SELECT INSTR('AABAACAABBAA','B',7,1) FROM DUAL; -- 9
 
 
-- 마이너스(-): 거꾸로 읽기
SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL; -- 10
SELECT INSTR('AABAACAABBAA','B',-1,1) FROM DUAL; -- 10
SELECT INSTR('AABAACAABBAA','B',-1,2) FROM DUAL; -- 9
SELECT INSTR('AABAACAABBAA','B',-1,3) FROM DUAL; -- 3

SELECT INSTR('AABAACAABBAA','B',-1,-1) FROM DUAL; -- ERROR : 4번째 인자는 양수만 가능
SELECT INSTR('AABAACAABBAA','B',-1,0) FROM DUAL;  -- ERROR : 4번째 인자는 양수만 가능
-- 역순 뒤에서 찍은 기준점 기준으로 왼쪽으로 세고 인덱스번호는 맨왼쪽에서 오른쪽으로


-- 1에서부터 두번째 있는 'B'를 찾아라
SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL; -- 9

SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL; -- 9


-- EMPLOYEE테이블에서 이메일의 @위치 반환

SELECT EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___@%';


------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- LPAD / RPAD
-- 왼쪽 공백 / 오른쪽 공백
-- 오른쪽 정렬 / 왼쪽 정렬
-- LPAD(컬럼명, 문자 총 길이,공백 대신 대체할 문자)
-- 주어진 값에 임의의 문자열을 왼쪽/오른쪽에 덧붙여 길이 n개의 문자열 반환
-- 전체 길이에서 남은 공간에 공백으로 채움


--      sun_di@kh.or.kr// 세팅 :20
SELECT LPAD('sun_di@kh.or.kr',20) FROM DUAL;
-- sun_di@kh.or.kr     //
SELECT RPAD('sun_di@kh.or.kr',20) FROM DUAL;



-- 값보다 지정한 총길이가 짧으면 뒤부터 짤림
SELECT LPAD('sun_di@kh.or.kr',5) FROM DUAL;
-- 공백대신 대체할 문자 삽입
SELECT LPAD('sun_di@kh.or.kr',20,'^') FROM DUAL;

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- LTRIM / RTRIM
-- 좌/우에서부터 지정한 문자를 제거한 나머지 반환
--      문자를 지정하지 않을 경우, 공백 제거
-- LTRIM : 왼쪽부터 순서대로 제거
-- RTRIM : 오른쪽부터 순서대로 제거


-- 자바 STRING클래스에서 TRIM은 공백제거 메소드

-- KH//
SELECT LTRIM('   KH   ') FROM DUAL; -- KH   //
--    KH//
SELECT RTRIM('   KH   ')FROM DUAL; --    KH//

-- 000123456
-- 0만 제거하고 나머지를 반환
SELECT LTRIM('000123456',0) FROM DUAL;

-- 0001230456
-- 중간에 껴있는 해당 문자는 제거X
SELECT LTRIM('000123456',0) FROM DUAL;

-- ACABACCKH // KH
-- 'ABC' 묶여진 문자 하나로 보는게 아니라, A 또는 B 또는 C가 있으면 다 지우는 것
-- 'ABC' 안에 순서 상관X
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; -- KH

-- KH   // KH
-- 오른쪽부터 공백제거
SELECT LTRIM('KH   ') FROM DUAL; -- KH   //
SELECT RTRIM('KH    ') FROM DUAL; -- KH//

-- 01230456000 // 01230456
SELECT RTRIM('01230456000',0) FROM DUAL;
-- KHACABACC // KH
-- 오른쪽부터 지우기 시작
SELECT RTRIM('KHACABACC','ABC') FROM DUAL; -- KH



------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- TRIM
-- 앞/뒤/양쪽에서 지정한 문자를 제거한 나머지 반환
-- TRIM(제거방향 '제거할 문자 1개' FROM '찾을 문자열OR컬럼명')
-- LEADING : 앞부터 제거
-- TRAILING : 뒤부터 제거
-- BOTH : 양쪽에서부터 제거


--    KH   // KH // A는 별칭
SELECT TRIM('   KH   ') FROM DUAL; -- KH
SELECT TRIM(BOTH FROM '   KH   ') FROM DUAL; -- KH//
SELECT TRIM(BOTH ' ' FROM '   KH   ') FROM DUAL; -- KH//
SELECT TRIM(BOTH FROM '   KH   ') FROM DUAL; -- KH// 2번인자 제거할 문자 : 생략가능
SELECT TRIM(LEADING 'K' FROM '   KH   ') FROM DUAL; --    KH   // 공백에서 멈춰 K안지워짐
SELECT TRIM(TRAILING 'K' FROM '   KH   ') FROM DUAL; --    KH   //공백에서 멈춰 K안지워짐
SELECT TRIM(TRAILING ' ' FROM '   KH   ') FROM DUAL; --    KH//



-- ZZZKHZZZ // KH
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- KH
-- 123KH123123 // error : trim set should have only one character
-- TRIM은 제거할 문자 1개만 받는다
-- ZZZKHZZZ // KHZZZ
-- LEADING 앞부터 제거
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- KHZZZ

-- ZZZKHZZZZ // ZZZKH
-- TRAILING 뒤부터 제거
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- ZZZKH

-- ZZZKHZZZZ //KH
-- BOTH 양쪽에서부터 제거
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;  -- KH

--LTRIM/RTRIM처럼 인자 추가 형식이 아닌 
--코드 구조를 바꿔서 써야함 
--제거를 지우겠다 어디서부터? 컬럼명부터


------------------------------------------------------------------------------
------------------------------------------------------------------------------

--SUBSTR
-- String.substring()
--SUBSTR(컬럼명, 시작위치 인덱스, 시작위치부터 값을 반환할 길이)


-- HELLOMYGOODFRIENDS // YGOODFRIENDS
-- 7번째서부터 끝까지 반환
SELECT SUBSTR('HELLOMYGOODFRIENDS',7) FROM DUAL;

-- HELLOMYGOODFRINEDS // OM
-- 5번째 문자부터 2개만 반환
SELECT SUBSTR('HELLOMYGOODFRIENDS',5,2) FROM DUAL;

-- HELLOMYGOODFRINEDS // (null)
-- 5번쨰 문자부터 0개 반환 // 0개 반환이 불가능하기에 NULL 출력됨
SELECT SUBSTR('HELLOMYGOODFRIENDS',5,0) FROM DUAL; -- --(NULL)
-- HELLOMYGOODFRINEDS // HELLOM
SELECT SUBSTR('HELLOMYGOODFRIENDS',0,5) FROM DUAL; -- HELLO // 0부터 시작해도 1부터 적용
SELECT SUBSTR('HELLOMYGOODFRIENDS',1,5) FROM DUAL; -- HELLO // 0부터 시작해도 1부터 적용


-- HELLOMYGOODFRINEDS //  DFR
-- 뒤에서 8번째(D)부터 오른쪽으로 3개의 문자 반환
-- 위에서 마이너스(-)였으면 기준점이 뒤에서부터 세고 왼쪽방향으로 카운팅했지만 얘는 오른쪽으로 카운팅
SELECT SUBSTR('HELLOMYGOODFRIENDS',-8,3) FROM DUAL; -- DFR
-- HELLOMYGOODFRINEDS // OO
SELECT SUBSTR('HELLOMYGOODFRIENDS',-10,2) FROM DUAL;  -- OO
SELECT SUBSTR('HELLOMYGOODFRIENDS',-10,-2) FROM DUAL; -- 3RD 인자 몇번째문자인지가 -이면 NULL값


-- EMPLOYEE 테이블에서 이름, 이메일, 이메일의 아이디 조회
-- (이메일의 @ 도메인말고 아이디까지만)
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)
FROM EMPLOYEE;
-- 문제풀이 사고과정
-- 1.이메일 아이디의 규칙은 항상 @이 앞에 있음
-- 2. @ 위치 파악
-- 3. 1~@앞까지 찾기

-- EMPLOYEE 테이블에서 이름, 이메일, 이메일의 아이디 조회
-- (이메일의 @ 도메인말고 아이디까지만)
SELECT EMP_NAME, EMAIL,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)
FROM EMPLOYEE;


-- 주민등록번호를 이용하여 이름과 성별을 나타내는 부분 조회
-- EMPLOYEE 테이블에서 남자만 조회(사원명, '남')
-- EMPLOYEE 테이블에서 여자만 조회(사원명, '여')
SELECT EMP_NAME 사원명, CASE WHEN SUBSTR(EMP_NO,8,1)=1 THEN '남'
                            WHEN SUBSTR(EMP_NO,8,1)=2 THEN '여'
                       END 성별 
FROM EMPLOYEE;

SELECT EMP_NAME 사원명, DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여') 성별
FROM EMPLOYEE;



-- EMPLOYEE테이블에서 직원들의 주민번호를 이용하여 사원명, 생년, 생월, 생일 조회
SELECT EMP_NAME 사원명,  SUBSTR(EMP_NO,1,2) 생년, SUBSTR(EMP_NO,3,2) 생월, SUBSTR(EMP_NO,5,2) 생일
FROM EMPLOYEE;



------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- LOWER / UPPER / INITCAP
-- INITCAP :각 단어의 첫글자만 대문자

-- 예제 Welcome To my World
-- welcome to my world
SELECT LOWER('Welcome To my World') FROM DUAL;
-- WELCOME TO MY WORLD
SELECT UPPER('Welcome To my World') FROM DUAL;
-- Welcome To My World
SELECT INITCAP('Welcome To my World') FROM DUAL;


------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- CONCAT
-- 문자열 이어붙이기

-- 가나다라123
SELECT CONCAT('가나다라','123') FROM DUAL;
SELECT CONCAT(DEPT_CODE, '-333') FROM EMPLOYEE; -- D9-333
SELECT CONCAT(JOB_CODE, ' BY S') FROM JOB; -- J1 BY S
SELECT CONCAT(DEPT_CODE, JOB_CODE) FROM EMPLOYEE; -- D9J1
-- 연결연산자 사용 : 가나다라123
-- 연결연산자 : ||
SELECT '가나다라' || '123' FROM DUAL; -- 가나다라123


------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- REPLACE
-- REPLACE(컬럼명,바꿔질 단어, 바꿀 단어)
-- 값 교체

-- 서울시 강남구 역삼동 // 서울시 강남구 삼성동
SELECT REPLACE('서울시 강남구 역삼동','역삼동','삼성동') FROM DUAL;

-- 강사님은 오라클을 수업중이다 // 선생님은 오라클을 수업중이다
-- 띄어쓰기 상관없이 적용가능
SELECT REPLACE('강사님은 오라클을 수업중이다','강사님','선생님') FROM DUAL;

-- 케이크 달다. 케이크 싫은사람? // 공부 달다. 공부 싫은사람?
-- 여러개 들어있어도 복수로 교체가능. 일치만 하면 전부 교체함
SELECT REPLACE('케이크 달다. 케이크 싫은사람?','케이크','단 거') FROM DUAL;

-- EMPLOYEE테이블에서 사원명, 주민번호 조회
-- 주민번호의 뒷자리는 *로 바꿔서 조회(EX.001122-*******)


-- REPLACE+SUBSTR

-- REPLACE+SUBSTR+INSTR


/*
REPLACE(EMP_NO,SUBSTR(EMP_NO,8,14/2)
SELECT REPLACE(EMP_NO,SUBSTR(EMP_NO,8,14/2)) FROM EMPLOYEE;
SELECT REPLACE(EMP_NO,SUBSTR(EMP_NO,8,LENGTH(EMP_NO)/2)) FROM EMPLOYEE;
SELECT LENGTH(EMP_NO)/2 FROM EMPLOYEE;
*/

-- RPAD+SUBSTR
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,7),14,'*******')
FROM EMPLOYEE;


-- 방법1
-- REPLACE+SUBSTR 끝수 지정 & 미지정 


-- 방법2
-- RPAD+SUBSTR
SELECT EMP_NAME, REPLACE(EMP_NO,SUBSTR(EMP_NO,8,7),'*******') 주민번호
FROM EMPLOYEE;

-- RPAD+SUBSTR+INSTR
SELECT EMP_NAME, REPLACE(EMP_NO,SUBSTR(EMP_NO,8,7),'*******')
FROM EMPLOYEE;

-- RPAD+SUBSTR+INSTR+LENGTH
SELECT EMP_NAME, REPLACE(EMP_NO,SUBSTR(EMP_NO,INSTR(EMP_NO,'-')+1,LENGTH(EMP_NO)/2),'*******')
FROM EMPLOYEE;

-- 방법3
-- REPLACE+SUBSTR+INSTR+LENGTH


-- 방법4
-- SUBSTR+연결연산자(||)
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 7) || '*******' 주민번호
FROM EMPLOYEE;



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 2) 숫자 관련 함수


-- ABS
-- 절대값 반환
SELECT ABS(FLOOR(1.234)) FROM DUAL;
-- 10.9	10.9	10	10
-- 전부 양수 출력
SELECT ABS(-10.9), ABS(10.9), ABS(-10) FROM DUAL;

-- MOD
-- 모듈러
-- 나머지 구하기
-- MOD(나눠지는수 ,나누는 수)

-- 1	-1	1	-1	1.9
-- 내가 나누어지는 수에 대한 부호를 따라가게 됨
SELECT MOD(10,3), MOD(-10,3), MOD(10,-3), MOD(-10,-3), MOD(10.9,3) FROM DUAL;


-- ROUND
-- 몇번째 자리에서 반올림할지 소수점 자리수 지정가능
-- 123.456
-- 123	124	123	123.5	123.46	120	100
-- 소수점 자리지정 반올림
-- 소수점 -의 반올림
SELECT ROUND(123.456,0),ROUND(123.456), ROUND(123.456,1),ROUND(123.456,2), ROUND(123.456,-1) FROM DUAL;
SELECT ROUND(123.456,-1), ROUND(123.456,-2) FROM DUAL;

-- -11
-- 마이너스(-)의 반올림은?
-- 마이너스는 숫자가 클수록 작은 수 ex) -11이 -10보다 작은 수
-- -10.61에서 .61이 5이상이라 반올림이 되는데 -11로



-- CEIL
-- 124
-- 무조건 1의 자리에서 올림하게 되어있음
-- 자릿수 지정 불가. 다른 인자값 집어넣으면 에러
SELECT CEIL(123.456) FROM DUAL;


-- FLOOR / TRUNC
-- FLOOR : 수학적 내림(배웠던 수학의 내림) // 자릿수 지정 불가
-- TRUNC : 버림. 절삭. 몇번째 자리까지 버리겠다 // 자릿수 지정가능
SELECT FLOOR(123.456), TRUNC(123.456) FROM DUAL;
SELECT FLOOR(123.456), TRUNC(123.456,1) FROM DUAL;

-- 123	123	123.7
-- TRUNC : 몇번째 자리까지 버리겠다 자릿수 지정가능
-- 파이썬에서 FLOOR가 -쪽으로 내리고 TRUNC가 0쪽으로 수렴하는 것과 같은 개념
-- math.trunc(-3.14)   #결과는 -3
-- math.floor(-3.14)   #결과는 -4






------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- 3)날짜 관련 함수

-- SYSDATE
-- 시스템에 저장되어있는 시간을 사용

SELECT SYSDATE FROM DUAL; -- 22/03/14



-- MONTHS_BETWEEN
-- ex) MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
-- 개월수의 차를 숫자로 리턴해주는 함수
SELECT MONTHS_BETWEEN(SYSDATE, HIRE_DATE) FROM EMPLOYEE; -- 385일 차이
SELECT SYSDATE,HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) FROM EMPLOYEE;
SELECT SYSDATE,HIRE_DATE, ABS(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) FROM EMPLOYEE;


-- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무 개월 수 조회
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE,HIRE_DATE) "근무 개월 수"
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, CEIL(ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))) || '개월차'
FROM EMPLOYEE; -- 368개월차
-- 앞뒤로 뭐가 올지 모른다면 ABS를 넣어서 절대값으로 받아오면 된다

SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) || '일수'"근무일수" FROM EMPLOYEE;




-- ADD_MONTHS
-- 기준 날짜에다 지정한 숫자만큼의 개월수로 더한 날짜 리턴
SELECT ADD_MONTHS(SYSDATE,4) FROM EMPLOYEE; -- 22/07/19
-- 지금부터 4개월 뒤 반환
SELECT ADD_MONTHS(SYSDATE,12) FROM EMPLOYEE; -- 23/03/19
-- 개월수가 더해져서 연도가 넘어가면 연도도 올라감

--EMPLOYEE테이블에서 사원의 이름, 입사일, 입사 후 6개월이 된 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) FROM EMPLOYEE;
SELECT EMP_NAME, ADD_MONTHS('00/01/01',12) FROM EMPLOYEE; -- 01/01/01
-- 마이너스 -12개월
SELECT EMP_NAME, ADD_MONTHS('00/01/01',-12) FROM EMPLOYEE; -- 99/01/01



-- NEXT_DAY
-- 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
-- 1=일, 2=월, 3=화,4=수, 5=목, 6=금, 7=토
-- 텍스트의 맨 앞글자만 따와서 요일 반환

SELECT SYSDATE, NEXT_DAY(SYSDATE, '일') FROM DUAL; -- 22/03/19	22/03/20
SELECT SYSDATE, NEXT_DAY(SYSDATE, '토') FROM DUAL; -- 22/03/19	22/03/26

-- 지금 기준으로부터 가장 가까운 목요일 구하기
SELECT NEXT_DAY(SYSDATE, '목') FROM DUAL;    -- 22/03/24
SELECT NEXT_DAY(SYSDATE, '목요일') FROM DUAL; -- 22/03/24
SELECT NEXT_DAY(SYSDATE, 5) FROM DUAL;       -- 22/03/24   
-- 1=일, 2=월, 3=화,4=수, 5=목, 6=금, 7=토
SELECT NEXT_DAY(SYSDATE, 'THUR') FROM DUAL; -- ERROR :  not a valid day of the week



SELECT SYSDATE, NEXT_DAY(SYSDATE, '목성주기') FROM DUAL; -- 22/03/19	22/03/24
-- 요일과 관련 없는 단어지만 맨 앞글자 '목'만 따서 요일 반환하는 걸 알 수 있다
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금성') FROM DUAL; -- 22/03/19	22/03/25
-- 금성의 맨 앞글자 '금' = 금요일


-- 한글만 인지하게끔 설정이 되어있어 인식오류 뜨는 것

-- 영어로 세팅
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- Session이(가) 변경되었습니다.
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- 22/03/15	22/03/17
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL; -- 22/03/15	22/03/17
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSTY') FROM DUAL; -- 22/03/15	22/03/17
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR--') FROM DUAL; -- 22/03/15	22/03/17
-- 한글과 동일하게 앞글자만 맞으면 요일 반환. 아마도 첫발음의 한글자를 치는 듯

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURDAY') FROM DUAL; -- 22/03/19	22/03/24
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;    -- 22/03/19	22/03/24
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR---') FROM DUAL;


-- 한글로 세팅
ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, '금') FROM DUAL; -- 22/03/25
SELECT NEXT_DAY(SYSDATE, '금성') FROM DUAL;


-- LAST_DAY
-- 해당 날짜의 월의 마지막 일 반환
SELECT LAST_DAY(SYSDATE) FROM DUAL; -- 22/03/31
SELECT LAST_DAY(HIRE_DATE) FROM EMPLOYEE; -- 90/02/28 01/09/30
SELECT LAST_DAY(JOB_CODE) FROM EMPLOYEE; -- ERROR
-- ORA-01841: (full) year must be between -4713 and +9999, and not be 0


-- EXTRACT
-- 년, 월, 일 정보 추출 반환
-- 시간은 추출 불가

SELECT EXTRACT(SYSDATE-hire_date) FROM EMPLOYEE;

SELECT EXTRACT(YEAR FROM SYSDATE), EXTRACT(MONTH FROM SYSDATE),
       EXTRACT(DAY FROM SYSDATE) FROM EMPLOYEE; -- 2022	3	19
SELECT EXTRACT(DAY FROM SYSDATE)
--        EXTRACT(HOUR FROM SYSDATE),  -- 시간은 추출 불가
--        EXTRACT(MINUTE FROM SYSDATE) 
FROM EMPLOYEE;
       
-- EMPLOYEE테이블에서 사원의 이름, 입사연도, 입사월, 입사일 조회

SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) 입사연도,
                 EXTRACT(MONTH FROM HIRE_DATE) 입사월, 
                 EXTRACT(MONTH FROM HIRE_DATE) 입사일
FROM EMPLOYEE; -- 선동일	1990	2	2


-- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무년수 조회
-- 단, 근무년수는 현재연도 - 입사연도로 조회
SELECT EMP_NAME,HIRE_DATE, SYSDATE,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
FROM EMPLOYEE; -- 선동일	90/02/06	22/03/19	32





----------실습문제------------
--1.EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
-- 단, 별칭은 근무일수1, 근무일수2로 하고 모두 정수처리(내림)와 양수로 처리
--2.EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
--3.EMPLOYEE테이블에서 근무년수가 20년 이상인 직원 전체 정보 조회
--4.EMPLOYEE테이블에서 사원명, 입사일, 입사한 달의 근무일수 조회


--1.EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
-- 단, 별칭은 근무일수1, 근무일수2로 하고 모두 정수처리(내림)와 양수로 처리
-- 절삭이 아니라 내림이라 FLOOR. TRUNC는 절삭이고 FLOOR는 수학적 내림


--2.EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회

-- 오라클에서는 % 나머지 연산지 지원X


--3.EMPLOYEE테이블에서 근무년수가 20년 이상인 직원 전체 정보 조회
-- 방법1

-- 방법2

-- 방법3

-- 방법4

-- 방법5

 
--4.EMPLOYEE테이블에서 사원명, 입사일, 입사한 달의 근무일수 조회



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- 4)형변환 함수
-- A) TO_CHAR
-- B) TO_DATE
-- C) TO_NUMBER

-- A) TO_CHAR : 날짜/숫자형 데이터를 문자형 데이터로 변경
-- B) TO_DATE : 
-- C) TO_NUMBER : 문자형 데이터를 숫자형 데이터로 변환


-- A) TO_CHAR 
-- 날짜/숫자형 데이터를 문자형 데이터로 변경
-- 자릿수에 맞춰 문자로 형변환
-- 남은 공백은 왼쪽에 표시
SELECT 1234 LITERAL_NUMBER FROM DUAL; -- 1234
SELECT TO_CHAR(1234) FROM DUAL; -- 1234
SELECT 1234 LITERAL_NUMBER , TO_CHAR(1234) FROM DUAL; -- 1234	1234
-- 숫자로 인지되었으면 오른쪽 정렬, 문자로 인지되어있으면 왼쪽 정렬
-- 글자가 어디에 들어가 있느냐에 따라서 문자인지 숫자인지 구분 가능

SELECT 1234+4321, TO_CHAR(1234)+TO_CHAR(4321) FROM DUAL; -- 5555	5555 
-- 문자인데 연산이 가능한 이유 : 숫자로 형변환에 문제 없는 문자는 오라클에서 자동으로 연산해줌
-- 문자 연산 가능 // 자바에선 불가능

SELECT TO_CHAR(1234, '99999') FROM DUAL;   --  (공백)1234
SELECT TO_CHAR(1234, '99999') A FROM DUAL; --  (공백)1234
-- '99999'의 의미는 5칸을 만들겠다. 여기에 1234를 넣고 빈 공간은 공백으로 하겠다는 의미
-- ' ' 안에는 9와 0만 가능. 다른 숫자는 에러
SELECT TO_CHAR(1234, '99') A FROM DUAL;    -- ###
SELECT TO_CHAR(1234, '88') A FROM DUAL;    -- ERROR
SELECT TO_CHAR(1234,'00000') A FROM DUAL;  -- 01234
-- 비어있는 곳을 0으로 채워라

SELECT TO_CHAR(1234,'L99999') FROM DUAL;     --         ￦1234
-- L을 붙인건 현재 설정된 나라의 원화표시를 붙인 것
SELECT TO_CHAR(1234,'FML99999') FROM DUAL;   -- ￦1234
-- FM을 추가로 넣으면 공백 없애는 것
SELECT TO_CHAR(1234,'$99999') FROM DUAL;     --   $1234
-- 달러를 찍고 싶으면 L대신 $기호
SELECT TO_CHAR(1234,'FM$99999') FROM DUAL;   --$1234
SELECT TO_CHAR(1234,'99,999') FROM DUAL;     --  1,234
SELECT TO_CHAR(1234,'FM99,999') FROM DUAL;   -- 1,234
SELECT TO_CHAR(1234,'00,000') FROM DUAL;     --  01,234
SELECT TO_CHAR(1234,'FM00,000') FROM DUAL;   -- 01,234
SELECT TO_CHAR(1234,'999') FROM DUAL; -- ####
-- 자릿수가 부족해서 # 출력

-- 1234보다 더 적은 자리수를 지정할 경우는?
-- ##을 이용하면 됨




-- EMPLOYEE테이블에서 사원명, 급여(\(원화표시)9,000,000 형식) 조회
SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
--SELECT EMP_NAME, TO_CHAR(SALARY, 'FML999,999,999')
FROM EMPLOYEE;
SELECT TO_CHAR(SYSDATE) FROM DUAL;                  -- 22/03/15
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;      -- 08:07:45
SELECT TO_CHAR(SYSDATE, 'AM:HH:MI:SS') FROM DUAL;   -- 오후:08:08:07
SELECT TO_CHAR(SYSDATE, 'PM:HH:MI:SS') FROM DUAL;   -- 오후:08:08:07 // AM PM 아무거나 쓰면됨  
SELECT TO_CHAR(SYSDATE, 'AM:HH24:MI:SS') FROM DUAL; -- 오후:20:10:01
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY AM HH:MI:SS') FROM DUAL;  --2022-03-15 화요일 오후 08:10:50
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY AM HH:MI:SS') FROM DUAL;--2022-3-15 화요일 오후 8:10:59
-- FM을 적용시키면 뒤에까지 적용되서 공백제거 되서 나온다
-- 01초가 나와야하는데 1초가 나옴
SELECT TO_CHAR(SYSDATE, 'YYYY"년"-MM"월"-DD"일" DAY AM HH:MI:SS') FROM DUAL; -- 2022년-03월-15일 화요일 오전 11:40:48
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" DAY AM HH:MI:SS') FROM DUAL; -- 2022년 03월 15일 화요일 오후 08:15:13
-- 글자 출력
-- 글자처럼 비어있는 자리를 지워주는 역할

-- 보이는게 다른 3가지
SELECT TO_CHAR(SYSDATE,'YYYY') FROM DUAL; -- 2022
SELECT TO_CHAR(SYSDATE,'YY') FROM DUAL; -- 22
SELECT TO_CHAR(SYSDATE,'YEAR')FROM DUAL; -- TWENTY TWENTY-TWO

SELECT TO_CHAR(SYSDATE,'MM')FROM DUAL; -- 03
SELECT TO_CHAR(SYSDATE,'MONTH')FROM DUAL; -- 3월 
SELECT TO_CHAR(SYSDATE,'MON')FROM DUAL; -- 3월 
SELECT TO_CHAR(SYSDATE,'RM')FROM DUAL; -- III 
SELECT TO_CHAR(SYSDATE,'MM'), TO_CHAR(SYSDATE,'MONTH'),
        TO_CHAR(SYSDATE,'MON'), TO_CHAR(SYSDATE,'RM')
FROM DUAL;  -- 03	3월 	3월 	III 


SELECT TO_CHAR(SYSDATE,'DDD'), -- 한달을 기준으로 몇일이 지나있는가
    TO_CHAR(SYSDATE,'DD'), -- 주를 기준으로 몇일이 지나있는가
    TO_CHAR(SYSDATE,'D') -- 한 해를 기준으로 몇일이 지나있는가
FROM DUAL; -- 074	15	3
 
SELECT TO_CHAR(SYSDATE,'Q'), TO_CHAR(SYSDATE,'DAY'), TO_CHAR(SYSDATE,'DY')
FROM DUAL;
-- Q : 분기를 나타냄. 1-4분기
-- DAY : 요일
-- DY : 요일



--EMPLOYEE테이블에서 이름, 입사일(2022년 03월 15일 (화) 형식) 조회




------------------------------------------------------------------------------
------------------------------------------------------------------------------




-- B) TO_DATE
-- 문자/숫자형 데이터를 날짜형 데이터로 변환
--
-- Y : 두자리 연도에 무조건 현재 세기(21세기 , 20XX) 적용
-- R : 두자리 연도가 50이상일 때, 이전 세기(20세기,19XX) 적용
--     두자리 연도가 50미만일 때, 현재 세기(21세기, 20XX) 적용


SELECT TO_DATE('20220315','YYYYMMDD') FROM DUAL; -- 22/03/15
SELECT TO_DATE(20220315,'YYYYMMDD') FROM DUAL; -- 22/03/15
SELECT TO_DATE('20220315','YYYYMMDD') FROM DUAL; -- 22/03/15

-- 입력 받은 문자열 : 20220713을 2022년 07월 13일 형식으로 출력하고 싶다면?
-- 20220713  -> 2022년 07월 13일
-- 문자열 받는거니 TO_CHAR써서 하면 편하지 않을까? 해서 써보면 에러
-- TO_CHAR는 날짜/숫자형 데이터를 문자형 데이터로 변경하는 함수
-- 아래에서 TO_CHAR()의 첫 매개변수가 숫자가 ' '로 감싸진 문자라서 에러나는 것
-- 문자+문자 더하기 가능한건? EX)TO_CHAR(1234) + TO_CHAR(4321)
-- 문자가 숫자로 바뀌는 문자라면 문제없이 연산처리 가능하도록 오라클은 되어있기에 가능했던 것
-- 자바는 '1234'+'4321'이면 '12344321'이겠지만 오라클은 숫자형식인 문자면 자동형변환해서 연산해준다

SELECT TO_CHAR('20220315','YYYY"년" MM"월" DD"일"') --  ERROR : invalid number format model
FROM DUAL;
-- TO_CHAR()를 쓸려면 '20220315'의 형식 바꿔야함
-- TO_DATE()로 날짜 데이터를 만듬 : SELECT T0_DATE('20220315','YYYYMMDD')
SELECT TO_CHAR('20220315','YYYY"년" MM"월" DD"일"') --  ERROR : invalid number format model
FROM DUAL;
SELECT TO_CHAR(T0_DATE('20220315','YYYYMMDD'), 'YYYY"년" MM"월" DD"일"') -- ERROR
FROM DUAL; -- 정답. 디버깅할 것


SELECT TO_CHAR(TO_DATE('220713 175019','YYMMDD HH24MISS'), 'YY-MM-DD AM HH:MI:SS DY')
FROM DUAL; -- 22-07-13 오후 05:50:19 수
-- 데이트는 시간까지 보여주지 않는다. 타임스탬프 써야함


-- TO_DATE()에서의 연도 표시 : YY, RR
-- 연도표시를 YY말고도 RR도 가능. 차이는?
SELECT TO_DATE('980630', 'YYMMDD'),  -- 98/06/30
        TO_DATE('980630', 'RRMMDD'), -- 98/06/30
        TO_DATE('140918', 'YYMMDD'), -- 14/09/18
        TO_DATE('140918', 'RRMMDD')  -- 14/09/18
FROM DUAL; -- 98/06/30	98/06/30	14/09/18	14/09/18
-- TO_DATE() 출력에서는 차이가 없어보인다. TO_CHAR()+TO_DATE()에서는?
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'),'YYYYMMDD'),  -- 20980630
        TO_CHAR(TO_DATE('980630', 'RRMMDD'),'YYYYMMDD'), -- 19980630
        TO_CHAR(TO_DATE('140918', 'YYMMDD'),'YYYYMMDD'), -- 20140918
        TO_CHAR(TO_DATE('140918', 'RRMMDD'),'YYYYMMDD')  -- 20140918
FROM DUAL; -- 20980630	19980630	20140918	20140918
-- 앞에있는 천의자리랑 백의자리가 생략되어있어서 그동안 몰랐던 것.
-- TO_CHAR()로 천의자리까지 만들어준 것
-- Y : 두자리 연도에 무조건 현재 세기(21세기 , 20XX) 적용
-- R : 두자리 연도가 50이상일 때, 이전 세기(20세기,19XX) 적용
--     두자리 연도가 50미만일 때, 현재 세기(21세가, 20XX) 적용


------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- C) TO_NUMBER
-- 문자형 데이터를 숫자형 데이터로 변환

SELECT '1234' CHAR_NUMBER, TO_NUMBER('1234') FROM DUAL;

-- CHAR + CHAR 숫자 연산 가능한데 왜 굳이 NUMBER연산해야할까?
--
SELECT '1234'+'4321' FROM DUAL; -- 5555
SELECT '10,000' + '5,000' FROM DUAL; -- ERROR : invalid number
 -- 쉼표 때문에 에러. 사람이 인식하기에 ,는 숫자 자릿수 구분이지만
 --  컴퓨터한테는 쉼표가 붙어 숫자로 인식할 수 없게 된 것
SELECT TO_NUMBER('10,000') FROM DUAL; -- ERROR : invalid number
SELECT TO_NUMBER('10,000','999,999') FROM DUAL; -- 10000
-- 두번째 인자 : 지금 들어온 문자 타입이 이런 형식이라는 것을 인식시키는 기준
SELECT TO_NUMBER('10,000','999,999'), TO_NUMBER('5,000','999,999') FROM DUAL;--10000	5000
SELECT TO_NUMBER('10,000','999,999') + TO_NUMBER('5,000','999,999') FROM DUAL;--15000









------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 5)NULL처리 함수


-- NVL
-- null값을 지정한 값으로 대체하는 함수
--
-- 실제값을 바꾸는건 X
-- 대체할 값은 대체할려는 데이터의 타입을 따라가야한다 
--      ex)bonus의 데이터타입이 number이므로 숫자만가능

-- NULL을 다른 값으로 인지시키게 못하나?로부터 나오게 됨
SELECT EMP_NAME, BONUS, NVL(BONUS, 0) 
FROM EMPLOYEE;

SELECT NVL(BONUS, '보너스X') -- ERROR : : invalid number
FROM EMPLOYEE; -- ex)bonus의 데이터타입이 number이므로 숫자만가능

-- NVL2
-- NVL2(컬럼명, NULL이면 이걸로 변경, NULL이 아니면 이걸로 변경)
-- NULL값이 존재한다면 두번쨰 인자값으로 변경, NULL값이 존재하지 않으면 세번쨰 인자값으로 변경
-- 해당데이터가 NULL이면 0.7로 아니면 0.5로 대체


-- NULLIF
-- 비교하는 값이 같으면 NULL, 다르면 앞에 있는 값 반환
-- (NULL)	123





------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 6.선택함수

-- DECODE
-- DECODE(계산식|컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ...)
-- 계산식에 따라 조건값1에 맞으면 선택값1 반환, 조건값2에 맞으면 선택값2를 반환하는 함수
-- 범위를 다루는 >,< 같은 것들은 DECODE로 쓸 수 없다
-- JAVA SWITCH 스위치도 딱딱 수가 떨어지는 것만 가능

-- 주민번호 옆에 성별 같이 찍히도록 해볼 것




-- 직원의 급여를 인상하고자 한다
-- 직급코드가 J7인 직원은 급여의 10%를 인상하고
-- 직급코드가 J6인 직원은 급여의 15%를 인상하고
-- 직급코드가 J5인 직원은 급여의 20%를 인상하며
-- 그 외 직급의 직원은 급여의 5%만 인상한다
-- 직원 테이블에서 직원명, 직급코드, 급여, 인상급여(위 조건)을 조회




-- CASE ~ WHEN ~ THEN
-- CASE WHEN 조건식THEN 결과값
--      WHEN 조건식THEN 결과값
--      ELSE 결과값
-- END




-- 직원의 급여를 인상하고자 한다
-- 직급코드가 J7인 직원은 급여의 10%를 인상하고
-- 직급코드가 J6인 직원은 급여의 15%를 인상하고
-- 직급코드가 J5인 직원은 급여의 20%를 인상하며
-- 그 외 직급의 직원은 급여의 5%만 인상한다
-- 직원 테이블에서 직원명, 직급코드, 급여, 인상급여(위 조건)을 조회


-- 위와 같은 코드
-- CASE 공통된컬럼명 WHEN 조건식 THEN 결과


-- 사번, 사원명, 급여, 등급조회
-- 등급 조건 : 급여가 500만보다 크면 1등급, 350만보다 크면 2등급, 200만보다 크면 3등급, 나머지는 4등급
-- DECODE로도 가능?
-- 범위를 다루는 >,< 같은 것들은 DECODE로 쓸 수 없다
-- JAVA SWITCH 스위치도 딱딱 수가 떨어지는 것만 가능





------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
---------------------------------- 그룹 함수 ----------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- 그룹 함수


-- SUM
-- 총합계
-- EMPLOYEE테이블에서 전 사원의 급여 총합



-- EMPLOYEE테이블에서 남자사원의 급여 총합



-- AVG
-- 평균
-- EMPLOYEE테이블에서 전 사원의 급여 평균
 -- 3047662.60869565217391304347826086956522
 
-- EMPLOYEE테이블에서 여자사원의 급여 총합
-- 2542030


-- EMPLOYEE테이블에서 전 사원의 보너스 평균
-- BONUS가 NULL인 사원은 0으로 처리
-- 0.0847826086956521739130434782608695652174
-- SUM(BONUS)/23



-- 0.2166666666666666666666666666666666666667
-- NULL을 가진 값은 평균 계산에서 제외되어 계산
-- SUM(BONUS)/9



-- MIN / MAX
-- 최소 / 최대
-- 숫자, 날짜, 문자도 가능
-- EMPLOYEE테이블에서 최소 급여와 최대 급여
-- 1380000	8000000




-- 문자 넣기

-- 날짜 넣기



-- COUNT
-- NULL값은 제외하고 카운트
-- 23
-- 직원 23명 카운트함

-- 21
-- NULL 2명을 제외한 21 반환




------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------















------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------








------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------















------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------








------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



















------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------








------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



