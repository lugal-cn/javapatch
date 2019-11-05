<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
$(function() {
    var datagrid = $("#tbRsReportViewListtb");
    datagrid.find("div[name='searchColums']").find("form#tbRsReportViewListForm").append($("#tempSearchColums div[name='searchColums']").html());
    $("#tempSearchColums").html('');
    
});
</script>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <div id="tempSearchColums" style="display: none;">
    <div name="searchColums">
      	统计周期：<input name="reportCycle_begin" id="reportCycle_begin" type="text" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'reportCycle_end\')}'})"  />
      	~
      	<input name="reportCycle_end" id="reportCycle_end" type="text" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'reportCycle_begin\')}'})" />
    </div>
   </div>
  <t:datagrid name="tbRsReportViewList" checkbox="true" pagination="true" fitColumns="true" title="报表查看表" actionUrl="tbRsReportViewController.do?datagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="报表名称"  field="reportName"  queryMode="single"  width="120"></t:dgCol>
    <t:dgCol title="机房名称"  field="computerRoomId" query="true" dictionary="tb_cr_computer_room,id,computer_room_name" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="报表类型"  field="reportType" query="true"   queryMode="single"  dictionary="itacs_report_set_type"   width="120"></t:dgCol>
   <t:dgCol title="报表样式"  field="reportStyle" query="true" dictionary="itacs_report_set_style"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="统计周期"  field="reportCycle"  queryMode="single"  width="120"></t:dgCol>
    <t:dgCol title="报表生成时间"  field="createTime" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tbRsReportViewController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
  <t:dgFunOpt  title="查看" funname="addNewPage(id,reportStyle,reportName,reportType,computerRoomId,reportCycle)" urlclass="ace_button"  urlfont="fa-check" />
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbRsReportViewController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbRsReportViewController.do?upload', "tbRsReportViewList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbRsReportViewController.do?exportXls","tbRsReportViewList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbRsReportViewController.do?exportXlsByT","tbRsReportViewList");
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

function addNewPage(id,reportStyle,reportName,reportType,computerRoomId,reportCycle){
	if(reportStyle == "01"){
		addOneTab("机房巡检记录表", "tbRsReportPatrolRecordController.do?list&type=table&id="+id+"&reportStyle="+reportStyle+"&reportName="+reportName+"&reportType="+reportType+"&computerRoomId="+computerRoomId+"&reportCycle="+reportCycle);
	}else if(reportStyle == "02"){
		addOneTab("机房告警统计表", "tbRsReportAlarmRoomController.do?list&type=table&id="+id+"&reportStyle="+reportStyle+"&reportName="+reportName+"&reportType="+reportType+"&computerRoomId="+computerRoomId+"&reportCycle="+reportCycle);
	}
}

</script>
