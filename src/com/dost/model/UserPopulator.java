package com.dost.model;

import com.dost.hibernate.DbUser;

public class UserPopulator {

	public static void populateUser(User user, DbUser dbUser) {
		user.setUserId(dbUser.getUserId());
		user.setAvatarId(dbUser.getAvatar());
		user.setFname(dbUser.getFname());
		user.setLname(dbUser.getLname());
		user.setUsername(dbUser.getUsername());
		user.setYear(dbUser.getYear());
		user.setHostel(dbUser.getHostel());
		user.setBranch(dbUser.getBranch());
		user.setEmail(dbUser.getEmail());
		user.setBlocked(dbUser.getBlocked());
		user.setIdentifier(dbUser.getIdentifier());
	}
	
	public static void populateDbUser(User user, DbUser dbUser) {
		dbUser.setAvatar(user.getAvatarId());
		dbUser.setFname(user.getFname());
		dbUser.setLname(user.getLname());
		dbUser.setUsername(user.getUsername());
		dbUser.setYear(user.getYear());
		dbUser.setHostel(user.getHostel());
		dbUser.setBranch(user.getBranch());
		dbUser.setEmail(user.getEmail());
		dbUser.setBlocked(user.getBlocked());
		dbUser.setIdentifier(user.getIdentifier());
	}
}
