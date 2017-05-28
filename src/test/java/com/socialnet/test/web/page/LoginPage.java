package com.socialnet.test.web.page;

import org.jboss.arquillian.graphene.GrapheneElement;
import org.jboss.arquillian.graphene.page.Location;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.jboss.arquillian.graphene.Graphene;


@Location("SocialNet/index")
public class LoginPage {

    @FindBy(id="username")
    private WebElement usernameInput;

    @FindBy(id="password")
    private WebElement passwordInput;
    
    @FindBy(id="loginSubmit")
    private GrapheneElement loginSubmit;
    
    @FindBy(id="logoutSubmit")
    private GrapheneElement logout;
    
    public void login(String username, String password){
        
        this.usernameInput.clear();
        this.passwordInput.clear();
        this.usernameInput.sendKeys(username);
        this.passwordInput.sendKeys(password);
        
        Graphene.guardHttp(loginSubmit)
                .click();
    }
    
    public void loginIfNotAuthenticated(String username, String password){
        if(!logout.isPresent()){
            login(username,password);
        }
    }
    
    public void logoutIfAuthenticated(){
        if(logout.isPresent()){
            Graphene.guardHttp(logout).click();
        }
    }
    
    public boolean assertOnLoginPage() {
        return loginSubmit.isPresent();
    }
    
}
