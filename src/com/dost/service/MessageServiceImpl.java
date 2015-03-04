package com.dost.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dost.dao.MessageDAO;
import com.dost.hibernate.DbMessage;

@Service("messageService")
@Transactional(propagation = Propagation.SUPPORTS)
public class MessageServiceImpl implements MessageService {

	@Autowired
	MessageDAO messageDAO;

	
	
	public List<DbMessage> getAllUserMessages(Long id, String pageNo, String per_page, String sort, String order) {
		return messageDAO.getAllUserMessagesById(id, pageNo, per_page, sort, order);
	}

	public List<DbMessage> getMessagesById(Long id) {
		return messageDAO.getMessagesById(id);
	}
	
	public List<DbMessage> getUserMessages(Long userId, String pageNo, String per_page, String sort, String order) {
		return messageDAO.getUserMessages(userId, pageNo, per_page, sort, order);
	}

	public List<DbMessage> getDraftUserMessages(Long userId) {
		return messageDAO.getDraftUserMessages(userId);
	}

	public List<DbMessage> getSentUserMessages(Long userId, String pageNo, String per_page, String sort, String order) {
		return messageDAO.getSentUserMessages(userId, pageNo, per_page, sort, order);
	}

	public DbMessage getMessageDetails(Long id) {
		return messageDAO.getMessageDetails(id);
	}

	public void setViewed(Long id, Long userId) {
		messageDAO.setViewed(id, userId);
	}
	
	public void sendMessage(DbMessage dbMessage) {
		messageDAO.sendMessage(dbMessage);
	}
	
	public Long getMaxMsgId() {
		return messageDAO.getMaxMsgId();
	}

	public Long getMsgCount(Long id) {
		return messageDAO.getMsgCount(id);
	}
	
	public int getUnreadMessageCount(Long id) {
		return messageDAO.getUnreadMessageCount(id);
	}

	public List<Long> getRecipientIdsBySenderId(Long senderId) {
		return messageDAO.getRecipientIdsBySenderId(senderId);
	}

	public List<Long> getSenderIdsByRecipientId(Long recipientId) {
		return messageDAO.getSenderIdsByRecipientId(recipientId);
	}
}
