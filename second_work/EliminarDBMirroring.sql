-- in case of this error:
--Msg 1405, Level 16, State 1, Line 3
--The database "MIRRORDB" is already enabled for database mirroring.

--no principal ou no mirror, use this
use master;
ALTER DATABASE MIRRORDB   
    SET PARTNER OFF
GO