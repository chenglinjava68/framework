package com.sendi.system.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.bean.Page;
import com.sendi.system.entity.SysDataSource;
import com.sendi.system.service.SysDataSourceService;
import com.sendi.system.util.BeanUtils;
import com.sendi.system.util.Json;

@Controller
@RequestMapping("/sysDataSourceController")
public class SysDataSourceController extends BaseController {
	
	@Autowired
	private SysDataSourceService sysDataSourceService;
	
	/**
	 * 查询所有
	 */
	@RequestMapping(params = "queryAll")
	public void queryAll(String ds_key,String ds_name,HttpServletRequest request,HttpServletResponse response) {
		
		int start = getStart(request);//获取start参数;
		int limit = getLimit(request);//获取limit参数;

		Page<SysDataSource> datas = sysDataSourceService.queryAll(ds_key, ds_name, start, limit);
		
		List<SysDataSource> list = datas.getRows();
		for (SysDataSource ds:list) {
			ds.setPassword("****");//密码显示为'****'
		}
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
	@RequestMapping(params = "loadSysDataSourceById")
	public void loadSysDataSourceById(HttpServletRequest request,HttpServletResponse response,String id){
		if (StringUtils.isNotEmpty(id)){
			SysDataSource sysDataSource = sysDataSourceService.loadSysDataSourceById(id);
			writeResponseText(toJSONString(sysDataSource), response);
		}
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(params = "add")
	public void add(HttpServletRequest request,HttpServletResponse response,SysDataSource sysDataSource){
		Json j = new Json();
		try {
			sysDataSourceService.add(sysDataSource);
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
	public void update(HttpServletRequest request,HttpServletResponse response,SysDataSource sysDataSource){
		
		Json j = new Json();
		try {
			if(StringUtils.isEmpty(sysDataSource.getId())) throw new RuntimeException("error: sysDataSource's id is not allowed null!");
			//1、先从数据库中读取实体
			SysDataSource target = sysDataSourceService.loadSysDataSourceById(sysDataSource.getId());
			BeanUtils.copyProperties(sysDataSource, target);//将非空属性拷贝给target以供持久化

			sysDataSourceService.update(target);
			
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
			
			sysDataSourceService.del(ids);//删除角色信息
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.getMessage());
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
}
