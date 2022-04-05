------------------------------------------------------------------------------
----------------------------DB에서의 객체---------------------------------------
------------------------------------------------------------------------------

-- DB에서의 객체

-- DB에서 사용하는 객체가 테이블 ONLY?
-- 굉장히 많다
-- ex)USER, VIEW, SEQUENCE, SYNONYM, INDEX


/*
0302-0303
INDEX
검색하는 속도 증가를 위해 많이 사용함. 중요
인덱스를 쓸려면 인덱스에 따로 저장할 별도의 공간이 필요해짐

데이터 추가,수정(DML작업) 자주 일어나면 오히려 성능 저하시킴

인덱스는 이미 만들어져 있음
고유인덱스 : 프라이머리키,유니크 만들면 자동으로 생성됨

인덱스 보는 방법 : KH계정들어가서 테이블 아래 카테고리 인덱스

5만건 데이터로 돌리는데도 속도차이가 크게 차이가 나지는 않음

*/

------------------------------------------------------------------------------





------------------------------------------------------------------------------
-----------------------------------VIEW---------------------------------------
------------------------------------------------------------------------------
/*

-- VIEW
SELECT 쿼리 실행 결과 화면을 저장한 객체
    (=RESULT SET을 저장한 객체)
실질적인 데이터를 저장하고 있는 것이 아니나 테이블을 사용하는 것과 동일하게 사용 가능
    -> 이런 특성 때문에 뷰를 '논리적인 가상 테이블'이라고 부름
물리적인 테이블에 근거한 논리적인 가상의 테이블로, 데이터가 없고 테이블에 대한 SQL만 저장되어
있다. 사용자가 VIEW에 접근할 경우 SQL이 수행되면서 그 결과를 가져온다


DB를 직접적으로 만지는거보다 프로그래밍할 일이 대부분 일 것
근데 만지게 된다면 테이블 자체를 다루기보다 뷰로 바꿔서 받아서 일하게 될 것임
테이블 망치거나 날릴 위험을 신입에게 주지는...


뷰 공부할 부분
생성이랑 옵션만 기억해놓으면 된다


*/

SELECT * FROM USER_VIEWS; -- 뷰에 대한 정보 데이터 딕셔너리
-- 아직 만든 뷰가 없어서 결과가 출력되지는 않는다


-- VIEW 생성
-- CREATE
-- CREATE VIEW 뷰명
-- Q.뷰를 생성하기 위해 왜 CREATE라는 명령어를 사용할까?
-- A.VIEW가 객체이기 때문 // 객체 생성은 CREATE

-- 사번, 이름, 부서명, 근무지역의 조회 결과를 뷰 V_EMPLOYEE에 저장
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME -- SUBQUERY를 이용한 객체생성
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE);
-- ERROR : infficient privileges
-- 뷰는 생성 권한이 따로 필요함. 현재 권한이 없는 상태이기에 아래와 같은 에러 발생
-- 권한은 관리자계정(SYSTEM)에서 줄 수 있다. 
-- SYSTEM으로 계정 변경 후 권한부여 코드 입력

-- 권한부여 코드
GRANT CREATE VIEW TO KH; -- Grant을(를) 성공했습니다.



CREATE OR REPLACE VIEW V_EMPLOYEE -- OR REPLACE를 일단 뷰 생성 시, 쓴다고 생각할 것
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME -- SUBQUERY를 이용한 객체생성
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE);
        
SELECT * FROM USER_VIEWS; 

SELECT * FROM EMPLOYEE
WHERE EMP_ID = 205; -- 정중하 


-- 사번 205번인 직원의 이름을 정중앙으로 변경
UPDATE EMPLOYEE
SET EMP_NAME = '정중앙'
WHERE EMP_ID = 205;

SELECT * FROM EMPLOYEE WHERE EMP_ID = 205;  -- 정중앙
SELECT * FROM V_EMPLOYEE WHERE EMP_ID = 205;  -- 정중앙 // VIEW에서도 변경되서 출력됨
-- 베이스테이블인 EMPLOYEE테이블의 정보가 변경되면 VIEW에도 똑같이 변경됨
-- 뷰는 SELECT 쿼리 실행 결과 화면(RESULT SET)을 저장한 객체이기 때문

ROLLBACK; -- 다시 정중하로 롤백
        

-- VIEW에 별칭을 넣어서 생성
CREATE OR REPLACE VIEW V_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO,8,1),1,'남','여'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
-- ERROR : ORA-00998: must name this expression with a column alias
-- 00998. 00000 -  "must name this expression with a column alias"
-- 컬럼에 별칭 짓겠다고 하고 안만들어서 난 에러
-- 별칭 생성해야만 할 때 : 서브쿼리 SELECT절 안에 함수가 포함되면 반드시 별칭 지정
-- 위 코드에서 함수는 DECODE, EXTRACT가 있기에 컬럼에 별칭 지정을 해야만한다
-- 별칭 추가해서 다시 시도
-- 뷰 별칭생성 방법1
CREATE OR REPLACE VIEW V_EMP_JOB
AS SELECT EMP_ID 사번, EMP_NAME "사원 명", JOB_NAME "직급 명",
            DECODE(SUBSTR(EMP_NO,8,1),1,'남','여') AS 성별,
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
    FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE); -- View V_EMP_JOB이(가) 생성되었습니다.
        
SELECT * FROM V_EMP_JOB; -- 별칭 적용 확인
   
-- 다른 별칭 생성법
-- 뷰 별칭생성 방법2 : 서브쿼리 안에서 지정
CREATE OR REPLACE VIEW V_EMP_JOB(사번, 이름, "직급 명", "성별(남/여)", 근무년수) -- 띄어쓰기,특문 등 ""은 여전히 필수
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO,8,1),1,'남','여'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);        
-- V_EMP_JOB뷰를 이미 방법1에서 생성했는데 방법2에서 중복에러 없이 생성됨
-- 뷰 옵션 때문 


/*
-- VIEW 옵션

    CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름[(alias,alias, ...)]
    AS subQuery  
    [WITH CHECK OPTION]
    [WITH READ OPTION];
    
[] : 생략가능

FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
NOFORCE : 기본값, 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성
WITH CHECK OPTION :옵션으로 설정한 컬럼의 값 수정 불가능
WITH READ OPTION : 뷰에 대해 조회만 가능(DML 불가능)

        
*/        
        
-- OR REPLACE
-- 기존의 동일한 이름의 뷰가 존재하면 덮어쓰고, 없으면 새로 생성하는 옵션

CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
    FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME, SALARY
    FROM EMPLOYEE;
-- 동명의 뷰를 SALARY 추가해서 다시 생성했어도 중복에러 없이 출력

-- OR REPLACE 없이 덮어쓰기 시도
CREATE VIEW V_EMP1
AS SELECT EMP_NAME, SALARY
 FROM EMPLOYEE;
-- ORA-00955: name is already used by an existing object
-- 원인 :OR REPLACE가 없기에 덮어쓰기가 안되서 에러 발생


-- 반대로 시도
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM V_JOB; 
SELECT * FROM JOB;  

INSERT INTO V_JOB VALUES('J8','인턴');
UPDATE V_JOB SET JOB_NAME = '알바' WHERE JOB_CODE = 'J8';
-- V_JOB에 알바로 변경했는데 왜 본테이블인 JOB에도 데이터가 변경됬을까?
DELETE FROM V_JOB WHERE JOB_CODE = 'J8'; -- 뷰도 본테이블도 삭제됨
-- 즉, 뷰를 수정해도 본테이블이 영향이가고 본테이블 수정해도 뷰에 수정이됨
-- WHY?
-- VIEW의 구조 때문


/*
-- 뷰의 구조
4:35-4:40
-- 뷰를 사용할 대 정의했던 문장이
뷰가 실행이 될 때는 셀렉트 문장이 실행이되면서 다시 보여주는 것

뷰에 실제 데이터가 담겨있는 것X
뷰, 셀렉트한 실행 결과화면을 저장한 객체
V_JOB을 통해서 다시 텍스트를 다시 실행시킴. 
SELCT JOB_CODE JOB_NAME FROM JOB 얘를 다시 실행시켜서 화면에 뿌려주는 것
이러다보니 실제로 실행시키는 건 텍스트에 들어있는 코드를 기준으로 실행하다보니
본테이블과 뷰가 서로 상호작용 할 수 밖에 없는 상황이 되는 것

뷰를 수정하면 본테이블도 바뀌는이유
뷰 안 TEXT안에 FROM JOB(본테이블과 연결된 부분)이라고 적힌 부분 때문에 본테이블과 연결되는 것
VIEW에서는 따로 TEXT에서 코드를 실행해서 사람에게 보여주는데 이 TEXT 코드에 안에 
본테이블인 JOB의 데이터를 참조해서 끌어와 쓰기 때문에 본테이블과 뷰 서로 영향이 있다




왜 실제 데이터 저장안한다고 할까?
V_JOB을 보면 TEXT에 보면 내가 정의한 쿼리의 컬럼들인 SELCT JOB_CODE JOB_NAME FROM JOB이 그대로 들어있다
V_JOB의 TEXT에 저장되어 있는 값을 따로 실행시키는 것
V_JOB의 TEXT라는 쿼리를 실행하는 것
여기서 본 테이블과 연결되는 이유는 이 TEXT안에 FROM JOB이라고 적힌 부분 때문에 연결되는 것


뷰 사용 이유 : 위험성 감소를 위해
영향을 미친다는게 이와 상충 되는데 왜 뷰를 쓸까?
나중에 설명



*/

SELECT * FROM USER_VIEWS;


------------------------------------------------------------------------------


-- VIEW에서 DML명령어로 조작할 수 없는 경우
-- 1.뷰 정의에 포함되지 않는 컬럼을 조작하는 경우
-- 2.뷰에 포함되지 않은 컬럼 중 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
-- 3.산술 표현식으로 정의된 경우
-- 4.그룹함수 또는 GROUP BY절을 포함한 경우
-- 5.DISTINCT를 포함한 경우



-- 1.뷰 정의에 포함되지 않는 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW V_JOB2
AS SELECT JOB_CODE
    FROM JOB;

SELECT * FROM V_JOB2;

INSERT INTO V_JOB2 VALUES ('J8','인턴');
-- SQL 오류: ORA-00913: too many values
UPDATE V_JOB2 SET JOB_NAME = '인턴' WHERE JOB_CODE = 'J7';
-- SQL 오류: ORA-00904: "JOB_NAME": invalid identifier
-- JOB_NAME이라는게 없기에 에러
DELETE FROM V_JOB2 WHERE JOB_NAME = '인턴';
-- SQL 오류: ORA-00904: "JOB_NAME": invalid identifier


-- 2.뷰에 포함되지 않은 컬럼 중 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME
    FROM JOB;

SELECT * FROM V_JOB3;

INSERT INTO V_JOB3 VALUES('인턴');
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- JOB에 NOT NULL 제약조건 때문에 에러

-- 3.산술 표현식으로 정의된 경우
CREATE OR REPLACE VIEW EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + SALARY + SALARY*NVL(BONUS,0))*12 연봉
    FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL VALUES(800, '남나눔',3000000,3600000);
-- SQL 오류: ORA-01733: virtual column not allowed her
UPDATE EMP_SAL SET 연봉=8000000 WHERE EMP_ID = 200;
-- SQL 오류: ORA-01733: virtual column not allowed here


-- 4.그룹함수 또는 GROUP BY절을 포함한 경우
CREATE OR REPLACE VIEW V_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) 합계, AVG(SALARY) 평균
    FROM EMPLOYEE
    GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT VALUES('D10',600000, 4000000);
-- SQL 오류: ORA-01733: virtual column not allowed here
UPDATE V_GROUPDEPT SET DEPT_CODE = 'D10' WHERE DEPT_CODE = 'D3';
-- SQL 오류: ORA-01732: data manipulation operation not legal on this view
DELETE FROM V_GROUPDEPT WHERE DEPT_CODE = 'D1';
-- 지금까지 삭제는 왠만하면 됬었는데, 4번의 경우는 삭제 불가

-- 5.DISTINCT를 포함한 경우
CREATE OR REPLACE VIEW V_DT_EMP
AS SELECT DISTINCT JOB_CODE
    FROM EMPLOYEE;
    
SELECT * FROM V_DT_EMP;

INSERT INTO V_DT_EMP VALUES('J9');
-- SQL 오류: ORA-01732: data manipulation operation not legal on this view
UPDATE V_DT_EMP SET JOB_CODE = 'J9' WHERE JOB_CODE = 'J7'; 
-- SQL 오류: ORA-01732: data manipulation operation not legal on this view
DELETE FROM V_DT_EMP WHERE JOB_CODE = 'J1';
-- SQL 오류: ORA-01732: data manipulation operation not legal on this view


--6.JOIN을 통해서 여러 테이블을 연결한 경우
CREATE OR REPLACE VIEW V_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP VALUES(800,'남나눔','인사관리부');
-- SQL 오류: ORA-01776: cannot modify more than one base table through a join view
UPDATE V_JOINEMP SET DEPT_TITLE = '인사관리부' WHERE EMP_ID = 219;
-- SQL 오류: ORA-01779: cannot modify a column which maps to a non key-preserved table



-- 어떤건 INSERT가 어떤건 DELETE가 안되고 다 다르다
-- 1-6번 외울 필요 X // VIEW 쓸 일이 생기면 저절로 익혀질 것



------------------------------------------------------------------------------
/*
-- VIEW 옵션

    CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름[(alias,alias, ...)]
    AS subQuery  
    [WITH CHECK OPTION]
    [WITH READ OPTION];
    
[] : 생략가능

FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
NOFORCE : 기본값, 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성
WITH CHECK OPTION :옵션으로 설정한 컬럼의 값 수정 불가능
WITH READ OPTION : 뷰에 대해 조회만 가능(DML 불가능)

*/
------------------------------------------------------------------------------


-- FORCE / NOFORCE
-- FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
-- NOFORCE : 기본값, 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성

CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP2 -- NOFORCE가 생략되서 들어가있는 상태
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
-- ERROR : ORA-00942: table or view does not exist    
    
CREATE OR REPLACE FORCE VIEW V_EMP2 -- FORCE
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT; 
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.
-- 뷰 생성 성공

-- FORCE가 필요한 경우
-- 설계하다가 뷰를 먼저 만들고 나중에 테이블을 나중에 만드는 경우가 가끔 있다
    
------------------------------------------------------------------------------

-- WITH CHECK OPTION
-- 옵션으로 설정한 컬럼의 값 수정 불가능

CREATE OR REPLACE FORCE VIEW V_EMP3 -- FORCE
AS SELECT * FROM EMPLOYEE
    WHERE DEPT_CODE = 'D9'
WITH CHECK OPTION; -- DEPT_CODE에 대한 UPDATE 불가능
-- WITH CHECK OPTION

SELECT * FROM V_EMP3;

-- 업데이트 시도해보면 에러남
UPDATE V_EMP3 SET DEPT_CODE = 'D1' WHERE EMP_ID = 200;
-- ERROR : ORA-01402: view WITH CHECK OPTION where-clause violation

-- 이외에는 업데이트 가능

COMMIT;

UPDATE V_EMP3 SET EMP_NAME = '선동이' WHERE EMP_ID = 200;
-- 1 행 이(가) 업데이트되었습니다.
INSERT INTO V_EMP3
VALUES(902, '도대담','111111-1111111','d@d.d','01022223333','D9','J3','S3',
        3500000, 0.2, 200, SYSDATE, NULL, 'N');
-- ERROR : ORA-01402: view WITH CHECK OPTION where-clause violation
-- D1에 넣을려해서 에러
-- D9에 넣으면 삽입 가능

SELECT * FROM V_EMP3;

ROLLBACK;



------------------------------------------------------------------------------

-- WITH READ OPTION
-- 뷰에 대해 조회만 가능(DML 불가능)
-- 조회만 할 수 있게 WITH READ OPTION 이 옵션이 있을 가능성 높음


CREATE OR REPLACE FORCE VIEW V_DEPT -- FORCE
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM V_DEPT;

INSERT INTO V_DEPT VALUES('D10', '해외영업4부','L1');
-- 업데이트, 삭제 다 불가
UPDATE V_DEPT SET LOCATION_ID = 'L2';
DELETE FROM V_DEPT;


--뷰
--생성이랑 옵션만 기억해놓으면 된다
--나머지는 교양으로 들어두면 됨


------------------------------------------------------------------------------
------------------------------------------------------------------------------
/*


*/
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


