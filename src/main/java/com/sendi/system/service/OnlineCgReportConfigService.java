package com.sendi.system.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sendi.system.constants.Globals;
import com.sendi.system.entity.OnlineCgReportHead;
import com.sendi.system.entity.OnlineCgReportItem;
import com.sendi.system.util.common.FreemarkerHelper;

@SuppressWarnings("unchecked")
@Service
public class OnlineCgReportConfigService extends CommonService<OnlineCgReportHead> {

	public List<OnlineCgReportHead> queryConfigedReport(HttpServletRequest request) {
		String coding = request.getParameter("coding");
		String name = request.getParameter("name");
		String sql = request.getParameter("sql");
		String description = request.getParameter("description");
		String ischart = request.getParameter("ischart");
		StringBuffer query_sql = new StringBuffer("select ID,CGR_SQL,CODE,CONTENT,NAME,ISCHART from online_cgreport_head where 1=1");
		if (coding != null && !coding.trim().equals("")) {
			query_sql.append(" and CODE like '%" + coding + "%'");
		}
		if (name != null && !name.trim().equals("")) {
			query_sql.append(" and NAME like '%" + name + "%'");
		}
		if (sql != null && !sql.trim().equals("")) {
			query_sql.append(" and CGR_SQL like '%" + sql + "%'");
		}
		if (description != null && !description.trim().equals("")) {
			query_sql.append(" and CONTENT like '%" + description + "%'");
		}
		if (ischart != null && !ischart.trim().equals("")) {
			query_sql.append(" and ISCHART='"+ischart+"'");
		}
		System.out.println(query_sql);
		List<OnlineCgReportHead> beanList = new ArrayList<OnlineCgReportHead>();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			rs = stat.executeQuery(query_sql.toString());
			while (rs.next()) {
				OnlineCgReportHead bean = new OnlineCgReportHead();
				bean.setId(rs.getString("ID"));
				bean.setCoding(rs.getString("CODE"));
				bean.setName(rs.getString("NAME"));
				bean.setSql(rs.getString("CGR_SQL"));
				bean.setDescription(rs.getString("CONTENT"));
				bean.setIschart(rs.getString("ISCHART"));
				beanList.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, stat, rs);
		}

		return beanList;
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

	public List<OnlineCgReportItem> analyzSql(String crgSql) throws Exception {
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		Map<String, String> typeMap = new HashMap<String, String>();
		typeMap.put("INT", "Integer");
		typeMap.put("VARCHAR", "String");
		typeMap.put("DATE", "Date");
		typeMap.put("BIGINT", "Long");
		try {
			conn = getConnection();
			stat = conn.createStatement();
			rs = stat.executeQuery(crgSql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();
			List<OnlineCgReportItem> beanList = new ArrayList<OnlineCgReportItem>();
			for (int i = 1; i <= count; i++) {
				OnlineCgReportItem bean = new OnlineCgReportItem();
				bean.setFieldName(rsmd.getColumnName(i));
				bean.setSort(i);
				bean.setFieldText(rsmd.getColumnName(i));
				String fieldType = typeMap.get(rsmd.getColumnTypeName(i));
				if (fieldType == null) {
					fieldType = "String";
				}
				bean.setFieldType(fieldType);
				bean.setFieldWidth(100);
				bean.setIsShow("Y");
				bean.setShowHref("");
				bean.setQueryModel("single");
				bean.setExpression("");
				bean.setDctCode("");
				bean.setIsQuery("Y");
				bean.setDefaultValue("");
				beanList.add(bean);
			}
			return beanList;
		} finally {
			close(conn, stat, rs);
		}
	}

	@Transactional
	public void saveItems(HttpServletRequest request) {

		// insert head
		String item_coding = request.getParameter("item_coding");
		String item_name = request.getParameter("item_name");
		String item_sql = request.getParameter("item_sql");
		String item_description = request.getParameter("item_description");
		String item_ischart = request.getParameter("item_ischart");
		JSONArray jArray = JSONArray.fromObject(request.getParameter("item_array"));
		String headKey = UUID.randomUUID().toString().replaceAll("-", "");
		jdbcTemplate.update("insert into online_cgreport_head(ID,CGR_SQL,CODE,CONTENT,NAME,ISCHART) values(?,?,?,?,?,?)", 
				headKey,item_sql, item_coding, item_description, item_name,item_ischart);

		// insert items
		String sql = "insert into online_cgreport_item" 
					+ "(ID,S_FLAG,S_MODE,CGRHEAD_ID,DICT_CODE,FIELD_HREF,FIELD_NAME,FIELD_TXT,FIELD_TYPE,FIELD_WIDTH,IS_SHOW,ORDER_NUM,REPLACE_VA,CHART_FIELD,DEFAULT_VALUE)" 
					+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		List<Object[]> argList = new ArrayList<Object[]>();
		Iterator<JSONObject> iterator = jArray.iterator();
		while (iterator.hasNext()) {
			JSONObject jo = iterator.next();
			Object[] objArray = new Object[] {UUID.randomUUID().toString().replaceAll("-", ""),
												  jo.get("isQuery"), 
												  jo.get("queryModel"), 
												  headKey, 
												  jo.get("dctCode"), 
												  jo.get("showHref"), 
												  jo.get("fieldName"), 
												  jo.get("fieldText"), 
												  jo.get("fieldType"), 
												  jo.get("fieldWidth"), 
												  jo.get("isShow"), 
												  jo.get("sort"), 
												  jo.get("expression"),
												  jo.get("chartField"),
												  jo.get("defaultValue")
											};
			argList.add(objArray);
		}
		jdbcTemplate.batchUpdate(sql, argList);
	}

	public List<OnlineCgReportItem> queryItemsByHeadId(String head_id) {
		List<Map<String, Object>> resultList = jdbcTemplate.queryForList("select * from online_cgreport_item where CGRHEAD_ID=?", head_id);
		List<OnlineCgReportItem> beanList = new ArrayList<OnlineCgReportItem>();
		for (Map<String, Object> map : resultList) {
			OnlineCgReportItem bean = new OnlineCgReportItem();
			bean.setFieldName(String.valueOf(map.get("FIELD_NAME")));
			bean.setSort(Integer.valueOf(String.valueOf(map.get("ORDER_NUM"))));
			bean.setFieldText(String.valueOf(map.get("FIELD_TXT")));
			bean.setFieldType(String.valueOf(map.get("FIELD_TYPE")));
			bean.setFieldWidth(Integer.valueOf(String.valueOf(map.get("FIELD_WIDTH"))));
			bean.setIsShow(String.valueOf(map.get("IS_SHOW")));
			bean.setShowHref(String.valueOf(map.get("FIELD_HREF")));
			bean.setQueryModel(String.valueOf(map.get("S_MODE")));
			bean.setExpression(String.valueOf(map.get("REPLACE_VA")));
			bean.setDctCode(String.valueOf(map.get("DICT_CODE")));
			bean.setIsQuery(String.valueOf(map.get("S_FLAG")));
			bean.setChartField(String.valueOf(map.get("CHART_FIELD")));
			bean.setDefaultValue(String.valueOf(map.get("DEFAULT_VALUE")));
			beanList.add(bean);
		}
		return beanList;
	}

	
	public void updateReportConfig(HttpServletRequest request) {
		// insert head
		String head_id = request.getParameter("head_id");
		String item_coding = request.getParameter("item_coding");
		String item_name = request.getParameter("item_name");
		String item_sql = request.getParameter("item_sql");
		String item_description = request.getParameter("item_description");
		String item_ischart = request.getParameter("item_ischart");
		System.out.println("ischart : "+item_ischart);
		JSONArray jArray = JSONArray.fromObject(request.getParameter("item_array"));
		jdbcTemplate.update("update online_cgreport_head set CGR_SQL=?,CODE=?,CONTENT=?,NAME=?,ISCHART=? where ID=?",item_sql,item_coding,item_description,item_name,item_ischart,head_id);

		// insert items
		jdbcTemplate.update("delete from online_cgreport_item where CGRHEAD_ID=?", head_id);
		String sql = "insert into online_cgreport_item" 
					+ "(ID,S_FLAG,S_MODE,CGRHEAD_ID,DICT_CODE,FIELD_HREF,FIELD_NAME,FIELD_TXT,FIELD_TYPE,FIELD_WIDTH,IS_SHOW,ORDER_NUM,REPLACE_VA,CHART_FIELD,DEFAULT_VALUE)" 
					+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		List<Object[]> argList = new ArrayList<Object[]>();
		Iterator<JSONObject> iterator = jArray.iterator();
		while (iterator.hasNext()) {
			JSONObject jo = iterator.next();
			Object[] objArray = new Object[] {UUID.randomUUID().toString().replaceAll("-", ""),
												  jo.get("isQuery"), 
												  jo.get("queryModel"), 
												  head_id, 
												  jo.get("dctCode"), 
												  jo.get("showHref"), 
												  jo.get("fieldName"), 
												  jo.get("fieldText"), 
												  jo.get("fieldType"), 
												  jo.get("fieldWidth"), 
												  jo.get("isShow"), 
												  jo.get("sort"), 
												  jo.get("expression"),
												  jo.get("chartField"),
												  jo.get("defaultValue")
											};
			argList.add(objArray);
		}
		jdbcTemplate.batchUpdate(sql, argList);
	}

	public void deleteJformHeads(String head_id) {
		jdbcTemplate.update("delete from online_cgreport_head where ID in ("+head_id+")");
		jdbcTemplate.update("delete from online_cgreport_item where CGRHEAD_ID in ("+head_id+")");
	}

	public String checkHeadCodeUsed(String coding, String currentCoding,String currentAction) {
		if(coding!=null && !coding.equals("") && coding.equals(currentCoding) && "update".equals(currentAction)){
			return "可用";
		}
		List<Map<String, Object>> list = jdbcTemplate.queryForList("select id from online_cgreport_head where CODE=?", coding);
		return list.size()>0?"不可用":"可用";
	}

	public String createReportRelativeFilesZip(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String headId = URLDecoder.decode(request.getParameter("configid"), "utf-8");
		String classnamePrex = URLDecoder.decode(request.getParameter("classnamePrex"), "utf-8");
		classnamePrex = classnamePrex.substring(0, 1).toLowerCase()+classnamePrex.substring(1);  //首字母小写
		String firstUpClassnamePrex = classnamePrex.substring(0, 1).toUpperCase()+classnamePrex.substring(1);
		String jsname = URLDecoder.decode(request.getParameter("jsname"), "utf-8");
		String savePath = request.getSession().getServletContext().getRealPath(File.separator+"page"+File.separator+"dynamicReport"+File.separator+"reportfiles");

		String timestamp = String.valueOf(new Date().getTime());
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		String path = request.getContextPath();

		//创建目录
		String rootPath = savePath+File.separator+timestamp+File.separator+classnamePrex;
		createDirectory(rootPath+File.separator+classnamePrex);
		createDirectory(rootPath+File.separator+classnamePrex+File.separator+"js");
		createDirectory(rootPath+File.separator+"web"+File.separator+classnamePrex);
		createDirectory(rootPath+File.separator+"service"+File.separator+classnamePrex);
		
		
		//生成jsp文件
		Map<String,Object> jspFtlMap = new HashMap<String, Object>();
		jspFtlMap.put("classnamePrex", classnamePrex);
		jspFtlMap.put("jsname", jsname);
		jspFtlMap.put("contextRootPath", request.getContextPath());
		jspFtlMap.put("fullpath", request.getScheme()+"://"+request.getServerName()+":"+Globals.Port+path);
		String jspFtlString = viewEngine.parseTemplate(
				"/com/sendi/znwg/web/dynamicReport/templates/jsp.ftl",
				jspFtlMap);
		File directory = new File(rootPath);
		if(!directory.exists()){
			directory.mkdirs();
		}
		System.out.println("Current RelativeFiles save path is "+rootPath);
		
		writeStringToFile(new File(rootPath+File.separator+classnamePrex+File.separator+jsname+".jsp"), jspFtlString);
		
		//生成js文件
		String sql = "select * from online_cgreport_head where ID='"+headId+"' ";
		Map<String, Object> head_map = jdbcTemplate.queryForMap(sql);
		
		String sql2 = "select * from online_cgreport_item where CGRHEAD_ID='"+headId+"' ";
		String sql3 = "select * from dctdata where dcttypeen in (select DICT_CODE from online_cgreport_item where CGRHEAD_ID='"+headId+"' AND DICT_CODE !='')";
		
		List<Map<String, Object>> item_list = jdbcTemplate.queryForList(sql2);
		List<Map<String, Object>> box_list = jdbcTemplate.queryForList(sql3);//下拉框
		
		Map<String, Object> jsFtlMap = new HashMap<String, Object>();
		jsFtlMap.put("headers", head_map);
		jsFtlMap.put("config_fieldList", item_list);
		jsFtlMap.put("config_boxList", box_list);
		String jsFtlString = viewEngine.parseTemplate("/com/sendi/znwg/web/dynamicReport/templates/js.ftl", jsFtlMap);
		writeStringToFile(new File(rootPath+File.separator+classnamePrex+File.separator+"js"+File.separator+jsname+".js"), jsFtlString);
		
		
		//生成Controller文件
		Map<String,Object> controllerFtlMap = new HashMap<String, Object>();
		controllerFtlMap.put("classnamePrex", classnamePrex);
		String controllerFtlString = viewEngine.parseTemplate("/com/sendi/znwg/web/dynamicReport/templates/controller.ftl", controllerFtlMap);
		writeStringToFile(new File(rootPath+File.separator+"web"+File.separator+classnamePrex+File.separator+firstUpClassnamePrex+"Controller.java"), controllerFtlString);
		
		//生成Service文件
		String serviceFtlString = viewEngine.parseTemplate("/com/sendi/znwg/web/dynamicReport/templates/service.ftl", controllerFtlMap);
		writeStringToFile(new File(rootPath+File.separator+"service"+File.separator+classnamePrex+File.separator+firstUpClassnamePrex+"Service.java"), serviceFtlString);
		
		
		String zipPathName = savePath+File.separator+timestamp+File.separator+classnamePrex+".zip";
//		ZipCompressorByAnt.compress(zipPathName, rootPath);
		
		InputStream is = new FileInputStream(zipPathName);
		String filename = new String((classnamePrex + ".zip").getBytes("gb2312"), "ISO-8859-1");
		response.setHeader("Content-disposition", "attachment;filename=" + filename);
		OutputStream os = response.getOutputStream();
		byte[] buf = new byte[1024];
		int len = 0;
		while((len=is.read(buf))!=-1){
			os.write(buf, 0, len);
		}
		os.flush();
		is.close();
		os.close();
		
		delDirectory(savePath);
		return zipPathName;
	}
	
	private void createDirectory(String dPath){
		File file = new File(dPath);
		if(!file.exists()){
			file.mkdirs();
		}
	}
	private void writeStringToFile(File file,String ftlString) throws Exception{
		PrintWriter ps = new PrintWriter(new OutputStreamWriter(new FileOutputStream(file), "utf-8"));
		ps.println(ftlString);
		if(ps!=null){
			ps.close();
		}
	}

	//删除文件夹
    private void delDirectory(String filepath){
    	 File f = new File(filepath);//定义文件路径         
    	 if(f.exists() && f.isDirectory()){
    		 if(f.listFiles().length==0){//若目录下没有文件则直接删除  
                 f.delete();  
             }else{
            	 File delFile[]=f.listFiles();  
                 int i =f.listFiles().length;  
                 for(int j=0;j<i;j++){  
                	 if(delFile[j].isDirectory()){  
                		 delDirectory(delFile[j].getAbsolutePath());//递归调用del方法并取得子目录路径  
                     }
                	 delFile[j].delete();
                 }
             }
    	 }
    }

	public OnlineCgReportHead getHeadById(String configId) {
		System.out.println("jdbcTemplate: " +jdbcTemplate);
		Map<String, Object> map = jdbcTemplate.queryForMap("select * from online_cgreport_head where ID='"+configId+"'");
		OnlineCgReportHead head = new OnlineCgReportHead();
		head.setId(String.valueOf(map.get("ID")));
		head.setCoding(String.valueOf(map.get("CODE")));
		head.setName(String.valueOf(map.get("NAME")));
		head.setSql(String.valueOf(map.get("CGR_SQL")));
		head.setDescription(String.valueOf(map.get("CONTENT")));
		head.setIschart(String.valueOf(map.get("ISCHART")));
		return head;
	}
}
