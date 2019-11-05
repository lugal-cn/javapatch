<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbRoRobotsParamList" checkbox="true" pagination="true" fitColumns="true" title="tb_ro_robots_param" actionUrl="tbRoRobotsParamController.do?datagrid" idField="id" sortName="id" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机器人ID"  field="robotsInfoId"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="识别摄像头数量（来源机器人型号表）"  field="identifyCamerasNumber"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="热成像摄像头数量（来源机器人型号表）"  field="imgCamerasNumber"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="选择传感器（来源机器人型号表）"  field="sensors"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="日常巡检开始前电量自检得最低电量值（立即巡检前也要电量自检）"  field="powerValueMin"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="低电量提醒中得初次提示电量"  field="powerValueFirst"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="强制回充电量"  field="forcedRecharge"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="遇障等待时间（机器人在遇障时，重新规划路径时间，在时间范围内若无法重新规划一条新的路径，机器人则返回充电）"  field="obstaclesWaitingTime"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="非巡检状态下动环检测时间间隔"  field="timeInterval"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="直播摄像头配置_IP"  field="liveCamerasIp"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="直播摄像头配置_用户名"  field="liveCamerasName"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="直播摄像头配置_密码"  field="liveCamerasPwd"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="热成像摄像头配置_IP"  field="imgCamerasIp"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="热成像摄像头配置_用户名"  field="imgCamerasName"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="热成像摄像头配置_密码"  field="imgCamerasPwd"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="热成像摄像头配置_IP"  field="imgCamerasIp2"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="热成像摄像头配置_用户名"  field="imgCamerasName2"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="热成像摄像头配置_密码"  field="imgCamerasPwd2"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="serverIp"  field="serverIp"  queryMode="group"  width="120"></t:dgCol>
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
   <t:dgCol title="创建时间"  field="createTime"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建人"  field="createUserId"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建部门"  field="createDept"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="温度设置标识"  field="temperatureFlag"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="湿度设置标识"  field="humidityFlag"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="噪音设置标识"  field="noiseFlag"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="PM2.5设置标识"  field="pm25Flag"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="污染气体设置标识"  field="pollutionGasFlag"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="设备温度设置标识"  field="equipmentTemperatureFlag"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tbRoRobotsParamController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbRoRobotsParamController.do?goAdd" funname="add"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbRoRobotsParamController.do?goUpdate" funname="update"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbRoRobotsParamController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbRoRobotsParamController.do?goUpdate" funname="detail"  width="800" height="500"></t:dgToolBar>
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
	openuploadwin('Excel导入', 'tbRoRobotsParamController.do?upload', "tbRoRobotsParamList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbRoRobotsParamController.do?exportXls","tbRoRobotsParamList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbRoRobotsParamController.do?exportXlsByT","tbRoRobotsParamList");
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
