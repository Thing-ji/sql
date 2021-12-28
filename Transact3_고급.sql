-- <조인>

-- INNER JOIN
-- 양쪽 테이블에 모두 내용이 있는 것만 조인되는 방식.
-- WHERE으로 조건 붙이는거 잊지 말기.
USE sqlDB;
SELECT *
	FROM buyTbl
		INNER JOIN userTbl
			ON buyTbl.userID = userTbl.userID
		WHERE buyTbl.userID = 'JYP';

SELECT buyTbl.userid, name, prodName, addr, mobile1 + mobile2 AS [연락처]
	FROM buyTbl
	  INNER JOIN userTbl
		ON buyTbl.userid = userTbl.userid;

SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [연락처]
	FROM buyTbl B
	  INNER JOIN userTbl U
		ON B.userid = U.userid;

SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [연락처]
	FROM buyTbl B
	  INNER JOIN userTbl U
		ON B.userid = U.userid
	  WHERE B.userid = 'JYP';

SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [연락처]
	FROM userTbl U
	  INNER JOIN buyTbl B
		ON B.userid = U.userid
	  WHERE B.userid = 'JYP';

-- 전체 회원이 구매한 목록을 모두 출력하고 싶을 때, 즉 "전체 회원" 이라고 말한 것
-- 본 예제에서는 전부 출력되지 않았음 -> OUTTER JOIN을 사용.
SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [연락처]
	FROM userTbl U
	  INNER JOIN buyTbl B
		ON B.userid = U.userid
	  ORDER BY U.userid;

SELECT DISTINCT U.userid, U.name, U.addr
	FROM userTbl U
		INNER JOIN buyTbl B
	       ON U.userID = B.userID
	ORDER BY U.userID;



-- 테이블 생성
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
INSERT INTO stdTbl VALUES ('김범수', '경남'), ('성시경', '서울'), ('조용필', '경기'), ('은지원', '경북'), ('바비킴', '서울');
INSERT INTO clubTbl VALUES ('수영', '101호'), ('바둑', '102호'), ('축구', '103호'), ('봉사', '104호');
INSERT INTO stdclubTbl VALUES ('김범수', '바둑'), ('김범수', '축구'), ('조용필', '축구'), ('은지원', '축구'), ('은지원', '봉사'), ('바비킴', '봉사');

-- 3개의 테이블 조인
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
-- 전체 회원의 구매기록을 보고 싶을 때, 구매 기록이 없는 회원도 출력하고 싶을 때

-- 왼쪽 테이블의 것은 모두 출력되어야 한다.
USE sqlDB;
SELECT U.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [연락처]
	FROM userTbl U
		LEFT OUTER JOIN buyTbl B
			ON U.userid = B.userid
	ORDER BY U.userid;

-- 오른쪽 테이블의 것은 모두 출력되어야 한다.
SELECT U.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [연락처]
	FROM buyTbl B
		LEFT OUTER JOIN userTbl U
			ON U.userid = B.userid
	ORDER BY U.userid;

-- 구매한 기록이 있는 우수 회원의 목록만, 유령회원만 뽑아보기.
SELECT U.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS [연락처]
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
-- N * N 으로 계산

-- SELF JOIN
USE sqlDB;
SELECT A.emp AS [부하직원], B.emp AS [직속상관], B.department AS [직속상관부서]
	FROM empTbl A
		INNER JOIN empTbl B
			ON A.manager = B.emp
	WHERE A.emp = '우대리';
	

-- UNION
USE sqlDB;
SELECT stdName, addr FROM stdTbl
	UNION ALL
SELECT clubName, roomNo From clubTbl;

-- 전화가 없는 사람을 제외하고자 한다면
SELECT name, mobile1 + mobile2 AS [전화번호] FROM userTbl
	EXCEPT
SELECT name, mobile1 + mobile2 FROM userTbl WHERE mobile1 IS NULL;

-- 전화가 없는 사람만 조회
SELECT name, mobile1 + mobile2 AS [전화번호] FROM userTbl
	INTERSECT
SELECT name, mobile1 + mobile2 FROM userTbl WHERE mobile1 IS NULL;


