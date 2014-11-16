package com.sendi.system.entity;

public class OnlineCgReportItem {
	private String fieldName;  //字段名
	private Integer sort;   //排序
	private String fieldText;   //字段文本
	private String fieldType;   //字段类型
	private Integer fieldWidth ; //字段宽度
	private String defaultValue; //默认值
	private String isShow;	 //是否显示
	private String showHref;	//字段显示href
	private String queryModel;	//查询模式
	private String expression;	//取值表达式
	private String dctCode;	 //字典Code
	private String isQuery;	  //是否查询
	private String chartField; //图表类型
	
	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getFieldText() {
		return fieldText;
	}

	public void setFieldText(String fieldText) {
		this.fieldText = fieldText;
	}

	public String getFieldType() {
		return fieldType;
	}

	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String getShowHref() {
		return showHref;
	}

	public void setShowHref(String showHref) {
		this.showHref = showHref;
	}

	public String getQueryModel() {
		return queryModel;
	}

	public void setQueryModel(String queryModel) {
		this.queryModel = queryModel;
	}

	public String getExpression() {
		return expression;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}

	public String getDctCode() {
		return dctCode;
	}

	public void setDctCode(String dctCode) {
		this.dctCode = dctCode;
	}

	public String getIsQuery() {
		return isQuery;
	}

	public void setIsQuery(String isQuery) {
		this.isQuery = isQuery;
	}

	public void setFieldWidth(Integer fieldWidth) {
		this.fieldWidth = fieldWidth;
	}

	public Integer getFieldWidth() {
		return fieldWidth;
	}

	public String getChartField() {
		return chartField;
	}

	public void setChartField(String chartField) {
		this.chartField = chartField;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}
	
}
