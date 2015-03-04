package com.dost.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dost.hibernate.DbCode;

@Repository("codeDAO")
public class CodeDAOImpl implements CodeDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	public List<DbCode> getAllCodes() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbCode ");
		List<DbCode> codesList = query.list();
		if(codesList == null) {
			codesList = new ArrayList<DbCode>();
		}
		return codesList;
	}

	public DbCode getCodeById(Long id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbCode c where c.codeId = :id");
		query.setParameter("id", id);
		DbCode code = (DbCode)query.uniqueResult();
		return code;
	}

	public List<DbCode> getCodesByTag(String tagType) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbCode where type = :tagType");
		query.setParameter("tagType", tagType);
		List<DbCode> codesList = query.list();
		if(codesList == null) {
			codesList = new ArrayList<DbCode>();
		}
		return codesList;
	}

	
}
