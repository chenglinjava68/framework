package com.sendi.system.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.entity.Syrole;
import com.sendi.system.service.SyroleService;
import com.sendi.system.util.BeanUtils;
import com.sendi.system.util.Json;
import com.sendi.system.util.common.ContextHolderUtils;

/**
 * 角色管理控制器
 * @author liujinghua 2014-10-31
 */
@Controller
@RequestMapping("/syroleController")
public class SyroleController extends BaseController {
	
	@Autowired
	private SyroleService syroleService;

	/**
	 * 查询所有
	 */
	@RequestMapping(params = "queryAll")
	public void queryAll(HttpServletRequest request,HttpServletResponse response,String name) {
		List<Syrole> datas = syroleService.queryAll(name);
		writeJSONArray(datas, request, response);
	}
	
	/**
	 * 根据ID查询
	 * @param request
	 * @param response
	 * @param id
	 */
	@RequestMapping(params = "loadSyroleById")
	public void loadSyroleById(HttpServletRequest request,HttpServletResponse response,String id){
		if (StringUtils.isNotEmpty(id)){
			Syrole syrole = syroleService.loadSyroleById(id);
			writeResponseText(toJSONString(syrole), response);
		}
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(params = "add")
	public void add(HttpServletRequest request,HttpServletResponse response,Syrole syrole){
		Json j = new Json();
		try {
			syroleService.add(syrole);
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
	@RequestMapping(params = "update")
	public void update(HttpServletRequest request,HttpServletResponse response,Syrole syrole){
		
		Json j = new Json();
		try {
			if(StringUtils.isEmpty(syrole.getId())) throw new RuntimeException("error: syrole's id is not allowed null!");
			//1、先从数据库中读取实体
			Syrole target = syroleService.loadSyroleById(syrole.getId());
			BeanUtils.copyNotNullProperties(syrole, target, new String[] { "createdatetime" });//将非空属性拷贝给target以供持久化

			syroleService.update(target);
			
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
	@RequestMapping(params = "del")
	public void del(HttpServletRequest request,HttpServletResponse response,String ids){
		Json j = new Json();
		try {
			
			if(!syroleService.isNotExistsSyuser(ids)) throw new RuntimeException("被删除角色中存在用户，不允许删除!");
			
			syroleService.delete(ids);//删除角色信息
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.getMessage());
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
		
	}
}
