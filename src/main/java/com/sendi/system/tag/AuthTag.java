package com.sendi.system.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.sendi.system.service.SyresourceService;
import com.sendi.system.util.AuthUtils;

/**
 * 功能权限用的标签
 * @author liujinghua
 *
 */
public class AuthTag extends TagSupport {
	
	@Autowired
	private static SyresourceService syresourceService;
	
	private String resoureUrl;//资源ID

	public String getResoureUrl() {
		return resoureUrl;
	}

	public void setResoureUrl(String resoureUrl) {
		this.resoureUrl = resoureUrl;
	}

	public int doStartTag() throws JspException {
		//1、如果登录用户没有资源权限，则直接略过
		if(StringUtils.isEmpty(resoureUrl)){ 
			throw new RuntimeException("标签属性resoureUrl不能为空字符串");
		}
		
		//3、检查是否有按钮权限
		boolean authFlag = AuthUtils.auth(pageContext.getSession(), resoureUrl);
		
		//没有权限直接略过标签内部
		if(!authFlag){
			return SKIP_BODY;
		}
		
		//2、有资源权限，则进行输出
		return EVAL_BODY_INCLUDE;
	}
	
	public int doEndTag() throws JspException {
		return EVAL_PAGE;
	}
}
