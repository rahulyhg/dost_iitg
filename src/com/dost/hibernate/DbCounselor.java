package com.dost.hibernate;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonManagedReference;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name="dost_counselors")
public class DbCounselor extends DbGeneric implements Serializable {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name = "counselorid")
	private Long counselorId;
	@Column(name = "username")
	private String username;
	@Column(name = "password")
	private String password;
	@Column(name = "name")
	private String name;
	@Column(name = "description")
	private String description;	
	@Column(name = "profilename")
	private String profileName;
	@Column(name = "timing")
	private String timing;
	@Column(name = "gender")
	private String gender;
	@Column(name = "location")
	private String location;
	@Column(name = "avatar")
	private String avatar;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "counselor")
	@Fetch(value = FetchMode.SUBSELECT)
	@JsonManagedReference
	private List<DbCounselorTag> tags;
	
	public Long getCounselorId() {
		return counselorId;
	}
	public void setCounselorId(Long counselorId) {
		this.counselorId = counselorId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProfileName() {
		return profileName;
	}
	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}
	public String getTiming() {
		return timing;
	}
	public void setTiming(String timing) {
		this.timing = timing;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}

	public List<DbCounselorTag> getTags() {
		return tags;
	}
	public void setTags(List<DbCounselorTag> tags) {
		this.tags = tags;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}




}
