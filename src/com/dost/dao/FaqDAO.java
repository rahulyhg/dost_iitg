package com.dost.dao;

import java.util.List;

import com.dost.hibernate.DbFaq;

public interface FaqDAO {

	public DbFaq getFaqById(Long id);
	
	public List<DbFaq> getFaqListByCategory(String category);
	
	public List<DbFaq> getAllFaq();

	public DbFaq addFaq(DbFaq dbFaq);
	
	public boolean deleteFaqById(Long id);
}
