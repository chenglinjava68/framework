package com.sendi.system.tag;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang3.StringUtils;

import com.sendi.system.bean.ApplicationContextHelper;
import com.sendi.system.service.DicDataService;

/**
 * 
 * 选择下拉框
 * 
 * @author: liujinghua
 * @date： 日期：20141111
 * @version 1.0
 */
public class DictSelectTag extends TagSupport {

	private static final long serialVersionUID = 1;
	private String dic_code; // 数据字典类型
	private String name ;//表单name
	private String id; // 表单ID
	private String value; // 默认值
	private String dictTable;// 自定义字典表
	private String dictField;// 自定义字典表的匹配字段-字典的编码值
	private String dictText;// 自定义字典表的显示文本-字典的显示值
	private String dictCondition;//自定义字典表的隔外过滤条件
	private String extendJson;//扩展参数
	private String style;//样式
	private String dataOptions;//属性
	private String multiple;//定义是否支持多选。
	private String editedAble;//是否可以编辑，默认支持编辑

	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}

	public int doEndTag() throws JspTagException {
		try {
			JspWriter out = this.pageContext.getOut();
			out.print(end().toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	public StringBuffer end() {
		StringBuffer sb = new StringBuffer();
		
		DicDataService dicDataService = ApplicationContextHelper.appctx.getBean(DicDataService.class);
		List<Map<String,Object>> list = null;
		if (dictTable != null) {//查自定义的数据表作为数据源
			list = dicDataService.queryDictByTable(dictField, dictText, dictTable);
		}else {
			list = dicDataService.queryDic(dic_code);
		}
		
		sb.append("<select id=\""+id+"\" class=\"easyui-combobox\" name=\""+name+"\" style=\""+style+"\" ");
		
		//是否支持编辑，默认支持编辑
		if(StringUtils.isNotEmpty(editedAble) && StringUtils.equals("false", editedAble)){
			sb.append("editable=\"false\" ");
		}
		
		//定义是否支持多选,如果标签中myltiple设置为true，则支持多选
		if(StringUtils.isNotEmpty(multiple) && StringUtils.equals("true", multiple)){
			sb.append("multiple=\"true\" ");
		}
		
		if(StringUtils.isNotEmpty(dataOptions)) {//dataOptions
			sb.append("data-options=\""+dataOptions+"\" ");	
		}
		sb.append(">");
		sb.append("<option value=\"\"></option>");
		for(Map<String,Object> m : list){
			
			String selected = StringUtils.equals(value, (String)m.get("dic_key"))?"selected=\"selected\"":"";
			sb.append("<option value=\""+m.get("dic_key")+"\" "+selected+">"+m.get("dic_value")+"</option>");
		}
		sb.append("</select>"); 

		return sb;
	}
	
	public String getDic_code() {
		return dic_code;
	}

	public void setDic_code(String dic_code) {
		this.dic_code = dic_code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getDictTable() {
		return dictTable;
	}

	public void setDictTable(String dictTable) {
		this.dictTable = dictTable;
	}

	public String getDictField() {
		return dictField;
	}

	public void setDictField(String dictField) {
		this.dictField = dictField;
	}

	public String getDictText() {
		return dictText;
	}

	public void setDictText(String dictText) {
		this.dictText = dictText;
	}

	public String getDictCondition() {
		return dictCondition;
	}

	public void setDictCondition(String dictCondition) {
		this.dictCondition = dictCondition;
	}

	public String getExtendJson() {
		return extendJson;
	}

	public void setExtendJson(String extendJson) {
		this.extendJson = extendJson;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}
	
	public String getDataOptions() {
		return dataOptions;
	}

	public void setDataOptions(String dataOptions) {
		this.dataOptions = dataOptions;
	}
	
	public String getMultiple() {
		return multiple;
	}

	public void setMultiple(String multiple) {
		this.multiple = multiple;
	}
	
	public String getEditedAble() {
		return editedAble;
	}

	public void setEditedAble(String editedAble) {
		this.editedAble = editedAble;
	}
}
