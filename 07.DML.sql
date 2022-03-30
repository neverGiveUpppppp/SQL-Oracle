

/*
DDL(Date Definition language) : ������ ���Ǿ�  - CREATE, ALTER, DROP

DML (Data Manipulation Language) :  ������ ���۾� - INSERT, UPDATE,DELETE,SELECT(DQL)

TCL(Transaction Ccontrol Language) : Ʈ����� ���� - COMMIT, ROLLBACK





INSERT(������ ����), UPDATE(������ ����),DELETE(������ ����),SELECT(DQL)


------------------------------------------------------------------------------
---------------------------------INSERT--------------------------------------
------------------------------------------------------------------------------

-- INSERT
������ ���� = �� �߰� �� ���̺� �� ���� ����

���� �μ�Ʈ �ڿ� ()�� ������ . �÷� ����

*/

-- INSERT : �÷��� ��� ����
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,
            SAL_LEVEL, SALARY, BONUS, MANAGER_ID,HIRE_DATE, ENT_YN, ENT_DATE)
VALUES(900,'���ǰ�','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,'N',NULL);                      
            
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- INSERT ��, �÷��� �������� ����           
-- ���̺��� ��� �÷��� ���� ���� ���� �÷��� ��ø� ���� ����            
-- INSERT ��, �÷����� �����Ϸ��� ���̺� �ִ� �÷� ������ ��Ȯ�� ���Ѽ� �־�� ��
INSERT INTO EMPLOYEE -- �÷��� ��úκ� ����
VALUES(900,'���ǰ�','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,'N',NULL);            
-- ORA-01841: (full) year must be between -4713 and +9999, and not be 0
-- ���� : ENT_YN,ENT_DATE�� ������ �ٲ㼭 �����߻�
-- �÷����� ����ϴ� ��쿡�� ����� ������ ���� �����͸� ������ �ǰ�, 
-- ���� �ÿ��� ���̺� �ִ� �÷��� ������ ����� �Ѵ�        
        
        
INSERT INTO EMPLOYEE -- �÷��� ��úκ� ����
VALUES(900,'���ǰ�','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,NULL,'N');          
        
SELECT * FROM EMPLOYEE;
COMMIT;
     
DROP TABLE EMP_01;

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

-- ���̺��� �÷� ���ΰ� �ƴ� ���ϴ� �����͸� ���԰���
INSERT INTO EMP_01(EMP_ID) VALUES(998);
INSERT INTO EMP_01(EMP_ID,EMP_NAME) VALUES(999,'������'); 

SELECT * FROM EMP_01;
-- ������ ��ȸ ��� : 999	������ (NULL) <- DEPT_TITLE�� �μ��� �ȳ־�ּ� NULL


-- ���������� ������ INSERT�ϱ�
INSERT INTO EMP_01(
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE
            LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);
-- INSERT �ι���Ű�� �ߺ������� �ι� ��
SELECT * FROM EMP_01; -- 25��


------------------------------------------------------------------------------
--����:5.1. SQL Ȱ�� (��ü����)


-- INSERT ALL
-- INSERT �� ���������� ����ϴ� ���̺��� ���� ��� �� ���� ���� ����
-- ���� 2��

-- WHEN ���� ������ ������ �����ϴ� �����͸� ���̺��� ������ ����


-- �����ʹ� �ʿ� ���� ������ ���� ���� �� ���� �ڵ�        
-- �����ʹ� ���� �÷��鸸 ���� ������ ��
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID,EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0; 
-- WHERE�� : ������ �޴� ��. 1 = 0�̶�°� 1�� 0�� �ƴϱ⿡ ������� FALSE
-- ������� FALSE�̱⿡ ���õ� �÷��� �ְ� �����ʹ� ���� ������ ��
-- ��, WHERE���� 1=0 ������ �����ϴ� ���� �����Ƿ�, ����ִ� ���̺��� �����ȴ�
-- �� �ڵ带 ���� ���� : �����ʹ� �ʿ� ���� ������ ���� ���� ��

SELECT * FROM EMP_DEPT_D1;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0; -- ������ ����

SELECT * FROM EMP_MANAGER;



-- EMP_DEPT_D1 ���̺� EMPLOYEE ���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ��
-- ���, �̸�, �ҼӺμ�, �Ի��� ����
-- EMP_MANAGER���̺� EMPLOYEE ���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ��
-- ���, �̸�, ������ ��� ����

INSERT INTO EMP_DEPT_D1(
            SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
            FROM EMPLOYEE
            WHERE DEPT_CODE = 'D1');
INSERT INTO EMP_MANAGER(
            SELECT EMP_ID, EMP_NAME,MANAGER_ID
            FROM EMPLOYEE
            WHERE DEPT_CODE = 'D1');

SELECT * FROM EMP_DEPT_D1;
SELECT * FROM EMP_MANAGER;
-- ���� INSERT�� �����͸� ���� ���� ��
ROLLBACK;

-- INSERT ALL�� �ѹ��� 
INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID -- ��������
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
-- INSERT ALL + SUBQUERY�� �� ������ �� ���̺��� �ѹ��� �߰�    
-- INSERT ALL �� ���̺� ���ǿ� �°� INSERT


-- ���������� INSERT ��, ���� AS���� ���� �Ұ�ȣ()����? =========================
-- CREATE(DDL)���� AS // INSERT(DML)���� ()?
-- INSERT INTO ���̺��(�� ��������ó)
INSERT INTO EMP_DEPT_D1 -- ���� �� ��� : EMP_DEPT_D1 ���̺�
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE -- ������ ������ : ID,NAME,DEPT_CODE, HIREDATE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
-- SQL ����: ORA-00926: missing VALUES keyword
-- FROM EMPLOYEE�� �ִ� �����͸�  EMP_DEPT_D1���̺� �����ϴµ�
-- INSERT INTO ���Դ��� ���̺��(����� ������)
-- ��, ����ε� �����Ͱ��� ���� �ʾ� ������ ��. 
-- �Ʒ��� ����
INSERT INTO EMP_DEPT_D1( -- ���� �� ��� : EMP_DEPT_D1 ���̺�
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE -- ������ ������ : ID,NAME,DEPT_CODE, HIREDATE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1');   




-- EMPLOYEE���̺��� ������ �����Ͽ� ���, �̸�, �Ի���, �޿��� ����� �� �ִ�
-- ���̺� EMP_OLD�� EMP_NEW ����
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;


-- EMPLOYEE���̺��� �Ի��� �������� 2000�� 1�� 1�� ������ �Ի��� �����
-- ���, �̸�, �Ի���, �޿��� EMP_OLD���̺�,
-- 2000�� 1�� 1�� ���Ŀ� �Ի��� ����� ���, �̸�, �Ի���, �޿��� EMP_NEW���̺� ����
-- ���1 : ���� INSERT
-- ���2 : INSERT ALL

-- INSERT ALL ���1
INSERT ALL -- �� ���̺� ������ �޶� WHEN�� �ѹ��� ���� ���� ����
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

-- INSERT ALL ���2
INSERT ALL -- �� ���̺� ������ �޶� WHEN�� �ѹ��� ���� ���� ����
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
ELSE -- ������ ���� �ƴϸ� �����̱⿡ ELSEó�� ����
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
-- SELECT * -- VALUES���� �÷��� �����ϱ� ������ SELECT * ������ ����X
FROM EMPLOYEE;


COMMIT;


------------------------------------------------------------------------------
---------------------------------UPDATE--------------------------------------
------------------------------------------------------------------------------


-- UPDATE

-- ����
-- ������ �����̶� ��ü �࿡�� ��ȭX
-- UPDATE ���̺�� SET �÷��� [WHERE]

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;


--DEPT_COPY���̺��� DEPT_ID�� D9�� ���� DEPT_TITLE�� ������ȹ������ ����
UPDATE DEPT_COPY -- �� ��������?
SET DEPT_TITLE = '������ȹ��' -- ��� ��������?
WHERE DEPT_ID = 'D9';
-- D9�� �ѹ��ο��� ������ȹ������ �����

ROLLBACK;
COMMIT;
-- ������Ʈ���� �߿��� ��
-- ������Ʈ���� �����ϴ� �Ǽ� : WHERE�� ���Ա�
-- WHERE���� �� �߰��ؼ� ���ϴ� �κи� ������ ��



CREATE TABLE EMP_SALARY
AS SELECT EMP_ID,EMP_NAME, SALARY, BONUS  -- SUBQUERY�� �̿��� ���̺� ����
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;

-- �� ������ ��
-- ���� ����� �޿��� ���ʽ��� ����� ����� �����ϰ� ����
SELECT * FROM EMP_SALARY -- �� ����� ���� ��ȸ�ؼ� �޿��� ���ʽ� üũ
WHERE EMP_NAME IN('����','�����'); -- 204	�����	3400000	0.2 // 214	����	1380000

-- ������Ʈ 2���� �ڵ� ���
-- ���1 - ���� ������Ʈ
-- ���2 - �ѹ��� ������Ʈ�ϴ� ���

UPDATE EMP_SALARY
-- ���1 : ���� ������Ʈ
SET SALARY = (SELECT SALARY
              FROM EMP_SALARY
              WHERE EMP_NAME = '�����'),
    BONUS = (SELECT BONUS
             FROM EMP_SALARY
             WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';
-- ���� ������Ʈ
SELECT * FROM EMP_SALARY -- �� ����� ���� ��ȸ�ؼ� �޿��� ���ʽ� üũ
WHERE EMP_NAME IN('����','�����'); -- 204	�����	3400000	0.2 // 214	�����	3400000	0.2
-- ����Ϸ� : �� ����� ������ �޿�,���ʽ�

-- ���2 : �ѹ��� ������Ʈ�ϴ� ���
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY,BONUS
                      FROM EMP_SALARY
                      WHERE EMP_NAME = '�����')
WHERE EMP_NAME IN('���ö','������','������','�ϵ���');
-- 4�� �����Ϸ�
SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN('����','�����','���ö','������','������','�ϵ���');
-- ���漺�� : ���� ���� �޿�,���ʽ�



--EMP_SALARY���̺��� �ƽþ� ������ �ٹ��ϴ� ������ ���ʽ��� 0.3���� ����
-- �ƽþ� �ٹ��ϴ� ���� ��ȸ
-- Ǯ� ��
--UPDATE EMP_SALARY
--SET BONUS = 0.3
--WHERE LOCAL_NAME = 'ASIA1' OR LOCAL_NAME = 'ASIA2' OR LOCAL_NAME = 'ASIA3';
---- �ƽþ� �ٹ��ϴ� ���� ��ȸ
--SELECT * FROM LOCATION, EMPLOYEE 
----WHERE LOCAL_NAME = 'ASIA1' OR LOCAL_NAME = 'ASIA2' OR LOCAL_NAME = 'ASIA3'; 
--WHERE LOCAL_NAME LIKE 'ASIA%';


-- ������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS, LOCAL_NAME
FROM EMP_SALARY
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID -- EMP_NAME�� ���������� ���������� ���� �� ������ ID�� Ȯ���� ����
                 FROM EMP_SALARY
                    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
                 WHERE LOCAL_NAME LIKE 'ASIA%';

COMMIT;

-- ������Ʈ �� ���ǻ���
-- NOT NULL �������ǿ� NULL ��������� �����߻��� ��
-- �̿� ���������� �߿��� ������ ��

-- EMPLOYEE���̺� DEPT_CODE�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� DEPARTMENT, ���� �÷��� DEPARTMENT�� �⺻Ű
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT; -- �÷��� ��������
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);

UPDATE EMPLOYEE
SET DEPT_CODE = '0'
WHERE DEPT_CODE ='D6';
-- ERROR : ORA-02291: integrity constraint (KH.SYS_C007066) violated - parent key not found
-- �θ����̺� ���� ���� �����ؼ� ���� - DEPARTMET�� ���� 0�ΰ� ���⿡ ����

COMMIT;
------------------------------------------------------------------------------
-----------------------------------DELETE------------------------------------
------------------------------------------------------------------------------

-- DELETE
-- �� ��ü ����
-- �� ���� ����


-- DELETE �������� ����
-- �⺻�����δ� �θ� ���� �ڽ� ���̺� ������ ���� �Ұ�

-- DELETE�� �����ѰŴ� �ѹ����� ���� ����
-- TRUNCATE�� �ѹ����� ���� �Ұ���

SELECT * FROM EMLOYEE;

DELETE FROM EMPLOYEE;
DELETE FROM EMPLOYEE WHERE EMP_NAME = '���ǰ�';

ROLLBACK;



DELETE FROM EMP_SALARY;
SELECT * FROM EMP_SALARY;
ROLLBACK;


COMMIT;
------------------------------------------------------------------------------

-- TRUNCATE
-- DELETE���� �ӵ��� ������, ��������
TRUNCATE TABLE EMP_SALARY; -- Table EMP_SALARY��(��) �߷Ƚ��ϴ�. // ROLLBACK���� ���� �Ұ�


-- ���� �ȵǴ� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- ORA-02292: integrity constraint (KH.SYS_C007066) violated - child record found
-- ���� :D1�� �����ϴ� �ڽ� �����Ͱ� �־

-- SYS_C007066 �� ���������� ��� ��Ȱ��ȭ ��ų ����
ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT SYS_C007066 CASCADE; -- �������� DISABLE�� ��Ȱ��ȭ ��Ŵ

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1'; -- 1�� �� ��(��) �����Ǿ����ϴ�.

ROLLBACK;

-- �������� Ȱ��ȭ
ALTER TABLE EMPLOYEE
ENABLE CONSTRAINT SYS_C007066;


------------------------------------------------------------------------------







------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



























