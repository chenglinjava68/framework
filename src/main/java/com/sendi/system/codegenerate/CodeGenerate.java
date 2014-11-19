package com.sendi.system.codegenerate;

import java.util.Arrays;
import java.util.List;

import com.sendi.system.codegenerate.service.CodeGenerateService;

/**
 * //代码生成入口
 * @author liujinghua
 */
public class CodeGenerate {
	
	private static String dbName = "framework";//数据库名称，需要指定

	public static void main(String[] args) throws Exception {
		CodeGenerateService codeGenerate = new CodeGenerateService();
		codeGenerate.setDbName(dbName);//指定数据库名称
		codeGenerate.setPath("d:/src/");//代码生成的目录，注意最后需要加斜扛结尾
		codeGenerate.setTableName("resource");//数据库表名
		codeGenerate.setEntityName("Resource");//实体名称
		codeGenerate.setPackageName("com.sendi.tyzlk");//包名前缀
		
		List<String> searchFields = Arrays.asList("name","passwrod");//必须最少指定一个字段作为查询，当然多个肯定也支持
		codeGenerate.setSearchFields(searchFields);
		
		codeGenerate.setJspLocation("page/resource");//必填,生成jsp文件的位置,不需要以斜扛开头,也不需要斜扛结尾
		
		
		codeGenerate.generate();
	}
}
