package com.sendi.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;


/**
 * SysJobInterface entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "sys_datasource")
public class SysDataSource implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	// Fields

	private String id;
	private String ds_key;
	private String ds_name;
	private String driverClassName;
	private String url;
	private String username;
	private String password;
	private String validationQuery;
	

	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="id",nullable=false,length=36)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "ds_key",nullable=false,length = 50)
	public String getDs_key() {
		return ds_key;
	}

	public void setDs_key(String ds_key) {
		this.ds_key = ds_key;
	}

	@Column(name = "ds_name",nullable=false,length = 50)
	public String getDs_name() {
		return ds_name;
	}

	public void setDs_name(String ds_name) {
		this.ds_name = ds_name;
	}

	@Column(name = "driverClassName", nullable=false,length = 50)
	public String getDriverClassName() {
		return driverClassName;
	}

	public void setDriverClassName(String driverClassName) {
		this.driverClassName = driverClassName;
	}

	@Column(name = "url",nullable=false, length = 200)
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "username",nullable=false, length = 50)
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "password",nullable=false, length = 50)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "validationQuery",nullable=false, length = 50)
	public String getValidationQuery() {
		return validationQuery;
	}

	public void setValidationQuery(String validationQuery) {
		this.validationQuery = validationQuery;
	}


}