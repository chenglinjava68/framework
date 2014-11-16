package com.sendi.system.util;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import com.sendi.system.constants.Globals;

/**
 * 权限控制工具类
 * @author liujinghua
 *
 */
public class AuthUtils {

	//判断当前用户是否有相应的资源的访问权限,resourcUrl对应于syresource表的url字段
	public static boolean auth(HttpSession session,String resoureUrl){
		//2、//从session中取出登录用户的功能权限列表
		List<Map<String,Object>> userButtonOperations = (List<Map<String,Object>>)session.getAttribute(Globals.UserButtonOperations);
		
		//3、检查是否有按钮权限
		boolean authFlag = false;
		for(Map<String,Object> m : userButtonOperations){
			if(StringUtils.equals(resoureUrl, (String)m.get("url"))){
				authFlag  = true;
				break;
			}
		}
		
		return authFlag;
	}
}
