package com.dost.service;

import java.util.List;

import com.dost.hibernate.DbCode;

public interface CodeService {

	public List<DbCode> getAllCodes();
	public DbCode getCodeById(Long id);
	public List<DbCode> getCodesByTag(String name);
}
