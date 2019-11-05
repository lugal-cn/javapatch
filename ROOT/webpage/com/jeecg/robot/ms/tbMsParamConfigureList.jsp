<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbMsParamConfigureList" checkbox="true" pagination="true" fitColumns="true" title="系统参数配置" actionUrl="tbMsParamConfigureController.do?datagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="参数类型"  field="paramConfigureType"  queryMode="single"  dictionary="itacs_alarm_level"  width="120"></t:dgCol>
   <t:dgCol title="是否按部门告警"  field="paramConfigureName"  queryMode="single"  dictionary="sf_yn"  width="120"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
  <%--  <t:dgCol title="操作" field="opt" width="100"></t:dgCol> --%>
<%--    <t:dgDelOpt title="删除" url="tbMsParamConfigureController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/> --%>
   <t:dgToolBar title="录入" icon="icon-add" url="tbMsParamConfigureController.do?goAdd" funname="add"  width="768"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbMsParamConfigureController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="删除"  icon="icon-remove" url="tbMsParamConfigureController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 gridname="tbMsParamConfigureList";
 });
 //添加
 function add() {
	 var framename = window.frameElement.name;
	 var url = 'tbMsParamConfigureController.do?goAdd';
	 url += '&framename='+framename;
	 addOneTab('添加参数', url);
 }
//更新
 function update() {
 	var rows = $("#tbMsParamConfigureList").datagrid('getSelections');
 	if (!rows || rows.length==0) {
 		tip($.i18n.prop('edit.selectItem'));
 		return;
 	}
    if (rows.length == 1) {
    	 var url = 'tbMsParamConfigureController.do?goUpdate&id='+rows[0].id+'&openType=2';
    	 var framename = window.frameElement.name;
    	 url += '&framename='+framename;
    	 addOneTab('修改参数', url);
    }else{
    	tip('请选择一条记录再编辑');
    }
 }
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbMsParamConfigureController.do?upload', "tbMsParamConfigureList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbMsParamConfigureController.do?exportXls","tbMsParamConfigureList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbMsParamConfigureController.do?exportXlsByT","tbMsParamConfigureList");
}

//bootstrap列表图片格式化
function btListImgFormatter(value,row,index){
	return listFileImgFormat(value,"image");
}
//bootstrap列表文件格式化
function btListFileFormatter(value,row,index){
	return listFileImgFormat(value);
}

//列表文件图片 列格式化方法
function listFileImgFormat(value,type){
	var href='';
	if(value==null || value.length==0){
		return href;
	}
	var value1 = "img/server/"+value;
	if("image"==type){
 		href+="<img src='"+value1+"' width=30 height=30  onmouseover='tipImg(this)' onmouseout='moveTipImg()' style='vertical-align:middle'/>";
	}else{
 		if(value.indexOf(".jpg")>-1 || value.indexOf(".gif")>-1 || value.indexOf(".png")>-1){
 			href+="<img src='"+value1+"' onmouseover='tipImg(this)' onmouseout='moveTipImg()' width=30 height=30 style='vertical-align:middle'/>";
 		}else{
 			var value2 = "img/server/"+value+"?down=true";
 			href+="<a href='"+value2+"' class='ace_button' style='text-decoration:none;' target=_blank><u><i class='fa fa-download'></i>点击下载</u></a>";
 		}
	}
	return href;
}

function deleteALLSelect(title,url,gname) {
	gridname=gname;
    var ids = [];
    var rows = $("#"+gname).datagrid('getSelections');
    if (rows.length > 0) {
    	$.dialog.setting.zIndex = getzIndex(true);
    	$.dialog.confirm('删除后指示灯告警无法按照部门进行告警，'+$.i18n.prop('del.forever.confirm.tip'), function(r) {
		   if (r) {
				for ( var i = 0; i < rows.length; i++) {
					ids.push(rows[i].id);
				}
				$.ajax({
					url : url,
					type : 'post',
					data : {
						ids : ids.join(',')
					},
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if (d.success) {
							var msg = d.msg;
							tip(msg);
							reloadTable();
							$("#"+gname).datagrid('unselectAll');
							ids='';
						}
					}
				});
			}
		});
	} else {
		tip($.i18n.prop('del.selectData.tip'));
	}
}
</script>
