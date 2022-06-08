# sql


EXECUTE sp_tables @table_type = "'TABLE'";

-- 지정된 테이블에 따라 테이블 정보 출력\
EXECUTE sp_columns\
  @table_name = 'Department',   # 테이블\
  @table_owner = 'HumanResources';  # 스키마\
