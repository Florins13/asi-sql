/* 
   Configurar DB mirroring 
   =======================
   
   Instancia1 - principal
   instancia2 - mirror
   instancia3 - witness
   
   Assume-se que as credennciais de Log do processo Sql Server em todas as inst�ncias est�o
   configuradas e que os logins respetivos est�o no grupo sysadmim em server roles.

   Pretende-se o modo de alta seguran�a com failover autom�tico.
   
   Se j� existirem nas inst�ncias endpoints para database mirroring,
   apag�-los previamente
*/   
-- Passo 1 (normalmente, n�o � ser necess�rio)
-- no principal
USE master;  
GO  
ALTER DATABASE MIRRORDB   
SET RECOVERY FULL;  
GO 

-- passo 2
-- no principal
BACKUP DATABASE MIRRORDB   
    TO DISK = 'C:\ASI\Backup\MIRROR_FB.bak'   
    WITH FORMAT  
GO

BACKUP LOG MIRRORDB   
    TO DISK = 'C:\ASI\Logs\MIRROR_LB.bak'   
	WITH FORMAT
GO

-- No mirror:
-- ligar � inst�ncia 2 (change connection)

RESTORE DATABASE MIRRORDB   
    FROM DISK = 'C:\ASI\Backup\MIRROR_FB.bak'   
	WITH MOVE 'MIRRORDB'  to 'C:\Program Files\Microsoft SQL Server\MSSQL14.PRAT_II_2\MSSQL\DATA\MIRRORDB.mdf',
	     MOVE 'MIRRORDB_log'to 'C:\Program Files\Microsoft SQL Server\MSSQL14.PRAT_II_2\MSSQL\DATA\MIRRORDB_log.ldf',
    NORECOVERY, 
	REPLACE
GO  

RESTORE LOG MIRRORDB   
    FROM DISK = 'C:\ASI\Logs\MIRROR_LB.bak'      
	WITH MOVE 'MIRRORDB_log'to 'C:\Program Files\Microsoft SQL Server\MSSQL14.PRAT_II_2\MSSQL\DATA\MIRRORDB_log.ldf',
    NORECOVERY  
GO 

--passo 3 (criar endpoints)
-- no principal:
--ligar � inst�ncia 1 (change connection):
DROP ENDPOINT Endpt_Mir
CREATE ENDPOINT Endpt_Mir  
    STATE=STARTED   
    AS TCP (LISTENER_PORT=5022)   
    FOR DATABASE_MIRRORING (ROLE=PARTNER)  
GO 
 

 -- no mirror
 --ligar � inst�ncia 2 (change connection):
CREATE ENDPOINT Endpt_Mir  
    STATE=STARTED   
    AS TCP (LISTENER_PORT=5023)   
    FOR DATABASE_MIRRORING (ROLE=PARTNER)   
GO 

 -- no witness
 --ligar � inst�ncia 3 (change connection):
CREATE ENDPOINT Endpt_Mir  
    STATE=STARTED   
    AS TCP (LISTENER_PORT=5024)   
    FOR DATABASE_MIRRORING (ROLE=WITNESS) 
GO 


-- passo 4
-- no mirror
--ligar � inst�ncia 2 (change connection):
use master;
ALTER DATABASE MIRRORDB   
    SET PARTNER = 'TCP://localhost:5022'  
GO  


--No principal
--ligar � inst�ncia 1 (change connection)
USE master; 

ALTER DATABASE MIRRORDB   
    SET PARTNER = 'TCP://localhost:5023'  
GO  

-- a instru��o seguinte n�o � necess�ria, pois FULL � o
-- valor por omiss�o 
-- (ver https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-database-transact-sql-database-mirroring)
--ALTER DATABASE MIRRORDB   
--    SET PARTNER SAFETY FULL  
--GO  

-- para haver failover autom�tico basta ativar o witness:
ALTER DATABASE MIRRORDB   
    SET WITNESS = 'TCP://localhost:5024'  
GO 
