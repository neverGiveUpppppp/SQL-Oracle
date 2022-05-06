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
    
-- 서브쿼리 사용    
SELECT *
FROM (SELECT BOARD_ID, BOARD_TYPE, CATE_ID, CATE_NAME, BOARD_TITLE, BOARD_CONTENT, BOARD_WRITER, NICKNAME, BOARD_COUNT, CREATE_DATE, b.MODIFY_DATE, b.STATUS
FROM BOARD b
    JOIN MEMBER ON(USER_ID = BOARD_WRITER)
    JOIN CATEGORY USING(CATE_ID )
WHERE B.STATUS = 'Y' AND BOARD_TYPE = 1
ORDER BY BOARD_ID DESC)
WHERE ROWNUM <= 10;
--WHERE ROWNUM <= 20 AND ROWNUM >= 11; 
-- ROWNUM은 ~이하는 먹는데 이상 이하 같은 조건은 작동X
-- ROWNUM을 안쓰면 간단하게 해결 가능


-- 3. M이상 N이하에 있는 게시물 가져오기
SELECT *
FROM(SELECT ROWNUM RNUM, DESCBOARD.* -- 아스트로라고만 하면 에러남. 별칭 꼭 .찍어서 명시해줄 것
FROM (SELECT BOARD_ID, BOARD_TYPE, CATE_ID, CATE_NAME, BOARD_TITLE, BOARD_CONTENT, BOARD_WRITER, NICKNAME, BOARD_COUNT, CREATE_DATE, b.MODIFY_DATE, b.STATUS
    FROM BOARD b
        JOIN MEMBER ON(USER_ID = BOARD_WRITER)
        JOIN CATEGORY USING(CATE_ID )
    WHERE B.STATUS = 'Y' AND BOARD_TYPE = 1
    ORDER BY BOARD_ID DESC) DESCBOARD)
WHERE ROWNUM <= 20 AND RNUM >= 11; -- ROWNUM의 별칭 RNUM이 ROWNUM 대체 안되는 이유 : SELECT보다 WHERE가 먼저 읽히기 때문
                                -- 이렇기 때문에 한번 더 SELECT로 또 인라인뷰를 넣어주면 됨
-- 강의시간 3:06
-- 20이랑 11의 숫자만 위치홀더로 바꿔서 자바코드에 넣으면 됨
-- 코드가 길어서 심플하게 해보자


-- 4.VIEW 활용한 심플화된 코드
-- 뷰를 사용할려면 먼저 권한부여가 필요
GRANT CREATE VIEW TO JSP_Servlet; -- 시스템계정으로 가서 권한부여
CREATE OR REPLACE VIEW BLIST -- 뷰 생성해야하니 계정생성 때처럼 이것만 코드실행해서 생성할 것
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



    
    



