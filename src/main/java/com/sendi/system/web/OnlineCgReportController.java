package com.sendi.system.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.constants.Globals;
import com.sendi.system.service.OnlineCgReportService;
import com.sendi.system.util.common.FreemarkerHelper;

@Controller
@RequestMapping("/dynamicReportController")
public class OnlineCgReportController extends BaseController {
	@Autowired
	private OnlineCgReportService dynamicReportService;

	@RequestMapping(params = "list")
	public void list(HttpServletRequest request, HttpServletResponse response,String configId) {
		try {

			System.out.println("configId:"+configId);
			Map<String, Object> configs = dynamicReportService.queryReportConfig(configId);
			
			String path = request.getContextPath();
			configs.put("contextRootPath", request.getContextPath());
			configs.put("fullpath", request.getScheme()+"://"+request.getServerName()+":"+Globals.Port+path);

			// step.2 获取列表ftl模板路径
			String html = null;
			FreemarkerHelper viewEngine = new FreemarkerHelper();
			if(StringUtils.equals("Y", (String)((Map<String, Object>)configs.get("headers")).get("ischart"))){//需要生成chart报表，使用DynamicReportChart模板
				html = viewEngine.parseTemplate("/com/sendi/znwg/web/dynamicReport/DynamicReportChart.ftl",configs);
			}else{
				html = viewEngine.parseTemplate("/com/sendi/znwg/web/dynamicReport/DynamicReport.ftl",configs);
			}
			writeResponseText(html, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeResponseText("{success:false,msg:'"+e.getMessage()+"'}", response);
		}
	}

	/**
	 * 动态报表数据查询
	 * 
	 * @param configId
	 *            配置id-code
	 * @param page
	 *            分页页面
	 * @param rows
	 *            分页大小
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "dataQry")
	public void dataQry(String configId, String page, String field,
			String rows, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			writeResponseText(dynamicReportService.dataQry(request), response);
		} catch (Exception e) {
			e.printStackTrace();
			writeResponseText("{success:false,msg:'程序错误'}", response);
		}
	}
	
	@RequestMapping(params = "queryReportChart")
	public void queryReportChart(HttpServletRequest request,HttpServletResponse response) {
		try {
			writeResponseText(dynamicReportService.queryReportChart(request), response);
		} catch (Exception e) {
			e.printStackTrace();
			writeResponseText("{success:false,msg:'程序错误'}", response);
		}
	}
}
