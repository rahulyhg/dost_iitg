package com.dost.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dost.hibernate.DbMessage;
import com.dost.hibernate.DbUser;
import com.dost.model.ChatHistory;
import com.dost.model.UserChat;
import com.dost.service.ChatHistoryService;
import com.dost.service.MessageService;
import com.dost.service.UserService;
import com.dost.util.Utils;

@Controller
@RequestMapping("api")
public class PatientHistoryController {

	@Autowired
	MessageService messageService;

	@Autowired
	ChatHistoryService chatHistoryService;
	
	@Autowired
	UserService userService;

	/**
	 * Nobody is using it.
	 * 
	 * @param id
	 * @return
	 */
	// @RequestMapping(value = "/user/{id}/patienthistory/all", method =
	// RequestMethod.GET)
	// @ResponseBody
	// public List<PatientHistoryData> getAllUserMessagesForHistory(
	// @PathVariable Long id) {
	// List<DbMessage> messages = messageService.getAllUserMessages(id);
	// for(DbMessage msg : messages) {
	// msg.setSentDate(Utils.formatDate(msg.getSentDateDb()));
	// }
	// // Formatting as Gudia needs
	// Map<Long, List<DbMessage>> messageMap = new HashMap<Long,
	// List<DbMessage>>();
	// for(DbMessage msg : messages) {
	// // New record
	// if(messageMap.get(msg.getMsgId()) == null) {
	// List<DbMessage> messageList = new ArrayList<DbMessage>();
	// messageList.add(msg);
	// messageMap.put(msg.getMsgId(), messageList);
	// }
	// // Existing record
	// else {
	// List<DbMessage> existingMessageList = messageMap.get(msg.getMsgId());
	// existingMessageList.add(msg);
	// }
	// }
	//
	// List<PatientHistoryData> historyData = new
	// ArrayList<PatientHistoryData>();
	// // Iterating over messages
	// for (Map.Entry<Long, List<DbMessage>> entry : messageMap.entrySet()) {
	// List<DbMessage> messagesByMsgId = entry.getValue();
	// PatientHistoryData singleEntry = new PatientHistoryData();
	// singleEntry.setDate(messagesByMsgId.get(0).getSentDate());
	// singleEntry.setUser(messagesByMsgId.get(0).getSender());
	// singleEntry.setSubject(messagesByMsgId.get(0).getSubject());
	// List<String> data = new ArrayList<String>();
	// for (DbMessage message : messagesByMsgId) {
	// data.add(message.getContent());
	// }
	// singleEntry.setData(data);
	//
	// historyData.add(singleEntry);
	// }
	//
	// // Iterating over chats
	// Map<Long, UserChat> userChatMap = chatHistoryService
	// .getUsersChatHistoryByUserId(id);
	// for (Map.Entry<Long, UserChat> entry : userChatMap.entrySet()) {
	// UserChat userChat = entry.getValue();
	// PatientHistoryData singleEntry = new PatientHistoryData();
	// List<String> data = new ArrayList<String>();
	// for (int i = 0; i < userChat.getUserChats().size(); i++) {
	// DbChatHistory chatHistory = userChat.getUserChats().get(i);
	// if (i == 0) {
	// // Date date = Utils.formatDate("YYYY-MM-DD",
	// (Long.parseLong(chatHistory.getSentDate()) * 1000)+"");
	// //Date date = new Date(chatHistory.getSentDate());
	// singleEntry.setDate(Utils.unixToDate(chatHistory.getSentDate()));
	// singleEntry.setUser(userChat.getUser());
	// singleEntry.setSubject("Chat");
	// }
	// data.add(chatHistory.getBody());
	// }
	// singleEntry.setData(data);
	//
	// historyData.add(singleEntry);
	// }
	//
	// // You are done with merging now, Sort it by date now
	// Collections.sort(historyData, new Comparator<PatientHistoryData>() {
	// public int compare(PatientHistoryData o1, PatientHistoryData o2) {
	// return o1.getDate().compareTo(o2.getDate());
	// }
	// });
	//
	// return historyData;
	// }
	
	@RequestMapping(value="/user/{username}/clients", method=RequestMethod.GET)  
	@ResponseBody
	public List<DbUser> getClientList(@PathVariable String username, HttpServletRequest request) {
		
		Set<Long> userIds = new HashSet<Long>();
		DbUser inputUser = userService.getUserByUsername(username);
		List<Long> recipientIds = messageService.getRecipientIdsBySenderId(inputUser.getUserId());
		List<Long> senderIds = messageService.getSenderIdsByRecipientId(inputUser.getUserId());
		userIds.addAll(recipientIds);
		userIds.addAll(senderIds);
		
		return userService.getUsers(new ArrayList<Long>(userIds));
	}

	@RequestMapping(value = "/user/{id}/patienthistory/all", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getAllUserMessagesForHistory(@PathVariable Long id) {
		List<DbMessage> senderMessages = messageService.getAllUserMessages(id, null, null, null, null);
		List<DbMessage> recipientMessages = messageService.getUserMessages(id, null, null, null, null);
//		Set<DbMessage> messages = new HashSet<DbMessage>();
//		messages.addAll(senderMessages);
//		messages.addAll(recipientMessages);
		List<DbMessage> messages = removeDuplicateMessages(senderMessages, recipientMessages);
		for(DbMessage msg : messages) {
			msg.setSentDate(Utils.formatDate("yyyy-MM-dd hh:mm:s", msg.getSentDateDb()));
			System.out.println(msg.getSentDate());
			System.out.println(Utils.dateToUnix(msg.getSentDate()));
		}
		// Formatting as Gudia needs
		Map<String, List<DbMessage>> messageMap = new HashMap<String, List<DbMessage>>();
		for(DbMessage msg : messages) {
			// New record
			if(messageMap.get(msg.getMsgId()+"") == null) {
				List<DbMessage> messageList = new ArrayList<DbMessage>();
				messageList.add(msg);
				// This is important..will put comment once it works
				messageMap.put(msg.getMsgId() + "", messageList);
			}
			// Existing record
			else {
				List<DbMessage> existingMessageList = messageMap.get(msg.getMsgId() +"");
				existingMessageList.add(msg);
			}
		}
		// Hacking messages
		Map<String, Map<String, List<DbMessage>>> finalMessageMap = new HashMap<String, Map<String, List<DbMessage>>>();
		System.out.println("message Map " + messageMap.size());
		for(Map.Entry<String, List<DbMessage>> message : messageMap.entrySet()) {
			Map<String, List<DbMessage>> localMap = new HashMap<String, List<DbMessage>>();
			System.out.println(message.getValue().size());
			localMap.put("M" + message.getKey(), message.getValue());
			finalMessageMap.put(message.getKey(), localMap);
		}
		
		Map<String, UserChat> chatOutputMap = new HashMap<String, UserChat>();
		Map<Long, UserChat> userChatMap = chatHistoryService.getUsersChatHistoryByUserId(id);
		for(Map.Entry<Long, UserChat> userchat : userChatMap.entrySet()) {
			UserChat localChat = userchat.getValue();
			ChatHistory lastChat = localChat.getUserChats().get(0);
//			chatOutputMap.put(Utils.unixToDate(lastChat.getSentDate()), userchat.getValue());
			chatOutputMap.put(lastChat.getConversationID() + "", userchat.getValue());
		}
		
		// Hacking chats
		Map<String, Map<String, UserChat>> finalChatMap = new HashMap<String, Map<String, UserChat>>();
		for(Map.Entry<String, UserChat> chat : chatOutputMap.entrySet()) {
			Map<String, UserChat> localMap = new HashMap<String, UserChat>();
			localMap.put("C" + chat.getKey(), chat.getValue());
			finalChatMap.put(chat.getKey(), localMap);
		}
		
		// Now finally adding everything in TreeMap to sort
		Map<String, Object> sortedMap = new TreeMap<String, Object>();
		for(Map.Entry<String, Map<String, List<DbMessage>>> message : finalMessageMap.entrySet()) {
			// key should be date so that it orders itself
			System.out.println("tree map " + (message.getValue().get("M" + message.getKey())).get(message.getValue().get("M" + message.getKey()).size() - 1).getSentDate());
			sortedMap.put(Utils.dateToUnix((message.getValue().get("M" + message.getKey())).get(message.getValue().get("M" + message.getKey()).size() - 1).getSentDate()) +"", message.getValue());
		}
		System.out.println("Sorted map size : " + sortedMap.size());
		for(Map.Entry<String, Map<String, UserChat>> chat : finalChatMap.entrySet()) {
			Map<String, UserChat> chatValue = chat.getValue();
			UserChat userChat = chatValue.get("C" + chat.getKey());
			sortedMap.put(userChat.getUserChats().get(0).getSentDate(), chat.getValue());
		}
		
		for(Map.Entry<String, Object> sortedMap1 : sortedMap.entrySet()) {
			System.out.println(sortedMap1.getKey());
		}
		return sortedMap;
	}
	
	/**
	 * All this I have to do to remove duplicate messages from 2 lists.
	 * Somehow hashset is not helping
	 * @param list1
	 * @param list2
	 * @return
	 */
	private List<DbMessage> removeDuplicateMessages(List<DbMessage> list1, List<DbMessage> list2) {
		
		List<DbMessage> output = new ArrayList<DbMessage>();
		Map<Long, DbMessage> map1 = new HashMap<Long, DbMessage>();
		for(DbMessage msg1 : list1) {
			map1.put(msg1.getMessageId(), msg1);
			output.add(msg1);
		}
		
		for(DbMessage msg2 : list2) {
			if(map1.get(msg2.getMessageId()) == null) {
				output.add(msg2);
			}
		}
		
		return output;
	}
}
