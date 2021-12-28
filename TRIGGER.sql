-- 트리거 -> 자동으로 저장 / 수정,삭제,추가 등 작업이 발생하면 자동으로 실행되는 코드.
-- 전체 운영 실습

INSERT INTO memberTBL VALUES ('Figure', '연아', '경기도 군포시 당정동');

SELECT * FROM memberTBL

UPDATE memberTBL SET memberAddress = '서울 강남구 역삼동' WHERE memberName = '연아';

DELETE memberTBL WHERE memberName = '연아';

-- 테이블 생성
CREATE TABLE deleteMemberTBL
( memberID char(8),
  memberName nchar(5),
  memberAddress nchar(20),
  deletedDate date -- 삭제한 날짜
  );

go
CREATE TRIGGER trg_deleteMemberTBL -- 트리거 이름
ON memberTBL -- 트리거를 부착할 테이블
AFTER DELETE -- 삭제 후에 작동하게 지정
AS
	-- deleted 테이블의 내용을 백업테이블에 삽입
	INSERT INTO deleteMemberTBL
		SELECT memberID, memberName, memberAddress, GETDATE() FROM deleted;

SELECT * FROM memberTBL;
SELECT * FROM deleteMemberTBL;

