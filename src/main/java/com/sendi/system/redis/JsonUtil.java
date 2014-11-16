package com.sendi.system.redis;

import java.util.Date;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.sendi.system.util.common.JsonDateValueProcessor;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class JsonUtil {

	public static String toJSONString(Object o){
		return JSON.toJSONString(o, 
				SerializerFeature.WriteMapNullValue,
				SerializerFeature.WriteNullStringAsEmpty,
				SerializerFeature.WriteNullNumberAsZero,
				SerializerFeature.WriteNullBooleanAsFalse,
				SerializerFeature.WriteDateUseDateFormat);
	}
	
	public static Object parseObject(String text, Class clazz){
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor());
		return JSONObject.toBean(JSONObject.fromObject(text,jsonConfig),clazz);
	}
}
