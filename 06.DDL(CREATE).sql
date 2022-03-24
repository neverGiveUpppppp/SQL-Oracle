
------------------------------------------------------------------------------
-------------------------------DDL------------------------------------------
--------------------------------------------------------------------
/*
CREATE`

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
DB ������ Ÿ��
1.���� : CHAR(ũ��[����Ʈ/����]), VARCHAR2(ũ��[����Ʈ/����]), NVARCHAR, LOB
2.���� : NUMBER[(P,S)]
3.��¥ : DATE, TIMESTAMP

1.���� : CHAR(ũ��[����Ʈ/����]), VARCHAR2(ũ��[����Ʈ/����]), NVARCHAR, LOB
    CHAR : ���� ���ڿ� �ڷ��� (�ִ� 2000byte)
    VARCHAR2 : ���� ���ڿ� �ڷ��� (�ִ� 40000byte)
    ex. CHAR(10) : ����Ʈ / CHAR(10char) : ����
            �ѱ� 3����          �ѱ� 10����
    ex. CHAR(10char)                 VS   VARCHAR2(10) 
    �ȳ��ϼ���_ _ _ _ _(����5�ڸ��� ����) //  �ȳ��ϼ���(���� ����X)
    �� ���� ���� ���� ���ΰ� CHAR�� VARCHAR2�� ����


    NVARCHAR : ���� ���� ��ü�� ���̷� ����ϴ� �ڷ��� --> �پ��� �� ���� �����ڵ忡 ����
    LOB : CLOB/BLOB �������� �ְ�, �Ⱑ���� ���尡��. CLOB�� �� �� ���� ����

2.���� : NUMBER[(P,S)]
ũ��(����)�� ���� ���� �� �ִ� ���ڰ� �ִ�
    NUMBER : �ְ� 40�ڸ�
    
    NUMBER(ũ��) : ���� ���� ����
                P : �ִ� �ڸ��� / S : �Ҽ��� �ڸ���
                EX).NUMBER(4,3) --> �ִ� 4�ڸ���, �Ҽ��� 3�ڸ����� ���
    
3.��¥ - DATE : ��¥�� �ð��� �����ϴ� ��¥�� ������ Ÿ��
    - TIMESTAMP : DATE�� �� Ȯ��� ���·� �и��� �������� ǥ�� ������ ������ Ÿ��

*�ǹ����� ���� developer���α׷����� cmdâ�� �� ���� �̿��� ��

*/


-- �÷��� �ּ��ޱ�
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�� ���̵�'; 
-- �ڵ� �ǹ� : MEMEBER���̺� MEMBER_ID��� �÷��� 'ȸ�� ���̵�'��� �ּ��� �ްڴ�
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ�� ��й�ȣ'; 
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ�� �̸�'; 
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ�� ����'; -- ���


-- CMD���� �ۼ��� ���̺� Ȯ�� ���
-- �ۼ��� ��ü ���̺� Ȯ�� �ڵ� 3����
-- ���1
SELECT * FROM USER_TABLES; -- ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��
-- ���2
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-- ���3
DESC MEMBER;




------------------------------------------------------------------------------
----------------------------------��������(CONSTRAINTS)------------------------
------------------------------------------------------------------------------



/*

<��������(CONSTRAINTS)>
���̺� �ۼ� ��, �� �÷����� �� ��Ͽ� ���� ���� ���� ���� ����
    ex) null �� ���� �� �ִ��� ����, �ֹι�ȣ Number Ÿ�Ը� �޵��� ����
    
������ : ������ ���Ἲ ����
    ������ ���Ἲ(or������ integrity constraint)�̶�?
    ������ ��Ȯ��, �ϰ���, ��ȿ���� �����Ǵ� ��


*/
-- ����ڰ� �ۼ��� �������� Ȯ�� �� 2����
DESC USER_CONSTRAINTS; 

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


-- NULL �����Ϳ� �������� �����غ���
CREATE TABLE USER_NOTNULL(
    USER_NO NUMBER NOT NULL, -- �÷� ���� �������� ���� : �÷� �������� �����ߴٰ� ���Ѵ�
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOTNULL VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO USER_NOTNULL VALUES(NULL, NULL, NULL, NULL,NULL,NULL,NULL);
-- ERROR : ORA-01400: cannot insert NULL into ("KH"."USER_NOTNULL"."USER_NO")
-- ("KH"."USER_NOTNULL"."USER_NO") �ǹ� : KH������ "USER_NOTNULL"�� ���̺� "USER_NO"�÷��� ���� �Ұ�
INSERT INTO USER_NOTNULL VALUES(2, NULL, NULL, NULL,NULL,NULL,NULL);
-- ERROR : ORA-01400: cannot insert NULL into ("KH"."USER_NOTNULL"."USER_ID")-- �����߻����� : USER_ID
INSERT INTO USER_NOTNULL VALUES(2, 'user02', NULL, NULL,NULL,NULL,NULL);
-- ERROR : ORA-01400: cannot insert NULL into ("KH"."USER_NOTNULL"."USER_PWD")-- �����߻����� : USER_PWD
INSERT INTO USER_NOTNULL VALUES(2, 'user02', 'pass02', NULL,NULL,NULL,NULL);
-- ERROR : ORA-01400: cannot insert NULL into ("KH"."USER_NOTNULL"."USER_NAME")-- �����߻����� : USER_NAME
INSERT INTO USER_NOTNULL VALUES(2, 'user02', 'pass02', '������',NULL,NULL,NULL);
-- 1 �� ��(��) ���ԵǾ����ϴ�.
-- ���� ���ǿ� NOT NULL �ɾ�а� USER_NAME�������̶� ������ʹ� NULL�̾ ���԰���


-------------------------------------------------------------------------------------------


-- UNIQUE

-- �ߺ��� �� ��� X
-- �÷�����, ���̺��� �� �� ��������

SELECT * FROM USER_NOCONST;
INSERT INTO USER_NOCONST VALUES(1, 'user01','pass01','���ǰ�','��','010-1111-2222','kang@k.k');

--�ߺ����Ѱɱ�
CREATE TABLE USER_UNIQUE(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE, -- �÷��������� �������� ������. UNIQUE �������� �߰� // �÷����� : �÷��� �������� ���� ���� ��
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_UNIQUE VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO USER_UNIQUE VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ERROR : ORA-00001: unique constraint (KH.SYS_C007021) violated
-- ����ũ ���������� ���ݵ�. SYS_C007021 �̺κ��� �������� �̸�. 
-- ���̺��� �ش� �÷����� �������� �ǿ� CONSTRAINT_NAME�� �������� �̸��� �ְ� ���⼭ Ȯ�ΰ���
-- DEVELOPER������ ��ó�� Ȯ�ΰ����ϰ� �Ʒ��� CMD
SELECT *
FROM USER_CONSTRAINTS C1
    JOIN USER_CONSTRAINTS C2 USING(CONSTRATINS_NAME)
WHERE C1.TABLE_NAME = 'USER_UNIQUE';
-- �������Ǹ����� Ȯ���ϴ� ���
SELECT *
FROM USER_CONSTRAINTS C1
    JOIN USER_CONSTRAINTS C2 USING(CONSTRATINS_NAME)
WHERE C1.CONSTRATINS_NAME_NAME = 'SYS_C007021';


-- 2:00 - 2:03 ���ǽð�
-- ���� ����,CONSTRAINTS C1,C2


INSERT INTO USER_UNIQUE VALUES(2, 'user02', 'pass02', '���ǰ�','��','010-1111-2222','kang@k.k');
-- 1 �� ��(��) ���ԵǾ����ϴ�.


CREATE TABLE USER_UNIQUE2(
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


INSERT INTO USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ERROR :ORA-00001: unique constraint (KH.SYS_C007022) violated
INSERT INTO USER_UNIQUE2 VALUES(2, 'user02', 'pass02', '���ǰ�','��','010-1111-2222','kang@k.k');
-- 1 �� ��(��) ���ԵǾ����ϴ�.

CREATE TABLE USER_UNIQUE3 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO, USER_ID) -- �÷� 2�� ����
);  -- UNIQUE�� �÷� 2���� ���� ��� ���� �� ȿ����?
    -- USER_NO, USER_ID�� 1,��USER01���� �ϳ��� ���� ������ �� ���� �� �����Ǿ�� ����ũ ���������� �ߵ��ȴ�


INSERT INTO USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO USER_UNIQUE2 VALUES(2, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ���̵� �ߺ��ӿ��� �� ���Լ���
INSERT INTO USER_UNIQUE VALUES(1, 'user02', 'pass02', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO USER_UNIQUE2 VALUES(2, 'user02', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO USER_UNIQUE2 VALUES(2, 'user02', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ORA-00001: unique constraint (KH.SYS_C007050) violated
-- ���� 3���� ������ �߉����� �������͸� 4�����̶� ���ļ� ����
-- UNIQUE(USER_NO,USER_ID)���� USER_NO,USER_ID ���� �Ѽ�Ʈ�� ���� 
-- �� ���� �� ���ƾ� �����̰�ġ�� �ɷ� ����.



------------------------------------------------------------------------------
-- < �������� �̸�����>

CREATE TABLE CONS_NAME(
    TEST_DATA1 VARCHAR2(20) CONSTRAINT CN_TD1_NN NOT NULL, -- �������� �̸� ����
    TEST_DATA2 VARCHAR2(20) CONSTRAINT CN_TD2_UQ UNIQUE, -- ����ũ �÷�����, ���̺��� �� �� ��������
    TEST_DATA3 VARCHAR2(20),
    CONSTRAINT CN_TD3_UK UNIQUE(TEST_DATE3) -- ����ũ �÷�����, ���̺��� �� �� ��������
);
-- CN_TD1_NN �ǹ�
--    CN : ���̺� �̸�
--    TD1 : �÷� �̸�
--    NN : (��������) NOT NULL �ǹ�
--    UQ(UK) : (��������) UNIQUE

INSERT INTO CONS_NAME VALUES('Z','A','B');


------------------------------------------------------------------------------

-- PRIMARY KEY

-- PRIMARY KEY : NOT NULL + UNIQUE -> ���� �ĺ��� ����
-- �÷�����, ���̺��� �� �� ��������
-- NOT NULL + UNIQUE -> **���� �ĺ��� ����**
-- �� ���̺� �� �ѹ��� ���� ����
--    (���� �ĺ��ڴ� �����ѰŴ� �ϳ��� ����. �÷����� �ִٸ� �����ĺ� �Ұ���������)

CREATE TABLE USER_PRIMARYKEY (
    USER_NO NUMBER CONSTRAINT UP_UPO_PK PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

--DROP TABLE USER_PRIMARYKEY; -- �߸����� �����ϰ� �����

INSERT INTO USER_PRIMARYKEY VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO USER_PRIMARYKEY VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ERROR : ORA-00001: unique constraint (KH.UP_UPO_PK) violated
-- �ߺ� ���� // 1�� ���� PRIMARY KEY �������� �����ߴµ� ���� �����޼����� �� ����ũ�ϱ�?
INSERT INTO USER_PRIMARYKEY VALUES(NULL, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- ORA-01400: cannot insert NULL into ("KH"."USER_PRIMARYKEY"."USER_NO")
-- NULL�� ���� PRIMARY KEY �������� �����ߴµ� ���� �����޼����� �� NULL�ϱ�?

-- PRIMARY KEY�� ���� �����޽����� ����ũ,�ο� ���� �ߴ°� �´�. ���� ���̱� ����


CREATE TABLE USER_PRIMARYKEY2 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT UP2_UNO_UI_PK PRIMARY KEY(USER_NO, USER_ID) -- ���̺� ����
);
-- �����̸Ӹ� Ű ���̺� �� �ѹ��� ��밡��
-- ���� ����ũ���� �÷� 2���� �ϳ��� ��� �־��� ��, �� �����͸� �ϳ��� ���� �ֱ� ������ �浹X
-- PRIMARY KEY�� ��������

INSERT INTO USER_PRIMARYKEY2 VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO USER_PRIMARYKEY2 VALUES(1, 'user02', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO USER_PRIMARYKEY2 VALUES(2, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
INSERT INTO USER_PRIMARYKEY2 VALUES(2, 'user02', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k');
-- �ߺ� ���� 4�� �� ���� ����


------------------------------------------------------------------------------

-- FOREIGN KEY 
-- ����
-- �ܺ� ���̺��� ������ �� �÷�. �� �÷����� �����ϸ� ���
-- ���̺� ����, �÷� ���� �� �� ��������

-- �θ����̺� : ���� ���ϴ� ���̺�
-- �ڽ����̺� : �����ϴ� ���̺�


CREATE TABLE USER_GRADE (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');


CREATE TABLE USER_FOREIGNKEY  (
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT UF_GC_FK FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
    -- USER_GRADE(GRADE_CODE)�� �����ϰ� �ִ� (GRADE_CODE). FOREIGN KEY�� �Ἥ �̺κ��� �Ŀ��� ������Ŵ
);

INSERT INTO USER_FOREIGNKEY VALUES(1, 'user01', 'pass01', '���ǰ�','��','010-1111-2222','kang@k.k',10);
INSERT INTO USER_FOREIGNKEY VALUES(2, 'user02', 'pass02', '������','��','010-1111-2222','nam@k.k',10);
INSERT INTO USER_FOREIGNKEY VALUES(3, 'user03', 'pass03', '�����','��','010-1111-2222','do@k.k',30);
INSERT INTO USER_FOREIGNKEY VALUES(4, 'user04', 'pass04', '�����','��','010-1111-2222','ryu@k.k',NULL);
-- �����ϴ� ���̺�(=�θ����̺�)�� ���� �÷� �� �ܿ� null ���� ����
INSERT INTO USER_FOREIGNKEY VALUES(5, 'user05', 'pass05', '���̹�','��','010-1111-2222','moon@k.k',50);
-- ERROR : ORA-02291: integrity constraint (KH.UF_GC_FK) violated - parent key not found
-- ������ ��������(integrity constraint)���� : �θ����̺� ���� ���� �����ؼ� �����߻�


COMMIT; -- ������ Ȯ��


DELETE FROM USER_GRADE -- �����ͻ���
WHERE GRADE_CODE = 10;
-- ERROR : ORA-02292: integrity constraint (KH.UF_GC_FK) violated - child record found
-- ������ ��������(integrity constraint)���� : �ڽ����̺��� �����ؼ� ���� �� ����
-- ���� : GRADE_CODE = 10�� �θ����̺��̰� �긦 �����ϰ� �ִ� �ڽ����̺� ������ ���� �Ұ�
-- ���������� �ɷ������� ���� �Ұ�

DELETE FROM USER_GRADE -- �����ͻ���
WHERE GRADE_CODE = 20; -- ��� ���� ����
-- 20�� �����ϴ� �ڽ��� ��� ���� ����

ROLLBACK; -- ������ COMMIT�� ���·� �ǵ���
-- ���̺� �����Ϳ��� �����ǰ� ���� �Ǵ� ���� ���ΰ�ħ�ؼ� Ȯ�ΰ���


------------------------------------------------------------------------------

-- <���������� �ɷ��־ ������ �� �ִ� ���>
-- ON DELETE SET NULL
-- �θ� Ű ���� �� �ڽ� Ű�� NULL�� ����

CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE2 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE2 VALUES(20, '���ȸ��'); 
INSERT INTO USER_GRADE2 VALUES(30, 'Ư��ȸ��');

CREATE TABLE USER_FOREIGNKEY2(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT UF2_GC_FK FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL -- ON DELETE SET NULL : �θ� Ű ���� �� �ڽ� Ű�� NULL�� ����
);/* ERROR �߻�
ORA-02264: name already used by an existing constraint
02264. 00000 -  "name already used by an existing constraint"
*Cause:    The specified constraint name has to be unique.
*Action:   Specify a unique constraint name for the constraint.
*/

-- ���̺��� �߸������ؼ� ��� :DROP TABLE
-- DROP TABLE USER_FOREIGNKEY2 CASCADE CONSTRAINTS; -- �������Ǳ��� ���� ����� DROP

INSERT INTO USER_FOREIGNKEY2 VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang@k.k', 10);
INSERT INTO USER_FOREIGNKEY2 VALUES(2, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam@n.n', 10);
INSERT INTO USER_FOREIGNKEY2 VALUES(3, 'user03', 'pass03', '�����', '��', '010-3333-2222', 'do@d.d', 30);
INSERT INTO USER_FOREIGNKEY2 VALUES(4, 'user04', 'pass04', '�����', '��', '010-2222-1111', 'ryu@r.r', NULL);

COMMIT; -- ������ Ȯ��

-- ������ ������ �� ������ Ȯ��
SELECT * FROM USER_GRADE2;
SELECT * FROM USER_FOREIGNKEY2;


DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10; -- 1 �� ��(��) �����Ǿ����ϴ�.
-- ���� SELECT * FROM USER_GRADE2; ��ɹ� �����غ��� ����Ʈ���� ������ �� Ȯ�ΰ���
-- ���� SELECT * FROM USER_FOREIGNKEY2; ��ɹ� �����غ��� 10�� ���ִ� ���� ������

-- ON DELETE SET NULL
-- �θ� Ű ���� �� �ڽ� Ű�� NULL�� ����

/*
-- �ڵ� ���̸� �Ẽ ��
-- �ϰ� ���� �� �����...
DROP TABLE USER_FOREIGNKEY CASCADE CONSTRAINTS;
DROP TABLE USER_FOREIGNKEY2 CASCADE CONSTRAINTS;
DROP TABLE USER_FOREIGNKEY3 CASCADE CONSTRAINTS;
DROP TABLE USER_GRADE CASCADE CONSTRAINTS;
DROP TABLE USER_GRADE2 CASCADE CONSTRAINTS;
DROP TABLE USER_GRADE3 CASCADE CONSTRAINTS;
*/

------------------------------------------------------------------------------


-- ON DELETE CASCADE
-- �θ� Ű ���� ��, �ڽ� Ű�� �Բ� ����

CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
-- �θ����̺� USER_GRADE3�� �� �ֱ� : INSERT
INSERT INTO USER_GRADE3 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE3 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE3 VALUES(30, 'Ư��ȸ��');

CREATE TABLE USER_FOREIGNKEY3(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT UF3_GC_FK FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
    -- ON DELETE CASCADE : �θ� Ű ���� ��, �ڽ� Ű�� �Բ� ����
);

INSERT INTO USER_FOREIGNKEY3 VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang@k.k', 10);
INSERT INTO USER_FOREIGNKEY3 VALUES(2, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam@n.n', 10);
INSERT INTO USER_FOREIGNKEY3 VALUES(3, 'user03', 'pass03', '�����', '��', '010-3333-2222', 'do@d.d', 30);
INSERT INTO USER_FOREIGNKEY3 VALUES(4, 'user04', 'pass04', '�����', '��', '010-2222-1111', 'ryu@r.r', NULL);


COMMIT; -- ������ Ȯ��

-- ������ ������ �� ������ Ȯ��
SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FOREIGNKEY3;


DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10; 
-- ���� SELECT * FROM USER_GRADE3; ��ɹ� �����غ��� ����Ʈ���� ������ �� Ȯ�ΰ���
-- ���� SELECT * FROM USER_FOREIGNKEY3; ��ɹ� �����غ��� 10�� ���ִ� ���� ������
-- 10�� �� �����Ͱ� ���� �����Ǿ��ִ�



------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- CHECK
-- 
-- ������ ���� ������ ������ ������ ������ ���� ���

CREATE TABLE USER_CHECK(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10)CHECK(GENDER IN('��','��')), -- GENDER�� ���� ���� ���� �������� ����
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);


INSERT INTO USER_CHECK VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang@k.k');
INSERT INTO USER_CHECK VALUES(2, 'user02', 'pass02', '������', '����', '010-2222-3333', 'nam@n.n');
-- ERROR : ORA-02290: check constraint (KH.SYS_C007063) violated
-- ���� : '��'�� '��'�� ���Բ� ���� �ɾ���µ� '����'�� �־��⿡ ���� �߻�



-- �̹��� ���̺� ���̺� �־��

CREATE TABLE USER_CHECK2(
    TEST_NUMBER NUMBER,
    CONSTRAINT UC2_TN_CK CHECK(TEST_NUMBER >0 )
);


INSERT INTO USER_CHECK2 VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang@k.k');
INSERT INTO USER_CHECK2 VALUES(2, 'user02', 'pass02', '������', '����', '010-2222-3333', 'nam@n.n');
-- ERROR : ORA-02290: check constraint (KH.SYS_C007063) violated
-- ���� : '��'�� '��'�� ���Բ� ���� �ɾ���µ� '����'�� �־��⿡ ���� �߻�


INSERT INTO USER_CHECK2 VALUES(10);
INSERT INTO USER_CHECK2 VALUES(-1);


-- [�ǽ� ����] --
-- �ǽ� ���� ���� ���״� ���� ������ ���߿� ��������. �ϴ� ��� ��������
-- Ǯ� ��
--CREATE TABLE USER_TEST(
--    USER_NO NUMBER PRIMARY KEY,
--    USER_ID VARCHAR2(20) CONSTRAINT UQ_UT_USERID UNIQUE,
--    USER_PWD VARCHAR2(20) CONSTRAINT NN_UT_USERPWD NOT NULL,
--    PNO VARCHAR2(20)CONSTRAINT UQ_UT_PNO UNIQUE CONSTRAINT NN_UT_PNO NOT NULL ,
--    GENDER VARCHAR2(3)CONSTRAINT CK_UT_GENDER CHECK(GENDER IN('��','��')), -- GENDER�� ���� ���� ���� �������� ����
--    PHONE VARCHAR2(20) CONSTRAINT AA,
--    ADDRESS VARCHAR2(100)CONSTRAINT  BB,
--    STATUS VARCHAR2(3) CONSTRAINT NN_UT_STATUS NOT NULL CONSTRAINT CK_UT_STATUS CHECK(STATUS IN('Y','N'))
--);    
--INSERT INTO USER_TEST VALUES(1, 'user01', 'pass01', '000101-3010101', '��', '010-1111-2222', '����','Y');
--INSERT INTO USER_TEST VALUES(2, 'user02', 'pass01', '000101-3010101', '��', '010-1111-2222', '����','Y');

DROP TABLE USER_TEST CASCADE CONSTRAINTS;

-- ��� ���
CREATE TABLE USER_TEST(
    USER_NO NUMBER CONSTRAINT PK_UT_USERNO PRIMARY KEY,
    USER_ID VARCHAR2(20) CONSTRAINT UQ_UT_USERID UNIQUE,
    USER_PWD VARCHAR2(20) CONSTRAINT NN_UT_USERPWD NOT NULL, -- 
    PNO VARCHAR2(20)CONSTRAINT NN_UT_PNO NOT NULL, -- �������� 2�������ε� ���̺� ���� �̿��� ��
    GENDER VARCHAR2(3)CONSTRAINT CK_UT_GENDER CHECK(GENDER IN('��','��')), -- GENDER�� ���� ���� ���� �������� ����
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(100),
    STATUS VARCHAR2(3) CONSTRAINT NN_UT_STATUS NOT NULL,
    CONSTRAINT UQ_UT_PNO UNIQUE(PNO),
    CONSTRAINT CK_UT_STATUS CHECK(STATUS IN('Y','N'))
);    

COMMENT ON COLUMN USER_TEST.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN USER_TEST.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USER_TEST.USER_PWD IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN USER_TEST.PNO IS '�ֹι�ȣ';
COMMENT ON COLUMN USER_TEST.GENDER IS '����';
COMMENT ON COLUMN USER_TEST.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN USER_TEST.ADRESS IS '�ּ�';
COMMENT ON COLUMN USER_TEST.STATUS IS 'Ż�𿩺�';
    
INSERT INTO USER_TEST VALUES(1, 'user01', 'pass01', '000101-3010101', '��', '010-1111-2222', '����','N');
INSERT INTO USER_TEST VALUES(2, 'user02', 'pass02', '000101-3010102', '��', '010-1111-2222', '����','N');
INSERT INTO USER_TEST VALUES(3, 'user03', 'pass03', '000101-3010103', '��', '010-1111-2222', '����','N');
INSERT INTO USER_TEST VALUES(4, 'user04', 'pass04', '000101-3010104', '��', '010-1111-2222', '����','N');
INSERT INTO USER_TEST VALUES(5, 'user05', 'pass05', '000101-3010105', '��', '010-1111-2222', '����','N');


SELECT * FROM USER_TEST;




------------------------------------------------------------------------------
------------------------------------------------------------------------------



-- SUBQUERY�� �̿��� ���̺� ����


CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;


CREATE TABLE EMPLOYE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME 
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYE_COPY2;


------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- ALTER
-- ���̺� ����
-- ���̺� ���� �� �������� �ڿ� �߰� ����

/*
ADD UNIQUE(�÷���);
ADD PRIMARY KEY(�÷���);
ADD FOREIGN KEY(�������� �ڽ����̺� �÷���) REFERENCE**S** �θ����̺��(������ �÷���);
MODIFY �÷��� NOT NULL;

*/

-- �̹� ���̺� ����ſ� �������� �ڿ� �߰� ����
-- ���� �� ������� �ƴ� �߰����
-- �׷� �̶� ���������� ���� �ɱ�? �÷���
-- �÷��� ���̺� ����� ���� ���
-- ���̺��� ��ü�̹Ƿ� ���̺�(=��ü) ������ ALTER ���
CREATE TABLE USER_GRADE4(
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(30)
); -- Table USER_GRADE4��(��) �����Ǿ����ϴ�.
ALTER TABLE USER_GRADE4 ADD PRIMARY KEY(GRADE_CODE);
-- Table USER_GRADE4��(��) ����Ǿ����ϴ�.

-- �������� �̸� ���̺� ���� �� �߰��ϰ� �ʹٸ�?
ALTER TABLE USER_GRADE4 ADD CONSTRAINT UG4_GC_PK PRIMARY KEY(GRADE_CODE);






------------------------------------------------------------------------------


-- �������� �̸� ���̺� ���� �� �߰��ϰ� �ʹٸ�?
-- ALTER TABLE 

CREATE TABLE USER_FOREIGNKEY4(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),    -- UNIQUE
    USER_PWD VARCHAR2(30),   -- NOT NUL
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),     -- CHECK
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER        -- FOREIGN KEY
);

ALTER TABLE USER_FOREIGNKEY4 ADD UNIQUE(USER_ID);      -- UNIQUE �������� �߰�
ALTER TABLE USER_FOREIGNKEY4 MODIFY USER_PWD NOT NULL; -- NOT NULL ���� ��� MODIFY �ڿ� ���
ALTER TABLE USER_FOREIGNKEY4 ADD CHECK (GENDER IN('��','��'));
ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4(GRADE_CODE);

ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4; --(GRADE_CODE) ����
--(GRADE_CODE) ����
-- �����ϴ� ���̺� �÷��� ���������ϴ°� �ƴѰ�?
-- ������ ������ ��찡 �ִ�
-- ���� : �����ϴ� ���̺� PRIMARY KEY�� ������ �����ϸ� �÷��� ��������

COMMIT;


-- <�̴� �ǽ� ����>
-- DEPARTMENT ���̺��� LOCATION_ID�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� LOCATION, ���� �÷��� LOCATION�� �⺻Ű


ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);
-- �� �� ����


ROLLBACK;



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

/*
DDL(Date Definition language) : ������ ���Ǿ�  - CREATE, ALTER, DROP

DML (Data Manipulation Language) :  ������ ���۾� - INSERT, UPDATE,DELETE,SELECT(DQL)

TCL(Transaction Ccontrol Language) : Ʈ����� ���� - COMMIT, ROLLBACK





INSERT(������ ����), UPDATE(������ ����),DELETE(������ ����),SELECT(DQL)


-- INSERT
������ ���� = �� �߰� �� ���̺� �� ���� ����

���� �μ�Ʈ �ڿ� ()�� ������ . �÷� ����

*/

INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,
            SAL_LEVEL, SALARY, BONUS, MANAGER_ID,HIRE_DATE, ENT_YN, ENT_DATE)
VALUES(900,'���ǰ�','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,'N',NULL);                      
            
SELECT * FROM EMPLOYEE;

ROLLBACK;

DELETE
            
-- ���̺��� ��� �÷��� ���� ���� ���� �÷��� ��ø� ���� ����            
-- INSERT ��, �÷����� �����Ϸ��� ���̺� �ִ� �÷� ������ ��Ȯ�� ���Ѽ� �־�� ��
INSERT INTO EMPLOYEE -- �÷��� ��úκ� ����
VALUES(900,'���ǰ�','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,'N',NULL);            
-- ORA-01841: (full) year must be between -4713 and +9999, and not be 0
-- ���� : ENT_YN,ENT_DATE�� ������ �ٲ㼭 �����߻�
-- �÷����� ����ϴ� ��쿡�� ����� ������ ���� �����͸� ������ �ǰ�, 
-- ���� �ÿ��� ���̺� �ִ� �÷��� ������ ����� �Ѵ�        
        
        
INSERT INTO EMPLOYEE -- �÷��� ��úκ� ����
VALUES(900,'���ǰ�','990311-1451201','kang_kk@kh.or.kr','01011112222',
        'D1','J7','S3',4300000,0.2,200,SYSDATE,NULL,'N');          
        
SELECT * FROM EMPLOYEE;
COMMIT;
     

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_01(EMP_ID,EMP_NAME) VALUES(999,'������'); 
-- ���̺��� �÷� ���ΰ� �ƴ� ���ϴ� �����͸� ���԰���
SELECT * FROM EMP_01;
-- ������ ��ȸ ��� : 999	������ (NULL) <- DEPT_TITLE�� �μ��� �ȳ־�ּ� NULL

-- ���������� INSERT�ϱ�
INSERT INTO EMP_01(
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE
            LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);
SELECT * FROM EMP_01; -- 25��


------------------------------------------------------------------------------
--����:5.1. SQL Ȱ�� (��ü����)


-- INSERT ALL
-- INSERT �� ���������� ����ϴ� ���̺��� ���� ��� �� ���� ���� ����
-- ���� 2��

-- WHEN ���� ������ ������ �����ϴ� �����͸� ���̺��� ������ ����
        
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID,EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0; 
-- WHERE�� : ������ �޴� ��. 1 = 0�̶�°� 1�� 0�� �ƴϱ⿡ ������� FALSE
-- ������� FALSE�̱⿡ ���õ� �÷��� �ְ� �����ʹ� ���� ������ ��
-- ��, WHERE���� 1=0 ������ �����ϴ� ���� �����Ƿ�, ����ִ� ���̺��� �����ȴ�
-- �� �ڵ带 ���� ���� : �����ʹ� �ʿ� ���� ������ ���� ���� ��

SELECT * FROM EMP_DEPT_D1;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0; -- ������ ����

SELECT * FROM EMP_MANAGER;



-- EMP_DEPT_D1 ���̺� EMPLOYEE ���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ��
-- ���, �̸�, �ҼӺμ�, �Ի��� ����
-- EMP_MANAGER���̺� EMPLOYEE ���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ��
-- ���, �̸�, ������ ��� ����

INSERT INTO EMP_DEPT_D1(
            SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
            FROM EMPLOYEE
            WHERE DEPT_CODE = 'D1');
INSERT INTO EMP_MANAGER(
            SELECT EMP_ID, EMP_NAME,MANAGER_ID
            FROM EMPLOYEE
            WHERE DEPT_CODE = 'D1');

SELECT * FROM EMP_DEPT_D1;
SELECT * FROM EMP_MANAGER;
-- ���� INSERT�� �����͸� ���� ���� ��
ROLLBACK;

INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME,MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID -- ��������
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
-- INSERT ALL + SUBQUERY�� �� ������ �� ���̺��� �ѹ��� �߰�    
-- INSERT ALL �� ���̺� ���ǿ� �°� INSERT



-- EMPLOYEE���̺��� ������ �����Ͽ� ���, �̸�, �Ի���, �޿��� ����� �� �ִ�
-- ���̺� EMP_OLD�� EMP_NEW ����
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;


-- EMPLOYEE���̺��� �Ի��� �������� 2000�� 1�� 1�� ������ �Ի��� �����
-- ���, �̸�, �Ի���, �޿��� EMP_OLD���̺�,
-- 2000�� 1�� 1�� ���Ŀ� �Ի��� ����� ���, �̸�, �Ի���, �޿��� EMP_NEW���̺� ����
-- ���1 : ���� INSERT
-- ���2 : INSERT ALL

-- INSERT ALL ���1
INSERT ALL -- �� ���̺� ������ �޶� WHEN�� �ѹ��� ���� ���� ����
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

-- INSERT ALL ���2
INSERT ALL -- �� ���̺� ������ �޶� WHEN�� �ѹ��� ���� ���� ����
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
ELSE -- ������ ���� �ƴϸ� �����̱⿡ ELSEó�� ����
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
-- SELECT * -- VALUES���� �÷��� �����ϱ� ������ SELECT * ������ ����X
FROM EMPLOYEE;


COMMIT;


------------------------------------------------------------------------------
---------------------------------UPDATE--------------------------------------
------------------------------------------------------------------------------


-- UPDATE

-- ����
-- ������ �����̶� ��ü �࿡�� ��ȭX

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;


--DEPT_COPY���̺��� DEPT_ID�� D9�� ���� DEPT_TITLE�� ������ȹ������ ����
UPDATE DEPT_COPY -- �� ��������?
SET DEPT_TITLE = '������ȹ��' -- ��� ��������?
WHERE DEPT_ID = 'D9';
-- D9�� �ѹ��ο��� ������ȹ������ �����



------------------------------------------------------------------------------






------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------






























