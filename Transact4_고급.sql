USE AdventureWorks;


-- <IF ELSE> / �� or ����
DECLARE @hireDATE SMALLDATETIME -- �Ի���
DECLARE @curDATE SMALLDATETIME -- ����
DECLARE @years DECIMAL(5,2) -- �ٹ��� ���
DECLARE @days INT -- �ٹ��� �ϼ�

SELECT @hireDATE = HireDATE -- HireDATE ���� ����� @hireDATE�� ����
	FROM HumanResources.Employee
	WHERE BusinessEntityID = 111

SET @curDATE = GETDATE()
SET @years = DATEDIFF(year, @hireDATE, @curDATE) -- ��¥�� ����, �� ����
SET @days = DATEDIFF(day, @hireDATE, @curDATE) -- ��¥�� ����, �� ����

IF (@years >= 5)
	BEGIN
		PRINT N'�Ի��� �� ' + CAST(@days AS NCHAR(5)) + N'���̳� �������ϴ�.'
		PRINT N'�����մϴ�.'
	END
ELSE
	BEGIN
		PRINT N'�Ի��� ��' + CAST(@days AS NCHAR(5)) + N'�Ϲۿ� �� �Ǿ��׿�.'
		PRINT N'������ ���ϼ���.'
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
PRINT N'������� ==> ' + CAST(@point AS NCHAR(3))
PRINT N'���� ==> ' + @credit
GO

-- CASE / ���� ���� ��� ����


DECLARE @point INT = 77, @credit NCHAR(1)

SET @credit = 
	CASE
		WHEN (@point >= 90) THEN 'A'
		WHEN (@point >= 80) THEN 'B'
		WHEN (@point >= 70) THEN 'C'
		WHEN (@point >= 60) THEN 'D'
	END
PRINT N'������� ==> ' + CAST(@point AS CHAR(3))
PRINT N'���� ==> ' + @credit


-- ���
USE tempdb;
RESTORE DATABASE sqlDB FROM DISK = '���' WITH REPLACE;


-- �ǽ�����1
USE sqlDB;
SELECT userid, SUM(price * amount) AS [�ѱ��ž�]
	FROM buyTbl
	GROUP BY userID
	ORDER BY SUM(price * amount) DESC;

-- ����
SELECT B.userid, U.name, SUM(price * amount) AS [�ѱ��ž�]
	FROM buyTbl	B
		INNER JOIN userTbl U
			ON B.userid = U.userid
	GROUP BY B.userid, U.name
	ORDER BY SUM(price * amount) DESC;

-- CASE ����
SELECT U.userid, U.name, SUM(price*amount) AS [�ѱ��ž�],
	CASE
		WHEN (SUM(price*amount) >= 1500) THEN N'�ֿ����'
		WHEN (SUM(price*amount) >= 1000) THEN N'�����'
		WHEN (SUM(price*amount) >= 1) THEN N'�Ϲݰ�'
		ELSE N'���ɰ�'
	END AS [�����]
FROM buyTbl B
	RIGHT OUTER JOIN userTbl U
		ON B.userid = U.userid
GROUP BY U.userid, U.name
ORDER BY SUM(price*amount) DESC ;


-- WHILE ����
DECLARE @i INT = 1 -- 1���� 100���� ������ ����
DECLARE @hap BIGINT = 0 -- ���� ���� ������ ����

WHILE (@i <= 100)
BEGIN
	SET @hap += @i -- @hap�� ������ ���� @i�� ���ؼ� �ٽ� @hap�� ������� �ǹ�
	SET @i += 1 -- @i�� ������ ���� 1�� ���ؼ� �ٽ� @i�� ������� �ǹ�
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
			PRINT N'7�� ���: ' + CAST(@i as NCHAR(3))
			SET @i += 1
			CONTINUE
		END

	SET @hap += @i
	IF (@hap > 1000) BREAK
	SET @i += 1
END
PRINT N'�հ�= ' + CAST(@hap AS NCHAR(10))
GO

-- GOTO / ������ ��ġ�� ������ �̵���.
DECLARE @i INT = 1
DECLARE @hap BIGINT = 0

WHILE (@i <= 100)
BEGIN
	IF (@i % 7 = 0)
		BEGIN
			PRINT N'7�� ���: ' + CAST(@i as NCHAR(3))
			SET @i += 1
			CONTINUE
		END

	SET @hap += @i
	IF (@hap > 1000) GOTO endprint
	SET @i += 1
END
endprint:
PRINT N'�հ�= ' + CAST(@hap AS NCHAR(10))
GO


-- WAITFOR / ������ �ð���ŭ �Ͻ�����
BEGIN
	WAITFOR DELAY '00:00:05'
	PRINT N'5�ʰ� ���� �� ����Ǿ���'
END
GO


-- TRY / CATCH
USE sqlDB;
BEGIN TRY
	INSERT INTO userTbl VALUES('LSG', '�̻�', 1988, '����', NULL, NULL, 170, GETDATE())
	PRINT N'���������� �ԷµǾ���.'
END TRY

BEGIN CATCH
	PRINT N'������ �߻��ߴ�.'
END CATCH
GO



-- EXEC(���� SQL)
-- sql���� ��������ִ� ����
USE sqlDB
DECLARE @sql VARCHAR(100)
SET @sql = 'SELECT * FROM userTbl WHERE userid = "EJW"' -- ��� ��������ǥ.
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


