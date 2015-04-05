package com.dost.hibernate;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;

@Entity
@Table(name="message")
public class DbMessage extends DbGeneric implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name = "messageId")
	private Long messageId;
	
    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="senderid", nullable=false)
	private DbUser sender;
    
    @Temporal(TemporalType.TIMESTAMP)
    @JsonIgnore
    @Column(name="sentdate")
	private Date sentDateDb;
    
    @Column(name="subject")
	private String subject;
    @Column(name="content")
	private String content;
    @Column(name="status")
	private MessageStatus messageStatus;
    @Column(name="important")
	private Long important;
    @OneToMany (fetch=FetchType.EAGER, mappedBy="message")
    //@JsonIgnore
    @Cascade({CascadeType.ALL, CascadeType.DELETE_ORPHAN})
    private List<DbMessageRecipient> recipients;
    @Column(name="msgId")
    private Long msgId;
    @Transient
	private String sentDate;
    @Column(name="category")
    private Long categoryId;
    
    @PrePersist
    public void sentDateDb() {
    	sentDateDb = new Date();
    }
    
	public Long getMessageId() {
		return messageId;
	}
	public void setMessageId(Long messageId) {
		this.messageId = messageId;
	}
	public DbUser getSender() {
		return sender;
	}
	public void setSender(DbUser sender) {
		this.sender = sender;
	}

	public Date getSentDateDb() {
		return sentDateDb;
	}
	public void setSentDateDb(Date sentDateDb) {
		this.sentDateDb = sentDateDb;
	}

	public String getSentDate() {
		return sentDate;
	}
	public void setSentDate(String sentDate) {
		this.sentDate = sentDate;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public MessageStatus getMessageStatus() {
		return messageStatus;
	}
	public void setMessageStatus(MessageStatus messageStatus) {
		this.messageStatus = messageStatus;
	}
	public Long getImportant() {
		return important;
	}
	public void setImportant(Long important) {
		this.important = important;
	}
	public List<DbMessageRecipient> getRecipients() {
		return recipients;
	}
	public void setRecipients(List<DbMessageRecipient> recipients) {
		this.recipients = recipients;
	}
	public Long getMsgId() {
		return msgId;
	}
	public void setMsgId(Long msgId) {
		this.msgId = msgId;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	
}
