package com.dost.quartz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.dost.hibernate.DbDostEmail;
import com.dost.service.EmailService;
import com.dost.util.MessageUtil;

public class IncompleteChatTask {
	
	@Autowired
	EmailService emailService; 
	
	@Scheduled(fixedDelay=30*60000)
	public void inCompleteChatTask() {
		System.out.println("IncompleteChatTask Started" );
		List<DbDostEmail> emails = getEntriesToProcess();
		for(DbDostEmail email : emails) {
			try {
				sendEmail(email);
				email.setStatus("SENT");
				updateEmailUpdate(email);
			}
			catch (Exception e) {
				System.out.println("Error sending email to : " + email.getRecipient());
				email.setErrorMessage(e.getMessage());
			}
		}
		System.out.println("IncompleteChatTask Ended" );
	}
	
	private void sendEmail(DbDostEmail email) {
		String subject = "Incomplete Chat";
		String content = createEmailContent(email);
		MessageUtil.sendEmail(email.getSender(), email.getRecipientEmail(), subject, content);
	}
	
	private String createEmailContent(DbDostEmail email) {
		StringBuffer content = new StringBuffer();
		content.append("Hi " + email.getRecipient() + ",");
		content.append("<br><br>");
		content.append("Hope you are doing good. We noticed that you were trying to reach us but could not get through. ");
		content.append("<br>");
		content.append("We apologize for the inconvenience caused.");
		content.append("<br><br>");
		content.append("I can assure you we will not judge you and you can share anything with us. You are completely anonymous. ");
		content.append("You can chat with us online (through <a href='http://www.yourdost.com/talkToFriend'>talk to friend</a> on top) or reply to this and we will get back to you.");
		content.append("Additionally, you can also start a <a href='http://www.yourdost.com/forums/show/6.page'>public discussion</a> and get the community to share their thoughts.");
		content.append("<br><br>");
		content.append("All the best");
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
		return emailService.getEmailEntriesByTypeAndStatus("MESSAGE_COUNT", "NOT_SENT");
	}
}
