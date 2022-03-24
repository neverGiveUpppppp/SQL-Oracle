/*
------------------------------------------------------------------------------
----------------------------------ALTER --------------------------------------
------------------------------------------------------------------------------

-- ALTER 
��ü ����

�÷� �߰�/����, �������� �߰�/����, �÷� �ڷ��� ����, ����Ʈ�� ����
���̺��/�÷���/�������Ǹ� ����


*/
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------


-- �÷� �߰�/����/����

SELECT * FROM DEPT_COPY; -- DEPT_ID, DEPT_TITLE, LOCATION_ID ��ȸ����
--�÷� �߰�
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20)); 
-- CNAME �÷� �߰� �� ������ SELECT�� ��ȸ�ϸ� CNAME�÷� �߰��Ȱ� Ȯ�� ����

ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '�ѱ�'); -- DEFAULT�� �ѱ� ����
-- DEFAULT�� �ѱ� ���� : �ƹ��͵� �ȳ����� NULL�� �ƴ� �ѱ����� ���� ����
-- ������ SELECT�� ��ȸ�ϸ� LCNAME�÷����� �ѱ�


------------------------------------------------------------------------------


--�÷� ����

DESC DEPT_COPY; -- ��ȸ : DEPT_COPY���̺�

ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3) -- �ڷ��� ����
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2) -- ũ�� ����
MODIFY CNAME CHAR(25) -- �ڷ���, ũ�� �� �� �ѹ��� ���氡�� // CNAME VARCHAR2(20) -> CHAR(25)
MODIFY LNAME DEFAULT '�̱�';-- DEFAULT���� ���氡��      // LNAME VARCHAR2(40) -> DEFAULT
-- LNAME�� ������ �ѱ�. ������ �� �� ���̱� ����.
-- ���⼭ ���� �߰��� �ϸ� �׶� �ٲ�Ե�
INSERT INTO DEPT_COPY
VALUES('D10','�����','L2',NULL,DEFAULT);-- D10�� �ѱ�->�̱����� ����

SELECT * FROM DEPT_COPY; -- D10�� �ѱ�to�̱����� �����

-- ũ�� : 16����Ʈ
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);
-- ORA-01441: cannot decrease column length because some value is too big
-- ũ�� ������ ���� �ȿ� �������� ũ�Ⱑ ����� ���� �����ؾ���


------------------------------------------------------------------------------


-- �÷� ����

-- �����Ͱ� ����־ ������ ��������
-- �ѹ��ϴ��� ������ �÷��� ���������� ����

-- ���̺� �ִ� ����÷��� ������� ����
-- ���̺� ��� 1���� �÷��� �����־����

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;
-- �����Ͱ� ����־ ������ ��������
-- �ѹ��ϴ��� ������ �÷��� ���������� ����

/*WHY?
���ǽð� 12:38-12:40 ���� ������ �κ�
DML
ũ������Ʈ ���� ����� �ѹ� ������ �Ǹ� �ٷ� Ŀ���� �ȴٰ� ������ ��
�ٷ� Ȯ���� �Ǵ°ű⿡ �ѹ��� ������ �ʴ´�*/

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;
/*
-- ERROR : ORA-12983: cannot drop all columns in a table
12983. 00000 -  "cannot drop all columns in a table"
*Cause:    An attempt was made to drop all columns in a table.
*Action:   Ensure that at least one column remains in the table after
           the drop column operation.*/
-- ���̺� �ִ� ����÷��� ������� ����
-- ���̺� ��� 1���� �÷��� �����־����


CREATE TABLE TB1 (
    PK1 NUMBER PRIMARY KEY,
    COL1 NUMBER,
    CHECK(PK1 > 0 AND COL1 >0 )
);

ALTER TABLE TB1
DROP COLUMN PK1;
/*ORA-12991: column is referenced in a multi-column constraint
12991. 00000 -  "column is referenced in a multi-column constraint"
*Cause:    An attempt was made to drop a column referenced by some
           constraints.
*Action:   Drop all constraints referencing the dropped column or
           specify CASCADE CONSTRAINTS in statement.
*/ -- ���� ������ ���־� ���� �� �� ����



------------------------------------------------------------------------------



/*���ǽð� 12:45-50 �ڵ� Ȯ��
*/

ALTER TABLE TB1
DROP COLUMN COL1;


-- ���� ���ǰ� �Բ� �÷� ����
ALTER TABLE TB1
DROP COLUMN PK1 CASCADE CONSTRAINTS;

SELECT * FROM TB1;



------------------------------------------------------------------------------

-- ���� ���� �߰�

-- DEPT_COPY�� DEPT_IDĮ���� PRIMARY KEY(DCOPY_DID_PK),
-- DPET_TITLEĮ���� UNIQUE(DCOPY_DTITLE_UQ),
-- LNAME�÷��� NOT NULL(DCOPY_LNAME_NN) �߰�
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_DID_PK PRIMARY KEY(DEPT_ID);
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_DTITLE_UQ UNIQUE(DEPT_TITLE);
ALTER TABLE DEPT_COPY MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;

-- ���� ��� : ALTER TABLE DEPT_COPY
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_DID_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_DTITLE_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL; -- Table DEPT_COPY��(��) ����Ǿ����ϴ�.
-- ���� Ȯ��
-- DCOPY_DID_PK	Primary_Key, DCOPY_DTITLE_UQ	Unique, DCOPY_LNAME_NN	Check


------------------------------------------------------------------------------

-- �������� ����

ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_DID_PK; -- Table DEPT_COPY��(��) ����Ǿ����ϴ�.


-- �������� �ѹ��� ������ ���� + ���
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_DTITLE_UQ
DROP CONSTRAINT SYS_C007062
MODIFY LNAME NULL; -- LNAME�� NULL�� ���� = �������� ����
-- ���� �Ϸ�. SYS_C007063	Check �ϳ� ����


------------------------------------------------------------------------------


SELECT * FROM DEPT_COPY;
-- �÷��� ����
-- RENAME A TO B : A�� B�� �÷��� ����
ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME; -- RENAME A TO B : A�� B�� �̸�����

-- �������� �̸� ����
ALTER TABLE DEPT_COPY
RENAME CONSTRAINT SYS_C007063 TO DCOPY_LID_NN; -- Table DEPT_COPY��(��) ����Ǿ����ϴ�.
-- DEPT_COPY���̺��� �������Ǹ��� SYS_C007063�� �������� �̸��� DCOPY_LID_NN���� �����Ѵٴ� �ǹ�


------------------------------------------------------------------------------


-- ���̺�� ����
ALTER TABLE DEPT_COPY 
--RENAME DEPT_COPY TO DEPT_TEST;
RENAME TO DEPT_TEST;
-- ���̺� �̸��� ALTER TABLE ���� ���ֱ⿡ RENAME ���� ���̺�� ������


-- ���̺� ����
-- ���̺� ����� ���������� ���� ä�� ���̺� ������ �� �ִ�
DROP TABLE DEPT_TEST
CASCADE CONSTRAINTS; -- �������� ���� �����ϴ� �ڵ�







------------------------------------------------------------------------------







