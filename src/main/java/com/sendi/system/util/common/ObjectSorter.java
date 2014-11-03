package com.sendi.system.util.common;

 
import java.lang.reflect.Field;
import java.text.Collator;
import java.util.Comparator;
import java.util.Date;
import java.util.Locale;
 
/*
 * 针对List集合中对像的排序,通过用户传回来的sortinf:如:name,desc,得到排序信息.然后借助java中的反射方法,进行排序.
 *  * 
 */
public class ObjectSorter  implements Comparator{
 
	public ObjectSorter() {

	}

	public ObjectSorter(String sortinf) {
		this.sortinf = sortinf;
	  	String a[] = this.sortinf.split(" ");
	  	this.sorttype = a[1];
	  	this.sortfildname=a[0];
	}
 
	private String  sortfildname;//排序字段名字
	private String sorttype="asc";//排序类型
	private String sortinf = "";
	
 

	public int compare(Object o1, Object o2) {
	 
	String type=o1.getClass().getName();
	int result=0;
	if(!o2.getClass().getName().equals(type))
	{
		return result;
	}
	else
	{
		Field f=null;
		try {
			try
			{
				if(sortfildname.contains("."))
				{
					String fieldssp[]=sortfildname.split("\\.");
					f=o1.getClass().getDeclaredField(fieldssp[0]);
					f.setAccessible(true);
					Object o11=f.get(o1);
					Object o22=f.get(o2);
					f=o11.getClass().getDeclaredField(fieldssp[1]);
					f.setAccessible(true);
					o1=o11;
					o2=o22;
				}
				else
				{
					f=o1.getClass().getDeclaredField(sortfildname);
				}
				
			}
			catch (Exception e) {
				 f=o1.getClass().getSuperclass().getDeclaredField(sortfildname);
			}
		
			f.setAccessible(true);
			Object of1=f.get(o1);
			Object of2=f.get(o2);
			if(of1.getClass().getName().equals("java.util.Date")&&of2.getClass().getName().equals("java.util.Date"))
			{
				Date d1=(Date)of1;
				Date d2=(Date)of2;
				if(d1.getTime()-d2.getTime()>0)
				{
					result=1;
				}
				else if(d1.getTime()-d2.getTime()<0)
				{
					result=-1;
				}
				
				
			}
			else if(of1.getClass().getSuperclass().getName().equals("java.lang.Number")&&of2.getClass().getSuperclass().getName().equals("java.lang.Number"))
			{
				
				Number n1=(Number)of1;
				Number n2=(Number)of2;
				if(n1.doubleValue()-n2.doubleValue()>0)
				{
					result=1;
				}
				else if(n1.doubleValue()-n2.doubleValue()<0)
				{
					result=-1;
				}
				
			}
			else
			{
				Collator   c = Collator.getInstance(Locale.CHINA);
				 
				result=c.compare(String.valueOf(of1), String.valueOf(of2));
		 	}
			
			if(this.sorttype.equalsIgnoreCase("desc"))
			{
				result=result*-1;
			}
		 
			return result;
			
			
			
		} catch (SecurityException e) {
		 
			e.printStackTrace();
		} catch (NoSuchFieldException e) {
		 
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
		 
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			 
			e.printStackTrace();
		}
		
		
	}
 	 return result;
	}
 
	public static void main(String[] args) {
		 
	}

	public ObjectSorter(String sortfildname, String sorttype) {
		super();
		this.sortfildname = sortfildname;
		this.sorttype = sorttype;
	}
}
 