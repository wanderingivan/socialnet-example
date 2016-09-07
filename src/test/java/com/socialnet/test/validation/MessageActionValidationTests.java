package com.socialnet.test.validation;

import org.junit.Test;

//import com.socialnet.action.message.MessageAction;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.ActionSupport;

//XXX This is Empty !!!
public class MessageActionValidationTests extends AbstractActionValidationTestCase {
	
	protected void setUpRequestTestParams(String [] params){

		request.setParameter("message",params[0]);
		
		
	}

	@Test
	public void empty(){
		assertTrue(true);
	}
	/*@Test
	public void testValidationWithNoErrors() throws Exception{
		ActionProxy actionProxy = setUpTestParams(new String[]{"message"});
		MessageAction action =  (MessageAction) actionProxy.getAction();	
		assertEquals("The validation didn't pass when it should have",
								ActionSupport.SUCCESS,actionProxy.execute());
		assertTrue("There were errors in the validation when passing correct parameters",
								action.getFieldErrors().size() < 1);
	}
	
	@Test
	public void testValidationWithThreeErrors() throws Exception{ // Empty field errors

		
		ActionProxy actionProxy = setUpTestParams(new String[]{""});
		
		MessageAction action =  (MessageAction) actionProxy.getAction();	
		assertEquals("The validation passed when it shouldn't have",
								ActionSupport.INPUT,actionProxy.execute());
		assertTrue(String.format("There were less  than expected "
				+ "errors in the validation when passing incorrect parameters"
				+ "expected 3 but were [%d]",action.getFieldErrors().size()),
								action.getFieldErrors().size() >= 0);
		
	}*/


	


}
