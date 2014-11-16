package com.sendi.system.service;

import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sendi.system.bean.Page;
import com.sendi.system.entity.OnlineHeadEnhanceJs;

/**
 * 平台软件升级Service
 * @author 邹山
 *
 */
@Service
public class OnlineHeadEnhanceJsService extends CommonService<OnlineHeadEnhanceJs>{
	
	@Autowired
	private DicDataService dicDataService;
	
	//查询所有
	public String queryAll(String headid,String js_location,String start,String limit){
			String sql = "select * from online_head_enhance_js where 1=1 ";
			
			if(!StringUtils.isEmpty(headid)){
				sql += " and headid = '"+StringUtils.trim(headid)+"'";
			}
			if(!StringUtils.isEmpty(js_location)){
				sql += " and js_location ='"+StringUtils.trim(js_location)+"'";
			}
			
			Page<Map<String,Object>> page = this.getPageData(sql, start, limit);
			
			//处理中文翻译
			dealDic(page);
			return page.formToJson();
		}
	
	//处理字典
	private void dealDic(Page<Map<String,Object>> page) {
		//issuccess , iscallback
		String[] dic_codes = new String[]{"select id as dic_key,title as dic_value from online_head&headid",
										  "tyzlk.common.jslocation&js_location"};
		
		for(String s :  dic_codes){
			String dic_code = s.split("&")[0];
			String fieldname = s.split("&")[1];
			List<Map<String, Object>> dicDatas = dicDataService.queryDic(dic_code);
			List<Map<String,Object>> list = page.getRows();	
			
			for(Map<String,Object> r : list){
				
				String value = String.valueOf(r.get(fieldname));
				
				for(Map m:dicDatas){
					String dic_key = String.valueOf(m.get("dic_key"));
					String dic_value = String.valueOf(m.get("dic_value"));
					if(value.equalsIgnoreCase(dic_key)){
						r.put(fieldname,dic_value);
						break;
					}
				}
			}
		}
	}
	
	//按ID查询
	public Map<String,Object> loadById(String id){
		String sql = "select * from online_head_enhance_js where id = '"+id+"'";
		return jdbcTemplate.queryForMap(sql);
	}
	
}
