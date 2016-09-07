package com.socialnet.configuration;

import java.io.IOException;
import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;

@Configuration
@PropertySource("classpath:application.properties")
public class HibernateConfig {
	
	
	@Value("${hibernate.dialect}")
	private String dialect;
	
	@Value("${hibernate.show_sql}")
	private boolean show_sql;
	
	@Value("${hibernate.second_level_cache}")
	private boolean enableCache;

	
	@Bean
	@Autowired
	public SessionFactory sessionFactory(DataSource dataSource) throws IOException{
		LocalSessionFactoryBean factory = new LocalSessionFactoryBean();
		factory.setDataSource(dataSource);
		factory.setHibernateProperties(hibernateProperties());
		factory.setPackagesToScan("com.socialnet.model");
		factory.afterPropertiesSet();
		return factory.getObject();
	}
	
	
	@Bean
	public Properties hibernateProperties(){
		Properties p = new Properties();
		p.put("hibernate.dialect",dialect);
		if(show_sql){
			p.put("hibernate.show_sql","true");
			p.put("hibernate.format_sql","true");
		}
		
		if(enableCache){
		  p.put("hibernate.cache.region.factory_class","org.hibernate.cache.ehcache.EhCacheRegionFactory");
		  p.put("hibernate.cache.use_second_level_cache","true");
		  p.put("hibernate.cache.use_query_cache","true");
		}else{
		  p.put("hibernate.cache.use_second_level_cache","false");
		}
		
		p.put("hibernate.c3p0.min_size","5");
		p.put("hibernate.c3p0.max_size","20");
		p.put("hibernate.c3p0.timeout","300");
		p.put("hibernate.c3p0.max_statements","50");
		p.put("hibernate.c3p0.idle_test_period","3000");
		return p;
	}
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
		return new PropertySourcesPlaceholderConfigurer();
	}
	
}