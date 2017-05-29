# socialnet-example

## A basic social net site example built using [Struts 2](http://struts.apache.org/) ,[Spring](https://spring.io/), [Tiles](https://tiles.apache.org/),[Hibernate](http://hibernate.org/), [H2 Database](http://www.h2database.com) and [MySql](http://www.mysql.com/).
 
 
 
 **How to run**:
  1. Download repository
  2. Execute mvn tomcat7:run
  3. Load localhost:8080/SocialNet on your favorite browser
  
  If you don't want to use preset users add -Dbuild.preset.skip=true argument
  
  If using mysql as database add -Pmysql-db as argument. Default user and password will be filtered from profile 
  configuration in pom.xml or can be overridden in application.properties
  
  Selenium tests will be run when executing mvn:verify with phantomjs browser as default.
  
  To use a different browser (say chrome) select -Pchrome-browser, select a database profile (-Pmysql-db/-Ph2-db)
  and add a path to a driver with argument -Ddriver.binary.loc
  e.g.: mvn verify -Pchrome-browser -Ph2-db -Ddriver.binary.loc=<path to driver> -DskipUTs=true
 
  
