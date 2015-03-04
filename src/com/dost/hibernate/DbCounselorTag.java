package com.dost.hibernate;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonBackReference;

@Entity
@Table(name="dost_counselortags")
public class DbCounselorTag extends DbGeneric implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name = "tagid")
	private Long tagId;
	@JsonBackReference
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "counselorid", nullable = false)
	DbCounselor counselor;
    @OneToOne
    @JoinColumn(name="tagname", nullable=false, updatable=false, insertable=false)
	private DbCode code;
    
	public Long getTagId() {
		return tagId;
	}
	public void setTagId(Long tagId) {
		this.tagId = tagId;
	}
	public DbCounselor getCounselor() {
		return counselor;
	}
	public void setCounselor(DbCounselor counselor) {
		this.counselor = counselor;
	}
	public DbCode getCode() {
		return code;
	}
	public void setCode(DbCode code) {
		this.code = code;
	}
    
    
}
