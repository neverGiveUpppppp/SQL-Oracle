------------------------------------------------------------------------------
----------------------------DB������ ��ü---------------------------------------
------------------------------------------------------------------------------

-- DB������ ��ü

-- DB���� ����ϴ� ��ü�� ���̺� ONLY?
-- ������ ����
-- ex)USER, VIEW, SEQUENCE, SYNONYM, INDEX


/*
0302-0303
INDEX
�˻��ϴ� �ӵ� ������ ���� ���� �����. �߿�
�ε����� ������ �ε����� ���� ������ ������ ������ �ʿ�����

������ �߰�,����(DML�۾�) ���� �Ͼ�� ������ ���� ���Ͻ�Ŵ

�ε����� �̹� ������� ����
�����ε��� : �����̸Ӹ�Ű,����ũ ����� �ڵ����� ������

�ε��� ���� ��� : KH�������� ���̺� �Ʒ� ī�װ� �ε���

5���� �����ͷ� �����µ��� �ӵ����̰� ũ�� ���̰� ������ ����

*/

------------------------------------------------------------------------------





------------------------------------------------------------------------------
-----------------------------------VIEW---------------------------------------
------------------------------------------------------------------------------
/*

-- VIEW
SELECT ���� ���� ��� ȭ���� ������ ��ü
    (=RESULT SET�� ������ ��ü)
�������� �����͸� �����ϰ� �ִ� ���� �ƴϳ� ���̺��� ����ϴ� �Ͱ� �����ϰ� ��� ����
    -> �̷� Ư�� ������ �並 '������ ���� ���̺�'�̶�� �θ�
�������� ���̺� �ٰ��� ������ ������ ���̺��, �����Ͱ� ���� ���̺� ���� SQL�� ����Ǿ�
�ִ�. ����ڰ� VIEW�� ������ ��� SQL�� ����Ǹ鼭 �� ����� �����´�


DB�� ���������� �����°ź��� ���α׷����� ���� ��κ� �� ��
�ٵ� ������ �ȴٸ� ���̺� ��ü�� �ٷ�⺸�� ��� �ٲ㼭 �޾Ƽ� ���ϰ� �� ����
���̺� ��ġ�ų� ���� ������ ���Կ��� ������...


�� ������ �κ�
�����̶� �ɼǸ� ����س����� �ȴ�


*/

SELECT * FROM USER_VIEWS; -- �信 ���� ���� ������ ��ųʸ�
-- ���� ���� �䰡 ��� ����� ��µ����� �ʴ´�


-- VIEW ����
-- CREATE
-- CREATE VIEW ���
-- Q.�並 �����ϱ� ���� �� CREATE��� ��ɾ ����ұ�?
-- A.VIEW�� ��ü�̱� ���� // ��ü ������ CREATE

-- ���, �̸�, �μ���, �ٹ������� ��ȸ ����� �� V_EMPLOYEE�� ����
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME -- SUBQUERY�� �̿��� ��ü����
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE);
-- ERROR : infficient privileges
-- ��� ���� ������ ���� �ʿ���. ���� ������ ���� �����̱⿡ �Ʒ��� ���� ���� �߻�
-- ������ �����ڰ���(SYSTEM)���� �� �� �ִ�. 
-- SYSTEM���� ���� ���� �� ���Ѻο� �ڵ� �Է�

-- ���Ѻο� �ڵ�
GRANT CREATE VIEW TO KH; -- Grant��(��) �����߽��ϴ�.



CREATE OR REPLACE VIEW V_EMPLOYEE -- OR REPLACE�� �ϴ� �� ���� ��, ���ٰ� ������ ��
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME -- SUBQUERY�� �̿��� ��ü����
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
        JOIN NATIONAL USING(NATIONAL_CODE);
        
SELECT * FROM USER_VIEWS; 

SELECT * FROM EMPLOYEE
WHERE EMP_ID = 205; -- ������ 


-- ��� 205���� ������ �̸��� ���߾����� ����
UPDATE EMPLOYEE
SET EMP_NAME = '���߾�'
WHERE EMP_ID = 205;

SELECT * FROM EMPLOYEE WHERE EMP_ID = 205;  -- ���߾�
SELECT * FROM V_EMPLOYEE WHERE EMP_ID = 205;  -- ���߾� // VIEW������ ����Ǽ� ��µ�
-- ���̽����̺��� EMPLOYEE���̺��� ������ ����Ǹ� VIEW���� �Ȱ��� �����
-- ��� SELECT ���� ���� ��� ȭ��(RESULT SET)�� ������ ��ü�̱� ����

ROLLBACK; -- �ٽ� �����Ϸ� �ѹ�
        

-- VIEW�� ��Ī�� �־ ����
CREATE OR REPLACE VIEW V_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO,8,1),1,'��','��'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
-- ERROR : ORA-00998: must name this expression with a column alias
-- 00998. 00000 -  "must name this expression with a column alias"
-- �÷��� ��Ī ���ڴٰ� �ϰ� �ȸ��� �� ����
-- ��Ī �����ؾ߸� �� �� : �������� SELECT�� �ȿ� �Լ��� ���ԵǸ� �ݵ�� ��Ī ����
-- �� �ڵ忡�� �Լ��� DECODE, EXTRACT�� �ֱ⿡ �÷��� ��Ī ������ �ؾ߸��Ѵ�
-- ��Ī �߰��ؼ� �ٽ� �õ�
-- �� ��Ī���� ���1
CREATE OR REPLACE VIEW V_EMP_JOB
AS SELECT EMP_ID ���, EMP_NAME "��� ��", JOB_NAME "���� ��",
            DECODE(SUBSTR(EMP_NO,8,1),1,'��','��') AS ����,
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
    FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE); -- View V_EMP_JOB��(��) �����Ǿ����ϴ�.
        
SELECT * FROM V_EMP_JOB; -- ��Ī ���� Ȯ��
   
-- �ٸ� ��Ī ������
-- �� ��Ī���� ���2 : �������� �ȿ��� ����
CREATE OR REPLACE VIEW V_EMP_JOB(���, �̸�, "���� ��", "����(��/��)", �ٹ����) -- ����,Ư�� �� ""�� ������ �ʼ�
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO,8,1),1,'��','��'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);        
-- V_EMP_JOB�並 �̹� ���1���� �����ߴµ� ���2���� �ߺ����� ���� ������
-- �� �ɼ� ���� 


/*
-- VIEW �ɼ�

    CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���̸�[(alias,alias, ...)]
    AS subQuery  
    [WITH CHECK OPTION]
    [WITH READ OPTION];
    
[] : ��������

FORCE : ���������� ���� ���̺��� �������� �ʾƵ� �� ����
NOFORCE : �⺻��, ���������� ���� ���̺��� �����ؾ߸� �� ����
WITH CHECK OPTION :�ɼ����� ������ �÷��� �� ���� �Ұ���
WITH READ OPTION : �信 ���� ��ȸ�� ����(DML �Ұ���)

        
*/        
        
-- OR REPLACE
-- ������ ������ �̸��� �䰡 �����ϸ� �����, ������ ���� �����ϴ� �ɼ�

CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
    FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME, SALARY
    FROM EMPLOYEE;
-- ������ �並 SALARY �߰��ؼ� �ٽ� �����߾ �ߺ����� ���� ���

-- OR REPLACE ���� ����� �õ�
CREATE VIEW V_EMP1
AS SELECT EMP_NAME, SALARY
 FROM EMPLOYEE;
-- ORA-00955: name is already used by an existing object
-- ���� :OR REPLACE�� ���⿡ ����Ⱑ �ȵǼ� ���� �߻�


-- �ݴ�� �õ�
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM V_JOB; 
SELECT * FROM JOB;  

INSERT INTO V_JOB VALUES('J8','����');
UPDATE V_JOB SET JOB_NAME = '�˹�' WHERE JOB_CODE = 'J8';
-- V_JOB�� �˹ٷ� �����ߴµ� �� �����̺��� JOB���� �����Ͱ� ���������?
DELETE FROM V_JOB WHERE JOB_CODE = 'J8'; -- �䵵 �����̺� ������
-- ��, �並 �����ص� �����̺��� �����̰��� �����̺� �����ص� �信 �����̵�
-- WHY?
-- VIEW�� ���� ����


/*
-- ���� ����
4:35-4:40
-- �並 ����� �� �����ߴ� ������
�䰡 ������ �� ���� ����Ʈ ������ �����̵Ǹ鼭 �ٽ� �����ִ� ��

�信 ���� �����Ͱ� ����ִ� ��X
��, ����Ʈ�� ���� ���ȭ���� ������ ��ü
V_JOB�� ���ؼ� �ٽ� �ؽ�Ʈ�� �ٽ� �����Ŵ. 
SELCT JOB_CODE JOB_NAME FROM JOB �긦 �ٽ� ������Ѽ� ȭ�鿡 �ѷ��ִ� ��
�̷��ٺ��� ������ �����Ű�� �� �ؽ�Ʈ�� ����ִ� �ڵ带 �������� �����ϴٺ���
�����̺�� �䰡 ���� ��ȣ�ۿ� �� �� �ۿ� ���� ��Ȳ�� �Ǵ� ��

�並 �����ϸ� �����̺� �ٲ������
�� �� TEXT�ȿ� FROM JOB(�����̺�� ����� �κ�)�̶�� ���� �κ� ������ �����̺�� ����Ǵ� ��
VIEW������ ���� TEXT���� �ڵ带 �����ؼ� ������� �����ִµ� �� TEXT �ڵ忡 �ȿ� 
�����̺��� JOB�� �����͸� �����ؼ� ����� ���� ������ �����̺�� �� ���� ������ �ִ�




�� ���� ������ ������Ѵٰ� �ұ�?
V_JOB�� ���� TEXT�� ���� ���� ������ ������ �÷����� SELCT JOB_CODE JOB_NAME FROM JOB�� �״�� ����ִ�
V_JOB�� TEXT�� ����Ǿ� �ִ� ���� ���� �����Ű�� ��
V_JOB�� TEXT��� ������ �����ϴ� ��
���⼭ �� ���̺�� ����Ǵ� ������ �� TEXT�ȿ� FROM JOB�̶�� ���� �κ� ������ ����Ǵ� ��


�� ��� ���� : ���輺 ���Ҹ� ����
������ ��ģ�ٴ°� �̿� ���� �Ǵµ� �� �並 ����?
���߿� ����



*/

SELECT * FROM USER_VIEWS;


------------------------------------------------------------------------------


-- VIEW���� DML��ɾ�� ������ �� ���� ���
-- 1.�� ���ǿ� ���Ե��� �ʴ� �÷��� �����ϴ� ���
-- 2.�信 ���Ե��� ���� �÷� �� ���̽��� �Ǵ� ���̺� �÷��� NOT NULL ���������� ������ ���
-- 3.��� ǥ�������� ���ǵ� ���
-- 4.�׷��Լ� �Ǵ� GROUP BY���� ������ ���
-- 5.DISTINCT�� ������ ���



-- 1.�� ���ǿ� ���Ե��� �ʴ� �÷��� �����ϴ� ���
CREATE OR REPLACE VIEW V_JOB2
AS SELECT JOB_CODE
    FROM JOB;

SELECT * FROM V_JOB2;

INSERT INTO V_JOB2 VALUES ('J8','����');
-- SQL ����: ORA-00913: too many values
UPDATE V_JOB2 SET JOB_NAME = '����' WHERE JOB_CODE = 'J7';
-- SQL ����: ORA-00904: "JOB_NAME": invalid identifier
-- JOB_NAME�̶�°� ���⿡ ����
DELETE FROM V_JOB2 WHERE JOB_NAME = '����';
-- SQL ����: ORA-00904: "JOB_NAME": invalid identifier


-- 2.�信 ���Ե��� ���� �÷� �� ���̽��� �Ǵ� ���̺� �÷��� NOT NULL ���������� ������ ���
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME
    FROM JOB;

SELECT * FROM V_JOB3;

INSERT INTO V_JOB3 VALUES('����');
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- JOB�� NOT NULL �������� ������ ����

-- 3.��� ǥ�������� ���ǵ� ���
CREATE OR REPLACE VIEW EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + SALARY + SALARY*NVL(BONUS,0))*12 ����
    FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL VALUES(800, '������',3000000,3600000);
-- SQL ����: ORA-01733: virtual column not allowed her
UPDATE EMP_SAL SET ����=8000000 WHERE EMP_ID = 200;
-- SQL ����: ORA-01733: virtual column not allowed here


-- 4.�׷��Լ� �Ǵ� GROUP BY���� ������ ���
CREATE OR REPLACE VIEW V_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) �հ�, AVG(SALARY) ���
    FROM EMPLOYEE
    GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT VALUES('D10',600000, 4000000);
-- SQL ����: ORA-01733: virtual column not allowed here
UPDATE V_GROUPDEPT SET DEPT_CODE = 'D10' WHERE DEPT_CODE = 'D3';
-- SQL ����: ORA-01732: data manipulation operation not legal on this view
DELETE FROM V_GROUPDEPT WHERE DEPT_CODE = 'D1';
-- ���ݱ��� ������ �ظ��ϸ� ����µ�, 4���� ���� ���� �Ұ�

-- 5.DISTINCT�� ������ ���
CREATE OR REPLACE VIEW V_DT_EMP
AS SELECT DISTINCT JOB_CODE
    FROM EMPLOYEE;
    
SELECT * FROM V_DT_EMP;

INSERT INTO V_DT_EMP VALUES('J9');
-- SQL ����: ORA-01732: data manipulation operation not legal on this view
UPDATE V_DT_EMP SET JOB_CODE = 'J9' WHERE JOB_CODE = 'J7'; 
-- SQL ����: ORA-01732: data manipulation operation not legal on this view
DELETE FROM V_DT_EMP WHERE JOB_CODE = 'J1';
-- SQL ����: ORA-01732: data manipulation operation not legal on this view


--6.JOIN�� ���ؼ� ���� ���̺��� ������ ���
CREATE OR REPLACE VIEW V_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP VALUES(800,'������','�λ������');
-- SQL ����: ORA-01776: cannot modify more than one base table through a join view
UPDATE V_JOINEMP SET DEPT_TITLE = '�λ������' WHERE EMP_ID = 219;
-- SQL ����: ORA-01779: cannot modify a column which maps to a non key-preserved table



-- ��� INSERT�� ��� DELETE�� �ȵǰ� �� �ٸ���
-- 1-6�� �ܿ� �ʿ� X // VIEW �� ���� ����� ������ ������ ��



------------------------------------------------------------------------------
/*
-- VIEW �ɼ�

    CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���̸�[(alias,alias, ...)]
    AS subQuery  
    [WITH CHECK OPTION]
    [WITH READ OPTION];
    
[] : ��������

FORCE : ���������� ���� ���̺��� �������� �ʾƵ� �� ����
NOFORCE : �⺻��, ���������� ���� ���̺��� �����ؾ߸� �� ����
WITH CHECK OPTION :�ɼ����� ������ �÷��� �� ���� �Ұ���
WITH READ OPTION : �信 ���� ��ȸ�� ����(DML �Ұ���)

*/
------------------------------------------------------------------------------


-- FORCE / NOFORCE
-- FORCE : ���������� ���� ���̺��� �������� �ʾƵ� �� ����
-- NOFORCE : �⺻��, ���������� ���� ���̺��� �����ؾ߸� �� ����

CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP2 -- NOFORCE�� �����Ǽ� ���ִ� ����
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
-- ERROR : ORA-00942: table or view does not exist    
    
CREATE OR REPLACE FORCE VIEW V_EMP2 -- FORCE
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT; 
-- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.
-- �� ���� ����

-- FORCE�� �ʿ��� ���
-- �����ϴٰ� �並 ���� ����� ���߿� ���̺��� ���߿� ����� ��찡 ���� �ִ�
    
------------------------------------------------------------------------------

-- WITH CHECK OPTION
-- �ɼ����� ������ �÷��� �� ���� �Ұ���

CREATE OR REPLACE FORCE VIEW V_EMP3 -- FORCE
AS SELECT * FROM EMPLOYEE
    WHERE DEPT_CODE = 'D9'
WITH CHECK OPTION; -- DEPT_CODE�� ���� UPDATE �Ұ���
-- WITH CHECK OPTION

SELECT * FROM V_EMP3;

-- ������Ʈ �õ��غ��� ������
UPDATE V_EMP3 SET DEPT_CODE = 'D1' WHERE EMP_ID = 200;
-- ERROR : ORA-01402: view WITH CHECK OPTION where-clause violation

-- �̿ܿ��� ������Ʈ ����

COMMIT;

UPDATE V_EMP3 SET EMP_NAME = '������' WHERE EMP_ID = 200;
-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
INSERT INTO V_EMP3
VALUES(902, '�����','111111-1111111','d@d.d','01022223333','D9','J3','S3',
        3500000, 0.2, 200, SYSDATE, NULL, 'N');
-- ERROR : ORA-01402: view WITH CHECK OPTION where-clause violation
-- D1�� �������ؼ� ����
-- D9�� ������ ���� ����

SELECT * FROM V_EMP3;

ROLLBACK;



------------------------------------------------------------------------------

-- WITH READ OPTION
-- �信 ���� ��ȸ�� ����(DML �Ұ���)
-- ��ȸ�� �� �� �ְ� WITH READ OPTION �� �ɼ��� ���� ���ɼ� ����


CREATE OR REPLACE FORCE VIEW V_DEPT -- FORCE
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM V_DEPT;

INSERT INTO V_DEPT VALUES('D10', '�ؿܿ���4��','L1');
-- ������Ʈ, ���� �� �Ұ�
UPDATE V_DEPT SET LOCATION_ID = 'L2';
DELETE FROM V_DEPT;


--��
--�����̶� �ɼǸ� ����س����� �ȴ�
--�������� �������� ���θ� ��


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


