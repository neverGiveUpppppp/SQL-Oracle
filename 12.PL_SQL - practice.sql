------------------------------------------------------------------------------
--------------------------------PL/SQL(������ SQL)-----------------------------
------------------------------------------------------------------------------
/*

PL/SQL ( Procedural Language extension to SQL) = ������ SQL
����Ŭ ��ü�� ����Ǿ��ִ� ������ ���

������ ���(Procedural Language)��?
�ݺ���,if�� ���� �͵��� ���������� ���Ǵ� �ڵ����
������ ��, ��� ���� �͵��� sql���� ���Ǵ� ��

������ ����, ����ó��, �ݺ�ó��(�ݺ���) ���� �����Ͽ� PL/SQL�� ���ؼ� SQL�� ���� ����

PL/SQL�� ����
1.�����(DECLARE SECTION)          :   DECLARE
2.�����(EXECUTABLE SECTION)       :   BEGIN
3.����ó����(EXCEPTION SECTION)     :   EXCEPTION

1.�����(DECLARE SECTION)      : ����, ��� �����ϴ� �κ� 
        -> DECLARE�� ����
2.�����(EXECUTABLE SECTION)   : ���, �Լ� ���� �� ������ ��� �ϴ� �κ� 
        -> BEGIN���� ����
3.����ó����(EXCEPTION SECTION) : ���� �߻� ��, �ذ��� �� �ִ� ���� ��� �κ� 
        -> EXCEPTION���� ����
        
�����,����ó���� ��������
 - �ʿ信 ���� �� �� ���� �ִٴ� �ǹ�
 
�ڹٷ� ���� 
System.out.println("�ȳ�");

String hello = "�ȳ�";
System.out.println(hello);


*/

SET SERVEROUTPUT ON; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLOW WORLD');
END;
/ 

SET SERVEROUTPUT ON;
BEGIN   
    DBMS_OUTPUT.PUT_LINE('HELLOW WORLD');
END;
/
-- / �����ؼ� �� �ڵ� ���� �ּ� �޸� ���� �߻�
-- SET SERVEROUTPUT ON; : ��� ����� �߰Բ� �ϴ� �ڵ�
-- SP2-0265: serveroutput�� ON �Ǵ� OFF�� �����Ǿ�� �մϴ�.
--      -> �ּ��� ���Ʒ� �� ������Ѵ�. ���ۺ��� ������ �ȿ� �ּ��� ������ؼ� ������ ���� �� 
-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
-- ����� �����°� �´µ� ���� ������ ���̴ٶ�� �ǹ̷� /���� ���������


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- ����� �ۼ�

/*
-- �ڹ��ڵ�� ����
-- �� �ڹ��ڵ带 ����η� �ۼ��� �� ����

-�����
int empId;
String empName;
final int PI = 3.14; -- ���� �ʱ�ȭ �����ϸ� ����� ��

-�����
empId = 888;        -- �� �ʱ�ȭ �κе� ����η� ����.
empName = "�����";  
System.out.println("empId : " + empId;
System.out.println("empName : " + empName);
System.out.println("PI : " + PI);

*/

-- �����
DECLARE -- �������� // ���� 3��
    EMP_ID NUMBER;          -- ��� ���ε��� ���� �����ؼ� �� ��
    EMP_NAME VARCHAR(30);   -- ���� ���°� �ƴ� �����ؼ� ���� ����� ����
    PI CONSTANT NUMBER := 3.14; -- ��� �ѹ�. ����Ŭ������ ����� CONSTANT
                                -- ����Ŭ�� ���Կ����� : :=
-- �����                                
BEGIN
    EMP_ID := 888;
    EMP_NAME := '�����';

    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/ 
-- / ���� �ּ��޸� �ȵȴ�
-- ���ǽð� 14:00-14:20

-- EMP_ID�� ������ ������ �� ����
-- �����
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
-- �����
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EMP_ID, EMP_NAME
    FROM EMPLOYEE
--    WHERE EMP_ID = 200;
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('��� : '||EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||EMP_NAME);
    
END;
/


/* ����
���۷��� ������ EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY�� �����ϰ�
EMPLOYEE ���̺��� ���, �̸�, �����ڵ�, �μ��ڵ�, �޿��� ��ȸ�ϰ�
������ ���۷��� ������ ��� ����Ͻÿ�
��, �Է¹��� �̸��� ��ġ�ϴ� ������ ������ ��ȸ�ϼ���.                               
*/
DECLARE 
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('��� : '||EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ�CODE : '||DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('���ڵ� : '||JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('���� : '||SALARY);
END;
/


/* -- ��� ���
EMP_ID 209
EMP_NAME �ɺ���
DEPT_CODE D5
JOB_CODE J3
SALARY 3500000
*/


--������ ���� ���ٸ�?

-- �� �� ��ü�� ������ ���� ���۷���
-- %ROWTYPE

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('��� : '||E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : '||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : '||E.SALARY);
END;
/

-- �� �� ��ü ���� : %ROWTYEP + INTO
DECLARE
   E EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' ||E.EMP_ID);
END;
/
-- ����� ���� �����ϴ� ���� �����ݷ�(;)���� ��ħ�� ������Ѵ�

---RE

------------------------------------------------------------------------------
-----------------------------------���ǹ�--------------------------------------
------------------------------------------------------------------------------

-- ���ǹ�

-- IF ~ THEN ~ END IF;
-- IF ~ THEN ~ END IF= �ڹ� ���� IF��


-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �޿�, ���ʽ��� ���
-- ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ���
-- �ϴ� IF�� ����

--�����
DECLARE  -- �������� // ���� 
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
--�����
BEGIN 
    SELECT EMP_ID,EMP_NAME,SALARY, BONUS
    INTO EMP_ID,EMP_NAME,SALARY, BONUS -- ��Ī���� ���� Ȯ������
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('���:' || EMP_ID);

END;
/
-- ������ ����
DECLARE  -- �������� // ���� 4��
    EI EMPLOYEE.EMP_ID%TYPE;    -- EI
    EN EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID,EMP_NAME,SALARY, BONUS
    INTO EI,EN,SAL, BNS -- INTO�� �� �͵��� ��������!!
    FROM EMPLOYEE       -- INTO�� EMP_ID�� ���� ������ ���� : EI
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('���:' || EI); -- EI
END;
/    

-- IF�� �߰�
-- ������ ����
DECLARE  -- �������� // ���� 4��
    EI EMPLOYEE.EMP_ID%TYPE;    -- EI
    EN EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID,EMP_NAME,SALARY, BONUS
    INTO EI,EN,SAL, BNS -- INTO�� �� �͵��� ��������!!
    FROM EMPLOYEE       -- INTO�� EMP_ID�� ���� ������ ���� : EI
    WHERE EMP_ID = '&���';
    
    IF BNS IS NULL
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ� ����X ���' || BNS); -- EI
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���:' || EI); -- EI
END;
/    

-- NVL �߰� ����
DECLARE  -- �������� // ���� 4��
    EI EMPLOYEE.EMP_ID%TYPE;    -- EI
    EN EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID,EMP_NAME,SALARY, NVL(BONUS, 0) -- NVL
    INTO EI,EN,SAL, BNS -- INTO�� �� �͵��� ��������!!
    FROM EMPLOYEE       -- INTO�� EMP_ID�� ���� ������ ���� : EI
    WHERE EMP_ID = '&���';
    
    IF BNS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ� ����X ���' || BNS); -- EI
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���:' || EI); -- EI
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || EN); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || SAL);
    DBMS_OUTPUT.PUT_LINE('BONUS ' || BNS);
END;
/    


------------------------------------------------------------------------------

-- IF ~ THEN ~ ELSE ~ END IF
-- IF ~ THEN ~ ELSE ~ END IF == IF ~ ELSE��


-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �μ���, �Ҽ� ���
-- TEAM ������ ����� �Ҽ��� KO�� ����� ������, �ƴ� ����� �ؿ������� ����

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR(10);
    
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&���';
    
    IF national_code = 'KO'
        THEN TEAM := '������';
    ELSE TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/

-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �μ���, �Ҽ� ���
-- TEAM ������ ����� �Ҽ��� KO�� ����� ������, �ƴ� ����� �ؿ������� ����
-- ������ �ٲ㼭 �ٽ��ѹ�
DECLARE
    EI EMPLOYEE.EMP_ID%TYPE;
    EN EMPLOYEE.EMP_NAME%TYPE;
    DT DEPARTMENT.DEPT_TITLE%TYPE;
    NC LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EI, EN, DT, NC
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&���';
    
    IF NC = 'KO'
        THEN TEAM := '������';
    ELSE TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EI); 
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EN); 
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DT);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || NC);   
END;
/


-- ����ڿ��� ����� �޾ƿ� �� ����� ��ü ������ VEMP�� ����
-- VEMP�� �̿��Ͽ� ���� ���(���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���)
-- ���� ��� ��� ���� YSALARY�� ����
-- �޿� �̸� ����(\1,000,000 ����)���� ���
-- (IF���� NVL�����ε� ����)

-- ��� 1���� ��ü�����ϱ� �� �� ��ü -> %ROWTYPE
DECLARE
    VEMP EMPLOYEE%ROWTYPE;
    YSALARY NUMBER;
BEGIN
    SELECT *
    INTO VEMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&�����ȣ';
    
    IF VEMP.BONUS IS NOT NULL   
        THEN YSALARY := VEMP.SALARY * (1+VEMP.BONUS)*12;
    ELSE YSALARY := VEMP.SALARY*12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.EMP_ID); 
    -- SELECT���� *��ü �ҷ����� ������ ������.�÷������� ����ؼ� �ҷ��;��Ѵ�
    DBMS_OUTPUT.PUT_LINE(VEMP.SALARY||' '||VEMP.EMP_NAME||' '||YSALARY||
                        TO_CHAR(YSALARY,'FML999,999,999')); 
    
END;
/
-- ����ڿ��� ����� �޾ƿ� �� ����� ��ü ������ VEMP�� ����
-- VEMP�� �̿��Ͽ� ���� ���(���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���)
-- ���� ��� ��� ���� YSALARY�� ����
-- �޿� �̸� ����(\1,000,000 ����)���� ���
-- (IF���� NVL�����ε� ����)
DECLARE
    VEMP EMPLOYEE%ROWTYPE;
    YSALARY NUMBER;
BEGIN
    SELECT *
    INTO VEMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    IF VEMP.BONUS IS NOT NULL
        THEN YSALARY := VEMP.SALARY*(1+VEMP.BONUS)*12;
    ELSE YSALARY := VEMP.SALARY*12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.SALARY||' '||vemp.EMP_NAME||' '||
                        TO_CHAR(YSALARY,'FML999,999,999'));     
    
    
END;
/

------------------------------------------------------------------------------

-- IF~ THEN~ ELSIF~ THEN~ ELSE~ END IF
-- IF~ THEN~ ELSIF~ THEN~ ELSE~ END IF == IF~ ELSE IF~ ELSE��


-- ������ �Է¹޾� SCORE ������ ����
-- 90�� �̻��̸� A, 80�̻��̸� B, 70�̻��� C, 60�� �̻��� D, �� �̸��� F ó���Ͽ� GRADE ������ ����
-- ������� : ����� ������ N���̰�, ������ M�����Դϴ�.

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := '&����';
        
    IF SCORE >= 90
        THEN GRADE := 'A';
    ELSIF SCORE >= 80
        THEN GRADE := 'B';
    ELSIF SCORE >= 70
        THEN GRADE := 'C';
    ELSIF SCORE >= 60
        THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ '||SCORE||'���̰�, ������ '||GRADE||'�� �Դϴ�'); 
END;
/
-- ������ �Է¹޾� SCORE ������ ����
-- 90�� �̻��̸� A, 80�̻��̸� B, 70�̻��� C, 60�� �̻��� D, �� �̸��� F ó���Ͽ� GRADE ������ ����
-- ������� : ����� ������ N���̰�, ������ M�����Դϴ�.

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := '&����';
    
    IF SCORE >= 90
        THEN GRADE := 'A';
    ELSIF SCORE >= 80
        THEN GRADE := 'B';
    ELSIF SCORE >= 70
        THEN GRADE := 'C';
    ELSIF SCORE >= 60
        THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF; 
    
    DBMS_OUTPUT.PUT_LINE('����� ������ '||SCORE||'���̰�, ������ '||GRADE||'���� �Դϴ�.');
END;
/

------------------------------------------------------------------------------
------------------------------------------------------------------------------








------------------------------------------------------------------------------
------------------------------------------------------------------------------








------------------------------------------------------------------------------
------------------------------------------------------------------------------






