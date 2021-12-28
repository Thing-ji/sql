-- ��Į�� �Լ�

-- <�����Լ�>
-- @@LANGID / ���� ������ ����� �ڵ� ��ȣ �� �� Ȯ���� �� �ִ�.
SELECT @@LANGID;

-- @@SERVERNAME / ���� �ν��Ͻ��� �̸��� Ȯ���� �� �ִ�.
SELECT @@SERVERNAME;

-- @@SERVICENAME / ������ �̸��� �����ش�.
SELECT @@SERVICENAME;

-- @@VERSION / ���� ��ġ�� SQL Server�� ����, CPU ����, �ü�� ������ ������ �˷��ش�.
SELECT @@VERSION;


-- <��¥ �� �ð� �Լ�>
-- SYSDATETIME() / ������ ��¥�� �ð��� �����ش�.
-- GETDATE() / ��¥�� ���� ����� �����ش�.
SELECT SYSDATETIME(), GETDATE();

-- DATEADD() / ��¥�� ���� ����� �����ش�.
SELECT DATEADD(day, 100, '2019/10/10');

-- DATEDIFF() / �� ��¥�� ���̸� �����ش�.
SELECT DATEDIFF(week, GETDATE(), '2027/10/19');

-- DATENAME() / ��¥�� ������ �κи� �����ش�.
SELECT DATENAME(weekday, '2022/10/19');

-- DATAPART() / ������ ��¥�� �� �Ǵ� ���� �����ش�.
SELECT DATEPART(year, GETDATE());

-- ������ ��¥�� ��/��/���� �����ش�.
SELECT MONTH('2022/10/19');

-- DATEFROMPARTS() / ��ȯ�� ������ ������ ���� ��ȯ�Ѵ�.
SELECT DATEFROMPARTS('2022', '10', '19');

-- EOMONTH() / �Է��� ��¥�� ���Ե� ���� ������ ���� �����ش�.
SELECT EOMONTH('2019-3-3');


-- <��ġ ���� �Լ�>
-- ABS() / ���밪
SELECT ABS(-100);

-- ROUND() / �ڸ����� �ø�
SELECT ROUND(1234.5678, 2), ROUND(1234.5678, -2);

-- RAND / 0~1���� ������ ���ڸ� ������.
SELECT RAND();

-- SQRT / �����ٰ�
SELECT SQRT(10);

-- POWER / �ŵ�������
SELECT POWER(3, 2);


-- <��Ÿ ������ �Լ�> : �����ͺ��̽� �� �����ͺ��̽� ��ü�� ������ ��ȯ
-- COL_LENGTH() / �÷��� ����
USE sqlDB;
SELECT COL_LENGTH('userTbl', 'name');

-- DB_ID() / DB�� ID, �̸�
SELECT DB_ID(N'AdventureWorks');
SELECT DB_NAME(5);


-- <�� �Լ�>
-- CHOOSE() / ���� �� �߿��� ������ ��ġ�� ���� ��ȯ
SELECT CHOOSE(2, 'SQL', 'Server', '2016', 'DVD');

-- IIF() / �Ķ���ͷ� ����, ���� ��, ������ ��
SELECT IIF(100>200, '�´�', '����');


-- <���ڿ� �Լ�>
-- CONCAT() / �� �̻��� ���ڿ��� ����
SELECT CONCAT('SQL ', 'SERVER', 2016)
SELECT 'SQL'+'SERVER'+'2016';

-- CHARINDEX() / ���ڿ��� ���� ��ġ
SELECT CHARINDEX('Server', 'SQL Server 2016');

-- LEFT(), RIGHT() / ���� ��ġ���� ������ ����ŭ ��ȯ
SELECT LEFT('SQL Server 2016', 3), RIGHT('SQL Server 2016', 4)

-- SUBSTRING() / ������ ��ġ���� ������ ������ ���ڸ� ������.
SELECT SUBSTRING(N'���ѹα�����', 3, 2);

-- LEN / ����
SELECT LEN('SQL SERVER 2016');

-- LOWER, UPPER / �ҹ���->�빮��, �빮��->�ҹ���
SELECT LOWER('abcdEFGH'), UPPER('abcdEFGH')

-- LITRIM, RTRIM / ���鹮�� ����
SELECT LTRIM('  ����յڵΰ�  '), RTRIM('  ����յڵΰ�  ');

-- REPLACE / ���ڿ��� ������ �ٲ�
SELECT REPLACE('SQL Server 2016', 'Server', '����');

-- REPLICATE / ������ ����ŭ �ݺ�
SELECT REPLICATE('SQL', 5);

-- REVERSE / ���ڿ��� ������ �Ųٷ�
SELECT REVERSE ('SQL Server 2016')

-- STUFF / ���ڸ� ������ ��ġ�� ������ŭ ���� ��, ���ο� ���ڸ� ��������
SELECT STUFF('SQL ���� 2016', 5, 2, 'Server');

-- FORMAT() / ������ �������� ���
SELECT FORMAT(GETDATE(), 'dd/MM/yyyy');



-- <���� ��>
USE tempdb;
CREATE TABLE maxTbl(
	col1 VARCHAR(MAX),
	col2 VARCHAR(MAX)
);
INSERT INTO maxTbl VALUES( REPLICATE('A', 1000000), REPLICATE('��', 1000000));
SELECT LEN(col1) AS [VARCHAR(MAX)], LEN(col2) AS [NVARCHAR(MAX)]
FROM maxTbl;

-- �Ʒ� ������� �ϸ� ���̰� �þ.
DELETE FROM maxTbl;
INSERT INTO maxTbl VALUES(
	REPLICATE(CAST('A' AS VARCHAR(MAX)), 1000000),
	REPLICATE(CONVERT(NVARCHAR(MAX), '��'), 1000000)
);
SELECT LEN(col1) AS [VARCHAR(MAX)], LEN(col2) AS [VARCHAR(MAX)]
FROM maxTbl;

USE tempdb;
UPDATE maxTbl SET col1 = REPLACE( (SELECT col1 FROM maxTbl), 'A', 'B'),
				  col2 = REPLACE( (SELECT col2 FROM maxTbl), '��', '��');
GO
SELECT REVERSE((SELECT col1 FROM maxTbl));
SELECT SUBSTRING((SELECT col2 FROM maxTbl), 999991, 10);
GO
UPDATE maxTbl SET col1 = STUFF((SELECT col1 FROM maxTbl), 999991, 10, REPLICATE('C', 10)),
				  col2 = STUFF((SELECT col2 FROM maxTbl), 999991, 10, REPLICATE('��', 10));

UPDATE maxTbl SET col1.WRITE('DDDD', 999996, 5), col2.WRITE('������', 999996, 5);
GO
SELECT * FROM maxTbl;



-- <�����Լ�>
-- Ű�� ū ������ ������ ���ϰ� ���� ���
USE sqlDB;
SELECT ROW_NUMBER() OVER(ORDER BY height DESC)[Űū����], name, addr, height
	FROM userTbl;
GO
SELECT ROW_NUMBER() OVER(ORDER BY height DESC, name ASC)[Űū����], name, addr, height
	FROM userTbl;

-- �������� ����
SELECT addr, ROW_NUMBER() OVER(PARTITION BY addr ORDER BY height DESC, name ASC) [������Űū����], name, height
	FROM userTbl;

-- ������ ���ó��
SELECT DENSE_RANK() OVER(ORDER BY height DESC) [Űū����], name, addr, height
	FROM userTbl;

-- 2���� 2���̶�� 2��, 2��, 4�� ������ �Ѿ
SELECT RANK() OVER(ORDER BY height DESC)[Űū����], name, addr, height
	FROM userTbl;

-- ��ü �ο��� Ű������ ���� �Ŀ�, �� ���� �׷����� �����ϰ� ���� ���
SELECT NTILE(2) OVER(ORDER BY height DESC) [�ݹ�ȣ], name, addr, height
	FROM userTbl;
GO
-- ��ü �ο��� Ű������ ���� �Ŀ�, �� ���� �׷����� �����ϰ� ���� ���
SELECT NTILE(4) OVER(ORDER BY height DESC) [�ݹ�ȣ], name, addr, height
	FROM userTbl;



-- <�м��Լ�>
-- Ű�� ū ������ ������ �Ŀ�, Ű ���̸� �˰�ʹ�.
USE sqlDB;
SELECT name, addr, height AS [Ű], height-(LEAD(height, 1, 0) OVER (ORDER BY height DESC)) AS [���� ����� Ű ����]
	FROM userTbl;

-- ���� Ű�� ū ������� ����
SELECT addr, name, height AS [Ű], height-(FIRST_VALUE(height) OVER (PARTITION BY addr ORDER BY height DESC) ) AS [������ ���� ū Ű�� ����]
	FROM userTbl;

-- �� �������� Ű�� �߾Ӱ� ���
SELECT DISTINCT addr, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY height) OVER (PARTITION BY addr) AS [������ Ű�� �߾Ӱ�]
	FROM userTbl;



-- PIVOT/UNPIVOT ������
-- �� ���� ���Ե� ���� ���� ����ϰ�, �̸� ���� ���� ��ȯ�Ͽ� ���̺� ��ȯ ���� ȸ���ϰ� �ʿ��ϸ� ������� ������ �� �ִ�.



-- JSON ������
-- �����͸� ��ȯ�ϴ� ������ ǥ������
-- �Ӽ�(Key)�� ��(Value)

DECLARE @json VARCHAR(MAX)
SET @json=N' { "userTBL" :
	[
			{"name": "�����", "height": 182},
			{"name": "�̽±�", "height": 182},
			{"name": "���ð�", "height": 186}
	]
} '

SELECT ISJSON(@json);
SELECT JSON_QUERY(@json, '$.userTBL[0]');
SELECT JSON_VALUE(@json, '$.userTBL[0].name');
SELECT * FROM OPENJSON(@json, '$.userTBL')
WITH(
		name NCHAR(8) '$.name',
		height INT    '$.height');