USE sqlDB
SELECT Name, height FROM userTbl WHERE height >= 180 AND height <= 183;
SELECT Name, height FROM userTbl WHERE height BETWEEN 180 AND 183;

SELECT Name, addr FROM userTbl WHERE addr = '경남' OR addr = '전남' OR addr = '경북';
SELECT Name, addr FROM userTbl WHERE addr IN ('경남', '전남', '경북');

SELECT Name, height FROM userTbl WHERE name LIKE '김%';
SELECT Name, height FROM userTbl WHERE name LIKE '_종신';


-- <서브쿼리>
-- 김경호보다 키가 큰사람 찾기
SELECT Name, height FROM userTBL WHERE height > 177;
-- BUT 이렇게 쓰는 것보다 서브쿼리를 써더 더 쉽게 쓸 수 있음.
SELECT Name, height FROM userTbl
	WHERE height > (SELECT height FROM userTbl WHERE Name = '김경호');

--'경남' 사람의 키보다, 키가 크거나 같은 사람을 추출하기
SELECT Name, height FROM userTbl
	WHERE height >= (SELECT height FROM userTbl WHERE addr = '경남')
-- 오류를 발생 (이유: 서브쿼리에서 두 개의 값을 반환하기 때문에 >= 을 쓸 수 없음)
SELECT Name, height FROM userTbl
	WHERE height >= ANY(SELECT height FROM userTbl WHERE addr = '경남') -- 둘 중에 하나 만족하는 것.(170 이상 출력됨)

SELECT Name, height FROM userTbl
	WHERE height >= ALL(SELECT height FROM userTbl WHERE addr = '경남') -- 전부 만족하는 것(173 이상 출력됨).

SELECT Name, height FROM userTbl
	WHERE height = ANY(SELECT height FROM userTbl WHERE addr = '경남') -- 같은 것 출력함.


-- <ORDER BY :: 성능이 떨어질 수도 있음>
SELECT Name, mDate FROM userTbl ORDER BY mDate; -- 오름차순 정렬

SELECT Name, height FROM userTbl ORDER BY height DESC, name ASC;


-- <DISTINCT와 TOP(N)과 TABLESAMPLE절>
SELECT DISTINCT addr FROM userTbl; -- 중복제거

USE AdventureWorks;
SELECT CreditCardID FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- 오래된 것부터 출력

SELECT TOP(10) CreditCardID FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- 상위 10개만 출력

SELECT TOP(SELECT COUNT(*)/100 FROM Sales.CreditCard) CreditCardID 
	FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- CreditCardID에 관한 것만 상위 1퍼센트만 출력

SELECT TOP(0.1) PERCENT CreditCardID, ExpYear, ExpMonth 
	FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- 위의 컬럼들에 대해서 상위 1퍼센트 / 단 동일점수에 있는 것은 출력 안하고 딱 5개만

SELECT TOP(0.1) PERCENT WITH TIES CreditCardID, ExpMonth, ExpYear
	FROM Sales.CreditCard
	WHERE CardType = 'Vista'
	ORDER BY ExpYear, ExpMonth; -- 위의 컬럼들에 대해서 상위 1퍼센트 / 단 동일점수에 있는 것도 출력

SELECT * FROM Sales.SalesOrderDetail TABLESAMPLE(5 PERCENT) -- 테이블에서 랜덤으로 5%만 추출


-- <OFFSET과 FETCH>
-- 건너뛰기
USE sqlDB
SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS -- 4개 행 건너뛰기

USE sqlDB
SELECT userID, name, birthYear FROM userTBL
	ORDER BY birthYear
	OFFSET 4 ROWS
	FETCH NEXT 3 ROWS ONLY -- 4개 행 건너뛰고, 다음 3개 행만 출력

	
-- <SELECT INTO>
-- SELECT문을 TABLE로 복사
-- 테이블로 복사하되, 기본키 및 외래키는 복사가 되지 않는다.
USE sqlDB
SELECT * INTO buyTbl2 FROM buyTbl;
SELECT * FROM buyTbl2;

SELECT userID, prodName INTO buyTbl3 FROM buyTbl;
SELECT * FROM buyTbl3;
