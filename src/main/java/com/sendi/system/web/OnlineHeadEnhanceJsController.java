package com.sendi.system.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.sendi.system.entity.OnlineHeadEnhanceJs;
import com.sendi.system.service.OnlineHeadEnhanceJsService;
import com.sendi.system.util.Json;

@Controller
@RequestMapping("/onlineHeadEnhanceJsController")
public class OnlineHeadEnhanceJsController extends BaseController{
	
	@Autowired
	private OnlineHeadEnhanceJsService service;
	
	@RequestMapping(params = "doAdd",method=RequestMethod.POST)
	public void doAdd(HttpServletRequest request,HttpServletResponse response,OnlineHeadEnhanceJs onlineHeadEnhanceJs){
		Json j = new Json();
		try {
			
			service.save(onlineHeadEnhanceJs);
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
	@RequestMapping(params = "doQuery")
	public void doQuery(HttpServletRequest request,
			HttpServletResponse response,
			String headid,String js_location){
		int starti = getStart(request);//获取分页参数
        int limiti = getLimit(request);
		String json = service.queryAll(headid, js_location, String.valueOf(starti), String.valueOf(limiti));
		writeResponseText(json, response);
	}
	
	@RequestMapping(params = "doUpdate")
	public void doUpdate(HttpServletRequest request,HttpServletResponse response,OnlineHeadEnhanceJs onlineHeadEnhanceJs){
		
		Json j = new Json();
		try {
			if(onlineHeadEnhanceJs==null || StringUtils.isEmpty(onlineHeadEnhanceJs.getId())){
				throw new RuntimeException("error: sysJobInterface's id is not allowed null!");
			}
			
			service.updateEntitie(onlineHeadEnhanceJs);
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.getMessage());
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
	@RequestMapping(params = "doDelete")
	public void doDelete(HttpServletRequest request,
			HttpServletResponse response,String ids){
		Json j = new Json();
		try {
			
			service.updateBySqlString("delete from online_head_enhance_js where id in("+ids+")");
			
			this.writeResponseText(j.getJsonStr(), response);
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg(e.getMessage());
			this.writeResponseText(j.getJsonStr(), response);
			e.printStackTrace();
		}
	}
	@RequestMapping(params = "doQueryById")
	public void doQueryById(HttpServletRequest request,
			HttpServletResponse response,String id){
		if (StringUtils.isNotEmpty(id)){
			Map<String,Object> map = service.loadById(id);
			writeResponseText(toJSONString(map), response);
		}
	}
}
