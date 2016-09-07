package com.socialnet.test.validation;

import org.apache.struts2.StrutsTestCase;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.web.context.WebApplicationContext;

import com.opensymphony.xwork2.ActionProxy;

/**
 * Abstract class that handles interceptor configuration 
 * and proxy creation before tests are ran 
 */
@SuppressWarnings("rawtypes")
public abstract class AbstractActionValidationTestCase extends StrutsTestCase {
	
	private final Class DEFAULT_CONFIG_CLASS = com.socialnet.test.configuration.ValidationsTestConfig.class;
	
	private Class configClass;

	private GenericApplicationContext applicationContext;
	
	protected void setupBeforeInitDispatcher() throws Exception{
		if(applicationContext == null){
			if(configClass == null){
				applicationContext = new AnnotationConfigApplicationContext(DEFAULT_CONFIG_CLASS);
			}else{
				applicationContext = new AnnotationConfigApplicationContext(configClass);
			}
		}
        servletContext.setAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE, applicationContext);
	}
    
	
    /**
     * Return an ActionProxy of the supplied action configured not to execute the result and with preset parameters 
     * @param action the action to proxy
     * @param params parameters to set on the action
     * @return ActionProxy
     */
    protected final ActionProxy getProxy(String action,String [] params){
    	setUpRequestTestParams(params);
		ActionProxy actionProxy = getActionProxy(action);
		assertNotNull("Action proxy shouldn't be null", actionProxy);
		actionProxy.setExecuteResult(false);
		return actionProxy;	    	
    }
    
    /**
     * @param param the parameters the action will be initialized with
     */
    protected abstract void setUpRequestTestParams(String [] param);

    /**
     * Convinience method to switch test configs
     * @param configClass different class to initialize appContext with
     */
	public void setConfigClass(Class configClass) {
		this.configClass = configClass;
	}
    
}

