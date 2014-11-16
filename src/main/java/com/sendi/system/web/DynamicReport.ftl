<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script type="text/javascript">
  var contextRootPath = "${contextRootPath}";
  var fullpath = "${fullpath}";
</script>
 
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<link rel="stylesheet" type="text/css" href="${contextRootPath}/ext2/resources/css/ext-all.css">

 
<script type="text/javascript" src="${contextRootPath}/ext2/ext-base.js"></script>
<script type="text/javascript" src="${contextRootPath}/ext2/ext-all.js"></script>
<script type="text/javascript" src="${contextRootPath}/ext2/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="${contextRootPath}/page/common/base/base.js"></script>
<script type="text/javascript" src="${contextRootPath}/page/common/common2.js"></script>
<script type="text/javascript" src="${contextRootPath}/page/common/commonfunction.js"></script> 
<script type="text/javascript" src="${contextRootPath}/page/common/My97DatePicker-4.7-Beta4/WdatePicker.js"></script>

<link rel="stylesheet" type="text/css" href="${contextRootPath}/page/common/LovCombo.css"/>
<script type="text/javascript" src="${contextRootPath}/page/common/LovCombo.js"></script>

<script type="text/javascript">


//*******变量声明************************************************************************
var store,grid,addform,addwin; //主页面（center）
var mdnfield; //主页面（grid的toolbar）
var dataIDTmp,dataNameTmp;	//全局变量
var theadbarArray=new Array();


//*******公共函数*****************************************`*******************************
//*******控件响应函数********************************************************************
function queryDevice(){
 	Ext.apply(store.baseParams, { 
 		<#if (config_fieldList?size>0)>
		<#list config_fieldList  as x> 
			<#if x['s_flag']=="Y"> 
				<#if x['s_mode']=="group"> 
				${x['field_name']}_begin:${x['field_name']}_begin.getValue(),${x['field_name']}_end:${x['field_name']}_end.getValue()<#if x_has_next>,</#if>
				<#else>
				${x['field_name']}:${x['field_name']}.getValue()<#if x_has_next>,</#if>
				</#if>
		  	</#if>
		</#list>
		</#if>
	});
	store.load({params:{start:0, limit:20}});
}

function exportData(){
	var queryStr='';
	<#if (config_fieldList?size>0)>
	<#list config_fieldList  as x> 
		<#if x['s_flag']=="Y">
			<#if x['s_mode']=="group"> 
			queryStr+='&${x['field_name']}_begin='+${x['field_name']}_begin.getValue();
			queryStr+='&${x['field_name']}_end='+${x['field_name']}_end.getValue();
			<#else>
			queryStr+='&${x['field_name']}='+${x['field_name']}.getValue();
			</#if> 
	  	</#if>
	</#list>
	</#if>
		
	var url = fullpath+'/dynamicReportExcelController.do?exportXls&configId='+configId+queryStr ;
	window.open(url, "_self");
}

	function getInfoFormLocationUrl(paraName){
	    var oldurl = location.href;
		var index = oldurl.indexOf(paraName);
		var index2 = oldurl.indexOf('&', index);
		var userid = '';
		if (index != -1 && index2 != -1) {
			userid = oldurl.substring(index + paraName.length, index2);
		} else if (index != -1) {
			userid = oldurl.substring(index + paraName.length);
		}
		return userid;
	}
	//获取页面配置id
	//http://localhost:8080/znwgxt/dynamicReportController.do?list&configId=t_s_log
	var configId=getInfoFormLocationUrl("configId=");
	//alert('configId:'+configId);
	
//*******grid 列定义*********************************************************************
var sm=new Ext.grid.CheckboxSelectionModel({
	singleSelect:false
});

var fields = [<#if (config_fieldList?size>0)>
<#list config_fieldList  as x>  
 	<#if x_has_next>
	'${x['field_name']}',
	<#else>
	'${x['field_name']}'
  	</#if>
</#list>
</#if>];

var colml=new Ext.grid.ColumnModel([
    new Ext.grid.RowNumberer(),
    sm,
		<#if (config_fieldList?size>0)>
		<#list config_fieldList  as x>  
		 	<#if x_has_next>
			{header: "${x['field_txt']}", width:${x['field_width']}, sortable:true,align:'center', dataIndex:'${x['field_name']}' <#if x['is_show']=='N'>,hidden:true</#if>} ,
			<#else>
			{header: "${x['field_txt']}", width:${x['field_width']}, sortable:true,align:'center', dataIndex:'${x['field_name']}' <#if x['is_show']=='N'>,hidden:true</#if>}
		  	</#if>
		</#list>
		</#if>
    ]
);

//*******报表主grid 查询条件********************************

//动态生成查询组件
<#if (config_fieldList?size>0)>
<#list config_fieldList  as x>  
	<#if x['s_flag']=="Y">
		<#if x['field_type']=="Date" || x['field_type']=="DateTime">
			<#if x['s_mode']=="group"> 
			${x['field_name']}_begin = new Ext.form.TextField({
				id:'${x['field_name']}_begin',
				name:'${x['field_name']}_begin',
				hiddenName:'${x['field_name']}_begin',
				fieldLabel: '${x['field_txt']}_begin',
				labelWidth:60,
				width:130,
				value:'${x['default_value']}'.split(',')[0],
				listeners:{
					'render':function(){
			          Ext.EventManager.on("${x['field_name']}_begin", 'click', function(){
			              new WdatePicker({
			                   skin: 'ext', // 应用ext的皮肤样式
			                   dateFmt: 'yyyyMMdd<#if x['field_type']=="DateTime">HHmmss</#if>' // 格式为：年-月-日 时 ：分
			               });
			          })
			 		}
				}
			});
			${x['field_name']}_end = new Ext.form.TextField({
				id:'${x['field_name']}_end',
				name:'${x['field_name']}_end',
				hiddenName:'${x['field_name']}_end',
				fieldLabel: '${x['field_txt']}_end',
				labelWidth:60,
				width:130,
				value:'${x['default_value']}'.split(',')[1],
				listeners:{
					'render':function(){
			          Ext.EventManager.on("${x['field_name']}_end", 'click', function(){
			              new WdatePicker({
			                   skin: 'ext', // 应用ext的皮肤样式
			                   dateFmt: 'yyyyMMdd<#if x['field_type']=="DateTime">HHmmss</#if>' // 格式为：年-月-日 时 ：分
			               });
			          })
			 		}
				}
			});
			<#else>
			${x['field_name']} = new Ext.form.TextField({
				id:'${x['field_name']}',
				name:'${x['field_name']}',
				hiddenName:'${x['field_name']}',
				fieldLabel: '${x['field_txt']}',
				labelWidth:60,
				width:130,
				value:'${x['default_value']}',
				listeners:{
					'render':function(){
			          Ext.EventManager.on("${x['field_name']}", 'click', function(){
			              new WdatePicker({
			                   skin: 'ext', // 应用ext的皮肤样式
			                   dateFmt: 'yyyyMMdd<#if x['field_type']=="DateTime">HHmmss</#if>' // 格式为：年-月-日 时 ：分
			               });
			          })
			 		}
				}
			});
			</#if>  
		<#else>
			<#if x['dict_code']!=''> 
				
				var boxItems= new Array();
				
				<#if (config_boxList?size>0)>
					<#list config_boxList  as c> 
						<#if x['dict_code']==c['dcttypeen']> 
						  	boxItems.push( [  '${c['valuetext']}'  ,  '${c['displayvalue']}'  ] );
						 </#if>
					</#list>
				</#if>
				
				<#if x['field_type']=="ComboBox" >
					boxItems.push( [   '','全部'    ] );
					${x['field_name']} = new Ext.form.ComboBox({
						xtype : 'combo', id:'${x['field_name']}_tmp',hiddenName:'${x['field_name']}',anchor:'98%',
				  		store : boxItems,  
				  		displayField:'text', valueField:'value',  
				  		//width:${x['field_width']},
				  		width:120,
				  		value:'${x['default_value']}',
			  			mode : 'local', editable : false,  
				  		triggerAction:'all',  
				  		emptyText:'请选择',allowBlank:false
						});
					<#elseif x['field_type']=="MultCombox">	
						
						${x['field_name']} = new Ext.ux.form.LovCombo({
							id:'${x['field_name']}_tmp',hiddenName:'${x['field_name']}',anchor:'98%',
					  		store : boxItems,  
					  		beforeBlur : function() { },
					  		displayField:'text', valueField:'value',  
					  		width:120,
					  		value:'${x['default_value']}',
				  			mode : 'local', editable : false,  
					  		triggerAction:'all',  
					  		emptyText:'请选择',allowBlank:true
							});
				</#if> 
				
			
			<#else>
				${x['field_name']} = new Ext.form.TextField({
				    id:'${x['field_name']}',
				    xtype:'textfield',
				    //width:${x['field_width']},
				    width:120,
				    value:'${x['default_value']}',
				    name:'${x['field_name']}'
				});
			</#if>
		</#if>
  	</#if>
</#list>
</#if>





<#-- 定义要每个theadbar显示的列数 columnCount -->
<#assign columnCount = 5>


<#-- 定义要查询的条件总数 totalCount -->
<#assign totalCount=0 />
<#if (config_fieldList?size>0)>
		<#list config_fieldList  as x>  
			<#if x['s_flag']=="Y"> 
				 		<#assign totalCount=totalCount+1 />
			</#if>
		</#list>
</#if>



<#-- 计算theadbar的行数 rowCount -->
<#if totalCount % columnCount == 0>
    <#assign rowCount = ( totalCount / columnCount) - 1 >
<#else>
    <#assign rowCount = ( (totalCount - totalCount % columnCount) / columnCount  ) >
</#if>




<#-- 外层循环输出表格的 tr  -->
<#list 0..rowCount as row >	
	var tbar${row_index+1} =new Ext.Toolbar({
		id:'theadbar${row_index+1}',
	    scope:this,
	    height:25,
	    items:[
			<#list 0..columnCount - 1 as cell >
	            <#if config_fieldList[row * columnCount + cell]?? && config_fieldList[row * columnCount + cell]['s_flag']=="Y" >
	            	<#if config_fieldList[row * columnCount + cell]['s_mode']=="group"> 
		            '${config_fieldList[row * columnCount + cell].field_txt}',${config_fieldList[row * columnCount + cell].field_name}_begin,'~',
		             ${config_fieldList[row * columnCount + cell].field_name}_end,
		            '-'<#if cell_index != columnCount-1 || rowCount==0  >,</#if>
					<#else>
		            '${config_fieldList[row * columnCount + cell].field_txt}',${config_fieldList[row * columnCount + cell].field_name},'-'<#if cell_index != columnCount-1 || rowCount==0  >,</#if>
					</#if>     
	            </#if>
	            
	            <#if row * columnCount + cell==config_fieldList?size-1 >
		            {
				    	text:'查询',
				    	pressed: true,
						handler:queryDevice
					},'-',{
				    	text:'导出',
				    	pressed: true,
						handler:exportData
					},'-','<font color=blue>默认精确查询，模糊查询需要加*号</font>'
		        </#if>
		        
		        
	        </#list>
	        
	        
		]
	});
	
	
</#list>

	
//初始化页面信息和表格
Ext.onReady(function(){
   	Ext.QuickTips.init();
   	//addButton.show();
   //************【center：报表主grid】************************
    store=new Ext.data.JsonStore({
    	root: 'datas',
    	totalProperty: 'totalCount',
    	pruneModifiedRecords:true,//设置为true,则每次当store装载或有record被移除时,清空所有修改了的record信息. 默认为false. 
  		fields: fields,
		url: fullpath+'/dynamicReportController.do?dataQry&configId='+configId ,
		remoteSort:true,
		sortInfo:{field:'dataName',direction:'DESC'}	//去掉"direction:'DESC"则正序!
    });
    // 分页工具栏
    var pagebar= new Ext.PagingToolbar({
        pageSize:20,
        store:store,
        displayInfo:true,
        displayMsg:'显示第 {0}  条 到 {1} 条记录，一共{2}条 ',
        emptyMsg:"没有记录"
    });
    grid=new Ext.grid.GridPanel({
    	 region:'center', 
    	 title:'${headers.name}',
    	 store: store,
    	 cm:colml,
     	 sm:sm,
     	 trackMouseOver:false,
     	 disableSelection:false,
     	 loadMask: {msg:'正加载数据...'},
     	 viewConfig: {
            forceFit:false            
     	 },
     	 bbar:pagebar,
     	 tbar:[],
     	 listeners: {
	      	 render: function(){ 
	             	//tbar1.render(this.tbar);  
	             	//tbar2.render(this.tbar); 
	             	
	             	<#list 0..rowCount as row >	
						tbar${row_index+1}.render(this.tbar); 
					</#list>
	            }  
	        }
    });
    
    queryDevice();
	//store.load({params:{start:0, limit:20}});
	
/////////******** viewport *********////////////////////////////
	var viewport = new Ext.Viewport({
		layout:'fit',
		border:false,
		split: true,
		items:[{
		    	   xtype:'panel',
		    	   region:'center',
                   id:'datagrid',
		    	   layout:'fit', 
                   hidden:false, 
    	    	   width:document.body.clientWidth * 1,
		    	   items:[grid]
		       } 
		]
	});
})




</script>
<style type="text/css">
  	.x-grid-back-red { 
		background: #e4765c; 
	}
	.x-grid-back-green { 
		background: #93de8b; 
	}
	.x-grid-back-yellow{
		background: #FFFF80;
	}
</style>
<title>动态报表</title>
</head>
<body>
</body>
</html>