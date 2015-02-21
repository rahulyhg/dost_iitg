package com.dost.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dost.hibernate.DbFaq;

@Repository("faqDAO")
public class FaqDAOImpl implements FaqDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public DbFaq getFaqById(Long id) {
		Session session = sessionFactory.getCurrentSession();
		DbFaq dbFaq = (DbFaq)session.get(DbFaq.class, id);
		if(dbFaq == null) {
			return new DbFaq();
		}
		return dbFaq;
	}

	public List<DbFaq> getFaqListByCategory(String category) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbFaq f where f.category.faqCategoryName = :category");
		query.setParameter("category", category);
		List<DbFaq> faqs = query.list();
		if(faqs == null) {
			faqs = new ArrayList<DbFaq>();
		}
		return faqs;
	}

	public List<DbFaq> getAllFaq() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbFaq f");
		List<DbFaq> faqs = query.list();
		if(faqs == null) {
			faqs = new ArrayList<DbFaq>();
		}
		return faqs;
	}

	public DbFaq addFaq(DbFaq dbFaq) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(dbFaq);
		return dbFaq;
	}
	
	public boolean deleteFaqById(Long id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("delete from DbFaq where faqId = :id");
		query.setParameter("id", id);
		
		query.executeUpdate();
		return true;
	}	
}
