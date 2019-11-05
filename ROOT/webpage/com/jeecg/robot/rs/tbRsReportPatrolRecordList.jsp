<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true" >
   <div region="center" style="padding:0px;border:0px;">
   <div id="tempSearchColums">
    <div name="searchColums">
      	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报表名称：${reportName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报表样式：${reportStyle}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统计周期：${reportCycle}
      	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机房名称：${computerRoomId}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报表类型：${reportType}
    </div>
   </div>
   <t:datagrid name="tbRsReportPatrolRecordList" pagination="false" fitColumns="true" actionUrl="tbRsReportPatrolRecordController.do?datagrid&id=${id}" idField="id" sortName="id" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="报表查看ID"  field="reportViewId" hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机柜编号"  field="cabineNo"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="巡检序号"  field="patrolNo"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="检测时间"  field="cabineTime"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="指示灯"  field="indicatorLight"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="设备温度"  field="equipmentTemperatureValue"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="温度"  field="temperatureValue"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="湿度"  field="humidityValue"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="噪声"  field="noiseValue"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="PM2.5"  field="pm25Value"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="污染气体"  field="pollutionGasValue"  queryMode="group"  width="120"></t:dgCol>
  </t:datagrid>
  </div>
 </div>
 
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbRsReportPatrolRecordController.do?upload', "tbRsReportPatrolRecordList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbRsReportPatrolRecordController.do?exportXls","tbRsReportPatrolRecordList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbRsReportPatrolRecordController.do?exportXlsByT","tbRsReportPatrolRecordList");
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
