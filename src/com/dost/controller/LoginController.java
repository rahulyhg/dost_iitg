package com.dost.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dost.hibernate.DbUser;
import com.dost.hibernate.DbUserLog;
import com.dost.hibernate.Role;
import com.dost.model.User;
import com.dost.service.UserLogService;
import com.dost.service.UserService;

// Adding more comments
@Controller
public class LoginController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private UserLogService userLogService;

	@RequestMapping("user/conversations")
	public ModelAndView showMessage() {
		return new ModelAndView("user/conversations");
	}

	@RequestMapping(value = "/user/authenticate")
	public ModelAndView authenticateUser(DbUser user) {
		Role role = userService.authenticateUser(user.getUsername(),
				user.getPassword());
		if (role == Role.USER) {
			return new ModelAndView("user/conversations");
		} else if (role == Role.COUNSELOR) {
			return new ModelAndView("counselor/conversations");
		} else {
			return new ModelAndView("unauthorized");
		}
	}

	@RequestMapping(value = "/faq/add", method = RequestMethod.POST)
	@ResponseBody
	public void addUser(DbUser user) {
		userService.saveUser(user.getUsername(), user.getPassword(), user
				.getUserRole().toString());
	}

	// @RequestMapping(value="/welcome", method = RequestMethod.GET)
	// public String printWelcome(ModelMap model) {
	//
	// User user =
	// (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	// String name = user.getUsername();
	//
	// model.addAttribute("username", name);
	// model.addAttribute("message",
	// "Spring Security login + database example");
	// return "hello";
	//
	// }
	//
	// @RequestMapping(value="/login", method = RequestMethod.GET)
	// public String login(ModelMap model) {
	//
	// return "login";
	//
	// }
	//
	// @RequestMapping(value="/loginfailed", method = RequestMethod.GET)
	// public String loginerror(ModelMap model) {
	//
	// model.addAttribute("error", "true");
	// return "login";
	//
	// }
	//
	// @RequestMapping(value="/logout", method = RequestMethod.GET)
	// public String logout(ModelMap model) {
	//
	// return "login";
	//
	// }

	@RequestMapping(value = { "/", "/user/welcome**" }, method = RequestMethod.GET)
	public String defaultPage(HttpServletRequest request) {
	System.out.println(request.getUserPrincipal().getName());
	HttpSession session = request.getSession();
	session.setAttribute("myAppUser", request.getUserPrincipal().getName());
	ModelAndView model = new ModelAndView();
	model.addObject("title",
	"Spring Security Login Form - Database Authentication");
	model.addObject("message", "This is default page!");
	// Creating UserLog Entry, same code is in SignupController
	createUserLogEntry(request.getUserPrincipal().getName(), request);
	if(request.isUserInRole("ROLE_ADMIN")){
			//return "redirect:/forums/show/1.page";
		return "redirect:/conversations";
	}
	else {
//			return "redirect:/forums/show/1.page";
		return "redirect:/conversations";
	}
	
	}
	
	private void createUserLogEntry(String userName, HttpServletRequest request) {
		DbUserLog userLog = new DbUserLog();
		userLog.setUserName(userName);
		userLog.setUserId(0L);
		String ipAddress = request.getHeader("X-FORWARDED-FOR");  
		if (ipAddress == null) {  
		   ipAddress = request.getRemoteAddr();  
		}
		userLog.setIp(ipAddress);
		
		userLogService.saveUserLog(userLog);
	}

	@RequestMapping(value = { "/", "/admin**" }, method = RequestMethod.GET)
	public ModelAndView adminPage() {

		ModelAndView model = new ModelAndView();
		model.addObject("title",
				"Spring Security Login Form - Database Authentication");
		model.addObject("message", "This page is for ROLE_ADMIN only!");
		model.setViewName("counselors/conversations");

		return model;

	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, HttpServletRequest request) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login");

		return model;

	}

	// for 403 access denied page
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {

		ModelAndView model = new ModelAndView();

		// check if user is login
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			System.out.println(userDetail);

			model.addObject("username", userDetail.getUsername());

		}

		model.setViewName("403");
		return model;

	}

}
