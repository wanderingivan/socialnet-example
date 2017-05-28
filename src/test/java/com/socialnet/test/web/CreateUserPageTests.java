package com.socialnet.test.web;

import org.jboss.arquillian.container.test.api.RunAsClient;
import org.jboss.arquillian.graphene.page.InitialPage;
import org.jboss.arquillian.graphene.page.Page;
import org.jboss.arquillian.junit.Arquillian;
import org.junit.Test;
import org.junit.runner.RunWith;

import com.socialnet.test.web.page.CreateUserPage;
import com.socialnet.test.web.page.LoginPage;
import com.socialnet.test.web.page.UserPage;

import static org.junit.Assert.*;

@RunAsClient
@RunWith(Arquillian.class)
public class CreateUserPageTests extends AbstractWebPageTest {
    
    @Page
    private CreateUserPage cPage;
    
    @Page
    private UserPage uPage;
    
    @Test
    public void testCreateUserAcessDeniedException(@InitialPage LoginPage login){
        login.loginIfNotAuthenticated("username1", "password");
        loadPage("/user/createPage");
        cPage.createUser("username7", "password", "email@email7.com");
        assertEquals("Error Page Prototype",driver.getTitle().trim());
    }
    
    @Test
    public void testCreateUser(@InitialPage LoginPage login){
        login.logoutIfAuthenticated();
        loadPage("/user/createPage");
        cPage.createUser("username6", "password", "email@email6.com");
        assertEquals("username6", uPage.getUsername());
    }

    @Test
    public void testCreateUserInputErrors(@InitialPage LoginPage login){
        login.logoutIfAuthenticated();
        loadPage("/user/createPage");
        cPage.createUser("", "", "email@email6");
        
        assertFalse(cPage.getUsernameError().isEmpty());
        assertFalse(cPage.getEmailError().isEmpty());
    }
    
    @Test
    public void testCreateUserPasswordInputErrors(@InitialPage LoginPage login){
        login.logoutIfAuthenticated();
        loadPage("/user/createPage");
        cPage.createUser("username19", "", "email@email6.com");
        
        assertFalse(cPage.getPasswordError().isEmpty());
        
        cPage.createUser("username", "pass", "email@email6.com");
        
        assertFalse(cPage.getPasswordError().isEmpty());
    }
    
}
