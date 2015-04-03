package com.dost.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.dost.util.Utils;

@Controller
public class HomeController {

	@RequestMapping("chat")  
	public ModelAndView chat() {
		return new ModelAndView("chat"); 
	}
	
	@RequestMapping("online")  
	public ModelAndView online() {
		return new ModelAndView("online"); 
	}
	
//	@RequestMapping("chat1")  
//	public ModelAndView chat1() {
//		return new ModelAndView("chat1"); 
//	}
//	
//	@RequestMapping("chat2")  
//	public ModelAndView chat2() {
//		return new ModelAndView("chat2"); 
//	}
	
	@RequestMapping("index")  
	public ModelAndView index() {
		return new ModelAndView("index"); 
	}
	
	@RequestMapping("testimonials")  
	public ModelAndView testimonials() {
		return new ModelAndView("testimonials"); 
	}
	
	@RequestMapping("team")  
	public ModelAndView team() {
		return new ModelAndView("team"); 
	}
	
	@RequestMapping("contact")  
	public ModelAndView contact() {
		return new ModelAndView("contact"); 
	}
	
	@RequestMapping(value="/forgotPassword", method=RequestMethod.GET)  
	public ModelAndView forgotPassword(HttpServletRequest request) {
		String username = request.getParameter("username");
		ModelAndView mav = new ModelAndView("forgotPassword");
		mav.addObject("username", username);
		return new ModelAndView("forgotPassword"); 
	}
	
	@RequestMapping("horoscope")  
	public ModelAndView horoscope() {
		return new ModelAndView("horoscope"); 
	}
	
	
	@RequestMapping("quotes")  
	public ModelAndView quotes() {
		return new ModelAndView("quotes"); 
	}
	
	@RequestMapping("conversations")  
	public ModelAndView conversations() {
		return new ModelAndView("conversations"); 
	}
	
	@RequestMapping("faqs")  
	public ModelAndView faqs_main() {
		return new ModelAndView("faqs"); 
	}
	
	
	@RequestMapping("user/includes/signUp")  
	public ModelAndView signUp() {
		return new ModelAndView("user/includes/signUp"); 
	}
	
	@RequestMapping("talkToFriend")  
	public ModelAndView talkToFriend() {
		return new ModelAndView("talkToFriend"); 
	}
	
	@RequestMapping("user/login")  
	public ModelAndView login() {
		return new ModelAndView("user/login"); 
	}
	
	@RequestMapping("signupNow")  
	public ModelAndView signupNow(HttpServletRequest request) {
		if(Utils.showSignUpPage(request)) {
			return new ModelAndView("signupNow"); 
		}
		else {
			return new ModelAndView("login"); 
		}
	}
	
	@RequestMapping("user/discussionsAll")  
	public ModelAndView discussionsAll() {
		return new ModelAndView("user/discussionsAll"); 
	}
	@RequestMapping("user/discussionsDetails")  
	public ModelAndView discussionsDetails() {
		return new ModelAndView("user/discussionsDetails"); 
	}
	
	@RequestMapping("user/faqs")  
	public ModelAndView faqs() {
		return new ModelAndView("user/faqs"); 
	}
	
	@RequestMapping("user/popups")  
	public ModelAndView popups() {
		return new ModelAndView("user/popups"); 
	}
	
	@RequestMapping("counselor/login")  
	public ModelAndView counselor_login() {
		return new ModelAndView("counselor/login"); 
	}
	@RequestMapping("counselor/faqs")  
	public ModelAndView counselor_faqs() {
		return new ModelAndView("counselor/faqs"); 
	}
	@RequestMapping("counselor/conversations")  
	public ModelAndView counselor_conversations() {
		return new ModelAndView("counselor/conversations"); 
	}
	@RequestMapping("conversationsExpanded")  
	public ModelAndView counselor_conversationsExpanded() {
		return new ModelAndView("conversationsExpanded"); 
	}
	
	@RequestMapping("chatExpanded")  
	public ModelAndView chatExpanded() {
		return new ModelAndView("chatExpanded"); 
	}
	
	@RequestMapping("patientList")  
	public ModelAndView counselor_patientList() {
		return new ModelAndView("patientList"); 
	}
	@RequestMapping("patientDetails")  
	public ModelAndView patientDetails() {
		return new ModelAndView("patientDetails"); 
	}
	
	@RequestMapping("clientList")  
	public ModelAndView counselor_clientList() {
		return new ModelAndView("clientList"); 
	}
	@RequestMapping("clientDetails")  
	public ModelAndView clientDetails() {
		return new ModelAndView("clientDetails"); 
	}
	
	@RequestMapping("onlineCounseling")  
	public ModelAndView counselor_onlineCounseling() {
		return new ModelAndView("onlineCounseling"); 
	}
	@RequestMapping("counselor/popups")  
	public ModelAndView counselor_popups() {
		return new ModelAndView("counselor/popups"); 
	}
	
	@RequestMapping("blog")  
	public String blog() {
		return "blog";
	}
	
	@RequestMapping("termsOfService")  
	public String termsOfService() {
		return "termsOfService";
	}
}
