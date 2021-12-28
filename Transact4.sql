-- WITH절
-- SELECT로 임시로 구해진 테이블을 잠시 생성하여 그 테이블을 가지고 다시 SELELCT 하는 것.
USE sqlDB;
SELECT userID AS [사용자], SUM(price*amount) AS [총구매액]
	FROM buyTbl
	GROUP BY userID

SELECT * FROM abc ORDER BY 총구매액 DESC

-- 위의 구문을 하나로 WITH절 사용.
-- 예제1
WITH abc(userID, total)
AS
( SELECT userID, SUM(price*amount)
	FROM buyTbl
	GROUP BY userID)
SELECT * FROM abc ORDER BY total DESC;


-- 예제2
WITH cte(addr, maxHeight)
AS
( SELECT addr, MAX(height)
	FROM userTbl
	GROUP BY addr)
SELECT AVG(maxHeight*1.0) AS [각 지역별 최고키의 평균] FROM cte

-- 예제3
WITH
AAA(userID, total)
	AS
		(SELECT userID, SUM(price*amount) FROM buyTbl GROUP BY userID),
BBB(sumtotal)
	AS
		(SELECT SUM(total) FROM AAA),
CCC(sumavg)
	AS
		(SELECT sumtotal / (SELECT count(*) FROM buyTbl) FROM BBB)
SELECT * FROM CCC;


---------------------------------------------------------------------

-- INSERT문
USE tempdb
CREATE TABLE testTbl1 (id int, userName nchar(3), age int);
GO
INSERT INTO testTbl1 VALUES (1, '홍길동', 25);
INSERT INTO testTbl1(id, userName) VALUES (2, '설현');
INSERT INTO testTbl1(userName, age, id) VALUES ('초아', 26, 3);
SELECT * FROM testTbl1;


-- 자동으로 증가하는 IDENTITY
-- 테이블 속성이 IDENTITY로 지정되어 있다면, INSERT에서는 해당 열이 없다고 생각하고 입력하면 된다.

USE tempdb;
CREATE TABLE testTbl2
(id int IDENTITY,
 userName nchar(3),
 age int,
 nation nchar(4) DEFAULT '대한민국')
GO
INSERT INTO testTbl2 VALUES ('지민', 25, DEFAULT)
GO
SELECT * FROM testTbl2

-- 강제로 identity 값을 입력하고 싶다.
SET IDENTITY_INSERT testTbl2 ON; -- 강제입력 ON
GO
INSERT INTO testTbl2(id, userName, age, nation) VALUES(11, '쯔위', 18, '대만');
INSERT INTO testTbl2(id, userName, age, nation) VALUES(12, '사나', 18, '일본');
GO
SELECT * FROM testTbl2;

SET IDENTITY_INSERT testTbl2 OFF;
GO
INSERT INTO testTbl2 VALUES ('미나', 21, '일본')
GO
SELECT * FROM testTbl2;

-- 열의 이름을 잊어버렸을 때
EXECUTE sp_help testTbl2;
-- 특정 테이블에 설정된 현재의 IDENTITY 값을 확인하고 싶을 때
SELECT IDENT_CURRENT('testTbl2');
SELECT @@IDENTITY;



-- SEQUENCE
-- IDENTITY와 같은 효과를 내는 개체
-- 시퀀스 활용1
USE tempdb
CREATE TABLE testTbl3
( id int,
  userName nchar(3),
  age int,
  nation nchar(4) DEFAULT '대한민국');
 GO
 -- 시퀀스 생성, 시작값 1, 증가값 1
 CREATE SEQUENCE idSEQ
	START WITH 1 -- 시작값
	INCREMENT BY 1 -- 증가값
GO
INSERT INTO testTbl3 VALUES (NEXT VALUE FOR idSEQ, '지민', 25, DEFAULT);
INSERT INTO testTbl3 VALUES (11, '쯔위', 18, '대만');
GO
SELECT * FROM testTbl3;
GO
ALTER SEQUENCE idSEQ
	RESTART WITH 12; -- 시작값을 다시 설정
GO
INSERT INTO testTbl3 VALUES (NEXT VALUE FOR idSEQ, '미나', 21, '일본');
GO
SELECT * FROM testTbl3;

-- 시퀀스 활용2
CREATE TABLE testTbl4 (id INT);
GO
CREATE SEQUENCE cycleSEQ
	START WITH 100
	INCREMENT BY 100
	MINVALUE 100 -- 최솟값
	MAXVALUE 300 -- 최대값
	CYCLE;
GO
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
GO
SELECT * FROM testTbl4; -- 100에서 300을 반복


-- 시퀀스 활용3
-- DEFAULT와 함께 사용하기

USE tempDB;
CREATE SEQUENCE autoSEQ
	START WITH 1
	INCREMENT BY 1
GO
CREATE TABLE testTbl5
( id int DEFAULT (NEXT VALUE FOR autoSEQ),
  userName nchar(4)
);
GO
INSERT INTO testTbl5(userName) VALUES ('지민');
INSERT INTO testTbl5(userName) VALUES ('쯔위');
INSERT INTO testTbl5(userName) VALUES ('미나');
GO
SELECT * FROM testTbl5



-- 대량의 샘플데이터 생성
USE tempDB;
CREATE TABLE testTbl6
( id int,
  Fname nvarchar(50),
  Lname nvarchar(50));
GO
INSERT INTO testTbl6
 SELECT BusinessEntityID, FirstName, LastName
 FROM AdventureWorks.Person.Person;

 -- 또는 아래오 같이 테이블생성 후 SELECT를 저장할 수 있으며, 더 많이 쓰임.
USE tempDB;
SELECT BusinessEntityID AS id, FirstName AS Fname, LastName AS Lname
	INTO testTbl7
	FROM AdventureWorks.Person.Person;
GO
SELECT * FROM testTbl7



-- UPDATE
UPDATE testTbl6
	SET Lname = '없음'
	WHERE Fname = 'Kim';
GO
SELECT * FROM testTbl6

USE sqlDB
UPDATE buyTbl SET price = price * 1.5;
GO
SELECT * FROM buyTbl


-- DELETE
USE tempDB;
DELETE testTbl6 WHERE Fname = 'Kim';
-- 상우 5개만 지우기
USE tempDB;
DELETE TOP(5) testTbl6 WHERE Fname = 'Kim';


-- 속도 비교
-- Tools -> Profiler
USE tempDB;
SELECT * INTO bigTbl1 FROM AdventureWorks.Sales.SalesOrderDetail;
SELECT * INTO bigTbl2 FROM AdventureWorks.Sales.SalesOrderDetail;
SELECT * INTO bigTbl3 FROM AdventureWorks.Sales.SalesOrderDetail;
GO
DELETE FROM bigTbl1
GO
DROP TABLE bigTbl2
GO
TRUNCATE TABLE bigTbl3;



-- MERGE
-- A 테이블에서 삽입/삭제/변경 등을 직접사용하면 안될 때 조건에 맞춰 B테이블에 실행시키도록한다.

USE sqlDB;
SELECT userID, name, addr INTO memberTBL FROM userTbl
GO
SELECT * FROM memberTBL;

CREATE TABLE changeTBL
( changeType NCHAR(4), -- 변경 사유
  userID char(8),
  name nvarchar(10),
  addr nchar(2)
);
GO
INSERT INTO changeTBL VALUES
	('신규가입', 'CHO', '초아', '미국'),
	('주소변경', 'LSG', null, '제주'),
	('주소변경', 'LJB', null, '영국'),
	('회원탈퇴', 'BBK', null, null),
	('회원탈퇴', 'SSK', null, null)
GO
SELECT * FROM memberTBL;
SELECT * FROM changeTBL;
GO

MERGE memberTBL AS M -- 변경될 테이블(target 테이블)
USING changeTBL AS C -- 변경할 기준이 되는 테이블 (source 테이블)
ON M.userID = C.userID -- userID를 기준으로 두 테이블을 비교한다.
-- target 테이블에 source 테이블의 행이 없고, 사유가 '신규가입' 이라면 새로운 행을 추가
WHEN NOT MATCHED AND changeType = '신규가입' THEN
	INSERT (userID, name, addr) VALUES (C.userID, C.name, C.addr)
-- target 테이블에 source 테이블의 행이 있고, 사유가 '주소변경' 이라면 주소를 변경한다.
WHEN MATCHED AND changeType = '주소변경' THEN
	UPDATE SET M.addr = C.addr
-- target 테이블에 source 테이블의 행이 있고, 사유가 '회원탈퇴' 이라면 해당 행을 삭제한다.
WHEN MATCHED AND changeType = '회원탈퇴' THEN
	DELETE ;

GO
SELECT * FROM memberTBL;
SELECT * FROM changeTBL;


