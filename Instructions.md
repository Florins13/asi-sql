### ASI class 


#### Configuration of 3 instances
1. Go to C:\SQLServer2017Media\Developer_ENU and run the setup to create a new instance.
2. In installation type select a new instance.
3. On Feature selection  enable SQL Server Replication.
4. On instance configuration set the names to PRAT_II_1, PRAT_II_2 and PRAT_II_3
5. On Database Engine Configuration Add the current user into the DB admin.
6. In computer management->Services and applications, we need to set the SQL Services Network with TCP as active 
7. Still in computer management  in SQL Server Services we need to grant authorizantion to a commun user in all DB. To simplify this part we need to set as a local user and then pick _local system_
8. Back to SQL Server Management studio, we need to grant permissions to this user. This oiptions can be found in Security-Login. Add the user _NT AUTHORITY\SYSTEM_ and give him permissions to sysadmin 
9. Run the SQL management studio as admin.
10. Give permissions to the created instances to the current users. (The folder can be found by cheing the properties)
11. To remove or change the endpoints we need to find it under Server Objects->Objects->Endpoints->DatabaseMirror
12. Last step, if it doesn't work, it is required to run the grant permission to the endpoint to the added user.
13. At some point if the have an error message saying that the MIRRORDB is already confiugured we need to remove the entry by running the other provided script.

