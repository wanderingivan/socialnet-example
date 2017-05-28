package com.socialnet.configuration;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.access.AccessDeniedHandlerImpl;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.socialnet.security.*;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter  {

	
	@Autowired
	public void configure(AuthenticationManagerBuilder auth,DaoAuthenticationProvider provider) throws Exception {
		auth.authenticationProvider(provider);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
	  http.authorizeRequests()
		.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
		.antMatchers("/user/edit*").access("isAuthenticated()")
		.antMatchers("/user/user-messages*").access("isAuthenticated()")
		.antMatchers("/message/send*").access("isAuthenticated()")
		.antMatchers("/message/add*").access("isAuthenticated()")
		.antMatchers("/message/*").permitAll()
		.antMatchers("/**").permitAll()
		.and()
		
		.formLogin()
		.loginPage("/login")
		            .successHandler(authSuccessHandler())
			        .failureHandler(authFailureHandler())
	    .and()
	    .logout().logoutSuccessUrl("/index")
	    .and().exceptionHandling().accessDeniedHandler(accessDeniedHandler())
	    .and().httpBasic();

		
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		// Disable security on static resources and images
		web.ignoring().antMatchers("/css/*")
		              .antMatchers("/images/*")
		              .antMatchers("/js/*")
		              .antMatchers("/util/loadImage*");
	}
	
	@Bean
	public AuthenticationSuccessHandler authSuccessHandler(){
		return new SavedRequestAwareRoleBasedAuthenticationSuccessHandler(roleUrls(), defaultSuccessUrl());
	}
	
	
	@Bean
	public AuthenticationFailureHandler authFailureHandler(){
		return new SimpleAuthenticationFailureHandler(defaultFailureUrl());
	}
	
	/**
	 * Returns a map with user roles as keys
	 * and default success urls as values
	 * @return
	 */
	private Map<String,String> roleUrls(){
		HashMap<String,String> roleUrls = new HashMap<>();
		roleUrls.put("ROLE_ADMIN", "/admin/welcome");
		roleUrls.put("ROLE_USER", "/user/show");
		return roleUrls;
	}
	@Bean
	public AccessDeniedHandler accessDeniedHandler(){
		AccessDeniedHandlerImpl handler = new  AccessDeniedHandlerImpl();
		handler.setErrorPage("/index");
		return handler;
	}
	/**
	 * Returns a default authentication success url
	 * @return
	 */
	private String defaultSuccessUrl(){
		return "/index";
	}
	

	/**
	 * Returns a default authentication failure url
	 * @return
	 */
	private String defaultFailureUrl(){
		return "/index";
	}
}
