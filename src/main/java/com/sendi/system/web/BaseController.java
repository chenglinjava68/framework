package com.sendi.system.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.sendi.system.util.common.ObjectSorter;

/**
 * 控制器基类，所有的controller都继承此类
 * @author liujinghua
 * @date 2014-05-14 12：03
 */
public abstract class BaseController {
	 
	////公共参数的名称列表
	protected static String SESSION_USER_ID = "userid";
	protected static String SESSION_USER_NAME = "username";
	protected static String SESSION_ROLE_ID = "roleid";
	protected static String SESSION_USER_ID_TABLEKEY = "userid_tablekey";
	protected static String START = "page";
	protected static String LIMIT = "rows";
	protected static String SORT = "sort";
	protected static String DIR = "dir";
	
	protected final Logger logger  =  LoggerFactory.getLogger(getClass());

	public String getCurrentUserId(HttpSession session){
		return (String)session.getAttribute(SESSION_USER_ID);
	}
	
	public String getCurrentUserId_TableKey(HttpSession session){
		return (String)session.getAttribute(SESSION_USER_ID_TABLEKEY);
	}
	
	public String getCurrentUserName(HttpSession session){
		return (String)session.getAttribute(SESSION_USER_NAME);
	}
	
	public String getCurrentRoleId(HttpSession session){
		return (String)session.getAttribute(SESSION_ROLE_ID);
	}
 
	public void writeResponseText(String responseText,HttpServletResponse response){
		try
		{
	        response.setContentType("text/html");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().print(responseText);
		}
		catch (Exception e) {
			 e.printStackTrace();
		}
		
	}
	
	public void writeJSONArray(List array,HttpServletRequest request,HttpServletResponse response){
		
		try
		{
			
			this.sortObjectList(array,request);			
	        response.setContentType("text/html");
	        response.setCharacterEncoding("UTF-8");
	        List<Object> pagedata=new ArrayList<Object>();
	        
	        int starti = getStart(request);
	        int limiti = getLimit(request);
	        
	        //starti = starti*limiti;//easyui和extjs的传参不一样，特殊处理
	        
	        logger.info("list data size:"+array.size());
	        if((starti+limiti+1)>array.size())
	        {
	        	pagedata.addAll(array.subList(starti,array.size()));
	        }
	        else
	        {
	        	pagedata.addAll(array.subList(starti, starti+limiti));
	         
	        }
	        String jsons = toJSONArraytring(pagedata);
	       String res="{\"total\":"+array.size()+",\"rows\":"+jsons+"}";
	       
	       //logger.info(res);
	       response.getWriter().print(res);
		}
		catch (Exception e) {
			 e.printStackTrace();
		}
	 
	}
	
	public int getStart(HttpServletRequest request){
		String start = request.getParameter(START)==null?"0":request.getParameter(START);
		
		int pageSize = request.getParameter(LIMIT)==null?99999999:Integer.parseInt(request.getParameter(LIMIT));
		
		int starti=(Integer.parseInt(start)-1)==-1?0:(Integer.parseInt(start)-1)*pageSize;
		return starti;
	}
	
	public int getLimit(HttpServletRequest request){
		String limit = request.getParameter(LIMIT)==null?"99999999":request.getParameter(LIMIT);
		int limiti=Integer.parseInt(limit);
		return limiti;
	}
	
	/*
     * 对像类型的集合进行排序
     */
    public void sortObjectList(List datas,HttpServletRequest request)
    {
    	String sort = request.getParameter(this.SORT);
    	String dir = request.getParameter(DIR);
    	//数据不为空，且大小大于1才进行排序
    	if(datas!=null&&datas.size()>1&&sort!=null&&dir!=null)
    	{
    		ObjectSorter s=new ObjectSorter(sort,dir);
    		Collections.sort(datas, s);//List 数据源进行排序
    	}
    }
    
    public String toJSONString(Object o ){
    	return JSON.toJSONString(o, 
				SerializerFeature.WriteMapNullValue,
				SerializerFeature.WriteNullStringAsEmpty,
				SerializerFeature.WriteNullNumberAsZero,
				SerializerFeature.WriteNullBooleanAsFalse,
				SerializerFeature.WriteDateUseDateFormat);
    	
		/*JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor());
		return JSONObject.fromObject(o, jsonConfig).toString();*/
	}
	
	public String toJSONArraytring(Object o ){
		return JSON.toJSONString(o, 
				SerializerFeature.WriteMapNullValue,
				SerializerFeature.WriteNullStringAsEmpty,
				SerializerFeature.WriteNullNumberAsZero,
				SerializerFeature.WriteNullBooleanAsFalse,
				SerializerFeature.WriteDateUseDateFormat);
		/*JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor());
		return JSONArray.fromObject(o, jsonConfig).toString();*/
	}
	
	/**
	 * 封装request请求参数到Map里
	 * @param request
	 * @return
	 */
	protected Map<String, String> paramsToMap(HttpServletRequest request) {
		Map<String, String> params = new HashMap<String, String>();
		// 得到枚举类型的参数名称，参数名称若有重复的只能得到第一个
		Enumeration em = request.getParameterNames();
		while (em.hasMoreElements()) {
			String paramName = (String) em.nextElement();
			String paramValue = request.getParameter(paramName);
			// 形成键值对应的map
			params.put(paramName, paramValue);
		}
		return params;
	}
	
	/**
	 * 封装request请求参数到Map里，解决get请求乱码问题
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	protected Map<String, String> paramsToMap(HttpServletRequest request,String encoding) throws Exception {
		Map<String, String> params = new HashMap<String, String>();
		// 得到枚举类型的参数名称，参数名称若有重复的只能得到第一个
		Enumeration em = request.getParameterNames();
		while (em.hasMoreElements()) {
			String paramName = (String) em.nextElement();
			String paramValue = request.getParameter(paramName);
			if(!StringUtils.isEmpty(paramValue)){
				paramValue = URLDecoder.decode(paramValue, encoding);
			}
			// 形成键值对应的map
			params.put(paramName, paramValue);
		}
		return params;
	}
	
	
	/************************************************************************
	 * 以下代码不再需要，已由FileUpDwnUtil工具类的相同名称的方法替代,liujinghua 20141112
	 * ********************************************************************
	//获取上传文件的全路径
	protected String getFileFullName(String basename) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String filename = FilenameUtils.concat(DateFormatUtils.format(new Date(), "yyyyMMdd"), basename);
		String filefullname = FilenameUtils.concat(request.getSession().getServletContext().getRealPath(Globals.UPLOAD),filename);
		return filefullname;
	}
	
	//获取上传文件的全路径
	protected String getFileAbsoluteName(String subPathName) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String filefullname = FilenameUtils.concat(request.getSession().getServletContext().getRealPath(Globals.UPLOAD),subPathName);
		return filefullname;
	}************************************************************************/
	
	/*******************************************************************************************
	 * 
	 * @param response 
	 * @param subFilePath 文件存储位置后半段路径, 存在数据库里的. /20141111/test.doc
	 * @param realname 文件的真实名, NULL表示用文件的存储名
	 
	protected void writeFile(HttpServletResponse response,String subFilePath,String realname){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String filefullname = FilenameUtils.concat(request.getSession().getServletContext().getRealPath(Globals.UPLOAD),subFilePath);
		response.setContentType("application/msword;chartset=utf-8");
		InputStream is = null;
		OutputStream os = null;
		try {
			String filename = new String(realname.getBytes("gb2312"), "ISO-8859-1");
			response.setHeader("Content-disposition", "attachment;filename=" + filename);

			is = new FileInputStream(filefullname);
			os = response.getOutputStream();
			int len = 0;
			byte[] buf = new byte[1024];
			while ((len = is.read(buf)) != -1) {
				os.write(buf, 0, len);
			}
			os.flush();
			os.close();
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {
				if(is!=null){
					is.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				try {
					if(os!=null){
						os.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}***************************************************************************************************************/
}
