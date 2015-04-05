package com.dost.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dost.dao.UserDAO;
import com.dost.hibernate.DbUser;
import com.dost.hibernate.Role;

@Service("userService")
@Transactional(propagation = Propagation.SUPPORTS)
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;

	public void saveUser(String username, String password, String role) {
		userDAO.saveUser(username, password, role);
	}

	public Role authenticateUser(String username, String password) {
		return userDAO.authenticateUser(username, password);
	}

	public DbUser getUser(Long userId) {
		return userDAO.getUser(userId);
	}
	
	public List<DbUser> getUsers(List<Long> userIds) {
		return userDAO.getUsers(userIds);
	}

	public List<DbUser> getAllUsers(String role, String pageNo, String per_page, String sort, String order, String username) {
		return userDAO.getAllUsers(role, pageNo, per_page, sort, order, username);
	}

	public List<DbUser> getAllCounselors() {
		return userDAO.getAllCounselors();
	}

	public DbUser getUserByUsername(String username) {
		return userDAO.getUserByUsername(username);
	}

	public DbUser checkUserBySecurityQuestion(String username, String question1, String question2,
			String answer1, String answer2) {
		return userDAO.checkUserBySecurityQuestion(username, question1, question2, answer1, answer2);
	}

	public DbUser updatePassword(String username, String password) {
		return userDAO.updatePassword(username, password);
	}

	public DbUser updateUser(DbUser dbUser) {
		return userDAO.updateUser(dbUser);
	}

	public int getUsersCount() {
		return userDAO.getUsersCount();
	}
	
	public List<DbUser> searchUserByUserName(String username) {
		return userDAO.searchUserByUserName(username);
	}

	@Override
	public DbUser getUserByIdentifier(String identifier) {
		return userDAO.getUserByIdentifier(identifier);
	}

	@Override
	public DbUser getUserByEmail(String email) {
		return userDAO.getUserByEmail(email);
	}

	
}
