package com.dost.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dost.dao.FaqDAO;
import com.dost.hibernate.DbFaq;

@Service("faqService")
@Transactional(propagation = Propagation.SUPPORTS)
public class FaqServiceImpl implements FaqService {

	@Autowired
	FaqDAO faqDAO;
	
	public DbFaq getFaqById(Long id) {
		return faqDAO.getFaqById(id);
	}

	public List<DbFaq> getFaqListByCategory(String category) {
		return faqDAO.getFaqListByCategory(category);
	}

	public List<DbFaq> getAllFaq() {
		return faqDAO.getAllFaq();
	}

	public DbFaq addFaq(DbFaq dbFaq) {
		return faqDAO.addFaq(dbFaq);
	}

	public boolean deleteFaqById(Long id) {
		return faqDAO.deleteFaqById(id);
	}
	
}
