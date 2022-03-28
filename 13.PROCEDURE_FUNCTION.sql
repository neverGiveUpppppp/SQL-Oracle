------------------------------------------------------------------------------
----------------------------------PROCEDURE-----------------------------------
------------------------------------------------------------------------------
                                                                  /*22.03.24 */
-- PROCEDURE 
-- PL/SQL ���� ��ü
-- PROCEDURE ���ν�����


CREATE TABLE EMP_DUP -- ���̺� ����
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_DUP; -- ������ �� ������ Ȯ�� ��ȸ



-- �ڷ� � �������� Ȯ���غ� ��

CREATE OR REPLACE PROCEDURE DEL_ALL_EMP -- PRCEDURE ���ν�����
IS -- ���ν����� ����ǵ� ���ν����� �̷��� ������� IS
BEGIN 
    DELETE FROM EMP_DUP;
END;
/
-- Procedure DEL_ALL_EMP��(��) �����ϵǾ����ϴ�.


-- ������ 2����
-- ���1
-- EXECUTE ���ν�����;
EXECUTE DEL_ALL_EMP;
-- ���2
-- EXEC ���ν�����;
EXEC DEL_ALL_EMP;

SELECT * FROM EMP_DUP; -- �ٽ� ��ȸ�غ��� �ڷ� ������

SELECT * FROM USER_SOURCE;

COMMIT;


-- �Է��� ����� �ش��ϴ� ��� ����
CREATE OR REPLACE PROCEDURE DEL_EMP_ID
IS
BEGIN 
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = '&���';
END;
/
-- Procedure DEL_EMP_ID��(��) �����ϵǾ����ϴ�.
EXEC DEL_EMP_ID; -- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
-- ó������ 200�� ������ ���� ������, �ι�°���ʹ� ��� 200�� �����ϰԵǴ� �ڵ尡 ��
-- ó�� 200 �����鼭 �� ���� ������ �Ǿ����. ���� �ڵ�� �߸��� �ڵ�
-- ���ǽð� 11:15-28
SELECT * FROM EMPLOYEE; 
/*�����ҽ� Ȯ���غ��� ���� �Է� 200�� �״�� �� ����
���� �ǵ��Ѱ� ���νõฦ ������ ������ 
����� ����ųİ� ����� ���ߴµ�
������ �� �� ������ �� ���� ���� �޾ƿ԰� �װ� �������� ����Ǿ� �Դٴ� ��

���� �ǵ��Ѱ� ���� �Է��� ��� �ϳ��� ����°� �ƴ϶� ���ν����� ������ ������ ��� ������
����� �ٷ����ǵ�, ���ν����� ����鼭 ����� ������ �Է� �ްԲ� ������⿡ 200 �Է��ϸ�
DEL EMP ID��� ���ν����� 200�� ���ִ� ���·� �������� �Ǿ����

�о� �� ����� ������ �� �����Ǳ⿡
����� �Է��ڵ� ��ġ�� �߸��� �� �˰ԉ��. �׷� ��� �־���ұ�?
EXEC ������ �� ���� ���� �� �ֵ��� �ؾ���


*/

-- �� ������
-- �Ű������� ����� ����

CREATE OR REPLACE PROCEDURE DEL_EMP_ID(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
IS
BEGIN 
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/
EXEC DEL_EMP_ID('&���'); -- �Է��� ���� ���� '&���'���� ��. ��, �Ű������� �ȴ�. �ٽ� ���ڰ� �Ǿ�
                         -- �� '&���'�� �����Ͱ� �� PROCEDURE ���ν�����(V_EMP_ID...)�� V_EMP_ID�� ��

SELECT * FROM EMPLOYEE; 

-- ���ǽð� 11:20-40
ROLLBACK;


------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- PROCEDURE �Ű�����

-- IN �Ű����� : ���ν��� ���ο��� ����� '����'
-- OUT �Ű����� : ���ν��� �ܺο��� ����� '����'
--               �ܺζ����� ���� ������ ���ν��� ���� �ǹ�


-- ����ڰ� �Է��� ������� ����� �̸�, �޿�, ���ʽ� ��ȸ�ϴ� SELECT_EMP_ID ���ν��� ����
-- �̸�,�޿�,���ʽ��� ���ν��� �ۿ����� �� �� �ֵ��� �ϴ°� �ǵ�

-- �Ű����� ������
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(V_EMP_ID/*������*/ EMPLOYEE.EMP_ID%TYPE)  
IS                                          
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE; -- ��������
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_NAME,SALARY,NVL(BONUS,0) -- NVL : ���ʽ� NULLó����
    INTO EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID/*������*/; -- V_EMP_ID : �ȿ��� ����Ǽ� IN �Ű������� ���Ե�
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME);
    DBMS_OUTPUT.PUT_LINE(SALARY);
    DBMS_OUTPUT.PUT_LINE(BONUS); 
    
END;
/

EXECUTE SELECT_EMP_ID('&���'); 
-- EXEC ���� �ּ� �޸� �����߻�
-- ���ν��� �ܺο��� ��ȸ ����


--    EMP_NAME EMPLOYEE.EMP_NAME%TYPE; -- ���� IN �Ű�����
--    SALARY EMPLOYEE.SALARY%TYPE;
--    BONUS EMPLOYEE.BONUS%TYPE;

-- �Ű����� ����
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(
                    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
                    EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE, -- OUT �Ű����� �ֱ⿡ 
                    SALARY OUT EMPLOYEE.SALARY%TYPE,
                    BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS                                          
BEGIN
    SELECT EMP_NAME,SALARY,NVL(BONUS,0) -- ����Ʈ�� ����� ������ �㿡���� ���� �ƿ����� ���ڴٴ� ��
    INTO EMP_NAME,SALARY,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID/*������*/; -- V_EMP_ID : �ȿ��� ����Ǽ� IN �Ű������� ���Ե�
END;
/
-- ���ε� ����
-- SQL�� ��밪�� ������ �� �ִ� ��� ����(�ۿ� �ִ� �Ͱ� �������ִ� ��)
VARIABLE VAR_EMP_NAME VARCHAR2(30); 
VAR VAR_SALARY NUMBER; 
VAR VAR_BONUS NUMBER;  
-- VARIABLE <- ���ε� ����
-- VAR��� �ᵵ OK
-- ���� ����

PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;

EXECUTE SELECT_EMP_ID('&���', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS); 
-- ���� // �ݷ� �� ���� ��

/*
�� �ڵ��� ���� ���� ���� �ٽ� ����
���ǽð� 2:23-2:28
�ƿ� �Ű����� 
�ۿ� �ִ� ������ ������ ���ε� ������ ������ ���� ��
�� ��, ���� �̶� CREATE�� ��,�����̶� ���� �����س��� ��
�ƿ� �Ű����� ����ŭ ���ε� ������ �����ϰڴ��ؼ� EXEC�� :���� ����
������� VARIABLE VAR VAR�� ���� PRINT�� �̿��Ͽ� �̸� Ȯ���� ��

*/


------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- FUNCTION

-- PROCEDURE�� ����ѵ�  PROCEDURE�� ��ȯ��X
-- FUNCTION�� ��ȯ�� O
-- ���ν����� ���������� ��ȯ ���� ������


-- 216�� ����� �̸� ���
CREATE OR REPLACE FUNCTION SELECT216
RETURN EMPLOYEE.EMP_NAME%TYPE -- �� ��ȯ�Ҳ��� ����Ÿ���� ���������
IS -- ����Ÿ���� ���� VARCHAR2,NUMBER�� �����ϰ� ����ó�� ���۷����ε� ����
    NAME EMPLOYEE.EMP_NAME%TYPE; --���� ���� �� �޾ƿ°� ����
BEGIN
    SELECT EMP_NAME
    INTO NAME -- ���� �޾ƿ°� ������� //
    FROM EMPLOYEE
    WHERE EMP_ID = 216;

    RETURN NAME; -- �ǹ� : ������ �����ҷ�? NAME�� �����ϰڴ�
END;
/
-- �ۿ��� ������ ����Ҳ��� VARIABLE ���������
VARIABLE NAME216 VARCHAR2(30);
-- == VAR
EXEC :NAME216 := SELECT216;
-- NAME216�� ���� ���� �ְڴٰ� := ���ش�
PRINT NAME216;
-- ���¿� 


-- ����� �Է¹޾� �ش� ����� ������ ����ϰ� �����ϴ� BONUS_CALC �Լ� ���� �� ���� ���
-- ������ ���ʽ� ���� (���ǽð� 3:20-3:35)

CREATE OR REPLACE FUNCTION BONUS_CALC (V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
                                     
RETURN NUMBER
IS
    V_SALARY EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
    CALC_SAL NUMBER; -- ��������� ����
BEGIN 
    SELECT SALARY, NVL(BONUS, 0)
    INTO V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    CALC_SAL := (V_SALARY + (V_SALARY * V_BONUS)) * 12;
    RETURN CALC_SAL; -- ���������� ��ȯ�ϰ� ���� ��
END;
/

VARIABLE VAR_YSAL NUMBER;

EXEC :VAR_YSAL := BONUS_CALC('&���');
PRINT VAR_YSAL;


--SELECT������ �Լ� ȣ���� ���� ����� ����
SELECT EMP_ID, EMP_NAME, BONUS_CALC(EMP_ID)
FROM EMPLOYEE
WHERE BONUS_CALC(EMP_ID) > 3000000;



------------------------------------------------------------------------------







------------------------------------------------------------------------------
------------------------------------------------------------------------------




------------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------