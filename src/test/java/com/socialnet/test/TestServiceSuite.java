package com.socialnet.test;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

import com.socialnet.test.service.*;

import junit.framework.TestCase;

@RunWith(Suite.class)
@Suite.SuiteClasses(value = { UserServiceSecurityTests.class})
public class TestServiceSuite extends TestCase {

}
