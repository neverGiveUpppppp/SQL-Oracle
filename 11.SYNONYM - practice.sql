------------------------------------------------------------------------------
------------------------------------SYNONYM----------------------------------
------------------------------------------------------------------------------

/*

-- SYNONYM
SYNONYM = 동의어 = 데이터베이스 객체에 대한 '별칭'

별칭을 의미함
동의어는 데이터베이스 객체에 대한 별칭



다른 객체를 부르는 말

동의어는 객체만 설정 가능

가상테이블에 접근할 수 있는 코드로 DUAL을 사용하는 것


CREATE SYNONYM 별칭명 FOR 테이블명; 


*/

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 비공개 동의어

CREATE SYNONYM EMP FOR EMPLOYEE; 
-- EMPLOYEE 테이블의 별칭을 EMP로 지어놓겠다는 의미
-- ERROR : ORA-01031 : insufficient privileges
-- 유저나 뷰의 권한 생성 때처럼 시노님도 권한을 부여해야한다

--GRANT CREATE TO 계정명; -- VIEW 때 권한 부여 코드. 
--SYSTEM계정으로 옮겨가서 아래 코드 작성.
GRANT CREATE SYNONYM TO KH;
-- Grant을(를) 성공했습니다.

CREATE SYNONYM EMP FOR EMPLOYEE;
CREATE SYNONYM EMP FOR EMPLOYEE;
------------------------------------------------------------------------------

-- 공개 동의어

CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT; -- PUBLIC 추가
-- SYSTEM계정으로 바꾸고나서 실행
-- KH.테이블명 하면 타계정에도 접촉 가능 
SELECT * FROM DEPT;

DROP SYNONYM EMP; -- KH계정에서 실행
DROP PUBLIC SYNONYM DEPT; -- 공개 동의어 삭제는 시스템 계정에서


------------------------------------------------------------------------------










------------------------------------------------------------------------------
------------------------------------------------------------------------------










------------------------------------------------------------------------------
------------------------------------------------------------------------------






