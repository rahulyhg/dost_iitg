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
import com.dost.model.Message;
import com.dost.model.User;
import com.dost.model.UserPopulator;
import com.dost.model.UserProfile;
import com.dost.service.UserService;
import com.dost.util.MessageUtil;
import com.dost.util.Utils;

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
		Map<String, String> response = new HashMap<String, String>();
		// username is not provided
		if(username == null) {
			response.put("status", "failure");	
		}
		else {
			DbUser user = userService.getUserByUsername(username);
			String identifier = Utils.generateUniqueToken();
			// Check if email provided by UI and email in DB is same
			if(user.getEmail() == null) {
				response.put("status", "failure");
			}
			else {
				if(user.getEmail().equals(userProfile.getEmail())) {
					// Update unique token in user table with proper identifier
					user.setIdentifier(identifier);
					userService.updateUser(user);
					String messageToSend = createPasswordResetMessage(username, identifier);
					MessageUtil.sendEmail("customersupport@yourdost.com", user.getEmail(), "Password Reset Request", messageToSend);
					
					response.put("status", "success");				
				}
				else {
					response.put("status", "failure");
				}
			}			
		}
		return response;
	}
	
	@RequestMapping(value="/user/resetpassword", method=RequestMethod.POST)  
	@ResponseBody
	public Map<String, String> resetUserPassword(UserProfile userProfile) {
		Map<String, String> response = new HashMap<String, String>();
		response.put("status", "failure");
		if(userProfile.getIdentifier() != null) {
			DbUser dbUser = userService.getUserByIdentifier(userProfile.getIdentifier());
			// Check if user identifier in database is same as identifier passed by UI in userprofile
			if(dbUser != null) {
				// Now change password
				dbUser.setPassword(userProfile.getPassword());
				dbUser.setIdentifier(null);
				userService.updateUser(dbUser);
				response.put("status", "success");
			}
		}		
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
	
	
	/**
	 * 
	 * @param recipientUsername
	 * @param identifier, to identify which user is it
	 * @return
	 */
	private String createPasswordResetMessage(String recipientUsername, String identifier) {
		StringBuilder resetPasswordMessageBuffer = new StringBuilder();
		resetPasswordMessageBuffer.append("Hi " + recipientUsername + ",");
		resetPasswordMessageBuffer.append("<br><br>");
		resetPasswordMessageBuffer.append("We have received a request from you to reset your password. If you asked to reset your password, please follow the instructions below. ");
		resetPasswordMessageBuffer.append("If you do not wish to reset your password, simply disregard this message.");
		resetPasswordMessageBuffer.append("<br><br>");
		resetPasswordMessageBuffer.append("To reset your password click on the following link:");
		resetPasswordMessageBuffer.append("<br><br>");
		resetPasswordMessageBuffer.append("<u><a href='http://localhost:8800/dost/resetPassword?identifier=" + identifier + "'>Reset Password</a></u>");
		resetPasswordMessageBuffer.append("<br><br>");
		resetPasswordMessageBuffer.append("Regards,");
		resetPasswordMessageBuffer.append("<br><br>");
		resetPasswordMessageBuffer.append("Admin at Your D.O.S.T");
		
		return resetPasswordMessageBuffer.toString();
	}

	
}
