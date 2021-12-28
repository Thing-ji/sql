USE sqlDB
SELECT Name, height FROM userTbl WHERE height >= 180 AND height <= 183;
SELECT Name, height FROM userTbl WHERE height BETWEEN 180 AND 183;

SELECT Name, addr FROM userTbl WHERE addr = '�泲' OR addr = '����' OR addr = '���';
SELECT Name, addr FROM userTbl WHERE addr IN ('�泲', '����', '���');

SELECT Name, height FROM userTbl WHERE name LIKE '��%';
SELECT Name, height FROM userTbl WHERE name LIKE '_����';


-- <��������>
-- ���ȣ���� Ű�� ū��� ã��
SELECT Name, height FROM userTBL WHERE height > 177;
-- BUT �̷��� ���� �ͺ��� ���������� ��� �� ���� �� �� ����.
SELECT Name, height FROM userTbl
	WHERE height > (SELECT height FROM userTbl WHERE Name = '���ȣ');

--'�泲' ����� Ű����, Ű�� ũ�ų� ���� ����� �����ϱ�
SELECT Name, height FROM userTbl
	WHERE height >= (SELECT height FROM userTbl WHERE addr = '�泲')
-- ������ �߻� (����: ������������ �� ���� ���� ��ȯ�ϱ� ������ >= �� �� �� ����)
SELECT Name, height FROM userTbl
	WHERE height >= ANY(SELECT height FROM userTbl WHERE addr = '�泲') -- �� �߿� �ϳ� �����ϴ� ��.(170 �̻� ��µ�)

SELECT Name, height FROM userTbl
	WHERE height >= ALL(SELECT height FROM userTbl WHERE addr = '�泲') -- ���� �����ϴ� ��(173 �̻� ��µ�).

SELECT Name, height FROM userTbl
	WHERE height = ANY(SELECT height FROM userTbl WHERE addr = '�泲') -- ���� �� �����.


-- <ORDER BY :: ������ ������ ���� ����>
SELECT Name, mDate FROM userTbl ORDER BY mDate; -- �������� ����

SELECT Name, height FROM userTbl ORDER BY height DESC, name ASC;


-- <DISTINCT�� TOP(N)�� TABLESAMPLE��>
SELECT DISTINCT addr FROM userTbl; -- �ߺ�����

USE AdventureWorks;
SELECT CreditCardID FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- ������ �ͺ��� ���

SELECT TOP(10) CreditCardID FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- ���� 10���� ���

SELECT TOP(SELECT COUNT(*)/100 FROM Sales.CreditCard) CreditCardID 
	FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- CreditCardID�� ���� �͸� ���� 1�ۼ�Ʈ�� ���

SELECT TOP(0.1) PERCENT CreditCardID, ExpYear, ExpMonth 
	FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- ���� �÷��鿡 ���ؼ� ���� 1�ۼ�Ʈ / �� ���������� �ִ� ���� ��� ���ϰ� �� 5����

SELECT TOP(0.1) PERCENT WITH TIES CreditCardID, ExpMonth, ExpYear
	FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- ���� �÷��鿡 ���ؼ� ���� 1�ۼ�Ʈ / �� ���������� �ִ� �͵� ���

SELECT * FROM Sales.SalesOrderDetail TABLESAMPLE(5 PERCENT) -- ���̺��� �������� 5%�� ����


-- <OFFSET�� FETCH>
-- �ǳʶٱ�
USE sqlDB
SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS -- 4�� �� �ǳʶٱ�

USE sqlDB
SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS
	FETCH NEXT 3 ROWS ONLY -- 4�� �� �ǳʶٰ�, ���� 3�� �ุ ���

	
-- <SELECT INTO>
-- SELECT���� TABLE�� ����
-- ���̺�� �����ϵ�, �⺻Ű �� �ܷ�Ű�� ���簡 ���� �ʴ´�.
USE sqlDB
SELECT * INTO buyTbl2 FROM buyTbl;
SELECT * FROM buyTbl2;

SELECT userID, prodName INTO buyTbl3 FROM buyTbl;
SELECT * FROM buyTbl3;
