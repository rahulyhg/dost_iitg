package com.dost.service;

import java.util.List;

import com.dost.hibernate.DbMessage;

public interface MessageService {

	public List<DbMessage> getAllUserMessages(Long id, String pageNo, String per_page, String sort, String order);
	
	public List<DbMessage> getMessagesById(Long id);
	
	public List<DbMessage> getUserMessages(Long id, String pageNo, String per_page, String sort, String order);

	public List<DbMessage> getDraftUserMessages(Long id);

	public List<DbMessage> getSentUserMessages(Long id, String pageNo, String per_page, String sort, String order);

	public DbMessage getMessageDetails(Long id);

	public void setViewed(Long id, Long userId);
	
	public void sendMessage(DbMessage dbMessage);
	
	public Long getMaxMsgId();

	public Long getMsgCount(Long id);

	public int getUnreadMessageCount(Long id);
	
	public List<Long> getRecipientIdsBySenderId(Long senderId);
	
	public List<Long> getSenderIdsByRecipientId(Long recipientId);
}
