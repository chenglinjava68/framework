package com.sendi.system.util;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.BeansException;
import org.springframework.beans.FatalBeanException;
import org.springframework.util.Assert;

/**
 * 扩展spring的BeanUtils，增加拷贝属性排除null值的功能(注：String为null不考虑)
 * 
 * @author 孙宇
 * 
 */
public class BeanUtils extends org.springframework.beans.BeanUtils {

	public static void copyNotNullProperties(Object source, Object target, String[] ignoreProperties) throws BeansException {
		copyNotNullProperties(source, target, null, ignoreProperties);
	}

	public static void copyNotNullProperties(Object source, Object target, Class<?> editable) throws BeansException {
		copyNotNullProperties(source, target, editable, null);
	}

	public static void copyNotNullProperties(Object source, Object target) throws BeansException {
		copyNotNullProperties(source, target, null, null);
	}

	private static void copyNotNullProperties(Object source, Object target, Class<?> editable, String[] ignoreProperties) throws BeansException {

		Assert.notNull(source, "Source must not be null");
		Assert.notNull(target, "Target must not be null");

		Class<?> actualEditable = target.getClass();
		if (editable != null) {
			if (!editable.isInstance(target)) {
				throw new IllegalArgumentException("Target class [" + target.getClass().getName() + "] not assignable to Editable class [" + editable.getName() + "]");
			}
			actualEditable = editable;
		}
		PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
		List<String> ignoreList = (ignoreProperties != null) ? Arrays.asList(ignoreProperties) : null;

		for (PropertyDescriptor targetPd : targetPds) {
			if (targetPd.getWriteMethod() != null && (ignoreProperties == null || (!ignoreList.contains(targetPd.getName())))) {
				PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
				if (sourcePd != null && sourcePd.getReadMethod() != null) {
					try {
						Method readMethod = sourcePd.getReadMethod();
						if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
							readMethod.setAccessible(true);
						}
						Object value = readMethod.invoke(source);
						if (value != null || readMethod.getReturnType().getName().equals("java.lang.String")) {// 这里判断以下value是否为空，当然这里也能进行一些特殊要求的处理 例如绑定时格式转换等等，如果是String类型，则不需要验证是否为空
							boolean isEmpty = false;
							if (value instanceof Set) {
								Set s = (Set) value;
								if (s == null || s.isEmpty()) {
									isEmpty = true;
								}
							} else if (value instanceof Map) {
								Map m = (Map) value;
								if (m == null || m.isEmpty()) {
									isEmpty = true;
								}
							} else if (value instanceof List) {
								List l = (List) value;
								if (l == null || l.size() < 1) {
									isEmpty = true;
								}
							} else if (value instanceof Collection) {
								Collection c = (Collection) value;
								if (c == null || c.size() < 1) {
									isEmpty = true;
								}
							}
							if (!isEmpty) {
								Method writeMethod = targetPd.getWriteMethod();
								if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
									writeMethod.setAccessible(true);
								}
								writeMethod.invoke(target, value);
							}
						}
					} catch (Throwable ex) {
						throw new FatalBeanException("Could not copy properties from source to target", ex);
					}
				}
			}
		}
	}
	
	
	
	
	//相同的bean之间的复制
	public static Object copy(Object object){
		Class classType = object.getClass();//获得对象的类型
//		System.out.println("Class:" + classType.getName());
		
		//通过默认的构造函数创建一个新的对象
		Object objectCopy = null;
		try{
			objectCopy = classType.getConstructor(new Class[] {}).
				newInstance(new Object[] {});
			//获得对象的所有属性
			Field fields[] = classType.getDeclaredFields();
			
		    for(int i = 0; i < fields.length; i++) {
		    	Field field = fields[i];
		    	
		    	String fieldName = field.getName();
		    	String firstLetter = fieldName.substring(0,1).toUpperCase();
		    	//获得和属性对应的getXXX（）方法的名字
		    	String getMethodName = "get" + firstLetter + fieldName.substring(1);
		    	//获得和属性对应的setXXX()方法的名字
		    	String setMethodName = "set" + firstLetter + fieldName.substring(1);
		    	
		    	//获得和属性对应的getXXX()方法
		    	Method getMethod = classType.getMethod(getMethodName, new Class[]{});
		    	//获得和属性对应的setXXX()方法
		    	Method setMethod = classType.getMethod(setMethodName, new Class[]{field.getType()});
		    	
		    	//调用原对象的getXXX()方法
		    	Object value = getMethod.invoke(object, new Object[]{});
	//	    	System.out.println(fieldName + ":" + value);
		    	//调用复制对象的setXXX()方法
		    	setMethod.invoke(objectCopy, new Object[]{value});
		    }
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return objectCopy;
	}
	
	//不同bean之间的复制
	public static void copyDiffentBean(Object source, Object dest)throws Exception {
		//获取属性
		BeanInfo sourceBean = Introspector.getBeanInfo(source.getClass(), java.lang.Object.class);
		PropertyDescriptor[] sourceProperty = sourceBean.getPropertyDescriptors();
		
		BeanInfo destBean = Introspector.getBeanInfo(dest.getClass(), java.lang.Object.class);
		PropertyDescriptor[] destProperty = destBean.getPropertyDescriptors();
		
		try{
			for(int i=0;i<sourceProperty.length;i++){
				
				for(int j=0;j<destProperty.length;j++){
					
					if(sourceProperty[i].getName().equals(destProperty[j].getName())){
						//调用source的getter方法和dest的setter方法
						destProperty[j].getWriteMethod().invoke(dest, sourceProperty[i].getReadMethod().invoke(source));
						break;					
					}
				}
			}
		}catch(Exception e){
			throw new Exception("属性复制失败:"+e.getMessage());
		}
	}

}
