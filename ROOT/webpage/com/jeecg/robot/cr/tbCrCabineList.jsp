<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbCrCabineList" checkbox="true" pagination="true" fitColumns="true" title="机柜管理" actionUrl="tbCrCabineController.do?datagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
     <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="所属机房"  field="computerRoomId"  query="true" queryMode="single" dictionary="tb_cr_computer_room,id,computer_room_name" width="120"></t:dgCol>
   <t:dgCol title="机柜编号"  field="cabineNo"  query="true" width="120"></t:dgCol> 
   <t:dgCol title="机柜类型"  field="cabineType"  query="true" dictionary="itacs_cabinetType" width="120"></t:dgCol>
   <t:dgCol title="边框尺寸"  field="borderSize"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="描述"  field="cabineDesc"  query="true"  width="120"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
  <%--  <t:dgCol title="操作" field="opt" width="100"></t:dgCol> --%>
   <t:dgDelOpt title="删除" url="tbCrCabineController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbCrCabineController.do?goAdd" funname="add"  width="730" height="450"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbCrCabineController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="删除"  icon="icon-remove" url="tbCrCabineController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  <%--  <t:dgToolBar title="查看" icon="icon-search" url="tbCrCabineController.do?goUpdate" funname="detail"  width="768"></t:dgToolBar> --%>
   <%-- <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 gridname="tbCrCabineList";
 });
 
//添加
 function add() {
 	 var framename = window.frameElement.name;
 	 var url = 'tbCrCabineController.do?goAdd';
 	 url += '&framename='+framename;
 	 addOneTab('添加机柜', url);
  }
//更新
 function update() {
 	var rows = $("#tbCrCabineList").datagrid('getSelections');
 	if (!rows || rows.length==0) {
 		tip($.i18n.prop('edit.selectItem'));
 		return;
 	}
    if (rows.length == 1) {
    	 var url = 'tbCrCabineController.do?goUpdate&id='+rows[0].id+'&openType=2';
    	 var framename = window.frameElement.name;
    	 url += '&framename='+framename;
    	 addOneTab('修改机柜信息', url);
    }else{
 	   tip('请选择一条记录再编辑');
    }
 } 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbCrCabineController.do?upload', "tbCrCabineList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbCrCabineController.do?exportXls","tbCrCabineList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbCrCabineController.do?exportXlsByT","tbCrCabineList");
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
