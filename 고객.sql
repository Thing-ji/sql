USE Product_data
SELECT ��ǰ��, ��������
FROM dbo.Pro_data
WHERE ��ǰ�� LIKE '��)�˻���Ĩ'


SELECT ��ǰ��, DATEPART(YEAR,��������) AS Year, DATEPART(MONTH, ��������) AS Month, DATEPART(DAY, ��������) AS Day
FROM dbo.Pro_data
WHERE ��ǰ�� = '��)�˻���Ĩ'

WITH DATE_TABLE AS (
SELECT ��ǰ��, DATEPART(YEAR,��������) AS Year, DATEPART(MONTH, ��������) AS Month, DATEPART(DAY, ��������) AS Day
FROM dbo.Pro_data
WHERE ��ǰ�� = '��)�˻���Ĩ'
)
SELECT * FROM DATE_TABLE
WHERE DAY BETWEEN 10 AND 30



-- WHERE Day BETWEEN 10 AND 30