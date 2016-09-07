package com.socialnet.dao.impl;


import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;

import com.socialnet.model.User;

/**
 * Abstract class that provides convenience methods for 
 * session, query and criteria handling.
 */

public abstract class AbstractHibernateDao<T> {
	
	
	private final Class<T> type;
	
	private SessionFactory sessionFactory;

	public AbstractHibernateDao(SessionFactory sessionFactory,Class<T> type) {
		super();
		this.sessionFactory = sessionFactory;
		this.type = type;
	}
	
	protected Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	protected Query createQuery(String query){
		return getSession().createQuery(query);
	}
	
	protected Query getNamedQuery(String name){
		return getSession().getNamedQuery(name);
	}
	
	protected Criteria createCriteria(){
		return getSession().createCriteria(type);
	}
	
	@SuppressWarnings("rawtypes")
	protected Criteria createCriteria(Class clazz){
		return getSession().createCriteria(clazz);
	}
	@SuppressWarnings("rawtypes")
	protected Criteria createCriteria(Class clazz,String alias){
		return getSession().createCriteria(clazz,alias);
	}
	
	@SuppressWarnings("unchecked")
	protected T load(Integer id){
		return (T) getSession().load(type, id);
	}
	
	@SuppressWarnings("unchecked")
	protected T getWithCriteria(Object [] restrictions){
		Criteria crit = createCriteria();
		for(int i =0;i< restrictions.length;i += 2){
			crit.add(Restrictions.eq( (String) restrictions[i],restrictions[i+1]));
		}
		crit.setMaxResults(1);
		crit.setCacheable(true);
		return (T) crit.uniqueResult();
		
	}
	
	protected User retrieveUserByUsername(String username) {
		try{
			Criteria crit = getSession().createCriteria(User.class)
			                            .add(Restrictions.eq("username",username))
			                            .setMaxResults(1)          
			                            .setCacheable(true);
			return (User) crit.uniqueResult();
		}catch(HibernateException e){
			throw new RuntimeException(e);
		}
	}
	
}
