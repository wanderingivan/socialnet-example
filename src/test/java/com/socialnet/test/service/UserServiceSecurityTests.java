package com.socialnet.test.service;

import java.io.File;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.List;

import org.dbunit.dataset.DataSetException;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSetBuilder;
import org.junit.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.acls.domain.BasePermission;
import org.springframework.security.acls.domain.ObjectIdentityImpl;
import org.springframework.security.acls.domain.PrincipalSid;
import org.springframework.security.acls.model.MutableAcl;
import org.springframework.security.acls.model.MutableAclService;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.annotation.DirtiesContext.ClassMode;
import org.springframework.transaction.annotation.Transactional;

import com.socialnet.dao.UserDao;
import com.socialnet.model.User;
import com.socialnet.service.UserService;


@DirtiesContext(classMode=ClassMode.AFTER_EACH_TEST_METHOD)
public class UserServiceSecurityTests extends AbstractServiceSecurityTest{
	


	private  UserService service;
	

	private MutableAclService aclService;

	private  UserDao mockDao;

	/* User doesn't have role
	 * required for method
	 */
	@Test(expected=AccessDeniedException.class)
	@WithMockUser(username="username",password="password",authorities={"ROLE_USER"})
	public void testAccessDenied(){
		service.delete("username2");
	}
		
	/*
	 * User has role but no permission for
	 * object
	 */
	@Test(expected=AccessDeniedException.class)
	@WithMockUser(username="username",password="password",authorities={"ROLE_USER"})
	public void testAccessDeniedExceptionFromAcl(){
		User testUser = new User("username1","email","password");
		testUser.setId(2);
		service.updateUser(testUser);
	}
	
	/*
	 * User has role and permission for method and object
	 */
	@Test
	@WithMockUser(username="username3",password="password",authorities={"ROLE_USER"})
	public void testAccessGrantedFromAcl(){
		User testUser = new User("username1","email","password");
		testUser.setId(2);
		service.updateUser(testUser);
		Mockito.verify(mockDao,Mockito.times(1)).update(testUser);
	}
	
	/*
	 * User has admin role and can
	 * pass permission checks
	 */
	@Test
	@WithMockUser(username="username",password="password",authorities={"ROLE_ADMIN"})
	public void testAccessGrantedToAdmin(){
		User testUser = new User("username3","email","password");
		testUser.setId(1);
		service.updateUser(testUser);
		Mockito.verify(mockDao,Mockito.times(1)).update(testUser);
	}	

	@Test
	@Transactional
	public void testInsertAcl(){
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
	    SecurityContextHolder.getContext()
	      .setAuthentication(new UsernamePasswordAuthenticationToken("username4","password",authorities));
		MutableAcl test = aclService.createAcl(new ObjectIdentityImpl(User.class,new Integer(8)));
		test.insertAce(test.getEntries().size(), BasePermission.WRITE, new PrincipalSid("username4"), true);
		aclService.updateAcl(test);
	}
	
	@Autowired
	public void setService(UserService service) {
		this.service = service;
	}
	
	@Autowired
	public void setAclService(MutableAclService aclService){
		this.aclService = aclService;
	}

	

	@Autowired
	@Qualifier(value="mockUserDao")
	public void setUserDao(UserDao userDao) {
		this.mockDao = userDao;
	}

	@Override
	protected IDataSet getDataSet() throws MalformedURLException,
			DataSetException {
		return new FlatXmlDataSetBuilder().build(new File(defaultTestResourceFolder.concat("DbSecTestDataSet.xml")));
	}
	


}
