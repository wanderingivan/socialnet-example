package com.socialnet.test.dao;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.AnnotationConfigContextLoader;

import com.socialnet.test.configuration.AbstractDBUnitTest;
import com.socialnet.test.configuration.DBUnitTestConfig;
import com.socialnet.test.configuration.DaoTestConfig;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={DBUnitTestConfig.class, DaoTestConfig.class}, 
				      loader=AnnotationConfigContextLoader.class)
public abstract class AbstractDaoTest extends AbstractDBUnitTest{

}
