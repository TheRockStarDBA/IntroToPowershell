/* For security reasons the login is created disabled and with a random password. */
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=N'·Z³ÍRGí£y¥W"]<À!%õS/_ ½)®7', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
ALTER LOGIN [##MS_PolicyEventProcessingLogin##] DISABLE
/* For security reasons the login is created disabled and with a random password. */
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=N'öyª§ì¾eêTt§Áz7Þ®v)pR×î&f', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
ALTER LOGIN [##MS_PolicyTsqlExecutionLogin##] DISABLE
/* For security reasons the login is created disabled and with a random password. */
CREATE LOGIN [appuser] WITH PASSWORD=N'<õæW+ÃÑ''¯ Eb#A~@:L*·ßµ®ªj', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
ALTER LOGIN [appuser] DISABLE
CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
CREATE LOGIN [NT SERVICE\MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\MSSQLSERVER]
CREATE LOGIN [NT SERVICE\SQLSERVERAGENT] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLSERVERAGENT]
CREATE LOGIN [NT SERVICE\SQLWriter] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLWriter]
CREATE LOGIN [NT SERVICE\Winmgmt] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\Winmgmt]
/* For security reasons the login is created disabled and with a random password. */
CREATE LOGIN [reportreader] WITH PASSWORD=N'vXä¶ã¤)öãû{qâßß0d¨ÝqjVOt®', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
ALTER LOGIN [reportreader] DISABLE
/* For security reasons the login is created disabled and with a random password. */
CREATE LOGIN [sa] WITH PASSWORD=N'»/Ì¦ÿÏÇºº 4?¹ò¥?!"p(k', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
ALTER LOGIN [sa] DISABLE
ALTER SERVER ROLE [sysadmin] ADD MEMBER [sa]
CREATE LOGIN [SDF\Administrator] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
ALTER SERVER ROLE [sysadmin] ADD MEMBER [SDF\Administrator]
CREATE LOGIN [sdf\mfal] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
ALTER SERVER ROLE [sysadmin] ADD MEMBER [sdf\mfal]
