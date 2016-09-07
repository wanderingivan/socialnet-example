package com.socialnet.exception;

import org.hibernate.exception.ConstraintViolationException;

public class DuplicateUsernameException extends RuntimeException {

	public DuplicateUsernameException(ConstraintViolationException ce) {
		super(ce);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -600172034697453054L;

}
