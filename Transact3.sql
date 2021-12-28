USE sqlDB

-- <GROUP BY>
SELECT userID, SUM(amount) FROM buyTbl GROUP BY userID;
SELECT userID AS [����ھ��̵�], SUM(price*amount) AS [�� ���ž�]
	FROM buyTbl
	GROUP BY userID;

-- ���
-- ���� ����� 2.91xx��, �������·� ��µǱ� ������ 2�� ��µ� ��.
-- ����� ����ϰ� ������ CAST(), CONVERT() ���.
USE sqlDB
SELECT AVG(amount) AS [��� ���� ����]
	FROM buyTbl;

SELECT AVG(amount*1.0) as [��ձ��Ű���]
	FROM buyTbl;
SELECT AVG(CAST(amount AS DECIMAL(10,6))) AS [��ձ��Ű���]
	FROM buyTbl; -- �Ҽ��� 6�ڸ����� �Ǽ��� ��ȯ�� �Ŀ� ��ճ���.

SELECT userID, AVG(amount*1.0) AS [��ձ��Ű���]
	FROM buyTbl
	GROUP BY userID

SELECT Name, MAX(height), MIN(height)
	FROM userTbl
	GROUP BY Name;

SELECT Name, height
	FROM userTbl
	WHERE height = (SELECT MAX(height) FROM userTbl)
		OR	height = (SELECT MIN(height) FROM userTbl)

SELECT COUNT(*) FROM userTbl; -- ��ü ī����
SELECT COUNT(mobile1) AS[�޴����� �ִ� �����] FROM userTbl; -- NULL �����ϰ� ī����

------------------------sql_profiler
USE AdventureWorks;
GO
SELECT * FROM Sales.Customer;
GO
SELECT COUNT(*) FROM Sales.Customer;

-- #���̺��̸� <- �ӽ����̺�
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
-- HAVING ��
USE sqlDB;
GO
--�ѱ��ž��� 1000�� �Ѵ� ����̱�.
SELECT userID AS [�����], SUM(price*amount) AS [�� ���ž�]
	FROM buyTbl
	GROUP BY userID
	HAVING SUM(price*amount) > 1000;

-- ROLLUP, GROUPING_ID(), CUBE() �Լ�
SELECT num, groupName, SUM(price*amount) AS [���]
	FROM buyTbl
	GROUP BY ROLLUP (groupName, num); -- �Ұ����� ����

SELECT groupName, SUM(price*amount) AS [���]
	FROM buyTbl
	GROUP BY ROLLUP (groupName); -- ��ü���� ������ ǥ��

SELECT groupName, SUM(price*amount) AS [���], GROUPING_ID(groupName) AS [�߰��� ����] -- ���� �߰����θ� �˷���
	FROM buyTbl
	GROUP BY ROLLUP(groupName);

-- CUBE �������� ������ �ѹ��� ������
USE sqlDB
CREATE TABLE cubeTbl(
	prodName NCHAR(3),
	color NCHAR(2),
	amount INT)
GO
INSERT INTO cubeTbl VALUES('��ǻ��', '����', 11);
INSERT INTO cubeTbl VALUES('��ǻ��', '�Ķ�', 22);
INSERT INTO cubeTbl VALUES('�����', '����', 33);
INSERT INTO cubeTbl VALUES('�����', '�Ķ�', 44);
GO
SELECT prodName, color, SUM(amount) AS [�����հ�]
	FROM cubeTbl
	GROUP BY CUBE (color,prodName);


