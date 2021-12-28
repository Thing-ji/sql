-- Ʈ���� -> �ڵ����� ���� / ����,����,�߰� �� �۾��� �߻��ϸ� �ڵ����� ����Ǵ� �ڵ�.
-- ��ü � �ǽ�

INSERT INTO memberTBL VALUES ('Figure', '����', '��⵵ ������ ������');

SELECT * FROM memberTBL

UPDATE memberTBL SET memberAddress = '���� ������ ���ﵿ' WHERE memberName = '����';

DELETE memberTBL WHERE memberName = '����';

-- ���̺� ����
CREATE TABLE deleteMemberTBL
( memberID char(8),
  memberName nchar(5),
  memberAddress nchar(20),
  deletedDate date -- ������ ��¥
  );

go
CREATE TRIGGER trg_deleteMemberTBL -- Ʈ���� �̸�
ON memberTBL -- Ʈ���Ÿ� ������ ���̺�
AFTER DELETE -- ���� �Ŀ� �۵��ϰ� ����
AS
	-- deleted ���̺��� ������ ������̺� ����
	INSERT INTO deleteMemberTBL
		SELECT memberID, memberName, memberAddress, GETDATE() FROM deleted;

SELECT * FROM memberTBL;
SELECT * FROM deleteMemberTBL;

