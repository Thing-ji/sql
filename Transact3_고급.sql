-- <����>

-- INNER JOIN
-- ���� ���̺� ��� ������ �ִ� �͸� ���εǴ� ���.
-- WHERE���� ���� ���̴°� ���� ����.
USE sqlDB;
SELECT *
	FROM buyTbl
		INNER JOIN userTbl
			ON buyTbl.userID = userTbl.userID
		WHERE buyTbl.userID = 'JYP';

SELECT buyTbl.userid, name, prodName, addr, mobile1 + mobile2 AS [����ó]
	FROM buyTbl
	  INNER JOIN userTbl
		ON buyTbl.userid = userTbl.userid;

SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [����ó]
	FROM buyTbl B
	  INNER JOIN userTbl U
		ON B.userid = U.userid;

SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [����ó]
	FROM buyTbl B
	  INNER JOIN userTbl U
		ON B.userid = U.userid
	  WHERE B.userid = 'JYP';

SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [����ó]
	FROM userTbl U
	  INNER JOIN buyTbl B
		ON B.userid = U.userid
	  WHERE B.userid = 'JYP';

-- ��ü ȸ���� ������ ����� ��� ����ϰ� ���� ��, �� "��ü ȸ��" �̶�� ���� ��
-- �� ���������� ���� ��µ��� �ʾ��� -> OUTTER JOIN�� ���.
SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [����ó]
	FROM userTbl U
	  INNER JOIN buyTbl B
		ON B.userid = U.userid
	  ORDER BY U.userid;

SELECT DISTINCT U.userid, U.name, U.addr
	FROM userTbl U
		INNER JOIN buyTbl B
	       ON U.userID = B.userID
	ORDER BY U.userID;



-- ���̺� ����
USE sqlDB;
CREATE TABLE stdTbl
( stdName NVARCHAR(10) NOT NULL PRIMARY KEY,
  addr	NCHAR(4) NOT NULL
);
GO
CREATE TABLE clubTbl
( clubName NVARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo NCHAR(4) NOT NULL
);
GO
CREATE TABLE stdclubTbl
( num int IDENTITY NOT NULL PRIMARY KEY,
  stdName NVARCHAR(10) NOT NULL
		FOREIGN KEY REFERENCES stdTbl(stdName),
  clubName NVARCHAR(10) NOT NULL
		FOREIGN KEY REFERENCES clubTbl(clubName)
);
GO
INSERT INTO stdTbl VALUES ('�����', '�泲'), ('���ð�', '����'), ('������', '���'), ('������', '���'), ('�ٺ�Ŵ', '����');
INSERT INTO clubTbl VALUES ('����', '101ȣ'), ('�ٵ�', '102ȣ'), ('�౸', '103ȣ'), ('����', '104ȣ');
INSERT INTO stdclubTbl VALUES ('�����', '�ٵ�'), ('�����', '�౸'), ('������', '�౸'), ('������', '�౸'), ('������', '����'), ('�ٺ�Ŵ', '����');

-- 3���� ���̺� ����
SELECT S.stdName, S.addr, C.clubName, C.roomNo
	FROM stdTbl S
		INNER JOIN stdclubTbl SC
			ON S.stdName = SC.stdName
		INNER JOIN clubTbl C
			ON SC.clubName = C.clubName
	ORDER BY S.stdName;

SELECT C.clubName, C.roomNo, S.stdName, S.addr
	FROM stdTbl S
		INNER JOIN stdclubTbl SC
			ON SC.stdName = S.stdName
		INNER JOIN clubTbl C
			ON SC.clubName = C.clubName
	ORDER BY C.clubName;


-- OUTER JOIN
-- ��ü ȸ���� ���ű���� ���� ���� ��, ���� ����� ���� ȸ���� ����ϰ� ���� ��

-- ���� ���̺��� ���� ��� ��µǾ�� �Ѵ�.
USE sqlDB;
SELECT U.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [����ó]
	FROM userTbl U
		LEFT OUTER JOIN buyTbl B
			ON U.userid = B.userid
	ORDER BY U.userid;

-- ������ ���̺��� ���� ��� ��µǾ�� �Ѵ�.
SELECT U.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [����ó]
	FROM buyTbl B
		LEFT OUTER JOIN userTbl U
			ON U.userid = B.userid
	ORDER BY U.userid;

-- ������ ����� �ִ� ��� ȸ���� ��ϸ�, ����ȸ���� �̾ƺ���.
SELECT U.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [����ó]
	FROM userTbl U
		LEFT OUTER JOIN buyTbl B
			ON U.userID = B.userID
	WHERE B.prodName IS NULL
	ORDER BY U.userID;


USE sqlDB;
SELECT S.stdName, S.addr, C.clubName, C.roomNo
	FROM stdTbl S
		LEFT OUTER JOIN stdclubTbl SC
			ON S.stdName = SC.stdName
		LEFT OUTER JOIN clubTbl C
			ON SC.clubName = C.clubName
	ORDER BY S.stdName;

-- FULL OUTER JOIN
SELECT S.stdName, S.addr, C.clubName, C.roomNo
	FROM stdTbl S
		FULL OUTER JOIN stdclubTbl SC
			ON S.stdName = SC.stdName
		FULL OUTER JOIN clubTbl C
			ON SC.clubName = C.clubName
	ORDER BY S.stdName;

-- CROSS JOIN
-- N * N ���� ���

-- SELF JOIN
USE sqlDB;
SELECT A.emp AS [��������], B.emp AS [���ӻ��], B.department AS [���ӻ���μ�]
	FROM empTbl A
		INNER JOIN empTbl B
			ON A.manager = B.emp
	WHERE A.emp = '��븮';
	

-- UNION
USE sqlDB;
SELECT stdName, addr FROM stdTbl
	UNION ALL
SELECT clubName, roomNo From clubTbl;

-- ��ȭ�� ���� ����� �����ϰ��� �Ѵٸ�
SELECT name, mobile1 + mobile2 AS [��ȭ��ȣ] FROM userTbl
	EXCEPT
SELECT name, mobile1 + mobile2 FROM userTbl WHERE mobile1 IS NULL;

-- ��ȭ�� ���� ����� ��ȸ
SELECT name, mobile1 + mobile2 AS [��ȭ��ȣ] FROM userTbl
	INTERSECT
SELECT name, mobile1 + mobile2 FROM userTbl WHERE mobile1 IS NULL;


