

/*

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

-----------------------------------------------------------------------
-----------------------------------------------------------------------

<SELECT���� ����>
SELECT
FROM
WHERE 
GROUP BY
HAVING
ORDER BY

<SELECT���� ����>
SELECT : �÷��� AS ��Ī, ����, �Լ���       -> ��ȸ�ϰ��� �ϴ� �÷� ���
FROM : ���̺� ��                           -> �÷��� ���� �ִ� ���̺� ���
WHERE : WHERE �÷���|�Լ��� �񱳿����� �񱳰� -> SELECT�� ���ǽ� ����
GROUP BY : �׷����� ���� �÷���              -> �׷��Լ��� ����� �׷� ���
HAVING : �׷��Լ��� �񱳿����� �񱳰�         -> �׷��Լ��� ���ǽ� ����
ORDER BY : �÷���|��Ī|�÷� ���� ���Ĺ�� [NULLS FIRST | LAST]; -> ���� ���� ���
    - SELECT���� ��Ī�� ��ξ��ٸ�, ��Ī���ε� ���� ����


<�������>
1)FROM : �����ؼ� ���� ���
2)WHERE : ���� �߷����� ���� ���� �÷��鸸 ����
3)GROUP BY
4)HAVING
5)SELECT
6)ORDER BY

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


-- ORDER BY
-- ����
-- �������� ASC / �������� DESC
--   ���� ����  /   ���� �Ұ�
-- ������������ NULL�� �������� ��ġ
-- ������������ NULL�� ù ��ġ

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
--ORDER BY EMP_NAME ASC;   -- �̸����� ��������(ASC)
--ORDER BY EMP_NAME;       -- ASC�� ��������. 
--ORDER BY EMP_NAME DESC;  -- DESC�� ���� �Ұ�. �����
--ORDER BY DEPT_CODE;      -- NULL�� �� �ִ� ���� ���߿� ��ġ�� ���·� ��������
ORDER BY DEPT_CODE DESC NULLS FIRST; -- NULL�� ���� ��ġ �� ��������
ORDER BY DEPT_CODE DESC NULLS LAST;  -- ���������� ���� NULL�� ���߿� ��ġ�ϴ°� �⺻, ���������� ���� NULL�� ���� ��ġ�ϴ°� �⺻

-- ��Ī���� �����غ���
SELECT EMP_ID, EMP_NAME, SALARY �޿�, DEPT_CODE -- �޿� : ��Ī
FROM EMPLOYEE
--ORDER BY SALARY;
ORDER BY �޿�;
ORDER BY �޿� DESC;
ORDER BY 2 DESC; -- 2�� EMP_NAME ����
ORDER BY 3 DESC; --  3�� SALARY�� ���� ��������
-- ����Ʈ�� �������̺��� ���� ����. �׷��� ��Ī�� �о�� �� �ִ� ��. �Ʒ� ������� ����
-- ORDER BY �̿ܿ� ��Ī�� ���� �� �ִ°� ����. �ڵ� �� ���� ���� ����
-- ��Ī�� �÷��� �ƴ϶� ���� �����͸� �����÷��ϴ� ���� : invailid identifier

/*
�������
1)FROM���� �����ؼ� ���� ���
2)WHERE ���ؼ� ���� �߷�����
���� ���� �÷��鸸 ����
3)GROUP BY
4)HAVING
5)SELECT
6)ORDER BY
*/


------------------------------------------------------------------------------
------------------------------------------------------------------------------
--------------------------------GROUP BY--------------------------------------
------------------------------------------------------------------------------


-- GROUP BY
-- �׷��Լ����� ���� ������ �����ϴ� ��
-- �׷��Լ��� ����� �׷� ���


-- �μ� �� �޿� �հ� ��ȸ
SELECT SUM(SALARY), DEPT_CODE -- ERROR : not a single-group group function
FROM EMPLOYEE; -- �� �޼��������� SINGLE�� ������ �׷��� ...?
-- �̱۰� �׷� �Բ� ����� �� ���ٴ� �ǹ� // ����� �ϳ��� ���;��ϴ� �׷��Լ��ε� �������� ������ ���� �� �Լ��� ȥ�� �Ұ�
-- �̱� : SUM(SALARY)
-- �׷� : DEPT_CODE

-- �μ� �� �޿� �հ��Ѵٰ��ϸ� ���� �μ����� �׷���� ���� ��
-- ������ �μ� �׷��� ������ �հ� ���س��ư� ��. 
-- ������ � �͵��� �׷� ������ �˷���� ����� �� �ִ�

-- �� �׷����� ���� �� ���� DEPT_CODE



SELECT SUM(SALARY), DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- DEPT_CODE�� �׷� ���´�
--ORDER BY DEPT_CODE; -- �������� �����ؼ� ���� ������ ORDER BY �߰�



-- EMPYLOEE���̺��� �μ� �� �޿� �հ�, �޿� ���, �ο� ���� ��ȸ
SELECT DEPT_CODE, SUM(SALARY), AVG(SALARY), COUNT(*) -- ERROR : not a single-group group function
FROM EMPLOYEE;
-- DEPT_CODE : �Ϲ� �Լ�
-- SUM, AVG, COUNT�� �׷��Լ�
-- ���� ���� ���� �� �� ����
SELECT DEPT_CODE, SUM(SALARY), AVG(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;  -- �׷�ȭ �� ���� �׷�ȭ�� ������ �Ǵ� �÷��� �����غ���

-- BONUS�� �׷������
SELECT BONUS, SUM(SALARY)�հ�, AVG(SALARY) ���, COUNT(*) ��
FROM EMPLOYEE
GROUP BY BONUS; 
SELECT BONUS, SUM(BONUS), AVG(BONUS), COUNT(*)
FROM EMPLOYEE
GROUP BY BONUS; 
-- �׷��������� ���� �Ϲ��Լ��� ���ƾ��Ѵ�. 
-- GROUP BY�� ���� �÷���� SELECT ������ �÷����� ���ƾ���


-- EMPLOYEE���̺��� �μ��ڵ�� ���ʽ� �޴� ����� ��ȸ
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- ���ʽ��� NULL�̶� 0���� ���


SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL -- ����� � ������? 
GROUP BY DEPT_CODE      -- D2�μ����� ���ʽ� �޴� ����� ���µ� �̰� �ȳ���. ���� ������
ORDER BY DEPT_CODE;

SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
--WHERE BONUS IS NOT NULL -- WHERE���� ������ COUNT(*)�� ������� ī��Ʈ��
GROUP BY DEPT_CODE;  

--EMPLOYEE���̺��� �����ڵ�, ���ʽ��� �޴� ����� ��ȸ
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE90
GROUP BY JOB_CODE;
-- ���ʽ� �ȹ޴� ����� �Ⱥ��� �ʹٸ�, WHERE BONUS IS NOT NULL �߰� 



--EMPLOYEE���̺��� ������ ���� �� �޿� ���(����ó��(���� �����϶�� �ǹ�)), �޿��հ�, �ο� �� ��ȸ(�ο����� ��������)
-- �����Ϳ� ���������� ���� �����͸� GROUP BY�ؼ� ���,�հ�,�� ��ȸ�ؾ���, COUNT(*) �ο���, 
--SELECT SUBSTR(EMP_NO,8,1), FLOOR(AVG(SALARY)), SUM(SALA
SELECT SUBSTR(EMP_NO,8,1), FLOOR(AVG(SALARY)), SUM(SALARY)RY), COUNT(SALARY) �ο���, 
        CASE WHEN SUBSTR(EMP_NO, 8,1) = 1 THEN '��'
             WHEN SUBSTR(EMP_NO, 8,1) = 2 THEN '��'
             END "����"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1) -- ���ڸ� ��ȯ�ϴ� �÷��� ��ü�����ε�
ORDER BY �ο��� DESC;
--ORDER BY 4 DESC;
--ORDER BY COUNT(SALARY)DESC;

-- ��� ���
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'��','��') ����, 
        FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) �ο���
FROM EMPLOYEE
--GROUP BY SUBSTR(EMP_NO,8, 1)
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),1,'��','��')
ORDER BY �ο��� DESC;


-- EMPLOYEE���̺��� �μ� �ڵ庰�� ���� ������ ����� �޿� �հ� ��ȸ
-- �μ���, �� ���޺� 2���� �׷��� �ʿ�
-- ��� ���
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE;
--ORDER BY DEPT_CODE;


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
GROUP BY JOB_CODE; -- ERROR : Only one clause allowed per query block




------------------------------------------------------------------------------
------------------------------------HAVING------------------------------------
------------------------------------------------------------------------------

-- HAVING
-- ������
-- ��� = WHERE
-- ���� WHERE ��� �Ϲ� �÷�
--     HAVING ��� GROUP BY�� ������


-- 1)�μ� �ڵ�� �޿� 3000000�̻��� ������ �׷� �� ��� �޿� ��ȸ
-- 2)�μ� �ڵ�� �޿� ��� 3000000�̻��� �׷� �� ��ձ޿� ��ȸ

-- 1)�μ� �ڵ�� �޿� 3000000�̻��� ������ �׷� �� ��� �޿� ��ȸ
-- ��� ���
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000 
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


-- 2)�μ� �ڵ�� �޿� ��� 3000000�̻��� �׷� �� ��ձ޿� ��ȸ
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000 -- ERROR : group function is not allowed here
GROUP BY DEPT_CODE;

-- ������
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;


SELECT DEPT_CODE, SALARY, AVG(SALARY), COUNT(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, SALARY -- �������� �߰� �׷���. ���� ���� ������� ������ ���� ���̴�?
HAVING AVG(SALARY) >= 3000000;


-- �μ� �� �޿� �հ� �� 900000�� �ʰ��ϴ� �μ��ڵ�� �޿� �հ� ��ȸ
-- ��� ���
SELECT DEPT_CODE, SUM(SALARY) -- �μ��ڵ�� �޿� �հ� ��ȸ�� ����Ʈ�� ��ȸ�� �׸� 2��
FROM EMPLOYEE
GROUP BY DEPT_CODE      -- � �� �׷��� ������ ������?
HAVING SUM(SALARY) > 900000
ORDER BY DEPT_CODE;


------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- ROLLUP, CUBE
-- ���� �Լ� : �׷캰 ������ ������� �����ϴ� �Լ�
-- ���� �Լ��� ���ٴ°� ������ ��������� ������ �������ִ°� �±��� ������µ� �ٵ�
--
-- �Ѿ� ť�� ������
-- �Ѿ��� ���ڷ� ���޹��� �� �� ù��° �ѹ��� ����
-- ť��� ���ڷ� ������ ��� �͵鿡 ���� �߰� ����
--      ex)ROLLUP : GROUP BY�� �׷��ε� ù�׷��� �������� �հ� ��ȯ
--      ex)CUBE : GROUP BY�� �׷��ε� ù�׷��� �������� �հ� ��ȯ�� ��, �ι�° �׷��� �հ� �� ��ȯ

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
--GROUP BY JOB_CODE           -- �� ���� �ڵ庰 �հ� 7��
--GROUP BY ROLLUP(JOB_CODE) -- �Ѿ��̳� ť���ڵ� �߰��� ���� �ϳ� �� ����. ���������� �����ʹ� ����
GROUP BY CUBE(JOB_CODE) --
ORDER BY JOB_CODE;


--EMPLOYEE���̺��� �� �μ��ڵ帶�� �����ڵ� �� �޿� ��, �μ� �� �޿� ��, ���� ��ȸ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;


-- ROLLUP
-- �׷캰�� �߰� ����ó���ϴ� �Լ�
-- ���ڷ� ���޹��� �׷� �� ���� ���� ������ �׷쿡�� �߰� ����ó��
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- CUBE
-- �׷캰 ������ ����� �����ϴ� �Լ�
-- �Ѿ��� ���ڷ� ���޹��� �� �� ù��° �ѹ��� ����
-- ť��� ���ڷ� ������ ��� �͵鿡 ���� �߰� ����

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY JOB_CODE;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------SET OPERATION----------------------------------
------------------------------------------------------------------------------


-- SET OPERATION : ���� ������
-- �� �� �̻��� ���̺��� ������ ������� �ʰ� ������ �����͸� ��ȸ�ϴ� ���

-- ����
-- UNION : ������ OR����
-- INTERSECT : ������ AND����
-- MINUS : ������ A-B
-- ������ ����� ������ ����� �ϳ��� ���� �ش� �Լ��� ����, ����� ��ȯ

-- ������ A OR B
-- ������ A AND B ����и�
-- ������ A - B
-- ������ A B�� ������ ������

-- UNION : ������ OR����
-- INTERSECT : ������ AND����
-- MINUS : ������ A-B
-- UNION ALL : AND���� + OR����(�ߺ��� �� �߰���ȸ)
-- 

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- UNION : ������
-- �� ������ ����� �ϳ��� ���� OR�������� ��ȯ
-- �� ���? WHERE���� ������ �� ���ų� OR�� ó���ϱ� ���� ���
-- UNION ������
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200; -- ������
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201; -- ������
-- UNION ����
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200 
UNION
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201; -- ������ ,������
--�������
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201 OR EMP_ID = 200; -- ������ ,������


-- EMPLOYEE���̺��� DEPT_CODE�� D5�̰ų� �޿��� 300000�� �ʰ��ϴ� 
-- ������ ���, �̸�, �μ��ڵ�, �޿���ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 300000;
-- UNION ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 300000;

------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- INTERSECT : ������
-- ������ ����� ������ ����� �ϳ��� ���� OR���� ����, ����� ��ȯ
-- INTERSECT ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 300000;

--���տ����ڿ��� SELECT ���� �����ؾ� �ǰ� FROM���� �޶� �볪��?
-- ����
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_ID_200
UNION
SELECT JOB_CODE
FROM JOB
WHERE JOB_NAME = '�븮';

------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- MINUS : ������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- DEPT�ڵ尡 D5�̸鼭 ������ 3000000�ʰ��� ����� �����ϴ� �ڵ�

-- UNINON ALL
-- 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------






















------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------









