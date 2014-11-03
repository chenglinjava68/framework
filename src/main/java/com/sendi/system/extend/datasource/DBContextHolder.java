package com.sendi.system.extend.datasource;

public class DBContextHolder{
	public static final String DATA_SOURCE_A = "dataSourceA";
	public static final String DATA_SOURCE_B = "dataSourceB";
	
	private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();
	
	public static void setDBType(String dbType) {
		contextHolder.set(dbType);
	}
	
	public static String getDBType() {
		//System.out.println("==============="+contextHolder.get()+"===========================");
		return contextHolder.get();
	}
	
	public static void clearDBType() {
		contextHolder.remove();
	}
}