package com.socialnet.configuration;

import java.util.EnumSet;

import javax.servlet.DispatcherType;
import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;
import org.apache.tiles.TilesException;
import org.springframework.orm.hibernate4.support.OpenSessionInViewFilter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.multipart.support.MultipartFilter;

import com.socialnet.util.TilesResolver;

/*
 * Initializer that sets up spring and tiles listeners
 * and registers 4 filters - spring's multipart filter to parse csrf tokens 
 * spring security's DelegatingFilterProxy
 * spring's OSIV filter
 * and struts's PrepareAndExecuteFilter
 */
public class SocialNetInitializer implements WebApplicationInitializer {

	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		
        AnnotationConfigWebApplicationContext appContext = setUpAppContext();
        servletContext.addListener(new ContextLoaderListener(appContext));
        
          //TilesAccess a class used in TilesListener doesn't have permission to append the tiles container
          //to the servlet context if initialized this way so we have to do it manually- this is fixed in 2.3.28 onward
        try{
        	servletContext.setAttribute("org.apache.tiles.CONTAINER",new TilesResolver().createContainer(servletContext));
        }catch(TilesException te){
        	System.out.println("Exception Creating Tiles Container" + te);
        	throw new RuntimeException(te);
        }
        
        FilterRegistration.Dynamic filter = servletContext.addFilter("multipartResolver", new MultipartFilter());
        filter.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), false, "/*");
        
        filter = servletContext.addFilter("springSecurityFilterChain", new DelegatingFilterProxy("springSecurityFilterChain"));
        filter.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");
        
        filter = servletContext.addFilter("springOSIVFilter", new OpenSessionInViewFilter());
        filter.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true,"/*");
        
        filter = servletContext.addFilter("struts2", new StrutsPrepareAndExecuteFilter());
        filter.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");
        
	}

	
	private AnnotationConfigWebApplicationContext setUpAppContext(){
        AnnotationConfigWebApplicationContext appContext = new AnnotationConfigWebApplicationContext();
        appContext.register(SocialNetConfig.class);
        return appContext;
	}
	
	
}
