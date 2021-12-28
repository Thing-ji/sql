USE tempdb;
GO
CREATE DATABASE sqlDB;
USE sqlDB;

CREATE TABLE userTbl -- ȸ�� ���̺�
( userID	CHAR(8) NOT NULL PRIMARY KEY, -- ����� ���̵�
  name		NVARCHAR(10) NOT  NULL, -- �̸� (��������)
  birthYear INT NOT NULL, -- ����⵵
  addr		NCHAR(2) NOT NULL, -- ����(���, ����, ���� ������ 2���ڸ� �Է�), N�� ������ �ѱ��Է� �����ϰ� �ϱ� ����.
  mobile1	CHAR(3), -- (��������) / �޴����� ����(011, 016, 017, 018, 019, 010 ��)
  mobile2	CHAR(8), -- �޴����� ������ ��ȭ��ȣ(����������)
  height	SMALLINT, -- ������ ���� INT / Ű
  mDate		DATE -- ȸ�� ������
);
GO
CREATE TABLE buyTbl
( num		INT IDENTITY NOT NULL PRIMARY KEY, -- ����(PK)
  userID	CHAR(8) NOT NULL -- ���̵�(FK)
	  FOREIGN KEY REFERENCES userTbl(userID),
  prodName	NCHAR(6) NOT NULL, -- ��ǰ��
  groupName NCHAR(4), -- �з�
  price		INT NOT NULL, -- �ܰ�
  amount	SMALLINT NOT NULL -- ����
);

SELECT * FROM userTbl
SELECT * FROM buyTbl

USE sqlDB
INSERT INTO sqlDB.dbo.userTbl VALUES('LSG','�̽±�',1987,'����','010','11111111',182,'2008-8-8')
INSERT INTO sqlDB.dbo.userTbl VALUES('KBS','�����',1979,'�泲','010','22222222',173,'2012-4-4')
INSERT INTO sqlDB.dbo.userTbl VALUES('KKH','���ȣ',1971,'����','010','33333333',177,'2017-7-7')
INSERT INTO sqlDB.dbo.userTbl VALUES('JYP','������',1950,'���','010','44444444',166,'2009-4-4')
INSERT INTO sqlDB.dbo.userTbl VALUES('SSK','���ð�',1979,'����','010',NULL,186,'2013-12-12')
INSERT INTO sqlDB.dbo.userTbl VALUES('LJB','�����',1963,'����','010','66666666',182,'2009-9-9')
INSERT INTO sqlDB.dbo.userTbl VALUES('YJW','������',1969,'�泲','010',NULL,170,'2005-5-5')
INSERT INTO sqlDB.dbo.userTbl VALUES('EJW','������',1978,'���','010','88888888',174,'2014-3-3')
INSERT INTO sqlDB.dbo.userTbl VALUES('JKW','������',1965,'���','010','99999999',172,'2010-10-10')
INSERT INTO sqlDB.dbo.userTbl VALUES('BBK','���Ŵ',1973,'����','010','00000000',176,'2013-5-5')

INSERT INTO dbo.buyTbl(userID,prodName,groupName,price,amount) VALUES('KBS','�ȭ',NULL,30,2)
INSERT INTO dbo.buyTbl VALUES('KBS','��Ʈ��','����',1000,1)
INSERT INTO dbo.buyTbl VALUES('JYP','�����','����',200,1)
INSERT INTO dbo.buyTbl VALUES('BBK','�����','����',200,5)
INSERT INTO dbo.buyTbl VALUES('KBS','û����','�Ƿ�',50,3)
INSERT INTO dbo.buyTbl VALUES('BBK','�޸�','����',80,10)
INSERT INTO dbo.buyTbl VALUES('SSK','å','����',15,5)
INSERT INTO dbo.buyTbl VALUES('EJW','å','����',15,2)
INSERT INTO dbo.buyTbl VALUES('EJW','û����','�Ƿ�',50,1)
INSERT INTO dbo.buyTbl VALUES('BBK','�ȭ',NULL,30,2)
INSERT INTO dbo.buyTbl VALUES('EJW','å','����',15,1)
INSERT INTO dbo.buyTbl VALUES('BBK','�ȭ',NULL,30,2)

-- ���(�ٸ� db�� ����� ���·� �����ϴ� ���� ����)
USE tempdb
BACKUP DATABASE sqlDB TO DISK = 'C:\Users\JeonginKoo-Stu6\Desktop\IPP_2021�Ϲݱ�\SQL_BACK\sqlDB2019.bak' WITH INIT

