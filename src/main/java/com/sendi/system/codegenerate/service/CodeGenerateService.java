package com.sendi.system.codegenerate.service;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sendi.system.util.ResourceUtils;
import com.sendi.system.util.common.FreemarkerHelper;

/**
 * 代码生成器
 * @author liujinghua
 */
public class CodeGenerateService {
	private String dbName ;//数据库名称
	private String path = "d:/src/";//代码生成的路径默认在d:/src目录下
	private String tableName ;//数据库表名
	private String entityName;//实体名称
	private String packageName;//包名
	private String jspLocation;//jsp文件的位置
	private List<String> searchFields ;
	
	private Logger logger  =  LoggerFactory.getLogger(getClass());

	//生成代码门面方法
	public void generate() throws Exception {
		
		logger.info("===========================代码生成开始....==============================================");
		long start = Calendar.getInstance().getTimeInMillis();
		
		//1、读取配置
		Map<String, Object> configs = loadConfigs();
		
		//、2生成实体
		generateEntityCode(configs);
		
		//3、生成service类
		generateServiceCode(configs);
		
		//4、生成controller类
		generateControllerCode(configs);
		
		//5、生成JSP页面
		generateJspFile(configs);
		
		logger.info("===========================代码生成完成，耗时"+(Calendar.getInstance().getTimeInMillis() - start) +"ms ========");
	}
	
	//1、读取配置
	public Map<String, Object> loadConfigs(){
		Map<String, Object> configs = new HashMap<String, Object>();
		
		/*configs.put("table_id", "id");
		configs.put("entityPackage", "com.sendi.tyzlk.test");
		configs.put("entityName", "Test");
		
		configs.put("ftl_description", "测试");
		configs.put("ftl_create_time", DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		
		configs.put("tableName", "t_test");
		
		List<Map<String, Object>> originalColumns = new ArrayList<Map<String, Object>>();
		Map<String, Object> column = new HashMap<String, Object>();
		column.put("fieldName", "name");
		column.put("fieldType", "java.lang.String");
		column.put("filedComment", "姓名");
		originalColumns.add(column);
		
		configs.put("originalColumns", originalColumns);*/
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			
			//包名
			configs.put("entityPackage", getPackageName());
			//实体名称
			configs.put("entityName", getEntityName());
			//实体里面的描述信息，无关紧要的东西
			configs.put("ftl_description", getTableName());
			//实体的生成时间，无关紧要的信息
			configs.put("ftl_create_time", DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			//表名，必须
			configs.put("tableName", this.getTableName());
			
			//获取备注字段中文，放在map中
			/***********************************************************************/
			Map<String,String> fieldComments = loadFieldComments();
			/***********************************************************************/
			
			/***********************************************************************/
			//获取数据连接后，读取除备注之段之外的信息，备注字段在上一步中已查询
			//读取除了ID字段之外的其他字段的一些描述信息
			conn = getConnection();
			String strSql = "select * from "+getTableName()+" where 1=2";
			pstmt = conn.prepareStatement(strSql);
			rs = pstmt.executeQuery();
			ResultSetMetaData rsd = rs.getMetaData();
			List<Map<String, Object>> originalColumns = new ArrayList<Map<String, Object>>();
			List<Map<String, String>> searchFieldList = new ArrayList<Map<String, String>>();
			int count = rsd.getColumnCount();
			for(int i=1;i<=count;i++){//循环读取列内容
				
				if(StringUtils.equalsIgnoreCase("id", rsd.getColumnName(i))) continue;//ID字段不加入
				Map<String, Object> column = new HashMap<String, Object>();
				column.put("fieldName", rsd.getColumnName(i));
				column.put("fieldType", rsd.getColumnClassName(i));
				column.put("fieldComment", fieldComments.get(rsd.getColumnName(i)));//字段中文
				column.put("nullable", rsd.isNullable(i)==1?"Y":"N");//是不是非空
				column.put("charmaxLength", ""+rsd.getColumnDisplaySize(i));//字段长度
				originalColumns.add(column);
				
				//加入相关信息到查询条件的配置数据
				//如果字段在seachFields中，还需要将字段名和中文加到searchFields的freemaker变量中，以提供给模板使用
				if(searchFields.contains(rsd.getColumnName(i))){
					Map<String,String> m = new HashMap<String,String>();
					m.put("fieldName", rsd.getColumnName(i));
					m.put("fieldComment", fieldComments.get(rsd.getColumnName(i)));
					searchFieldList.add(m);
				}
				
			}
			/***********************************************************************/
			
			//加入除了ID字段之外的其他字段的一些描述信息
			configs.put("originalColumns", originalColumns);
			
			//设置JSP文件的生成位置
			configs.put("jspLocation", this.getJspLocation());//jsp文件生成的相对位置
			
			//设置jsp列表页面的查询字段名称
			configs.put("searchFieldList", searchFieldList);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(rs!=null) rs.close();}catch (SQLException e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();}catch (SQLException e) {e.printStackTrace();}
			try {if(conn!=null) conn.close();}catch (SQLException e) {e.printStackTrace();}
		}

		return configs;
	}
	
	//生成实体
	public void generateEntityCode(Map<String, Object> configs) throws Exception{
		
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		String enetity = viewEngine.parseTemplate("/com/sendi/system/codegenerate/template/entityTemplate.ftl",configs);
		String pathPrex = getPackageName().replace(".", "/");
		FileUtils.writeStringToFile(new File( this.path  + pathPrex + "/entity/"+getEntityName()+".java"), enetity);
	}
	
	//生成Service类
	public void generateServiceCode(Map<String, Object> configs) throws Exception{
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		String service = viewEngine.parseTemplate("/com/sendi/system/codegenerate/template/serviceTemplate.ftl",configs);
		String pathPrex = getPackageName().replace(".", "/");
		FileUtils.writeStringToFile(new File( this.path + pathPrex + "/service/"+getEntityName()+"Service.java"), service);
	}
	
	//生成Controller类
	public void generateControllerCode(Map<String, Object> configs) throws Exception{
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		String service = viewEngine.parseTemplate("/com/sendi/system/codegenerate/template/controllerTemplate.ftl",configs);
		String pathPrex = getPackageName().replace(".", "/");
		FileUtils.writeStringToFile(new File( this.path + pathPrex + "/web/"+getEntityName()+"Controller.java"), service);
	}
	
	//生成JSP文件
	public void generateJspFile(Map<String, Object> configs) throws Exception{
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		String jsp = viewEngine.parseTemplate("/com/sendi/system/codegenerate/template/jspTemplate.ftl",configs);
		String jspList = viewEngine.parseTemplate("/com/sendi/system/codegenerate/template/jspListTemplate.ftl",configs);
		
		FileUtils.writeStringToFile(new File( this.path + "/jsp/"+ getJspLocation() +"/"+StringUtils.uncapitalize(getEntityName())+".jsp"), jsp);
		FileUtils.writeStringToFile(new File( this.path + "/jsp/"+ getJspLocation() +"/"+StringUtils.uncapitalize(getEntityName())+"List.jsp"), jspList);
	}
	
	//读取表字段备注信息，为空的话返回字段原类型
	private Map<String,String> loadFieldComments(){
		Map<String,String> fieldComments = new HashMap<String,String>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//读取除了ID字段之外的其他字段的一些描述信息
			conn = getConnection();
			String strSql = "select COLUMN_NAME,COLUMN_COMMENT from information_schema.columns where table_schema = '"+this.getDbName()+"' and table_name='"+getTableName()+"' ";
			pstmt = conn.prepareStatement(strSql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				//如果备注为空返回原字段名
				fieldComments.put(rs.getString("COLUMN_NAME"), StringUtils.isEmpty(rs.getString("COLUMN_COMMENT"))?rs.getString("COLUMN_NAME"):rs.getString("COLUMN_COMMENT"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(rs!=null) rs.close();}catch (SQLException e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();}catch (SQLException e) {e.printStackTrace();}
			try {if(conn!=null) conn.close();}catch (SQLException e) {e.printStackTrace();}
		}
		
		return fieldComments;
	}
	
	//获取连接
	private Connection getConnection() throws Exception{
		Class.forName(ResourceUtils.getConfigByName("datasourceA.driverClassName")).newInstance();
		String url = ResourceUtils.getConfigByName("datasourceA.url");
		String user = ResourceUtils.getConfigByName("datasourceA.username");
		String password = ResourceUtils.getConfigByName("datasourceA.password");
		Connection conn = DriverManager.getConnection(url, user, password);
		return conn;
	}
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	
	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	
	public String getJspLocation() {
		return jspLocation;
	}

	public void setJspLocation(String jspLocation) {
		this.jspLocation = jspLocation;
	}
	public String getDbName() {
		return dbName;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}
	
	public List<String> getSearchFields() {
		return searchFields;
	}

	public void setSearchFields(List<String> searchFields) {
		this.searchFields = searchFields;
	}
}
