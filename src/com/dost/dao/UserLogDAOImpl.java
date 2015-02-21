package com.dost.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dost.hibernate.DbUserLog;

@Repository("userLogDAO")
public class UserLogDAOImpl implements UserLogDAO {

	@Autowired
	SessionFactory sessionFactory;

	public void saveUserLog(DbUserLog userLog) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(userLog);
	}
}
