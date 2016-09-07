package com.socialnet.configuration;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.dispatcher.multipart.MultiPartRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.Scope;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.security.acls.model.MutableAclService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.socialnet.dao.UserDao;
import com.socialnet.service.ImageService;
import com.socialnet.service.LogService;
import com.socialnet.service.impl.BasicLogService;
import com.socialnet.service.impl.ImageServiceImpl;
import com.socialnet.service.impl.UserServiceImpl;
import com.socialnet.util.ImageUtil;
import com.socialnet.util.SpringMultipartParser;

@Configuration
@ComponentScan(basePackages={"com.socialnet.service","com.socialnet.dao","com.socialnet.util"},excludeFilters={@ComponentScan.Filter(type= FilterType.REGEX,pattern="com.socialnet.test.*")})
@Import({EhCacheConfig.class,TransactionConfig.class,DataSourceConfig.class,HibernateConfig.class,SecurityConfig.class})
@PropertySource("classpath:application.properties")
public class SocialNetConfig {

	@Value("${image.folder}")
	private String picFolder;
	
	@Value("${image.convert.jpg}")
	private String convertToJpg;

	@Value("${image.maxUpload.size}")
	private String maxUploadSize;
	
	@Value("${image.maxUncompressed.size}")
	private String maxUncompresssed;

	@Value("${image.defaultProfileImagePath}")
	private String defaultProfileImagePath;
	
	@Value("${image.defaultCoverImagePath}")
	private String defaultCoverImagePath;
	
	@Value("${image.placeholder.filename}")
	private String placeholder;
	
	@Value("${log.folder}")
	private String logFolder;
	
    @Bean
	public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
		return new PropertySourcesPlaceholderConfigurer();
	}
	
    
    @Bean
	public ImageUtil imageUtil(){
		ImageUtil util = new ImageUtil(picFolder,Boolean.valueOf(convertToJpg),Long.valueOf(maxUncompresssed));
		return util;
	}
    
	@Bean
	public LogService logService(){
		Map<String,String> aliases = new HashMap<>();
	    //Aliases for log filenames
		aliases.put("action","newssite.actionDebug.log");
		aliases.put("error","newssite.error.log");
		aliases.put("security","newssite.security.log");
		aliases.put("dao","newssite.daoDebug.log");
		return new BasicLogService(aliases,logFolder);
	}
   	/* 
   	 *  Multipart resolver so we can include spring security 
   	 *  csrf tokens in multipart posts 
   	 */
	@Bean(name="filterMultipartResolver",destroyMethod="cleanUp")
	@Scope("prototype")
	public MultipartResolver multipartResolver(){
		CommonsMultipartResolver resolver = new CommonsMultipartResolver();
		resolver.setMaxUploadSize(Long.valueOf(maxUploadSize));
		return resolver;
	}
	
	@Bean
	@Autowired
	public UserServiceImpl userServiceImpl(UserDao userDao,MutableAclService aclService,PasswordEncoder encoder){
		
		return new UserServiceImpl(userDao, aclService, new String []{defaultProfileImagePath,
				                                                      defaultCoverImagePath},encoder);
	}
	
	@Bean
	public ImageService imageService(){
		return new ImageServiceImpl(imageUtil(),placeholder);
	}
	
	@Bean(name="springMultipartParser")
	public MultiPartRequest multiPartRequest(){
		return new SpringMultipartParser();
	}
}
