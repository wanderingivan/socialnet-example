package com.socialnet.configuration;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;


@Configuration
@Import({WebSecurityConfig.class,MethodSecurityConfig.class})
public class SecurityConfig {


	
	@Bean
	@Autowired
	public DaoAuthenticationProvider authProvider(DataSource dataSource){
		DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
		provider.setUserDetailsService(userDetailsService(dataSource));
		provider.setPasswordEncoder(passwordEncoder());
		return provider;
	}
	
	@Bean
	public UserDetailsService userDetailsService (DataSource dataSource){
		JdbcDaoImpl dao =  new JdbcDaoImpl();
		dao.setDataSource(dataSource);
		dao.setEnableAuthorities(true);
		dao.afterPropertiesSet();
		return dao;
	}
	
	@Bean 
	public PasswordEncoder passwordEncoder(){
		return new BCryptPasswordEncoder(12);
	}
	

}