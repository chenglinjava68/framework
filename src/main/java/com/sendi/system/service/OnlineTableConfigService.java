package com.sendi.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sendi.system.util.UUIDGenerator;

@Service
public class OnlineTableConfigService extends CommonService {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	//查询所有
	public List<Map<String, Object>> queryAll(String tablename){
		
		String sql = "select * from online_head where 1=1";
		
		if(StringUtils.isNotEmpty(tablename)){
			sql += " and tablename like '%"+tablename+"%'";
		}
		return jdbcTemplate.queryForList(sql);
	}

	//根据configId查询所有online_item项
	public List<Map<String, Object >> queryOnlineItemAll(String configId){
		String sql = "select * from online_item where headid = '"+configId+"'";
		
		return jdbcTemplate.queryForList(sql);
	}
	
	//根据ID查询
	public Map<String,Object> loadOnlineHeadById(String id){
		Map<String,Object> data = jdbcTemplate.queryForMap("select * from online_head where id='"+id+"'");
		return data;
	}
	
	//新增或修改 
	@Transactional
	public void saveOrUpdate(String configId,String tablename,String title,String online_items){
		String id = configId;//初始化
		
		String sql = "";
		if(StringUtils.isEmpty(configId)){//新增
			id = UUIDGenerator.generate();
			sql = "insert into online_head(id,tablename,title) values ('"+id+"','"+tablename+"','"+title+"')";
		}else{
			sql = "update online_head set tablename='"+tablename+"',title='"+title+"' where id='"+id+"'";
		}
		String sql2 = "delete from online_item where headid='"+id+"'";
		
		jdbcTemplate.execute(sql);//插主表
		jdbcTemplate.execute(sql2);//先删字段表
		
		//插字段表
		JSONArray arrays = JSONArray.fromObject(online_items);
		for(int i=0;i<arrays.size();i++){
			JSONObject j = arrays.getJSONObject(i);
			String sql3 = "insert into online_item(id,headid,fieldname,fieldtitle,fieldtype,isquery,isshow,is_addupdate,is_exact_match,order_num,data_options,dic_code) ";
			sql3 += "values (" ;
			sql3 += "'"+UUIDGenerator.generate()+"',";//id
			sql3 += "'"+StringUtils.trimToEmpty(id)+"',";//headid
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("fieldname"))+"',";//fieldname
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("fieldtitle"))+"',";
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("fieldtype"))+"',";
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("isquery"))+"',";
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("isshow"))+"',";
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("is_addupdate"))+"',";
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("is_exact_match"))+"',";
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("order_num"))+"',";
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("data_options"))+"',";
			sql3 += "'"+StringUtils.trimToEmpty(j.getString("dic_code"))+"'";
			sql3 +=	")";
			jdbcTemplate.execute(sql3);
		}
	}
	
	//根据表名查询出所有的字段名称和类型，给配置页面初始化使用
	public List<Map<String,Object>> loadTableInfo(String tableName){
		String crgSql = "select * from "+tableName;
		
		List<Map<String,Object>> tableInfoMap = new ArrayList<Map<String,Object>>();
		
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			rs = stat.executeQuery(crgSql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();
			for (int i = 1; i <= count; i++) {
				
				if(StringUtils.equalsIgnoreCase("id", rsmd.getColumnName(i))) continue;//ID字段不要
				
				Map<String,Object> m =  new HashMap<String,Object>();
				m.put("fieldname", rsmd.getColumnName(i));
				tableInfoMap.add(m);
			}
		} catch (Exception e) {
			throw new RuntimeException("表名不存在");
		} finally {
			close(conn, stat, rs);
		}
		
		return tableInfoMap;
	}
	
	//删除
	@Transactional
	public void del(String ids){
		String sql = "";
		String sql2 = "";
		if(ids.contains(",")){
			sql = "delete from online_head where id in("+ids+")";
			sql2 = "delete from online_item where headid in("+ids+")";
		}else{
			sql = "delete from online_head where id = "+ids+"";
			sql2 = "delete from online_item where headid = "+ids+"";
		}
		
		jdbcTemplate.execute(sql);
		jdbcTemplate.execute(sql2);
	}
	
	private void close(Connection conn, Statement stat, ResultSet rs) {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (stat != null) {
					stat.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null) {
						rs.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {

				}
			}
		}
	}
}
