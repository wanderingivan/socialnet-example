package com.socialnet.test.configuration;

import java.net.MalformedURLException;

import org.dbunit.IDatabaseTester;
import org.dbunit.dataset.DataSetException;
import org.dbunit.dataset.IDataSet;
import org.dbunit.operation.DatabaseOperation;
import org.junit.After;
import org.junit.Before;
import org.springframework.beans.factory.annotation.Autowired;

import junit.framework.TestCase;


public abstract class AbstractDBUnitTest extends TestCase {
	
	protected boolean init;
	
	private  IDatabaseTester databaseTester;

	protected static final String defaultTestResourceFolder = "src/test/resources/";
	
	protected void initialSetUp() throws Exception{
		databaseTester.setDataSet(getDataSet());
		//config.setProperty(DatabaseConfig.PROPERTY_DATATYPE_FACTORY, new MySqlDataTypeFactory());
		databaseTester.setSetUpOperation(DatabaseOperation.CLEAN_INSERT);
		databaseTester.setTearDownOperation(DatabaseOperation.DELETE_ALL);
		init = true;
	}

	@Before
	public void setUp() throws Exception{//FIXME ugly hack to avoid static methods
		if(!init){						// Spring throws a hissy fit if you try to				
			initialSetUp();             // use static methods with its runner 
										// and @BeforeClass seems to work only with static methods
		}                               // so this will have to work for the moment
		databaseTester.onSetup();
	}

	@After
	public void tearDown() throws Exception{
		//databaseTester.onTearDown();
	}
	
	protected abstract IDataSet getDataSet() throws MalformedURLException, DataSetException;

	@Autowired
	public void setDatabaseTester(IDatabaseTester tester){
		this.databaseTester = tester;
		
	}
}
