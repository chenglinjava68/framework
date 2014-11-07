package com.sendi.system.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.bean.Page;
import com.sendi.system.entity.SysJobInterface;
import com.sendi.system.service.SysJobInterfaceService;
import com.sendi.system.util.BeanUtils;
import com.sendi.system.util.Json;

@Controller
@RequestMapping("/sysJobInterfaceController")
public class SysJobInterfaceController extends BaseController {
	
	@Autowired
	private SysJobInterfaceService sysJobInterfaceService;
	
	/**
	 * 查询所有
	 */
	@RequestMapping(params = "queryAll")
	public void queryAll(String description,String interfaceid ,HttpServletRequest request,HttpServletResponse response) {
		
		String start = Integer.toString(getStart(request));//获取start参数;
		String limit = Integer.toString(getLimit(request));//获取limit参数;

		Page<SysJobInterface> datas = sysJobInterfaceService.queryAll(description, interfaceid, start, limit);
		
		String responseText = datas.formToJson();
		
		logger.info(responseText);
		
		writeResponseText(responseText, response);
	}
	
	/**
	 * 根据ID查询
	 * @param request
	 * @param response
	 * @param id
	 */
	@RequestMapping(params = "loadSysJobInterfaceById")
	public void loadSysJobInterfaceById(HttpServletRequest request,HttpServletResponse response,String id){
		if (StringUtils.isNotEmpty(id)){
			SysJobInterface sysJobInterface = sysJobInterfaceService.loadSysJobInterfaceById(id);
			writeResponseText(toJSONString(sysJobInterface), response);
		}
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(params = "add")
	public void add(HttpServletRequest request,HttpServletResponse response,SysJobInterface sysJobInterface){
		Json j = new Json();
		try {
			sysJobInterfaceService.add(sysJobInterface);
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
	public void update(HttpServletRequest request,HttpServletResponse response,SysJobInterface sysJobInterface){
		
		Json j = new Json();
		try {
			if(StringUtils.isEmpty(sysJobInterface.getId())) throw new RuntimeException("error: sysJobInterface's id is not allowed null!");
			//1、先从数据库中读取实体
			SysJobInterface target = sysJobInterfaceService.loadSysJobInterfaceById(sysJobInterface.getId());
			BeanUtils.copyProperties(sysJobInterface, target);//将非空属性拷贝给target以供持久化

			sysJobInterfaceService.update(target);
			
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
	public void del(HttpServletRequest request, HttpServletResponse response,String ids) {
		Json j = new Json();
		try {
			
			sysJobInterfaceService.del(ids);//删除角色信息
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.getMessage());
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
}
