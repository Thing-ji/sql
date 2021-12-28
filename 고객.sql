USE Product_data
SELECT 상품명, 매출일자
FROM dbo.Pro_data
WHERE 상품명 LIKE '농)알새우칩'


SELECT 상품명, DATEPART(YEAR,매출일자) AS Year, DATEPART(MONTH, 매출일자) AS Month, DATEPART(DAY, 매출일자) AS Day
FROM dbo.Pro_data
WHERE 상품명 = '농)알새우칩'

WITH DATE_TABLE AS (
SELECT 상품명, DATEPART(YEAR,매출일자) AS Year, DATEPART(MONTH, 매출일자) AS Month, DATEPART(DAY, 매출일자) AS Day
FROM dbo.Pro_data
WHERE 상품명 = '농)알새우칩'
)
SELECT * FROM DATE_TABLE
WHERE DAY BETWEEN 10 AND 30



-- WHERE Day BETWEEN 10 AND 30