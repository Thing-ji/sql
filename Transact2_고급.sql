-- 스칼라 함수

-- <구성함수>
-- @@LANGID / 현재 설정된 언어의 코드 번호 및 언어를 확인할 수 있다.
SELECT @@LANGID;

-- @@SERVERNAME / 현재 인스턴스의 이름을 확인할 수 있다.
SELECT @@SERVERNAME;

-- @@SERVICENAME / 서비스의 이름을 돌려준다.
SELECT @@SERVICENAME;

-- @@VERSION / 현재 설치된 SQL Server의 버전, CPU 종류, 운영체제 버전의 정보를 알려준다.
SELECT @@VERSION;


-- <날짜 및 시간 함수>
-- SYSDATETIME() / 현재의 날짜와 시간을 돌려준다.
-- GETDATE() / 날짜에 더한 결과를 돌려준다.
SELECT SYSDATETIME(), GETDATE();

-- DATEADD() / 날짜에 더한 결과를 돌려준다.
SELECT DATEADD(day, 100, '2019/10/10');

-- DATEDIFF() / 두 날짜의 차이를 돌려준다.
SELECT DATEDIFF(week, GETDATE(), '2027/10/19');

-- DATENAME() / 날짜의 지정한 부분만 돌려준다.
SELECT DATENAME(weekday, '2022/10/19');

-- DATAPART() / 지정된 날짜의 연 또는 일을 돌려준다.
SELECT DATEPART(year, GETDATE());

-- 지정된 날짜의 일/월/년을 돌려준다.
SELECT MONTH('2022/10/19');

-- DATEFROMPARTS() / 변환된 데이터 형식의 값을 반환한다.
SELECT DATEFROMPARTS('2022', '10', '19');

-- EOMONTH() / 입력한 날짜에 포함된 달의 마지막 날을 돌려준다.
SELECT EOMONTH('2019-3-3');


-- <수치 연산 함수>
-- ABS() / 절대값
SELECT ABS(-100);

-- ROUND() / 자릿수를 올림
SELECT ROUND(1234.5678, 2), ROUND(1234.5678, -2);

-- RAND / 0~1까지 임의의 숫자를 돌려줌.
SELECT RAND();

-- SQRT / 제곱근값
SELECT SQRT(10);

-- POWER / 거듭제곱값
SELECT POWER(3, 2);


-- <메타 데이터 함수> : 데이터베이스 및 데이터베이스 개체의 정보를 반환
-- COL_LENGTH() / 컬럼의 길이
USE sqlDB;
SELECT COL_LENGTH('userTbl', 'name');

-- DB_ID() / DB의 ID, 이름
SELECT DB_ID(N'AdventureWorks');
SELECT DB_NAME(5);


-- <논리 함수>
-- CHOOSE() / 여러 값 중에서 지정된 위치의 값을 반환
SELECT CHOOSE(2, 'SQL', 'Server', '2016', 'DVD');

-- IIF() / 파라미터로 수식, 참일 때, 거짓일 때
SELECT IIF(100>200, '맞다', '거짓');


-- <문자열 함수>
-- CONCAT() / 둘 이상의 문자열을 연결
SELECT CONCAT('SQL ', 'SERVER', 2016)
SELECT 'SQL'+'SERVER'+'2016';

-- CHARINDEX() / 문자열의 시작 위치
SELECT CHARINDEX('Server', 'SQL Server 2016');

-- LEFT(), RIGHT() / 지정 위치부터 지정한 수만큼 반환
SELECT LEFT('SQL Server 2016', 3), RIGHT('SQL Server 2016', 4)

-- SUBSTRING() / 지정한 위치부터 지정한 개수의 문자를 돌려줌.
SELECT SUBSTRING(N'대한민국만세', 3, 2);

-- LEN / 길이
SELECT LEN('SQL SERVER 2016');

-- LOWER, UPPER / 소문자->대문자, 대문자->소문자
SELECT LOWER('abcdEFGH'), UPPER('abcdEFGH')

-- LITRIM, RTRIM / 공백문자 제거
SELECT LTRIM('  공백앞뒤두개  '), RTRIM('  공백앞뒤두개  ');

-- REPLACE / 문자열의 내용을 바꿈
SELECT REPLACE('SQL Server 2016', 'Server', '서버');

-- REPLICATE / 지정한 수만큼 반복
SELECT REPLICATE('SQL', 5);

-- REVERSE / 문자열의 순서를 거꾸로
SELECT REVERSE ('SQL Server 2016')

-- STUFF / 문자를 지정한 위치의 개수만큼 삭제 후, 새로운 문자를 끼워넣음
SELECT STUFF('SQL 서버 2016', 5, 2, 'Server');

-- FORMAT() / 지정된 형식으로 출력
SELECT FORMAT(GETDATE(), 'dd/MM/yyyy');



-- <길이 비교>
USE tempdb;
CREATE TABLE maxTbl(
	col1 VARCHAR(MAX),
	col2 VARCHAR(MAX)
);
INSERT INTO maxTbl VALUES( REPLICATE('A', 1000000), REPLICATE('가', 1000000));
SELECT LEN(col1) AS [VARCHAR(MAX)], LEN(col2) AS [NVARCHAR(MAX)]
FROM maxTbl;

-- 아래 방식으로 하면 길이가 늘어남.
DELETE FROM maxTbl;
INSERT INTO maxTbl VALUES(
	REPLICATE(CAST('A' AS VARCHAR(MAX)), 1000000),
	REPLICATE(CONVERT(NVARCHAR(MAX), '가'), 1000000)
);
SELECT LEN(col1) AS [VARCHAR(MAX)], LEN(col2) AS [VARCHAR(MAX)]
FROM maxTbl;

USE tempdb;
UPDATE maxTbl SET col1 = REPLACE( (SELECT col1 FROM maxTbl), 'A', 'B'),
				  col2 = REPLACE( (SELECT col2 FROM maxTbl), '가', '나');
GO
SELECT REVERSE((SELECT col1 FROM maxTbl));
SELECT SUBSTRING((SELECT col2 FROM maxTbl), 999991, 10);
GO
UPDATE maxTbl SET col1 = STUFF((SELECT col1 FROM maxTbl), 999991, 10, REPLICATE('C', 10)),
				  col2 = STUFF((SELECT col2 FROM maxTbl), 999991, 10, REPLICATE('다', 10));

UPDATE maxTbl SET col1.WRITE('DDDD', 999996, 5), col2.WRITE('라라라라라', 999996, 5);
GO
SELECT * FROM maxTbl;



-- <순위함수>
-- 키가 큰 순으로 순위를 정하고 싶을 경우
USE sqlDB;
SELECT ROW_NUMBER() OVER(ORDER BY height DESC)[키큰순위], name, addr, height
	FROM userTbl;
GO
SELECT ROW_NUMBER() OVER(ORDER BY height DESC, name ASC)[키큰순위], name, addr, height
	FROM userTbl;

-- 지역별로 순위
SELECT addr, ROW_NUMBER() OVER(PARTITION BY addr ORDER BY height DESC, name ASC) [지역별키큰순위], name, height
	FROM userTbl;

-- 동일한 등수처리
SELECT DENSE_RANK() OVER(ORDER BY height DESC) [키큰순위], name, addr, height
	FROM userTbl;

-- 2등이 2명이라면 2등, 2등, 4등 식으로 넘어감
SELECT RANK() OVER(ORDER BY height DESC)[키큰순위], name, addr, height
	FROM userTbl;

-- 전체 인원을 키순으로 세운 후에, 몇 개의 그룹으로 분할하고 싶은 경우
SELECT NTILE(2) OVER(ORDER BY height DESC) [반번호], name, addr, height
	FROM userTbl;
GO
-- 전체 인원을 키순으로 세운 후에, 몇 개의 그룹으로 분할하고 싶은 경우
SELECT NTILE(4) OVER(ORDER BY height DESC) [반번호], name, addr, height
	FROM userTbl;



-- <분석함수>
-- 키가 큰 순서로 정렬한 후에, 키 차이를 알고싶다.
USE sqlDB;
SELECT name, addr, height AS [키], height-(LEAD(height, 1, 0) OVER (ORDER BY height DESC)) AS [다음 사람과 키 차이]
	FROM userTbl;

-- 가장 키가 큰 사람과의 차이
SELECT addr, name, height AS [키], height-(FIRST_VALUE(height) OVER (PARTITION BY addr ORDER BY height DESC) ) AS [지역별 가장 큰 키와 차이]
	FROM userTbl;

-- 각 지역별로 키의 중앙값 계산
SELECT DISTINCT addr, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY height) OVER (PARTITION BY addr) AS [지역별 키의 중앙값]
	FROM userTbl;



-- PIVOT/UNPIVOT 연산자
-- 한 열에 포함된 여러 값을 출력하고, 이를 여러 열로 변환하여 테이블 반환 식을 회전하고 필요하면 집계까지 수핼할 수 있다.



-- JSON 데이터
-- 데이터를 교환하는 개방형 표준포맷
-- 속성(Key)과 값(Value)

DECLARE @json VARCHAR(MAX)
SET @json=N' { "userTBL" :
	[
			{"name": "임재범", "height": 182},
			{"name": "이승기", "height": 182},
			{"name": "성시경", "height": 186}
	]
} '

SELECT ISJSON(@json);
SELECT JSON_QUERY(@json, '$.userTBL[0]');
SELECT JSON_VALUE(@json, '$.userTBL[0].name');
SELECT * FROM OPENJSON(@json, '$.userTBL')
WITH(
		name NCHAR(8) '$.name',
		height INT    '$.height');