package com.sendi.system.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sendi.system.entity.Syrole;

/**
 * 角色service类
 * @author liujinghua
 */
@Service
public class SyroleService extends CommonService<Syrole> {
	
	@Autowired
	private UserService userService;
	
		// 查询所有
		public List<Syrole> queryAll(String rolename) {
			String hql = "from Syrole where 1=1";
			
			if(StringUtils.isNotEmpty(rolename)){
				hql += " and name like '%"+rolename+"%'";
			}
			
			return this.findByQueryString(hql);
			
		}

		// 根据ID查询
		public Syrole loadSyroleById(String id) {
			if (StringUtils.isEmpty(id))
				return null;
			return this.getEntity(Syrole.class, id);
		}

		// 更新
		public void update(Syrole syrole) {
			if (!StringUtils.isBlank(syrole.getId())) {
				this.updateEntitie(syrole);
			}
		}

		// 新增角色
		public void add(Syrole syrole) {
			this.save(syrole);
		}
		
		// 刪除角色
		@Transactional
		public void delete(String ids) {
			if(StringUtils.isEmpty(ids)) throw new RuntimeException("error: deleted record failed, id is not allowed null!");
			
			String hql = "";
			if(ids.contains(",")){
				hql = "DELETE FROM Syrole WHERE id in("+ids+")";
			}else{
				hql = "DELETE FROM Syrole WHERE id = "+ids+" ";
			}
			this.executeHql(hql);
			
			deleteSyroleResourceByRoleId(ids);//删除角色资源关系
			deleteSyuserSyroleByRoleId(ids);//删除角色用户关系
		}
		
		//根据角色id删除角色资源关系表中的信息
		private void deleteSyroleResourceByRoleId(String ids){
			String sql = "";
			if(ids.contains(",")){
				sql = "delete from syrole_syresource where SYROLE_ID in("+ids+")";
			}else{
				sql = "delete from syrole_syresource where SYROLE_ID = "+ids+"";
			}
			
			jdbcTemplate.execute(sql);
		}
		
		//根据角色id删除角色用户关系表中的信息
		private void deleteSyuserSyroleByRoleId(String ids){
			String sql = "";
			if(ids.contains(",")){
				sql = "delete from syuser_syrole where SYROLE_ID in("+ids+")";
			}else{
				sql = "delete from syuser_syrole where SYROLE_ID = "+ids+"";
			}
			
			jdbcTemplate.execute(sql);
		}
		
		//查询删除的角色中是否还有用户,
		public boolean isNotExistsSyuser(String ids){
			String sql = "";
			if(ids.contains(",")){
				sql = "select count(*) from syuser_syrole where SYROLE_ID in("+ids+")";
			}else{
				sql = "select count(*) from syuser_syrole where SYROLE_ID = "+ids+"";
			}
			
			int count = jdbcTemplate.queryForObject(sql, Integer.class);
			return count == 0 ? true : false;
		}
		
}
