
------------------------------------------------------------------------------
-------------------------------DDL------------------------------------------
--------------------------------------------------------------------
/*
CREATE

1.���̺� �����

���̺� = ��ü

CREATE TABLE

���̺� DB�� ���� �⺻���� ��ü
���̺� ������ ��ü����

*/
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),  -- �÷��� �÷��� // ������Ÿ��(������ũ��)
    MEMBER_PWD VARCHAR2(20), -- MEMBER_PWD  // VARCHAR2(20)
    MEMBER_NAME VARCHAR2(20)
);

/*
������ Ÿ��
���� : CHAR(ũ��[����Ʈ/����]), VARCHAR2(ũ��[����Ʈ/����]), NVARCHAR, LOB
    CHAR : ���� ���ڿ� �ڷ��� (�ִ� 2000byte)
    VARCHAR2 : ���� ���ڿ� �ڷ��� (�ִ� 40000byte)
    ex. CHAR(10) : ����Ʈ / CHAR(10char) : ����
            �ѱ� 3����          �ѱ� 10����
    ex. CHAR(10char)                 VS   VARCHAR2(10) 
    �ȳ��ϼ���_ _ _ _ _(����5�ڸ��� ����) //  �ȳ��ϼ���(���� ����X)
    �� ���� ���� ���� ���ΰ� CHAR�� VARCHAR2�� ����


    NVARCHAR : ���� ���� ��ü�� ���̷� ����ϴ� �ڷ��� --> �پ��� �� ���� �����ڵ忡 ����
    LOB : CLOB/BLOB �������� �ְ�, �Ⱑ���� ���尡��. CLOB�� �� �� ���� ����

���� : NUMBER[(P,S)]
ũ��(����)�� ���� ���� �� �ִ� ���ڰ� �ִ�
    NUMBER : �ְ� 40�ڸ�
    
    NUMBER(ũ��) : ���� ���� ����
                P : �ִ� �ڸ��� / S : �Ҽ��� �ڸ���
                EX).NUMBER(4,3) --> �ִ� 4�ڸ���, �Ҽ��� 3�ڸ����� ���
    
��¥ - DATE : ��¥�� �ð��� �����ϴ� ��¥�� ������ Ÿ��
    - TIMESTAMP : DATE�� �� Ȯ��� ���·� �и��� �������� ǥ�� ������ ������ Ÿ��

*�ǹ����� ���� developer���α׷����� cmdâ�� �� ���� �̿��� ��

*/


-- �÷��� �ּ��ޱ�
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�� ���̵�'; 
-- �ڵ� �ǹ� : MEMEBER���̺� MEMBER_ID��� �÷��� 'ȸ�� ���̵�'��� �ּ��� �ްڴ�
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ�� ��й�ȣ'; 
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ�� �̸�'; 
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ�� ����'; -- ���

COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ�� �̸�';

-- CMD���� �ۼ��� ���̺� Ȯ�� ���
-- ���1
SELECT * FROM USER_TABLES; -- ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��
-- ���2
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-- ���3
DESC MEMBER;

SELECT * FROM USER_TABLES;
DESC USER_CONSTRAINTS;


------------------------------------------------------------------------------
----------------------------------��������(CONSTRAINTS)------------------------
------------------------------------------------------------------------------



/*

<��������(CONSTRAINTS)>
���̺� �ۼ� ��, �� �÷����� �� ��Ͽ� ���� ���� ���� ���� ����
    ex) null �� ���� �� �ִ��� ����, �ֹι�ȣ Number Ÿ�Ը� �޵��� ����
    
������ : ������ ���Ἲ ����
    ������ ���Ἲ�̶�?
    ������ ��Ȯ��, �ϰ���, ��ȿ���� �����Ǵ� ��


*/

DESC USER_CONSTRAINTS; -- ����ڰ� �ۼ��� �������� Ȯ�� ��

SELECT * FROM USER_CONSTRAINTS;

/*
-- �������� ����
NOT NULL : �����Ϳ� NULL ��� X
UNIQUE : �ߺ��� �� ��� X
PRIMARY KEY : NOT NULL + UNIQUE �� ���� �ĺ��ڷ� ��� : �� �÷��� �ĺ��� �� �ִ� ���� �ĺ���
FOREIGN KEY : �ܺ� ���̺��� ������ �� �÷����� �����ϸ� ���
CHECK :  ������ ���� ������ ������ ������ ������ ���� ���

�� �÷��� �������� ������ ����



NOT NULL : �����Ϳ� NULL ��� X
UNIQUE : �ߺ��� �� ��� X
PRIMARY KEY : NOT NULL + UNIQUE �� ���� �ĺ��ڷ� ��� : �� �÷��� �ĺ��� �� �ִ� ���� �ĺ���
    - PRIMARY KEY�� ���� �ĺ��ڷ� ���. �� ������ �ɷ� �� ������ �Ǳ⿡ �߿�
FOREIGN KEY : �ܺ� ���̺��� ������ �� �÷����� �����ϸ� ���

*/

-- �������� �׽�Ʈ START
-- ���̺� ����


CREATE TABLE USER_NOCONST(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);


INSERT INTO USER_NOCONST VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO USER_NOCONST VALUES(NULL, NULL, NULL, NULL,NULL,NULL,NULL);
-- 1 �� ��(��) ���ԵǾ����ϴ�.
-- �ƹ��� ���������� ���⿡ ������ �߰��� ��������


CREATE TABLE P_USER_NOCONST(
    USER_NO NUMBER,
    USER_ID VARCHAR(20),
    USER_PWD VARCHAR(20),
    USER_NAME VARCHAR(20),
    GENDER VARCHAR(20),
    PHONE VARCHAR(20),
    EMAIL VARCHAR(20)
);

INSERT INTO P_USER_NOCONST VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO P_USER_NOCONST VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- �ߺ� ���� ����

-- NULL �����Ϳ� �������� �����غ���

CREATE TABLE P_USER_NOTNULL(
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20)NOT NULL,
    USER_PWD VARCHAR2(30)NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR(20),
    PHONE VARCHAR(20),
    EMAIL VARCHAR(20)
);
INSERT INTO P_USER_NOTNULL VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO P_USER_NOTNULL VALUES(NULL, NULL, 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ORA-01400: cannot insert NULL into ("KH"."P_USER_NOTNULL"."USER_NO")
-- "P_USER_NOTNULL"���̺��� "USER_NO"�÷����� NULL CONSTRAINT ���� ������ ����
INSERT INTO P_USER_NOTNULL VALUES(2, 'user02', NULL, '���ǰ�','��','010-1111-2222','kang@k.k');
-- ORA-01400: cannot insert NULL into ("KH"."P_USER_NOTNULL"."USER_PWD")
-- ���� ���ǿ� NOT NULL �ɾ�а� USER_NAME�������̶� ������ʹ� NULL�̾ ���԰���


-------------------------------------------------------------------------------------------


-- UNIQUE

-- �ߺ��� �� ��� X
-- �÷�����, ���̺��� �� �� ��������


--�ߺ����Ѱɱ�
CREATE TABLE P_USER_UNIQUE(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE,
    -- �÷��������� �������� ������. UNIQUE �������� �߰� // �÷����� : �÷��� �������� ���� ���� ��
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);
INSERT INTO P_USER_UNIQUE VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');



INSERT INTO P_USER_UNIQUE VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO P_USER_UNIQUE VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ERROR : ORA-00001: unique constraint (KH.SYS_C007021) violated
-- ����ũ ���������� ���ݵ�. SYS_C007021 �̺κ��� �������� �̸�. 
-- ���̺��� �ش� �÷����� �������� �ǿ� CONSTRAINT_NAME�� �������� �̸��� �ְ� ���⼭ Ȯ�ΰ���
-- DEVELOPER������ ��ó�� Ȯ�ΰ����ϰ� �Ʒ��� CMD


INSERT INTO P_USER_UNIQUE VALUES(2, 'user02', 'pass02', '���ǰ�','��','010-1111-2222','kang@k.k');
-- 1 �� ��(��) ���ԵǾ����ϴ�.


CREATE TABLE P_USER_UNIQUE2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID) -- ���̺� ���� : �Ʒ��� �������� �����ϴ� ��
    -- NOT NULL ���������� ���̺� ������ ���� ���� ���� �Ұ��� -> ������ �÷� ���������� ��밡��
);
INSERT INTO P_USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO P_USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ORA-00001: unique constraint (KH.SYS_C007049) violated
-- KH������ SYS_C007049 �������� ����



---RE
CREATE TABLE P_USER_UNIQUE (
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR(20) UNIQUE,
    USER_PWD VARCHAR(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO)
);
INSERT INTO P_USER_UNIQUE VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');

SELECT * FROM P_USER_UNIQUE;
SELECT * FROM USER_CONSTRAINTS;


CREATE TABLE P_USER_UNIQUE3 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO,USER_ID) -- �÷� 2���� �ϳ��� ����
); -- �÷�1�� ������ ���̰� ���� �غ���
INSERT INTO P_USER_UNIQUE3 VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO P_USER_UNIQUE3 VALUES(1, 'user02', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO P_USER_UNIQUE3 VALUES(2, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO P_USER_UNIQUE3 VALUES(2, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ORA-00001: unique constraint (KH.SYS_C007050) violated
-- ���� 3���� ������ �߉����� �������͸� 3�����̶� ���ļ� ����
-- UNIQUE(USER_NO,USER_ID)���� USER_NO,USER_ID ���� �Ѽ�Ʈ�� ���� 
-- �� ���� �� ���ƾ� �����̰�ġ�� �ɷ� ����.

DROP TABLE P_USER_UNIQUE3 CASCADE CONSTRAINTS;

CREATE TABLE P_USER_UNIQUE4 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO,USER_ID)
);
INSERT INTO P_USER_UNIQUE4 VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO P_USER_UNIQUE4 VALUES(1, 'user02', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');

SELECT * FROM USER_TABLES;
DROP TABLE P_USER_UNIQUE4;
DROP TABLE P_USER_UNIQUE4 CASCADE CONSTRAINTS;

------------------------------------------------------------------------------
-- < �������� �̸�����>


CREATE TABLE P_CONS_NAME(
    CONS_TEST1 VARCHAR(20) CONSTRAINT PCN_CT1_NN NOT NULL, -- �������� �̸� ����
    CONS_TEST2 VARCHAR(20) CONSTRAINT PCN_CT2_UQ UNIQUE,-- ����ũ �÷�����, ���̺��� �� �� ��������
    CONS_TEST3 VARCHAR(20),
    CONSTRAINT PCN_CT3_UK UNIQUE(CONS_TEST3)-- ����ũ �÷�����, ���̺��� �� �� ��������
);
-- CN_TD1_NN �ǹ�
--    CN : ���̺� �̸�
--    TD1 : �÷� �̸�
--    NN : (��������) NOT NULL �ǹ�
--    UQ(UK) : (��������) UNIQUE
DROP TABLE P_CONS_NAME CASCADE CONSTRAINTS;

INSERT INTO P_CONS_NAME VALUES('Z','A','B');
-- ���̺��� �������� �ǿ� ���� CONSTRAINT_NAME�� �̸��� �ٲ� ���� Ȯ���� �� �ִ�

CREATE TABLE P_CONS_NAME3 (
    CTEST1  NUMBER CONSTRAINTS PCN_CT1_NN NOT NULL,
    CTEST2 VARCHAR2(10) CONSTRAINTS PCN_CT2_UQ UNIQUE,
    CTEST3 VARCHAR2(20)
);
SELECT * FROM USER_CONSTRAINTS;

DROP TABLE P_CONS_NAME3 CASCADE CONSTRAINTS;

------------------------------------------------------------------------------


-- PRIMARY KEY

-- PRIMARY KEY : NOT NULL + UNIQUE -> ���� �ĺ��� ����
-- �÷�����, ���̺��� �� �� ��������
-- NOT NULL + UNIQUE -> **���� �ĺ��� ����**
-- �� ���̺� �� �ѹ��� ���� ����
--    (���� �ĺ��ڴ� �����ѰŴ� �ϳ��� ����. �÷����� �ִٸ� �����ĺ� �Ұ���������)


CREATE TABLE P_U_PK(
     USER_NO NUMBER CONSTRAINT PUP_N_PK PRIMAY KE,
     USER_ID VARCHAR2(20),
     USER_PWD VARCHAR2(10)
    );

CREATE TABLE PK(
     USER_NO NUMBER ,
     USER_ID VARCHAR2(20),
     USER_PWD VARCHAR2(10),
    CONSTRAINT PK PRIMARY KEY(USER_NO,USER_ID)
);     

DROP TABLE PK CASCADE CONSTRAINTS;

------------------------------------------------------------------------------


-- FOREIGN KEY 
-- ����
-- �ܺ� ���̺��� ������ �� �÷�. �� �÷����� �����ϸ� ���
-- ���̺� ����, �÷� ���� �� �� ��������

-- �θ����̺� : ���� ���ϴ� ���̺�
-- �ڽ����̺� : �����ϴ� ���̺�

CREATE TABLE A (
    AA NUMBER PRIMARY KEY,
    BB VARCHAR2(30) NOT NULL
);
INSERT INTO A VALUES(10, 'A');
INSERT INTO A VALUES(20, 'B');

CREATE TABLE B(
    CC NUMBER PRIMARY KEY,
    DD VARCHAR2(30) UNIQUE,
    AA NUMBER NOT NULL,
    CONSTRAINT B_EE_FK FOREIGN KEY(AA) REFERENCES A(AA) ON DELETE SET NULL
);                                                   -- OM DELETE CASCADE
INSERT INTO B VALUES(1,'A',1);

-- <���������� �ɷ��־ ������ �� �ִ� ���>
-- ON DELETE SET NULL
-- �θ� Ű ���� �� �ڽ� Ű�� NULL�� ����

-- ON DELETE CASCADE
-- �θ� Ű ���� ��, �ڽ� Ű�� �Բ� ����


------------------------------------------------------------------------------
-- CHECK
-- 
-- ������ ���� ������ ������ ������ ������ ���� ���

CREATE TABLE UC(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK(GENDER IN('��','��'))
);
INSERT INTO UC VALUES(1,'A','AA','AAA','��');
INSERT INTO UC VALUES(2,'B','BB','BBB','M');
-- ��OR���� ���� �Ǿ��� �������ǿ� �ɷ� ����

-- �ڸ�Ʈ(����) �ޱ�
COMMENT ON COLUMN UC.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN UC.USER_ID IS 'ȸ�����̵�';

------------------------------------------------------------------------------

-- SUBQUERY�� �̿��� ���̺� ����

CREATE TABLE P_EC
AS SELECT * FROM EMPLOYEE;

SELECT * FROM P_EC;

CREATE TABLE P_EC2
AS SELECT * 
FROM EMPLOYEE
    LEFT OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE);

SELECT * FROM P_EC2;
DROP TABLE P_EC2;

ALTER TABLE P_EC ADD PRIMARY KEY(EMP_ID);
ALTER TABLE P_EC ADD UNIQUE(EMP_NAME);
ALTER TABLE P_EC ADD CONSTRAINT PEC_EN_UQ UNIQUE(EMP_NO);
ALTER TABLE P_EC MODIFY 
------------------------------------------------------------------------------
-- DEPARTMENT ���̺��� LOCATION_ID�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� LOCATION, ���� �÷��� LOCATION�� �⺻Ű

ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCATION);

