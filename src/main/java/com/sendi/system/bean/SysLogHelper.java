package com.sendi.system.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.stereotype.Component;

import com.sendi.system.util.UUIDGenerator;

/*
 * 系统日志记录类
 */
@Component
public class SysLogHelper {
	
	@Autowired
	public JdbcTemplate jdbcTemplate;
	
	public void Log(final String username,final String loginhost,final String resutl,final String operatetime,final String logcontent,final String operatename)
	{
		
		final String sql="insert into syslogs (id,logname,loguser,logterminal,logresult,logcontent,logtime) values(?,?,?,?,?,?,?)";
		jdbcTemplate.update(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection conn)
					throws SQLException {
				  PreparedStatement pst = conn.prepareStatement(sql);
				  pst.setString(1, UUIDGenerator.generate());//手动生成ID
				  pst.setString(2, operatename);
				  pst.setString(3, username);
				  pst.setString(4, loginhost);
				  pst.setString(5, resutl);
				  pst.setString(6, logcontent);
				  pst.setString(7, operatetime);
				return pst;
			}
		});
	}
}
