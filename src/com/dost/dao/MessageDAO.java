package com.dost.dao;

import java.util.List;

import com.dost.hibernate.DbMessage;

public interface MessageDAO {

	List<DbMessage> getAllUserMessagesById(Long id, String pageNo, String per_page, String sort, String order);
	
	List<DbMessage> getMessagesById(Long id);
	
	List<DbMessage> getUserMessages(Long userId, String pageNo, String per_page, String sort, String order);

	List<DbMessage> getDraftUserMessages(Long userId);

	List<DbMessage> getSentUserMessages(Long userId, String pageNo, String per_page, String sort, String order);

	DbMessage getMessageDetails(Long id);

	void setViewed(Long id, Long userId);
	
	public void sendMessage(DbMessage dbMessage);
	
	public Long getMaxMsgId();
	
	public Long getMsgCount(Long id);

	public int getUnreadMessageCount(Long id);
	
	public List<Long> getRecipientIdsBySenderId(Long senderId);
	
	public List<Long> getSenderIdsByRecipientId(Long recipientId);
}
