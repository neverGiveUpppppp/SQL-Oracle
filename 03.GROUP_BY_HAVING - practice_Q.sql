

/*
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
-- �̸����� ��������(ASC)
--ORDER BY EMP_NAME ASC;
-- ASC�� ��������. 
--ORDER BY EMP_NAME;
-- ���������� ���� �Ұ�. ������
--ORDER BY EMP_NAME DESC;
-- NULL�� �� �ִ� ���� ���߿� ��ġ�� ���·� ��������
--ORDER BY DEPT_CODE;
-- NULL�� ���� ��ġ �� ��������
--ORDER BY DEPT_CODE DESC;
--ORDER BY DEPT_CODE DESC NULLS FIRST;
-- ���������� ���� NULL�� ���߿� ��ġ�ϴ°� �⺻, ���������� ���� NULL�� ���� ��ġ�ϴ°� �⺻
ORDER BY DEPT_CODE DESC NULLS LAST;


-- ��Ī���� �����غ���
SELECT EMP_ID, EMP_NAME, SALARY �޿�, DEPT_CODE -- �޿� : ��Ī
FROM EMPLOYEE
--ORDER BY SALARY;
--ORDER BY �޿�;
-- 2�� EMP_NAME ����
--ORDER BY 2 DESC;
-- 3�� SALARY�� ���� ��������
ORDER BY 3 DESC;


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
-- �����͵��� ���ϴ� �׷����� ���� �� ���
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




-- DEPT_CODE�� �׷� ���´�
--ORDER BY DEPT_CODE; -- �������� �����ؼ� ���� ������ ORDER BY �߰�



-- EMPYLOEE���̺����� �μ� �� �޿� �հ�, �޿� ���, �ο� ���� ��ȸ
-- �׷�ȭ �� ���� �׷�ȭ�� ������ �Ǵ� �÷��� �����غ���



-- �׷��������� ���� �Ϲ��Լ��� ���ƾ��Ѵ�. 
-- GROUP BY�� ���� �÷����� SELECT ������ �÷����� ���ƾ���


-- EMPLOYEE���̺����� �μ��ڵ�� ���ʽ� �޴� ����� ��ȸ


-- ����� � ������? 
-- D2�μ����� ���ʽ� �޴� ����� ���µ� �̰� �ȳ���




--WHERE BONUS IS NOT NULL -- WHERE���� ������ COUNT(*)�� ������� ī��Ʈ��

--EMPLOYEE���̺����� �����ڵ�, ���ʽ��� �޴� ����� ��ȸ

-- ���ʽ� �ȹ޴� ����� �Ⱥ��� �ʹٸ�, WHERE BONUS IS NOT NULL �߰� 





--EMPLOYEE���̺����� ������ ���� �� �޿� ���(����ó��(���� �����϶�� �ǹ�)), �޿��հ�, �ο� �� ��ȸ(�ο����� ��������)
-- �����Ϳ� ���������� ���� �����͸� GROUP BY�ؼ� ���,�հ�,�� ��ȸ�ؾ���





-- EMPLOYEE���̺����� �μ� �ڵ庰�� ���� ������ ����� �޿� �հ� ��ȸ
-- �μ���, �� ���޺� 2���� �׷��� �ʿ�
-- ��� ���



 -- ERROR : Only one clause allowed per query block




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



-- 2)�μ� �ڵ�� �޿� ��� 3000000�̻��� �׷� �� ��ձ޿� ��ȸ


-- ������





-- �μ� �� �޿� �հ� �� 900000�� �ʰ��ϴ� �μ��ڵ�� �޿� �հ� ��ȸ
-- ��� ���



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


--EMPLOYEE���̺����� �� �μ��ڵ帶�� �����ڵ� �� �޿� ��, �μ� �� �޿� ��, ���� ��ȸ



-- ROLLUP


-- CUBE
-- �׷캰 ������ ����� �����ϴ� �Լ�
-- �Ѿ��� ���ڷ� ���޹��� �� �� ù��° �ѹ��� ����
-- ť��� ���ڷ� ������ ��� �͵鿡 ���� �߰� ����



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------SET OPERATION----------------------------------
------------------------------------------------------------------------------


-- SET OPERATION : ���� ������
-- �� �� �̻��� ���̺����� ������ ������� �ʰ� ������ �����͸� ��ȸ�ϴ� ���

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
-- �� ������ ����� �ϳ��� ���� AND�������� ��ȯ
-- �� ���? WHERE���� ������ �� ���ų� OR�� ó���ϱ� ���� ���
-- UNION ������

-- UNION ����

--�������



-- EMPLOYEE���̺����� DEPT_CODE�� D5�̰ų� �޿��� 300000�� �ʰ��ϴ� 
-- ������ ���, �̸�, �μ��ڵ�, �޿���ȸ

-- UNION ����


------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- INTERSECT : ������
-- ������ ����� ������ ����� �ϳ��� ���� OR���� ����, ����� ��ȯ
-- INTERSECT ���


--���տ����ڿ��� SELECT ���� �����ؾ� �ǰ� FROM���� �޶� �볪��?
-- ����


------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- MINUS : ������

-- DEPT�ڵ尡 D5�̸鼭 ������ 3000000�ʰ��� ����� �����ϴ� �ڵ�

-- UNINON ALL
-- 



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------






















------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------








