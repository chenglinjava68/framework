package com.sendi.system.service;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.sendi.system.bean.Page;
import com.sendi.system.entity.SysJobInterface;

@Service
public class SysJobInterfaceService extends CommonService<SysJobInterface> {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	// 查询所有,兼按条件查询，方法共用
	public Page<SysJobInterface> queryAll(String description,String interfaceid,String start, String limit) {
		String hql = "from SysJobInterface where 1=1";
		if(StringUtils.isNotEmpty(interfaceid)){
			hql += " and interfaceid like '%"+interfaceid+"%'";
		}
		if(StringUtils.isNotEmpty(description)){
			hql += " and description like '%"+description+"%'";
		}
		return this.getPageList(hql, start, limit);
	}
	
	// 根据ID查询
	public SysJobInterface loadSysJobInterfaceById(String id) {
		if (StringUtils.isEmpty(id))
			return null;
		return this.getEntity(SysJobInterface.class, id);
	}
	
	// 更新
	public void update(SysJobInterface sysJobInterface) {
		if (!StringUtils.isBlank(sysJobInterface.getId())) {
			this.updateEntitie(sysJobInterface);
		}
	}

	// 新增角色
	public void add(SysJobInterface sysJobInterface) {
		this.save(sysJobInterface);
	}
	
	// 刪除定时任务
	public void del(String ids) {
		if(StringUtils.isEmpty(ids)) throw new RuntimeException("error: deleted record failed, id is not allowed null!");
		
		String hql = "";
		if(ids.contains(",")){
			hql = "DELETE FROM SysJobInterface WHERE id in("+ids+")";
		}else{
			hql = "DELETE FROM SysJobInterface WHERE id = "+ids+" ";
		}
		
		this.executeHql(hql);
	}
}
