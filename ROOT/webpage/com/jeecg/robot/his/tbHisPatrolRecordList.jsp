<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbHisPatrolRecordList" checkbox="true" pagination="true" fitColumns="true" title="机房巡检记录表" actionUrl="tbHisPatrolRecordController.do?datagrid&patrolId=${patrolId}" idField="id" sortName="patrolTime" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="巡检历史表ID"  field="patrolId" hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="指示灯告警信息ID"  field="alarmZsdId" hidden="true" queryMode="group"  width="120"></t:dgCol> 
   <t:dgCol title="动环告警信息ID"  field="alarmDhId" hidden="true" queryMode="group"  width="120"></t:dgCol> 
   <t:dgCol title="巡检序号"  field="patrolNo"  queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="机柜编号"  field="cabineNo"  queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="检测时间"  field="patrolTime"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="温度/°C"  field="temperatureValue"  queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="湿度/%"  field="humidityValue"  queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="噪音/DB"  field="noiseValue"  queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="PM2.5/μg/m³"  field="pm25Value"  queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="污染气体/ppm"  field="pollutionGasValue"  queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="设备温度/°C"  field="imgTemperature"  queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="指示灯告警"  field="indicatorLightAlarm"  queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="动环告警"  field="alarmMenvironment"  queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="设备温度"  field="equipmentTemperatureValue" hidden="true" queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="图片路径"  field="imgUrl"  queryMode="group" hidden="true"  width="120"></t:dgCol>
   <t:dgCol title="查看" field="opt" width="200"></t:dgCol>
     <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
     <t:dgFunOpt title="指示灯告警" funname="check(id)" exp="indicatorLightAlarm#eq#是" urlclass="ace_button" urlfont="fa-search" />
     <t:dgFunOpt title="动环告警" funname="indicator(alarmDhId)"  exp="alarmMenvironment#eq#是" urlclass="ace_button" urlfont="fa-search" />  
     <t:dgFunOpt title="图片详情" funname="imgDetails(id)" exp="indicatorLightAlarm#eq#否"  urlclass="ace_button" urlfont="fa-search" /> 
    
  <%--  <t:dgDelOpt title="删除" url="tbHisPatrolRecordController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbHisPatrolRecordController.do?goAdd" funname="add"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbHisPatrolRecordController.do?goUpdate" funname="update"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbHisPatrolRecordController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbHisPatrolRecordController.do?goUpdate" funname="detail"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
 
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
  var computerRoomId= '${computerRoomId}';
 $(document).ready(function(){
 });
 //指示灯告警详情
 function check(recordId){ //巡检历史表Id
	 addOneTab('指示灯告警详情','tbAlAlarmInfoController.do?indicatorCheckPoint&recordId='+recordId,800,1200);
	 }
 //动环告警详情
 function indicator(alarmInfoId){	
	 addOneTab('动环告警详情','tbAlAlarmInfoController.do?checkPoint&id='+alarmInfoId,800,1200);
 }
 function imgDetails(id){
	 openwindow('图片详情','tbHisPatrolRecordController.do?viewPic&id='+id,"tbHisPatrolRecordList",600,400);
 }
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbHisPatrolRecordController.do?upload', "tbHisPatrolRecordList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbHisPatrolRecordController.do?exportXls","tbHisPatrolRecordList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbHisPatrolRecordController.do?exportXlsByT","tbHisPatrolRecordList");
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
