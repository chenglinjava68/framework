package com.sendi.system.util;

import org.apache.commons.lang3.StringUtils;

import net.sf.json.JSONObject;

/**
 * JSON模型
 * 用户后台向前台返回的JSON对象
 * @author liujinghua
 */
public class Json implements java.io.Serializable {

	private boolean success = true;

	private String msg = "";

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		if(StringUtils.isNotEmpty(this.msg)) {
			return msg;
		}else{
			return success ? "操作成功" : "操作失败";
		}
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getJsonStr(){
		JSONObject obj = new JSONObject();
		obj.put("success", this.isSuccess());
		obj.put("msg", this.getMsg());
		return obj.toString();
	}
	
	public static void main(String[] args) {
		Json j = new Json();
		System.out.println(j.getJsonStr());
	}

}
