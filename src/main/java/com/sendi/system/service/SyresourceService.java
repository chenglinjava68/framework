package com.sendi.system.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sendi.system.entity.Syresource;

@Service
public class SyresourceService extends CommonService<Syresource> {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	// 查询所有,不带条件
	public List<Syresource> queryAll() {
		String hql= "from Syresource";
		return findByQueryString(hql);
	}
	
	//根据角色ID进行查询，查询出所属角色的资源列表
	public List<Map<String,Object>> queryByRoleId(String roleid){
		String hql= "select * from syrole_syresource where syrole_id = '"+roleid+"' ";
		return jdbcTemplate.queryForList(hql);
	}

	// 查询所有
	public List<Syresource> querySyresourceTreeGridDatas(String sysresource_id) {
		String hql;
		if (StringUtils.isEmpty(sysresource_id)) {
			hql = "from Syresource where sysresource_id ='' or sysresource_id is null";
		} else {
			hql = "from Syresource where sysresource_id ='" + sysresource_id
					+ "'";
		}
		return findByQueryString(hql);
	}
	
	// 授权
	@Transactional
	public void grant(String roleid,String resourceids) {
		String delAuthSql = "delete from syrole_syresource where syrole_id='"+roleid+"'";//1、删除旧权限关系
		StringBuilder updateAuthSql = new StringBuilder("insert into syrole_syresource(syrole_id,syresource_id) values ");
		if(StringUtils.isNotEmpty(resourceids)){
			String[] rids = StringUtils.split(resourceids, ",");
			for(int i=0;i<rids.length;i++){
				if(i==rids.length-1){
					updateAuthSql.append("('").append(roleid).append("','").append(rids[i]).append("')");
				}else{
					updateAuthSql.append("('").append(roleid).append("','").append(rids[i]).append("'),");
				}
			}
		}
		jdbcTemplate.execute(delAuthSql);
		jdbcTemplate.execute(updateAuthSql.toString());
	}

	// 左侧树形菜单
	public List<Map<String,Object>> getMainMenu(String roleid) {
		String sql = "select a.* from syresource a,syrole_syresource b where a.id=b.syresource_id and a.syresourcetype_id='0' and b.syrole_id = '"+roleid+"'";
		return jdbcTemplate.queryForList(sql);
	}

	// 根据ID查询
	public Syresource loadSyresourceById(String id) {
		if (StringUtils.isEmpty(id))
			return null;
		return this.getEntity(Syresource.class, id);
	}

	// 更新资源信息
	public void update(Syresource syresource) {
		if (!StringUtils.isBlank(syresource.getId())) {
			this.updateEntitie(syresource);
		}
	}

	// 新增资源信息
	public void add(Syresource syresource) {
		this.save(syresource);
	}
	
	
	// 刪除资源信息
	@Transactional
	public void delete(String id) {
		if(StringUtils.isEmpty(id)) throw new RuntimeException("error: deleted record failed, id is not allowed null!");
		
		String hql = "DELETE FROM Syresource WHERE id = '"+id+"' ";

		this.executeHql(hql);
		
		//删除角色资源关系
		deleteSyroleResourceByResourceId(id);
	}
	
	//根据资源d删除角色资源关系表中的信息
	private void deleteSyroleResourceByResourceId(String id){
		String sql = "delete from syrole_syresource where SYRESOURCE_ID = '"+id+"' ";
		jdbcTemplate.execute(sql);
	}
	
	//查询当前节点下还有没有子结点,
	public boolean isNotExistsChilds(String id){
		String sql = "select count(*) from syresource where SYRESOURCE_ID = '"+id+"'";
		int count = jdbcTemplate.queryForObject(sql, Integer.class);
		return count == 0 ? true : false;
	}
}
