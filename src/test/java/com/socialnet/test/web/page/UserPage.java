package com.socialnet.test.web.page;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

public class UserPage {
    
    @FindBy(id="userTitle")
    private WebElement username;
    
    @FindBy(id="description")
    private WebElement description;
    
    public String getUsername() {
        return username.getText().trim();
    }

    public String getDescription() {
        return description.getText().trim();
    }

}
