package com.sendi.system.extend.datasource;

import java.util.Map;
import org.apache.commons.dbcp.BasicDataSource;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

import com.sendi.system.bean.ApplicationContextHelper;
 
/**
 * @author liujinghua
 * @describe 实现动态数据源切换逻辑
 * 修改为从数据库读取配置方式支持
 */
public class DynamicDataSource extends AbstractRoutingDataSource {
    private Logger logger = Logger.getLogger(this.getClass());
    private Map<Object, Object> _targetDataSources;
 
    /**
     * @see org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource#determineCurrentLookupKey()
     * @describe 数据源为空或者为"datasourceA"时，自动切换至默认数据源，即在配置文件中定义的datasourceA数据源
     */
    @Override
    protected Object determineCurrentLookupKey() {
        String dataSourceName = DBContextHolder.getDBType();
        if (dataSourceName == null) {
            dataSourceName = DBContextHolder.DATA_SOURCE_A;
        } else {
            this.selectDataSource(dataSourceName);
            if (dataSourceName.equals(DBContextHolder.DATA_SOURCE_A)){
            	dataSourceName = DBContextHolder.DATA_SOURCE_A;
            }
        }
        logger.debug("--------------------> Use Datasource ： " + dataSourceName);
        return dataSourceName;
    }
 
    public void setTargetDataSources(Map<Object, Object> targetDataSources) {
        this._targetDataSources = targetDataSources;
        super.setTargetDataSources(this._targetDataSources);
        afterPropertiesSet();
    }
 
    public void addTargetDataSource(String key, BasicDataSource dataSource) {
        this._targetDataSources.put(key, dataSource);
        this.setTargetDataSources(this._targetDataSources);
    }
 
    //apache数据源,暂时只支持mysql多数据源
    public BasicDataSource createDataSource(String driverClassName, String url,
            String username, String password) {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName(driverClassName);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        dataSource.setMaxActive(20);
        dataSource.setInitialSize(0);
        dataSource.setMaxWait(60000);
        dataSource.setMaxIdle(20);
        dataSource.setMinIdle(5);
        dataSource.setRemoveAbandoned(true);
        dataSource.setRemoveAbandonedTimeout(1800);
        dataSource.setLogAbandoned(true);
        dataSource.setValidationQuery("select 1");
        dataSource.setTestOnBorrow(false);
        dataSource.setTestOnReturn(false);
        dataSource.setTestWhileIdle(true);
        dataSource.setTimeBetweenEvictionRunsMillis(60000);
        dataSource.setMinEvictableIdleTimeMillis(25200000);
        return dataSource;
    }
 
    /**
     * @param dataSourceName
     * @describe 数据源存在时不做处理，不存在时创建新的数据源链接，并将新数据链接添加至缓存
     */
    public void selectDataSource(String dataSourceName) {
        Object sid = DBContextHolder.getDBType();
        if (DBContextHolder.DATA_SOURCE_A.equals(dataSourceName)) {
            DBContextHolder.setDBType(DBContextHolder.DATA_SOURCE_A);
            return;
        }
        
        Object obj = this._targetDataSources.get(dataSourceName);
        if (obj != null && sid.equals(dataSourceName + "")) {
            return;
        } else {
            BasicDataSource dataSource = this.getDataSource(dataSourceName);
            if (null != dataSource)
                this.setDataSource(dataSourceName, dataSource);
        }
    }
 
    /**
     * @describe 查询dataSourceName对应的数据源记录
     * @param dataSourceName
     *    @return
     */
    public BasicDataSource getDataSource(String dataSourceName) {
    	BasicDataSource dataSource = null;
    	
    	try{
    		DBContextHolder.setDBType(DBContextHolder.DATA_SOURCE_A);

	        //从原始的数据库中获取数据配置
	        JdbcTemplate jdbcTemplate = ApplicationContextHelper.appctx.getBean(JdbcTemplate.class);
	        Map<String, Object> map = jdbcTemplate.queryForMap("select * from sys_datasource where ds_key = '"+dataSourceName+"'");
	        
	        if (map != null) {
	            String driverClassName = map.get("driverClassName").toString();
	            String url = map.get("url").toString();
	            String userName = map.get("username").toString();
	            String password = map.get("password").toString();
	            dataSource = this.createDataSource(driverClassName, url, userName, password);
	        }
    		
    	}catch (Exception e) {
			e.printStackTrace();
		}finally{
			 DBContextHolder.clearDBType();
		}
        
        return dataSource;
    }
 
    /**
     * @param serverId
     * @param dataSource
     */
    public void setDataSource(String dataSourceName, BasicDataSource dataSource) {
        this.addTargetDataSource(dataSourceName, dataSource);
        DBContextHolder.setDBType(dataSourceName);
    }
 
}