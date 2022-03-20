
--------------------------- �Լ�(FUNCTION)------------------------------

/*
22.03.14

�Լ�(FUNCTION)

�Լ�(FUNCTION) �� ����
A.���� �� �Լ�
B.�׷� �Լ�

A.���� �� �Լ�
    1.���� ���� �Լ� : LENGTH, INSTR,LPAD,LTRIM,TRIM,SUBSTR, CONCAT,REPLACE
    2.���� ���� �Լ� : ABS,MOD,ROUND,CEIL,FLOOR/TRUNC
    3.��¥ ���� �Լ� : MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY,LAST_DAT,EXTRACT
    4.����ȯ �Լ� : TO_CHAR, TO_DATE, TO_NUMBER
    5.nulló�� �Լ� : NVL, NVL2, NULLIF 
    6.���� �Լ� : DECODE, CASE WHEN THEN
    
B.�׷��Լ�
SUM, AVG, MIN/MAX, COUNT

---------------------------------------------------------------------------
---------------------------------------------------------------------------


 1.���� �� �Լ�
n���� �����͸� ������ n���� ������ ��
n���� ���� �о n���� ��� ����

2.�׷� �Լ�
n���� �����͸� ������ 1�� ������ ��
n���� ���� �о� 1���� ��� ����


Q. SELECT���� ���� �� �Լ��� �׷� �Լ��� �Բ� ����� �� �ִ�/����?
A. ����

WHY?
result set�� ����� ���̺��̾���
������ ���� ���� ����� �����µ� �׷��� �ϳ��� ���̺��� ���´�
���� ���� ���̺� �ϳ��� ����� �ȳ����� ��

-- SELECT���� ���� �� �Լ��� �׷��Լ��� �Բ� ����� �� ����
��� ���� ������ �ٸ��� ����


�Լ��� ����� �� �ִ� ��ġ
SELECT ��
WHERE ��
GROUP BY ��
HAVING ��
ORDER BY ��
( ��ǻ� ����Ʈ���� �� ����)


<SELECT�� ������� �� �������>
1. FROM ���̺�� - ��ȸ ��� �÷��� �ִ� ���̺�� ���
2. WHERE �÷��� ������ ���� - ���� �����ϴ� ������ ���
3. GROUP BY �÷��� } ���� - �׷칭�� �÷���, ���� ���
4. HAVING �׷��Լ� ������ �񱳰� - �׷칭�� ������ �׷��Լ��� ����� ������ ���� ���Ǳ��
5. SELECT * | [DISTINCT] �÷���, ���� [AS] ��Ī
6. ORDER BY �÷��� | ��Ī | �÷����� [ASC] | DESC
 
*/
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 1.���� �� �Լ�
-- 1)���� ���� �Լ�
-- LENGTH / LENGTHB
-- ���� : ����,����,Ư����ȣ, �÷��� 
-- B = BYTE
-- LENGTH  : ����
-- LENGTHB : ������ ����Ʈ ������ ��ȯ 
--      �ѱ� : 3 byte
--      ����, ����, Ư����ȣ : 1 byte

SELECT LENGTH('����Ŭ') FROM DUAL;  -- 3    
SELECT LENGTHB('����Ŭ') FROM DUAL; -- 9  
-- DUAL : ���� ���̺� 

-- DUAL
-- ���� ���̺������� �����ϰ� ���� ���� �� ����ϴ� ���� ���̺�

SELECT LENGTH(EMAIL), LENGTHB(EMAIL) FROM EMPLOYEE; -- 15 15
-- ���ͷ����� ���������� �÷��� ����

SELECT LENGTH(EMP_NAME), LENGTH(EMAIL) FROM EMPLOYEE;   -- 3	15
-- �̸�, �̸��� -> ����, ����Ʈ ������

SELECT LENGTHB(EMP_NAME), LENGTHB(EMAIL) FROM EMPLOYEE; -- 9	15
SELECT EMP_NAME, LENGTHB(EMP_NAME), LENGTHB(EMP_NAME) FROM EMPLOYEE; -- ����B 9
        
SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
        EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- ������	3	9	sun_di@kh.or.kr	15	15


------------------------------------------------------------------------------
------------------------------------------------------------------------------


--  INSTR
-- �ش� ���ڿ��� ó�� ���� ��ġ �ε�����ȣ ��ȯ(ZERO-INDEX X)
-- INSTR(�����ڿ���or�÷���, ��ã�Ƴ� ���ڡ�,  ���� index, 2��°������ ���ڰ� ���° ������ ��������)

--1��° ���� : ã�� ���ڿ� or �÷���
--2��° ���� : ù��° �߿� ã�� ���� ����
--3��° ���� : ���°���� �б� ������ ���̳�. �������� 1���� ����
--4��° ���� : ' '�� ���ڰ� ����°���ڷκ��� ���� �����ؼ� "���°�� ������ �����ΰ���
--    1,2��° ���ڴ� ���ͷ�( �� �� )�� ���Ѵ�
SELECT INSTR('AABAACAABBAA','B') FROM DUAL; -- 3
SELECT INSTR('AABAACAABBAA','Z') FROM DUAL; -- 0 // ���� ���ڿ��� 0��ȯ // ����, �����ε������ٸ� -1��ȯ
SELECT INSTR('AABAACAABBAA','A') FROM DUAL; -- 1

SELECT INSTR('AABAACAABBAA','B', 1) FROM DUAL; -- 3
SELECT INSTR('AABAACAABBAA','B', 7) FROM DUAL; -- 9 // 7��°���� �б� �����϶�� ���
-- �ڵ��ؼ� : 7�������� �б� �����ؼ� B�� ó�� ���� ������ �о, ó�� ������ B�� ��ġ ��ȯ��
SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL; -- 10 // ���̳ʽ�(-)�� �Ųٷ� �б�
-- ���̳ʽ�(-)�� �Ųٷ� �б�
-- ���� �ڿ��� ���� ������ �������� �������� ���� �ε�����ȣ�� �ǿ��ʿ��� ����������
SELECT INSTR('AABAACAABBAA','A',-3) FROM DUAL; -- 8
SELECT INSTR('AABAACAABBAA','B',1,2) FROM DUAL; -- 9
-- 1�������� �ι�° �ִ� 'B'�� ã�ƶ�
SELECT INSTR('AABAACAABBAA','C',1,2) FROM DUAL; -- 0

SELECT INSTR('AABAACAABBAA', 'AB',3) FROM DUAL; -- 8
-- �α��� �̻��� ù���� �������� �ε�����ȯ

-- 3��° ����, ���̳ʽ�(-): �Ųٷ� �б�
SELECT INSTR('AABAACAABBAA','B',-1) FROM DUAL; -- 10
SELECT INSTR('AABAACAABBAA','B',-1,1) FROM DUAL; -- 10
SELECT INSTR('AABAACAABBAA','B',-1,2) FROM DUAL; -- 9
SELECT INSTR('AABAACAABBAA','B',-1,3) FROM DUAL; -- 3

SELECT INSTR('AABAACAABBAA','B',-1,-1) FROM DUAL; -- ERROR : 4��° ���ڴ� ����� ����
SELECT INSTR('AABAACAABBAA','B',-1,0) FROM DUAL;  -- ERROR : 4��° ���ڴ� 0,���� �Ұ�



-- EMPLOYEE���̺��� �̸����� @��ġ ��ȯ
SELECT INSTR(EMAIL,'@',1) FROM EMPLOYEE; -- 7 
SELECT EMAIL, INSTR(EMAIL,'@') FROM EMPLOYEE; -- sun_di@kh.or.kr 7
-- ���� ���̺��� ����

SELECT EMP_NAME, EMAIL, INSTR(EMAIL, '@') FROM EMPLOYEE;

------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- LPAD / RPAD
 ���� ���� / ������ ����
 ������ ���� / ���� ����
 LPAD(�÷���, ���� �� ����,���� ��� ��ü�� ����)
 �־��� ���� ������ ���ڿ��� ����/�����ʿ� ���ٿ� ���� n���� ���ڿ� ��ȯ
 ��ü ���̿��� ���� ������ �������� ä��


SELECT LPAD(EMAIL,20) FROM EMPLOYEE; --      sun_di@kh.or.kr//
SELECT RPAD(EMAIL,20) FROM EMPLOYEE; -- sun_di@kh.or.kr     //
SELECT LPAD(EMAIL,20), RPAD(EMAIL,20) FROM EMPLOYEE;

SELECT LPAD(EMAIL,11), RPAD(EMAIL,20) FROM EMPLOYEE;
-- ������ ������ �ѱ��̰� ª���� �ں��� ©��

-- ������ ��ü�� ���� ����
SELECT LPAD(EMAIL, 20, '#'), RPAD(EMAIL,20, '*') FROM EMPLOYEE;
SELECT LPAD(EMAIL,5), RPAD(EMAIL,5) FROM EMPLOYEE;

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- LTRIM / RTRIM
-- ��/�쿡������ ������ ���ڸ� ������ ������ ��ȯ
--      ���ڸ� �������� ���� ���, ���� ����
-- LTRIM(�÷���,'���﹮��')
-- LTRIM : ���ʺ��� ������� ����
-- RTRIM : �����ʺ��� ������� ����
-- ������� ���ڰ� �ƴ� ���ڿ� �ٴٸ��� TRIM ����

-- �ڹ� STRINGŬ�������� TRIM�� �������� �޼ҵ�

SELECT LTRIM('   KH') FROM DUAL; -- KH//
SELECT RTRIM('   KH') FROM DUAL; --    KH//
SELECT LTRIM('000123456','0') FROM DUAL; -- 123456
-- 0�� �����ϰ� �������� ��ȯ
SELECT LTRIM('0001230456','0') FROM DUAL; -- 1230456
-- �߰��� ���ִ� �ش� ���ڴ� ����X
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL; -- KH
-- 'ABC' ������ ���� �ϳ��� ���°� �ƴ϶�, A �Ǵ� B �Ǵ� C�� ������ �� ����� ��
-- 'ABC' �ȿ� ���� ���X
SELECT RTRIM('KH   ') A FROM DUAL; -- KH
-- �����ʺ��� ��������
SELECT RTRIM('01230456000','0') FROM DUAL; -- 01230456
SELECT RTRIM('KHACABACC', 'BAC') FROM DUAL; -- KH
-- �����ʺ��� ����� ����

SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; -- KH
SELECT LTRIM('ACABACCKH','CBA') FROM DUAL; -- KH
SELECT RTRIM('ACABACCKH','CBA') FROM DUAL; -- ACABACCKH // -- ������� ���ڰ� �ƴ� ���ڿ� �ٴٸ��� TRIM ����
SELECT RTRIM('ACABACCKH','ABC') FROM DUAL; -- ACABACCKH 
-- ������� ���� A�Ǵ�B�Ǵ�C�� �ƴ� KH�� �´ڵ鿩 ���� ���� ACABACCKH ��ȯ

------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- TRIM
-- ��/��/���ʿ��� ������ ���ڸ� ������ ������ ��ȯ
-- TRIM(���Ź��� '������ ���� 1��' FROM 'ã�� ���ڿ�OR�÷���')
-- LEADING : �պ��� ����
-- TRAILING : �ں��� ����
-- BOTH : ���ʿ������� ����

SELECT TRIM('   KH   ') A FROM DUAL; -- KH // A�� ��Ī
SELECT TRIM('   KH   ') FROM DUAL; -- KH
--SELECT TRIM('ZZZKHZZZ', 'Z') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL; -- KH
SELECT TRIM('123' FROM '123KH3123123') FROM DUAL; -- error : trim set should have only one character
-- TRIM�� ������ ���� 1���� �޴´�
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- KHZZZZ
-- LEADING �պ��� ����
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- ZZZKH
-- TRAILING �ں��� ����
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZZ') FROM DUAL; -- KH
-- BOTH ���ʿ������� ����

SELECT TRIM('   KH   ') FROM DUAL; -- KH
SELECT TRIM(BOTH FROM '   KH   ') FROM DUAL; -- KH//
SELECT TRIM(BOTH ' ' FROM '   KH   ') FROM DUAL; -- KH//
SELECT TRIM(BOTH FROM '   KH   ') FROM DUAL; -- KH// 2������ ������ ���� : ��������
SELECT TRIM(LEADING 'K' FROM '   KH   ') FROM DUAL; --    KH   // ���鿡�� ���� K��������
SELECT TRIM(TRAILING 'K' FROM '   KH   ') FROM DUAL; --    KH   //���鿡�� ���� K��������
SELECT TRIM(TRAILING ' ' FROM '   KH   ') FROM DUAL; --    KH//


------------------------------------------------------------------------------
------------------------------------------------------------------------------

--SUBSTR
-- String.substring()
--SUBSTR(�÷���, ������ġ �ε���, ������ġ���� ���� ��ȯ�� ����)

SELECT SUBSTR('HELLOMYGOODFRIENDS',7) FROM DUAL; -- YGOODFRIENDS
-- 7��°������ ������ ��ȯ
SELECT SUBSTR('HELLOMYGOODFRINEDS', 5, 2) FROM DUAL; -- OM
-- 5��° ���ں��� 2���� ��ȯ
SELECT SUBSTR('HELLOMYGOODFRINEDS', 5, 0) FROM DUAL; -- (null)
-- 5���� ���ں��� 0�� ��ȯ // 0�� ��ȯ�� �Ұ����ϱ⿡ NULL ��µ�
SELECT SUBSTR('HELLOMYGOODFRINEDS', 1, 6) FROM DUAL; -- HELLOM
SELECT SUBSTR('HELLOMYGOODFRINEDS', -8, 3) FROM DUAL; -- DFR
-- �ڿ��� 8��°(D)���� ���������� 3���� ���� ��ȯ
-- ������ ���̳ʽ�(-)������ �������� �ڿ������� ���� ���ʹ������� ī���������� ��� ���������� ī����
SELECT SUBSTR('HELLOMYGOODFRINEDS', -10, 2) FROM DUAL; -- OO

-- 0���� �����ص� 1���� ����
SELECT SUBSTR('HELLOMYGOODFRIENDS',0,5) FROM DUAL; -- HELLO // 0���� �����ص� 1���� ����
SELECT SUBSTR('HELLOMYGOODFRIENDS',1,5) FROM DUAL; -- HELLO // 0���� �����ص� 1���� ����
-- ���̳ʽ�(-) ����
SELECT SUBSTR('HELLOMYGOODFRIENDS',-10,2) FROM DUAL;  -- OO
SELECT SUBSTR('HELLOMYGOODFRIENDS',-10,-2) FROM DUAL; -- 3RD ���� ���°���������� -�̸� NULL��



-- EMPLOYEE ���̺��� �̸�, �̸���, �̸����� ���̵� ��ȸ
-- (�̸����� @ �����θ��� ���̵������)
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) 
FROM EMPLOYEE;
-- ����Ǯ�� ������
-- 1.�̸��� ���̵��� ��Ģ�� �׻� @�� �տ� ����
-- 2. @ ��ġ �ľ�
-- 3. 1~@�ձ��� ã��




-- �ֹε�Ϲ�ȣ�� �̿��Ͽ� �̸��� ������ ��Ÿ���� �κ� ��ȸ
-- EMPLOYEE ���̺��� ���ڸ� ��ȸ(�����, '��')
-- EMPLOYEE ���̺��� ���ڸ� ��ȸ(�����, '��')


--SELECT EMP_NO, SUBSTR(EMP_NO, 7, INSTR(EMP_NO, '-')+1) FROM EMPLOYEE;
-- SUBSTR & INSTR ����ؼ� �� �� �ִ� ����� ������?

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) 
FROM EMPLOYEE;

SELECT EMP_NAME, '��'
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

SELECT EMP_NAME, '��'
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;


-- EMPLOYEE���̺��� �������� �ֹι�ȣ�� �̿��Ͽ� �����, ����, ����, ���� ��ȸ

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 2) ����, SUBSTR(EMP_NO, 3, 2) ����, SUBSTR(EMP_NO, 5, 2) ����
FROM EMPLOYEE;



------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- LOWER / UPPER / INITCAP
-- INITCAP :�� �ܾ��� ù���ڸ� �빮��
SELECT LOWER('Welcome To my World') from DUAL; -- welcome to my world
SELECT UPPER('Welcome To my World') from DUAL; -- WELCOME TO MY WORLD
SELECT INITCAP('Welcome To my World') from DUAL; -- Welcome To My World



------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- CONCAT
-- ���ڿ� �̾���̱�
SELECT CONCAT('�����ٶ�','123') FROM DUAL; -- �����ٶ�123
SELECT '�����ٶ�' || '123' FROM DUAL; -- �����ٶ�123
-- ���Ῥ���� : ||


-- �÷��� + ����
SELECT CONCAT(DEPT_CODE, '-333') FROM EMPLOYEE; -- D9-333
SELECT CONCAT(JOB_CODE, ' BY S') FROM JOB; -- J1 BY S
-- �÷��� + �÷���
SELECT CONCAT(DEPT_CODE, JOB_CODE) FROM EMPLOYEE; -- D9J1

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- REPLACE
-- REPLACE(�÷���,�ٲ��� �ܾ�, �ٲ� �ܾ�)
-- �� ��ü
SELECT REPLACE('����� ������ ���ﵿ','���ﵿ','�Ｚ��') FROM DUAL; -- ����� ������ �Ｚ��
SELECT REPLACE('������� ����Ŭ�� �������̴�','�����','������') FROM DUAL; -- �������� ����Ŭ�� �������̴�
-- ���� ������� ���밡��
SELECT REPLACE('����ũ �޴�. ����ũ �������?','����ũ','����') FROM DUAL; -- ���� �޴�. ���� �������?
-- ������ ����־ ������ ��ü����. ��ġ�� �ϸ� ���� ��ü��


-- EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ
-- �ֹι�ȣ�� ���ڸ��� *�� �ٲ㼭 ��ȸ(EX.001122-*******)

-- ���1
-- REPLACE+SUBSTR ���� ���� & ������ 
SELECT EMP_NO, REPLACE(EMP_NO,SUBSTR(EMP_NO,8,14) ,'*******') -- 630709-*******
--SELECT EMP_NAME, REPLACE(EMP_NO , SUBSTR(EMP_NO ,8), '*******')
FROM EMPLOYEE;

-- ���2
-- RPAD+SUBSTR
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,7),14,'*')
FROM EMPLOYEE;
-- RPAD+SUBSTR+INSTR
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,INSTR(EMP_NO,'-')),14,'*')
FROM EMPLOYEE;
-- RPAD+SUBSTR+INSTR+LENGTH
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,INSTR(EMP_NO,'-')),LENGTH(EMP_NO),'*')
FROM EMPLOYEE;

-- ���3
-- REPLACE+SUBSTR+INSTR+LENGTH
SELECT EMP_NAME, REPLACE(EMP_NO, SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1), '*******')
FROM EMPLOYEE;

-- ���4
-- SUBSTR+���Ῥ����(||)
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 7) || '*******' �ֹι�ȣ
FROM EMPLOYEE;

-- ���5
-- LPAD+���Ῥ����(||)
SELECT EMP_NAME, LPAD(EMP_NO , 7) || '*******'
FROM EMPLOYEE;
-- LPAD�� ���� �տ��� �������� �뵵�� �ƴϴ� ����

-- ���6
-- CONCAT+SUBSTR
SELECT EMP_NAME, CONCAT(SUBSTR(EMP_NO, 1, 7), '*******')
FROM EMPLOYEE;



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 2) ���� ���� �Լ�


-- ABS
-- ���밪 ��ȯ
SELECT ABS(10.9), ABS(-10.9), ABS(10), ABS(-10) FROM DUAL; -- 10.9	10.9	10	10
-- ���� ��� ���

-- MOD
-- ��ⷯ
-- ������ ���ϱ�
-- MOD(�������¼� ,������ ��)
SELECT MOD(10,3), MOD(-10,3), MOD(10,-3), MOD(-10,-3), MOD(10.9, 3) FROM DUAL; -- 1	-1	1	-1	1.9
-- ���� ���������� ���� ���� ��ȣ�� ���󰡰� ��

-- ROUND
-- ���° �ڸ����� �ݿø����� �Ҽ��� �ڸ��� ��������
SELECT ROUND(123.456), ROUND(123.789), -- 123	124	123	123.5	123.46	120	100
       ROUND(123.456, 0), ROUND(123.456, 1), ROUND(123.456, 2), -- �Ҽ��� �ڸ����� �ݿø�
       ROUND(123.456, -1), ROUND(123.456, -2) FROM DUAL; -- �Ҽ��� -�� �ݿø�


SELECT ROUND(-10.61) FROM DUAL; -- -11
-- ���̳ʽ�(-)�� �ݿø���?
-- ���̳ʽ��� ���ڰ� Ŭ���� ���� �� ex) -11�� -10���� ���� ��
-- -10.61���� .61�� 5�̻��̶� �ݿø��� �Ǵµ� -11��


-- CEIL
SELECT CEIL(123.456) FROM DUAL; -- 124
-- ������ 1�� �ڸ����� �ø��ϰ� �Ǿ�����
-- �ڸ��� ���� �Ұ�. �ٸ� ���ڰ� ��������� ����

-- FLOOR / TRUNC
-- FLOOR : ������ ����(����� ������ ����)     // �ڸ��� ���� �Ұ�
-- TRUNC : ����. ����. ���° �ڸ����� �����ڴ� // �ڸ��� ��������
-- ��������� ������ �� ����, �������� ���̳���. t
SELECT FLOOR(123.789), TRUNC(123.789), TRUNC(123.789,1) FROM DUAL; -- 123	123	123.7
-- TRUNC : ���° �ڸ����� �����ڴ� �ڸ��� ��������
-- ���̽㿡�� FLOOR�� -������ ������ TRUNC�� 0������ �����ϴ� �Ͱ� ���� ����
-- math.trunc(-3.14)   #����� -3
-- math.floor(-3.14)   #����� -4








------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------





-- 3)��¥ ���� �Լ�

-- SYSDATE
-- �ý��ۿ� ����Ǿ��ִ� �ð��� ���

SELECT SYSDATE FROM DUAL; -- 22/03/14


-- MONTHS_BETWEEN
-- �������� ���� ���ڷ� �������ִ� �Լ�
-- ex) MONTHS_BETWEEN(SYSDATE, HIRE_DATE)

-- EMPLOYEE���̺��� ����� �̸�, �Ի���, �ٹ� ���� �� ��ȸ
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) FROM EMPLOYEE; -- 385.283...
--SELECT EMP_NAME, HIRE_DATE, ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)) FROM EMPLOYEE; -- �����ڵ�
-- 368������
-- SYSDATE�� ��¥���� HIRE_DATE�� �� �� : SYSDATE - HIRE_DATE

SELECT EMP_NAME, HIRE_DATE, CEIL(ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))) || '������'
FROM EMPLOYEE; -- 368������
-- �յڷ� ���� ���� �𸥴ٸ� ABS�� �־ ���밪���� �޾ƿ��� �ȴ�




-- ADD_MONTHS
-- ���� ��¥���� ������ ���ڸ�ŭ�� �������� ���� ��¥ ����
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL; -- 22/07/14
-- ���ݺ��� 4���� �� ��ȯ��
SELECT ADD_MONTHS(SYSDATE, 10) FROM DUAL; -- 23/01/14
-- �������� �������� ������ �Ѿ�� ������ �ö�

--EMPLOYEE���̺��� ����� �̸�, �Ի���, �Ի� �� 6������ �� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) FROM EMPLOYEE;


-- NEXT_DAY
-- ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥ ����
-- 1=��, 2=��, 3=ȭ,4=��, 5=��, 6=��, 7=��
-- �ؽ�Ʈ�� �� �ձ��ڸ� ���ͼ� ���� ��ȯ
-- ��ȯ
-- ALTER SESSION SET NLS_LANGUAGE = AMERICAN;



-- ���� �������κ��� ���� ����� ����� ���ϱ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����') FROM DUAL; -- 22/03/15	22/03/17
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL; -- 22/03/15	22/03/17
SELECT SYSDATE, NEXT_DAY(SYSDATE, 5) FROM DUAL; -- 22/03/15	22/03/17
-- 1=��, 2=��, 3=ȭ,4=��, 5=��, 6=��, 7=��

SELECT SYSDATE, NEXT_DAY(SYSDATE, '���� �԰��ĤФ�') FROM DUAL; -- 22/03/15	22/03/16
-- ���ڸ԰��İ� ������ �ƴ����� �� �ձ��� '��'�� ���� ���� ��ȯ�ϴ� �� �� �� �ִ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '����ž') FROM DUAL; -- 22/03/15	22/03/18
-- ����ž�� �� �ձ��� '��' = �ݿ���


SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- ERROR : not a valid day of the week
-- �ѱ۸� �����ϰԲ� ������ �Ǿ��־� �νĿ��� �ߴ� ��

-- ����� ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- Session��(��) ����Ǿ����ϴ�.
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- 22/03/15	22/03/17
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL; -- 22/03/15	22/03/17
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSTY') FROM DUAL; -- 22/03/15	22/03/17
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR--') FROM DUAL; -- 22/03/15	22/03/17
-- �ѱ۰� �����ϰ� �ձ��ڸ� ������ ���� ��ȯ. �Ƹ��� ù������ �ѱ��ڸ� ġ�� ��
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'TTTT--') FROM DUAL; -- ERROR : not a valid day of the week
-- T������ ����. THUR���� ��� ��ȯ

SELECT SYSDATE, NEXT_DAY(SYSDATE, '����ž') FROM DUAL; -- ERROR : not a valid day of the week
-- �ѱ۷� ����
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '����ž') FROM DUAL; -- 22/03/15	22/03/18




-- LAST_DAY
-- �ش� ��¥�� ���� ������ �� ��ȯ
--��ȯ�� ���� : 00/00/00
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL; -- 22/03/15	22/03/31
SELECT LAST_DAY(SYSDATE) FROM DUAL; -- 22/03/31
SELECT LAST_DAY(JOB_CODE) FROM EMPLOYEE; -- ERROR
-- ORA-01841: (full) year must be between -4713 and +9999, and not be 0
-- ��¥�� �ƴ� ���� ��ǲ�ϴ� ����


-- EXTRACT
-- ��, ��, �� ���� ���� ��ȯ
-- �ð��� ���� �Ұ�


-- EMPLOYEE���̺��� ����� �̸�, �Ի翬��, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME,EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵,
                EXTRACT(MONTH FROM HIRE_DATE) �Ի��, 
                EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE; -- ������	1990	2	6

-- EMPLOYEE���̺��� ����� �̸�, �Ի���, �ٹ���� ��ȸ
-- ��, �ٹ������ ���翬�� - �Ի翬���� ��ȸ
SELECT EMP_NAME, HIRE_DATE, ABS(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)) �ٹ����
FROM EMPLOYEE;




----------�ǽ�����------------
--1.EMPLOYEE���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
-- ��, ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ϰ� ��� ����ó��(����)�� ����� ó��
--2.EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
--3.EMPLOYEE���̺��� �ٹ������ 20�� �̻��� ���� ��ü ���� ��ȸ
--4.EMPLOYEE���̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ


--1.EMPLOYEE���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
-- ��, ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ϰ� ��� ����ó��(����)�� ����� ó��
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE - SYSDATE)) �ٹ��ϼ�1, 
                FLOOR(ABS(SYSDATE - HIRE_DATE)) �ٹ��ϼ�2
FROM EMPLOYEE;
-- ������ �ƴ϶� �����̶� FLOOR. TRUNC�� �����̰� FLOOR�� ������ ����


--2.EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE (MOD(EMP_ID, 2)) = 1;
SELECT *
FROM EMPLOYEE
WHERE (MOD(EMP_ID, 2)) != 0;
-- ����Ŭ������ % ������ ������ ����X


--3.EMPLOYEE���̺��� �ٹ������ 20�� �̻��� ���� ��ü ���� ��ȸ
SELECT * FROM EMPLOYEE -- ���1
WHERE (CEIL(ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)))/12) >= 20; -- 20������ CEIL ����
SELECT * FROM EMPLOYEE -- ���2
WHERE (ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))/12) >= 20; -- ��20�� �ٹ�
SELECT * FROM EMPLOYEE -- ���3
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
SELECT * FROM EMPLOYEE -- ���4
WHERE (SYSDATE - HIRE_DATE) >= 365*20;
 -- WHERE (SYSDATE - HIRE_DATE) / 365>=20;
 -- WHERE ABS(HIRE_DATE - SYSDATE) >= 7300;
SELECT * FROM EMPLOYEE -- ���5
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;

 
--4.EMPLOYEE���̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
-- ���1
-- LAST_DAY
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, (LAST_DAY(HIRE_DATE))-HIRE_DATE "�Ի��� �� �ٹ��ϼ�"
FROM EMPLOYEE;

-- ���2
-- EXTRACT + LAST_DAY
SELECT EMP_NAME �����, HIRE_DATE �Ի���, 
    EXTRACT(DAY FROM LAST_DAY(HIRE_DATE))- EXTRACT(DAY FROM HIRE_DATE) "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- 4)����ȯ �Լ�
-- A) TO_CHAR
-- B) TO_DATE
-- C) TO_NUMBER

-- A) TO_CHAR : ��¥/������ �����͸� ������ �����ͷ� ����
-- B) TO_DATE : ����/������ �����͸� ��¥�� �����ͷ� ��ȯ
-- C) TO_NUMBER : ������ �����͸� ������ �����ͷ� ��ȯ


-- A) TO_CHAR 
-- ��¥/������ �����͸� ������ �����ͷ� ����
-- �ڸ����� ���� ���ڷ� ����ȯ
-- TO_CHAR(����ȯ�� ��¥or����OR�÷���, ��ü�ڸ��� 0 OR 9)
--      ���а����� 0�� 0���� 9�� ��������
-- ���� ������ ���ʿ� ǥ��
SELECT 1234 LITERAL_NUMBER FROM DUAL; -- 1234
SELECT TO_CHAR(1234) FROM DUAL; -- 1234
SELECT TO_CHAR('1234') FROM DUAL; -- ����to���� ����ȯ ����
SELECT 1234 LITERAL_NUMBER , TO_CHAR(1234) FROM DUAL; -- 1234	1234
-- ���ڷ� �����Ǿ����� ������ ����, ���ڷ� �����Ǿ������� ���� ����
-- ���ڰ� ��� �� �ִ��Ŀ� ���� �������� �������� ���� ����

SELECT 1234+4321, TO_CHAR(1234)+TO_CHAR(4321) FROM DUAL; -- 5555	5555 
-- �����ε� ������ ������ ���� : ���ڷ� ����ȯ�� ���� ���� ���ڴ� ����Ŭ���� �ڵ����� ��������
-- ���� ���� ���� // �ڹٿ��� �Ұ���

SELECT TO_CHAR(1234, '99999') FROM DUAL;   --  (����)1234
SELECT TO_CHAR(1234, '99999') A FROM DUAL; --  (����)1234
-- '99999'�� �ǹ̴� 5ĭ�� ����ڴ�. ���⿡ 1234�� �ְ� �� ������ �������� �ϰڴٴ� �ǹ�
-- ' ' �ȿ��� 9�� 0�� ����. �ٸ� ���ڴ� ����
SELECT TO_CHAR(1234, '99') A FROM DUAL;    -- ###
SELECT TO_CHAR(1234, '88') A FROM DUAL;    -- ERROR
SELECT TO_CHAR(1234,'00000') A FROM DUAL;  -- 01234
-- ����ִ� ���� 0���� ä����

SELECT TO_CHAR(1234,'L99999') FROM DUAL;     --         ��1234
-- L�� ���ΰ� ���� ������ ������ ��ȭǥ�ø� ���� ��
SELECT TO_CHAR(1234,'FML99999') FROM DUAL;   -- ��1234
-- FM�� �߰��� ������ ���� ���ִ� ��
SELECT TO_CHAR(1234,'$99999') FROM DUAL;     --   $1234
-- �޷��� ��� ������ L��� $��ȣ
SELECT TO_CHAR(1234,'FM$99999') FROM DUAL;   --$1234
SELECT TO_CHAR(1234,'99,999') FROM DUAL;     --  1,234
SELECT TO_CHAR(1234,'FM99,999') FROM DUAL;   -- 1,234
SELECT TO_CHAR(1234,'00,000') FROM DUAL;     --  01,234
SELECT TO_CHAR(1234,'FM00,000') FROM DUAL;   -- 01,234
SELECT TO_CHAR(1234,'999') FROM DUAL; -- ####
-- �ڸ����� �����ؼ� # ���

-- 1234���� �� ���� �ڸ����� ������ ����?
-- ##�� �̿��ϸ� ��




-- EMPLOYEE���̺��� �����, �޿�(\(��ȭǥ��)9,000,000 ����) ��ȸ
SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
--SELECT EMP_NAME, TO_CHAR(SALARY, 'FML999,999,999')
FROM EMPLOYEE;


-- �ð�
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL; -- 03:40:27
SELECT TO_CHAR(SYSDATE, 'AM:HH:MI:SS') FROM DUAL; -- ����:03:41:01
SELECT TO_CHAR(SYSDATE, 'PM:HH:MI:SS') FROM DUAL; -- ����:03:41:43
SELECT TO_CHAR(SYSDATE, 'AM:HH24:MI:SS') FROM DUAL; -- ����:15:42:38
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;    -- 15:43:02
-- ��¥
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL;      --22-03-20
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD DAY') FROM DUAL;  -- 22-03-20 �Ͽ���
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD DAY HH:MI:SS') FROM DUAL; -- 22-03-20 �Ͽ��� 03:46:52
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY HH:MI:SS') FROM DUAL; -- 2022-03-20 �Ͽ��� 03:48:07
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY HH:MI:SS') FROM DUAL; --2022-3-20 �Ͽ��� 3:48:47 ��������
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY AM HH:MI:SS') FROM DUAL; -- 2022-3-20 �Ͽ��� ���� 3:50:0
-- �ٸ����
SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL;  -- 2022
SELECT TO_CHAR(SYSDATE, 'YY') FROM DUAL;    -- 22
SELECT TO_CHAR(SYSDATE, 'MM') FROM DUAL;    -- 03
SELECT TO_CHAR(SYSDATE, 'MONTH') FROM DUAL; -- 3��
SELECT TO_CHAR(SYSDATE, 'MON') FROM DUAL;   -- 3��
SELECT TO_CHAR(SYSDATE, 'RM') FROM DUAL;    -- III 
SELECT TO_CHAR(SYSDATE, 'YY-MONTH-RM') FROM DUAL; -- 22-3�� -III 
SELECT TO_CHAR(SYSDATE, 'YY MONTH RM') FROM DUAL; -- 22 3��  III 
SELECT TO_CHAR(SYSDATE, 'Q'),   -- Q : �б⸦ ��Ÿ��. 1-4�б�
       TO_CHAR(SYSDATE, 'DAY'), -- DAY : ����
       TO_CHAR(SYSDATE, 'DY')   -- DY : ����
FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'Q DAY DDD') FROM DUAL; -- 1 �Ͽ��� 079


SELECT TO_CHAR(SYSDATE) FROM DUAL;                  -- 22/03/15
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;      -- 08:07:45
SELECT TO_CHAR(SYSDATE, 'AM:HH:MI:SS') FROM DUAL;   -- ����:08:08:07
SELECT TO_CHAR(SYSDATE, 'PM:HH:MI:SS') FROM DUAL;   -- ����:08:08:07 // AM PM �ƹ��ų� �����  
SELECT TO_CHAR(SYSDATE, 'AM:HH24:MI:SS') FROM DUAL; -- ����:20:10:01
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY AM HH:MI:SS') FROM DUAL;  --2022-03-15 ȭ���� ���� 08:10:50
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY AM HH:MI:SS') FROM DUAL;--2022-3-15 ȭ���� ���� 8:10:59
-- FM�� �����Ű�� �ڿ����� ����Ǽ� �������� �Ǽ� ���´�
-- 01�ʰ� ���;��ϴµ� 1�ʰ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY"��"-MM"��"-DD"��" DAY AM HH:MI:SS') FROM DUAL; -- 2022��-03��-15�� ȭ���� ���� 11:40:48
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" DAY AM HH:MI:SS') FROM DUAL; -- 2022�� 03�� 15�� ȭ���� ���� 08:15:13
-- ���� ���
-- ����ó�� ����ִ� �ڸ��� �����ִ� ����

-- ���̴°� �ٸ� 3����
SELECT TO_CHAR(SYSDATE,'YYYY') FROM DUAL; -- 2022
SELECT TO_CHAR(SYSDATE,'YY') FROM DUAL; -- 22
SELECT TO_CHAR(SYSDATE,'YEAR')FROM DUAL; -- TWENTY TWENTY-TWO

SELECT TO_CHAR(SYSDATE,'MM')FROM DUAL; -- 03
SELECT TO_CHAR(SYSDATE,'MONTH')FROM DUAL; -- 3�� 
SELECT TO_CHAR(SYSDATE,'MON')FROM DUAL; -- 3�� 
SELECT TO_CHAR(SYSDATE,'RM')FROM DUAL; -- III 
SELECT TO_CHAR(SYSDATE,'MM'), TO_CHAR(SYSDATE,'MONTH'),
        TO_CHAR(SYSDATE,'MON'), TO_CHAR(SYSDATE,'RM')
FROM DUAL;  -- 03	3�� 	3�� 	III 


SELECT TO_CHAR(SYSDATE, 'DDD'), -- �� �ظ� �������� ������ �����ִ°�
       TO_CHAR(SYSDATE, 'DD'),  -- �� ���� �������� ������ �����ִ°�
       TO_CHAR(SYSDATE, 'D')    -- �� �ָ� �������� ������ �����ִ°�(�Ͽ��� ����)
FROM DUAL; -- 079	20	1
SELECT TO_CHAR(SYSDATE,'Q'), TO_CHAR(SYSDATE,'DAY'), TO_CHAR(SYSDATE,'DY')
FROM DUAL;
-- Q : �б⸦ ��Ÿ��. 1-4�б�
-- DAY : ����
-- DY : ����



--EMPLOYEE���̺��� �̸�, �Ի���(2022�� 03�� 15�� (ȭ) ����) ��ȸ
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��", (DY)')
FROM EMPLOYEE;


/*
���ڸ� ���ڷ�
��¥�� ���ڷ�

��¥������ ���ڷ� ��ȯ�غ���
*/


------------------------------------------------------------------------------
------------------------------------------------------------------------------




-- B) TO_DATE
-- ����/������ �����͸� ��¥�� �����ͷ� ��ȯ
--
-- Y : ���ڸ� ������ ������ ���� ����(21���� , 20XX) ����
-- R : ���ڸ� ������ 50�̻��� ��, ���� ����(20����,19XX) ����
--     ���ڸ� ������ 50�̸��� ��, ���� ����(21����, 20XX) ����


SELECT TO_DATE('20220315','YYYYMMDD') FROM DUAL; -- 22/03/15
SELECT TO_DATE(20220315,'YYYYMMDD') FROM DUAL; -- 22/03/15
SELECT TO_DATE('20220315','YYYYMMDD') FROM DUAL; -- 22/03/15

-- �Է� ���� ���ڿ� : 20220713�� 2022�� 07�� 13�� �������� ����ϰ� �ʹٸ�?
-- 20220713  -> 2022�� 07�� 13��
-- ���ڿ� �޴°Ŵ� TO_CHAR�Ἥ �ϸ� ������ ������? �ؼ� �Ẹ�� ����
-- TO_CHAR�� ��¥/������ �����͸� ������ �����ͷ� �����ϴ� �Լ�
-- �Ʒ����� TO_CHAR()�� ù �Ű������� ���ڰ� ' '�� ������ ���ڶ� �������� ��
-- ����+���� ���ϱ� �����Ѱ�? EX)TO_CHAR(1234) + TO_CHAR(4321)
-- ���ڰ� ���ڷ� �ٲ�� ���ڶ�� �������� ����ó�� �����ϵ��� ����Ŭ�� �Ǿ��ֱ⿡ �����ߴ� ��
-- �ڹٴ� '1234'+'4321'�̸� '12344321'�̰����� ����Ŭ�� ���������� ���ڸ� �ڵ�����ȯ�ؼ� �������ش�

SELECT TO_CHAR('20220315','YYYY"��" MM"��" DD"��"') --  ERROR : invalid number format model
FROM DUAL;
-- TO_CHAR()�� ������ '20220315'�� ���� �ٲ����
-- TO_DATE()�� ��¥ �����͸� ���� : SELECT T0_DATE('20220315','YYYYMMDD')
SELECT TO_CHAR('20220315','YYYY"��" MM"��" DD"��"') --  ERROR : invalid number format model
FROM DUAL;
SELECT TO_CHAR(T0_DATE('20220315','YYYYMMDD'), 'YYYY"��" MM"��" DD"��"') -- ERROR
FROM DUAL; -- ����. ������� ��


SELECT TO_CHAR(TO_DATE('220713 175019','YYMMDD HH24MISS'), 'YY-MM-DD AM HH:MI:SS DY')
FROM DUAL; -- 22-07-13 ���� 05:50:19 ��
-- ����Ʈ�� �ð����� �������� �ʴ´�. Ÿ�ӽ����� �����


-- TO_DATE()������ ���� ǥ�� : YY, RR
-- ����ǥ�ø� YY���� RR�� ����. ���̴�?
SELECT TO_DATE('980630', 'YYMMDD'),  -- 98/06/30
        TO_DATE('980630', 'RRMMDD'), -- 98/06/30
        TO_DATE('140918', 'YYMMDD'), -- 14/09/18
        TO_DATE('140918', 'RRMMDD')  -- 14/09/18
FROM DUAL; -- 98/06/30	98/06/30	14/09/18	14/09/18
-- TO_DATE() ��¿����� ���̰� ����δ�. TO_CHAR()+TO_DATE()������?
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'),'YYYYMMDD'),  -- 20980630
        TO_CHAR(TO_DATE('980630', 'RRMMDD'),'YYYYMMDD'), -- 19980630
        TO_CHAR(TO_DATE('140918', 'YYMMDD'),'YYYYMMDD'), -- 20140918
        TO_CHAR(TO_DATE('140918', 'RRMMDD'),'YYYYMMDD')  -- 20140918
FROM DUAL; -- 20980630	19980630	20140918	20140918
-- �տ��ִ� õ���ڸ��� �����ڸ��� �����Ǿ��־ �׵��� ������ ��.
-- TO_CHAR()�� õ���ڸ����� ������� ��
-- Y : ���ڸ� ������ ������ ���� ����(21���� , 20XX) ����
-- R : ���ڸ� ������ 50�̻��� ��, ���� ����(20����,19XX) ����
--     ���ڸ� ������ 50�̸��� ��, ���� ����(21����, 20XX) ����


------ ���� ------

-- ���� -> ��¥
SELECT TO_DATE('20220320','YYYYMMDD') FROM DUAL; -- 22/03/20 
-- ���� -> ��¥
SELECT TO_DATE(20220320, 'YYYYMMDD') FROM DUAL;  -- 22/03/20

-- ����Ʈ�� �ð����� �������� �ʴ´�. Ÿ�ӽ����� �����
-- TO_DATE + TO_CHAR
-- ��,��,��,�ð� ���� �͵��� ���Ϸ��� TO_CHAR�� ���Ѵ�
SELECT TO_CHAR(TO_DATE(20220320,'YYYYMMDD'), 'YYYY"��" MM"��" DD"��"')
FROM DUAL; -- 2022�� 03�� 20��
SELECT TO_DATE('220713 215005','YYMMDD HH24MISS')
FROM DUAL; -- 22/07/13 // �ð� ��� X
SELECT TO_CHAR(TO_DATE('220713 215005','YYMMDD HH24MISS'), 'YY/MM/DD AM HH:MI:SS DY')
FROM DUAL; -- 22/07/13 ���� 09:50:05 ��
SELECT TO_CHAR(TO_DATE('220713 175019','YYMMDD HH24MISS'), 'YY-MM-DD AM FMHH:MI:SS DY')
FROM DUAL; -- 22-07-13 ���� 5:50:19 ��


-- Y�� R�� ����
-- TO_DATE()�θ����δ� ���̰� ����δ�. TO_DATE()+TO_CHAR()��?
SELECT TO_DATE('000320','YYMMDD'), -- 00/03/20
       TO_DATE('000320','RRMMDD'), -- 00/03/20
       TO_DATE('450625','YYMMDD'), -- 45/06/25
       TO_DATE('450625','RRMMDD')  -- 45/06/25
FROM DUAL;
SELECT TO_CHAR(TO_DATE('900320','YYMMDD'),'YYYY/MM/DD'), -- 2090/03/20
       TO_CHAR(TO_DATE('900320','RRMMDD'),'YYYY/MM/DD'), -- 1990/03/20
       TO_CHAR(TO_DATE('450625','YYMMDD'),'YYYY/MM/DD'), -- 2045/06/25
       TO_CHAR(TO_DATE('450625','RRMMDD'),'YYYY/MM/DD')  -- 2045/06/25
FROM DUAL;



------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- C) TO_NUMBER
-- ������ �����͸� ������ �����ͷ� ��ȯ
-- TO_NUMBER(��ȯ�� �÷�or����,'���� ���������� �νĽ�Ű�±���')
-- TO_NUMBER('10,000','999,999')

SELECT '1234' CHAR_NUMBER, TO_NUMBER('1234') FROM DUAL;
-- ���ڴ� ��������, ���ڴ� ������ ����

-- CHAR + CHAR ���� ���� �����ѵ� �� ���� NUMBER�����ؾ��ұ�?
-- TO_NUMBER()�� �ʿ伺
SELECT '1234'+'4321' FROM DUAL; -- 5555
SELECT '10,000' + '5,000' FROM DUAL; -- ERROR : invalid number
 -- ��ǥ ������ ����. ����� �ν��ϱ⿡ ,�� ���� �ڸ��� ����������
 --  ��ǻ�����״� ��ǥ�� �پ� ���ڷ� �ν��� �� ���� �� ��
SELECT TO_NUMBER('10,000') FROM DUAL; -- ERROR : invalid number
SELECT TO_NUMBER('10,000','999,999') FROM DUAL; -- 10000
-- �ι�° ���� : ���� ���� ���� Ÿ���� �̷� �����̶�� ���� �νĽ�Ű�� ����
SELECT TO_NUMBER('10,000','999,999'), TO_NUMBER('5,000','999,999') FROM DUAL;--10000	5000
SELECT TO_NUMBER('10,000','999,999') + TO_NUMBER('5,000','999,999') FROM DUAL;--15000

-- 2������ ����
SELECT TO_NUMBER('5000','999,999') + TO_NUMBER('5000','999,999')
FROM DUAL; -- ORA-01722: invalid number
           -- �������� : ��°�ڸ��� ,�ޱ�� �ߴµ� ,�� ��� ����
SELECT TO_NUMBER('5,000','999,999') + TO_NUMBER('5,000','999,999')
FROM DUAL; -- 10000







------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 5)NULLó�� �Լ�


-- NVL
-- null���� ������ ������ ��ü�ϴ� �Լ�
--
-- �������� �ٲٴ°� X
-- ��ü�� ���� ��ü�ҷ��� �������� Ÿ���� ���󰡾��Ѵ� 
--      ex)bonus�� ������Ÿ���� number�̹Ƿ� ���ڸ�����

-- NULL�� �ٸ� ������ ������Ű�� ���ϳ�?�κ��� ������ ��
SELECT EMP_NAME, BONUS, NVL(BONUS, 0) 
FROM EMPLOYEE;

SELECT NVL(BONUS, '���ʽ�X') -- ERROR : : invalid number
FROM EMPLOYEE; -- ex)bonus�� ������Ÿ���� number�̹Ƿ� ���ڸ�����
SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE, '�μ��� �����ϴ�') FROM EMPLOYEE;


-- NVL2
-- NVL2(�÷���, NULL�̸� �̰ɷ� ����, NULL�� �ƴϸ� �̰ɷ� ����)
-- NULL���� �����Ѵٸ� �ι�° ���ڰ����� ����, NULL���� �������� ������ ����° ���ڰ����� ����
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.5) FROM EMPLOYEE;
-- �ش絥���Ͱ� NULL�̸� 0.7�� �ƴϸ� 0.5�� ��ü
SELECT NVL2(BONUS, 0, 100) FROM EMPLOYEE;
SELECT NVL2(BONUS, 50, 100,) FROM EMPLOYEE;


-- NULLIF
-- ���ϴ� ���� ������ NULL, �ٸ��� �տ� �ִ� �� ��ȯ
SELECT NULLIF(123,123), NULLIF(123,132) FROM DUAL; -- (NULL)	123

SELECT NULLIF(123,123) FROM DUAL; -- �� �񱳰��� ���� NULL��ȯ
-- ������(�÷���) ����
SELECT EMP_NAME, NULLIF(EMPLOYEE.JOB_CODE, JOB.JOB_CODE) FROM EMPLOYEE, JOB;






------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 6.�����Լ�

-- DECODE
-- DECODE(����|�÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2, ...)
-- ���Ŀ� ���� ���ǰ�1�� ������ ���ð�1 ��ȯ, ���ǰ�2�� ������ ���ð�2�� ��ȯ�ϴ� �Լ�
-- ������ �ٷ�� >,< ���� �͵��� DECODE�� �� �� ����
-- JAVA SWITCH ����ġ�� ���� ���� �������� �͸� ����

-- �ֹι�ȣ ���� ���� ���� �������� �غ� ��
SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, EMP_NO, 
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2,  '��') "����"
        -- ����:SUBSTR // �÷���:EMP_NO // ���ǰ�:1 // ���ð� :��
        -- 1�̸� ���� 2�� ����
FROM EMPLOYEE;

-- ������ 1�̳� 2 �� �� �ϳ�
-- 1,2�� �ƴϸ� �������� ����Ʈ
-- 1,2���� 2�� ������ �Ȱ��� ���´�. elseó�� 1�ܿ� �������� '��'�� ó��
SELECT EMP_ID, EMP_NAME, EMP_NO, 
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��') "����"
        -- ����:SUBSTR // �÷���:EMP_NO // ���ǰ�:1 // ���ð� :��
        -- 1�̸� ���� 2�� ����
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO, 
    DECODE(SUBSTR(EMP_NO,8,1),1,'��','��') "����"
FROM EMPLOYEE;    


-- ������ �޿��� �λ��ϰ��� �Ѵ�
-- �����ڵ尡 J7�� ������ �޿��� 10%�� �λ��ϰ�
-- �����ڵ尡 J6�� ������ �޿��� 15%�� �λ��ϰ�
-- �����ڵ尡 J5�� ������ �޿��� 20%�� �λ��ϸ�
-- �� �� ������ ������ �޿��� 5%�� �λ��Ѵ�
-- ���� ���̺��� ������, �����ڵ�, �޿�, �λ�޿�(�� ����)�� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY, 
        DECODE(JOB_CODE, 'J7', SALARY*1.1, 
                         'J6', SALARY*1.15,     
                         'J5', SALARY*1.2, 
                               SALARY*1.05) "�λ�޿�"
    --  DECODE(JOB_CODE, 'J7', SALARY+(SALARY*0.1), 'J6', SALARY+(SALARY*0.15), 'J5', SALARY+(SALARY*0.2), SALARY+(SALARY*0.05) "�λ�޿�"
FROM EMPLOYEE;




-- CASE ~ WHEN ~ THEN
-- CASE WHEN ���ǽ�THEN �����
--      WHEN ���ǽ�THEN �����
--      ELSE �����
-- END

-- DECODE������ () ���Ŀ� ,������ CASE�� ���Ǹ��� ,�Ⱥ���

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE WHEN SUBSTR(EMP_NO, 8,1) = 1 THEN '��' -- ������ ���� �޶� ��ȯ���ְ� �������־�� ������ 
             WHEN SUBSTR(EMP_NO, 8,1) = 2 THEN '��' -- ���Կ�����(=)�� �˾Ƽ� �����ش�
        END ���� -- ���� : ��Ī                      -- CASE �÷��� WHEN ���ǽ� THEN ����������� �÷���� WHEN���ǽ��� �Ÿ��� �־ �ڵ����� �ȵǴ� ����
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE WHEN SUBSTR(EMP_NO, 8,1) = 1 THEN '��'
--             WHEN SUBSTR(EMP_NO, 8,1) = 2 THEN '��'
        ELSE '��'
        END  ���� -- ���� : ��Ī
FROM EMPLOYEE;        

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE SUBSTR(EMP_NO, 8,1) WHEN 1 THEN '��' -- ERROR : inconsistent datatypes: expected CHAR got NUMBER
                                     ELSE '��'    -- SUBSTR � ���ڿ� ���� �κ������� ���ڸ� ��ȯ�ϴ� �Լ�. 
        END ���� -- ���� : ��Ī                     -- SUBSTR�� ��ȯŸ���� �����ε� WHEN���� ���� NUMBER�� �޾Ƽ� ������ ��
FROM EMPLOYEE;                                    

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE SUBSTR(EMP_NO, 8,1)WHEN '1' THEN '��' -- WHEN�� 1�� '1' ���ڷ� ����
                                     ELSE '��'     -- SUBSTR � ���ڿ� ���� �κ������� ���ڸ� ��ȯ�ϴ� �Լ�. 
        END ���� -- ���� : ��Ī                     -- SUBSTR�� ��ȯŸ���� �����ε� WHEN���� ���� NUMBER�� �޾Ƽ� ������ ��
FROM EMPLOYEE;




-- ������ �޿��� �λ��ϰ��� �Ѵ�
-- �����ڵ尡 J7�� ������ �޿��� 10%�� �λ��ϰ�
-- �����ڵ尡 J6�� ������ �޿��� 15%�� �λ��ϰ�
-- �����ڵ尡 J5�� ������ �޿��� 20%�� �λ��ϸ�
-- �� �� ������ ������ �޿��� 5%�� �λ��Ѵ�
-- ���� ���̺��� ������, �����ڵ�, �޿�, �λ�޿�(�� ����)�� ��ȸ

SELECT EMP_NAME, JOB_CODE, SALARY,
    CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
         WHEN JOB_CODE = 'J6' THEN SALARY*1.15
         WHEN JOB_CODE = 'J5' THEN SALARY*1.2
         ELSE SALARY*0.05
         END �λ�޿�
FROM EMPLOYEE;
-- ���� ���� �ڵ�
-- CASE ������÷��� WHEN ���ǽ� THEN ���
SELECT EMP_NAME, JOB_CODE, SALARY,
    CASE JOB_CODE WHEN 'J7' THEN SALARY*1.1
                  WHEN 'J6' THEN SALARY*1.15
                  WHEN 'J5' THEN SALARY*1.2
                  ELSE SALARY*0.05
    END �λ�޿�
FROM EMPLOYEE;


-- ���, �����, �޿�, �����ȸ
-- ��� ���� : �޿��� 500������ ũ�� 1���, 350������ ũ�� 2���, 200������ ũ�� 3���, �������� 4���
-- DECODE�ε� ����?
-- ������ �ٷ�� >,< ���� �͵��� DECODE�� �� �� ����
-- JAVA SWITCH ����ġ�� ���� ���� �������� �͸� ����
SELECT EMP_ID, EMP_NAME, SALARY,
    CASE WHEN SALARY > 5000000 THEN '1���'
         WHEN SALARY > 3500000 THEN '2���'
         WHEN SALARY > 2000000 THEN '3���'
         ELSE '4���'
    END "���"
FROM EMPLOYEE;




------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
---------------------------------- �׷� �Լ� ----------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- �׷� �Լ�


-- SUM
-- ���հ�
-- EMPLOYEE���̺��� �� ����� �޿� ����
SELECT SUM(SALARY)
FROM EMPLOYEE; -- 70096240 // ����� �ϳ�


-- EMPLOYEE���̺��� ���ڻ���� �޿� ����
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1; -- 49760000


-- AVG
-- ���
-- EMPLOYEE���̺��� �� ����� �޿� ���
SELECT AVG(SALARY)
FROM EMPLOYEE; -- 3047662.60869565217391304347826086956522
-- EMPLOYEE���̺��� ���ڻ���� �޿� ����
SELECT AVG(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 2; -- 2542030
-- EMPLOYEE���̺��� �� ����� ���ʽ� ���
-- BONUS�� NULL�� ����� 0���� ó��
SELECT AVG(NVL(BONUS, 0)) 
FROM EMPLOYEE; -- 0.0847826086956521739130434782608695652174
-- SUM(BONUS)/23

SELECT AVG(BONUS)
FROM EMPLOYEE; -- 0.2166666666666666666666666666666666666667
-- NULL�� ���� ���� ��� ��꿡�� ���ܵǾ� ���
-- SUM(BONUS)/9



-- MIN / MAX
-- �ּ� / �ִ�
-- ����, ��¥, ���ڵ� ����
-- EMPLOYEE���̺��� �ּ� �޿��� �ִ� �޿�
SELECT MIN(SALARY), MAX(SALARY) -- 1380000	8000000
FROM EMPLOYEE;

SELECT MIN(SALARY), MAX(SALARY)
FROM EMPLOYEE;
-- ���� ������ �����ʾƼ�. EMP_NAME�� ��û ���������´�.
-- �׷��Լ��� N���� �����͸� �޾� 1���� �����͸� ��ȯ

-- ����
SELECT MIN(EMP_NAME), MAX(EMP_NAME) -- ���ؼ�	������
FROM EMPLOYEE;
-- ��¥
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE) -- 90/02/06	17/06/19
FROM EMPLOYEE;


-- COUNT
-- NULL���� �����ϰ� ī��Ʈ
SELECT COUNT(*) FROM EMPLOYEE; -- 23
-- ���� 23�� ī��Ʈ��
SELECT COUNT(DEPT_CODE) FROM EMPLOYEE; -- 21
-- NULL 2���� ������ 21 ��ȯ




------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------














