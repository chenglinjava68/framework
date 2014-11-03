package com.sendi.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 
 */
@Entity
@Table(name = "sys_proload_conf")
public class SysProloadConf implements java.io.Serializable {

	// Fields

	private String id;
	private String interfaceid;
	private String description;
	private String interfacecalss;

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

	@Column(name = "interfaceid", nullable = false, length = 200)
	public String getInterfaceid() {
		return this.interfaceid;
	}

	public void setInterfaceid(String interfaceid) {
		this.interfaceid = interfaceid;
	}

	@Column(name = "description", length = 200)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "interfacecalss", nullable = false, length = 200)
	public String getInterfacecalss() {
		return this.interfacecalss;
	}

	public void setInterfacecalss(String interfacecalss) {
		this.interfacecalss = interfacecalss;
	}

}