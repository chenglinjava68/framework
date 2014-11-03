package com.sendi.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/*
 * 用户角色的运行类
 * 缓存到内存中，做为单例运行
 */

/**
 * 用户角类Service类
 * @author liujinghua
 *
 */
@Service
@Transactional(readOnly = true)
public class UserRoleService extends CommonService{
	
	public List<Map<String,Object>> findParentidCombox(String roleId){
		String sql = "select id,name from syrole";
		return jdbcTemplate.queryForList(sql);
	}
	
	/**
	 * 根据userid查询roleid
	 * @param userid
	 * @return
	 */
	public String findRoleIdByUserId(String userid){
		String sql="select SYROLE_ID from syuser_syrole  WHERE SYUSER_ID ='"+userid+"'";
		Map<String,Object> map = jdbcTemplate.queryForMap(sql);
		return (String)map.get("SYROLE_ID");
	}
	
   /**
    * 需要将用户组关系删除，然后再进行重新插入,更新用户角色ID
    */
	public void updateUserRoleId(String roleid,String userid)
	{
		 String sql="delete from syuser_syrole  WHERE SYUSER_ID = '"+userid+"'";
		 String sql2="insert into syuser_syrole (SYUSER_ID,SYROLE_ID) values ('"+userid+"','"+roleid+"')";
		 String[] sqls = new String[]{sql,sql2};
		 jdbcTemplate.batchUpdate(sqls);
	}
	
	/**
	 * 根据角色id查询角色下的所有用户
	 * @param roleid
	 * @return
	 */
	public String queryUserByRoleId(String roleid,String start,String limit){
		String sql = "select sys_user.* from sys_user,syuser_syrole where sys_user.id = syuser_syrole.SYUSER_ID and syuser_syrole.SYROLE_ID='"+roleid+"'";
		return getDataLimit(sql, start, limit);
	}
	
	
}
