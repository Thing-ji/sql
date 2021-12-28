USE AdventureWorks;


-- <IF ELSE> / 참 or 거짓
DECLARE @hireDATE SMALLDATETIME -- 입사일
DECLARE @curDATE SMALLDATETIME -- 오늘
DECLARE @years DECIMAL(5,2) -- 근무한 년수
DECLARE @days INT -- 근무한 일수

SELECT @hireDATE = HireDATE -- HireDATE 열의 결과를 @hireDATE에 대입
	FROM HumanResources.Employee
	WHERE BusinessEntityID = 111

SET @curDATE = GETDATE()
SET @years = DATEDIFF(year, @hireDATE, @curDATE) -- 날짜의 차이, 년 단위
SET @days = DATEDIFF(day, @hireDATE, @curDATE) -- 날짜의 차이, 일 단위

IF (@years >= 5)
	BEGIN
		PRINT N'입사한 지 ' + CAST(@days AS NCHAR(5)) + N'일이나 지났습니다.'
		PRINT N'축하합니다.'
	END
ELSE
	BEGIN
		PRINT N'입사한 지' + CAST(@days AS NCHAR(5)) + N'일밖에 안 되었네요.'
		PRINT N'열심히 일하세요.'
	END

-----
DECLARE @point INT = 77, @credit NCHAR(1)

IF @point >= 90
	SET @credit = 'A'
ELSE
	IF @point >= 80
		SET @credit = 'B'
	ELSE
		IF @point >= 70
			SET @credit = 'C'
		ELSE
			IF @point >= 60
				SET @credit = 'D'
			ELSE
				SET @credit = 'F'
PRINT N'취득점수 ==> ' + CAST(@point AS NCHAR(3))
PRINT N'학점 ==> ' + @credit
GO

-- CASE / 여러 조건 사용 가능


DECLARE @point INT = 77, @credit NCHAR(1)

SET @credit = 
	CASE
		WHEN (@point >= 90) THEN 'A'
		WHEN (@point >= 80) THEN 'B'
		WHEN (@point >= 70) THEN 'C'
		WHEN (@point >= 60) THEN 'D'
	END
PRINT N'취득점수 ==> ' + CAST(@point AS CHAR(3))
PRINT N'학점 ==> ' + @credit


-- 백업
USE tempdb;
RESTORE DATABASE sqlDB FROM DISK = '경로' WITH REPLACE;


-- 실습예제1
USE sqlDB;
SELECT userid, SUM(price * amount) AS [총구매액]
	FROM buyTbl
	GROUP BY userID
	ORDER BY SUM(price * amount) DESC;

-- 조인
SELECT B.userid, U.name, SUM(price * amount) AS [총구매액]
	FROM buyTbl	B
		INNER JOIN userTbl U
			ON B.userid = U.userid
	GROUP BY B.userid, U.name
	ORDER BY SUM(price * amount) DESC;

-- CASE 구문
SELECT U.userid, U.name, SUM(price*amount) AS [총구매액],
	CASE
		WHEN (SUM(price*amount) >= 1500) THEN N'최우수고객'
		WHEN (SUM(price*amount) >= 1000) THEN N'우수고객'
		WHEN (SUM(price*amount) >= 1) THEN N'일반고객'
		ELSE N'유령고객'
	END AS [고객등급]
FROM buyTbl B
	RIGHT OUTER JOIN userTbl U
		ON B.userid = U.userid
GROUP BY U.userid, U.name
ORDER BY SUM(price*amount) DESC ;


-- WHILE 구문
DECLARE @i INT = 1 -- 1에서 100까지 증가할 변수
DECLARE @hap BIGINT = 0 -- 더한 값을 누적할 변수

WHILE (@i <= 100)
BEGIN
	SET @hap += @i -- @hap의 원래의 값에 @i를 더해서 다시 @hap에 넣으라는 의미
	SET @i += 1 -- @i의 원래의 값에 1을 더해서 다시 @i에 넣으라는 의미
END
PRINT @hap
GO

--------
DECLARE @i INT = 1
DECLARE @hap BIGINT = 0

WHILE (@i <= 100)
BEGIN
	IF (@i % 7 = 0)
		BEGIN
			PRINT N'7의 배수: ' + CAST(@i as NCHAR(3))
			SET @i += 1
			CONTINUE
		END

	SET @hap += @i
	IF (@hap > 1000) BREAK
	SET @i += 1
END
PRINT N'합계= ' + CAST(@hap AS NCHAR(10))
GO

-- GOTO / 지정한 위치로 무조건 이동함.
DECLARE @i INT = 1
DECLARE @hap BIGINT = 0

WHILE (@i <= 100)
BEGIN
	IF (@i % 7 = 0)
		BEGIN
			PRINT N'7의 배수: ' + CAST(@i as NCHAR(3))
			SET @i += 1
			CONTINUE
		END

	SET @hap += @i
	IF (@hap > 1000) GOTO endprint
	SET @i += 1
END
endprint:
PRINT N'합계= ' + CAST(@hap AS NCHAR(10))
GO


-- WAITFOR / 지정한 시간만큼 일시정지
BEGIN
	WAITFOR DELAY '00:00:05'
	PRINT N'5초간 멈춘 후 진행되었음'
END
GO


-- TRY / CATCH
USE sqlDB;
BEGIN TRY
	INSERT INTO userTbl VALUES('LSG', '이상구', 1988, '서울', NULL, NULL, 170, GETDATE())
	PRINT N'정상적으로 입력되었다.'
END TRY

BEGIN CATCH
	PRINT N'오류가 발생했다.'
END CATCH
GO



-- EXEC(동적 SQL)
-- sql문을 실행시켜주는 역할
USE sqlDB
DECLARE @sql VARCHAR(100)
SET @sql = 'SELECT * FROM userTbl WHERE userid = "EJW"' -- 모두 작은따옴표.
EXEC(@sql)
GO

--
DECLARE @curDATE DATE
DECLARE @curYear VARCHAR(4)
DECLARE @curMonth VARCHAR(2)
DECLARE @curDay VARCHAR(2)
DECLARE @sql VARCHAR(100)

SET @curDATE = GETDATE()
SET @curYear = YEAR(@curDATE)
SET @curMonth = MONTH(@curDATE)
SET @curDay = DAY(@curDATE)

SET @sql = 'CREATE TABLE myTbl' + @curYear + '_' + @curMonth + '_' + @curDay
SET @sql += '(id INT, name NCHAR(10))'

EXEC(@sql)


