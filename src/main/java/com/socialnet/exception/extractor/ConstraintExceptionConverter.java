package com.socialnet.exception.extractor;


import org.hibernate.exception.ConstraintViolationException;

import com.socialnet.exception.DuplicateEmailException;
import com.socialnet.exception.DuplicateHeadlineException;
import com.socialnet.exception.DuplicateUsernameException;

public class ConstraintExceptionConverter {
	
	
	public static RuntimeException convertException(ConstraintViolationException ce){
		
		String message = ce.getCause()
		                   .getMessage()
		                   .split(";")[0]
		                   .toLowerCase();
		              
		if(message.contains("email")){
			return new DuplicateEmailException(ce);
		}else if(message.contains("username")){
			return new DuplicateUsernameException(ce);
		}else if (message.contains("headline")){
			return new DuplicateHeadlineException(ce);
		}else{
			return ce;
		}
		
	}

}
