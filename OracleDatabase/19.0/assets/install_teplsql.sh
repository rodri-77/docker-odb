#!/bin/bash

sqlplus -s -l sys/${PASS}@${CONNECT_STRING} AS SYSDBA <<EOF
	BEGIN
	   EXECUTE IMMEDIATE 'DROP USER teplsql CASCADE';
	EXCEPTION
	   WHEN OTHERS THEN
		  NULL;
	END;
	/
	CREATE USER teplsql IDENTIFIED BY teplsql
	DEFAULT TABLESPACE users
	TEMPORARY TABLESPACE TEMP;
	GRANT CONNECT, RESOURCE TO teplsql;
	GRANT SELECT_CATALOG_ROLE, SELECT ANY DICTIONARY TO teplsql;
	GRANT UNLIMITED TABLESPACE TO teplsql;
EOF
sqlplus -s -l teplsql/teplsql@${CONNECT_STRING} <<EOF
	@/opt/teplsql/TE_TEMPLATES.sql
	@/opt/teplsql/tePLSQL.pks
	@/opt/teplsql/tePLSQL.pkb
EOF
