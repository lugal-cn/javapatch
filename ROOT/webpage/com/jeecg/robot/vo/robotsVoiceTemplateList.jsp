<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="robotsVoiceTemplateList" checkbox="false" pagination="true" fitColumns="true" 
  	title="语音播报" actionUrl="tbVoVoiceTemplateController.do?robotsVoiceTemplateDatagrid" idField="id" sortName="createTime" sortOrder="desc" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group" width="120"></t:dgCol>
   <t:dgCol title="机器人名称" field="robotsInfoId"  query="true" queryMode="single" dictionary="tb_ro_robots_info,id,robots_name" width="120"></t:dgCol>
   <t:dgCol title="机器人名称" field="robotsName" hidden="true" width="120"></t:dgCol>
   <t:dgCol title="机器人状态" field="robotsStatus" width="120"></t:dgCol>
   <t:dgCol title="当前语音模板" field="voiceTemplateName" width="120"></t:dgCol>
   <t:dgCol title="语音模板数量" field="voiceCount" width="120"></t:dgCol>
   <t:dgCol title="创建时间" field="createTime" hidden="true" width="120"></t:dgCol>
   <t:dgCol title="语音播报状态" field="robotsTemplateFlag" dictionary="itacs_planStatus" width="120"></t:dgCol>
   <t:dgCol title="查看语音模板" field="opt" width="140"></t:dgCol>
   <t:dgFunOpt title="启用" funname="statusChange(id,robotsInfoId,robotsTemplateFlag,robotsName,robotsStatus)" exp="robotsTemplateFlag#eq#2" urlclass="ace_button" ></t:dgFunOpt>
   <t:dgFunOpt title="停用" funname="statusChange(id,robotsInfoId,robotsTemplateFlag,robotsName,robotsStatus)" exp="robotsTemplateFlag#eq#1" urlclass="ace_button" ></t:dgFunOpt>
   <t:dgFunOpt title="管理" funname="patrolPlanList(id,robotsName,robotsStatus)" urlclass="ace_button" ></t:dgFunOpt>
  </t:datagrid> 
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 $("#robotsVoiceTemplateListtb").find("span")[3].style.width="100px"; 
	 
 });
 
//查询巡检计划列表
 function patrolPlanList(id,robotsName,robotsStatus) {
	   if(robotsStatus && robotsStatus == '未连接') { //判断机器人状态是否在线
		tip(robotsName+"机器人状态是未连接");
		return false;
	}  
	var url = 'tbVoVoiceTemplateController.do?list&id='+id;
	addOneTab(robotsName+'语音模板', url);
 }
 
//机器人播报状态启用禁用
 function statusChange(id,robotsInfoId, robotsTemplateFlag,robotsName,robotsStatus){ 
	 if(robotsStatus && robotsStatus == '未连接') { //判断机器人状态是否在线
		tip(robotsName+"机器人状态是未连接");
		return false;
	}
	if (robotsTemplateFlag == 1) {
		robotsTemplateFlag = 2;
	} else {
		robotsTemplateFlag = 1;
	}
	 $.dialog.confirm('请确认是否调整语音播报状态', function(r) {
		if (r) {
		   	$.ajax({
			url:'tbRoRobotsInfoController.do?doUpdate',
			type:'post',
			data:{id: id, robotsTemplateFlag: robotsTemplateFlag},
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success) {
					if (robotsTemplateFlag == 1) {
						tip("语音播报启用成功");
						//调用机器人接口方法
						//voiceAnnoun(true);
					} else {
						tip("语音播报停用成功");
						//调用机器人接口方法
						//voiceAnnoun(false);
					}
					reloadTable();
				} else {
					if (robotsTemplateFlag == 1) {
						tip("语音播报启用失败");
					} else {
						tip("语音播报停用失败");
					}
				}
			}
		});
	}
  });
 }
 
//语音播报 接口调用
 function voiceAnnoun(isFlag) {
	 var status = 0;
	 var msg = "";
	 if(isFlag) { //选中时，启用
		 status = 1;
		 msg = "语音播报启用";
	 } else {
		 status = 0;
		 msg = "语音播报停用";
	 }
	 $.ajax({
		url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
		type : 'post',
		data: JSON.stringify({interfaceNo:"isplayvoice",status:status}),
		datatype:'json',
		cache : false,
		success : function(data) {
			var d = $.parseJSON(data);
			if(d) {
				if (d.ErrorNo == '0') { //成功
					var Message = d.Message;
					//在通知消息里提示信息
					addNoticeMsg("01",msg+"成功");
				} else { //失败
					//在通知消息里提示信息
					addNoticeMsg("01",msg+"失败");
				}
				
			} else {
				if (data.ErrorNo == '0') { //成功
					//在通知消息里提示信息
					addNoticeMsg("01",msg+"成功");
				} else { //失败
					//在通知消息里提示信息
					addNoticeMsg("01",msg+"失败");
				}
				
				
			}
		}
	 });
 }
 
</script>
