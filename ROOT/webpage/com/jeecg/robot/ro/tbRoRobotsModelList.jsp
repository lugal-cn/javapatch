<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbRoRobotsModelList" checkbox="true" pagination="true" fitColumns="true" title="机器人型号表" actionUrl="tbRoRobotsModelController.do?datagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机器人型号"  field="robotsModel"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="滑竿拍照摄像头数量"  field="sliderCamerasTakeNumber"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="滑竿直播摄像头数量"  field="sliderCamerasLiveNumber"  queryMode="group"  width="120"></t:dgCol>
<%--    <t:dgCol title="识别摄像头数量"  field="identifyCamerasNumber"  queryMode="group"  width="120"></t:dgCol> --%>
   <t:dgCol title="热成像仪摄像头数量"  field="imgCamerasNumber"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="选择传感器"  field="sensors"  queryMode="group" dictionary="itacs_sensors" width="200"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建人"  field="createUserId"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建部门"  field="createDept"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <%-- <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tbRoRobotsModelController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/> --%>
   <t:dgToolBar title="录入" icon="icon-add" url="tbRoRobotsModelController.do?goAdd" funname="add"  width="768"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbRoRobotsModelController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="删除"  icon="icon-remove" url="tbRoRobotsModelController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbRoRobotsModelController.do?goUpdate" funname="detail"  width="768"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 gridname="tbRoRobotsModelList";
 });

 //添加
 function add() {
	 var framename = window.frameElement.name;
	 var url = 'tbRoRobotsModelController.do?goAdd';
	 url += '&framename='+framename;
	 addOneTab('添加机器人型号', url);
 }
//更新
 function update() {
	var rows = $("#tbRoRobotsModelList").datagrid('getSelections');
	if (!rows || rows.length==0) {
		tip($.i18n.prop('edit.selectItem'));
		return;
	}
    if (rows.length == 1) {
    	 var url = 'tbRoRobotsModelController.do?goUpdate&id='+rows[0].id+'&openType=2';
    	 var framename = window.frameElement.name;
    	 url += '&framename='+framename;
    	 addOneTab('修改机器人型号信息', url);
    }else{
 	   tip('请选择一条记录再编辑');
    }
 }
 
//查看
 function detail() {
	 var rows = $("#tbRoRobotsModelList").datagrid('getSelections');
	 if (!rows || rows.length==0) {
			tip($.i18n.prop('read.selectItem'));
			return;
		}
    if (rows.length == 1) {
    	 var url = 'tbRoRobotsModelController.do?goUpdate&id='+rows[0].id+'&openType=1';
    	 addOneTab('查看机器人型号信息', url);
    }else{
 	   tip('请选择一条记录再查看');
    }
 }
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbRoRobotsModelController.do?upload', "tbRoRobotsModelList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbRoRobotsModelController.do?exportXls","tbRoRobotsModelList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbRoRobotsModelController.do?exportXlsByT","tbRoRobotsModelList");
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

</script>
