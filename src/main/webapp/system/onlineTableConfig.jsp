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
				
				$.post(
					fullpath + '/onlineTableConfigController.do?saveOrUpdate', {
						configId : $(':input[name="id"]').val(),
						tablename : $(':input[name="tablename"]').val(),
						title : $(':input[name="title"]').val(),
						online_items : JSON.stringify(rows)//将对像转成字符串往后台传			
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
				fieldname : '',
				fieldtitle : '',
				fieldtype : 'text',
				isquery : 'N',
				isshow : 'Y',
				is_addupdate : 'Y',
				is_exact_match : 'Y',
				data_options : '',
				dic_code : '',
				order_num : ''
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
	
	//读取数据库名称，然后尝试构造所有列
	function addBatch(){
		$.post(
			fullpath + '/onlineTableConfigController.do?loadTableInfo', {
				tableName : $(':input[name="tablename"]').val()
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
								fieldname : fields[i].fieldname,
								fieldtitle : fields[i].fieldname,
								fieldtype : 'text',
								isquery : 'N',
								isshow : 'Y',
								is_addupdate : 'Y',
								is_exact_match : 'Y',
								data_options : '',
								dic_code : '',
								order_num : ''
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
			url : fullpath + '/onlineTableConfigController.do?queryOnlineItemAll&configId=<%=id%>',
			columns:[[    
		          {field:'id',title:'id',width:30,hidden:true},    
		          {field:'fieldname',title:'字段名',width:40,editor:{type:'validatebox',options:{required:true}}},    
		          {field:'fieldtitle',title:'字段中文',width:40,editor:{type:'validatebox',options:{required:true}}},
		          {field:'fieldtype',title:'类型',width:20,editor:'validatebox',
		        	  editor:{
		        	  	type:'combobox',
		        	  	options:{
			        	  	valueField:'dic_key',
			        	  	textField:'dic_value',
			        	  	data : [{"dic_key":"text","dic_value":"text"},
			        	  	        {"dic_key":"date","dic_value":"date"},
			        	  	        {"dic_key":"datetime","dic_value":"datetime"},
			        	  	        {"dic_key":"combobox","dic_value":"combobox"}],
			        	  	required:true
		        	  	}
		        	  }  
		          },
		          {field:'isquery',title:'是否查询',width:30,
		        	  formatter : function(value,row){
		        		  if(value == "Y") return "是";
		        		  return "否";
		        	  },
		        	  editor:{
		        	  	type:'combobox',
		        	  	options:{
			        	  	valueField:'dic_key',
			        	  	textField:'dic_value',
			        	  	data : [{"dic_key":"Y","dic_value":"是"},{"dic_key":"N","dic_value":"否"}],
			        	  	required:true
		        	  	}
		        	  }
		          },
		          {field:'isshow',title:'是否列表显示',width:30,editor:'validatebox',
		        		  formatter : function(value,row){
			        		  if(value == "Y") return "是";
			        		  return "否";
			        	  },
			        	  editor:{
			        	  	type:'combobox',
			        	  	options:{
				        	  	valueField:'dic_key',
				        	  	textField:'dic_value',
				        	  	data : [{"dic_key":"Y","dic_value":"是"},{"dic_key":"N","dic_value":"否"}],
				        	  	required:true
			        	  	}
			        	  }
			      },
			      {field:'is_addupdate',title:'是否录入显示',width:30,editor:'validatebox',
		        		  formatter : function(value,row){
			        		  if(value == "Y") return "是";
			        		  return "否";
			        	  },
			        	  editor:{
			        	  	type:'combobox',
			        	  	options:{
				        	  	valueField:'dic_key',
				        	  	textField:'dic_value',
				        	  	data : [{"dic_key":"Y","dic_value":"是"},{"dic_key":"N","dic_value":"否"}],
				        	  	required:true
			        	  	}
			        	  }
			      },
		          {field:'is_exact_match',title:'是否模糊查询',width:30,editor:'validatebox',
				    	  formatter : function(value,row){
			        		  if(value == "Y") return "是";
			        		  return "否";
			        	  },
			        	  editor:{
			        	  	type:'combobox',
			        	  	options:{
			        	  		editable:false,
				        	  	valueField:'dic_key',
				        	  	textField:'dic_value',
				        	  	data : [{"dic_key":"Y","dic_value":"是"},{"dic_key":"N","dic_value":"否"}],
				        	  	required:true
			        	  	}
			        	  }  
		          },
		          {field:'order_num',title:'排序',width:15,editor:{type:'numberbox',options:{required:true}}},
		          {field:'data_options',title:'data_options',width:50,editor:'validatebox'},
		          {field:'dic_code',title:'字典代码',width:40,editor:'validatebox'}
			]], 
			toolbar : '#toolbar',
			onBeforeLoad : function(row, param) {
				parent.$.messager.progress({text : '数据加载中....'});
			},
			onLoadSuccess : function(row, data) {
				$('.iconImg').attr('src', sy.pixel_0);
				parent.$.messager.progress('close');
			}
		});
		
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			$('#fm').form('load', fullpath + '/onlineTableConfigController.do?loadOnlineHeadById&id='+$(':input[name="id"]').val());
		}
	});
</script>
<body class="easyui-layout">
	<div data-options="region:'north',title:'主表信息',border:false" style="height: 95px;">
		<form id="fm">
		<fieldset>
		<table style="width: 100%;" data-options="border:false">
			<tr>
				<input id="id" name="id"  type="hidden" value="<%=id%>" />
				<th>主表名称</th>	<td><input name="tablename" class="easyui-validatebox" data-options="required:true" />
					<img class="iconImg ext-icon-page_white_put" onclick="addBatch();" title="初始化字段信息" /></td>
				<th>显示标题</th>	<td><input name="title" class="easyui-validatebox" data-options="required:true" /></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</div>
	<div data-options="region:'center',title:'字段信息',border:false">
		<table id="dg"/>
		<div id="toolbar">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addFun()">增加</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delFun()">删除</a>
			<a href="#" class="easyui-linkbutton" iconCls="ext-icon-cross" plain="true" onclick="reject()">取消编辑</a>
		</div>
	</div>
</body>
</html>