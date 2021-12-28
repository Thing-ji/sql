-- WITH��
-- SELECT�� �ӽ÷� ������ ���̺��� ��� �����Ͽ� �� ���̺��� ������ �ٽ� SELELCT �ϴ� ��.
USE sqlDB;
SELECT userID AS [�����], SUM(price*amount) AS [�ѱ��ž�]
	FROM buyTbl
	GROUP BY userID

SELECT * FROM abc ORDER BY �ѱ��ž� DESC

-- ���� ������ �ϳ��� WITH�� ���.
-- ����1
WITH abc(userID, total)
AS
( SELECT userID, SUM(price*amount)
	FROM buyTbl
	GROUP BY userID)
SELECT * FROM abc ORDER BY total DESC;


-- ����2
WITH cte(addr, maxHeight)
AS
( SELECT addr, MAX(height)
	FROM userTbl
	GROUP BY addr)
SELECT AVG(maxHeight*1.0) AS [�� ������ �ְ�Ű�� ���] FROM cte

-- ����3
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

-- INSERT��
USE tempdb
CREATE TABLE testTbl1 (id int, userName nchar(3), age int);
GO
INSERT INTO testTbl1 VALUES (1, 'ȫ�浿', 25);
INSERT INTO testTbl1(id, userName) VALUES (2, '����');
INSERT INTO testTbl1(userName, age, id) VALUES ('�ʾ�', 26, 3);
SELECT * FROM testTbl1;


-- �ڵ����� �����ϴ� IDENTITY
-- ���̺� �Ӽ��� IDENTITY�� �����Ǿ� �ִٸ�, INSERT������ �ش� ���� ���ٰ� �����ϰ� �Է��ϸ� �ȴ�.

USE tempdb;
CREATE TABLE testTbl2
(id int IDENTITY,
 userName nchar(3),
 age int,
 nation nchar(4) DEFAULT '���ѹα�')
GO
INSERT INTO testTbl2 VALUES ('����', 25, DEFAULT)
GO
SELECT * FROM testTbl2

-- ������ identity ���� �Է��ϰ� �ʹ�.
SET IDENTITY_INSERT testTbl2 ON; -- �����Է� ON
GO
INSERT INTO testTbl2(id, userName, age, nation) VALUES(11, '����', 18, '�븸');
INSERT INTO testTbl2(id, userName, age, nation) VALUES(12, '�糪', 18, '�Ϻ�');
GO
SELECT * FROM testTbl2;

SET IDENTITY_INSERT testTbl2 OFF;
GO
INSERT INTO testTbl2 VALUES ('�̳�', 21, '�Ϻ�')
GO
SELECT * FROM testTbl2;

-- ���� �̸��� �ؾ������ ��
EXECUTE sp_help testTbl2;
-- Ư�� ���̺� ������ ������ IDENTITY ���� Ȯ���ϰ� ���� ��
SELECT IDENT_CURRENT('testTbl2');
SELECT @@IDENTITY;



-- SEQUENCE
-- IDENTITY�� ���� ȿ���� ���� ��ü
-- ������ Ȱ��1
USE tempdb
CREATE TABLE testTbl3
( id int,
  userName nchar(3),
  age int,
  nation nchar(4) DEFAULT '���ѹα�');
 GO
 -- ������ ����, ���۰� 1, ������ 1
 CREATE SEQUENCE idSEQ
	START WITH 1 -- ���۰�
	INCREMENT BY 1 -- ������
GO
INSERT INTO testTbl3 VALUES (NEXT VALUE FOR idSEQ, '����', 25, DEFAULT);
INSERT INTO testTbl3 VALUES (11, '����', 18, '�븸');
GO
SELECT * FROM testTbl3;
GO
ALTER SEQUENCE idSEQ
	RESTART WITH 12; -- ���۰��� �ٽ� ����
GO
INSERT INTO testTbl3 VALUES (NEXT VALUE FOR idSEQ, '�̳�', 21, '�Ϻ�');
GO
SELECT * FROM testTbl3;

-- ������ Ȱ��2
CREATE TABLE testTbl4 (id INT);
GO
CREATE SEQUENCE cycleSEQ
	START WITH 100
	INCREMENT BY 100
	MINVALUE 100 -- �ּڰ�
	MAXVALUE 300 -- �ִ밪
	CYCLE;
GO
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
INSERT INTO testTbl4 VALUES (NEXT VALUE FOR cycleSEQ);
GO
SELECT * FROM testTbl4; -- 100���� 300�� �ݺ�


-- ������ Ȱ��3
-- DEFAULT�� �Բ� ����ϱ�

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
INSERT INTO testTbl5(userName) VALUES ('����');
INSERT INTO testTbl5(userName) VALUES ('����');
INSERT INTO testTbl5(userName) VALUES ('�̳�');
GO
SELECT * FROM testTbl5



-- �뷮�� ���õ����� ����
USE tempDB;
CREATE TABLE testTbl6
( id int,
  Fname nvarchar(50),
  Lname nvarchar(50));
GO
INSERT INTO testTbl6
 SELECT BusinessEntityID, FirstName, LastName
 FROM AdventureWorks.Person.Person;

 -- �Ǵ� �Ʒ��� ���� ���̺���� �� SELECT�� ������ �� ������, �� ���� ����.
USE tempDB;
SELECT BusinessEntityID AS id, FirstName AS Fname, LastName AS Lname
	INTO testTbl7
	FROM AdventureWorks.Person.Person;
GO
SELECT * FROM testTbl7



-- UPDATE
UPDATE testTbl6
	SET Lname = '����'
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
-- ��� 5���� �����
USE tempDB;
DELETE TOP(5) testTbl6 WHERE Fname = 'Kim';


-- �ӵ� ��
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
-- A ���̺��� ����/����/���� ���� ��������ϸ� �ȵ� �� ���ǿ� ���� B���̺� �����Ű�����Ѵ�.

USE sqlDB;
SELECT userID, name, addr INTO memberTBL FROM userTbl
GO
SELECT * FROM memberTBL;

CREATE TABLE changeTBL
( changeType NCHAR(4), -- ���� ����
  userID char(8),
  name nvarchar(10),
  addr nchar(2)
);
GO
INSERT INTO changeTBL VALUES
	('�ű԰���', 'CHO', '�ʾ�', '�̱�'),
	('�ּҺ���', 'LSG', null, '����'),
	('�ּҺ���', 'LJB', null, '����'),
	('ȸ��Ż��', 'BBK', null, null),
	('ȸ��Ż��', 'SSK', null, null)
GO
SELECT * FROM memberTBL;
SELECT * FROM changeTBL;
GO

MERGE memberTBL AS M -- ����� ���̺�(target ���̺�)
USING changeTBL AS C -- ������ ������ �Ǵ� ���̺� (source ���̺�)
ON M.userID = C.userID -- userID�� �������� �� ���̺��� ���Ѵ�.
-- target ���̺� source ���̺��� ���� ����, ������ '�ű԰���' �̶�� ���ο� ���� �߰�
WHEN NOT MATCHED AND changeType = '�ű԰���' THEN
	INSERT (userID, name, addr) VALUES (C.userID, C.name, C.addr)
-- target ���̺� source ���̺��� ���� �ְ�, ������ '�ּҺ���' �̶�� �ּҸ� �����Ѵ�.
WHEN MATCHED AND changeType = '�ּҺ���' THEN
	UPDATE SET M.addr = C.addr
-- target ���̺� source ���̺��� ���� �ְ�, ������ 'ȸ��Ż��' �̶�� �ش� ���� �����Ѵ�.
WHEN MATCHED AND changeType = 'ȸ��Ż��' THEN
	DELETE ;

GO
SELECT * FROM memberTBL;
SELECT * FROM changeTBL;


