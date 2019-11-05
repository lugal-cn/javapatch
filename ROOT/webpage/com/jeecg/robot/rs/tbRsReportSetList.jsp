<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbRsReportSetList" checkbox="true" pagination="true" fitColumns="true" title="报表设置表" actionUrl="tbRsReportSetController.do?datagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="报表规则名称"  field="reportSetName"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="机房名称"  field="computerRoomId"  dictionary="tb_cr_computer_room,id,computer_room_name"  query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="报表状态"  field="reportSetStatus"  query="true" queryMode="single"  dictionary="itacs_report_set_status"  width="120"></t:dgCol>
   <t:dgCol title="报表样式"  field="reportSetStyle" query="true"  queryMode="single"  dictionary="itacs_report_set_style"  width="120"></t:dgCol>
   <t:dgCol title="选择类型"  field="reportSetType" query="true" queryMode="single"  dictionary="itacs_report_set_type"  width="120"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime" sortable="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tbRsReportSetController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgConfOpt exp="reportSetStatus#eq#02" url="tbRsReportSetController.do?updateReportSetStatus&id={id}&status=01"   urlclass="ace_button"  title="启用" message="确定要启用吗？" ></t:dgConfOpt>
   <t:dgConfOpt exp="reportSetStatus#eq#01"  url="tbRsReportSetController.do?updateReportSetStatus&id={id}&status=02"  urlclass="ace_button"  title="停用" message="确定要停用吗？" ></t:dgConfOpt>
   <t:dgToolBar title="创建" icon="icon-add" url="tbRsReportSetController.do?goAdd" funname="add"  width="768"></t:dgToolBar>
   <t:dgToolBar title="修改" icon="icon-edit" url="tbRsReportSetController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbRsReportSetController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 gridname="tbRsReportSetList";
 });
 

//添加
 function add() {
 	 var framename = window.frameElement.name;
 	 var url = 'tbRsReportSetController.do?goAdd';
 	 url += '&framename='+framename;
 	 addOneTab('添加报表', url);
  }
//更新
 function update() {
 	var rows = $("#tbRsReportSetList").datagrid('getSelections');
 	if (!rows || rows.length==0) {
 		tip($.i18n.prop('edit.selectItem'));
 		return;
 	}
    if (rows.length > 0) {
    	 var url = 'tbRsReportSetController.do?goUpdate&id='+rows[0].id+'&openType=2';
    	 var framename = window.frameElement.name;
    	 url += '&framename='+framename;
    	 addOneTab('修改报表', url);
    }
 }  
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbRsReportSetController.do?upload', "tbRsReportSetList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbRsReportSetController.do?exportXls","tbRsReportSetList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbRsReportSetController.do?exportXlsByT","tbRsReportSetList");
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
