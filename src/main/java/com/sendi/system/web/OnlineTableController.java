package com.sendi.system.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.bean.Page;
import com.sendi.system.constants.Globals;
import com.sendi.system.service.DicDataService;
import com.sendi.system.service.OnlineTableService;
import com.sendi.system.util.Json;
import com.sendi.system.util.common.FreemarkerHelper;

/**
 * @author liujinghua
 * 动态单表的增删改查处理器 20141104
 */
@Controller
@RequestMapping("/onlineTableController")
public class OnlineTableController extends BaseController{
	
	private static final String CONFIGID = "configId";
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private OnlineTableService onlineTableService;
	
	@Autowired
	private DicDataService dicDataService;
	
	/**
	 * 进入单表配置主页面
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "goListPage")
	public void goListPage(HttpServletRequest request,HttpServletResponse response) {
		
		String configId = StringUtils.trimToEmpty(request.getParameter(CONFIGID));
		//1、读配置数据
		Map<String, Object> configs = onlineTableService.queryConfig(configId);
		configs.put(CONFIGID, configId);
		
		
		String path = request.getContextPath();
		configs.put("contextRootPath", request.getContextPath());
		configs.put("fullpath", request.getScheme()+"://"+request.getServerName()+":"+Globals.Port+path);
		
		//2、组装sql语句进行查询
		
		//3、将数据传到freemaker模板引擎进行页面显示
		String html = null;
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		html = viewEngine.parseTemplate("/com/sendi/system/template/online/onlineTableList.ftl",configs);
		
		//4、输出内容到页面
		writeResponseText(html, response);
		
	}
	
	/**
	 * 进入单表的新增或修改页面
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "goDetailPage")
	public void goDetailPage(HttpServletRequest request,HttpServletResponse response,String id) {
		
		String configId = StringUtils.trimToEmpty(request.getParameter(CONFIGID));
		//1、读配置数据
		Map<String, Object> configs = onlineTableService.queryConfig(configId);
		configs.put(CONFIGID, configId);
		
		String path = request.getContextPath();
		configs.put("contextRootPath", request.getContextPath());
		configs.put("fullpath", request.getScheme()+"://"+request.getServerName()+":"+Globals.Port+path);
		
		//将id处理后传到freemaker模板
		configs.put("id", StringUtils.trimToEmpty(id));//这个id是业务数据的ID
		
		//3、将数据传到freemaker模板引擎进行页面显示
		String html = null;
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		html = viewEngine.parseTemplate("/com/sendi/system/template/online/onlineTable.ftl",configs);
		
		//4、输出内容到页面
		writeResponseText(html, response);
		
	}
	
	/**
	 * 查询所有
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "queryAll")
	public void queryAll(HttpServletRequest request,HttpServletResponse response) {
		
		Map<String, String> params = paramsToMap(request);
		
		//1、读配置数据
		Map<String, Object> configs = onlineTableService.queryConfig(params.get(CONFIGID));
		
		String path = request.getContextPath();
		configs.put("contextRootPath", request.getContextPath());
		configs.put("fullpath", request.getScheme()+"://"+request.getServerName()+":"+Globals.Port+path);
		
		//2、组装sql语句进行查询
		Page<Map<String, Object>> page = onlineTableService.queryAll(params, configs);
		
		//4、输出内容到页面
		writeResponseText(page.formToJson(), response);
		
	}
	
	
	/**
	 * 根据ID进行查询
	 */
	@RequestMapping(params = "loadById")
	public void loadById(HttpServletRequest request,HttpServletResponse response,String id){
		if (StringUtils.isNotEmpty(id)){
			String configId = StringUtils.trimToEmpty(request.getParameter(CONFIGID));
			//1、读配置数据
			Map<String, Object> configs = onlineTableService.queryConfig(configId);
			
			//2、组装sql语句进行查询
			
			Map<String, Object> data = onlineTableService.loadById(id, configs);
			
			writeResponseText(toJSONString(data), response);
		}
	}
	
	/**
	 * 新增
	 */
	@RequestMapping(params = "add")
	public void add(HttpServletRequest request,HttpServletResponse response) {
		Json j = new Json();
		try {
			String configId = StringUtils.trimToEmpty(request.getParameter(CONFIGID));
			//1、读配置数据
			Map<String, Object> configs = onlineTableService.queryConfig(configId);
			
			Map<String, String> params = paramsToMap(request);
			
			onlineTableService.add(params, configs);
			
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
	public void update(HttpServletRequest request,HttpServletResponse response) {
		Json j = new Json();
		try {
			String configId = StringUtils.trimToEmpty(request.getParameter(CONFIGID));
			//1、读配置数据
			Map<String, Object> configs = onlineTableService.queryConfig(configId);
			
			Map<String, String> params = paramsToMap(request);
			
			onlineTableService.update(params, configs);
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(params = "del")
	public void del(String ids ,HttpServletRequest request,HttpServletResponse response) {
		Json j = new Json();
		try {
			String configId = StringUtils.trimToEmpty(request.getParameter(CONFIGID));
			//1、读配置数据
			Map<String, Object> configs = onlineTableService.queryConfig(configId);
			
			//3、执行删除
			onlineTableService.del(ids, configs);
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
	
	/**
	 * 查询字典
	 * @param dict_code
	 */
	@RequestMapping(params = "queryDic")
	public void queryDic(String dic_code,HttpServletRequest request,HttpServletResponse response){
			List<Map<String, Object>> data = dicDataService.queryDic(dic_code);
			
			writeResponseText(toJSONArraytring(data), response);
	}
}
