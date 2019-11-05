<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbAlAlarmMenvironmentList" checkbox="true" pagination="true" fitColumns="true" title="tb_al_alarm_menvironment" actionUrl="tbAlAlarmMenvironmentController.do?datagrid" idField="id" sortName="id" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="告警信息ID"  field="alarmInfoId"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="温度"  field="temperatureValue"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="湿度"  field="humidityValue"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="噪声"  field="noiseValue"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="PM2.5"  field="pm25Value"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="污染气体"  field="pollutionGasValue"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="设备温度"  field="equipmentTemperatureValue"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="温度设置"  field="temperatureLow"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="温度设置"  field="temperatureHigh"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="湿度设置低"  field="humidityLow"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="湿度设置高"  field="humidityHigh"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="噪声低"  field="noiseLow"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="噪声高"  field="noiseHigh"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="PM2.5低"  field="pm25Low"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="PM2.5高"  field="pm25High"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="污染气体低"  field="pollutionGasLow"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="污染气体高"  field="pollutionGasHigh"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="设备温度低"  field="equipmentTemperatureLow"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="设备温度高"  field="equipmentTemperatureHigh"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tbAlAlarmMenvironmentController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbAlAlarmMenvironmentController.do?goAdd" funname="add"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbAlAlarmMenvironmentController.do?goUpdate" funname="update"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbAlAlarmMenvironmentController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbAlAlarmMenvironmentController.do?goUpdate" funname="detail"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbAlAlarmMenvironmentController.do?upload', "tbAlAlarmMenvironmentList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbAlAlarmMenvironmentController.do?exportXls","tbAlAlarmMenvironmentList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbAlAlarmMenvironmentController.do?exportXlsByT","tbAlAlarmMenvironmentList");
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
