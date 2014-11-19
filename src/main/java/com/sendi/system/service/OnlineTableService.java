package com.sendi.system.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.sendi.system.bean.Page;
import com.sendi.system.util.AuthUtils;
import com.sendi.system.util.UUIDGenerator;

@Service
public class OnlineTableService extends CommonService {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	private static final String TITLE = "title";
	private static final String TABLENAME = "tablename";
	private static final String ONLINE_HEAD = "online_head";
	private static final String FIELDNAME = "fieldname";
	private static final String FIELDTYPE = "fieldtype";
	private static final String FIELDTITLE = "fieldtitle";
	private static final String ISQUERY = "isquery";
	private static final String IS_EXACT_MATCH = "is_exact_match";
	private static final String ONLINE_ITEM = "online_item";
	private static final String SEARCHFIELD_LIST = "searchfield_list";
	private static final String DIC_CODE = "dic_code";
	private static final String LIST_ENHANCE_JS = "list_enhance_js";
	private static final String FORM_ENHANCE_JS = "form_enhance_js";
	
	@Autowired
	private DicDataService dicDataService;
	
	//读取配置数据
	//将缓存保存进andCache，并使用参数拼接，加上一个字符串(这里使用方法名称)作为缓存的key，不配置key，默认使用方法中的所有参数作为key
	//@Cacheable(value = Globals.EhCacheName,key="#paraDesc + #paraName + 'sysConfigParaQuery'")
	@Cacheable(value = "onlinecache",key="'OnlineTableService.queryConfig' + #configId")
	public Map<String, Object> queryConfig(String configId){
		logger.info("重新加载配置.....");
		if(StringUtils.isEmpty(configId)){
			throw new RuntimeException("动态报表配置加载出错...");
		}

		Map<String, Object> configs = new HashMap<String,Object>();
		//表头配置
		String sql = "select * from online_head where id='"+configId+"'";
		Map<String, Object> head_map = jdbcTemplate.queryForMap(sql);
		configs.put(ONLINE_HEAD, head_map);//
		
		//加入排序功能
		String itemSQL = "select * from online_item where headid = '"+configId+"' order by order_num";
		//itemList
		List<Map<String, Object>> item_list = jdbcTemplate.queryForList(itemSQL);
		
		//searchList
		List<Map<String, Object>> searchfield_list = new ArrayList<Map<String, Object>>();
		for(Map<String, Object> m : item_list){
			if(StringUtils.equals("Y",(String)m.get(ISQUERY))){
				searchfield_list.add(m);
			}
		}
		
		configs.put(ONLINE_ITEM, item_list);
		configs.put(SEARCHFIELD_LIST, searchfield_list);
		
		//5、
		/*******************************************
		 * 为了支持单表配置的查询按钮权限，在这里处理，权限查好后放在freemarker变量，前台根据此变量来判断用户是否有权限访问
		 * 暂时支持新增、修改、删除、查看四种以后在这里扩展
		 * 在资源管理中需要严格设置URL才有效，格式为：/configId!save,/configId!update,/configId!delete,/configId!view
		 * 如：/4028b881499c7fe301499c8101dd0002!save表示online_head表的id为4028b881499c7fe301499c8101dd0002的配置数据的新增权限URL名称
 		 *******************************************
		 */
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		Map<String, Object> buttonOperAuth = new HashMap<String, Object>();
		//新增权限
		String saveAuth = AuthUtils.auth(request.getSession(), "/"+configId+"!save") ?"Y":"N";
		//修改权限
		String updateAuth = AuthUtils.auth(request.getSession(), "/"+configId+"!update") ?"Y":"N";
		//删除权限
		String deleteAuth = AuthUtils.auth(request.getSession(), "/"+configId+"!delete") ?"Y":"N";
		String viewAuth = AuthUtils.auth(request.getSession(), "/"+configId+"!view") ?"Y":"N";
		buttonOperAuth.put("save", saveAuth);
		buttonOperAuth.put("update", updateAuth);
		buttonOperAuth.put("delete", deleteAuth);
		buttonOperAuth.put("view", viewAuth);
		configs.put("buttonOperAuth", buttonOperAuth);
		
		
		//列表和增改页面的增强JS
		String enhance_sql = "select js_location,jscontent from online_head_enhance_js where headid='"+configId+"'";
		List<Map<String, Object>> enhanceList = jdbcTemplate.queryForList(enhance_sql);
		List<String> listEnhanceList = new ArrayList<String>();
		List<String> formEnhanceList = new ArrayList<String>();
		for (Map<String, Object> map : enhanceList) {
			String js_location = String.valueOf(map.get("js_location"));
			String jscontent = String.valueOf(map.get("jscontent"));
			if("list".equals(js_location) && !StringUtils.isEmpty(jscontent)){
				listEnhanceList.add(jscontent);
			}
			if("form".equals(js_location) && !StringUtils.isEmpty(jscontent)){
				formEnhanceList.add(jscontent);
			}
		}
		configs.put(LIST_ENHANCE_JS, listEnhanceList);
		configs.put(FORM_ENHANCE_JS, formEnhanceList);
		
		return configs;
	}
	
	//查询所有
	public Page<Map<String, Object>> queryAll(Map<String, String> params,Map<String, Object> configs){
		Map<String, Object> online_head = (Map<String, Object>)configs.get(ONLINE_HEAD);
		String countsql = "select count(*) from " + online_head.get(TABLENAME)+" where 1=1";
		String sql = "select * from " + online_head.get(TABLENAME)+" where 1=1";
		
		List<Map<String, Object>> online_item = (List<Map<String, Object>>)configs.get(ONLINE_ITEM);
		//组拼查询条件
		String condition = "";
		for(Map<String,Object> m : online_item){
			if(StringUtils.equals("Y", (String)m.get(ISQUERY)) && StringUtils.isNotEmpty(params.get(m.get(FIELDNAME)))){
				if("Y".equals(m.get(IS_EXACT_MATCH))){//精确查询
					condition += " and " + m.get(FIELDNAME) + " = '" + params.get(m.get(FIELDNAME)) + "'";
				}else{//模糊查询
					condition += " and " + m.get(FIELDNAME) + " like '%" + params.get(m.get(FIELDNAME)) + "%'";
				}
			}
		}
		
		countsql += condition; 
		if(params.get("page")!=null){
			sql += condition + " limit "+(Integer.parseInt(params.get("page"))-1) * Integer.parseInt(params.get("rows")) +","+params.get("rows");//分页查询
		}
		logger.info(sql);
		int total = jdbcTemplate.queryForObject(countsql, Integer.class);
		List<Map<String, Object>> datas = jdbcTemplate.queryForList(sql);
		
		//处理字典的中文替换
		dealDic(datas , online_item);
		
		Page<Map<String, Object>> page = new Page<Map<String, Object>>();
		page.setTotal(total);
		page.setRows(datas);
		
		return page;
	}
	
	//根据ID查询
	public Map<String,Object> loadById(String id ,Map<String, Object> configs){
		Map<String, Object> online_head = (Map<String, Object>)configs.get("online_head");
		String sql = "select * from " + online_head.get("tablename") + " where id = '"+id+"'";
		Map<String,Object> data = jdbcTemplate.queryForMap(sql);
		
		logger.info(sql);
		
		return data;
	}
	
	//新增
	public void add(Map<String, String> params,Map<String, Object> configs){
		
		Map<String, Object> online_head = (Map<String, Object>)configs.get(ONLINE_HEAD);
		List<Map<String, Object>> online_item = (List<Map<String, Object>>)configs.get(ONLINE_ITEM);

		String fields = "id,";
		String values = "'"+UUIDGenerator.generate()+"',";
		for(Map<String,Object> m : online_item){
			fields += m.get(FIELDNAME)+",";
			values += "'"+params.get(m.get(FIELDNAME))+"',";
		}
		fields = StringUtils.substringBeforeLast(fields, ",");
		values = StringUtils.substringBeforeLast(values, ",");

		String sql = "insert into "+online_head.get(TABLENAME)+"("+fields+") values("+values+")";
		
		logger.info(sql);
		
		jdbcTemplate.execute(sql);
	}
	
	//更新
	public void update(Map<String, String> params , Map<String, Object> configs){
		if(StringUtils.isEmpty(params.get("id"))) throw new RuntimeException("id parameter can not be null");
		
		Map<String, Object> online_head = (Map<String, Object>)configs.get(ONLINE_HEAD);
		List<Map<String, Object>> online_item = (List<Map<String, Object>>)configs.get(ONLINE_ITEM);
		
		String sql = "update "+online_head.get(TABLENAME)+" set ";
		for(Map<String,Object> m : online_item){
			sql += m.get(FIELDNAME) + "='"+StringUtils.trimToEmpty(params.get(m.get(FIELDNAME)))+"',";
		}
		sql = StringUtils.substringBeforeLast(sql, ",");
		sql += " where id='"+params.get("id")+"'";
		
		logger.info(sql);
		
		jdbcTemplate.execute(sql);
	}
	
	//删除
	public void del(String ids,Map<String, Object> configs) {
		if(StringUtils.isEmpty(ids)) throw new RuntimeException("error: deleted record failed, id is not allowed null!");
		
		Map<String, Object> online_head = (Map<String, Object>)configs.get(ONLINE_HEAD);
		
		String sql = "";
		if(ids.contains(",")){
			sql = "DELETE FROM "+online_head.get(TABLENAME)+" WHERE id in("+ids+")";
		}else{
			sql = "DELETE FROM "+online_head.get(TABLENAME)+" WHERE id = "+ids+" ";
		}
		
		logger.info(sql);
		
		jdbcTemplate.execute(sql);
	}
	
	//处理字典
	private void dealDic(List<Map<String, Object>> datas, List<Map<String,Object>> items) {
		for(Map<String,Object> item:items){
			String dict_code = (String) item.get(DIC_CODE);
			if(StringUtils.isEmpty(dict_code) || !StringUtils.equals("combobox", (String) item.get(FIELDTYPE))){//只有combobox需要做字典处理，其他的全忽略
				//不需要处理字典
				continue;
			}else{
				List<Map<String, Object>> dicDatas = dicDataService.queryDic(dict_code);
				for(Map r:datas){
					String value = String.valueOf(r.get(item.get(FIELDNAME)));
					for(Map m:dicDatas){
						String dic_key = String.valueOf(m.get("dic_key"));
						String dic_value = String.valueOf(m.get("dic_value"));
						if(value.equalsIgnoreCase(dic_key)){
							r.put((String)item.get(FIELDNAME),dic_value);
							break;
						}
					}
				}
			}
		}
	}
}
