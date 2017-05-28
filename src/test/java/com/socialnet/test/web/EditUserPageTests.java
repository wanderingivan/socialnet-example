package com.socialnet.test.web;

import org.jboss.arquillian.container.test.api.RunAsClient;
import org.jboss.arquillian.graphene.page.InitialPage;
import org.jboss.arquillian.graphene.page.Page;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.arquillian.junit.InSequence;
import org.junit.Test;
import org.junit.runner.RunWith;

import com.socialnet.test.web.page.EditUserPage;
import com.socialnet.test.web.page.LoginPage;
import com.socialnet.test.web.page.UserPage;

import static org.junit.Assert.*;

@RunAsClient
@RunWith(Arquillian.class)
public class EditUserPageTests extends AbstractWebPageTest {

    
    @Page
    private EditUserPage ePage;
    
    @Page
    private UserPage uPage;

    
    @Test
    @InSequence(1)
    public void testEditUserAcessDeniedExceptionFromAcl(@InitialPage LoginPage login){
        login.logoutIfAuthenticated();
        login.login("username1", "password");
        loadPage("/user/editPage?username=username2");

        ePage.editUser("username6","email@email6.com");
        
        assertEquals("Error Page Prototype",driver.getTitle().trim());
    }
    
    @Test
    @InSequence(2)
    public void testEditUser(@InitialPage LoginPage login){
        login.logoutIfAuthenticated();
        loadPage("/index");
        login.login("username2", "password");
        loadPage("/user/editPage?username=username2");
        ePage.editUser("username7", "email@email7.com");
        loadPage("/user/show?username=username7");
        
        assertEquals("username7", uPage.getUsername());
    }

    @Test
    @InSequence(3)
    public void testEditUserInputErrors(@InitialPage LoginPage login){
        login.logoutIfAuthenticated();
        loadPage("/index");
        login.login("username1", "password");
        loadPage("/user/editPage?username=username1");
        ePage.editUser("", "email@email6");
        
        assertFalse(ePage.getUsernameError().isEmpty());
        assertFalse(ePage.getEmailError().isEmpty());
    }
    
    @Test
    @InSequence(4)
    public void testEditUserAcessDeniedException(@InitialPage LoginPage login){
        login.logoutIfAuthenticated();
        loadPage("/user/show?username=username3");
        loadPage("/user/editPage?username=username3");
        
        assertTrue(login.assertOnLoginPage());
    }
    
}
