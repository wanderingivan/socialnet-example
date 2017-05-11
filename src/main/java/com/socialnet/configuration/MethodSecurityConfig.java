package com.socialnet.configuration;



import java.sql.SQLException;

import javax.sql.DataSource;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.PermissionEvaluator;
import org.springframework.security.access.expression.method.DefaultMethodSecurityExpressionHandler;
import org.springframework.security.access.expression.method.MethodSecurityExpressionHandler;
import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.acls.AclPermissionEvaluator;
import org.springframework.security.acls.domain.AclAuthorizationStrategy;
import org.springframework.security.acls.domain.AclAuthorizationStrategyImpl;
import org.springframework.security.acls.domain.AuditLogger;
import org.springframework.security.acls.domain.ConsoleAuditLogger;
import org.springframework.security.acls.domain.DefaultPermissionGrantingStrategy;
import org.springframework.security.acls.domain.SpringCacheBasedAclCache;
import org.springframework.security.acls.jdbc.BasicLookupStrategy;
import org.springframework.security.acls.jdbc.JdbcMutableAclService;
import org.springframework.security.acls.jdbc.LookupStrategy;
import org.springframework.security.acls.model.AclCache;
import org.springframework.security.acls.model.AclService;
import org.springframework.security.acls.model.PermissionGrantingStrategy;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.method.configuration.GlobalMethodSecurityConfiguration;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;


@Configuration
@EnableGlobalMethodSecurity(prePostEnabled=true)
public class MethodSecurityConfig extends GlobalMethodSecurityConfiguration{
	

	@Autowired
	public void configure(AuthenticationManagerBuilder auth,DaoAuthenticationProvider provider) throws Exception {
		auth.authenticationProvider(provider);
	}
	
	@Bean
	@Autowired
	public MethodSecurityExpressionHandler expressionHandler(PermissionEvaluator evaluator){
		DefaultMethodSecurityExpressionHandler handler = new DefaultMethodSecurityExpressionHandler();
		handler.setPermissionEvaluator(evaluator);
		return handler;
		
	}
	
	@Bean
	@Autowired
	public PermissionEvaluator permissionEvaluator(AclService aclService){
		return new AclPermissionEvaluator(aclService);
	}
	
	@Bean
	@Autowired
	public AclService mutableAclService(DataSource dataSource,LookupStrategy lookupStrategy,AclCache aclCache) throws SQLException{
		JdbcMutableAclService service = new JdbcMutableAclService(dataSource,lookupStrategy,aclCache);
		service.setClassIdentityQuery(classIdentityQuery());
		service.setSidIdentityQuery(sidIdentityQuery());
		return service;
	}

	
	@Bean
	@Autowired
	public LookupStrategy lookupStrategy(DataSource dataSource,AclCache aclCache){
		return new BasicLookupStrategy(dataSource, aclCache, aclAuthorizationStrategy(), auditLogger());		
	}
	
	@Bean
	public AclAuthorizationStrategy aclAuthorizationStrategy(){
		return new AclAuthorizationStrategyImpl(auths());
	}

	@Bean
	@Autowired
	public AclCache aclCache(Cache cache){
		return new SpringCacheBasedAclCache(cache, permissionStrategy(), aclAuthorizationStrategy());
	}
	
	@Bean
	public PermissionGrantingStrategy permissionStrategy(){
		return new DefaultPermissionGrantingStrategy(auditLogger());
	}
	
	/*
	 * Auth's used for the Acl authorization strategy
	 * [0] - General Changes
	 * [1] - Modify  Auditing
	 * [2] - Take Ownership
	 */
	@Bean
	public GrantedAuthority[] auths() {
		GrantedAuthority [] auths = new GrantedAuthority[3];
		for(int i=0;i<3;i++){
			auths[i] = new SimpleGrantedAuthority("ROLE_ANONYMOUS");
		}
		return auths;
	}
	
	@Bean
	public AuditLogger auditLogger(){
		return new ConsoleAuditLogger();
	}
	
	@Bean 
	public RoleHierarchy roleHierarchy(){
		RoleHierarchyImpl rh = new RoleHierarchyImpl();
		rh.setHierarchy("ROLE_ADMIN > ROLE_USER "
	                    +"ROLE_USER > ROLE_VISITOR");
		return rh;
	}
	
	/*
	 * Note : this is assuming mysql is used as db 
	 */
	private String classIdentityQuery(){
	    return "SELECT LAST_INSERT_ID()";
	}

	private String sidIdentityQuery(){
        return "SELECT LAST_INSERT_ID()";
	}
}
