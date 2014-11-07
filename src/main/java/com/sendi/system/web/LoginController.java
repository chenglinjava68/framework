package com.sendi.system.web;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sendi.system.bean.SysLogHelper;
import com.sendi.system.entity.User;
import com.sendi.system.service.AfterLoginService;
import com.sendi.system.service.UserRoleService;
import com.sendi.system.service.UserService;
import com.sendi.system.util.Json;
import com.sendi.system.util.common.DateUtil;

/**
 * 登录类控制器
 * 
 * @author liujinghua
 * @date 2014-05-14 10：32
 */
@Controller
@RequestMapping("/loginController")
public class LoginController extends BaseController{
	
	private static final String LOGIN_ = "/login";
	
	@Autowired
	private SysLogHelper sysLogHelper;
	
	@Autowired
	private AfterLoginService afterLoginService;
	
	@Autowired
	private UserRoleService userRoleService;
	
	@Autowired
	private UserService userService;
	
	/**
	 * 登录
	 */
	@RequestMapping(params = "login")
	public ModelAndView login(HttpServletRequest request) {

		String login_rand = request.getParameter("login_rand");
		String login_username = request.getParameter("login_username");
		String login_password = request.getParameter("login_password");

		try {
			
			//1、验证码校验
			if (request.getSession().getAttribute("rand") != null) {
				if (!request.getSession().getAttribute("rand").toString()
						.equals(login_rand)) {
					request.setAttribute("loginMSG", "验证码输入错误");
					return new ModelAndView(LOGIN_);
				}
			}
			
		 	//3、判断用户名密码
			User u = userService.findByUserId(login_username);
			
			if(u==null)
			{
				request.setAttribute("loginMSG", "未知用户名登录");
				return new ModelAndView(LOGIN_);
		 	}else{
		 		
		 		if(!u.getPassword().equals(login_password))
				{
					request.setAttribute("loginMSG", "密码不正确");
					return new ModelAndView(LOGIN_);
				}
				if(u.getIsactive().equals("off")) //系统管理员不能禁用
				{
					request.setAttribute("loginMSG", "该用户已被禁用");
					return new ModelAndView(LOGIN_);
			 	}
				
				//判断密码是否已过有限期2010 07 22 超级管理员不需要提示
				if(u.getIstip().equals("on"))
				{
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
				    Date  d=sdf.parse(u.getPwddate());
				    int p= DateUtil.diffDateD(d,new Date());
				    if(p>=u.getPwdvalicity())
				    {
						String pwdurl=request.getContextPath()+"/system/modipwd.jsp";
				    	request.setAttribute("loginMSG", u.getUserId()+":该用户密码已过期,请<a target='_blank' href='"+pwdurl+"'>修改密码</a>");
				    	return new ModelAndView(LOGIN_);
				    }
				}
				
	 		}
			
			//6、登录成功，从数据库中查询出角色ID
			String roleid = userRoleService.findRoleIdByUserId(u.getId());//加载出角角ID放入session
			
			//7、登录成功，将登录信息设置在session中
			request.getSession().setAttribute(this.SESSION_USER_ID, u.getUserId()+"");
			request.getSession().setAttribute(this.SESSION_USER_NAME, u.getUserName()+"");
			request.getSession().setAttribute(this.SESSION_ROLE_ID, roleid+"");
			request.getSession().setAttribute(this.SESSION_USER_ID_TABLEKEY, u.getId()+"");
			
			//8、登录成功后通过afterLoginService.doLoad方法做一系统事情
			afterLoginService.setUserid(u.getUserId()+"");
			afterLoginService.setRoleid(roleid+"");
			afterLoginService.setRequest(request);
			afterLoginService.doLoad();
			
			this.sysLogHelper.Log(login_username, request.getRemoteAddr(), "success", new Date().toLocaleString(),"login to system","login");
			 
		 }catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("loginMSG","error:"+e.getMessage());
				return new ModelAndView(LOGIN_);
	     }
				 
		 return new ModelAndView("system/main_common");
	}
	
	//这个方法用于锁定窗口后进行解锁
	@RequestMapping(params = "doLoginAgain")
	public void doLoginAgain(HttpServletRequest request, HttpServletResponse response, String loginname, String password) {
		Json j = new Json();
		//3、判断用户名密码
		User u = userService.findByUserId(loginname);
		System.out.println(u.getPassword()+":"+password);
		if(!u.getPassword().equals(password)){
			j.setSuccess(false);
			j.setMsg("密码不正确");
		}else{//成功检验
			//6、登录成功，从数据库中查询出角色ID
			String roleid = userRoleService.findRoleIdByUserId(u.getId());//加载出角角ID放入session
			
			//7、登录成功，将登录信息设置在session中
			request.getSession().setAttribute(this.SESSION_USER_ID, u.getUserId()+"");
			request.getSession().setAttribute(this.SESSION_USER_NAME, u.getUserName()+"");
			request.getSession().setAttribute(this.SESSION_ROLE_ID, roleid+"");
			request.getSession().setAttribute(this.SESSION_USER_ID_TABLEKEY, u.getId()+"");
			
			//8、登录成功后通过afterLoginService.doLoad方法做一系统事情
			afterLoginService.setUserid(u.getUserId()+"");
			afterLoginService.setRoleid(roleid+"");
			afterLoginService.setRequest(request);
			afterLoginService.doLoad();
		}
		
		writeResponseText(j.getJsonStr(), response);
		
	}
	
	/**
	 * 登出
	 */
	@RequestMapping(params = "logout")
	public void logout(HttpServletRequest request,HttpServletResponse response) {
		logger.info("logout...............................");
		HttpSession hs = request.getSession();
		if (hs.getAttribute("userid") != null) {
			String userId = hs.getAttribute("userid").toString();
			String ip = getIp(request);
			// behaviourHelper.logout(userId, ip);
			// this.sysLogHelper.Log(this.login_username,
			// getRequest().getRemoteAddr(), "success", new
			// Date().toLocaleString(),"logout system","logout");
			try {
				// OnlineUser
				// onlineUser=(OnlineUser)this.applicationContextHelper.appctx.getBean("onlineUser");
				// onlineUser.loginstatusmap.remove(hs.getId());
				// //状态未知，2种状态login(登录),unknow状态需要在真正的socket连接建立后才能将状态改为login

				hs.invalidate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		Json j = new Json();
		writeResponseText(j.getJsonStr(), response);
	}

	private String getIp(HttpServletRequest request) {
		String ip = request.getRemoteAddr();
		if (ip == null || ip.length() == 0) {
			HttpSession hs = request.getSession();
			System.out.println(request.getRemoteAddr() + "_"
					+ hs.getAttribute("loginInfo"));
			if (hs.getAttribute("loginInfo") != null) {
				// LoginInfo loginInfo =
				// (LoginInfo)hs.getAttribute("loginInfo");
				ip = "192.168.2.1";// loginInfo.loginhost;
			}
		}
		return ip;
	}

}
