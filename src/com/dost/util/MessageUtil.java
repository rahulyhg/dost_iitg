package com.dost.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.dost.hibernate.DbUser;

public class MessageUtil {

	public static void sendEmail(DbUser sender) {
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getDefaultInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(
								"yourdostiitg@gmail.com", "D0$t123!");
					}
				});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("yourdostiitg@gmail.com"));
			if(sender.getUsername().equals("sohil")) {
				message.setRecipients(Message.RecipientType.CC,
						InternetAddress.parse("yourdostiitg@gmail.com")); //TODO: Use counselors email id				
			}
			else {
				message.setRecipients(Message.RecipientType.CC,
						InternetAddress.parse("yourdostiitg@gmail.com")); //TODO: Use counselors email id
			}

			message.setSubject("Email from " + sender.getUsername());
			message.setText("Dear Counselor,"
					+ "\n There is a query from user " + sender.getUsername() + ". Please login to http://iitg.yourdost.com/ and handle this case..Thanks");

			Transport.send(message);
			System.out.println("Done");
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	
	public static void sendEmailToUsers(DbUser sender, DbUser toUser) {
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getDefaultInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(
								"yourdostiitg@gmail.com", "D0$t123!");
					}
				});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("yourdostiitg@gmail.com"));
			message.setRecipients(Message.RecipientType.CC,
					InternetAddress.parse(toUser.getEmail()));
			message.setSubject("Response from D.O.S.T Team");
			message.setContent("<html>\n" +
                    "<body>\n" +
                    "\n" +
                    "Hi " + toUser.getUsername() + "," + 
                    "<br><br>Thank you for visiting http://iitg.yourdost.com. One of your D.O.S.T has left a message for you. Please log into http://iitg.yourdost.com/ to see the response." +
                    "<br><br>If there is anything bothering you, just reply to mail or " +
                    "<a href=\"http://iitg.yourdost.com/talkToFriend\">\n" +
                    "talk to your friend</a> online\n" +
                    "<br><br>Be stress free! " +
                    "<br><br> --<br>Regards, <br>D.O.S.T Team <br>http://iitg.yourdost.com/" +
                    "</body>\n" +
                    "</html>", "text/html");

			Transport.send(message);
			System.out.println("Done");
		} catch (MessagingException e) {
			//throw new RuntimeException(e);
			System.out.println("Eating exception..DO not want to fail only when their is some problem with sending email..");
		}
	}
	
	public static void sendEmail(String senderEmail, String recipientEmail, String subject, String content) {
		//TODO: Hard-coding this to richa and my email to test
		if(recipientEmail == null || recipientEmail.length() == 0) {
			recipientEmail = "yourdostiitg@gmail.com"; //TODO: replace or add counselors email id
		}
		
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getDefaultInstance(props,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(
								"yourdostiitg@gmail.com", "D0$t123!");
					}
				});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("yourdostiitg@gmail.com"));
			message.setRecipients(Message.RecipientType.CC,
					InternetAddress.parse(recipientEmail));
			message.setSubject(subject);
			message.setContent(content, "text/html");

			Transport.send(message);
			System.out.println("Done");
		} catch (MessagingException e) {
			//throw new RuntimeException(e);
			System.out.println("Eating exception..DO not want to fail only when their is some problem with sending email..");
		}		
	}
}
