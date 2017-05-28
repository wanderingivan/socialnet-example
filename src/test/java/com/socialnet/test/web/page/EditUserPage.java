package com.socialnet.test.web.page;

import org.jboss.arquillian.graphene.Graphene;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

public class EditUserPage {
    
    @FindBy(id="username")
    private WebElement usernameInput;

    @FindBy(id="password")
    private WebElement passwordInput;
    
    @FindBy(id="email")
    private WebElement emailInput;

    @FindBy(id="editSubmit")
    private WebElement editSubmit;
    
    @FindBy(id="usernameError")
    private WebElement usernameError;
    
    @FindBy(id="emailError")
    private WebElement emailError;
    
    public void editUser(String username,String email){
        
        this.usernameInput.clear();
        this.usernameInput.sendKeys(username);
        this.emailInput.clear();
        this.emailInput.sendKeys(email);
        
        Graphene.guardHttp(editSubmit)
                .click();
    }
    
    public String getUsernameError(){
        return usernameError.getText().trim();
    }

    public String getEmailError() {
        return emailError.getText().trim();
    }
    
}
