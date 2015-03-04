package com.dost.dao;

import java.util.List;

import com.dost.hibernate.DbCode;

public interface CodeDAO {
	public List<DbCode> getAllCodes();
	public DbCode getCodeById(Long id);
	public List<DbCode> getCodesByTag(String name);
}
