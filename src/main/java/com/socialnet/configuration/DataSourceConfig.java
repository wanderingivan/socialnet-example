package com.socialnet.configuration;

import java.beans.PropertyVetoException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration
@PropertySource("classpath:application.properties")
public class DataSourceConfig {
	
	@Value("${db.url}")
	private String url;
	
	@Value("${db.user}")
	private String username;
	
	@Value("${db.password}")
	private String password;

	@Value("${db.driver_class}")
	private String driverClass;
	
	@Value("${db.min_pool_size}")
	private int minPoolSize;

	@Value("${db.max_pool_size}")
	private int maxPoolSize;
	
	
	@Bean
	public DataSource dataSource(){
		ComboPooledDataSource dataSource = new ComboPooledDataSource();
		try {
			dataSource.setDriverClass(driverClass);
		} catch (PropertyVetoException e) {
			e.printStackTrace();
		}
		dataSource.setJdbcUrl(url);
		dataSource.setUser(username);
		dataSource.setPassword(password);
		dataSource.setMinPoolSize(minPoolSize);
		dataSource.setMaxPoolSize(maxPoolSize);
		
		return dataSource;
	}
}
