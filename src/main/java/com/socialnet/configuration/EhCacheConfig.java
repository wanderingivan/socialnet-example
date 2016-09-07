package com.socialnet.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.cache.support.NoOpCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;


@Configuration
@EnableCaching
public class EhCacheConfig {


	@Value("${image.cache.enable}")
	private boolean enableImageCache;
	
	@Bean
	public Cache mutableAclCache(){
		return cacheManager().getCache("aclCache");

	}
	@Bean
	public CacheManager cacheManager(){	
		if(enableImageCache){
		 return new EhCacheCacheManager(ehCacheFactoryBean().getObject());
		}else{
			return new NoOpCacheManager();
		}

	}
	
	@Bean
	public EhCacheManagerFactoryBean ehCacheFactoryBean(){
		EhCacheManagerFactoryBean fb = new EhCacheManagerFactoryBean();
		fb.setConfigLocation(new ClassPathResource("ehcache2.xml"));
		fb.setShared(true);
		fb.setCacheManagerName("SocialNetCache");
		fb.afterPropertiesSet();
		
		if(!enableImageCache){
			fb.getObject().removeCache("b64");
			fb.getObject().removeCache("image");
		}
		return fb;
	}
	
}
