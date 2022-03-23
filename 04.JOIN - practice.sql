/*

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


-- 04.JOIN �ڡڡ�


---- <JOIN�� �ʿ伺> ----
-- ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;
-- Q.���������� � �μ��� �����ֳ���? 
-- A.D5��. �ٵ� D5�� ���� �μ��ϱ�? 
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT; -- D1-9���� �μ� Ÿ��Ʋ ��ȯ
-- �ؿܿ���1��
-- ���� ������ ���� ��ȸ�ϱ⿡ ����
-- EMPLOYEE ���̺� ������� ���� ���ϴ� ������ �� ��Ⱑ ��ƴ�

/*
JOIN�̶�?
�ϳ� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���� ���
�������� ���̺���� �����Ͽ� �����͸� ��ȸ



<JOIN ���� ����>
1.���� ����
�����Ͱ� ������ �κС����� ����
���� Ư�� ������ �ش����� �ʴ� �����ʹ� �����ϰ� ��ȯ��
    1)����Ŭ ���뱸�� 
        FROM���� �ش� ���̺� ��� ���
        ���̺��� �����ϴ� �κ��� WHERE�� ���� ����
    2)ANSI ǥ�ر���
        FROM���� �ش�Ǵ� ���̺� ��� ���
        JOIN ���� �̿� 
            JOIN + ON : �� �����Ͱ��� �ٸ� �̸��� ��
            JOIN + USING : �� �����Ͱ��� ���� �̸��� ��
            but, �̸��� ������ JOIN + ON ��밡��

2.�ܺ� ����
�����Ͱ� ���� ���� �൵ ���ο� ����
���� ������ ���� �����͸� �����ϴ� Ư������ ���ʸ� �����ϴ� �����͸� �� ���� �� �� �ְ� �� ����
    1)����Ŭ ���뱸��
        �����ִ� ���̺�(������ �ƴ� ���̺�)�� �÷� �ʿ� (+)
    2)ANSI ǥ�ر��� : �� �� LEFT, RIGHT ������
        LEFT OUTER JOIN
        RIGHT OUTER JOIN
        FULL OUTER JOIN : ���� �� ����
        (OUTER)�� ���� ����


*/

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--1.��������(Inner join)
--    1)����Ŭ ���� ����
--          �÷����� ������ ��� ���̺� �÷����� ����������� : ���̺��.�÷������� ����
--    2)ANSI ǥ�� ����
--          ���� ������ �÷��� �̸��� �ٸ� �� = ON ���
--          ���� ������ �÷��� �̸��� ���� �� = USING ���
--               �÷� �̸��� ���ٰ� �ؼ� ������ USING ���? X  


-- ���, �̸�, �μ��ڵ�, �μ���
-- ����Ŭ ���� ����

SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID -- ����� 21��. �μ��ڵ尡 NULL�� ������ ���ܵ�. INNER JOIN�� �Ѱ�. 
ORDER BY DEPT_ID;         -- OUTER JOIN���� ���� ����


-- ANSI ǥ�� ����
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE              
    JOIN DEPARTMENT; -- ERROR : missing keyword

SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE               -- ����Ŭ ���뱸���� ����
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); -- JOIN�� ON ��Ʈ�� ���̽����
                                             -- WHERE���� �������ΰ� ������


-- ���, �����, �����ڵ�, ���޸� // �� ����� ���� ���޸� ��ȸ
-- ����Ŭ ���� ����
-- ANSI ǥ�� ����
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);


-- ��� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE,JOB_NAME
FROM EMPLOYEE, JOB     /*JOB.JOB_CODE�� ����*/               
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;  -- 23�� // 200	������	J1 

 
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE 
    JOIN JOB ON(EMPLOYEE.JOB_CODE = JOB.JOB_CODE);
             /*JOB.JOB_CODE�� ����*/
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
    JOIN JOB USING(JOB_CODE); -- USING���� ��ü ����
                              -- USING�� ���� �÷��� ���ٴ°� ����ϱ⿡ ���̺� ����ʿ�X


-- ���̺�� EMPLOYEE�� �� ��Ī�� �����ؼ� ����غ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_NAME
FROM EMPLOYEE E, JOB J    /*JOB.JOB_CODE�� ����*/               
WHERE E.JOB_CODE = J.JOB_CODE;

-- �μ���� �ش� �μ��� ������ ��ȸ
-- ����Ŭ ���� ����
-- ANSI ǥ�� ����


-- ������
SELECT DEPT_TITLE,  LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
     JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

---RE
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
    JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE);




------------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------2.�ܺ�����(Outer join)-----------------------------
------------------------------------------------------------------------------
/*
���� ������ �Ѱ�
��Ī�� �ȵǴ� ���� ������ �����ؼ� ������ �� ���� �Ѱ�
�������� ������ ��ġ�ϴ� ���� �������� ��

 2.�ܺ�����(Outer join)
 �÷� ���� ��ġ���� �ʴ� �൵ ���ο� ���Խ�Ŵ
 �ƿ��� ������ ������ ����ؾ���. �̳����ΰ� �򰥸� �� �ֱ� ����

�ھ��� ���̺��� ��Ī�� ������ + �������� ���ϴ� ���� ������ �����͡�

����
1.LEFT (OUTER) JOIN
2.RIGHT (OUTER) JOIN
3.FULL (OUTER) JOIN
    - ����Ŭ ������ Ǯ�ƿ��� ���� ���Ұ�
- (OUTER) : ��������
    

*/ 

-- INNER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); -- 21�� : DEPT_CODE�� NULL�� ����� ����(��ĪX)
    

--1.LEFT (OUTER) JOIN

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- DEPT_ID(+)
-- �������� �Ǵ� ���̺��� �ƴ� JOIN�Ǵ� ���̺� (+) �߰�

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE -- ���� : EMPLOYEE ���̺�
    LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 23�� : NULL 2�� -> 22 �̿��� 23 �ϵ��� NULL


-- �������ΰ� ����
-- �������ο����� �μ��ڵ尡 NULL�� ������ ���ܵǰ� 21�� ��������
-- LEFT OUTER JOIN�� NULL�� ���� 2�� �����߱⿡ 23�� ���
 
/* 
�� �������� ���ʿ� �ִ� �긦 �������� ��ڴ�
�� EMPLOYEE�� ����
����Ʈ�� �������� �����ִ� ��. 
�׷��� ����Ŭ ���뱸������ ǥ�Ⱑ �������� �Ǵ� ���̺��� �ƴ� �����ϴ� ���̺�(+) ����
ex)WHERE DEPT_CODE = DEPT_ID(+);


<����� ����>
--����Ʈ ����Ʈ ���� �������� �����̸� ���÷��� �������̸� ����Ʈ
--����Ʈ�� ������ �����̶� ���÷��� ���θ� �����(23����). �������� �ϸ� �ϵ���,�̿��� �ȳ���.
--������ �����̶� NULL���� ����� ����
--����Ʈ�� ���� ���������->23������ ���� �� �ֵ��� 

<���� �� ����>
����Ʈ ����Ʈ ���� �������� �����̸� ���÷��� �������̸� ����Ʈ
���÷��̿��� EMP_NAME���� ����� �������µ� �̰� 23���̰�,
���Ŀ����� DEPT_TITLE���� �μ��� �������µ� �̰� 21��. �μ������� ������ 2����
NULL�� �����µ� ���� �����̶� 23�� ��������ϴ� �μ����� ���� 2���� NULL�� ǥ��

 
Q.EMPLOYEE�ȿ� DEPT_CODE�� �����ϱ� DEPT_CODE�ȿ� NULL�� �־ �ϴ� ����, 
  DEPARTMENT�� DEPT_CODE�� ���缭 ���°���,,?
A.YES

*/

 
 
--2.RIGHT (OUTER) JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT     -- ������ : DEPARTMENT ���̺�
WHERE DEPT_CODE(+) = DEPT_ID; -- EMPLOYEE�� DEPT_CODE�� (+)�߰�
                              -- �����ִ� ������ (+)�� �߰���Ű�� ��. �� ������ �ƴ� �ʿ� �߰�
-- 24�� ��� : (NULL) �ؿܿ���3�� (NULL) �����ú� (NULL) ����������
-- NULL 3��

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    RIGHT OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);--24���� // NULL 3�� ����
       -- OUTER ��������
       
---RE
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;
       
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
       
/*
Q.
�״ϱ� �����������δ� ���� �������̺� ��ġ�ϴ� ���� �����Դµ�
�� ������ AND �����̾��µ�
����Ʈ�� ����Ʈ�� �� ���̺� �� �ϳ��� ���Ǹ� �¾Ƶ�
�����´ٴ°Ű� �ٽ� ���� �³���?
A. �������� �ƴ� ��Ī�����ִ� ����
�ھ��� ���̺��� ��Ī�� ������ + �������� ���ϴ� ���� ������ �����͡�
���� ����ؼ� 23��,24�� ����
LEFT�� ���� �������̶��ؼ� employee �����°Ű�
RIGHT�� ������ department�� �������� ��Ƽ� 21�ຸ�� ���� �� ����
*/


--3.FULL (OUTER) JOIN
-- �� �� ������ �ȴ�
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE(+) = DEPT_ID(+); -- ERROR :  a predicate may reference only one outer-joined table
-- ����Ŭ �������δ� ������ �ϳ��� ���� �� �־� Ǯ�ƿ��������� ���Ұ�


SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); --26���� //NULL3��//
                                    -- �μ��� ������������ ��� + �μ��� ������ ���� �μ��� ����
-- 26�� ��� : 
-- LEFT�� �μ������ȵ� 22�̿���23�ϵ��� NULL ������ + RIGHT�� �μ��� �ְ� ���� ���� 
-- (NULL) �ؿܿ���3��,�����ú�,�����������ؼ� 
-- �������� ��� 21�࿡ LEFT 2��+ RIGHT 3�� = 21+2+3= ��26��


---RE
-- ����Ŭ ���뱸��
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);
-- ANSI ǥ�ر���
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-------------------------------�ٸ� JOIN ����----------------------------------
------------------------------------------------------------------------------

/*
�ٸ� JOIN ����
���� ����, ���� ����(CROSS JOIN = CARTESIAN PRODUCT), �� ����(NON-EQUI JOIN), ��ü(SELF) ���� �� �ִ�.
���� ������ ���� �߿��ϰ� ���� ���
�������� ���� �Ⱦ���, ��ü(SELF)������ �ɽ�ġ �ʰ� ���δ�


����,�ܺ� ���� = � ����
�����Ͱ� ���� �κг��� �����ؼ� ���⿡ � ����

�� ���? 
��ġ�� �߿䵵�� ����


<�� ����>
ũ�� �۴� > <�� ���� � ���� �ȿ� �� �ְԲ� �ϴ°� �� ����

���� : EMPLOYEE TABLE�� SAL_GRADE.SAL_LEVEL�� ����
        (SAL_GRADE �÷� �ȿ� SAL_LEVEL�����Ͱ� ���ٸ�?)
���� : EMPLOYEE TABLE�� SAL_GRADE.SAL_LEVEL�� ���ٴ� �����Ͽ� 
        �޿� ����� ���� �ʹ�
SAL_GRADE�ϰ� ������ ����
*/

SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL
FROM EMPLOYEE
    JOIN SAL_GRADE ON(SALARY >= MIN_SAL AND SALARY <= MAX_SAL);
-- ������ ���� ������⿡ �� ����
--    JOIN SAL_GRADE ON(SALARY BETWEEB MIN_SAL AND MAX_SAL); -- BETWEEN AND�� ��ü����

---RE
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE S
WHERE SALARY >= S.MIN_SAL AND SALARY <= S.MAX_SAL;
-- ����Ŭ ������ �� ���� �ȵ�?
========================
========================


------------------------------------------------------------------------------
------------------------------------------------------------------------------

/*
<��ü(SELF) ����>
��ü(SELF)���� : ���� ���� ���̺� �����ϴ� ��

���� : �ϳ� �̻��� ���̺��� �����ؼ� ��ȸ�ϴ� ��
    - ��ü ���� ������ �ϳ� �̻��̶�� �� ��. ���ݱ��� ���� �� 2��������


*/

-- �� ������� ������ ��ȸ
-- EMP ���̺��� EMP_ID�� MANAGER_ID üũ�غ���
-- Ǯ�� ����
SELECT EMP_ID, EMP_NAME ����̸� , DEPT_CODE, MANAGER_ID, EMP_NAME �������̸�
--FROM EMPLOYEE;
FROM EMPLOYEE, EMPLOYEE; -- ���� �����̶� ���� �ϳ� �� �߰�
-- ORA-00918: column ambiguously defined
-- EMP_ID, EMP_NAME �� ���� ���̺��� 2���� ��ȣ�� �� �ۿ�. 
-- �ذ�å : �÷��� ��� ���̺����� ������ ���߰��� -> ��Ī
--   �� �� ��   
SELECT E.EMP_ID, E.EMP_NAME ����̸� ,E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME �������̸� -- ��� ���ؿ��� ���� �����ڸ� �� ���� E.�� ���δ�
-- ����� ���� + �ش� ����� ����ϴ� �Ŵ���ID����̶� ��������� E.�̰� ���⿡ �߰��� �ų����� �̸��� ���̴°ű⿡ M.MANAGER_ID �߰�
FROM EMPLOYEE E, EMPLOYEE M; -- E.EMPLOYEE�� ����� ���� // M.EMPLOYEE�� �������� ����
-- ������ ��� ��� ����� ��ȯ��. ������ WHERE�� �߰�����

-- ��� ���
-- ����Ŭ ���뱸��
SELECT E.EMP_ID, E.EMP_NAME ����̸� ,E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME �������̸� 
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID
ORDER BY EMP_ID; -- SELECT�� EMP_ID�� �ϳ��� ������� �ʿ�X // ��Ī �����ϸ� E. �ٿ�����
-- ANSI ǥ�ر���
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME
FROM EMPLOYEE E
    JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);



------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- ���� ����

-- ���� ���� �ۼ� ��� �� ���� 
-- 1)���ν�ų ���̺� �̾Ƽ� ���´�                                EX) EMPLOYEE, DEPARTMENT,LOCATION
-- 2)�� ���̺�鿡�� �����ų ���� ����Ǵ� ������ �����Ͽ� ���´�  EX) LOCATION_ID = LOCAL_CODE, DEPT_ID = DEPT_CODE


-- ���, �̸�, �μ��ڵ�, �μ���, �����̸�(LOCAL_NAME)
-- ����Ŭ ���뱸��
-- ANSI ǥ�ر���
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT,LOCATION;


SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT,LOCATION
WHERE LOCATION_ID = LOCAL_CODE -- EMPLOYEE �� DEPARTMENT
      AND DEPT_ID = DEPT_CODE; -- DEPARTMENT �� LOCATION


SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)     -- EMPLOYEE �� DEPARTMENT
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE); -- DEPARTMENT �� LOCATION
-- 

-- ���� ���ν�, ���ǻ��� 
-- ����
-- 
-- ���� �������� �ڵ带 �����ٲ��ؼ� �ѹ��غ���. � ����� ������
-- ����Ŭ ���뱸���� ���� �ٲ㵵 ����X
-- ANSI ǥ�ر����� ����
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT,LOCATION
WHERE DEPT_ID = DEPT_CODE -- DEPARTMENT �� LOCATION
      AND LOCATION_ID = LOCAL_CODE; -- EMPLOYEE �� DEPARTMENT -- ���� X


SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)  -- EMPLOYEE �� DEPARTMENT���� ���� -> �ٲ��
    JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE);    -- error : ORA-00904: "LOCATION_ID": invalid identifier
-- ERROR ����
-- JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE) ��ü�� �񱳸� 
-- DEPARTMENT���̺��  LOCATION ���̺��� �÷��� �ϴ°Ŷ� ������ �ٲ�� ����� �ٲ�⿡ �����߻��� �� �ۿ�
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)  -- LOCATION���̺��� ��� �ΰ� �ʹٸ� 
    JOIN EMPLOYEE ON(DEPT_ID = DEPT_CODE); -- DEPARTMENT���̺��� ���� ó������ �ø��� �ȴ�
    
    
    
    
-- ������ �븮�̸鼭 �ƽþ� ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸� ,���޸�, �μ���, �ٹ� ������, �޿�
-- ����Ŭ ���뱸��
-- ANSI ǥ�ر���
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE, L.LOCAL_NAME, SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE J.JOB_CODE = E.JOB_CODE
        AND E.DEPT_CODE = D.DEPT_ID
        AND D.LOCATION_ID = L.LOCAL_CODE -- ������� ���� ����
        AND JOB_NAME = '�븮' -- ������ �븮�̸� �ƽþ� ���� �ٹ� ���� ��ȸ ����
        AND LOCAL_NAME LIKE 'ASIA%'; -- 216	���¿�	�븮	�λ������	ASIA1	2780000


SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE JOB_NAME = '�븮'
    AND LOCAL_NAME LIKE 'ASIA%'; -- 216	���¿�	�븮	�λ������	ASIA1



    
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------






