package com.dost.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dost.hibernate.DbMessage;
import com.dost.hibernate.DbMessageRecipient;
import com.dost.hibernate.DbUser;
import com.dost.hibernate.DbUserLog;
import com.dost.hibernate.DbUserRole;
import com.dost.hibernate.DbUserSecurity;
import com.dost.model.Message;
import com.dost.model.User;
import com.dost.service.MessageService;
import com.dost.service.SecurityQuestionService;
import com.dost.service.SignupService;
import com.dost.service.UserLogService;
import com.dost.service.UserService;

@Controller
@RequestMapping("api")
public class SignupController {

	@Autowired
	SignupService signupService;
	
	@Autowired
	UserService userService;
	
	// This is for creating welcome message for new user
	@Autowired
	MessageService messageService;
	
	@Autowired @Qualifier("authMgr") 
	private AuthenticationManager authMgr;
	
	@Autowired
	SecurityQuestionService questionService; 
	
	@Autowired
	UserLogService userLogService;
	
	@RequestMapping(value="/su/{id}", method=RequestMethod.GET)  
	@ResponseBody
	public void signup1(@PathVariable Long id) {
		System.out.println("test id : " + id);

	}
	
	// Method to handle initial signup
	@RequestMapping(value="/signup", method=RequestMethod.POST)  
	public String signup(HttpServletRequest request) {
		
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setPassword(request.getParameter("password"));
		user.setAvatarId(request.getParameter("avatarinput"));
		user.setEmail(request.getParameter("email"));
		Map<String, Boolean> output = new HashMap<String, Boolean>();
		if(user.getUsername() == null) {
			output.put("status", false);
			return "redirect:/signupNow"; 
		}
		DbUser existingUser = userService.getUserByUsername(user.getUsername());
		// User does not exists
		if(existingUser == null) {
			DbUser newUser = populateDbUser(user, request);	
			signupService.signupUser(newUser);
			output.put("status", true);
			Message welcomeMessage = createWelcomeMessage(newUser.getUserId()+"");
			messageService.sendMessage(populateDbMessage(welcomeMessage));
			//return new ModelAndView("index");
			
			UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword());
			token.setDetails(new WebAuthenticationDetails(request));
			//authMgr.authenticate(auth);
			Authentication authentication = authMgr.authenticate(token);
		      // redirect into secured main page if authentication successful
		  if(authentication.isAuthenticated()) {
			  // Adding this because new signup user after going to discussion page was getting header as logged out user.
			HttpSession session = request.getSession();
			session.setAttribute("myAppUser", user.getUsername());
			
			// Creating UserLog Entry, same code is in LoginController
			createUserLogEntry(user, request);
			  
			SecurityContextHolder.getContext().setAuthentication(authentication);
		    return "redirect:/conversations";
		  }
		}
		// User already exists with same username
		else {
			output.put("status", false);
			return "redirect:/signupNow"; 
		}
		return "redirect:/conversations";
	}

	private void createUserLogEntry(User user, HttpServletRequest request) {
		DbUserLog userLog = new DbUserLog();
		userLog.setUserName(user.getUsername());
		userLog.setUserId(0L);
		String ipAddress = request.getHeader("X-FORWARDED-FOR");  
		if (ipAddress == null) {  
		   ipAddress = request.getRemoteAddr();  
		}
		userLog.setIp(ipAddress);
		
		userLogService.saveUserLog(userLog);
	}

	private DbUser populateDbUser(User user, HttpServletRequest request) {
		DbUser dbUser = new DbUser();
		dbUser.setUsername(user.getUsername());
		dbUser.setPassword(user.getPassword());
		dbUser.setDeleted("0");
		dbUser.setEnabled(1);
		dbUser.setBlocked("0");
		dbUser.setAvatar(user.getAvatarId());
		// Setting user role
		DbUserRole userRole = new DbUserRole();
		userRole.setUsername(user.getUsername());
		userRole.setRole("ROLE_USER");
		userRole.setDbUser(dbUser);
		
		dbUser.setDbUserRole(userRole);
		
		List<DbUserSecurity> securityQuestions = new ArrayList<DbUserSecurity>();
		// Setting user questions
		// TODO: Commenting temporarily
//		DbUserSecurity question1 = new DbUserSecurity();
//		question1.setUser(dbUser);
//		question1.setAnswer(request.getParameter("answer1"));
//		question1.setQuestionId(Long.parseLong(request.getParameter("question1")));
//		
//		DbUserSecurity question2 = new DbUserSecurity();
//		question2.setUser(dbUser);
//		question2.setAnswer(request.getParameter("answer2"));
//		question2.setQuestionId(Long.parseLong(request.getParameter("question2")));

		DbUserSecurity question1 = new DbUserSecurity();
		question1.setUser(dbUser);
		question1.setAnswer("dost");
		question1.setQuestionId(1l);
		
		DbUserSecurity question2 = new DbUserSecurity();
		question2.setUser(dbUser);
		question2.setAnswer("bhopal");
		question2.setQuestionId(3l);
		
		securityQuestions.add(question1);
		securityQuestions.add(question2);
		dbUser.setUserSecurities(securityQuestions);
		
		//adding email
		dbUser.setEmail(user.getEmail());
		return dbUser;
	}
	
	

	
	/**
	 * All this and below is for welcome message
	 * @param recipient
	 * @return
	 */
	private Message createWelcomeMessage(String recipient) {
		StringBuilder welcomeBuffer = new StringBuilder();
		
		welcomeBuffer.append("<div id='welcome-message'><span>Hi,</span> <br/><span>Welcome to D.O.S.T");
		welcomeBuffer.append("</span> <br/><span>Every problem has a solution and together we will find a solution to the problems that are bothering you. <br/> ");
		welcomeBuffer.append("<br/>I am your friend - not a computer program and I am here to help you come out of your problems. I will be here to support you ");
		welcomeBuffer.append("and help you in any way I can.");
		welcomeBuffer.append("</span><h3>Steps to get started</h3><ol>	");
		welcomeBuffer.append("<li>You could also leave a offline message and someone from team DOST will reply in not more than 24 hours.<br/>");
		welcomeBuffer.append("<a href='conversations?=chat'> leave a message for your dost</a>");
		welcomeBuffer.append("<li> If you want to chat with a DOST about your problems <br/>");
		welcomeBuffer.append("<a href='talkToFriend'> CHAT ONLINE WITH THE NEXT AVAILABLE DOST</a>	</li>");
		welcomeBuffer.append("<li>Discuss with our DOST users about your by people around");
		welcomeBuffer.append("<a href='faqs'>frequently asked questions</a></li><br/></ol>	</div>");
		
		Message welcomeMessage = new Message();
		welcomeMessage.setContent(welcomeBuffer.toString());
		welcomeMessage.setImportant(0l);
		welcomeMessage.setRecipients(recipient);
		// Trigger populates sent date
		// welcomeMessage.setSentDate(new Date());
		//welcomeMessage.setSenderId(Long.parseLong(Utils.getDostConfig("dostadmin.userid")));
		welcomeMessage.setSubject("Welcome to You D.O.S.T");
		return welcomeMessage;
	}
	
	private DbMessage populateDbMessage(Message message) {
		
		DbMessage dbMessage = new DbMessage();
		dbMessage.setContent(message.getContent());
		dbMessage.setSubject(message.getSubject());
		dbMessage.setImportant(message.getImportant() != null ? 0l : 1l);
		// Hibernate will set this
		//dbMessage.setMessageId(messageId)
		if(message.getMsgId() != null) {
			dbMessage.setMsgId(message.getMsgId());
		}
		// If msgId is null then create new..Using bad way of doing it for now
		else {
			Long maxMsgId = messageService.getMaxMsgId();
			dbMessage.setMsgId(maxMsgId + 1);
		}
		dbMessage.setRecipients(createRecipientList(message, dbMessage));
		if(message.getSenderId() == null) {
			message.setSenderId(104l);
		}
		dbMessage.setSender(userService.getUser(message.getSenderId()));
		dbMessage.setSentDateDb(new Date());
		return dbMessage;
	}
	
	private List<DbMessageRecipient> createRecipientList(Message message, DbMessage dbMessage) {
		List<DbMessageRecipient> lists = new ArrayList<DbMessageRecipient>();
		String recipientIds = message.getRecipients();
		String[] recipientArray = null;
		if(!recipientIds.equals("all")){
			recipientArray = recipientIds.split(",");	
		}
		// If UI didnt send the recipient id then get list of available couselors
		else {
			List<DbUser> counselors = userService.getAllCounselors();
			recipientArray = new String[counselors.size()];
			for(int i = 0; i < counselors.size(); i++) {
				recipientArray[i] = ""+counselors.get(i).getUserId();
			}
		}
		for(String userId : recipientArray) {
			DbMessageRecipient dbMessageRecipient = new DbMessageRecipient();
			// Hibernate will put this
			//dbMessageRecipient.setMessageRecipientId(messageRecipientId);
			dbMessageRecipient.setDeleted("0");
			dbMessageRecipient.setMessage(dbMessage);
			DbUser recipient = userService.getUser(Long.parseLong(userId));
			dbMessageRecipient.setRecipient(recipient);
			dbMessageRecipient.setViewed(0l);
			lists.add(dbMessageRecipient);
		}
		return lists;
	}
	
	// Method to handle initial signup
	@RequestMapping(value="/forgotPasswordSignup", method=RequestMethod.POST)  
	public ModelAndView forgotPasswordSignup(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String question1 = request.getParameter("question1");
		String question2 = request.getParameter("question2");
		String answer1 = request.getParameter("answer1");
		String answer2 = request.getParameter("answer2");
		String username = request.getParameter("username");
		DbUser user = userService.checkUserBySecurityQuestion(username, question1, question2, answer1, answer2);
		if(user != null) {
//			UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword());
//			token.setDetails(new WebAuthenticationDetails(request));
//			Authentication authentication = authMgr.authenticate(token);
//		      // redirect into secured main page if authentication successful
//			if(authentication.isAuthenticated()) {
//			  SecurityContextHolder.getContext().setAuthentication(authentication);
//			  return "redirect:/resetPassword";
//			}	
			// We dont want user to login at this point. We will ask user to first reset password.
			// And this should happen only when security question answer matches.
			mav = new ModelAndView("resetPassword");
			mav.addObject("username", username);
			return mav;
		}
		return new ModelAndView("forgotPassword");
	}
	
	// Method to handle initial signup
	@RequestMapping(value="/resetPassword", method=RequestMethod.POST)  
	public String resetPassword(HttpServletRequest request) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		DbUser user = userService.updatePassword(username, password);
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword());
		token.setDetails(new WebAuthenticationDetails(request));
		Authentication authentication = authMgr.authenticate(token);
	      // redirect into secured main page if authentication successful
		if(authentication.isAuthenticated()) {
		  SecurityContextHolder.getContext().setAuthentication(authentication);
		  return "redirect:/conversations";
		}
		// It should never come here
		return "redirect:/resetPassword"; 
	}
}
