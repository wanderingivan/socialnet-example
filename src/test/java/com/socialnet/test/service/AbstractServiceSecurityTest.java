package com.socialnet.test.service;


import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.AnnotationConfigContextLoader;

import com.socialnet.test.configuration.AbstractDBUnitTest;
import com.socialnet.test.configuration.DBUnitTestConfig;
import com.socialnet.test.configuration.ServiceSecurityTestConfig;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={DBUnitTestConfig.class, ServiceSecurityTestConfig.class}, loader=AnnotationConfigContextLoader.class)
public abstract class AbstractServiceSecurityTest extends AbstractDBUnitTest {


}
