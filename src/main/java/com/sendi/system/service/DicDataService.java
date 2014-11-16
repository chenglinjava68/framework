package com.sendi.system.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.sendi.system.constants.Globals;

@Service
public class DicDataService extends CommonService{
	
	public List<Map<String,Object>> queryDictByTable(String dictField,String dictText,String dictTable){
		String sql = "select "+dictField+" as dic_key,"+dictText+" as dic_value from "+dictTable;
		return jdbcTemplate.queryForList(sql);
	}
	
	/**
	 * 查询数据字典
	 * @param diccode 字典编码
	 * @return
	 */
	//加入缓存支持，提升性能
	@Cacheable(value = Globals.DICDATA_CACHE,key="'DicDataService.queryDic' + #dic_code")
	public List<Map<String, Object>> queryDic(String dic_code) {
		//1、做特殊处理，如果dic_code里面带有select 和 from表示不查字典表，直接查数据库表
		 if(dic_code.toLowerCase().contains("select ") && dic_code.toLowerCase().contains("from")){
			 //如dic_code = select id as dic_key,platname as dic_value from tyzlk_plat_info,一定要加as别名，因为数据取出时就按dic_key和dic_value来读取的
			 return getDataList(dic_code);
		 }
		
		StringBuilder dicSql = new StringBuilder();
		dicSql.append(" SELECT dic_key,dic_value FROM dicdata WHERE dic_code = '"+dic_code+"'");
		logger.info(dicSql.toString());
		//System.out.println(dicSql);
		
		List<Map<String, Object>> dicDatas = getDataList(dicSql.toString());
		return dicDatas;
	}
	
	/**
	 * 查询数据字典,根据dic_key和dic_code模糊查询
	 * @param dic_code 字典编码
	 * @param dic_key
	 * @return
	 */
	public List<Map<String, Object>> likeQueryDic(String dic_code,String dic_key) {
		//1、做特殊处理，如果dic_code里面带有select 和 from表示不查字典表，直接查数据库表
		 if(dic_code.toLowerCase().contains("select ") && dic_code.toLowerCase().contains("from")){
			 //如dic_code = select id as dic_key,platname as dic_value from tyzlk_plat_info,一定要加as别名，因为数据取出时就按dic_key和dic_value来读取的
			 String sql = dic_code;
			 if(StringUtils.isNotEmpty(dic_key));
			 sql = "select dic_key,dic_value from ("+sql+") t where dic_key like '"+dic_key+"%'";//模糊查询
			 return getDataList(sql);
		 }
		
		StringBuilder dicSql = new StringBuilder();
		dicSql.append(" SELECT dic_key,dic_value FROM dicdata WHERE dic_code = '"+dic_code+"' and dic_key like '"+dic_key+"%'");//模糊查询
		logger.info(dicSql.toString());
		
		List<Map<String, Object>> dicDatas = getDataList(dicSql.toString());
		return dicDatas;
	}
	
}
	
	
