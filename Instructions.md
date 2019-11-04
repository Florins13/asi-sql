### ASI class 


#### Configuration of 3 instances
1. Go to C:\SQLServer2017Media\Developer_ENU and run the setup to create a new instance.
2. In installation type select a new instance.
3. On Feature selection  enable SQL Server Replication.
4. On instance configuration set the names to PRAT_II_1, PRAT_II_2 and PRAT_II_3
5. On Database Engine Configuration Add the current user into the DB admin.
6. Run the SQL management studio as admin.
7. Give permissions to the created instances to the current users. (The folder can be found by cheing the properties)
8. To remove or change the endpoints we need to find it under Server Objects->Objects->Endpoints->DatabaseMirror
9. To active the tcp connections (partner) we need to enable the Protocals inside computer management->Services and applications->SQL Services and do enable

### Config the DB mirror
1. 

