package com.sendi.system.bean;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.sendi.system.util.common.JsonDateValueProcessor;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

/**
 * 分页对像
 * @author liujinghua
 * @param <T>
 */
public class Page<T> implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer total;
	private List<T> rows;

	public Page(){}
	
	public Page(Integer total,List<T> rows){
		this.total = total;
		this.rows = rows;
	}
	
	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public String formToJson(){
		String json = "{'total':"+this.total+",'rows':"+this.toJSONArraytring(rows)+"}";
		return json;
	}
	
	public String toJSONArraytring(Object o ){
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor());
		return JSONArray.fromObject(o, jsonConfig).toString();
	}
}
