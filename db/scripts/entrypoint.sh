# Run initialization and SQL Server at the same time
chmod +x /scripts/db-init.sh & \
/scripts/db-init.sh & \
/opt/mssql/bin/sqlservr