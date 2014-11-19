package ${entityPackage}.service;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.sendi.system.bean.Page;
import com.sendi.system.service.CommonService;
import ${entityPackage}.entity.${entityName};

@Service
public class ${entityName}Service extends CommonService<${entityName}> {
	
	// 查询所有,兼按条件查询，方法共用
	public Page<${entityName}> queryAll(<#list searchFieldList  as x>String ${x['fieldName']},</#list>int start, int limit) {
		String hql = "from ${entityName} where 1=1 ";
		
		<#list searchFieldList  as x>
			if(StringUtils.isNotEmpty(${x['fieldName']})){
				hql += " and ${x['fieldName']} like '%"+${x['fieldName']}+"%'";
			}
		</#list>
		
		return this.getPageList(hql, start, limit);
	}
	
	// 根据ID查询
	public ${entityName} loadById(String id) {
		if (StringUtils.isEmpty(id))
			return null;
		return this.getEntity(${entityName}.class, id);
	}
	
	// 更新
	public void doUpdate(${entityName} ${entityName?uncap_first}) {
		if (!StringUtils.isBlank(${entityName?uncap_first}.getId())) {
			this.updateEntitie(${entityName?uncap_first});
		}
	}

	// 新增
	public void doAdd(${entityName} ${entityName?uncap_first}) {
		this.save(${entityName?uncap_first});
	}
	
	// 刪除
	public void doDel(String ids) {
		if(StringUtils.isEmpty(ids)) throw new RuntimeException("error: deleted record failed, id is not allowed null!");
		
		String hql = "";
		if(ids.contains(",")){
			hql = "DELETE FROM ${entityName} WHERE id in("+ids+")";
		}else{
			hql = "DELETE FROM ${entityName} WHERE id = "+ids+" ";
		}
		
		this.executeHql(hql);
	}
}
