package com.socialnet.test.configuration;


import static java.nio.charset.StandardCharsets.UTF_8;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.dbunit.DataSourceDatabaseTester;
import org.dbunit.IDatabaseTester;
import org.h2.tools.RunScript;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
public class DBUnitTestConfig {

	@Bean(name="databaseTester")
	public IDatabaseTester iDatabaseTester() throws SQLException {
	    createSchema();
		return new DataSourceDatabaseTester(testDataSource());
	}
	
	@Bean
	public DataSource testDataSource(){
        DriverManagerDataSource data = new DriverManagerDataSource();
        data.setDriverClassName("org.h2.Driver");
        data.setUrl("jdbc:h2:mem:socialnettest;MODE=mysql;DB_CLOSE_DELAY=-1;");
        data.setUsername("sa");
        data.setPassword("sa");
        return data;
	}

    protected void createSchema() throws SQLException {
        RunScript.execute("jdbc:h2:mem:socialnettest;MODE=mysql;DB_CLOSE_DELAY=-1;", "sa","sa", "classpath:scripts/sql/create_database.sql",UTF_8,false);
        RunScript.execute("jdbc:h2:mem:socialnettest;MODE=mysql;DB_CLOSE_DELAY=-1;", "sa","sa", "classpath:scripts/sql/create_procedures_h2.sql",UTF_8,false);
    }
	
}
