-- ���ν��� -> ���α׷� ��� / �Ʒ��� �� ���̺��� �ڵ����� �����Ŵ.
CREATE PROCEDURE myProc1
AS
	SELECT * FROM memberTBL WHERE memberName = '������';
	SELECT * FROM productTBL WHERE productName = '�����';

go
EXECUTE myProc1;