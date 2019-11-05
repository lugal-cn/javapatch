<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbVoVoiceInteractionList" checkbox="false" pagination="true" fitColumns="true" 
  	title="语音交互" actionUrl="tbVoVoiceInteractionController.do?datagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol> 
   <t:dgCol title="机器人名称"  field="robotsInfoId" dictionary="tb_ro_robots_info,id,robots_name" queryMode="single" query="true"  width="120"></t:dgCol>
   <t:dgCol title="机器人状态" field="robotsStatus" width="120"></t:dgCol>
   <t:dgCol title="关键词数量"  field="keyWordNum"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建时间" field="createTime" hidden="true" width="120"></t:dgCol>
   <t:dgCol title="语音交互状态"  field="robotsInteractionFlag" dictionary="itacs_planStatus" width="120"></t:dgCol>
   <t:dgCol title="查看关键词" field="opt" width="100"></t:dgCol>
   <t:dgFunOpt title="启用" funname="statusChange(id,robotsInfoId,robotsInteractionFlag,robotsStatus)" exp="robotsInteractionFlag#eq#2" urlclass="ace_button" ></t:dgFunOpt>
   <t:dgFunOpt title="停用" funname="statusChange(id,robotsInfoId,robotsInteractionFlag,robotsStatus)" exp="robotsInteractionFlag#eq#1" urlclass="ace_button" ></t:dgFunOpt>
   <t:dgFunOpt title="管理" funname="seeVoiceInteraction(robotsInfoId,robotsInteractionFlag,robotsStatus)" urlclass="ace_button" ></t:dgFunOpt>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 $("#tbVoVoiceInteractionListtb").find("span")[3].style.width="90px"; 
	 gridname="tbVoVoiceInteractionList";
 });
 
 //查看
 function seeVoiceInteraction(obj,robotsInteractionFlag,robotsStatus){
	 if(robotsStatus && robotsStatus == '未连接') { //判断机器人状态是否在线
		tip("机器人状态是未连接");
		return false;
	}
	 var framename = window.frameElement.name;
	 var url = 'tbVoVoiceInteractionController.do?goUpdate&robotsInfoId='+obj;
	 url += '&framename='+framename+'&robotsInteractionFlag='+robotsInteractionFlag;
	addOneTab('语音交互编辑', url); }
 
//机器人交互状态启用禁用
 function statusChange(id,robotsInfoId, robotsInteractionFlag, robotsStatus){
	 if(robotsStatus && robotsStatus == '未连接') { //判断机器人状态是否在线
		tip("机器人状态是未连接");
		return false;
	}
	if (robotsInteractionFlag == 1) {
		robotsInteractionFlag = 2;
	} else {
		robotsInteractionFlag = 1;
	}
	 $.dialog.confirm('请确认是否调整语音交互状态', function(r) {
		if (r) {
		   	$.ajax({
			url:'tbRoRobotsInfoController.do?doUpdate',
			type:'post',
			data:{id: id, robotsInteractionFlag: robotsInteractionFlag},
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success) {
					if (robotsInteractionFlag == 1) {
						tip("语音交互启用成功");
						//调用机器人接口方法
						voiceInteraction(true,robotsInfoId);
					} else {
						tip("语音交互停用成功");
						//调用机器人接口方法
						voiceInteraction(false,robotsInfoId);
					}
					reloadTable();
				} else {
					if (robotsInteractionFlag == 1) {
						tip("语音交互启用失败");
					} else {
						tip("语音交互停用失败");
					}
				}
			}
		});
	}
  });
 }
 
//语音交互 接口调用
 function voiceInteraction(isFlag, robotsInfoId) {
	 var status = 0;
	 var msg = "";
	 if(isFlag) { //选中时，启用
		 status = 1;
		 msg = "语音交互启用";
	 } else {
		 status = 0;
		 msg = "语音交互停用";
	 }
	 $.ajax({
		url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
		type : 'post',
		data: JSON.stringify({interfaceNo:"isvoiceanswer",status:status, robotId:robotsInfoId}),
		datatype:'json',
		cache : false,
		success : function(data) {
			var d = $.parseJSON(data);
			if(d) {
				if (d.ErrorNo == '0') { //成功
				} else { //失败
				}
			} else {
				if (data.ErrorNo == '0') { //成功
				} else { //失败
				}
			}
		}
	 });
 }
 
</script>
