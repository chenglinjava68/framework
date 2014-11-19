package com.sendi.system.service;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.sendi.system.bean.Page;
import com.sendi.system.entity.SysDataSource;

@Service
public class SysDataSourceService extends CommonService<SysDataSource> {
	
	// 查询所有,兼按条件查询，方法共用
	public Page<SysDataSource> queryAll(String ds_key,String ds_name,int start, int limit) {
		String hql = "from SysDataSource where 1=1";
		if(StringUtils.isNotEmpty(ds_key)){
			hql += " and ds_key like '%"+ds_key+"%'";
		}
		if(StringUtils.isNotEmpty(ds_name)){
			hql += " and ds_key like '%"+ds_name+"%'";
		}
		return this.getPageList(hql, start, limit);
	}
	
	// 根据ID查询
	public SysDataSource loadSysDataSourceById(String id) {
		if (StringUtils.isEmpty(id))
			return null;
		return this.getEntity(SysDataSource.class, id);
	}
	
	// 更新
	public void update(SysDataSource SysDataSource) {
		if (!StringUtils.isBlank(SysDataSource.getId())) {
			this.updateEntitie(SysDataSource);
		}
	}

	// 新增数据源
	public void add(SysDataSource SysDataSource) {
		this.save(SysDataSource);
	}
	
	// 刪除数据源
	public void del(String ids) {
		if(StringUtils.isEmpty(ids)) throw new RuntimeException("error: deleted record failed, id is not allowed null!");
		
		String hql = "";
		if(ids.contains(",")){
			hql = "DELETE FROM SysDataSource WHERE id in("+ids+")";
		}else{
			hql = "DELETE FROM SysDataSource WHERE id = "+ids+" ";
		}
		
		this.executeHql(hql);
	}
}
