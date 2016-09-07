package com.socialnet.test;

import junit.framework.TestCase;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

import com.socialnet.test.dao.*;

@RunWith(Suite.class)
@SuiteClasses({UserDaoTests.class,MessageDaoTests.class})
public class TestDaoSuite extends TestCase{

}
