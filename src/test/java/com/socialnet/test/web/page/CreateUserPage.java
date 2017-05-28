package com.socialnet.test.web.page;

import org.jboss.arquillian.graphene.Graphene;
import org.jboss.arquillian.graphene.page.Location;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

@Location("SocialNet/user/createPage")
public class CreateUserPage {
    
    @FindBy(id="c_username")
    private WebElement usernameInput;

    @FindBy(id="c_password")
    private WebElement passwordInput;
    
    @FindBy(id="c_email")
    private WebElement emailInput;
        
    @FindBy(id="createSubmit")
    private WebElement createSubmit;
    
    @FindBy(id="usernameError")
    private WebElement usernameError;
    
    @FindBy(id="passwordError")
    private WebElement passwordError;
    
    @FindBy(id="emailError")
    private WebElement emailError;
    
    public void createUser(String username,String password,String email){
        
        this.usernameInput.clear();
        this.usernameInput.sendKeys(username);
        this.passwordInput.clear();
        this.passwordInput.sendKeys(password);
        this.emailInput.clear();
        this.emailInput.sendKeys(email);

        Graphene.guardHttp(createSubmit)
                .click();
    }
    
    public String getUsernameError(){
        return usernameError.getText().trim();
    }
    
    public String getPasswordError() {
        return passwordError.getText().trim();
    }

    public String getEmailError() {
        return emailError.getText().trim();
    }
    
}
