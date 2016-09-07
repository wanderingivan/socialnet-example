package com.socialnet.exception;

import org.hibernate.exception.ConstraintViolationException;

public class DuplicateHeadlineException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4406789449470321323L;

	public DuplicateHeadlineException(ConstraintViolationException ce) {
		super(ce);
	}
}
