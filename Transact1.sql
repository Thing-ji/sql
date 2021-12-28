USE tempdb;
GO
CREATE DATABASE sqlDB;
USE sqlDB;

CREATE TABLE userTbl -- 회원 테이블
( userID	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디
  name		NVARCHAR(10) NOT  NULL, -- 이름 (가변길이)
  birthYear INT NOT NULL, -- 출생년도
  addr		NCHAR(2) NOT NULL, -- 지역(경기, 서울, 강남 식으로 2글자만 입력), N이 붙은건 한글입력 가능하게 하기 위함.
  mobile1	CHAR(3), -- (고정길이) / 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이폰제외)
  height	SMALLINT, -- 범위가 작은 INT / 키
  mDate		DATE -- 회원 가입일
);
GO
CREATE TABLE buyTbl
( num		INT IDENTITY NOT NULL PRIMARY KEY, -- 순번(PK)
  userID	CHAR(8) NOT NULL -- 아이디(FK)
	  FOREIGN KEY REFERENCES userTbl(userID),
  prodName	NCHAR(6) NOT NULL, -- 물품명
  groupName NCHAR(4), -- 분류
  price		INT NOT NULL, -- 단가
  amount	SMALLINT NOT NULL -- 수량
);

SELECT * FROM userTbl
SELECT * FROM buyTbl

USE sqlDB
INSERT INTO sqlDB.dbo.userTbl VALUES('LSG','이승기',1987,'서울','010','11111111',182,'2008-8-8')
INSERT INTO sqlDB.dbo.userTbl VALUES('KBS','김범수',1979,'경남','010','22222222',173,'2012-4-4')
INSERT INTO sqlDB.dbo.userTbl VALUES('KKH','김경호',1971,'전남','010','33333333',177,'2017-7-7')
INSERT INTO sqlDB.dbo.userTbl VALUES('JYP','조용필',1950,'경기','010','44444444',166,'2009-4-4')
INSERT INTO sqlDB.dbo.userTbl VALUES('SSK','성시경',1979,'서울','010',NULL,186,'2013-12-12')
INSERT INTO sqlDB.dbo.userTbl VALUES('LJB','임재범',1963,'서울','010','66666666',182,'2009-9-9')
INSERT INTO sqlDB.dbo.userTbl VALUES('YJW','윤종신',1969,'경남','010',NULL,170,'2005-5-5')
INSERT INTO sqlDB.dbo.userTbl VALUES('EJW','은지원',1978,'경북','010','88888888',174,'2014-3-3')
INSERT INTO sqlDB.dbo.userTbl VALUES('JKW','조관우',1965,'경기','010','99999999',172,'2010-10-10')
INSERT INTO sqlDB.dbo.userTbl VALUES('BBK','비비킴',1973,'서울','010','00000000',176,'2013-5-5')

INSERT INTO dbo.buyTbl(userID,prodName,groupName,price,amount) VALUES('KBS','운동화',NULL,30,2)
INSERT INTO dbo.buyTbl VALUES('KBS','노트북','전자',1000,1)
INSERT INTO dbo.buyTbl VALUES('JYP','모니터','전자',200,1)
INSERT INTO dbo.buyTbl VALUES('BBK','모니터','전자',200,5)
INSERT INTO dbo.buyTbl VALUES('KBS','청바지','의류',50,3)
INSERT INTO dbo.buyTbl VALUES('BBK','메모리','전자',80,10)
INSERT INTO dbo.buyTbl VALUES('SSK','책','서적',15,5)
INSERT INTO dbo.buyTbl VALUES('EJW','책','서적',15,2)
INSERT INTO dbo.buyTbl VALUES('EJW','청바지','의류',50,1)
INSERT INTO dbo.buyTbl VALUES('BBK','운동화',NULL,30,2)
INSERT INTO dbo.buyTbl VALUES('EJW','책','서적',15,1)
INSERT INTO dbo.buyTbl VALUES('BBK','운동화',NULL,30,2)

-- 백업(다른 db를 사용한 상태로 진행하는 것이 좋음)
USE tempdb
BACKUP DATABASE sqlDB TO DISK = 'C:\Users\JeonginKoo-Stu6\Desktop\IPP_2021하반기\SQL_BACK\sqlDB2019.bak' WITH INIT

