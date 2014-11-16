package com.sendi.system.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sendi.system.entity.OnlineCgReportHead;
import com.sendi.system.entity.OnlineCgReportItem;
import com.sendi.system.service.OnlineCgReportConfigService;

@Controller
@RequestMapping("/onlineCgReportConfigController")
public class OnlineCgReportConfigController extends BaseController{
	
	@Autowired
	private OnlineCgReportConfigService service;
	
	@RequestMapping(params = "queryConfigedReport")
	public void queryConfigedReport(HttpServletRequest request,
			HttpServletResponse response){
		List<OnlineCgReportHead> list = service.queryConfigedReport(request);
		writeJSONArray(list, request, response);
	}
	
	@RequestMapping(params = "analyzSql")
	public void analyzSql(HttpServletRequest request,
			HttpServletResponse response,String crgSql){
		try {
			List<OnlineCgReportItem> list = service.analyzSql(crgSql);
			writeJSONArray(list, request, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeResponseText("{success:false,message:'SQL解析失败'}", response);
		}
	}
	
	@RequestMapping(params = "saveItems")
	public void saveItems(HttpServletRequest request,
			HttpServletResponse response){
		service.saveItems(request);
		writeResponseText("'保存成功'", response);
	}
	
	@RequestMapping(params = "showItemsByHeadId")
	public void showItemsByHeadId(HttpServletRequest request,
			HttpServletResponse response){
		List<OnlineCgReportItem> list = service.queryItemsByHeadId(request.getParameter("configId"));
		writeJSONArray(list, request, response);
	}
	
	/**
	 * 修改报表信息
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "updateReportConfig")
	public void updateReportConfig(HttpServletRequest request,
			HttpServletResponse response){
		service.updateReportConfig(request);
		writeResponseText("'修改成功'", response);
	}
	
	@RequestMapping(params = "deleteJformHead")
	public void deleteJformHead(HttpServletRequest request,
			HttpServletResponse response){
		service.deleteJformHeads(request.getParameter("ids"));
		writeResponseText("'删除成功'", response);
	}
	
	/**
	 * 检查编码是否已经存在
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "checkHeadCodeUsed")
	public void checkHeadCodeUsed(HttpServletRequest request,
			HttpServletResponse response){
		String message = service.checkHeadCodeUsed(request.getParameter("coding"),request.getParameter("currentCoding"),request.getParameter("currentAction"));
		writeResponseText("{success:true,message:'"+message+"'}", response);
	}
	
	/**
	 * 导出报表相关脚本和类文件
	 */
	@RequestMapping(params = "exportReportRelativeFiles")
	public void exportReportRelativeFiles(HttpServletRequest request,HttpServletResponse response){
		try {
			service.createReportRelativeFilesZip(request,response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据ID获取表头信息
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "getHeadById")
	public void getHeadById(HttpServletRequest request,HttpServletResponse response){
		OnlineCgReportHead head = service.getHeadById(request.getParameter("configId"));
		System.out.println("toJSONString(data) : "+toJSONString(head));
		writeResponseText(toJSONString(head), response);
	}
}
