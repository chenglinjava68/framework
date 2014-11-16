package com.sendi.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 单表配置增强JS
 * @author 邹山
 *
 */
@Entity
@Table(name = "online_head_enhance_js")
public class OnlineHeadEnhanceJs {
	private String id;
	private String headid = "";  //配置的表头ID
	private String js_location = "";   //js位置：list，列表，form,表单
	private String jscontent = ""; //js内容
	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=36)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Column(name = "headid")
	public String getHeadid() {
		return headid;
	}
	public void setHeadid(String headid) {
		this.headid = headid;
	}
	
	@Column(name = "js_location")
	public String getJs_location() {
		return js_location;
	}
	public void setJs_location(String js_location) {
		this.js_location = js_location;
	}
	
	@Column(name = "jscontent")
	public String getJscontent() {
		return jscontent;
	}
	public void setJscontent(String jscontent) {
		this.jscontent = jscontent;
	}
}
