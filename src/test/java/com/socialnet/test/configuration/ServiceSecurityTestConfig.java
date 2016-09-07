package com.socialnet.test.configuration;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.cache.support.NoOpCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.security.acls.model.MutableAclService;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.support.ResourceTransactionManager;

import com.socialnet.dao.UserDao;
import com.socialnet.dao.impl.HibernateUserDao;
import com.socialnet.service.UserService;
import com.socialnet.service.impl.UserServiceImpl;

@Configuration
@Import({com.socialnet.configuration.MethodSecurityConfig.class})
@EnableTransactionManagement
public class ServiceSecurityTestConfig {

	
	@Bean
	@Autowired
	public UserService userService(MutableAclService aclService){
		return new UserServiceImpl(userDao(),aclService,new String[]{"",""}, new BCryptPasswordEncoder());
	}
	
	@Bean(name="mockUserDao")
	public UserDao userDao(){
		return Mockito.mock(HibernateUserDao.class);
	}
	
	@Bean
	public SessionFactory sessionFactory(){
		return Mockito.mock(SessionFactory.class);
	}
	
	@Bean
	public Cache cache(){
		return cacheManager().getCache("aclCache");
	}
	
	@Bean
	public CacheManager cacheManager(){
		return new NoOpCacheManager();
	}
	@Bean
	public EhCacheManagerFactoryBean ehCacheFactoryBean(){
		EhCacheManagerFactoryBean fb = new EhCacheManagerFactoryBean();
		fb.setShared(true);
		fb.setCacheManagerName("SocialNetTestCache");
		fb.afterPropertiesSet();
		fb.getObject().addCache("aclCache");
		return fb;
	}
	
	
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
		dao.setEnableGroups(true);
		dao.setEnableAuthorities(false);
		dao.afterPropertiesSet();
		return dao;
	}
	
	@Bean(name="txManager")
	@Autowired
	public ResourceTransactionManager transactionManager (DataSource dataSource){
		return new DataSourceTransactionManager(dataSource);
	}
	
	@Bean 
	public PasswordEncoder passwordEncoder(){
		return new BCryptPasswordEncoder(12);
	}
	
}
	
	
	