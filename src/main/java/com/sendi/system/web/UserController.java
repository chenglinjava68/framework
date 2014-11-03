package com.sendi.system.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.entity.User;
import com.sendi.system.service.UserRoleService;
import com.sendi.system.service.UserService;
import com.sendi.system.util.Json;

@Controller
@RequestMapping("/userController")
public class UserController extends BaseController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private UserRoleService userRoleService;

	/**
	 * 查询
	 */
	@RequestMapping(params = "queryUser")
	public void queryUser(HttpServletRequest request,
			HttpServletResponse response, String userId, String userName) {

		List<User> datas = userService.queryUser(userId, userName);
		writeJSONArray(datas, request, response);		
	}

	/**
	 * 新增
	 */
	@RequestMapping(params = "addUser")
	public void addUser(HttpServletRequest request,
			HttpServletResponse response, User user,String roleid) {

		try {
			// 先进行特殊处理一下，将部分参数值设置默认值
			user.setUsertype("1");// usertype写死成1

			if (StringUtils.isEmpty(user.getIstip())) {
				user.setIstip("off");
			}

			String currentTime = DateFormatUtils.format(new Date(),
					"yyyy-MM-dd HH:mm");
			user.setCreatedate(currentTime);
			user.setPwddate(currentTime);
			user.setIsactive("on");

			// 执行插入操作
			userService.addUser(user,roleid);

			this.writeResponseText("{\"success\":true,\"msg\":\"新增成功\"}", response);
		} catch (Exception e) {
			this.writeResponseText("{\"success\":false,\"msg\":\"新增失败\"}", response);
			e.printStackTrace();
		}

	}
	
	/**
	 * 查询单条记录，用于修改
	 * 
	 */
	@RequestMapping(params = "excutModifyQueryuser")
	public void excutModifyQueryuser(String id,HttpServletResponse response){
		try {
			
			User user = userService.findById(id);
			String roleid = userRoleService.findRoleIdByUserId(user.getId());//将角色ID查询出来
			user.setRoleid(roleid);
			JSONObject json = JSONObject.fromObject(user);
			json.put("passwordc", user.getPassword());////load完然后设置确认密码的框的值
			writeResponseText(json.toString(),response);
	   	} catch (Exception e) {
			e.printStackTrace();
	   		writeResponseText("{\"success\":false,\"msg\":\"faild\",\"errors\":{"+e.getMessage()+"}}",response);
		}
	}

	/**
	 * 修改
	 */
	@RequestMapping(params = "excuteModifyuser")
	public void excuteModifyuser(HttpServletRequest request,
			HttpServletResponse response, String id, String istip,
			String userId, Integer pwdvalicity, String userName, String ip,
			String is_share, Integer max_connect,String password,Integer maxlogincount,String roleid) {

		try {

			User user = userService.findById(id);
			if (user == null)
				throw new RuntimeException("用户未找到，修改失败");

			user.setIstip(istip == null ? "off" : istip);
			user.setUserId(userId);
			user.setPwdvalicity(pwdvalicity);
			user.setUserName(userName);
			user.setIp(ip);
			user.setIs_share(is_share);
			user.setMax_connect(max_connect);
			if (!user.getPassword().equals(password)) // 如果原密码跟现有的密码一样，则不修改日期
			{
				user.setPassword(password);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				String current = sdf.format(new Date());
				user.setPwddate(current);
			}
			user.setMaxlogincount(maxlogincount);

			userService.excuteModifyuser(user,roleid);

			this.writeResponseText("{\"success\":true,\"msg\":\"修改成功\"}", response);
		} catch (Exception e) {
			this.writeResponseText("{\"success\":false,\"msg\":\"修改失败\"}", response);
			e.printStackTrace();
		}
	}

	/**
	 * 删除
	 */
	@RequestMapping(params = "excuteDeleteuser")
	public void excuteDeleteuser(HttpServletRequest request,
			HttpServletResponse response,String deleterecord) {
		try {

			userService.excuteDeleteuser(deleterecord);
			
			this.writeResponseText("{\"success\":true,\"msg\":\"删除成功\"}", response);
		} catch (Exception e) {
			this.writeResponseText("{\"success\":false,\"msg\":\"删除失败\"}", response);
			e.printStackTrace();
		}
	}

	/**
	 * 激活或禁用
	 */
	@RequestMapping(params = "excuteChangestatus")
	public void excuteChangestatus(HttpServletRequest request,
			HttpServletResponse response, String activestatus,String deleterecord) {
		try {

			userService.excuteChangestatus(activestatus, deleterecord);
			
			this.writeResponseText("{\"success\":true,\"msg\":\"操作成功\"}", response);
		} catch (Exception e) {
			this.writeResponseText("{\"success\":false,\"msg\":\"操作失败\"}", response);
			e.printStackTrace();
		}
	}

	/**
	 * 修改密码
	 * 
	 * @param request
	 * @param response
	 * @param description
	 * @param password
	 * @param pwdvalicity
	 */
	@RequestMapping(params = "excuteModifyUserPassword")
	public void excuteModifyUserPassword(HttpServletRequest request,
			HttpServletResponse response, String description, String userName,// 这里的userName表示旧密码
			String password, Integer pwdvalicity) {
		try {
			String userId = getCurrentUserId(request.getSession());
			userService.excuteModifyUserPassword(userId, userName, password,
					pwdvalicity);
			this.writeResponseText("{\"success\":true,\"msg\":\"修改密码成功!\"}", response);
		} catch (Exception e) {
			this.writeResponseText(
					"{\"success\":false,\"msg\":\"修改密码失败！" + e.getMessage() + "\"}",
					response);
			e.printStackTrace();
		}

	}
	
	/**
	 * 查询新增或修改页面中父角色的下拉选择框数据
	 */
	@RequestMapping(params = "findParentidCombox")
	public void findParentidCombox(HttpServletRequest request,HttpServletResponse response){
		
		String roleId = getCurrentRoleId(request.getSession());
		if(StringUtils.isEmpty(roleId)) throw new RuntimeException("未找到role,当前session已失效？");
		
		writeResponseText(toJSONArraytring(userRoleService.findParentidCombox(roleId)), response);
	}
	
	/**
	 * 根据角色id查询角色下的所有用户
	 */
	@RequestMapping(params = "queryUserByRoleId")
	public void queryUserByRoleId(HttpServletRequest request,
			HttpServletResponse response, String roleid ) {
		
		int starti = getStart(request);
        int limiti = getLimit(request);
		
		String json = userRoleService.queryUserByRoleId(roleid, ""+starti, ""+limiti);
		
		writeResponseText(json, response);	
	}
}
