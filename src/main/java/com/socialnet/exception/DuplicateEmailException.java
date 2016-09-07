package com.socialnet.exception;

import org.hibernate.exception.ConstraintViolationException;

public class DuplicateEmailException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5051593248412638810L;

	public DuplicateEmailException(ConstraintViolationException ce) {
		super(ce);
	}

}
