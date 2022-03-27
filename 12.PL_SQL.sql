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


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DECLARE  -- ��������
	������ ���������̸�.�������÷���%TYPE
BEGIN
	SELECT EMP_ID,EMP_NAME,SALARY, BONUS -- ����� ���̺��� �÷���
	INTO ������ -- (DECLARE�� ����)������, ������
	FROM EMPLOYEE -- ����� ���̺��
	WHERE EMP_ID = '&���';

	DBMS_OUTPUT.PUT_LINE('���:' || (�����)������); -- (�����)������)
    
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


-- ���� : %TYPE + INTO

-- EMP_ID�� ������ ������ �� ����
-- �����
DECLARE -- �������� // ���� 2��
    EMP_ID EMPLOYEE.EMP_ID%TYPE; -- EMPLOYEE���̺��� EMP_ID�� �����͸� �����ϰڴ�
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE; -- %TYPE
-- �����
BEGIN
    SELECT EMP_ID, EMP_NAME -- EMP ID,NAME�� ���� DECLARE�� EMP ID,NAME���� �ְ� ������?
    INTO EMP_ID, EMP_NAME   -- INTO ���
    FROM EMPLOYEE
    WHERE EMP_ID = 200;
    -- ����ڿ��� INPUT �ޱ�(SCANNER)
    WHERE EMP_ID = '&EMP_ID'; -- 205�Է� // EMP_ID 205 EMP_NAME : ������ // �������
    WHERE EMP_ID = '&���';    -- ���ٰ� ���� �ǹ�
    
    --����غ���
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID);      -- EMP_ID : 200
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);-- EMP_NAME : ������

END;
/


/* ����
���۷��� ������ EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY�� �����ϰ�
EMPLOYEE ���̺��� ���, �̸�, �����ڵ�, �μ��ڵ�, �޿��� ��ȸ�ϰ�
������ ���۷��� ������ ��� ����Ͻÿ�
��, �Է¹��� �̸��� ��ġ�ϴ� ������ ������ ��ȸ�ϼ���.                               
*/
DECLARE -- ���� 5��
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&EMP_NAME'; -- '&' : ����� �Է�(Scanner)
    --WHERE EMP_NAME = '&�����'; -- ��� �� �����ϸ� ����
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE ' || DEPT_CODE); 
    DBMS_OUTPUT.PUT_LINE('JOB_CODE ' || JOB_CODE); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || SALARY); 
END;
/
/* -- ��� ���
EMP_ID 209
EMP_NAME �ɺ���
DEPT_CODE D5
JOB_CODE J3
SALARY 3500000
*/

-------------------------------------------------------------------------------


--������ ���� ���ٸ�?


-- %ROWTYPE
-- �� �� ��ü�� ������ ���� ���۷���
-- ������ ���������̺��%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE; -- �տ� Ÿ�Կ� �´� �������� ���
BEGIN                   -- EMPLOYEE ���� �� �� ���۷���
    SELECT * INTO E     -- E : ������
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || E.EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || E.EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || E.SALARY);
    
END;
/
-- ����� ���� �����ϴ� ���� �����ݷ�(;)���� ��ħ�� ������Ѵ�


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

------------------------------------------------------------------------------
-----------------------------------���ǹ�--------------------------------------
------------------------------------------------------------------------------

-- ���ǹ�

-- IF ~ THEN ~ END IF;
-- IF ~ THEN ~ END IF = �ڹ� ���� IF��

DECLARE
    E EMPLOYEE%ROWTYPE; -- �տ� Ÿ�Կ� �´� �������� ���
BEGIN
    SELECT * INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || E.EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || E.EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || E.SALARY);
    
END;
/

-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �޿�, ���ʽ��� ���
-- ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ���
-- �ϴ� IF�� ����
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,SALARY,BONUS
    INTO EMP_ID,EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('BONUS ' || BONUS);
END;
/
-- IF�� �߰�
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,SALARY,BONUS
    INTO EMP_ID,EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || SALARY);
    
    IF(BONUS = 0) -- IF�� ���� ��Ī // ���� BONUS�� ������ͼ� ��� 
    -- IF BONUS = 0 -- �Ұ�ȣ ���� ����
    -- IF BONUS IS NULL
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('BONUS ' || BONUS * 100 || '%'); -- ���ʽ� % ���̰��ϱ�
END;
/

-- NVL �߰� ����
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,SALARY,NVL(BONUS, 0) -- NVL :NULL ��� ����� ����
    INTO EMP_ID,EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('SALARY ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('BONUS ' || BONUS);
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
    TEAM VARCHAR2(10);  -- TEAM ���� ����
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
--    FROM EMPLOYEE, DEPARTMENT, LOCATION ======================================
--    WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID,===== ����Ŭ���� ������ �� ���ȵǴ°�?
--          DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE, == WHERE�� ������ ����?
--          EMP_ID = '&EMP_ID';
    FROM EMPLOYEE 
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&EMP_ID';
    
    IF NATIONAL_CODE = 'KO'     -- IF ELSE��
        THEN TEAM := '������';   -- IF ~ THEN ~ ELSE ~ END IF
    ELSE TEAM := '�ؿ���';       -- DMBS_OUTPUT.PUT_LINE������ �տ� �;� IF�� �����
    END IF;

    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME); 
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM); -- NATIONAL_CODE���� TEAM���� ����
END;
/

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

DECLARE
    VEMP EMPLOYEE%ROWTYPE; -- ��� ��ü �ҷ����°Ŷ� %ROWTYPE
    YSALARY NUMBER;
BEGIN             
    SELECT *      -- VEMP�������� �ش� ���1���� ��ü������ �ҷ����⿡(SELECT���� *��ü �ҷ����� ������)
    INTO VEMP     -- VEMP.�÷������� ���ϴ� ������ ����ؼ� �ҷ��;��Ѵ�
    FROM EMPLOYEE -- ex) VEMP.SALARY VEMP.DEPT_CODE
    WHERE EMP_ID = '&EMP_ID';
    
    IF VEMP.BONUS IS NOT NULL   
        THEN YSALARY := VEMP.SALARY * (1+ VEMP.BONUS) * 12;
    ELSE YSALARY := VEMP.SALARY * 12;
    -- YSALRY := VEMP.SALARY * (1+ NVL(VEMP.BONUS, 0)) * 12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.SALARY || ' ' || VEMP.EMP_NAME || ' ' ||
                         TO_CHAR(YSALARY, 'FML999,999,999'));  -- FM : �������� // L : �ý��ۼ��� ������ ȭ�����
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
    SCORE := '&����'; -- ���Կ����� :=
    
    IF SCORE >= 90
        THEN GRADE := 'A';
    ELSIF SCORE >=80
        THEN GRADE := 'B';
    ELSIF SCORE >= 70
        THEN GRADE := 'C';
    ELSIF SCORE >= 60
        THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰� ������ ' || GRADE ||'�����Դϴ�.');
END;
/





------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- CASE~ WHEN~ THEN~ END(SWITCH��)

-- ���α׷� ����� �� ����Ʈ�� ������ �ٸ� ������� �ȳ��´ٸ�,
-- SET SERVEROUTPUT ON; �ڵ� ����ְ� �ϸ� �� �߳��� ��

-- IF���� THEN���� �����ݷ�( ; )�� ������ CASE WHEN THEN END���� �ȵ��� ������ END����


-- ��� ��ȣ�� �Է��Ͽ� �ش� ����� ���,�̸�,�μ��� ���
-- �����
DECLARE -- �������� // ���� 2��
    EMP EMPLOYEE%ROWTYPE; -- EMPLOYEE���̺��� EMP_ID�� �����͸� �����ϰڴ�
    DNAME DEPARTMENT.DEPT_TITLE%TYPE;
-- �����
BEGIN
    SELECT * INTO EMP    
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
-- ���1
--    DNAME := CASE
--                WHEN EMP.DEPT_CODE = 'D1' THEN '�λ������'
--                WHEN EMP.DEPT_CODE = 'D2' THEN 'ȸ�������'
--                WHEN EMP.DEPT_CODE = 'D3' THEN '�����ú�'
--                WHEN EMP.DEPT_CODE = 'D4' THEN '����������'
--                WHEN EMP.DEPT_CODE = 'D5' THEN '�ؿܿ���1��'
--                WHEN EMP.DEPT_CODE = 'D6' THEN '�ؿܿ���2��'
--                WHEN EMP.DEPT_CODE = 'D7' THEN '�ؿܿ���3��'
--                WHEN EMP.DEPT_CODE = 'D8' THEN '���������'
--                WHEN EMP.DEPT_CODE = 'D9' THEN '�ѹ���'
--                ELSE '����X'
--            END;
-- ���2
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '�λ������'
                WHEN 'D2' THEN 'ȸ�������'
                WHEN 'D3' THEN '�����ú�'
                WHEN 'D4' THEN '����������'
                WHEN 'D5' THEN '�ؿܿ���1��'
                WHEN 'D6' THEN '�ؿܿ���2��'
                WHEN 'D7' THEN '�ؿܿ���3��'
                WHEN 'D8' THEN '���������'
                WHEN 'D9' THEN '�ѹ���'
                ELSE '����X'
            END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID||' '||EMP.EMP_NAME||' ' ||DNAME);
    
END;
/

------------------------------------------------------------------------------
--------------------------------------�ݺ���-----------------------------------
------------------------------------------------------------------------------

-- �ݺ���


-- BASIC LOOP
-- LOOP ~ END LOOP;
-- �ݺ��� ������ �ۼ��ϰ� �������� �ݺ��� ��� ���� ���
-- FOR���� �ٸ��� �ܼ� �ݺ���


-- 1~5���� ������ ���
DECLARE
    N NUMBER := 1; -- �� �ʱ�ȭ
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;         -- i+1ó�� �� ����
-- ���1        
--        IF N > 5 THEN EXIT; -- �ݺ��� ���� ����
--        END IF;
-- ���2
        EXIT WHEN N > 5;    -- �ݺ��� ���� ����
    END LOOP;
END;
/
-- 1~5���� ���η� ������µ�



-- �ݺ� ���� ��� 2����
/*
-- ���1        
IF N > 5 THEN EXIT; -- �ݺ��� ���� ����
END IF;
-- ���2
EXIT WHEN N > 5;
*/
------------------------------------------------------------------------------

-- FOR LOOP

-- Ư���� ������ ���� �ʴ� �̻� DECLARE ����ΰ� �ʿ�X
-- �������͸� �־ �̸� �������� ���� FOR LOOP�� �Ἥ �������͸� ���� �ִµ� ����Ѵ�

-- 1~5���� ������ ���
BEGIN
    FOR N IN 1..5   -- �ǹ� 1���� 5���� // .. 2�� �� 3������ �����߻�
    LOOP            --  N�� �ڵ������� NUMBERŸ���� ���� ������
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 5~1���� ���
BEGIN
    FOR N2 IN REVERSE 5..1  -- �⺻������ �� ���ڰ� �۾ƾ� FOR���� ���Եȴ�. 
    LOOP                    -- REVERSE ���� ��
        DBMS_OUTPUT.PUT_LINE(N2);
    END LOOP;
END;
/
-- REVERSE �߰� �� FOR N2 IN 5..1�θ� ����ϸ�,
-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�. ������ �ƹ��͵� �ȶ��

-- ���� ��� ����
-- �������� �ֱ�

-- ��� ���
BEGIN
    FOR N2 IN REVERSE 1..5  -- �⺻������ �� ���ڰ� �۾ƾ� FOR���� ���Եȴ�. 
    LOOP                    -- REVERSE ���� ��
        DBMS_OUTPUT.PUT_LINE(N2);
    END LOOP;
END;
/

BEGIN
    FOR N IN 1..30   
    LOOP            
        INSERT INTO TB1 VALUES(I); -- -- �������� �ֱ�
    END LOOP;
END;
/

-- FOR�� ���� �ȿ��� ���갡��
BEGIN
    FOR N IN 2..8/2 -- FOR�� �ȿ��� ���갡��
    LOOP
        DBMS_OUTPUT.PUT_LINE('---'||N||'��---');    
        FOR NN IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(N||' x '||NN||' = '||N*NN);
        END LOOP;
    END LOOP;
END;
/
------------------------------------------------------------------------------

-- WHILE LOOP

-- ���� �� �ʱ�ȭ ��, ����� ����
-- ex)���� �ڵ忡�� N �̹� ��������� �Ʒ��� �ٽ� �� �ʱ�ȭ�ؼ� ����

-- 1~5���� ������ ���
DECLARE
    N NUMBER := 1; -- �� �ʱ�ȭ
BEGIN
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N + 1;     -- N + 1�� LOOP �� ��ġ �߿�. ���!
    END LOOP;
END;
/

-- 5~1���� ���
DECLARE
    N NUMBER := 5; -- �� �ʱ�ȭ
BEGIN
    WHILE N >= 1
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N - 1;     -- N - 1�� LOOP �� ��ġ �߿�. ���!
    END LOOP;
END;
/


-- ������ ���
-- ¦�� �� ���
-- 1)WHILE��
-- 2)FOR�� - WHILE��
-- 3)WHILE�� - FOR��

-- 1-9�� FOR�� ���
BEGIN
    FOR N IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE('---'||N||'��---');
        FOR M IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(N||' x '||M||' = '||N*M );
        END LOOP;
    END LOOP;
END;
/

-- 1-9�� WHILE�� ���
DECLARE
    N NUMBER := 1;
    NN NUMBER := 1;
BEGIN
    WHILE N <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE('---'||N||'��---'); 
        
        DECLARE
            NN NUMBER := 1;
        BEGIN   
            WHILE NN <= 9
            LOOP
            DBMS_OUTPUT.PUT_LINE(N||' x '||NN||' = '||N*NN);
            NN := NN + 1;
            END LOOP;    
            N := N + 1;
        END;
    END LOOP;
END;
/
-- ¦�� �� ���



COMMIT;
------------------------------------------------------------------------------
----------------------------���� ó��(EXCEPTION)--------------------------------
------------------------------------------------------------------------------

-- ���� ó��(EXCEPTION)
-- NO_DATA_FOUND : SELECT���� ������ ���� ��ȯ���� ���� ��
-- DUP_VAL_ON_INDEX : UNIQUE ���������� �� �÷��� �ߺ� ���� ���� ��
--                      DUPLICATE VALUE ON INDEX
-- ZERO_DIVIDE : 0���� ���� ��


-- DUP_VAL_ON_INDEX
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&���' -- 201 ��ǲ
    WHERE EMP_ID = 200;
    -- ERROR : ORA-00001: unique constraint (KH.EMPLOYEE_PK) violated
    -- ����ó�� �غ���
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/


-- NO_DATA_FOUND
DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT EMP_NAME INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID = 0;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('��ȸ ����� �����ϴ�');
END;
/


------------------------------------------------------------------------------




------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------










