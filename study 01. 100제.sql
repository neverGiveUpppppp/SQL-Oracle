



--SELECT ����
--1. EMPLOYEE ���̺���    ���, �̸�, �޿�   ��ȸ
SELECT EMP_NO, EMP_NAME,SALARY
FROM EMPLOYEE;
--2. EMPLOYEE ���̺���    ���    ����    ��ȸ
SELECT * FROM EMPLOYEE;
--3. JOB ���̺���   ���    ����   ��ȸ
SELECT * FROM JOB;
--4. JOB ���̺���   ����    �̸�   ��ȸ
SELECT JOB_NAME FROM JOB;
--5. DEPARTMENT ���̺���    ���    ����    ��ȸ
--6. EMPLOYEE ���̺���    ����    ��, �̸���, ��ȭ��ȣ, �����    ��ȸ
--7. EMPLOYEE ���̺���    �����, ���    �̸�, ����    ��ȸ
--8. EMPLOYEE ���̺���    ����    ��, �޿�, ����    ��ȸ(����    = �޿�*12)
SELECT EMP_NAME,SALARY,SALARY*12
FROM EMPLOYEE;
--9. EMPLOYEE ���̺���    ����    ��, ����, ���ʽ���    �߰���    ����    ��ȸ
SELECT EMP_NAME,SALARY,SALARY*12
FROM EMPLOYEE;
--10.EMPLOYEE  ���̺���      �̸�,  ����,  �Ѽ��ɾ�(���ʽ�      ����),  �Ǽ��ɾ�(�Ѽ��ɾ�-(����*���� 3%)) ��ȸ
SELECT EMP_NAME �̸�,SALARY �޿�,SALARY*12-(SALARY*12*0.03) �Ѽ��ɾ�, SALARY*12 ����
FROM EMPLOYEE;
--11.EMPLOYEE  ���̺���      �̸�,  �����,  �ٹ��ϼ�(����      ��¥      -  �����)  ��ȸ,  ����      ��¥: SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE �ٹ��ϼ�, SYSDATE ����
FROM EMPLOYEE;
--12.EMPLOYEE ���̺���    ������    ����    ��ȣ, ���    ��, �޿�, ����    ��ȸ
--13.EMPLOYEE ���̺���    ������    ����    �ڵ�    ��ȸ
--14.EMPLOYEE ���̺���    ������    ����    �ڵ带    �ߺ�    ����    ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;
--15.EMPLOYEE ���̺���    ������    �μ�    �ڵ带    �ߺ�    ����    ��ȸ
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;
--16.EMPLOYEE ���̺���    �μ�    �ڵ尡    'D9'��    ������    �̸�, �μ�    �ڵ�    ��ȸ
SELECT EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';
--17.EMPLOYEE ���̺���    �޿���    4000000 �̻���    ������    �̸�, �޿�    ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;
--18.EMPLOYEE ���̺���    �μ�    �ڵ尡    ��D9����    �ƴ�    �����    ���, �̸�, �μ�    �ڵ�    ��ȸ
SELECT EMP_ID, EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';
--19.EMPLOYEE  ���̺���    ���    ���ΰ�    N��    ������    ��ȸ�ϰ�    �ٹ�    ���θ�    ����������    ǥ���� ��    ���, �̸�, �����, �ٹ�    ����    ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, ENT_YN ������
FROM EMPLOYEE
WHERE ENT_YN = 'N' ;
--20.EMPLOYEE ���̺���    ������    3000000�̻���    �����    �̸�, ����, �����    ��ȸ
--21.EMPLOYEE ���̺���    SAL_LEVEL��   ��S1����    �����    �̸�, ����, �����, ����ó    ��ȸ
--
--22.EMPLOYEE ���̺���    �Ǽ��ɾ�(�Ѽ��ɾ�    - (����*����%3))��    5õ����    �̻���    �����    �̸�, �޿�, �Ǽ��ɾ�, �����    ��ȸ
--23.EMPLOYEE  ���̺���    �μ�    �ڵ尡    ��D6���̰�    �޿���    3000000����    ����    �޴�    ������    �̸�, �μ�    �ڵ�, �޿�    ��ȸ
--24.EMPLOYEE  ���̺���    �μ�    �ڵ尡    ��D6���̰ų�    �޿���    3000000����    ����    �޴�    ������    �� ��, �μ�   �ڵ�, �޿�    ��ȸ
--25.EMPLOYEE  ���̺���    �޿���    3500000  �̻�    6000000  ���ϸ�    �޴�    �����    ���,  �̸�,  �� ��, �μ��ڵ�, �����ڵ�
--26.EMPLOYEE���̺�    ������    4000000�̻��̰�    JOB_CODE��    ��J2����    �����    ��ü    ����    ��ȸ
--27.EMPLOYEE ���̺�    DEPT_CODE��    ��D9���̰ų�    ��D5����    ���    �߿�    �������    02��    1��    1�Ϻ� ��    ����   �����    �̸�, �μ��ڵ�, �����   ��ȸ
--28.EMPLOYEE  ���̺���    �޿���    3500000  �̸�    6000000  �ʰ���    �޴�    �����    ���, �̸�,  �� ��, �μ��ڵ�, �����ڵ�
--29. EMPLOYEE ���̺�    �������    90/01/01 ~ 01/01/01��    �����    ��ü    ������    ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';
--30. EMPLOYEE ���̺���    ����    ����������    �����    ���, �����    ��ȸ
--31. EMPLOYEE ���̺���    �̸���    '��'��    ���Ե�    ������    �̸�, �ֹι�ȣ, �μ��ڵ�    ��ȸ
--32. EMPLOYEE ���̺���    ��ȭ��ȣ    4��°    �ڸ���    9��    �����ϴ�    �����    ���, �̸�, ��ȭ��ȣ ��ȸ
--33. EMPLOYEE  ���̺���    �̸���    ��    _��    ��    ���ڰ�    3�ڸ���    �̸���    �ּҸ�    ����    �����    �� ��, �̸�, �̸���    �ּ�    ��ȸ
SELECT EMP_ID,EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___!_%' ESCAPE '!';
--34. EMPLOYEE ���̺���    �̸�    ��    �达    ����    ������    ����    �����    ���, �̸�, �����   ��ȸ
--35. EMPLOYEE ���̺���    �̸�    ����    '��'����    ������    ���    ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';
--36. EMPLOYEE ���̺���    ��ȭ��ȣ    ó��    ���ڸ���    010��    �ƴ�    �����    �̸�, ��ȭ��ȣ    ��ȸ
SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';
--37. EMPLOYEE  ���̺���     �����ּ�     _��     ����     4���̸鼭     DEPT_CODE��     ��D9��     �Ǵ�     ��D6���̰�, 
-- �������    90/01/01 ~ 00/12/01�̰�, �޿���   2700000��    �̻���    �����    ��ü    ����    ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____!_%' ESCAPE '!'
        AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
        AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
        AND SALARY >= 2700000;
        
--38. EMPLOYEE ���̺���    ���ʽ���    ����    �ʴ�    �����    ���, �̸�, �޿�, ���ʽ�    ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY,  NVL(BONUS, 0)---------------------
FROM EMPLOYEE
WHERE BONUS = 0;
--39. EMPLOYEE ���̺���    ���ʽ���    �޴�    �����    ���, �̸�, �޿�, ���ʽ�    ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;
--40. EMPLOYEE  ���̺��� �����ڵ� ���� �μ� ��ġ�� ���� ���� ������ �̸�,  ������,  �μ��ڵ�    ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--41. EMPLOYEE  ���̺���    �μ�    ��ġ��    ����    �ʾ�����    ���ʽ���    ���޹޴�    ������    �̸�,  ���� ��, �μ��ڵ�   ��ȸ
SELECT EMP_NAME,BONUS,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
--42. ��D6���μ���   ��D9���μ�������    �̸�, �μ��ڵ�, �޿�    ��ȸ
--43. ����   �ڵ尡   ��J1��, ��J2��, ��J3��, ��J4����    �������    �̸�, ����    �ڵ�, �޿�    ��ȸ
SELECT EMP_NAME, JOB_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1','J2','J3','J4');
--44. EMPLOYEE ���̺���    ���, �̸�, �޿���    �����ؼ�    ��ȸ    (EX. 200������8000000)
SELECT EMP_ID||EMP_NAME||SALARY
FROM EMPLOYEE;
--45. EMPLOYEE ���̺���    '���    ����    ������    �޿�    ���Դϴ�' ��������    ��ȸ
SELECT '����� '||EMP_NAME||'�� ������ �޿� '|| SALARY||'���Դϴ�'
FROM EMPLOYEE;
--
--
--
--FUNCTION ����
--1. EMPLOYEE  ���̺���    ���    ��,  �Ի���-����,  ����-�Ի���    ��ȸ    (��,  ��Ī��    �ٹ��ϼ�1,  �� ���ϼ�2��   �ϰ�    ���    ����    ó��(����)��    �����    ó��)
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE - SYSDATE)) �ٹ��ϼ�1 , FLOOR(ABS(SYSDATE - HIRE_DATE)) �ٹ��ϼ�2
FROM EMPLOYEE;
--2. EMPLOYEE ���̺���    �����    Ȧ����    ��������    ����    ���    ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE MOD(EMP_ID,2) = 1;
WHERE MOD(EMP_ID,2) != 0;
--3. EMPLOYEE ���̺���    �ٹ�������    20��    �̻���    ����    ����    ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 20;
--4. EMPLOYEE ���̺���    ���    ��, �Ի���, �Ի���    ����    �ٹ���    ��    ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)-HIRE_DATE "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;
--5. EMPLOYEE ���̺���    �����    �̸�, �Ի�    ����, �Ի�    ��, �Ի���    ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)-HIRE_DATE "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;
--6. EMPLOYEE���̺���    �����    �̸�,  �Ի���,  �ٹ�����    ��ȸ    (��,  �ٹ�������    ����    ����    - �� �翬����    ��ȸ)
SELECT EMP_NAME, HIRE_DATE, EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) �ٹ�����
FROM EMPLOYEE;
--7. EMPLOYEE ���̺���    ���    ��, �޿�(\9,000,000 ����) ��ȸ
SELECT EMP_NAME ,TO_CHAR(SALARY,'L9,000,000') �޿�
FROM EMPLOYEE;
--8. EMPLOYEE ���̺���    �̸�, �Ի���(2022��    3��    15��    (ȭ) ����) ��ȸ
SELECT EMP_NAME,TO_CHAR(HIRE_DATE, 'YYYY"��" FMMM"��" DD"��" (DY)')
FROM EMPLOYEE;
--9. ������ �޿��� �λ��ϰ��� �Ѵ�. �����ڵ尡 ��J7���� ������ �޿��� 10%�� �λ��ϰ�, ������ �尡 ��J6���� ������ �޿��� 15%�� �λ��ϰ�, 
-- �����ڵ尡 ��J5���� ������ �޿��� 20%�� �λ� �ϸ�, �� �� ������ ������ �޿��� 5%�� �λ��ϸ�, ���� ���̺��� ������,  �����ڵ�,  �� ��, �λ�޿�(�� ����)�� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY, 
        DECODE JOB_CODE WHEN 'J7' THEN SALARY*0.1
               JOB_CODE WHEN 'J6' THEN SALARY*0.15
               JOB_CODE WHEN 'J5' THEN SALARY*0.2
               ELSE SALARY*0.05
        END;
               
        '�λ�޿�'
FROM EMPLOYEE
WHERE JOB_CODE = 
--10. EMPLOYEE ���̺���    ��    �����    �޿�    ����    ��ȸ
--11. EMPLOYEE ���̺���    ���ڻ����    �޿�    ����    ��ȸ
--12. EMPLOYEE ���̺���    ��    �����    �޿�    ���    ��ȸ
--13. EMPLOYEE ���̺��� �� ����� ���ʽ� ��� (��, BONUS�� NULL�� ����� 0���� ó��)
--14. EMPLOYEE ���̺���    �ּ�    �޿���    �ִ�    �޿�    ��ȸ
--15. �μ�   �ڵ尡   �ִ�    ���    ��    (NULL ����) ��ȸ
--
--
--GROUP BY HAVING ����
--1. �μ�    ��   �޿�    �հ�    ��ȸ
--2. EMPLOYEE ���̺��� �μ�, �μ� �� �޿� �հ�, �μ� �� �޿� ���, �μ� �� �ο� �� ��ȸ
--3. EMPLOYEE ���̺���    �μ��ڵ��    ���ʽ�    �޴�    ���    ��    ��ȸ
--4. EMPLOYEE ���̺���    �����ڵ��    ���ʽ�    �޴�    ���    ��    ��ȸ
--5. EMPLOYEE ���̺���    ������    ����    ��    �޿�    ���(����ó��(����)), �޿�    �հ�, �ο�    ��    ��ȸ (�ο�    ����   ��������)
--6. EMPLOYEE ���̺���    �μ�    �ڵ庰��    ����    ������    �����    �޿�    �հ�    ��ȸ
--7. �μ�    �ڵ��   �޿�    3000000�̻���    ������    �׷�    ��    ���    �޿�    ��ȸ
--8. �μ�    �ڵ��   �޿�    ���    3000000�̻���    �׷�   ��    ���    �޿�    ��ȸ
--9. �μ�    ��   �޿�    �հ�    ��    9000000��    �ʰ��ϴ�    �μ��ڵ��    �޿�    �հ�    ��ȸ
--10. EMPLOYEE  ���̺���    ��    �μ�    �ڵ帶��    ����    �ڵ�    ��    �޿�    ��,  �μ�    ��    �޿�    ��,  ���� ��ȸ
--11. EMPLOYEE  ���̺���    DEPT_CODE��    ��D5���̰ų�    �޿���    3000000��    �ʰ��ϴ�    ������    �� ��, �̸�, �μ��ڵ�, �޿�    ��ȸ
--
--
--
--JOIN ����
--����    ����(INNER JOIN) : ��ġ����    �ʴ�    �÷�    ����    ���ܽ�Ŵ 1. ���, ���   ��, �μ��ڵ�    ��ȸ
--2-1.   ���, �̸�, �μ��ڵ�, �μ�    ��    ��ȸ(����Ŭ    ����    ����) 2-2.   ���, �̸�, �μ��ڵ�, �μ�    ��    ��ȸ(ANSI ǥ��    ����)
--3-1.    ���, ���    ��, ����    �ڵ�, ����    ��    ��ȸ(����Ŭ    ����    ����) 3-2.    ���, ���    ��, ����    �ڵ�, ����    ��    ��ȸ(ANSI ǥ��    ����) 4-1.    �μ�   ���   �ش�    �μ���    ����    ��    ��ȸ(����Ŭ    ����    ����)
--
--
--
--4-2.    �μ�   ���   �ش�    �μ���    ����    ��    ��ȸ(ANSI ǥ��    ����)
--5. ����Ŭ    ����    ����    ANSI ǥ��    ��������    �ٲٱ�
--SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);
--6. ����Ŭ    ����    ����    ANSI ǥ��    ��������    �ٲٱ�
--SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;
--7. ����Ŭ    ����    ��������    FULL [OUTER] JOIN ��    ��. �Ʒ�    ����    �����ص�    ����    ��. �׷��ϱ� �ؿ�    ������    ANSI ǥ������    �ٲ��ּ�.
--SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID(+);
--8-1.   ���, �̸�, �μ�    �ڵ�, �μ�    ��, ����    �̸�(LOCAL_NAME) ��ȸ(����Ŭ    ����    ����) 8-2.   ���, �̸�, �μ�    �ڵ�, �μ�    ��, ����    �̸�(LOCAL_NAME)(ANSI ǥ��    ����)
--SUBQUERY ����
--����    ����(SUBQUERY) :  ����    ������    ����    ����    ������    �ϴ�    �����̸�,  ����    �ȿ�    ������    �� �ԵǾ�   ����.
--1. ù    ��°   ������    ��    ��°    ����    �����ּ�.
--��
--SELECT DEPT_CODE FROM EMPLOYEE
--WHERE EMP_NAME = '���ö';
--��
--
--SELECT EMP_NAME FROM EMPLOYEE
--WHERE DEPT_CODE = 'D9';
--2. ��    ������   ���    �޿�����    ����    �޿���   �ް�    �ִ�    ������    ���, �̸�, ����    �ڵ�, �޿�    ��ȸ
--3. ���ö    �����   �޿�����    ����    �޴�    ������    ���, �̸�, �μ��ڵ�, �����ڵ�, �޿�    ��ȸ
--4. ����    ����   �޿���    �޴�    ������    ���, �̸�, �����ڵ�, �μ��ڵ�, �޿�    �Ի���    ��ȸ
--5. �μ�    ��   �޿�    �հ�    ��    ����    ū    �μ���   �μ�    ��, �޿�    �հ�
--6. �μ�    ��   �ְ�    �޿���    �޴�    ������    �̸�, ����    �ڵ�, �μ��ڵ�, �޿�    ��ȸ
--7. �����ڿ�    �Ϲ�    ������    �ش��ϴ�    ���    ����    ����    : ���, �̸�, �μ���, ����, ����(������/�� ��)
--8. �븮    ������    ������    �߿���    ����    ������    �ּ�    �޿�����    ����    �޴�    ������    ���, �̸�, ����, �޿�    ��ȸ
--9. ����    ������   �޿�    ��    ����    ū    ������   ����    �޴�    ����    ������    ���, �̸�, ����, �޿�    ��ȸ
--10.�����    ��������    ����    �μ�, ����    ���޿�    �ش��ϴ�    �����    �̸�, ����    �ڵ�, �μ��ڵ�, �Ի� ��    ��ȸ
--11.�ڱ�    ������    ���    �޿���    �ް�    �ִ�    ������    ���,  �̸�,  ����    �ڵ�,  �޿�    ��ȸ    (��, �޿�    �� ����    ��   ����    ������    ���    : TRUNC(�÷�    ��, -5))
--12.��    ����   ��    �޿���    ����    ����    5����   �̸�, �޿�    ��ȸ
--13.��    ����   ��    �޿���    ����    ����    5����   �̸�, �޿�    ��ȸ









