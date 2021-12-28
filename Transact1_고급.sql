-- N문자열, 한글 입력 가능.
-- 한글은 글자당 2byte 차지
-- 소문자 입력 안됨. 형식은 맞춰서
USE tempdb;
CREATE TABLE uniTest(korName NVARCHAR(10));
GO
INSERT INTO uniTest	VALUES (N'박신혜'); -- 맞음
INSERT INTO uniTest VALUES ( '박신혜'); -- 맞음
INSERT INTO uniTest VALUES (n'박신혜'); -- 틀림


-- 변수의 사용.
-- 한번 돌리면 변수에 저장된 내용이 사라지기 때문에 전체를 돌려야함.
USE tempdb;
RESTORE DATABASE sqlDB FROM DISK = '파일경로' WITH REPLACE;

-- 예제1
USE sqlDB
DECLARE @myVar1 INT;
DECLARE @myVar2 SMALLINT, @myVar3 DECIMAL(5,2);
DECLARE @myVar4 NCHAR(20);

SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수 이름==> ';

SELECT @myVar1;
SELECT @myVar2 + @myVar3
SELECT @myVar4, Name FROM userTbl WHERE height > 180;


-- 예제2
DECLARE @myVar11 INT;
SET @myVar11 = 3;
SELECT TOP(@myVar11) Name, height 
	FROM userTbl 
	ORDER BY height;



-- 데이터 형식 변환 함수
-- CAST(), CONVERT(), TRY_CONVERT(), PARSE(), TRY_PARSE()

USE sqlDB;
SELECT AVG(amount) AS [평균구매개수]
	FROM buyTbl;
GO
SELECT AVG(CAST(amount AS FLOAT)) AS [평균구매개수] FROM buyTbl;
SELECT AVG(CONVERT(FLOAT, amount)) AS [평균구매개수] FROM buyTbl;
SELECT AVG(TRY_CONVERT(FLOAT, amount)) AS [평균구매개수] FROM buyTbl;


SELECT price, amount, price/amount AS [단가/수량] 
	FROM buyTbl;
GO
SELECT price, amount, CAST(CAST(price AS FLOAT)/amount AS DECIMAL(10,2)) AS [단가/수량] -- DECIMAL : 소수점자리까지
	FROM buyTbl;


-- DATE 타입으로 변환
-- 오류발생 시 PARSE는 에러반환, YRY_PARSE는 NULL반환
SELECT PARSE( '2019년 9월 9일' AS DATE);
SELECT PARSE('123.45' AS INT);
SELECT TRY_PARSE('123.45' AS INT);



-- 암시적인 형변환
DECLARE @myVar22 CHAR(3);
SET @myVar22 = '100' ;
SELECT @myVar22 + '200'; -- 문자와 문자를 더함(정상)
SELECT @myVar22 + 200; -- 문자와 정수를 더함(정상: 정수로 암시적 형 변환)
SELECT @myVar22 + 200.0; -- 문자와 실수를 더함(정상: 실수로 암시적 형 변환)
GO
DECLARE @myVar33 CHAR(3);
SET @myVar33 = '100';
SELECT @myVar33 + '200'; -- 문자와 문자를 더함(정상)
SELECT CAST(@myVar33 AS INT) + 200; -- 정수로 변환 후 연산(정상)
SELECT CAST(@myVar33 AS DECIMAL(5, 1)) + 200.0 -- 실수로 변환 후 연산(정상)

