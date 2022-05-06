begin
    for i in 1..97
    loop
        insert into board values(seq_bid.nextval, 1, 10, i, i+100, 'admin', default,
                                        sysdate, sysdate, default);
    end loop;
end;
/
commit;

SELECT BOARD_ID, BOARD_TYPE, CATE_ID, CATE_NAME, BOARD_TITLE, BOARD_CONTENT, BOARD_WRITER, NICKNAME, BOARD_COUNT, CREATE_DATE, b.MODIFY_DATE, b.STATUS
FROM BOARD b
    JOIN MEMBER ON(USER_ID = BOARD_WRITER)
    JOIN CATEGORY USING(CATE_ID)
WHERE B.STATUS = 'Y' AND BOARD_TYPE = 1
ORDER BY BOARD_ID DESC;
    
-- �������� ���    
SELECT *
FROM (SELECT BOARD_ID, BOARD_TYPE, CATE_ID, CATE_NAME, BOARD_TITLE, BOARD_CONTENT, BOARD_WRITER, NICKNAME, BOARD_COUNT, CREATE_DATE, b.MODIFY_DATE, b.STATUS
FROM BOARD b
    JOIN MEMBER ON(USER_ID = BOARD_WRITER)
    JOIN CATEGORY USING(CATE_ID )
WHERE B.STATUS = 'Y' AND BOARD_TYPE = 1
ORDER BY BOARD_ID DESC)
WHERE ROWNUM <= 10;
--WHERE ROWNUM <= 20 AND ROWNUM >= 11; 
-- ROWNUM�� ~���ϴ� �Դµ� �̻� ���� ���� ������ �۵�X
-- ROWNUM�� �Ⱦ��� �����ϰ� �ذ� ����


-- 3. M�̻� N���Ͽ� �ִ� �Խù� ��������
SELECT *
FROM(SELECT ROWNUM RNUM, DESCBOARD.* -- �ƽ�Ʈ�ζ�� �ϸ� ������. ��Ī �� .�� ������� ��
FROM (SELECT BOARD_ID, BOARD_TYPE, CATE_ID, CATE_NAME, BOARD_TITLE, BOARD_CONTENT, BOARD_WRITER, NICKNAME, BOARD_COUNT, CREATE_DATE, b.MODIFY_DATE, b.STATUS
    FROM BOARD b
        JOIN MEMBER ON(USER_ID = BOARD_WRITER)
        JOIN CATEGORY USING(CATE_ID )
    WHERE B.STATUS = 'Y' AND BOARD_TYPE = 1
    ORDER BY BOARD_ID DESC) DESCBOARD)
WHERE ROWNUM <= 20 AND RNUM >= 11; -- ROWNUM�� ��Ī RNUM�� ROWNUM ��ü �ȵǴ� ���� : SELECT���� WHERE�� ���� ������ ����
                                -- �̷��� ������ �ѹ� �� SELECT�� �� �ζ��κ並 �־��ָ� ��
-- ���ǽð� 3:06
-- 20�̶� 11�� ���ڸ� ��ġȦ���� �ٲ㼭 �ڹ��ڵ忡 ������ ��
-- �ڵ尡 �� �����ϰ� �غ���


-- 4.VIEW Ȱ���� ����ȭ�� �ڵ�
-- �並 ����ҷ��� ���� ���Ѻο��� �ʿ�
GRANT CREATE VIEW TO JSP_Servlet; -- �ý��۰������� ���� ���Ѻο�
CREATE OR REPLACE VIEW BLIST -- �� �����ؾ��ϴ� �������� ��ó�� �̰͸� �ڵ�����ؼ� ������ ��
AS
SELECT ROWNUM RNUM, DESCBOARD.*
FROM (SELECT BOARD_ID, BOARD_TYPE, CATE_ID, CATE_NAME, BOARD_TITLE, BOARD_CONTENT, BOARD_WRITER, NICKNAME, BOARD_COUNT, CREATE_DATE, b.MODIFY_DATE, b.STATUS
    FROM BOARD b
        JOIN MEMBER ON(USER_ID = BOARD_WRITER)
        JOIN CATEGORY USING(CATE_ID )
    WHERE B.STATUS = 'Y' AND BOARD_TYPE = 1
    ORDER BY BOARD_ID DESC) DESCBOARD;

SELECT * FROM BLIST
WHERE ROWNUM <= 11 AND RNUM <= 20;



    
    



