package com.socialnet.test.configuration;

import org.mockito.Mockito;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.socialnet.dao.UserDao;
import com.socialnet.service.ImageService;
import com.socialnet.service.UserService;
import com.socialnet.service.impl.ImageServiceImpl;
import com.socialnet.util.ImageUtil;

@Configuration
public class ValidationsTestConfig {

    @Bean
    public ImageUtil imageUtil (){
    	return Mockito.mock(ImageUtil.class);
    }
    @Bean
    public UserService service(){
    	return Mockito.mock(UserService.class); 
    }

    @Bean
    public UserDao userDao(){
    	return Mockito.mock(UserDao.class);
    }
    
    @Bean ImageService imageService(){
    	return new ImageServiceImpl(imageUtil(),"placeholder");
    }
}
