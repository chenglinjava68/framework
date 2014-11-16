<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		id = "";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	var grid;
	var editIndex = undefined;
	
	//保存
	var submitForm = function($dialog, $grid, $pjq) {
		if (endEditing()){
			if($('#fm').form('validate')){
				var rows = $('#dg').datagrid('getRows');
				if(rows.length == 0) {
					$pjq.messager.show({title : '警告',msg : "字段信息至少需要一项"});
					return;
				}
				var url = fullpath + '/onlineCgReportConfigController.do?saveItems';
				if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
					var url = fullpath + '/onlineCgReportConfigController.do?updateReportConfig';
				}
				$.post(
						url, {
						head_id : $('input:hidden[name="id"]').val(),
						item_coding : $(':input[name="coding"]').val(),
						item_description : $(':input[name="description"]').val(),
						item_sql : $(':input[name="sql"]').val(),
						item_name : $(':input[name="name"]').val(),
						item_ischart : $(':input[name="ischart"]').val(),
						item_array : JSON.stringify(rows)	
					}, 
					function(result) {
						if (!result.success) {
							$pjq.messager.show({title : '警告',msg : result.msg});
						} else {
							$pjq.messager.show({title : '消息窗口',msg : result.msg});
							$('#dg').datagrid('acceptChanges');//清空已改变的
							$dialog.dialog('close');
							$grid.datagrid('reload');
						}
				}, 'json');
			}
		}
	};
	
	//判断当前的编辑行是否通过校验
	function endEditing(){
		if (editIndex == undefined){return true}
		if ($('#dg').datagrid('validateRow', editIndex)){
			$('#dg').datagrid('endEdit', editIndex);//结速编辑行
			editIndex = undefined;//将index清空
			return true;
		}else{
			return false;
		}
	}
	
	//新增
	var addFun = function() {
		if (endEditing()){
			editIndex = 0;
			grid.datagrid('insertRow',{index: editIndex,row: {
				id : '',
				fieldName : '',
				sort : editIndex+1,
				fieldText : '',
				fieldType : 'String',
				fieldWidth : '40',
				isShow : 'Y',
				showHref : '',
				queryModel : 'single',
				expression : '',
				dctCode : '',
				isQuery : 'Y',
				defaultValue : '',
			}});
			$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
		}
	};
	
	//行选中
	var onClickRow = function(rowIndex, rowData) {
		if (editIndex != rowIndex){
			if (endEditing()){
				$('#dg').datagrid('selectRow', rowIndex).datagrid('beginEdit', rowIndex);
				editIndex = rowIndex;
			}else {
				$('#dg').datagrid('selectRow', editIndex);
			}
		}
	};
	
	//删除
	var delFun = function() {
		if (editIndex == undefined){return}
		$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
		editIndex = undefined;
	};
	
	//SQL解析
	var analyzSql = function(){
		$.post(fullpath + '/onlineCgReportConfigController.do?analyzSql', {
					crgSql : $('textarea[name="sql"]').val()	
				}, 
				function(result) {
					if (!result.rows) {
						$pjq.messager.show({title : '警告',msg : result.msg});
					} else {
						var rows = $('#dg').datagrid('getRows');//先将原先的所有行全删除
						while(rows.length>0){
							$('#dg').datagrid('deleteRow',0);
							rows = $('#dg').datagrid('getRows');//最后一行也要清掉
						}
						
						var datas = result.rows;
						
						for(var i=0;i<datas.length;i++){//然后根据数据库表的字段，重新初始化
							var data = datas[i];
							if (endEditing()){
								editIndex = 0;
								grid.datagrid('insertRow',{index: editIndex,row: {
									id : data.id,
									fieldName : data.fieldName,
									sort : data.sort,
									fieldText : data.fieldText,
									fieldType : data.fieldType,
									fieldWidth : data.fieldWidth,
									isShow : data.isShow,
									showHref : data.showHref,
									queryModel : data.queryModel,
									expression : data.expression,
									dctCode : data.dctCode,
									isQuery : data.isQuery,
									defaultValue : data.defaultValue
								}});
							}
						}
						editIndex = 0;
						$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
					}
		}, 'json');
	}
	
	//读取数据库名称，然后尝试构造所有列
	function addBatch(){
		$.post(
			fullpath + '/onlineTableConfigController.do?loadTableInfo', {
				tableName : $('textarea[name="tablename"]').val()
			}, 
			function(result) {
				if (!result.success) {
					$.messager.show({title : '警告',msg : result.msg});
				} else {//信息加载成功
					
					reject();//取消编辑
					
					var rows = $('#dg').datagrid('getRows');//先将原先的所有行全删除
					while(rows.length>0){
						$('#dg').datagrid('deleteRow',0);
						rows = $('#dg').datagrid('getRows');//最后一行也要清掉
					}
					
					var fields = result.fields;
					
					for(var i=0;i<fields.length;i++){//然后根据数据库表的字段，重新初始化
						if (endEditing()){
							editIndex = 0;
							grid.datagrid('insertRow',{index: editIndex,row: {
								id : '',
								fieldName : fields[i].fieldname,
								sort : fields[i].fieldname,
								fieldText : 'text',
								fieldType : 'N',
								fieldWidth : 'Y',
								isShow : 'Y',
								showHref : '',
								queryModel : '',
								expression : '',
								dctCode : '',
								isQuery : '',
								defaultValue : '',
							}});
						}
					}
					
					editIndex = 0;
					$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
					
				}
		}, 'json');
	}
	
	//取消编辑
	function reject(){
		$('#dg').datagrid('rejectChanges');
		editIndex = undefined;
	}

	$(function() {
		grid = $('#dg').datagrid({
			fitColumns : true,
			rownumbers : true,
			singleSelect : false,
			fit : true,
			border : false,
			idField : 'id',
			onClickRow: onClickRow,
			url : fullpath + '/onlineCgReportConfigController.do?showItemsByHeadId&configId=<%=id%>',
							columns : [ [ {
								field : 'id',
								title : 'id',
								width : 30,
								hidden : true
							}, {
								field : 'fieldName',
								title : '字段名',
								width : 40,
								editor : {
									type : 'validatebox',
									options : {
									}
								}
							}, {
								field : 'sort',
								title : '排序',
								width : 40,
								editor : {
									type : 'validatebox',
									options : {
									}
								}
							}, {
								field : 'fieldText',
								title : '字段文本',
								width : 40,
								editor : {
									type : 'validatebox',
									options : {
									}
								}
							}, {
								field : 'fieldType',
								title : '字段类型',
								width : 40,
								editor : {
									type : 'combobox',
									options : {
										valueField : 'dic_key',
										textField : 'dic_value',
										data : [ {
											"dic_key" : "Integer",
											"dic_value" : "Integer"
										}, {
											"dic_key" : "String",
											"dic_value" : "String"
										}, {
											"dic_key" : "Date",
											"dic_value" : "Date"
										}, {
											"dic_key" : "DateTime",
											"dic_value" : "DateTime"
										}, {
											"dic_key" : "ComboBox",
											"dic_value" : "ComboBox"
										}, {
											"dic_key" : "MultCombox",
											"dic_value" : "MultCombox"
										}, {
											"dic_key" : "Long",
											"dic_value" : "Long"
										} ],
										required : true
									}
								}
							}, {
								field : 'fieldWidth',
								title : '字段宽度',
								width : 40,
								editor : {
									type : 'validatebox',
									options : {
									}
								}
							}, {
								field : 'isShow',
								title : '是否显示',
								width : 40,
								formatter : function(value, row) {
									if (value == "Y")
										return "显示";
									return "隐藏";
								},
								editor : {
									type : 'combobox',
									options : {
										valueField : 'dic_key',
										textField : 'dic_value',
					
										data : [ {
											"dic_key" : "Y",
											"dic_value" : "显示"
										}, {
											"dic_key" : "N",
											"dic_value" : "隐藏"
										} ],
										required : true
									}
								}
							}, {
								field : 'showHref',
								title : '字段显示href',
								width : 40,
								editor : {
									type : 'validatebox',
									options : {
									}
								}
							}, {
								field : 'queryModel',
								title : '查询模式',
								width : 40,
								formatter : function(value, row) {
									if (value == "single")
										return "单条件查询";
									return "范围查询";
								},
								editor : {
									type : 'combobox',
									options : {
										valueField : 'dic_key',
										textField : 'dic_value',
										data : [ {
											"dic_key" : "single",
											"dic_value" : "单条件查询"
										}, {
											"dic_key" : "range",
											"dic_value" : "范围查询"
										} ],
										required : true
									}
								}
							}, {
								field : 'expression',
								title : '取值表达式',
								width : 40,
								editor : {
									type : 'validatebox',
									options : {
									}
								}
							}, {
								field : 'dctCode',
								title : '字典Code',
								width : 40,
								editor : {
									type : 'validatebox',
									options : {
									}
								}
							}, {
								field : 'isQuery',
								title : '是否查询',
								width : 40,
								formatter : function(value, row) {
									if (value == "Y")
										return "是";
									return "否";
								},
								editor : {
									type : 'combobox',
									options : {
										valueField : 'dic_key',
										textField : 'dic_value',
										data : [ {
											"dic_key" : "Y",
											"dic_value" : "是"
										}, {
											"dic_key" : "N",
											"dic_value" : "否"
										} ],
										required : true
									}
								}
							}, {
								field : 'chartField',
								title : '图表类型',
								width : 40,
								formatter : function(value, row) {
									if (value == "Line"){
										return "拆线图";
									}else if(value=="COLUMN"){
										return "柱状图";
									}else if(value=="key"){
										return "图间分组字段";
									}else if(value=="group"){
										return "图内分组字段";
									}
								},
								editor : {
									type : 'combobox',
									options : {
										valueField : 'dic_key',
										textField : 'dic_value',
										data : [ {
											"dic_key" : "Line",
											"dic_value" : "拆线图"
										}, {
											"dic_key" : "COLUMN",
											"dic_value" : "柱状图"
										}, {
											"dic_key" : "key",
											"dic_value" : "图间分组字段"
										}, {
											"dic_key" : "group",
											"dic_value" : "图内分组字段"
										} ],
									}
								}
							}, {
								field : 'defaultValue',
								title : '默认值',
								width : 40,
								editor : {
									type : 'validatebox',
									options : {
									}
								}
							}] ],
							toolbar : '#toolbar',
							onBeforeLoad : function(row, param) {
								parent.$.messager.progress({
									text : '数据加载中....'
								});
							},
							onLoadSuccess : function(row, data) {
								$('.iconImg').attr('src', sy.pixel_0);
								parent.$.messager.progress('close');
							}
						});

		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			$('#fm').form('load',fullpath + '/onlineCgReportConfigController.do?getHeadById&configId='	+ $(':input[name="id"]').val());
		}
	});
</script>
<body class="easyui-layout">
	<div data-options="region:'north',title:'主表信息',border:false"
		style="height: 195px;">
		<form id="fm">
			<fieldset>
				<table style="width: 100%;" data-options="border:false">
					<tr>
						<input id="id" name="id" type="hidden" value="<%=id%>" />
						<th>编码</th>
						<td colspan="1">
							<input name="coding" class="easyui-validatebox"	data-options="required:true" /> 
						</td>
						<th>名称</th>
						<td>
							<input name="name" class="easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
					<tr>
						<th>查询数据SQL</th>
						<td>
							<textarea rows="3" cols="20" name="sql" class="easyui-validatebox"	data-options="required:true"></textarea>
							<img class="iconImg ext-icon-page_white_put" onclick="analyzSql();" title="SQL解析" />
						</td>
						<th>描述</th>
						<td>
							<input name="description" class="easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
					<tr>
						<th>生成图表</th>
						<td>
							<input name="ischart" type="checkbox" value="Y" class="easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
	</div>
	<div data-options="region:'center',title:'字段信息',border:false">
		<table id="dg" />
		<div id="toolbar">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true"
				onclick="addFun()">增加</a> <a href="#" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true" onclick="delFun()">删除</a> <a
				href="#" class="easyui-linkbutton" iconCls="ext-icon-cross"
				plain="true" onclick="reject()">取消编辑</a>
		</div>
	</div>
</body>
</html>