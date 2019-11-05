<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
/* $(function() {
    var datagrid = $("#tbRsReportAlarmRoomListtb");
    datagrid.find("div[name='searchColums']").find("form#tbRsReportAlarmRoomListForm").append($("#tempSearchColums div[name='searchColums']").html());
    $("#tempSearchColums").html('');
}); */
</script>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <div id="tempSearchColums">
    <div name="searchColums">
      	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报表名称：${reportName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报表样式：${reportStyle}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统计周期：${reportCycle}
      	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机房名称：${computerRoomId}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报表类型：${reportType}
      	
    </div>
   </div>
  <t:datagrid name="tbRsReportAlarmRoomList"  pagination="true" fitColumns="true"  actionUrl="tbRsReportAlarmRoomController.do?datagrid&id=${id}" idField="id" sortName="id" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="报表查看ID"  field="reportViewId"  hidden="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="机柜编号"  field="cabineNo" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="巡检次数"  field="patrolTimes"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="指示灯告警次数"  field="alarmLightTimes"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="指示灯告故障率"  field="alarmLightFailurerate"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="动环告警次数"  field="alarmMenvTimes"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="动环告警故障率"  field="alarmMenvFailurerate"  queryMode="single"  width="120"></t:dgCol>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbRsReportAlarmRoomController.do?upload', "tbRsReportAlarmRoomList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbRsReportAlarmRoomController.do?exportXls","tbRsReportAlarmRoomList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbRsReportAlarmRoomController.do?exportXlsByT","tbRsReportAlarmRoomList");
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
