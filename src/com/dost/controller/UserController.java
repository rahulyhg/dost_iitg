package com.dost.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dost.hibernate.DbUser;
import com.dost.model.User;
import com.dost.model.UserPopulator;
import com.dost.model.UserProfile;
import com.dost.service.UserService;

@Controller
@RequestMapping("api")
public class UserController {

//	@Value("${test}")
//	private String test;
	
	@Autowired
	UserService userService;
	
	 @Resource(name="sessionRegistry")
	 private SessionRegistryImpl sessionRegistry;
	
	/*messages received*/
	@RequestMapping(value="/users", method=RequestMethod.GET)  
	@ResponseBody
	public List<DbUser> getAllUsers(HttpServletRequest request) {
		String role = request.getParameter("role");
		if(role == null || role.length() == 0) {
			role = "ROLE_USER";
		}
		String pageNo =  request.getParameter("page");
		String per_page = request.getParameter("per_page");
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		String username = request.getParameter("searchtext");
		
		return userService.getAllUsers(role, pageNo, per_page, sort, order, username);
	}
	
	@RequestMapping(value="/user/{username}", method=RequestMethod.GET)  
	@ResponseBody
	public DbUser getUserByUsername(@PathVariable String username) {
		return userService.getUserByUsername(username);
	}
	
	@RequestMapping(value="/user/{username}/exists", method=RequestMethod.GET)  
	@ResponseBody
	public Map<String, Boolean> checkIfUsernameExists(@PathVariable String username) {
		DbUser user = userService.getUserByUsername(username);
		boolean exists = false;
		if(user != null) {
			exists = true;
		}
		Map<String, Boolean> responseMap = new HashMap<String, Boolean>();
		responseMap.put("status", exists);
		
		return responseMap;
	}

	
	@RequestMapping(value="/user/{username}/search", method=RequestMethod.GET)  
	@ResponseBody
	public List<DbUser> getSearchUserByUsername(@PathVariable String username) {
		List<DbUser> searchedUsers = userService.searchUserByUserName(username);
		return searchedUsers;
	}

	@RequestMapping(value="/user/{username}/emailpassword", method=RequestMethod.POST)  
	@ResponseBody
	public Map<String, String> sendPasswordResetLinkToUser(@PathVariable String username, UserProfile userProfile) {
		
		//TODO: perform business logic 
		Map<String, String> response = new HashMap<String, String>();
		response.put("status", "success");
		return response;
	}
	
	@RequestMapping(value="/user/{username}/resetpassword", method=RequestMethod.POST)  
	@ResponseBody
	public Map<String, String> resetUserPassword(@PathVariable String username, UserProfile userProfile) {

		//TODO: perform business logic 
		Map<String, String> response = new HashMap<String, String>();
		response.put("status", "success");
		return response;
	}
	
	@RequestMapping(value="/userdetail/add", method=RequestMethod.POST)  
	@ResponseBody
	public User addUserDetail(User user) {
		DbUser dbUser = userService.getUser(user.getUserId());
		dbUser.setFname(user.getFname());
		dbUser.setLname(user.getLname());
		dbUser.setHostel(user.getHostel());
		dbUser.setYear(user.getYear());
		dbUser.setBranch(user.getBranch());
		
		dbUser = userService.updateUser(dbUser);
		User userToReturn = new User();
		UserPopulator.populateUser(userToReturn, dbUser);
		return userToReturn;
	}
	
	@RequestMapping(value="users/count", method=RequestMethod.GET)  
	@ResponseBody
	public Map<String, Integer> getUserDetail() {
		int usersCount = userService.getUsersCount();
		Map<String, Integer> countMap = new HashMap<String, Integer>();
		countMap.put("count", usersCount);
		return countMap;
	}
	
	@RequestMapping(value="/user/{username}/block", method=RequestMethod.GET)  
	@ResponseBody
	public Map<String, String> blockUser(@PathVariable String username) {
		Map<String, String> statusMap = new HashMap<String, String>();
		statusMap.put("status", "false");
		for (Object principal : sessionRegistry.getAllPrincipals()) {
			UserDetails userDetail = (UserDetails)principal;
			if(username.equals(userDetail.getUsername())) {
		        // Expiring user to block session
				for (SessionInformation session : sessionRegistry.getAllSessions(principal, false)) {
		            session.expireNow();
		        }
//				// Reset password to null in DB
//				DbUser user = userService.getUserByUsername(username);
//				user.setPassword("");
//				user.setBlocked("1");
//				userService.updateUser(user);
//		        statusMap.put("status", "true");
			}
		}
		// Reset password to null in DB
		// Do this even when user is not loggedin
		DbUser user = userService.getUserByUsername(username);
		user.setPassword("");
		user.setBlocked("1");
		userService.updateUser(user);
        statusMap.put("status", "true");
		return statusMap;
	}	
	
}
