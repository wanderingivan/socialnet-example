package com.socialnet.test;

import junit.framework.TestCase;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;
import com.socialnet.test.validation.*;

@RunWith(value=Suite.class)
@SuiteClasses({CreateUserActionValidationTests.class,
			   EditUserActionValidationTests.class})
public class TestValidationsSuite extends TestCase{

}
