package com.sendi.system.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.service.DicDataService;

/**
 * 字典管理控制器
 * @author liujinghua 2014-10-31
 */
@Controller
@RequestMapping("/dicDataController")
public class DicDataController extends BaseController {
	
	@Autowired
	private DicDataService dicDataService;

	/**查询数据字典,根据dic_key和dic_code模糊查询**/
	@RequestMapping(params = "likeQueryDic")
	public void likeQueryDic(HttpServletRequest request,HttpServletResponse response,String dic_code,String dic_key) {
		if(StringUtils.isEmpty(dic_code) || StringUtils.isEmpty(dic_key)){
			throw new RuntimeException("Error: dic_code or dic_key can not be null!");
		}
		
		List<Map<String, Object>>  datas = dicDataService.likeQueryDic(dic_code, dic_key);
		
		writeResponseText(toJSONArraytring(datas),response);
	}
	
}
