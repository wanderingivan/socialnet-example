package com.socialnet.test.configuration;

import java.io.IOException;
import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.support.ResourceTransactionManager;



@Configuration
@EnableTransactionManagement
@ComponentScan("com.socialnet.dao")
public class DaoTestConfig {

	private boolean useCache = false;
	
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
		
		p.put("hibernate.show_sql","false");
		p.put("hibernate.format_sql","true");
		
		/* Second level cache setup */
		if(useCache){
		  p.put("hibernate.cache.region.factory_class","org.hibernate.cache.ehcache.EhCacheRegionFactory");
		  p.put("hibernate.cache.use_second_level_cache","true");
		  p.put("hibernate.cache.use_query_cache","true");
		}else{
			p.put("hibernate.cache.use_second_level_cache","false");
		}
		/* Connection Pool Setup */
		p.put("hibernate.c3p0.min_size","5");
		p.put("hibernate.c3p0.max_size","20");
		p.put("hibernate.c3p0.timeout","300");
		p.put("hibernate.c3p0.max_statements","50");
		p.put("hibernate.c3p0.idle_test_period","3000");
		return p;
	}
    
	@Bean(name="txManager")
	@Autowired
	public ResourceTransactionManager transactionManager(DataSource dataSource) throws IOException{
		ResourceTransactionManager manager = new HibernateTransactionManager(sessionFactory(dataSource));
		return manager;
	}

}
