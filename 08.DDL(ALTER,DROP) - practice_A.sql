/*
------------------------------------------------------------------------------
----------------------------------ALTER --------------------------------------
------------------------------------------------------------------------------

-- ALTER 
��ü ����

�÷� �߰�/����, �������� �߰�/����, �÷� �ڷ��� ����, ����Ʈ�� ����
���̺��/�÷���/�������Ǹ� ����


*/

-- �÷� �߰�/����/����

SELECT * FROM UC;

-- �߰�
ALTER TABLE UC ADD (PHONE NUMBER);
ALTER TABLE UC ADD (NATIONALITY VARCHAR2(20) DEFAULT '�ѱ�');
-- �÷� PHONE, NATIONALITY �߰��Ϸ�. NATIONALITY �������ϸ� �⺻������ �ѱ�


DESC UC;
-- ����
ALTER TABLE UC
MODIFY USER_ID VARCHAR2(30)
MODIFY GENDER CHAR(3) -- ERROR : ORA-01441: cannot decrease column length because some value is too big
MODIFY NATIONALITY DEFAULT '�̱�';  -- �ٲ� �ڷ����� ũ�Ⱑ ����ִ� �����ͺ��� ������ ����

-- ����
ALTER TABLE UC
DROP COLUMN PHONE; -- PHONE �÷� ����


-- ���� ���ǰ� �Բ� �÷� ����
ALTER TABLE UC
DROP COLUMN USER_NAME CASCADE CONSTRAINT;

DESC UC;

------------------------------------------------------------------------------
------------------------------------------------------------------------------

ALTER TABLE TB1
DROP COLUMN COL1;


-- ���� ���ǰ� �Բ� ����
ALTER TABLE TB1
DROP COLUMN PK1 CASCADE CONSTRAINTS;

SELECT * FROM TB1;

-- ���� ���� �߰�
ALTER TABLE UC ADD CONSTRAINT UC_GEN_UQ UNIQUE(GENDER);

-- �������� ����
ALTER TABLE UC DROP CONSTRAINT UC_GEN_UQ;

-- �������� �ѹ��� ������ ����
ALTER TABLE UC
DROP CONSTRAINT SYS_C007129
DROP CONSTRAINT SYS_C007130
DROP CONSTRAINT SYS_C007127; -- GENDER�� CHECK �������� ���� �������� �� ����

-- �÷��� ����
-- RENAME A TO B : A�� B�� �÷��� ����
ALTER TABLE UC
RENAME COLUMN GENDER TO GENDER2;
ALTER TABLE UC
RENAME COLUMN GENDER2 TO GENDER;

-- �������� �̸� ����
ALTER TABLE UC
RENAME CONSTRAINT SYS_C007128 TO UC_CHECK1; 

DESC UC;
------------------------------------------------------------------------------

--���̺�� ����
ALTER TABLE DEPT_COPY
RENAME TO DEPT_COPY2;

--���̺� ����
DROP TABLE DEPT_COPY;
--���̺�+�������� ����
DROP TABLE DEPT_COPY
CASCADE CONSTRAINTS;

------------------------------------------------------------------------------



------------------------------------------------------------------------------

