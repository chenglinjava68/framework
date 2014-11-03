package com.sendi.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**
 * User entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "sys_user")
public class User implements java.io.Serializable {

	// Fields

	private String id;
	private String userId;
	private String userName;
	private String password;
	private String usertype;
	private Integer pwdvalicity;
	private String createdate;
	private String pwddate;
	private String istip;
	private String isactive;
	private Integer maxlogincount;
	
	//新增 201308
	private String is_share;
	private String ip;
	private Integer max_connect;
	
	private String roleid;//所属角色
	// Constructors

	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=36)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "userId", nullable = false, length = 20)
	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Column(name = "userName", length = 20)
	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Column(name = "password", nullable = false, length = 100)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "usertype", length = 20)
	public String getUsertype() {
		return this.usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}

	@Column(name = "pwdvalicity")
	public Integer getPwdvalicity() {
		return this.pwdvalicity;
	}

	public void setPwdvalicity(Integer pwdvalicity) {
		this.pwdvalicity = pwdvalicity;
	}

	@Column(name = "createdate", length = 20)
	public String getCreatedate() {
		return this.createdate;
	}

	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}

	@Column(name = "pwddate", length = 20)
	public String getPwddate() {
		return this.pwddate;
	}

	public void setPwddate(String pwddate) {
		this.pwddate = pwddate;
	}

	@Column(name = "istip", length = 20)
	public String getIstip() {
		return this.istip;
	}

	public void setIstip(String istip) {
		this.istip = istip;
	}

	@Column(name = "isactive", length = 20)
	public String getIsactive() {
		return this.isactive;
	}

	public void setIsactive(String isactive) {
		this.isactive = isactive;
	}
	
	@Column(name = "maxlogincount")
	public Integer getMaxlogincount() {
		return this.maxlogincount;
	}

	public void setMaxlogincount(Integer maxlogincount) {
		this.maxlogincount = maxlogincount;
	}

	@Column(name = "is_share", length = 10)
	public String getIs_share() {
		return is_share;
	}

	public void setIs_share(String is_share) {
		this.is_share = is_share;
	}
	
	@Column(name = "ip", length = 10)
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
	@Column(name = "max_connect")
	public Integer getMax_connect() {
		return max_connect;
	}

	public void setMax_connect(Integer max_connect) {
		this.max_connect = max_connect;
	}
	
	@Transient
	public String getRoleid() {
		return roleid;
	}

	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	

}