package com.dost.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dost.dao.CounselorDAO;
import com.dost.hibernate.DbCounselor;

@Service("counselorService")
@Transactional(propagation = Propagation.SUPPORTS)
public class CounselorServiceImpl implements CounselorService {

	@Autowired
	CounselorDAO counselorDAO;

	public List<DbCounselor> getAllCounselors() {
		return counselorDAO.getAllCounselors();
	}
	public List<DbCounselor> getCounselorsByTagName(String tagName) {
		return counselorDAO.getCounselorsByType(tagName);
	}
	public List<DbCounselor> getCounselorsByType(String type) {
		return counselorDAO.getCounselorsByType(type);
	}

	public List<DbCounselor> getCounselorsByReviews() {
		return counselorDAO.getCounselorsByReviews();
	}

	public List<DbCounselor> getCounselorsByProfileName(String profileName) {
		return counselorDAO.getCounselorsByProfileName(profileName);
	}

	public List<DbCounselor> getCounselorsByLocation(String location) {
		return counselorDAO.getCounselorsByLocation(location);
	}

	public List<DbCounselor> getCounselorsByGender(String gender) {
		return counselorDAO.getCounselorsByGender(gender);
	}

	public List<DbCounselor> getCounselorsByTiming(String timing) {
		return counselorDAO.getCounselorsByTiming(timing);
	}

	public List<DbCounselor> getCounselorsByCodeIds(List<Long> codeIds) {
		return counselorDAO.getCounselorsByCodeIds(codeIds);
	}	
	
	
}
