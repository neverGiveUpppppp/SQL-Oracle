------------------------------------------------------------------------------
---------------------------------TRIGGER--------------------------------------
------------------------------------------------------------------------------

-- TRIGGER

-- ���̺��̳� �䰡 DML(INSERT, UPDATE, DELETE)�� ���� ����� ��� 
-- �ڵ����� ����� ������ ������ '��ü'

-- ��Ƽ谡 ���� �� �ٸ� ���� �����ϴ� ��

-- ���� ���迡 �ִ� �� ���̺��� �ϳ��� ���̺� ����,����,���� ���� �������� 
-- ���̺��� ������ �ٲ���� �� �������� �ϰ����� ���Ἲ ������ ���ؼ� 
-- �̿� ���õ� ���̺� ���������� ������ �̷���� �� �ֵ��� �ϴ� ���� ���Ѵ�.


/*

-- ����
SQL���� ���� �ñ⿡ ���� �з�
    BEFORE TRIGGER : SQL�� ���� �� Ʈ���� ����
    AFTER  TRIGGER : SQL�� ���� �� Ʈ���� ����
SQL���� ������ �޴� ROW�� ���� �з�
    STATEMENT TRIGGER : DEFAULT TIGGER, ��ü������ �� ���� ����
    ROW TRIGGER : SQL�� �� ROW�� �� ���� ���� // �� �ุ ����
        FOR EACH ROW �ɼ� �ۼ��ؾ� �ν�
            OLD ���� ���� ���� �� ex)UPDATE ���� ������, DELETE�� �� �ڷ�
            NEW ���� ���� ���� �� ex)UPDATE ���� ������, INSERT�� �� �ڷ�


-- ǥ����

CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ� 
BEFORE | AFTER -- SQL ���� ������ ������ ����
INSERT| UPDATE | DELETE  -- UPDATE ������ ������ ��
ON ���̺��
[FOR EACH ROW] -- STATEMENT���� ROW TRIGGER���� ����
[WHEN ����]

DECLARE
    �����
BEGIN
    �����
EXCEPTION
    ����ó����
END;
/

[] : ��������

*/
------------------------------------------------------------------------------


-- EMPLOYEE���̺� ����� �߰��Ǹ� '���Ի���� �Ի��߽��ϴ�'��� 
-- ������ �ڵ� ����ϴ� TRG_01 Ʈ���� ����
-- ��� �߰��Ǹ� //' ' ���� �ڵ� ��� //Ʈ���� ����

CREATE OR REPLACE TRIGGER TRG_01
AFTER -- ���� ���� ������? INSERT 
INSERT -- ��� ���� INSERT AFTER? 
ON EMPLOYEE
-- CREATE OR REPLACE TRIGGER TRG_01
-- AFTER INSERT ON EMPLOYEE
BEGIN
     DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�');
END;
/
-- TRIGGER ����

INSERT INTO EMPLOYEE VALUES(908,'������','740214-1210121','nam@n.n','01022223333',
                            'D5','J3','S5',3000000,0.1,200,SYSDATE,NULL,DEFAULT);
                            
SELECT * FROM EMPLOYEE; -- 908 �߰������ Ȯ��       

/*
���ǽð� 4:10-20
Ʈ���Ű� ���� ���Ǵ� �κ��� ����
��ȭ

������� ���̻��
����ؼ� +10
��� -5
��ǥ���̰� �θ�����

*/
-- ��ǰ ���� ���̺�
CREATE TABLE PRODUCT(
    PCODE NUMBER PRIMARY KEY, -- ��ǰ �ڵ�
    PNAME VARCHAR2(30),       -- ��ǰ �̸�
    BRAND VARCHAR2(30),       -- �귣��  
    PRICE NUMBER,             -- ����
    STOCK NUMBER DEFAULT 0    -- ���
);
-- ����� �� �̷� ���̺�
CREATE TABLE PRO_DETAIL(
    DCODE NUMBER PRIMARY KEY,   -- �� �ڵ�
    PCODE NUMBER,               -- ��ǰ �ڵ�
    PDATE DATE,                 -- ��ǰ �������
    AMOUNT NUMBER,              -- ����� ����
    STATUS VARCHAR2(10) CHECK(STATUS IN('�԰�','���')), -- ����
    FOREIGN KEY(PCODE) REFERENCES PRODUCT
);

-- PK �����ĺ��ڿ� ������ ����
CREATE SEQUENCE SEQ_PCODE;
CREATE SEQUENCE SEQ_DCODE;

INSERT INTO PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������','�Ե�',2000,DEFAULT);
INSERT INTO PRODUCT VALUES(SEQ_PCODE.NEXTVAL, 'Ȩ����','����',2500,DEFAULT);
INSERT INTO PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '���ϸ�','�︳',1500,DEFAULT);
    
SELECT * FROM PRODUCT;

-- �԰�Ǹ� �԰��� ��ŭ STOCK ����
-- ���Ǹ� ����� ��ŭ STOCK ����
-- Ʈ���Ÿ� �Ⱦ��� �� �ֹ����� ������ ��ŭ ���� ���� ��������

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON PRO_DETAIL -- ����� ���� �߰��Ǹ��̶� ������
FOR EACH ROW -- �� �ึ�� // ROW TRIGGER ���� OLD/NEW�� �����������
BEGIN -- PRO_DETAIL�� ��ǰ(�ڵ�)�� �߰��Ǹ� ������ Ʈ���Ÿ� �ڵ� ��
     -- Ʈ���� ��Ÿ� ���� ������ �ɱ�? STATUS �������ͽ��� ���� ���(�����)�� �� ��������
    -- ��ǰ�� �԰�� ���
    -- ��ǰ�� ���� ���

    -- ��ǰ�� �԰�� ���
    IF :NEW.STATUS = '�԰�' -- ���� ����(:NEW) STATUS�� �԰�� THEN ���� �ض�� �ǹ�. 
    THEN                   -- �� NEW�� ���� �־��� ���� �ǹ��ϰ� ROW TRIGGER OLD/NEW�� �� NEW.
        UPDATE PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT -- STOCK�� ���� ���� ��(:NEW.AMOUNT)��ŭ SET�ش޶�� �ǹ�. 
        WHERE PCODE = :NEW.PCODE; -- :NEW�� ROW TRIGGER������ ���̴� ���۷���
    END IF;
    
    -- ��ǰ�� ���� ���
    IF :NEW.STATUS = '���'
    THEN
        UPDATE PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE; 
    END IF;
END;
/

SELECT * FROM PRODUCT;    -- ���� ��ǰ ��� ��ȸ
SELECT * FROM PRO_DETAIL; -- ����� �� ��� ��ȸ

INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 20, '�԰�'); -- 3����ǰ ���ϸ�
-- INSERT�� �ߴµ� TRIGGER ���� SELECT * FROM PRODUCT;��ȸ�غ��� ���ϸ� 20�� �߰��Ǿ�����
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 5, '�԰�'); -- 1����ǰ ������
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 10, '�԰�');

INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 19, '���'); -- -19�Ǽ� ���ϸ� 1������ // SELECT * FROM PRODUCT;
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 2, '���');

SELECT * FROM PRODUCT;    -- ���� ��ǰ ��� ��ȸ
SELECT * FROM PRO_DETAIL; -- ����� �� ��� ��ȸ

SELECT * FROM USER_TRIGGERS; -- ��ü Ʈ���� Ȯ�� �ڵ�

-----------------------------------------------------------------------------
------------------------------------------------------------------------------


------------------------------------------------------------------------------







------------------------------------------------------------------------------
------------------------------------------------------------------------------




------------------------------------------------------------------------------
------------------------------------------------------------------------------
