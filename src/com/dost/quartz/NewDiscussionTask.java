package com.dost.quartz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.dost.hibernate.DbDostEmail;
import com.dost.hibernate.DbUser;
import com.dost.service.EmailService;
import com.dost.service.TopicService;
import com.dost.service.UserService;
import com.dost.util.MessageUtil;

public class NewDiscussionTask {
	@Autowired
	EmailService emailService; 
	
	@Autowired
	UserService userService;
	
	@Autowired
	TopicService topicService;
	
	@Scheduled(fixedDelay=30*60000)
	public void newDiscussionTask() {
		System.out.println("NewDiscussionTask Started" );
		/**
		 * We make only one entry in dost_table when there is new topic. But we also want to create entry for each user to whom we wanna send message. 
		 * This will be helpful to analyze and check data later on.
		 * Also, I do not want to create entries for all users in during inserting new topic. This might slow down system so here we will follow these steps;
		 * 1. Explode/delete one entry that was created while new topic creation and create multiple entries for each user and then follow normal way of sending messages
		 */
		DbDostEmail genericEmail = getGenericEntryToExplode();
		// Do this only if genericEmail is not null
		if(genericEmail != null) {
			// Explode this generic email and create entry for all users
			List<DbUser> users = userService.getAllUsers("ROLE_USER", null, null, null, null, null);
			// Create entry for each user now
			for(DbUser user : users) {
				if(user.getEmail() != null) {
					DbDostEmail userEmail = new DbDostEmail();
					userEmail.setConversationId(genericEmail.getConversationId());
					userEmail.setEmailType(genericEmail.getEmailType());
					userEmail.setSender("");
					userEmail.setRecipient(user.getUsername());
					userEmail.setRecipientEmail(user.getEmail());
					userEmail.setStatus("NOT_SENT");	
					
					// Create entry
					emailService.createEmailEntry(userEmail);
				}
			}
			// Delete generic entry now
			emailService.deleteEmailEntry(genericEmail);			
		}
		
		List<DbDostEmail> emails = getEntriesToProcess();
		for(DbDostEmail email : emails) {
			try {
				sendEmail(email);
				email.setStatus("SENT");
			}
			catch (Exception e) {
				System.out.println("Error sending email to : " + email.getRecipient());
				email.setStatus("NOT_SENT");
				email.setErrorMessage(e.getMessage());
			}
			updateEmailUpdate(email);
		}
		System.out.println("NewDiscussionTask Ended" );
	}
	
	private void sendEmail(DbDostEmail email) {
		String subject = "New Discussion";
		String content = createEmailContent(email);
		MessageUtil.sendEmail(email.getSender(), email.getRecipientEmail(), subject, content);
	}
	
	private String createEmailContent(DbDostEmail email) {
		String topicName = topicService.getTopicName(email.getConversationId().intValue());
		StringBuffer content = new StringBuffer();
		content.append("Hi " + email.getRecipient() + ",");
		content.append("<br><br>");
        content.append("We wanted to let you know that a new Discussion <a href='http://yourdost.com/posts/list/" + email.getConversationId() + ".page'>" + topicName + "</a> has been started on Your D.O.S.T.");
		content.append("<br><br>");
		content.append("Regards,");
		content.append("<br>");
		content.append("Richa");
		return content.toString();
	}
	
	private void updateEmailUpdate(DbDostEmail email) {
		email.setStatus("SENT");
		emailService.updateEmailEntry(email);
	}
	
	private List<DbDostEmail> getEntriesToProcess() {
		return emailService.getEmailEntriesByTypeAndStatus("NEW_TOPIC_IN_DISCUSSION", "NOT_SENT");
	}
	
	private DbDostEmail getGenericEntryToExplode() {
		return emailService.getGenericEmailEntriesByTypeAndStatus("NEW_TOPIC_IN_DISCUSSION", "NOT_SENT");
	}
}
