--DAA DICTIONARY = 데이터 사전
-- 데이터베이스에 관한 전반적인 정보 제공
-- 관리자 계정은 내용 변경에 대한 권한을 가지고 있지만
-- 일반 사용자계정은 읽기만 가능함(단순 조히ㅗ)

-- 계정 생성
-- 12c 이상에서부터 계정을 만들기 위해 앞에 c##을 붙여야만 가능하게 만듬
-- CREATE USER C##KH IDENTIFIED BY KH;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- 11g 포함
CREATE USER KH IDENTIFIED BY KH; -- 권한 부여

