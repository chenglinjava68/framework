package com.sendi.system.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.service.OnlineTableConfigService;
import com.sendi.system.util.Json;

/**
 * @author liujinghua
 * 动态单表配置的增删改查处理器 20141104
 */
@Controller
@RequestMapping("/onlineTableConfigController")
public class OnlineTableConfigController extends BaseController{
	
	@Autowired
	private OnlineTableConfigService onlineTableConfigService;
	
	/**
	 * 查询所有
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "queryAll")
	public void queryAll(String tablename,HttpServletRequest request,HttpServletResponse response) {
		
		List<Map<String, Object>> datas = onlineTableConfigService.queryAll(tablename);
		
		//4、输出内容到页面
		writeJSONArray(datas, request, response);
		
	}
	
	
	/**
	 * 根据configId查询online_item数据
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "queryOnlineItemAll")
	public void queryOnlineItemAll(String configId,HttpServletRequest request,HttpServletResponse response) {
		
		configId = StringUtils.trimToEmpty(configId);//如果为空表示是新增
		
		List<Map<String, Object>> datas = onlineTableConfigService.queryOnlineItemAll(configId);
		
		//4、输出内容到页面
		writeJSONArray(datas, request, response);
		
	}
	
	
	/**
	 * 根据ID进行查询
	 */
	@RequestMapping(params = "loadOnlineHeadById")
	public void loadOnlineHeadById(HttpServletRequest request,HttpServletResponse response,String id){
		if (StringUtils.isNotEmpty(id)){
			Map<String, Object> data = onlineTableConfigService.loadOnlineHeadById(id);
			writeResponseText(toJSONString(data), response);
		}
	}
	
	/**
	 * 修改或新增
	 */
	@RequestMapping(params = "saveOrUpdate")
	public void saveOrUpdate(String configId,String tablename,String title,String online_items,HttpServletRequest request,HttpServletResponse response) {
		Json j = new Json();
		try {
			
			onlineTableConfigService.saveOrUpdate(configId, tablename, title, online_items);
			
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
			
			onlineTableConfigService.del(ids);
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
	
}
