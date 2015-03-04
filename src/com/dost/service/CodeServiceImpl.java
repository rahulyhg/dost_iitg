package com.dost.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dost.dao.CodeDAO;
import com.dost.hibernate.DbCode;

@Service("codeService")
@Transactional(propagation = Propagation.SUPPORTS)
public class CodeServiceImpl implements CodeService {

	@Autowired
	CodeDAO codeDAO;
	
	public List<DbCode> getAllCodes() {
		return codeDAO.getAllCodes();
	}

	public DbCode getCodeById(Long id) {
		return codeDAO.getCodeById(id);
	}

	public List<DbCode> getCodesByTag(String name) {
		return codeDAO.getCodesByTag(name);
	}

}
