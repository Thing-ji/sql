-- N���ڿ�, �ѱ� �Է� ����.
-- �ѱ��� ���ڴ� 2byte ����
-- �ҹ��� �Է� �ȵ�. ������ ���缭
USE tempdb;
CREATE TABLE uniTest(korName NVARCHAR(10));
GO
INSERT INTO uniTest	VALUES (N'�ڽ���'); -- ����
INSERT INTO uniTest VALUES ( '�ڽ���'); -- ����
INSERT INTO uniTest VALUES (n'�ڽ���'); -- Ʋ��


-- ������ ���.
-- �ѹ� ������ ������ ����� ������ ������� ������ ��ü�� ��������.
USE tempdb;
RESTORE DATABASE sqlDB FROM DISK = '���ϰ��' WITH REPLACE;

-- ����1
USE sqlDB
DECLARE @myVar1 INT;
DECLARE @myVar2 SMALLINT, @myVar3 DECIMAL(5,2);
DECLARE @myVar4 NCHAR(20);

SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '���� �̸�==> ';

SELECT @myVar1;
SELECT @myVar2 + @myVar3
SELECT @myVar4, Name FROM userTbl WHERE height > 180;


-- ����2
DECLARE @myVar11 INT;
SET @myVar11 = 3;
SELECT TOP(@myVar11) Name, height 
	FROM userTbl 
	ORDER BY height;



-- ������ ���� ��ȯ �Լ�
-- CAST(), CONVERT(), TRY_CONVERT(), PARSE(), TRY_PARSE()

USE sqlDB;
SELECT AVG(amount) AS [��ձ��Ű���]
	FROM buyTbl;
GO
SELECT AVG(CAST(amount AS FLOAT)) AS [��ձ��Ű���] FROM buyTbl;
SELECT AVG(CONVERT(FLOAT, amount)) AS [��ձ��Ű���] FROM buyTbl;
SELECT AVG(TRY_CONVERT(FLOAT, amount)) AS [��ձ��Ű���] FROM buyTbl;


SELECT price, amount, price/amount AS [�ܰ�/����] 
	FROM buyTbl;
GO
SELECT price, amount, CAST(CAST(price AS FLOAT)/amount AS DECIMAL(10,2)) AS [�ܰ�/����] -- DECIMAL : �Ҽ����ڸ�����
	FROM buyTbl;


-- DATE Ÿ������ ��ȯ
-- �����߻� �� PARSE�� ������ȯ, YRY_PARSE�� NULL��ȯ
SELECT PARSE( '2019�� 9�� 9��' AS DATE);
SELECT PARSE('123.45' AS INT);
SELECT TRY_PARSE('123.45' AS INT);



-- �Ͻ����� ����ȯ
DECLARE @myVar22 CHAR(3);
SET @myVar22 = '100' ;
SELECT @myVar22 + '200'; -- ���ڿ� ���ڸ� ����(����)
SELECT @myVar22 + 200; -- ���ڿ� ������ ����(����: ������ �Ͻ��� �� ��ȯ)
SELECT @myVar22 + 200.0; -- ���ڿ� �Ǽ��� ����(����: �Ǽ��� �Ͻ��� �� ��ȯ)
GO
DECLARE @myVar33 CHAR(3);
SET @myVar33 = '100';
SELECT @myVar33 + '200'; -- ���ڿ� ���ڸ� ����(����)
SELECT CAST(@myVar33 AS INT) + 200; -- ������ ��ȯ �� ����(����)
SELECT CAST(@myVar33 AS DECIMAL(5, 1)) + 200.0 -- �Ǽ��� ��ȯ �� ����(����)

