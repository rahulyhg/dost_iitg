package com.dost.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dost.dao.UserLogDAO;
import com.dost.hibernate.DbUserLog;

@Service("userLogService")
@Transactional(propagation = Propagation.SUPPORTS)
public class UserLogServiceImpl implements UserLogService {

	@Autowired
	UserLogDAO userLogDAO;

	public void saveUserLog(DbUserLog userLog) {
		userLogDAO.saveUserLog(userLog);
	}

}
