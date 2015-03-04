package com.dost.dao;

import java.util.List;

import com.dost.hibernate.DbCounselor;

public interface CounselorDAO {

	public List<DbCounselor> getAllCounselors();
	public List<DbCounselor> getCounselorsByTagName(String tagName);
	public List<DbCounselor> getCounselorsByType(String type);
	public List<DbCounselor> getCounselorsByReviews();
	public List<DbCounselor> getCounselorsByProfileName(String profileName);
	public List<DbCounselor> getCounselorsByLocation(String location);
	public List<DbCounselor> getCounselorsByGender(String gender);
	public List<DbCounselor> getCounselorsByTiming(String timing);
	public List<DbCounselor> getCounselorsByCodeIds(List<Long> codeIds);
}
