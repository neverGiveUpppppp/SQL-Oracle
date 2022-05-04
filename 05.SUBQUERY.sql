`
/*

<SELECT�� ������� �� �������>
1. FROM ���̺�� - ��ȸ ��� �÷��� �ִ� ���̺�� ���
2. WHERE �÷��� ������ ���� - ���� �����ϴ� ������ ���
3. GROUP BY �÷��� } ���� - �׷칭�� �÷���, ���� ���
4. HAVING �׷��Լ� ������ �񱳰� - �׷칭�� ������ �׷��Լ��� ����� ������ ���� ���Ǳ��
5. SELECT * | [DISTINCT] �÷���, ���� [AS] ��Ī
6. ORDER BY �÷��� | ��Ī | �÷����� [ASC] | DESC

------------------------------------------------------------------------------
------------------------------------------------------------------------------


05.SUBQUERY
���� ������ ���� '��������'�� �ϴ� ����

���� �ȿ� ������ �����ִ� ����


��ȣ : �Ұ�ȣ()


�������� ����
1)���� �� ��������
2)���� �� ��������
3)���� �� ��������
4)���� �� ���� �� ��������
5)��� ��������, ��Į�� �������� <- ��׵��� �߸���


�������� ��ġ
1)WHERE��
2)FROM��


*/

/*
����
�ζ��� ��, ��Į�� ��������, ��Ÿ

SELECT���� �ۼ��� �Ǹ� ��Į�� ��������
FROM���� �ۼ��Ǹ� �ζ��� �� ��������
*/    
    
-- �μ��ڵ尡 ���ö ����� ���� �Ҽ��� ������� ��ȸ
-- SUBQUERY ����
-- 1)������� ���ö�� ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; -- D9

--2) D9�μ��ڵ忡 �����ִ� ���� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; -- ������ ������ ���ö
-- 1)2)�� ���ļ� �ѹ��� �غ� ��


-- SUBQUERY ����
-- ���������� �ñ��� ���� ����������
-- ����� ��� ���� ���� ������ ���������� �־��Ѵ�
-- �������� 2�� �������� 1��
SELECT EMP_NAME  --�ñ��� ������ ���κ��� �ۼ�
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D9' -- �������� �˻��ؼ� D9�� �˾����� ������ D9��°� �𸣱� ������ ���ö����� �μ��ڵ带 �޾ƿ� �� �ִ� �ڵ带 �־���Ѵ�
WHERE DEPT_CODE = (SELECT DEPT_CODE         -- ORA-00936: missing expression
                    FROM EMPLOYEE           -- �������� ���� �˸��� ���� �Ұ�ȣ�� ������Ѵ�
                    WHERE EMP_NAME = '���ö'); -- ������ ������ ���ö
                

-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ ���, �̸�, �����ڵ�, �޿� ��ȸ
-- 1)�� ������ ��� �޿��� ���� �˾ƾ��Ѵ�
-- 2) ��� ���� ���� �޴� ���� ��ȸ

--1)�� ������ ��� �޿��� ���� �˾ƾ��Ѵ�
SELECT AVG(SALARY)
FROM EMPLOYEE;  -- 3047662.60869565217391304347826086956522

-- 2) ��� ���� ���� �޴� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522; -- 9��
--WHERE SALARY >AVG(SALARY); -- ERROR

-- 3) 1)+2)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE); -- 8��

------------------------------------------------------------------------------
------------------------------------------------------------------------------
/*
�������� ����
1)���� �� ��������
2)���� �� ��������
3)���� �� ��������
4)���� �� ���� �� ��������
5)��� ��������, ��Į�� �������� <- ��׵��� �߸��󵵵�



1)���� �� �������� : ���������� ��� ���� 1���� ��(�� �ϳ�)
2)���� �� �������� : ���������� ��� ���� ������ �� ��
3)���� �� �������� : ���������� SELECT���� ������ �׸� ���� �������� �� (���� ���̶�°� �÷��� �������� �ǹ�)
4)���� �� ���� �� �������� : ��ȸ ��� �� ���� �� ���� ���� ���� ��
5)��� ��������, ��Į�� �������� <- ��׵��� �߸��󵵵�


EX)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE); -- 8��
-> ���� �� �������� 
��ü ������ ����� �ƴ� ���������������� ��� ���� �����̱⿡ 1���̹Ƿ� ���� �� ��������

*/

------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 1)���� �� ��������
--�Ϲ� �����ڸ� ���� ���
--�������� ������ WHERE���� �÷���� �������� �� SELECT�� �÷��� ��ġ �ʼ�

-- ���ö ����� �޿����� ���� �޴� ������ ���, �̸�, �μ��ڵ�, �����ڵ� , �޿� ��ȸ
--1) ���ö ����� �޿�
--2) ���� �޴� ������ ���, �̸�, �μ��ڵ�, �����ڵ� , �޿�

--1) ���ö ����� �޿�
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; -- 3700000

--2) ���� �޴� ������ ���, �̸�, �μ��ڵ�, �����ڵ� , �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3700000;

-- 3) 1)+2)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY -- WHERE SALARY�� �������� �� SELECT�� SALARY�� ���ƾ��Ѵ�. �÷��� ��ġ �ʼ�
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö'); -- 4�� : 200	������	D9	J1	8000000


SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE); -- 8��



-- ���� ���� �޿��� �޴� ������ ���, �̸�, �����ڵ�, �μ��ڵ�, �޿�, �Ի��� ��ȸ
--1)���� ���� �޿�
--2)���� ���� �޿��� �޴� ����
SELECT MIN(SALARY)
FROM EMPLOYEE; -- 1380000

SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE); -- 214	����	J7	D1	1380000	10/04/04


-- �μ� �� �޿� �հ� �� ���� ū �μ��� �μ���, �޿� �հ�
--1)�޿� �հ谡 ���� ū �μ�
--2)�޿� �հ谡 ���� ū �μ��� �μ���, �޿� �հ�

--1)�μ��� �޿� �հ�
SELECT MAX(SUM(SALARY)) -- ���μ��� �հ踦 SUM(SALARY)�� ���ϰ� ���� ���� ũ�ٴ� ������ MAX�� ó��
FROM EMPLOYEE
GROUP BY DEPT_CODE;     -- 17700000

--2)�޿� �հ谡 ���� ū �μ��� �μ���, �޿� �հ�
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE -- ������ �׷쿡�� �޿� �հ� ������ �ɱ� ���� HAVING
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE); -- �ѹ���	17700000
                      
 
    
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- 2)������ �������� 
 �Ϲ� ������ ���
 ������ ������������ ����ϴ� �����ڸ� ����ؾ���
 IN / NOT IN : ���� �� ��� �� �� �ϳ��� ��ġ�ϴ� ���� �ִٸ�/���ٸ�
 > ANY, < ANY : ���� �� ��� �� �� �ϳ��� ū/���� ��� ->���� ���� ������ ũ�⸸ �ϸ�ȴ�/�ִ밪���� �۳�
 > ALL, < ALL : ��� ������ ū/���� ��� -> �ִ밪���� ũ��/�ּҰ����� �۴�?                 // > <ũ�� �۴� �ǹ�
 EXISTS/ NOT EXISTS : ���� �����ϴ�/�������� �ʴ� ���

-- ���� ����� IN�� ���� IN
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID IN(200,201,202,205);



-- �μ��� �ְ� �޿��� �޴� ������ �̸�, �����ڵ�,�μ��ڵ� �޿� ��ȸ
--1)�μ��� �ְ� �޿�
--2) 1)�� �̿��Ͽ� �μ� �� �ְ� �޿� �޴� ������ ���� ��ȸ

--1)�μ��� �ְ� �޿�
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--2) 1)�� �̿��Ͽ� �μ� �� �ְ� �޿� �޴� ������ ���� ��ȸ
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)-- ���������� ���� ��
                FROM EMPLOYEE
                GROUP BY DEPT_CODE); -- 7��

-- �����ڿ� �Ϲ� ������ �ش��ϴ� ��� ���� ���� : ���, �̸�, �μ���,����,����(������/����)
--1)�����ڿ� �ش��ϴ� ��� ��ȣ ��ȸ
--2)�����ڿ� �ش��ϴ� ���� ����
--3)����� �ش��ϴ� ���� ���� ��ȸ
--4) 2,3�� ���ľ��Ѵ�


--1)�����ڿ� �ش��ϴ� ��� ��ȣ ��ȸ
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL; -- NULL�� �ʿ���⿡ ����

--2)�����ڿ� �ش��ϴ� ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) -- DEPT_TITLE�� NULL�� ������ �ȳ����� �ܺ����� �߰� �ʿ���
    JOIN JOB USING(JOB_CODE) -- ����� �ٳ����⿡ ���������� ���� ������
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL); -- 6��

--3)����� �ش��ϴ� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '���' ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
    JOIN JOB USING(JOB_CODE) 
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID -- ������ �ƴϸ� �������� �Ϲ� ������״� NOT IN���� ó��
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL); -- 17��
                        
 --4) 2,3�� ���ľ��Ѵ�
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);
UNION -- OR �Ἥ �ٲ� ���� �ְ����� ��û �������״� �����ϰ� UNION���� �ذ�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '���' ����
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
    JOIN JOB USING(JOB_CODE) 
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID -- ������ �ƴϸ� �������� �Ϲ� ������״� NOT IN���� ó��
                        FROM EMPLOYEE
                        WHERE MANAGER_ID IS NOT NULL);

-- SELECT������ ���������� �� �� �ִ�
-- CASE WHEN ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
        CASE WHEN EMP_ID IN(SELECT DISTINCT MANAGER_ID
                                    FROM EMPLOYEE
                                    WHERE MANAGER_ID IS NOT NULL) THEN '������'
            ELSE '����'
        END ����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE); -- 23��


-- �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ������ ���, �̸�, ����, �޿� ��ȸ
--1)�븮 ����
--2)���������� �ּұ޿�
--3)���������� �ּұ޿����� ���� �޴� ��������

----1)�븮 ����
--SELECT JOB_CODE, JOB_NAME
--FROM JOB
--WHERE JOB_CODE = 'J6';
--
----2)���������� �ּұ޿�
--SELECT SALARY, MIN(SALARY)
--FROM EMPLOYEE, G
--GROUP BY JOB;

-- ��� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='�븮'
    AND SALARY > (SELECT MIN(SALARY)
                        FROM EMPLOYEE
                                JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '����'); -- 5��


-- �ּұ޿����� ũ�� -> ANY�� ǥ�� ����
-- ��� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
    AND SALARY > ANY(SELECT SALARY -- ANY ���
                    FROM EMPLOYEE
                        JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '����'); -- 5��

                        
-- ���� ������ �޿� �� ���� ū ������ ���� �޴� ���� ������ ���, �̸�, ����, �޿� ��ȸ
-- �Ϲݿ����� ���� �ۼ�
--1) ���� ������ �ִ� �޿�
--2) ���� ���� �޴� ���� ������ ����

----1) ���� ������ �ִ� �޿�
--SELECT MAX(SALARY)
--FROM EMPLOYEE
--GROUP BY JOB_CODE
--HAVING JOB_CODE = 'J4'; -- 2800000

-- ��� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
        AND SALARY > (SELECT MAX(SALARY)
                        FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '����'); -- 215	���ȥ	����	3760000

-- ���� ū������ ũ�� -> ALL ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
        AND SALARY > ALL (SELECT SALARY
                        FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '����'); -- 215	���ȥ	����	3760000





------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- ���� �� ��������

-- ���������� SELECT���� ������ �׸� ���� �������� �� (���� ���̶�°� �÷��� �������� �ǹ�)



-- ����� �������� ���� �μ�, ���� ���޿� �ش��ϴ� ����� �̸�, ���� �ڵ�, �μ��ڵ�, �Ի��� ��ȸ
--1)����� �������� �μ�, ����
--2)�̿� �ش��ϴ� ��� ����

--1)����� �������� �μ�, ����
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO,8,1) = 2; -- 1�� 2�� : D8	J6 <- ���� �������� ���� ��
        
--2)����� �������� ���� �μ�/����((D8/J6)�� �ش��ϴ� ��� ���� ��ȸ
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2) -- 3�� 4�� // �� �� �Ѹ��� ����� ������. ��������.
    AND EMP_NAME != (SELECT EMP_NAME -- ����� ������ ���� ���� �ڵ�
                    FROM EMPLOYEE
                    WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8,1)=2); -- 2�� 4�� // ������	J6	D8	15/06/17 ������	J6	D8	12/12/12


-- �ٸ� ����
-- ���� �μ�, ����
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2)
        AND JOB_CODE = (SELECT JOB_CODE
                        FROM EMPLOYEE
                        WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2)
        AND EMP_NAME != (SELECT EMP_NAME
                        FROM EMPLOYEE
                        WHERE ENT_YN = 'Y' AND SUBSTR(EMP_NO, 8, 1) = 2); -- 2�� 4�� : ������	J6	D8	15/06/17 ������	J6	D8	12/12/12




------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- ���� �� ���� �� ��������

-- ��ȸ ��� �� ���� �� ���� ���� ���� ��

-- �ڱ� ������ ��� �޿��� �ް� �ִ� ������ ��� �̸�, �����ڵ�, �޿� ��ȸ
-- ��, �޿� ����� �ʸ��� ������ ��� : TRUNC(�÷���, -5)
--1)�ڱ� ������ ��� �޿�
--2)�� �������� ��� �̸�, �����ڵ�, �޿� ��ȸ

--1)�ڱ� ������ ��� �޿�
-- ���� ��� �޿��� �ڱ� �޿��� �´����� Ȯ���ʿ�
SELECT JOB_CODE, TRUNC(AVG(SALARY),-5)
FROM EMPLOYEE
GROUP BY JOB_CODE;


--2)�� �������� ��� �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY),-5)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE); -- 2�� 4�� : 210	������	J7	2000000



------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- �ζ��� �� 
--FROM���� �������� ����ϴ� ��
-- ���� ��

-- �ζ��� �� ����
SELECT *
FROM(SELECT EMP_NAME, SALARY, BONUS -- FROM�� �������� = �ζ��� ��
     FROM EMPLOYEE);

-- SELECT *�� ��ü ��ȸ���ص� FROM������ ������ �Կ��� ���ϴ� �͸� �����͸� SELECT *�� ������ ��ü�� �� ������ �ʴ´�


-- ROWNUM
-- ���� ����
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; 
-- ROWNUM�� ��� ����Ʈ���� ���� �ִ�.
-- ���� ����� �� ���ʿ� �ߴ� 1 2 3 ���ڵ��� ���� �̰� �ʹٸ�(?)
-- ROW NUM ���
-- ��ȸ�� �࿡ ���� 1���� ��ȣ�� �Ű�����(�� ��ȣ)


--������ ORDER BY ���� ������� �ʴ´ٸ�, ���������� ROWNUM�� ������ ���� ����
--ROWNUM�� ���������� �̹� �ο����� ���̱� ������ ORDER BY ���� ���� ������ �ٲٴ��� ���� ������ �ʴ´�
-- ex)
SELECT ROWNUM, EMP_NO, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;




-- �� ���� �� �޿��� ���� ���� 5���� ����,�̸�, �޿� ��ȸ
--1) �޿� ���� 5��

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE 
WHERE ROWNUM <= 5
ORDER BY SALARY DESC; -- 5�� ���
-- ROWNUM�� �������� ������ �ȵǾ� �ִ�. ���� SALARY�� �ߵǾ�����

-- WHERE�� ���� ���̴�?
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE 
ORDER BY SALARY DESC; -- 23�� ���
-- 5��� 23�� ��� �׸��� ���� ���� �ȸ���. 
-- WHY?
-- ROWNUM�� ��ȣ�� �Ű��ִ°ǵ� FROM������ ��ȣ�� �ű�� �ڡڡڡڡ�
-- ���� �� �򸮰� ROWNUM�� �̶� ������

/*
SELECT���� �������
1)FROM : �Ǳ��
2)WHERE : ����
3)GROUP BY
4)HAVING
5)SELECT
6)ORDER BY

���� �򸮸� ROWNUM�� ������
SALARY ���� �������� ����
�ο���� �̹� �����ǰ� ORDER BY�� ���� ������ �������̶� �ο�� ���� �� �ٽ� �������ϱ⿡
�ο���� ���� �� �ۿ� ����
�ο���� �̿��ҷ��� �������������� �����Ƿ� �������������� �޿��� ���������� �Ǿ��ֵ��� �������� �ٲٸ� �ȴ�
�̶� �ζ��� �並 �̿��ؼ� �������� ���������� ������༭ �ذᰡ��

�ζ��κ�� 1ȸ���� ���������̴�. ���� FROM������ ����ϸ�, 
���̺�ó�� ����ϸ� �ȴ�.

���� ��� �̷��� �ο�� �ʼ�
���������� �ο��� ����
->�׷� ���ؾ��ұ�?
->���������� �޿��� ���� // ���� ���� ���ϴµ��� �̸� ����ִ� �� // 4:00-4:10 ���ǽð�

*/
-- �ζ��� �� ����
SELECT *
FROM(SELECT EMP_NAME, SALARY, BONUS -- FROM�� �������� = �ζ��� ��
     FROM EMPLOYEE);

-- SELECT *�� ��ü ��ȸ���ص� FROM������ ������ �Կ��� ���ϴ� �͸� �����͸� SELECT *�� ������ ��ü�� �� ������ �ʴ´�
-- 

-- ���ǽð�
-- 4:13-20
SELECT *
FROM(SELECT EMP_NAME �̸�, SALARY, BONUS -- FROM�� �������� = �ζ��� ��
     FROM EMPLOYEE --23��
     WHERE EMP_NAME LIKE '%��%')
WHERE EMP_NAME = '������';
--WHERE �̸� = '������';
--WHERE EMP_ID = 201; -- ERROR

SELECT SALARY, �̸�
FROM(SELECT EMP_NAME �̸�, SALARY, BONUS -- FROM�� �������� = �ζ��� ��
     FROM EMPLOYEE --23��
     WHERE EMP_NAME LIKE '%��%')
WHERE �̸� = '������';




-- �� ���� �� �޿��� ���� ���� 5���� ����, �̸�, �޿� ��ȸ
SELECT ROWNUM, *    -- ERROR : ORA-00936: missing expression // ���ʿ� ���� �� ���� ����
FROM(SELECT EMP_NAME, SALARY -- �÷��� �ʹ� ������ �ƽ�Ʈ�� ����� ���� ��� �ұ�?
    FROM EMPLOYEE 
    ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

SELECT ROWNUM, MYFROM.*           -- ��Ī ����ϸ� �ƽ�Ʈ��* ��밡��
FROM(SELECT EMP_NAME, SALARY      -- �÷��� �ʹ� ������ �ƽ�Ʈ�� ����� ���� ��� �ұ�?
    FROM EMPLOYEE 
    ORDER BY SALARY DESC) MYFROM  -- ��Ī ����ϸ� �ƽ�Ʈ��* ��밡��
WHERE ROWNUM <= 5;  -- 5�� : �ο��&�޿� �� �� ���ĵ�


-- ��� ���
SELECT ROWNUM, EMP_NAME, SALARY
FROM(SELECT EMP_NAME, SALARY
     FROM EMPLOYEE
     ORDER BY SALARY DESC )
WHERE ROWNUM <= 5;
-- ��Ī �߰�
SELECT ROWNUM ����,�̸�,�޿�
FROM(SELECT EMP_NAME �̸�, SALARY �޿�
     FROM EMPLOYEE
     ORDER BY �޿� DESC )
WHERE ROWNUM <= 5;

 -- �ȿ� �ִ� �÷� �ϳ��ϳ� �������ص� �Ǵ� ���
SELECT ROWNUM, EMP_NAME , SALARY
FROM(SELECT  * -- �������� SELECT * ó��
     FROM EMPLOYEE
     ORDER BY SALARY DESC )
WHERE ROWNUM <= 5;


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
/*
-- RANK() OVER / DENSE_RANK() OVER
������ �ű�� �Լ�
-- ���� ������ ������ �ű���� OVER�ڿ� ���. RANK()�� ����� ��

 ���� ����
 �������� ���Ŀ� ������ȣ ����
 RANK() OVER : ������ ���� ������ ����� ������ �ο� ����ŭ �ǳʶٰ� ���
      ex)19�� 2�� ���� ���� ��� 21��
 DENSE_RANK() OVER : �ߺ��Ǵ� ���� ������ ����� �ٷ� ���� ����� ���
      ex) 19�� 2�� ���� ���� ��� 20��

*/

-- RANK() OVER
SELECT RANK() OVER(ORDER BY SALARY DESC) ����, EMP_NAME, SALARY -- ���� ������ �����ڿ� ���
FROM EMPLOYEE; -- 23�� : 1	������	8000000
-- FROM������ ��밡��. ���� �ζ��κ並 �����  �ʿ�X
-- 19�� 2�� ���� ���� ��� 21��

------------------------------------------------------------------------------


-- DENSE_RANK() OVER
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) ����, EMP_NAME, SALARY
FROM EMPLOYEE;
-- 19�� 2�� ���� ���� ��� 20��











------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------







