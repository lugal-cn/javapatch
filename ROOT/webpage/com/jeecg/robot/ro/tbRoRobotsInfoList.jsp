<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>

<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbRoRobotsInfoList" checkbox="true" pagination="true" fitColumns="true" 
  title="机器人信息表" actionUrl="tbRoRobotsInfoController.do?datagrid" idField="id" sortName="createTime" sortOrder="acs" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <%-- <t:dgCol title="机器人图片"  field="robotsUrl"  queryMode="group"  image="true" imageSize="50,50" formatterjs="btListImgFormatter" width="120"></t:dgCol> --%>
   <t:dgCol title="机器人编号"  field="robotsNo" queryMode="single"  width="80"></t:dgCol>
   <t:dgCol title="机器人名称"  field="robotsName" query="true" queryMode="single"  width="80"></t:dgCol>
   <t:dgCol title="机器人型号"  field="robotsModelId" query="true" queryMode="single" dictionary="tb_ro_robots_model,id,robots_model" width="70"></t:dgCol>
   <t:dgCol title="机器人IP"  field="robotsIp" query="true" queryMode="single"  width="80"></t:dgCol>
   <t:dgCol title="所属机房"  field="computerRoomId"  query="true" queryMode="single" dictionary="tb_cr_computer_room,id,computer_room_name" width="60"></t:dgCol>
   <t:dgCol title="剩余电量"  field="createDept"  queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="当前状态"  field="robotsStatus"  queryMode="group"  width="60"></t:dgCol> 
   <t:dgCol title="创建时间"  field="createTime" hidden="true" queryMode="group"  width="100"></t:dgCol>
   <%-- <t:dgCol title="创建人"  field="createUserId"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建部门"  field="createDept"  queryMode="group"  width="120"></t:dgCol> --%>
   <t:dgCol title="管理" field="opt" width="400"></t:dgCol>
   <t:dgFunOpt title="硬件配置" funname="setHardware(id)" urlclass="ace_button" />
   <t:dgFunOpt title="参数设置" funname="setParam(id,robotsStatus,robotsName)" urlclass="ace_button"  />
   <t:dgFunOpt title="巡检点管理" funname="setPatrol(id,robotsName)" urlclass="ace_button"  />
   <t:dgFunOpt title="同步" funname="synchData(id,robotsName,robotsStatus,robotsIp)" urlclass="ace_button"  />
   <t:dgFunOpt title="备份/恢复" funname="backUp(id,robotsName,robotsStatus,computerRoomId)" urlclass="ace_button"  />
   <t:dgFunOpt title="固件升级" funname="firmwareUpdate(id,robotsName,robotsStatus)" urlclass="ace_button"  />
   <t:dgFunOpt title="下载日志" funname="confirmDepartureTime(robotsIp)" urlclass="ace_button"  />
   <t:dgFunOpt title="设备库导入" funname="deviceslib(id,robotsStatus,robotsName)" urlclass="ace_button"  />
   <%-- <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
   <%-- <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar> --%>
   <t:dgDelOpt title="删除" url="tbRoRobotsInfoController.do?doDel&id={id}" urlclass="ace_button"  />
   <t:dgToolBar title="录入" icon="icon-add" url="tbRoRobotsInfoController.do?goAdd" funname="add1"  width="768"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbRoRobotsInfoController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <%-- <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbRoRobotsInfoController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar> --%>
   <t:dgToolBar title="查看" icon="icon-search" url="tbRoRobotsInfoController.do?goDetail" funname="detail"  width="768"></t:dgToolBar>
   <%-- <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 
 <script type="text/javascript">
 $(document).ready(function(){
	 $("#tbRoRobotsInfoListtb").find("span")[3].style.width="100px"; 
	 gridname="tbRoRobotsInfoList";
 });
 
var robotId = '${id}'; //机器人ID
 
//添加
function add1() {
	 var framename = window.frameElement.name;
	 var url = 'tbRoRobotsInfoController.do?goAdd&robotId='+robotId;
	 url += '&framename='+framename;
	 addOneTab('添加机器人', url);
 }
 
//更新
function update() {
	var rows = $("#tbRoRobotsInfoList").datagrid('getSelections');
	if (!rows || rows.length==0) {
		tip($.i18n.prop('edit.selectItem'));
		return;
	}
   if (rows.length == 1) {
   	 var url = 'tbRoRobotsInfoController.do?goUpdate&id='+rows[0].id+'&openType=2';
   	 var framename = window.frameElement.name;
   	 url += '&framename='+framename;
   	 addOneTab('修改机器人信息', url);
   }else{
	   tip('请选择一条记录再编辑');
   }
}
//查看
function detail() {
	 var rows = $("#tbRoRobotsInfoList").datagrid('getSelections');
	 if (!rows || rows.length==0) {
			tip($.i18n.prop('read.selectItem'));
			return;
		}
   if (rows.length == 1) {
   	 var url = 'tbRoRobotsInfoController.do?goUpdate&id='+rows[0].id+'&openType=1';
   	 addOneTab('查看任务', url);
   }else{
	   tip('请选择一条记录再查看');
   }
}
 
//硬件设置
function setHardware(id) {
	add('硬件配置', 'tbRoRobotsParamController.do?goSetHardware&robotsInfoId='+id, 'tbRoRobotsModelController.do?doUpdate');
}

//参数设置  
function setParam(id,robotsStatus,robotsName) {
	 if(robotsStatus && robotsStatus == '未连接') { //判断机器人状态是否在线
		tip(robotsName+"机器人状态是未连接");
		return false;
	} 
	//add('参数设置', 'tbRoRobotsParamController.do?goSetParam&robotsInfoId='+id, 'tbRoRobotsModelController.do?doUpdate');
	  var framename = window.frameElement.name;
	 var url = 'tbRoRobotsParamController.do?goSetParam&robotsInfoId='+id;
	 url += '&framename='+framename;
	 addOneTab('参数设置', url); 
}

//巡检点管理
function setPatrol(id,robotsName) {
	addOneTab(robotsName+'巡检点管理', 'tbRoRobotsPatrolPointController.do?list&robotsInfoId='+id);
}

//同步数据
function synchData(id,robotsName,robotsStatus,robotsIp) {
	if(robotsStatus && robotsStatus == '未连接') { //判断机器人状态是否在线
		tip(robotsName+"机器人状态是未连接");
		return false;
	} 
	/* var urlTb ="http://"+'${localhostIP}'+":7002/jk/api/robotconfig";//获取传值的json接口
	var url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient"; //同步数据接口 */
	add('同步数据', 'tbRoRobotsParamController.do?goSynchData&robotsInfoId='+id+'&robotsIp='+robotsIp, 'tbRoRobotsParamController.do?synchData');
}
			function onprogress(evt) {
			    var loaded = 1;     //已经上传大小情况
			    var tot = 2;      //附件总大小
			    var per = Math.floor(100 * loaded / tot);  //已经上传的百分比
			    $("#myProgress").attr("value",per);
			}
//添加页面
function addpage() {
	
	var url = 'tbRoRobotsInfoController.do?goAdd';
	
	addOneTab('机器人录入界面', url);
}

//备份
function backUp(id,robotsName,robotsStatus,computerRoomId) {
	if(robotsStatus && robotsStatus == '未连接') { //判断机器人状态是否在线
		tip(robotsName+"机器人状态是未连接");
		return false;
	}
	addOneTab(robotsName+'备份恢复', 'tbRoRobotsBackupController.do?list&robotsInfoId='+id+'&computerRoomId='+computerRoomId);
}

//固件升级
function firmwareUpdate(id,robotsName,robotsStatus) {
	 if(robotsStatus && robotsStatus == '未连接') { //判断机器人状态是否在线
		tip(robotsName+"机器人状态是未连接");
		return false;
	} 
	addOneTab(robotsName+'固件升级', 'tbRoRobotsFirmwareController.do?list&robotsInfoId='+id);
}

//设备库导入
function deviceslib(id,robotsStatus,robotsName) {
	 if(robotsStatus && robotsStatus == '未连接') { //判断机器人状态是否在线
		tip(robotsName+"机器人状态是未连接");
		return false;
	} 
	addOneTab('设备库导入', 'tbRoRobotsFirmwareController.do?deviceslibList&robotsInfoId='+id);
}
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbRoRobotsInfoController.do?upload', "tbRoRobotsInfoList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbRoRobotsInfoController.do?exportXls","tbRoRobotsInfoList");
}

/* //模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbRoRobotsInfoController.do?goConfirmDepartureTime&robotsIp='+robotsIp,"tbRoRobotsInfoList");
} */

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
//下载

function confirmDepartureTime(robotsIp) {
	openwindow('日志下载', 'tbRoRobotsInfoController.do?goConfirmDepartureTime&robotsIp='+robotsIp, 'tbRoRobotsInfoList',300,200);
}

</script>