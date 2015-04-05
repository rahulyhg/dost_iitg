package com.dost.hibernate;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonManagedReference;
import org.hibernate.annotations.IndexColumn;

@Entity
@Table(name="user")
//@Cache(usage=CacheConcurrencyStrategy.READ_WRITE, region="database")
public class DbUser extends DbGeneric implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1083243294363914028L;
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name = "userid")
	private Long userId;
	@Column(name = "username")
	private String username;
	@Column(name = "password")
	@JsonIgnore
	private String password;
	@Column(name = "userrole")
	@JsonIgnore
	private Role userRole;
	@JsonManagedReference
	@OneToOne(fetch = FetchType.EAGER, mappedBy = "dbUser", cascade = CascadeType.ALL)
	private DbUserRole dbUserRole;
	@Column(name = "enabled")
	@JsonIgnore
	private Integer enabled;
	@Column(name = "avatar")
	private String avatar;
//	@JsonManagedReference
//	@IndexColumn(name="userId")
//    @OneToMany (fetch = FetchType.EAGER, mappedBy="user", cascade = CascadeType.ALL)
//    private List<DbUserSecurity> userSecurities;
	
	@JsonManagedReference
	@IndexColumn(name="questionId")
    @OneToMany (fetch = FetchType.EAGER, mappedBy="user", cascade = CascadeType.ALL)
    private List<DbUserSecurity> userSecurities;
	
	//TODO: Need place holder for images or avatar, may be clob or blob. Satya you decide
	
	@Column(name = "fname")
	private String fname;
	@Column(name = "lname")
	private String lname;
	@Column(name = "hostel")
	private String hostel;
	@Column(name = "year")
	private String year;
	@Column(name = "branch")
	private String branch;
	@Column(name = "email")
	private String email;	
	@Column(name = "blocked")
	private String blocked;	
	@Column(name = "identifier")
	private String identifier;
	
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
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
	public Role getUserRole() {
		return userRole;
	}
	public void setUserRole(Role userRole) {
		this.userRole = userRole;
	}
	public DbUserRole getDbUserRole() {
		return dbUserRole;
	}
	public void setDbUserRole(DbUserRole dbUserRole) {
		this.dbUserRole = dbUserRole;
	}
	public Integer getEnabled() {
		return enabled;
	}
	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public List<DbUserSecurity> getUserSecurities() {
		return userSecurities;
	}
	public void setUserSecurities(List<DbUserSecurity> userSecurities) {
		this.userSecurities = userSecurities;
	}
	public String getFname() {
		return fname == null ? "" : fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname == null ? "" : lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getHostel() {
		return hostel == null ? "" : hostel;
	}
	public void setHostel(String hostel) {
		this.hostel = hostel;
	}
	public String getYear() {
		return year == null ? "" : year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getBranch() {
		return branch  == null ? "" : branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBlocked() {
		return blocked;
	}
	public void setBlocked(String blocked) {
		this.blocked = blocked;
	}
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	
	
	
}
