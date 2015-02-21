package com.dost.service;

import java.util.List;

import com.dost.hibernate.DbFaq;

public interface FaqService {

	public DbFaq getFaqById(Long id);
	
	public List<DbFaq> getFaqListByCategory(String category);
	
	public List<DbFaq> getAllFaq();

	public DbFaq addFaq(DbFaq dbFaq);
	
	public boolean deleteFaqById(Long id);
}
