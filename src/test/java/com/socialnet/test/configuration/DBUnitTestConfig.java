package com.socialnet.test.configuration;


import javax.sql.DataSource;

import org.dbunit.DataSourceDatabaseTester;
import org.dbunit.IDatabaseTester;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
public class DBUnitTestConfig {

	@Bean(name="databaseTester")
	public IDatabaseTester iDatabaseTester(){
		return new DataSourceDatabaseTester(testDataSource());
	}
	
	@Bean
	public DataSource testDataSource(){
		DriverManagerDataSource data = new DriverManagerDataSource();
		data.setDriverClassName("com.mysql.jdbc.Driver");
		data.setUrl("jdbc:mysql://localhost:3306/SOCIALNETTEST");
		data.setUsername("tester");
		data.setPassword("pass");
		return data;
	}

	
}
