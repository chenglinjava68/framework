package com.sendi.system.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.sendi.system.util.DynamicReportConstant;
import com.sendi.system.util.DynamicReportQueryParamUtil;


@Service
public class OnlineCgReportService extends CommonService {
	
	@Autowired
	private DicDataService dicDataService;

	// 获取下拉树选项的内容
	public Map<String, Object> queryReportConfig(String configId) {
		//System.out.println("queryReportConfig  configId:"+configId);
		String sql = "select * from online_cgreport_head where CODE='"+configId+"' ";
		//System.out.println("sql:"+sql);
		Map<String, Object>  head_map = null;
		try{
			head_map = jdbcTemplate.queryForMap(sql);
		}catch (Exception e) {
			throw new RuntimeException("动态报表配置不存在!");
		}
		String cgrheader_id=(String)head_map.get("ID");
		
		String sql2 = "select * from online_cgreport_item where CGRHEAD_ID='"+cgrheader_id+"' order by order_num asc ";
		String sql3 = "select * from dctdata where dcttypeen in (select DICT_CODE from online_cgreport_item where CGRHEAD_ID='"+cgrheader_id+"' AND DICT_CODE !='')";
		System.out.println("sql2:"+sql2);
		List<Map<String, Object>> item_list = jdbcTemplate.queryForList(sql2);
		dealDefaultValue(item_list);
		
		List<Map<String, Object>> box_list = jdbcTemplate.queryForList(sql3);//下拉框
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("headers", head_map);
		result.put("config_fieldList", item_list);
		result.put("config_boxList", box_list);
		
		//需要生成chart报表的情况，把chart报表信息加载进来
		if(StringUtils.equals("Y", (String)head_map.get("ischart"))){//需要生成chart报表，使用DynamicReportChart模板
			List<Map<String, Object>> chart_fieldList = new ArrayList<Map<String, Object>>();
			//List<Map<String, Object>> chart_labelList = new ArrayList<Map<String, Object>>();
			List<String> chart_label=new ArrayList<String>();
			List<String> chart_key=new ArrayList<String>();
			
			for(Map<String,Object> m : item_list){
				if("Line".equals(m.get("chart_field")) || "COLUMN".equals(m.get("chart_field"))){
					Map<String,Object> mT = new HashMap<String,Object>();
					mT.put("name", m.get("field_name"));
					mT.put("cname", m.get("field_txt"));
					mT.put("chartType", m.get("chart_field"));
					chart_fieldList.add(mT);
				}else if("key".equals(m.get("chart_field"))){
					//result.put("chart_key", m.get("field_name"));//多个报表的字段，根据这个字段来生成一个或多个图
					chart_key.add(m.get("field_name").toString());
				}else if("group".equals(m.get("chart_field"))){
					//result.put("chart_label", m.get("field_name"));//报表横坐标字段
					
					/*
					Map<String,Object> labelmap = new HashMap<String,Object>();
					labelmap.put("field_name", m.get("field_name"));
					labelmap.put("field_txt", m.get("field_txt"));
					chart_labelList.add(labelmap);
					*/
					chart_label.add(m.get("field_name").toString());
				}
			}
			/*Map<String,Object> m = new HashMap<String,Object>();
			m.put("name", "sum");
			m.put("cname", "用户数");
			m.put("chartType", "Line");
			chart_fieldList.add(m);*/
			result.put("chart_labelList", chart_label);//报表横坐标字段
			result.put("chart_keyList", chart_key);//报表横坐标字段
			
			result.put("chart_fieldList", chart_fieldList);
			System.out.println("chart_fieldList22:"+JSONArray.fromObject(chart_fieldList).toString());
			System.out.println("result22:"+JSONArray.fromObject(result).toString());
			
			//result.put("chart_label", "starttime");//报表横坐标字段
			//result.put("chart_key", "hostInfo");//多个报表的字段，根据这个字段来生成一个或多个图
		}
		return result;
	}
	
	//替换default_value值
	private void dealDefaultValue(List<Map<String, Object>> beans) {
		for(Map<String,Object> bean:beans){
			String filedName = (String) bean.get("field_type");
			if(StringUtils.equals(filedName, "Date") || StringUtils.equals(filedName, "DateTime")){
				String str = (String)bean.get("default_value");
				if (StringUtils.isNotEmpty(str)) {
					String[] strs = str.split(",");
					Calendar cal1= Calendar.getInstance();
					cal1.add(Calendar.DATE,Integer.parseInt(strs[0]));
					SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
					String begin = sf.format(cal1.getTime());
					String end="";
					if (strs.length>1) {
						 Calendar cal2= Calendar.getInstance();
						 cal2.add(Calendar.DATE,Integer.parseInt(strs[1]));
						 end =  sf.format(cal2.getTime());
						 bean.put("default_value",begin+","+end);
					}else {
						bean.put("default_value",begin);
					}
					
					
				}
			}
		}
	}

	/**
	 * 动态报表数据查询
	 * @param configId 配置id-code
	 * @param page 分页页面
	 * @param rows 分页大小
	 * @param request 
	 * @param response
	 */
	public String dataQry(HttpServletRequest request) {
		String configId=request.getParameter("configId");
		//step.1 根据id获取该动态报表的配置参数
		Map<String,Object> cgReportMap = queryReportConfig(configId);
		
		//step.2 获取该配置的查询SQL
		Map configM = (Map) cgReportMap.get(DynamicReportConstant.MAIN);
		String querySql = (String) configM.get(DynamicReportConstant.CONFIG_SQL);
		List<Map<String,Object>> items = (List<Map<String, Object>>) cgReportMap.get(DynamicReportConstant.ITEMS);
		Map queryparams =  new LinkedHashMap<String,Object>();
		for(Map<String,Object> item:items){
			String isQuery = (String) item.get(DynamicReportConstant.ITEM_ISQUERY);
			if(DynamicReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
				//step.3 装载查询条件
				DynamicReportQueryParamUtil.loadQueryParams(request, item, queryparams);
			}
		}
		
		//String orderby=getOrderbySql(configId);
		//String sql = getFullSql(querySql.toString(),queryparams,orderby);
		String sql = getFullSql(querySql.toString(),queryparams);
		String start = StringUtils.trimToEmpty(request.getParameter("start"));
		String limit = StringUtils.trimToEmpty(request.getParameter("limit"));
		
		logger.info(sql);
		
		return this.queryDataLimit(sql.toString(), items, start, limit);
	}
	
	//动态报表趋势图数据获取
	public String queryReportChart(HttpServletRequest request){
		//String sql = "select mdn,termtype,sum(upcount) as sum1,sum(timelength) as sum2 from esb_wap_aaa group by mdn,termtype";
		
		String configId=request.getParameter("configId");
		//step.1 根据id获取该动态报表的配置参数
		Map<String,Object> cgReportMap = queryReportConfig(configId);
		
		//step.2 获取该配置的查询SQL
		Map configM = (Map) cgReportMap.get(DynamicReportConstant.MAIN);
		String querySql = (String) configM.get(DynamicReportConstant.CONFIG_SQL);
		List<Map<String,Object>> items = (List<Map<String, Object>>) cgReportMap.get(DynamicReportConstant.ITEMS);
		Map queryparams =  new LinkedHashMap<String,Object>();
		for(Map<String,Object> item:items){
			String isQuery = (String) item.get(DynamicReportConstant.ITEM_ISQUERY);
			if(DynamicReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
				//step.3 装载查询条件
				DynamicReportQueryParamUtil.loadQueryParams(request, item, queryparams);
			}
		}

		String sql = getFullSql(querySql.toString(),queryparams);
		
		logger.info(sql);
		
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
		dealDic(list,items);
		
		//将不同的分组拆分成多个Map，显示多个图
		Map<String, Object> result = new HashMap<String,Object>();
		
		//获取chart_KEY字段
		//String chartKey = cgReportMap.get("chart_key").toString();
		List<String> chart_keys=(List<String>)cgReportMap.get("chart_keyList");
		
		for(Map<String, Object> m :list){
			String key="";
			for(String chart_key:chart_keys){
				key+=m.get(chart_key)+"-";
			}
			
			key=key.length()>0?key.substring(0, key.length()-1):key;
				if(result.get(key)==null){
					Map<String, Object> temp = new HashMap<String, Object>();
					temp.put("chart_key", key);
					temp.put("list", new ArrayList<Map<String,Object>>());
					result.put(key, temp);
				}
				((List<Map<String,Object>>)((Map<String, Object>)result.get(key)).get("list")).add(m);	
			
		}
		
		return JSONArray.fromObject(result.values()).toString();
		
		//return "[{hostInfo:'20140911',list:[{'actiontime':'20140911','duration':'488924.71','durationrate':'9.54','homecity':'深圳','hour':'0-24','link':'3122.69','linkrate':'62.41','order_num':1,'users':'51238'},{'actiontime':'20140911','duration':'219853.70','durationrate':'9.25','homecity':'广州','hour':'0-24','link':'2155.98','linkrate':'92.84','order_num':11,'users':'23780'},{'actiontime':'20140911','duration':'20705.74','durationrate':'8.48','homecity':'东莞','hour':'0-24','link':'182.70','linkrate':'76.61','order_num':12,'users':'2442'},{'actiontime':'20140911','duration':'34986.63','durationrate':'8.07','homecity':'佛山','hour':'0-24','link':'189.69','linkrate':'44.80','order_num':13,'users':'4336'},{'actiontime':'20140911','duration':'549.75','durationrate':'10.00','homecity':'中山','hour':'0-24','link':'7.67','linkrate':'142.77','order_num':14,'users':'55'},{'actiontime':'20140911','duration':'959.03','durationrate':'11.70','homecity':'惠州','hour':'0-24','link':'15.97','linkrate':'199.48','order_num':15,'users':'82'},{'actiontime':'20140911','duration':'172.02','durationrate':'12.29','homecity':'江门','hour':'0-24','link':'0.63','linkrate':'46.21','order_num':17,'users':'14'},{'actiontime':'20140911','duration':'412.29','durationrate':'11.78','homecity':'珠海','hour':'0-24','link':'1.94','linkrate':'56.88','order_num':18,'users':'35'},{'actiontime':'20140911','duration':'13.25','durationrate':'6.63','homecity':'湛江','hour':'0-24','link':'0.84','linkrate':'429.61','order_num':20,'users':'2'},{'actiontime':'20140911','duration':'121.78','durationrate':'11.07','homecity':'潮州','hour':'0-24','link':'0.18','linkrate':'16.38','order_num':24,'users':'11'},{'actiontime':'20140911','duration':'63.49','durationrate':'10.58','homecity':'河源','hour':'0-24','link':'0.14','linkrate':'23.86','order_num':25,'users':'6'},{'actiontime':'20140911','duration':'16.50','durationrate':'16.50','homecity':'汕尾','hour':'0-24','link':'0.15','linkrate':'153.75','order_num':26,'users':'1'},{'actiontime':'20140911','duration':'113.73','durationrate':'9.48','homecity':'梅州','hour':'0-24','link':'1.79','linkrate':'152.57','order_num':27,'users':'12'},{'actiontime':'20140911','duration':'11.36','durationrate':'11.36','homecity':'韶关','hour':'0-24','link':'0.01','linkrate':'6.13','order_num':28,'users':'1'},{'actiontime':'20140911','duration':'247.61','durationrate':'17.69','homecity':'阳江','hour':'0-24','link':'0.82','linkrate':'59.82','order_num':29,'users':'14'},{'actiontime':'20140911','duration':'10632.92','durationrate':'10.84','homecity':'未知','hour':'0-24','link':'5393.26','linkrate':'5629.66','order_num':31,'users':'981'}]}]";
	}
	
	
	//这里类似于commonService里面的getDataLimit方法，因为这里要处理字典翻译及替换值
	//因为在这里重写一个方法
	private String queryDataLimit(String sql,List<Map<String,Object>> items, String start,String limit){
		String dataStr = "";
		String countSQL = "select count(*) from ("+sql+") t";
		String dataSQL = sql + " limit "+(StringUtils.isBlank(start)?0:start)+","+(StringUtils.isBlank(limit)?15:limit) ;
		List<Map<String,Object>> datasList = jdbcTemplate.queryForList(dataSQL);
		HashMap dataMap = new HashMap();
		dataMap.put("totalCount",jdbcTemplate.queryForObject(countSQL, Integer.class));
		
		//1处理字典
		dealDic(datasList,items);
		//2处理替换值
		dealReplace(datasList,items);
		
		dataMap.put("datas",datasList);
		JSONObject jsons = JSONObject.fromObject(dataMap);
		dataStr = jsons.toString();
		return dataStr;
	}
	
	private void dealDic(List<Map<String, Object>> result,
			List<Map<String,Object>> beans) {
		for(Map<String,Object> bean:beans){
			String dict_code = (String) bean.get(DynamicReportConstant.ITEM_DICCODE);
			if(StringUtils.isEmpty(dict_code)){
				//不需要处理字典
				continue;
			}else{
				List<Map<String, Object>> dicDatas = dicDataService.queryDic(dict_code);
				for(Map r:result){
					String value = String.valueOf(r.get(bean.get(DynamicReportConstant.ITEM_FIELDNAME)));
					for(Map m:dicDatas){
						String typecode = String.valueOf(m.get("dic_value"));
						String typename = String.valueOf(m.get("dic_key"));
						if(value.equalsIgnoreCase(typecode)){
							r.put(bean.get(DynamicReportConstant.ITEM_FIELDNAME),typename);
						}
					}
				}
			}
		}
	}
	
	private void dealReplace(List<Map<String, Object>> result,
			List<Map<String,Object>> beans){
		for(Map<String,Object> bean:beans){
			try{
				//获取取值表达式
				String replace = (String) bean.get(DynamicReportConstant.ITEM_REPLACE);
				if(StringUtils.isEmpty(replace)){
					continue;
				}
				String[] groups = replace.split(",");
				for(String g:groups){
					String[] items = g.split("_");
					String v = items[0];//逻辑判断值
					String txt = items[1];//要转换的文本
					for(Map r:result){
						String value = String.valueOf(r.get(bean.get(DynamicReportConstant.ITEM_FIELDNAME)));
						if(value.equalsIgnoreCase(v)){
							r.put(bean.get(DynamicReportConstant.ITEM_FIELDNAME),txt);
						}
					}
				}
			}catch (Exception e) {
				//这里出现异常原因是因为取值表达式不正确
				e.printStackTrace();
				throw new RuntimeException("取值表达式不正确");
			}
		}
	}
	
	/**
	 * 动态报表数据查询
	 * @param configId 配置id-code
	 * @param request 
	 * @param response
	 */
	public List<Map<String,Object>> dataExport(HttpServletRequest request) {
		String configId=request.getParameter("configId");
		//step.1 根据id获取该动态报表的配置参数
		Map<String,Object> cgReportMap = queryReportConfig(configId);
		
		//step.2 获取该配置的查询SQL
		Map configM = (Map) cgReportMap.get(DynamicReportConstant.MAIN);
		String querySql = (String) configM.get(DynamicReportConstant.CONFIG_SQL);
		List<Map<String,Object>> items = (List<Map<String, Object>>) cgReportMap.get(DynamicReportConstant.ITEMS);
		Map queryparams =  new LinkedHashMap<String,Object>();
		for(Map<String,Object> item:items){
			String isQuery = (String) item.get(DynamicReportConstant.ITEM_ISQUERY);
			if(DynamicReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
				//step.3 装载查询条件
				DynamicReportQueryParamUtil.loadQueryParams(request, item, queryparams);
			}
		}
		String sql = getFullSql(querySql.toString(),queryparams);
		
		List<Map<String,Object>> datasList = jdbcTemplate.queryForList(sql);
		//1处理字典
		dealDic(datasList,items);
		//2处理替换值
		dealReplace(datasList,items);
		
		return datasList;
	}
	
	/*
	 * 获取拼装order by 语句
	 */
	private String getOrderbySql(String configId){
		//start 排序
		String sql1 = "select * from online_cgreport_head where CODE='"+configId+"' ";
		//System.out.println("sql:"+sql);
		Map<String, Object>  head_map = null;
		try{
			head_map = jdbcTemplate.queryForMap(sql1);
		}catch (Exception e) {
			throw new RuntimeException("动态报表配置不存在!");
		}
		String cgrheader_id=(String)head_map.get("ID");
		StringBuffer orderby=new StringBuffer();
		String sql2 = "select * from online_cgreport_item where CGRHEAD_ID='"+cgrheader_id+"' and IS_SHOW='Y' order by order_num ";
		List<Map<String, Object>> item_list = jdbcTemplate.queryForList(sql2);
		for(int i=0;i<item_list.size();i++){
			Map<String,Object> map=item_list.get(i);
			orderby.append(map.get("FIELD_NAME")+" ,");
		}
		if(orderby.length()>0){
			orderby.deleteCharAt(orderby.length()-1);
		}
		orderby.insert(0, " order by ");
		//System.out.println("orderby:"+orderby.toString());
		//end 排序
		return orderby.toString();
	}
	
	/**
	 * 获取拼装查询条件之后的sql
	 * @param sql
	 * @param params
	 * @return
	 */
	private String getFullSql(String sql,Map params,String orderby){
		StringBuilder sqlB =  new StringBuilder();
		sqlB.append("SELECT t.* FROM ( ");
		sqlB.append(sql+" ");
		sqlB.append(") t ");
		if (params.size() >= 1) {
			sqlB.append("WHERE 1=1  ");
			Iterator it = params.keySet().iterator();
			while (it.hasNext()) {
				String key = String.valueOf(it.next());
				String value = String.valueOf(params.get(key));
				if (!StringUtils.isEmpty(value) && !"null".equals(value)) {
						sqlB.append(" AND ");
						sqlB.append(" " + key +  value );
				}
			}
		}
		sqlB.append(orderby);
		return sqlB.toString();
	}
	private String getFullSql(String sql,Map params){
		return getFullSql(sql,params,"");
	}
	
}
