package com.dost.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dost.hibernate.DbSecurityQuestion;
import com.dost.hibernate.DbUser;
import com.dost.hibernate.DbUserSecurity;
import com.dost.hibernate.Role;

@Repository("userDao")
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	public Role authenticateUser(String username, String password) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbUser u where u.username = :username and u.password = :password");
		query.setParameter("username", username);
		query.setParameter("password", password);
		
		Role outputRole = Role.UNAUTHORIZED;
		DbUser retUser = (DbUser)query.uniqueResult();
		if(retUser != null) {
			outputRole = Role.valueOf(retUser.getUserRole().toString());
		}
		return outputRole;
	}

	public void saveUser(String username, String password, String userRole) {
		DbUser user = new DbUser();
		user.setUsername(username);
		user.setPassword(password);
		user.setUserRole(Role.valueOf(userRole));
		user.setCreateBy("system");
		user.setCreateDate(new Date());
		user.setUpdateBy("system");
		user.setUpdateDate(new Date());
		
		sessionFactory.getCurrentSession().saveOrUpdate(user);
	}

	public DbUser getUser(Long userId) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbUser u where u.userId = :id");
		query.setParameter("id", userId);
		
		DbUser user = (DbUser)query.uniqueResult();
		if(user == null){
			user = new DbUser();
		}
		return user;
	}
	

	public List<DbUser> getUsers(List<Long> ids) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbUser u where u.userId in (:ids)");
		query.setParameterList("ids", ids);
		
		List<DbUser> users = query.list();
		if(users == null){
			users = new ArrayList<DbUser>();
		}
		return users;
	}

	public List<DbUser> getAllUsers(String role, String pageNo, String per_page, String sort, String order, String username) {
		Session session = sessionFactory.getCurrentSession();
		StringBuilder hqlQuery = new StringBuilder("from DbUser u where u.dbUserRole.role = :role");
		if(username != null) {
			hqlQuery.append(" and u.username like :username");
		}
		if(order != null) {
			hqlQuery.append(" order by u.userId " + order);
		}
		
		Query query = session.createQuery(hqlQuery.toString());
		query.setParameter("role", role);
		if(username != null) {
			query.setParameter("username", "%"+ username +"%");
		}
		if(per_page != null) {
			query.setFirstResult((Integer.parseInt(pageNo) - 1) * Integer.parseInt(per_page));
			query.setMaxResults(Integer.parseInt(per_page));			
		}
		List<DbUser> users = query.list();
		if(users == null) {
			users = new ArrayList<DbUser>();
		}
		return users;
	}
	
	public List<DbUser> getAllCounselors() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbUser u where u.dbUserRole.role = 'ROLE_ADMIN'");
		List<DbUser> users = query.list();
		if(users == null) {
			users = new ArrayList<DbUser>();
		}
		return users;
	}

	public DbUser getUserByUsername(String username) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbUser u where u.username = :username");
		query.setParameter("username", username);
		DbUser user = (DbUser)query.uniqueResult();
		return user;
	}
	
	

	public List<DbUser> getUsersByUsernames(List<String> usernames) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbUser u where u.username in (:usernames)");
		query.setParameterList("usernames", usernames);
		List<DbUser> users = query.list();
		if(users == null) {
			users = new ArrayList<DbUser>();
		}
		return users;
	}

	public DbUser checkUserBySecurityQuestion(String username, String question1, String question2,
			String answer1, String answer2) {
		DbUser dbUser = getUserByUsername(username);
		Session session = sessionFactory.getCurrentSession();
		Query query1 = session.createQuery("from DbUserSecurity us where us.questionId = :question1 " +
										"and us.answer = :answer1 and us.user.userId = :userId");
		query1.setParameter("question1", Long.parseLong(question1));
		query1.setParameter("answer1", answer1);
		query1.setParameter("userId", dbUser.getUserId());
		DbUserSecurity userQuestion1 = (DbUserSecurity)query1.uniqueResult();
		
		Query query2 = session.createQuery("from DbUserSecurity us where us.questionId = :question2 " +
		"and us.answer = :answer2 and us.user.userId = :userId");
		query2.setParameter("question2", Long.parseLong(question2));
		query2.setParameter("answer2", answer2);
		query2.setParameter("userId", dbUser.getUserId());
		
		DbUserSecurity userQuestion2 = (DbUserSecurity)query2.uniqueResult();
		
		if(userQuestion1 != null && userQuestion2 != null) {
			return dbUser;
		}
		return null;
	}
	
	public DbUser updatePassword(String username, String password) {
		Session session = sessionFactory.getCurrentSession();
		DbUser user = getUserByUsername(username);
		
		user.setPassword(password);
		session.saveOrUpdate(user);
		
		return user;
	}

	public DbUser updateUser(DbUser dbUser) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(dbUser);
		return dbUser;
	}

	public int getUsersCount() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("select count(*) from DbUser");
		Long count = (Long)query.list().get(0);
		return count.intValue();
	}

	public List<DbUser> searchUserByUserName(String username) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from DbUser u where u.username like :username");
		query.setParameter("username", "%"+username+"%");
		List<DbUser> users = query.list();
		if(users == null) {
			users = new ArrayList<DbUser>();
		}
		return users;
	}	
}
