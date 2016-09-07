package com.socialnet.configuration;

import java.io.IOException;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.support.ResourceTransactionManager;


@Configuration
@EnableTransactionManagement
public class TransactionConfig {

	@Bean(name="txManager")
	@Autowired
	public ResourceTransactionManager transactionManager (SessionFactory sessionFactory) throws IOException{
		ResourceTransactionManager manager = new HibernateTransactionManager(sessionFactory);
		return manager;
	}
}
