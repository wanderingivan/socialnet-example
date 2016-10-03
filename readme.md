# socialnet-example

## A basic social net site example built using [Struts 2](http://struts.apache.org/) ,[Spring](https://spring.io/), [Tiles](https://tiles.apache.org/),[Hibernate](http://hibernate.org/) and [MySql](http://www.mysql.com/).
 
 
 
 **How to run**:
  1. Download repository
  2. Run /src/scripts/sql/create_database.sql on a database of your choice
   * (Optional) Run /src/scripts/sql/createPresetDatabase.sql -adds pre made articles,users and comments
  3. Update src/main/resources/application.properties to include db url and user 
  4. Update application.properties to include default image folder
   * (Optional) use image folder included at /src/images - application.properties expects absolute path
  5. Execute mvn tomcat7:run
  6. Load localhost:8080/SocialNet in your favorite browser
  
 For integration tests an empty database must be created with createDatabase.sql.
 Test datasource configuration will be in com/socialnet/test/configuration/DBUnitTestConfig.class   
  
