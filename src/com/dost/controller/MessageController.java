package com.dost.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dost.hibernate.DbCounselor;
import com.dost.hibernate.DbMessage;
import com.dost.hibernate.DbMessageRecipient;
import com.dost.hibernate.DbUser;
import com.dost.model.Faq;
import com.dost.model.Message;
import com.dost.service.ChatHistoryService;
import com.dost.service.CounselorService;
import com.dost.service.MessageService;
import com.dost.service.UserService;
import com.dost.util.MessageUtil;
import com.dost.util.Utils;

@Controller
@RequestMapping("api")
public class MessageController {

	@Autowired
	MessageService messageService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	ChatHistoryService chatHistoryService;
	
	@Autowired
	CounselorService counselorService;
	
	@RequestMapping(value="/user/{id}/unreadcount", method=RequestMethod.GET)  
	@ResponseBody
	public Map<Long, Integer> getUnreadMessageCount(@PathVariable Long id) {
		int unreadCount = messageService.getUnreadMessageCount(id);
		Map<Long, Integer> countMap = new HashMap<Long, Integer>();
		countMap.put(id, unreadCount);
		return countMap;
	}
	
	@RequestMapping(value="/message/{messageId}/user/{userId}/markasread", method=RequestMethod.GET)  
	@ResponseBody
	public void markAsRead(@PathVariable Long messageId, @PathVariable Long userId) {
		messageService.setViewed(messageId, userId);
	}
	
	/*messages received*/
	@RequestMapping(value="/user/{id}/messages/all", method=RequestMethod.GET)  
	@ResponseBody
	public Map<Long, List<DbMessage>> getAllUserMessagesForHistory(HttpServletRequest request, @PathVariable Long id) {
		String pageNo = request.getParameter("page");
		String per_page = request.getParameter("per_page");
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		
		List<DbMessage> messages = messageService.getAllUserMessages(id, pageNo, per_page, sort, order);
		for(DbMessage msg : messages) {
			msg.setSentDate(Utils.formatDate(msg.getSentDateDb()));
		}
		// Formatting as Gudia needs
		Map<Long, List<DbMessage>> messageMap = new HashMap<Long, List<DbMessage>>();
		for(DbMessage msg : messages) {
			// New record
			if(messageMap.get(msg.getMsgId()) == null) {
				List<DbMessage> messageList = new ArrayList<DbMessage>();
				messageList.add(msg);
				messageMap.put(msg.getMsgId(), messageList);
			}
			// Existing record
			else {
				List<DbMessage> existingMessageList = messageMap.get(msg.getMsgId());
				existingMessageList.add(msg);
			}
		}
		
//		// Creating output
//		Map<Map<String, Long>, List<DbMessage>> outputMap = new HashMap<Map<String, Long>, List<DbMessage>>();
//		for (Map.Entry<Long, List<DbMessage>> entry : messageMap.entrySet()) {
//			Long key = entry.getKey();
//			List<DbMessage> value = entry.getValue();
//			Map<String, Long> keyMap = new HashMap<String, Long>();
//			keyMap.put("msgId", key);
//			outputMap.put(keyMap, value);
//		}
		return messageMap;
	}
	
	/*messages received*/
	@RequestMapping(value="/message/{id}/", method=RequestMethod.GET)  
	@ResponseBody
	public List<DbMessage> getAllMessagesById(@PathVariable Long id) {
		List<DbMessage> messages = messageService.getMessagesById(id);
		for(DbMessage msg : messages) {
			msg.setSentDate(Utils.formatDate(msg.getSentDateDb()));
		}
		return messages;
	}
	
	/*messages received*/
	@RequestMapping(value="/user/{id}/messages", method=RequestMethod.GET)  
	@ResponseBody
	public List<DbMessage> getAllUserMessages(HttpServletRequest request, @PathVariable Long id) {
		String pageNo =  request.getParameter("page");
		String per_page = request.getParameter("per_page");
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		
		List<DbMessage> messages = messageService.getUserMessages(id, pageNo, per_page, sort, order);
		for(DbMessage msg : messages) {
			msg.setSentDate(Utils.formatDate(msg.getSentDateDb()));
		}
		
		// Creating map of msgId and messages which I can later use to get the latest message
		Map<Long, List<DbMessage>> messageMap = new HashMap<Long, List<DbMessage>>();
		for(DbMessage msg : messages) {
			// New record
			if(messageMap.get(msg.getMsgId()) == null) {
				List<DbMessage> messageList = new ArrayList<DbMessage>();
				messageList.add(msg);
				messageMap.put(msg.getMsgId(), messageList);
			}
			// Existing record
			else {
				List<DbMessage> existingMessageList = messageMap.get(msg.getMsgId());
				existingMessageList.add(msg);
			}
		}
		
		// Select one message you want to show in UI
		List<DbMessage> messagesToReturn = new ArrayList<DbMessage>();
		for(Map.Entry<Long, List<DbMessage>> entry : messageMap.entrySet()) {
			List<DbMessage> messagesByMsgId = messageMap.get(entry.getKey());
			// Select one from the list
			if(messagesByMsgId.size() > 1) {
				// Sort the messages in list and pick the last one or first one based on Richa
				Collections.sort(messagesByMsgId, new Comparator<DbMessage>() {
					public int compare(DbMessage o1, DbMessage o2) {
						return o1.getMessageId().compareTo(o2.getMessageId());
					}
				});	
				// Add the most recent message in return list
				messagesToReturn.add(messagesByMsgId.get(messagesByMsgId.size() - 1));
			}
			else {
				messagesToReturn.add(messagesByMsgId.get(0));
			}
		}
		
		
		// Sort messages based on dates
		Collections.sort(messagesToReturn, new Comparator<DbMessage>() {
			public int compare(DbMessage o1, DbMessage o2) {
				// Sort in descending order date
				return o2.getSentDate().compareTo(o1.getSentDate());
			}
		});	
		return messagesToReturn;
	}
	
	@RequestMapping(value="/user/{id}/draftmessages", method=RequestMethod.GET)  
	@ResponseBody
	public List<DbMessage> getDraftUserMessages(@PathVariable Long id) {
		return messageService.getDraftUserMessages(id);
	}
	
	@RequestMapping(value="/user/{id}/sentmessages", method=RequestMethod.GET)  
	@ResponseBody
	public List<DbMessage> getSentUserMessages(HttpServletRequest request, @PathVariable Long id) {
		
		String pageNo =  request.getParameter("page");
		String per_page = request.getParameter("per_page");
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		
		List<DbMessage> messages =  messageService.getSentUserMessages(id, pageNo, per_page, sort, order);
		for(DbMessage msg : messages) {
			msg.setSentDate(Utils.formatDate(msg.getSentDateDb()));
		}
		return messages;
	}
	
	@RequestMapping(value="/message/{id}/details", method=RequestMethod.GET)  
	@ResponseBody
	public DbMessage getMessageDetails(@PathVariable Long id) {
		return messageService.getMessageDetails(id);
	}
	
	@RequestMapping(value="/message/{id}/user/{userid}/setview", method=RequestMethod.GET)  
	public void setViewed(@PathVariable Long id, @PathVariable Long userId) {
		messageService.setViewed(id, userId);
	}
	
	@RequestMapping(value="/msgid/{id}/count", method=RequestMethod.GET)  
	@ResponseBody
	public Map<String, Long> getMsgCount(@PathVariable Long id) {
		Long count = messageService.getMsgCount(id);
		Map<String, Long> countMap = new HashMap<String,Long>();
		countMap.put("count", count);
		return countMap;
	}
	
	@RequestMapping(value="/user/message", method=RequestMethod.POST)  
	@ResponseBody
	public void sendMessage(Message message) {
		DbMessage messageToSend = populateDbMessage(message);
		messageService.sendMessage(messageToSend);
		
		DbUser sender = messageToSend.getSender();
		// Send email to customersupport if message is sent from user
		if(sender.getDbUserRole().getRole().equals("ROLE_USER")) {
			System.out.println("Sending email to counselors..");
			MessageUtil.sendEmail(sender);
		}
		
		// Send email to user that they have got response
		List<DbMessageRecipient> recipientList = messageToSend.getRecipients();
		for(DbMessageRecipient recipient : recipientList) {
			DbUser user = recipient.getRecipient();
			// Send email only if recipient is ROLE_USER
			if(user.getDbUserRole().getRole().equals("ROLE_USER")) {
				// If user has provided his email while sign up then send email to their gmail/yahoo account
				if(user.getEmail() != null && user.getEmail().length() > 0) {
					MessageUtil.sendEmailToUsers(sender, user);
				}				
			}
		}
	}
	@RequestMapping(value="/messages/add", method=RequestMethod.POST)  
	@ResponseBody
	public Faq addFaq(Faq faq) {
//		DbFaqCategory dbFaqCategory = categoryService.findCategoryByName(faq.getCategory());
//		DbFaq dbFaq = new DbFaq();
//		dbFaq.setQuestion(faq.getQuestion());
//		dbFaq.setAnswer(faq.getAnswer());
//		dbFaq.setCategory(dbFaqCategory);
//		faq.setCategoryId(""+dbFaqCategory.getFaqCategoryId());
//		faqService.addFaq(dbFaq);
//		return faq;
		return null;
	}
	
	/**
	 * Same copy is in SignupController
	 * @param message
	 * @return
	 */
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
//			Long maxMsgId = chatHistoryService.getMaxMsgId();
			dbMessage.setMsgId(maxMsgId + 1);
		}
		dbMessage.setRecipients(createRecipientList(message, dbMessage));
		if(message.getSenderId() == null) {
			message.setSenderId(102l);
		}
		DbUser sender = userService.getUser(message.getSenderId());

		dbMessage.setSender(sender);
		dbMessage.setSentDateDb(new Date());
		return dbMessage;
	}
	
	/**
	 * Same copy is in SignupController
	 * @param message
	 * @param dbMessage
	 * @return
	 */
	private List<DbMessageRecipient> createRecipientList(Message message, DbMessage dbMessage) {
		List<DbMessageRecipient> lists = new ArrayList<DbMessageRecipient>();
		String recipientIds = message.getRecipients();
		String[] recipientArray = null;
		if(!recipientIds.equals("all")){
			recipientArray = recipientIds.split(",");	
		}
		// If UI didnt send the recipient id then get list of available counselors
		else {
			// Earlier we used to send messages to all counselors, now after 02/28 for IITG we send messages messages to only counselor having TAG sent by user
//			List<DbUser> counselors = userService.getAllCounselors();
			String selectedCounselorTag = message.getCounselorTag();
			//TODO: Hardcoding it for now. It should come from UI
			Long selectedCounselorTagId = 1l;
			List<DbCounselor> counselors = counselorService.getCounselorsByCodeIds(Arrays.asList(selectedCounselorTagId));
			recipientArray = new String[counselors.size()];
			for(int i = 0; i < counselors.size(); i++) {
				recipientArray[i] = ""+counselors.get(i).getCounselorId();
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
}
