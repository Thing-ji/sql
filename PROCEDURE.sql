-- 프로시저 -> 프로그램 기능 / 아래의 두 테이블을 자동으로 실행시킴.
CREATE PROCEDURE myProc1
AS
	SELECT * FROM memberTBL WHERE memberName = '탕탕히';
	SELECT * FROM productTBL WHERE productName = '냉장고';

go
EXECUTE myProc1;