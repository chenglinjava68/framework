package com.sendi.system.redis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

@Component
public class RedisCacheBean {
    
	@Autowired
    JedisPool jedisPool;

    /**
     * 把对象放入Hash中
     */
    public void hset(String key,String field,Object o){
        Jedis jedis =jedisPool.getResource();
        jedis.hset(key,field, JsonUtil.toJSONString(o).toString());
        jedisPool.returnResource(jedis);
    }
    /**
     * 从Hash中获取对象
     */
    public String hget(String key,String field){
        Jedis jedis =jedisPool.getResource();
        String text=jedis.hget(key,field);
        jedisPool.returnResource(jedis);
        return text;
    }
    /**
     * 从Hash中获取对象,转换成制定类型
     */
    public Object hget(String key,String field,Class clazz){
        String text = hget(key, field);
        if(clazz.getName().equals("java.lang.String" )) {//如果redis中存的是字符串，直接返回，不转换成对像
        	return text;
        }
        Object result=JsonUtil.parseObject(text, clazz);
        return result;
    }
    
    /**
     * 从Hash中删除对象
     */
    public void hdel(String key,String ... field){
        Jedis jedis =jedisPool.getResource();
        Object result=jedis.hdel(key,field);
        jedisPool.returnResource(jedis);
    }
    
}