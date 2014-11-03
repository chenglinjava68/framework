package com.sendi.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * SysJobInterface entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "sys_job_interface")
public class SysJobInterface implements java.io.Serializable {

	// Fields

	private String id;
	private String interfaceid;
	private String description;
	private String interfacecalss;
	private String jobtype;
	private String cronexpression;
	private String jobstartTime;
	private Integer jobRepeatInterval;
	private Integer jobRepeatcount;
	private String isactive;

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

	@Column(name = "interfaceid", nullable = false, length = 100)
	public String getInterfaceid() {
		return this.interfaceid;
	}

	public void setInterfaceid(String interfaceid) {
		this.interfaceid = interfaceid;
	}

	@Column(name = "description", nullable = false, length = 200)
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

	@Column(name = "jobtype", length = 20)
	public String getJobtype() {
		return this.jobtype;
	}

	public void setJobtype(String jobtype) {
		this.jobtype = jobtype;
	}

	@Column(name = "cronexpression", length = 20)
	public String getCronexpression() {
		return this.cronexpression;
	}

	public void setCronexpression(String cronexpression) {
		this.cronexpression = cronexpression;
	}

	@Column(name = "jobstart_time", length = 20)
	public String getJobstartTime() {
		return this.jobstartTime;
	}

	public void setJobstartTime(String jobstartTime) {
		this.jobstartTime = jobstartTime;
	}

	@Column(name = "job_repeatInterval")
	public Integer getJobRepeatInterval() {
		return this.jobRepeatInterval;
	}

	public void setJobRepeatInterval(Integer jobRepeatInterval) {
		this.jobRepeatInterval = jobRepeatInterval;
	}

	@Column(name = "job_repeatcount")
	public Integer getJobRepeatcount() {
		return this.jobRepeatcount;
	}

	public void setJobRepeatcount(Integer jobRepeatcount) {
		this.jobRepeatcount = jobRepeatcount;
	}

	@Column(name = "isactive", length = 20)
	public String getIsactive() {
		return this.isactive;
	}

	public void setIsactive(String isactive) {
		this.isactive = isactive;
	}

}