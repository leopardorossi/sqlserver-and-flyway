# Wait to be sure that SQL Server came up
sleep 30s

# Run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${MSSQL_SA_PASSWORD} -d master -i /scripts/init.sql