package com.sendi.system.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Service;

import com.sendi.system.bean.ApplicationContextHelper;
import com.sendi.system.constants.Globals;

/**
 * 用户登录后在此类作一些加载操作，如设置全局的session信息等等
 * @author liujinghua 日期：2014-07-03
 */

@Service
public class AfterLoginService {
	private final static String UserButtonOperationsJson ="user_button_operations_json"; 

	@Autowired
	private ApplicationContextHelper applicationContextHelper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private String userid;
	private String roleid;
	private HttpServletRequest request;
	
	public void doLoad() {
		loadUserButtionOperations();//加载用户按钮操作权限
	}
	
	/**
	 * 加载用户按钮操作权限
	 */
	public void loadUserButtionOperations() {
		String sql = "select t1.syrole_id,t1.syresource_id,t2.url from syrole_syresource t1,syresource t2 where t2.syresourcetype_id = '1' and t1.syrole_id='"+getRoleid()+"' and t1.syresource_id=t2.id;";
		List<Map<String,Object>> userButtonOperations = this.jdbcTemplate.queryForList(sql);
		getRequest().getSession().setAttribute(Globals.UserButtonOperations, userButtonOperations);
	}
	
	
	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public String getRoleid() {
		return roleid;
	}

	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
}
