package com.sendi.system.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sendi.system.bean.ApplicationContextHelper;
import com.sendi.system.entity.User;

/**
 * 用户管理类
 * @author liujinghua
 */
@Service
public class UserService extends CommonService<User> {
	
	@Autowired
	private ApplicationContextHelper applicationContextHelper;
	
	@Autowired
	private UserRoleService userRoleService;
	
	
	/**
	 * 查询用户，用于用户列表显示
	 */
	public List<User> queryUser(String userid,String username){
		String hql = "from User where 1=1";
		
		if(StringUtils.isNotEmpty(userid)){
			hql += " and userid like '%"+userid+"%'";
		}
		if(StringUtils.isNotEmpty(username)){
			hql += " and username like '%"+username+"%'";
		}
		
		return this.findByQueryString(hql);
	}
	
	
	/**
	 * 新增用户
	 */
	@Transactional
	public void addUser(User user,String roleid){
		 
		String userid = (String)this.save(user);
		userRoleService.updateUserRoleId(roleid, userid);
	}
	
	/**
	 * 修改用户
	 */
	@Transactional
	public void excuteModifyuser(User user,String roleid){
		this.updateEntitie(user);
		userRoleService.updateUserRoleId(roleid, user.getId());
	}
	
	/**
	 * 根据Id查询用户
	 * @param id
	 * @return
	 */
	public User findById(String id){
		return this.get(User.class, id);
	}
	
	/**
	 * 根据用户账号查询用户
	 * @param id
	 * @return
	 */
	public User findByUserId(String userId){
		return this.findUniqueByProperty(User.class, "userId", userId);
	}
	
	/**
	 * 删除用户
	 */
	@Transactional
	public void excuteDeleteuser(String deleterecord){
		String hql="delete from sys_user where id in ("+deleterecord+")";
		String hql2="delete from syuser_syrole where SYUSER_ID in ("+deleterecord+")";
		
		String[] sqls = new String []{hql,hql2};
		
		jdbcTemplate.batchUpdate(sqls);
	}
	
	//激活或禁用用的方法
	@Transactional
	public void excuteChangestatus(String activestatus,String deleterecord)
	{
		String sql="update sys_user set isactive='"+activestatus+"' where id in("+deleterecord+")";
		
		int r = jdbcTemplate.update(sql);
		
	}
	

	/**
	 * 修改密码
	 */
	@Transactional
	public void excuteModifyUserPassword(String userId, String userName,String password,
			Integer pwdvalicity) {
		if (userId == null || userId.equals("") || userId.equals("null")) {
			throw new RuntimeException("userId is null!账号不能为空");
		}

		String hql = "from User where  userId='" + userId + "' and password='"	+ userName + "' ";

		User user = singleResult(hql);
		
		if(user == null) throw new RuntimeException("原始密码输入不正确");
		
		user.setPwdvalicity(pwdvalicity);
		if (!user.getPassword().equals(password)) // 如果原密码跟现有的密码一样，则不修改日期
		{
			user.setPassword(password);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String current = sdf.format(new Date());
			user.setPwddate(current);
		}

		updateEntitie(user);

	}
}
