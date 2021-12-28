USE sqlDB

-- <GROUP BY>
SELECT userID, SUM(amount) FROM buyTbl GROUP BY userID;
SELECT userID AS [사용자아이디], SUM(price*amount) AS [총 구매액]
	FROM buyTbl
	GROUP BY userID;

-- 평균
-- 실제 평균은 2.91xx임, 정수형태로 출력되기 때문에 2가 출력된 것.
-- 제대로 출력하고 싶으면 CAST(), CONVERT() 사용.
USE sqlDB
SELECT AVG(amount) AS [평균 구매 개수]
	FROM buyTbl;

SELECT AVG(amount*1.0) as [평균구매개수]
	FROM buyTbl;
SELECT AVG(CAST(amount AS DECIMAL(10,6))) AS [평균구매개수]
	FROM buyTbl; -- 소수점 6자리까지 실수로 변환한 후에 평균내라.

SELECT userID, AVG(amount*1.0) AS [평균구매개수]
	FROM buyTbl
	GROUP BY userID

SELECT Name, MAX(height), MIN(height)
	FROM userTbl
	GROUP BY Name;

SELECT Name, height
	FROM userTbl
	WHERE height = (SELECT MAX(height) FROM userTbl)
		OR	height = (SELECT MIN(height) FROM userTbl)

SELECT COUNT(*) FROM userTbl; -- 전체 카운팅
SELECT COUNT(mobile1) AS[휴대폰이 있는 사용자] FROM userTbl; -- NULL 제외하고 카운팅

------------------------sql_profiler
USE AdventureWorks;
GO
SELECT * FROM Sales.Customer;
GO
SELECT COUNT(*) FROM Sales.Customer;

-- #테이블이름 <- 임시테이블
USE sqlDB
SELECT num, price, amount INTO #tmpTbl
	FROM buyTbl
GO
INSERT INTO #tmpTbl
	SELECT a.price, a.amount FROM #tmpTbl a, #tmpTbl b;
GO
SELECT * FROM #tmpTbl;

SELECT SUM(price*amount) FROM #tmpTbl;


--------------------------
-- HAVING 절
USE sqlDB;
GO
--총구매액이 1000이 넘는 사람뽑기.
SELECT userID AS [사용자], SUM(price*amount) AS [총 구매액]
	FROM buyTbl
	GROUP BY userID
	HAVING SUM(price*amount) > 1000;

-- ROLLUP, GROUPING_ID(), CUBE() 함수
SELECT num, groupName, SUM(price*amount) AS [비용]
	FROM buyTbl
	GROUP BY ROLLUP (groupName, num); -- 소계합이 나옴

SELECT groupName, SUM(price*amount) AS [비용]
	FROM buyTbl
	GROUP BY ROLLUP (groupName); -- 전체합을 행으로 표현

SELECT groupName, SUM(price*amount) AS [비용], GROUPING_ID(groupName) AS [추가행 여부] -- 행의 추가여부를 알려줌
	FROM buyTbl
	GROUP BY ROLLUP(groupName);

-- CUBE 다차원의 정보를 한번에 보여줌
USE sqlDB
CREATE TABLE cubeTbl(
	prodName NCHAR(3),
	color NCHAR(2),
	amount INT)
GO
INSERT INTO cubeTbl VALUES('컴퓨터', '검정', 11);
INSERT INTO cubeTbl VALUES('컴퓨터', '파랑', 22);
INSERT INTO cubeTbl VALUES('모니터', '검정', 33);
INSERT INTO cubeTbl VALUES('모니터', '파랑', 44);
GO
SELECT prodName, color, SUM(amount) AS [수량합계]
	FROM cubeTbl
	GROUP BY CUBE (color,prodName);


