package com.dost.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dost.hibernate.DbCode;
import com.dost.hibernate.DbCounselor;

@Repository("counselorDAO")
public class CounselorDAOImpl implements CounselorDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public List<DbCounselor> getAllCounselors() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbCounselor ");
		List<DbCounselor> counselorsList = query.list();
		if(counselorsList == null) {
			counselorsList = new ArrayList<DbCounselor>();
		}
		return counselorsList;
	}
	
	public List<DbCounselor> getCounselorsByTagName(String tagName) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbCounselor dc join dc.tags dt where dt.tagId in (:ids)");
		List<DbCounselor> counselorsList = query.list();
		if(counselorsList == null) {
			counselorsList = new ArrayList<DbCounselor>();
		}
		return counselorsList;		
	}

	public List<DbCounselor> getCounselorsByType(String type) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<DbCounselor> getCounselorsByReviews() {
		// TODO Auto-generated method stub
		return null;
	}

	public List<DbCounselor> getCounselorsByProfileName(String profileName) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<DbCounselor> getCounselorsByLocation(String location) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<DbCounselor> getCounselorsByGender(String gender) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<DbCounselor> getCounselorsByTiming(String timing) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<DbCounselor> getCounselorsByCodeIds(List<Long> codeIds) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("select dc from DbCounselor dc join dc.tags dt join dt.code tc where tc.id in (:ids)");
		query.setParameterList("ids", codeIds);
		List<DbCounselor> counselorsList = query.list();
		if(counselorsList == null) {
			counselorsList = new ArrayList<DbCounselor>();
		}
		return counselorsList;
	}
	
	
	
}
