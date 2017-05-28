package com.socialnet.test.web;

import java.net.URL;

import org.jboss.arquillian.drone.api.annotation.Drone;
import org.jboss.arquillian.test.api.ArquillianResource;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;

public class AbstractWebPageTest {

    @Drone
    protected WebDriver driver;
    
    @ArquillianResource
    protected URL deploymentUrl;
    
    
    
    protected void loadPage(String url){
        driver.manage().window().setSize(new Dimension(1920,1080));
        driver.get(deploymentUrl.toString()
                                .trim()
                                .concat(url));
    }
}
