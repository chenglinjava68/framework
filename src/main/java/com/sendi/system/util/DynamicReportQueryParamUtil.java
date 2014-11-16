package com.sendi.system.util;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;

/**
 * 
 * @Title:QueryParamUtil
 * @description:动态报表查询条件处理工具
 * @author 赵俊夫
 * @date Jul 5, 2013 10:22:31 PM
 * @version V1.0
 */
public class DynamicReportQueryParamUtil
{
	/**
	 * 组装查询参数
	 * @param request 请求(查询值从此处取)
	 * @param item 动态报表字段配置
	 * @param params 参数存放
	 */
	@SuppressWarnings("unchecked")
	public static void loadQueryParams(HttpServletRequest request, Map item, Map params) {
		String filedName = (String) item.get(DynamicReportConstant.ITEM_FIELDNAME);
		String queryMode = (String) item.get(DynamicReportConstant.ITEM_QUERYMODE);
		String filedType = (String) item.get(DynamicReportConstant.ITEM_FIELDTYPE);
		
		if("single".equals(queryMode)){
			//单条件组装方式
			String value =request.getParameter(filedName);
			try {
				if(StringUtils.isEmpty(value)){
					return;
				}
				String uri = request.getQueryString();
				if(uri.contains(filedName+"=")){
					String contiansChinesevalue = new String(value.getBytes("ISO-8859-1"), "UTF-8");
					value = contiansChinesevalue;
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return;
			} 
			value = applyType(filedType,value);
			
			
			if(!StringUtils.isEmpty(value)){
				if(value.contains("*")){
					//模糊查询
					value = value.replaceAll("\\*", "%");
					params.put(filedName, DynamicReportConstant.OP_LIKE+""+value+"");
				}else if( StringUtils.equals(filedType, "MultCombox") && value.contains(",") ){
					params.put(filedName, DynamicReportConstant.OP_IN+"("+value+")");
				}else {
					params.put(filedName, DynamicReportConstant.OP_EQ+""+value+"");
				}
			}
		}else if("group".equals(queryMode)){
			//范围查询组装
			String begin = request.getParameter(filedName+"_begin");
			begin= applyType(filedType,begin);
			String end = request.getParameter(filedName+"_end");
			end= applyType(filedType,end);
			if(!StringUtils.isEmpty(begin)){
				String re = DynamicReportConstant.OP_RQ+begin;
				if(!StringUtils.isEmpty(end)){
					re +=" AND "+filedName+DynamicReportConstant.OP_LQ+end;
				}
				params.put(filedName, re);
			}else if(!StringUtils.isEmpty(end)){
				String re = DynamicReportConstant.OP_LQ+end;
				params.put(filedName, re);
			}
		}
	}
	
	/**
	 * 根据字段类型 进行处理
	 * @param fieldType 字段类型
	 * @param value 值
	 * @return
	 */
	public static String applyType(String fieldType, String value) {
		if(!StringUtils.isEmpty(value)){
			String result = "";
			if("String".equalsIgnoreCase(fieldType) || "ComboBox".equalsIgnoreCase(fieldType) ){
				result = "'" +value+ "'";
			}else if("Date".equalsIgnoreCase(fieldType)){
				result = getDateFunction(value, "yyyyMMdd");
			}else if("DateTime".equalsIgnoreCase(fieldType)){
				result = "'" +value+ "'";
			}else if("Double".equalsIgnoreCase(fieldType)){
				result = value;
			}else if("Integer".equalsIgnoreCase(fieldType)){
				result = value;
			}else if("MultCombox".equalsIgnoreCase(fieldType)){
				String[] valueArray = value.split(",");
				int length = valueArray.length;
				StringBuffer systemid = new StringBuffer();
				for (int i = 0; i < length; i++) {
					systemid.append("'"+valueArray[i]+"'");
					if (length==1 || i==length-1) {
					}else {
						systemid.append(",");
					}
				}
				result = systemid.toString();
			}
			else{
				result = value;
			}
			return result;
		}else{
			return "";
		}
	}
	
	/**
	 * 跨数据库返回日期函数
	 * @param dateStr 日期值
	 * @param dateFormat 日期格式
	 * @return 日期函数
	 */
	public static String getDateFunction(String dateStr,String dateFormat){
		String dbType = "mysql";
		String dateFunction = "";
		if("mysql".equalsIgnoreCase(dbType)){
			//mysql日期函数
			dateFunction = "'"+dateStr+"'";
		}else if("oracle".equalsIgnoreCase(dbType)){
			//oracle日期函数
			dateFunction = "TO_DATE('"+dateStr+"','"+dateFormat+"')";
		}else if("sqlserver".equalsIgnoreCase(dbType)){
			//sqlserver日期函数
			dateFunction = "(CONVERT(VARCHAR,'"+dateStr+"') as DATETIME)";
		}else if("postgres".equalsIgnoreCase(dbType)){
			//postgres日期函数
			dateFunction = "'"+dateStr+"'::date ";
		}else{
			dateFunction = dateStr;
		}
		return dateFunction;
	}
}
