package com.sendi.system.web;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.service.OnlineCgReportExcelService;
import com.sendi.system.service.OnlineCgReportService;
/**
 * 
 * @Title:ExportExcelController
 * @description:报表excel导出
 * @author 赵俊夫
 * @date Aug 1, 2013 10:52:26 AM
 * @version V1.0
 */
@Controller
@RequestMapping("/dynamicReportExcelController")
public class OnlineCgReportExcelController {
	@Autowired
	private OnlineCgReportService dynamicReportService;
	@Autowired
	private OnlineCgReportExcelService dynamicReportExcelService;
	/**
	 * 将报表导出为excel
	 * @param request
	 * @param response
	 */
	@SuppressWarnings("all")
	@RequestMapping(params = "exportXls")
	public void exportXls(HttpServletRequest request,
			HttpServletResponse response) {
		//step.1 设置，获取配置信息
		String codedFileName = "报表";
		if (request.getParameter("configId")!=null) {
			String configId = request.getParameter("configId");
			codedFileName = configId+"报表";
			Map<String, Object> cgReportMap = null;
			try{
				cgReportMap = dynamicReportService.queryReportConfig(configId);
			}catch (Exception e) {
				e.printStackTrace();
			}
			List<Map<String,Object>> fieldList = (List<Map<String, Object>>) cgReportMap.get("config_fieldList");
			/*
			Map configM = (Map) cgReportMap.get(CgReportConstant.MAIN);
			codedFileName = configM.get("name")+codedFileName;
			String querySql = (String) configM.get(CgReportConstant.CONFIG_SQL);
			List<Map<String,Object>> items = (List<Map<String, Object>>) cgReportMap.get(CgReportConstant.ITEMS);
			Map queryparams =  new LinkedHashMap<String,Object>();
			for(Map<String,Object> item:items){
				String isQuery = (String) item.get(CgReportConstant.ITEM_ISQUERY);
				if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
					//step.2 装载查询条件
					CgReportQueryParamUtil.loadQueryParams(request, item, queryparams);
				}
			}
			*/
			//step.3 进行查询返回结果
			List<Map<String, Object>> result= dynamicReportService.dataExport(request);
			
			response.setContentType("application/vnd.ms-excel");
			OutputStream fOut = null;
			try {

				//step.4 根据浏览器进行转码，使其支持中文文件名
				String browse = request.getHeader("User-Agent");  
				//String browse = BrowserUtils.checkBrowse(request);
				if ("MSIE".equalsIgnoreCase(browse.substring(0, 4))) {
					response.setHeader("content-disposition","attachment;filename="+ java.net.URLEncoder.encode(codedFileName,"UTF-8") + ".xls");
				} else {
					String newtitle = new String(codedFileName.getBytes("UTF-8"),"ISO8859-1");
					response.setHeader("content-disposition","attachment;filename=" + newtitle + ".xls");
				}
				
				//step.5 产生工作簿对象
				HSSFWorkbook workbook = null;
				workbook = dynamicReportExcelService.exportExcel(codedFileName, fieldList, result);
				fOut = response.getOutputStream();
				workbook.write(fOut);
			} catch (UnsupportedEncodingException e1) {

			} catch (Exception e) {
				
			} finally {
				try {
					fOut.flush();
					fOut.close();
				} catch (IOException e) {

				}
			}
		} else {
			System.out.println("参数错误");
		}
	}
}
