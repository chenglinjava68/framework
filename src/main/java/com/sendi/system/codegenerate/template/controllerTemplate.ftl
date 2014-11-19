package ${entityPackage}.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.bean.Page;
import ${entityPackage}.entity.${entityName};
import ${entityPackage}.service.${entityName}Service;
import com.sendi.system.util.BeanUtils;
import com.sendi.system.util.Json;
import com.sendi.system.web.BaseController;

@Controller
@RequestMapping("/${entityName?uncap_first}Controller")
public class ${entityName}Controller extends BaseController {
	
	@Autowired
	private ${entityName}Service ${entityName?uncap_first}Service;
	
	/**
	 * 查询所有
	 */
	@RequestMapping(params = "queryAll")
	public void queryAll(<#list searchFieldList  as x>String ${x['fieldName']},</#list>HttpServletRequest request,HttpServletResponse response) {
		
		int start = getStart(request);//获取start参数;
		int limit = getLimit(request);//获取limit参数;

		Page<${entityName}> datas = ${entityName?uncap_first}Service.queryAll(<#list searchFieldList as x>${x['fieldName']},</#list>start, limit);
		
		String responseText = datas.formToJson();
		
		writeResponseText(responseText, response);
	}
	
	/**
	 * 根据ID查询
	 * @param request
	 * @param response
	 * @param id
	 */
	@RequestMapping(params = "loadById")
	public void load${entityName}ById(HttpServletRequest request,HttpServletResponse response,String id){
		if (StringUtils.isNotEmpty(id)){
			${entityName} ${entityName?uncap_first} = ${entityName?uncap_first}Service.loadById(id);
			writeResponseText(toJSONString(${entityName?uncap_first}), response);
		}
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(params = "doAdd")
	public void doAdd(HttpServletRequest request,HttpServletResponse response,${entityName} ${entityName?uncap_first}){
		Json j = new Json();
		try {
			${entityName?uncap_first}Service.doAdd(${entityName?uncap_first});
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(params = "doUpdate")
	public void doUpdate(HttpServletRequest request,HttpServletResponse response,${entityName} ${entityName?uncap_first}){
		
		Json j = new Json();
		try {
			if(StringUtils.isEmpty(${entityName?uncap_first}.getId())) throw new RuntimeException("error: ${entityName?uncap_first}'s id is not allowed null!");
			//1、先从数据库中读取实体
			${entityName} target = ${entityName?uncap_first}Service.loadById(${entityName?uncap_first}.getId());
			BeanUtils.copyProperties(${entityName?uncap_first}, target);//将非空属性拷贝给target以供持久化

			${entityName?uncap_first}Service.doUpdate(target);
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.getMessage());
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(params = "doDel")
	public void doDel(HttpServletRequest request, HttpServletResponse response,String ids) {
		Json j = new Json();
		try {
			
			${entityName?uncap_first}Service.doDel(ids);//删除角色信息
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.getMessage());
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
}
