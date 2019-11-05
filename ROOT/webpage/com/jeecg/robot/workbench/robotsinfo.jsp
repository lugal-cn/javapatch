<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>机器人信息</title>
    <!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
    <style type="text/css">
    body{
    	width:auto;
    }
    .btn{
        text-align: center;
        width: 100px;
        height: 30px;
        cursor: pointer;
    }
    td {
    	padding: 0px;
    }
    .cmn-toggle {
	  position: absolute;
	  margin-left: -9999px;
	  visibility: hidden;
	}
	.cmn-toggle + label {
	  display: block;
	  position: relative;
	  cursor: pointer;
	  outline: none;
	  user-select: none;
	}
	input.cmn-toggle-round + label {
	  padding: 2px;
	  width: 30px;
	  height: 15px;
	  background-color: #dddddd;
	  border-radius: 15px;
	}
	input.cmn-toggle-round + label:before,
	input.cmn-toggle-round + label:after {
	  display: block;
	  position: absolute;
	  top: 1px;
	  left: 1px;
	  bottom: 1px;
	  content: "";
	}
	input.cmn-toggle-round + label:before {
	  right: 1px;
	  background-color: #f1f1f1;
	  border-radius: 15px;
	  transition: background 0.4s;
	}
	input.cmn-toggle-round + label:after {
	  width: 15px;
	  background-color: #fff;
	  border-radius: 100%;
	  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	  transition: margin 0.4s;
	}
	input.cmn-toggle-round:checked + label:before {
	  background-color: #8ce196;
	}
	input.cmn-toggle-round:checked + label:after {
	  margin-left: 15px;
	}

</style>
    <link rel="stylesheet" href="./webpage/com/jeecg/robot/workbench/myPageStyle.css" type="text/css" />

  </head>
  
  <body marginwidth="0px" marginheight="0px">
  	<div class="myheader">
  		<label style="font-size: 15px;">基础信息</label>
  		<hr>
 	</div>
  	<table width="100%" height="80%" cellspacing="0px;" style="padding:0px 20px;">
    	<tr>
            <td colspan="6" rowspan="1" style="text-align: center;">
            	名称：<input type="text" id="robotsInfoId" name="robotsInfoId" onchange="queryxunjian(this.value);">
            </td>
        </tr>
        <tr>
            <td colspan="2" rowspan="1" style="border: 0px solid #000; border-left: 0px; border-right: 0px;">
            	型号：<label id="robotModel"></label>
            	<input type="hidden" id="computerRoomId" />
            	<input type="hidden" id="robotsIp" />
            	<input type="hidden" id="robotsName" />
            </td>
            <td colspan="2" rowspan="1"  style="border: 0px solid #000; border-right: 0px;">
            	状态：<label id="robotStatus"></label>
            	<input type="hidden" id="robotStatusCode" />
            </td>
            <td colspan="2" rowspan="1"  style="border: 0px solid #000; border-right: 0px;">
            	电量：<label id="power"></label>
            </td>
        </tr>
        <tr>
            <td colspan="6" rowspan="1" style="text-align: center;">
            	<a href="#" onclick="gobakPower()" class="ace_button mybtn">回桩充电 </a>
            	<a href="#" onclick="immePatrol()" class="ace_button mybtn">立即巡检 </a>
            	<a href="#" onclick="fixedPatrol()" class="ace_button mybtn">定点巡检 </a>
            	<a href="#" onclick="remoteControl()" class="ace_button mybtn">远程控制 </a>
            </td>
        </tr>
        <%-- <tr>
            <td colspan="3" rowspan="1" style="text-align: center;">
            	<input type="button" value="回桩充电" onclick="gobakPower()" class="btn"/>
            	<a href="#" onclick="gobakPower()" class="ace_button mybtn">&nbsp;&nbsp;回桩充电 &nbsp;&nbsp;</a>
            </td>
            <td colspan="3" rowspan="1" style="text-align: center;">
            	<input type="button" value="立即巡检" onclick="immePatrol()" class="btn"/>
            	<a href="#" onclick="immePatrol()" class="ace_button mybtn">&nbsp;&nbsp;立即巡检 &nbsp;&nbsp;</a>
            </td>
        </tr>
        <tr>
            <td colspan="3" rowspan="1" style="text-align: center;">
            	<input type="button" value="定点巡检" onclick="fixedPatrol()" class="btn"/>
            	<a href="#" onclick="fixedPatrol()" class="ace_button mybtn">&nbsp;&nbsp;定点巡检 &nbsp;&nbsp;</a>
            </td>
            <td colspan="3" rowspan="1" style="text-align: center;">
            	<input type="button" value="远程控制" onclick="remoteControl()" class="btn"/>
            	<a href="#" onclick="remoteControl()" class="ace_button mybtn">&nbsp;&nbsp;远程控制 &nbsp;&nbsp;</a>
            </td>
        </tr> --%>
        <tr>
            <td colspan="2" rowspan="1" style="text-align: right;">
            	语音播报
            </td>
            <td colspan="1" rowspan="1" style="text-align: left;">
            	<div class="switch">
				  <input id="cmn-toggle-1" class="cmn-toggle cmn-toggle-round"  type="checkbox" onclick="voiceAnnoun(this)">
				  <label id="lable-1" for="cmn-toggle-1"></label>
				</div>
            </td>
            <td colspan="2" rowspan="1" style="text-align: right;">
            	语音交互
            </td>
            <td colspan="1" rowspan="1" style="text-align: left;">
            	<div class="switch">
				  <input id="cmn-toggle-2" class="cmn-toggle cmn-toggle-round" type="checkbox" onclick="voiceInteraction(this)">
				  <label id="lable-2" for="cmn-toggle-2"></label>
				</div>
            </td>
        </tr>
       </table>
</body>
 <script type="text/javascript">
 
 $(document).ready(function() {
	 var selectedId = "";
 /*-------------------------------------------所属机器人----------------------------------------------*/
	var select2Data = new Array();
	$.ajax({
		url:'tbPaPatrolTaskController.do?robotsInfoSelect',
		type:'GET',
		dataType:'JSON',
		delay: 250,
		cache: true,
		success: function(data){
			for(var i = 0; i < data.length; i++){
				var select2Obj = {};
				if (i == 0) {
					selectedId = data[i][0];
				}
				select2Obj.id = data[i][0];
				select2Obj.text = data[i][1];
				select2Data.push(select2Obj);
			}
			$("#robotsInfoId").select2({
				data: select2Data,
				placeholder:'请选择所属机器人',//默认文字提示
			    language: "zh-CN",//汉化
			    allowClear: true//允许清空
			});
			$("#robotsInfoId").val(selectedId).trigger('change'); //默认选中第一个
		}
	});
	/*-------------------------------------------所属机器人----------------------------------------------*/
 });
 
 //判断机器人是否在线
 function isConn () {
	 var robotStatus = $("#robotStatus").text();
	 var robotStatusCode = $("#robotStatusCode").val();
	 if(robotStatusCode && robotStatusCode != "1") { //机器人在线
		 return true;
	 } else { //机器人不在线
		 tip("机器人未连接！");
	 	 return false;
	 }
 }
 
 //判断机器人是否在线
 function isLogin () {
	 var robotsIp = $("#robotsIp").val();
	 var isLoginFlag = false;
	 $.ajax({
			url : "workbenchController.do?getRobotUserByRobotIp",
			type : 'post',
			data : {robotIp:robotsIp},
			cache : false,
			async : false,
			success : function(data) {
				var d = $.parseJSON(data);
				if(d && d.obj) {
					isLoginFlag = true;
				} else {
					isLoginFlag = false;
				}
			}
	 });
	 return isLoginFlag;
 }
 
 //机器人改变事件
 function queryxunjian(obj){
	//获取机器人型号
	getRobotModel(obj);
	//获取机器人电量、状态
	
	//任务队列
	
	//3D机房地图及巡检
	
	//机器人巡检直播视频画面
	
	//机器人巡检热成像画面
	
	//告警信息
	
	//通知消息
	
 }
 
 //获取机器人型号
 function getRobotModel(robotId) {
	 $.ajax({
		url : "workbenchController.do?getRobotModelByRobotId",
		type : 'post',
		data : {id:robotId},
		cache : false,
		success : function(data) {
			var d = $.parseJSON(data);
			var robotsIp;
			if(d && d.attributes) {
				$("#robotModel").text(d.attributes.robotsModel);
				$("#computerRoomId").val(d.attributes.computerRoomId);
				$("#robotsName").val(d.attributes.robotsName);
				robotsIp = d.attributes.robotsIp;
				$("#robotsIp").val(d.attributes.robotsIp);
				 if(d.attributes.robotsTemplateFlag==1){
					 $("#cmn-toggle-1").attr("checked",true);
				 }
				 else{
					 $("#cmn-toggle-1").attr("checked",false);
				 }
				 if(d.attributes.robotsInteractionlag==1){
					 $("#cmn-toggle-2").attr("checked",true);
				 }
				 else{
					 $("#cmn-toggle-2").attr("checked",false);
				 }
			}
			$("#power").text("--");
		    $("#robotStatus").text("未连接");
		    $("#robotStatusCode").val("1");
			//调用通知页面加载数据方法
			window.parent.frames['iframe_noticemessage'].reloadData(robotId);
			//调用告警页面加载数据方法
			window.parent.frames['iframe_alarminfo'].reloadData(robotId);
			//调用机房地图页面
			window.parent.document.getElementById('iframe_computerroom').src = "workbenchController.do?computerroom&robotId="+robotId;
			//调用任务队列页面
			window.parent.document.getElementById('iframe_patroltask').src = "workbenchController.do?patroltask&robotsIp="+robotsIp+"&robotId="+robotId;
			// window.parent.document.getElementById('iframe_patroltask').src = "workbenchController.do?websocketTest&robotsIp="+robotsIp+"&robotId="+robotId; 
			//调用巡检直播画面
			window.parent.document.getElementById('iframe_livecameras').src = "workbenchController.do?livecameras&robotsIp="+robotsIp+"&robotId="+robotId;
			//调用热成像画面
			window.parent.document.getElementById('iframe_imgcameras').src = "workbenchController.do?imgcameras&robotsIp="+robotsIp+"&robotId="+robotId;
			//重新调用websocket连接， 获取机器人电量、状态
			connWebSocket(robotId);
		}
	});
 }
 
 //立即充电 /*{"ErrorNo": 0,"Message": "成功" }*/ 是否要传机器人地址  ErrorNo: 0 成功；-1 失败；1 执行命令中；
function gobakPower() {
	var robot_ip = $("#robotsIp").val();
	var robotId = $("#robotsInfoId").val();
	var robotStatus = $("#robotStatus").text();
	var robotStatusCode = $("#robotStatusCode").val();
	if(!robotId) {
		tip("请先选择机器人");
		return;
	}
	if(!isConn()) { //判断机器人是否在线
		 return false;
	 }
	//0,待命中 2,回充 3,低电回充 4,充电中 5,任务中 6,引导中 7, 录像中 8 ,控制中
	if(robotStatusCode && robotStatusCode==5){
		if(!isLogin()) { //判断机器人是否有用户在登录  未登录
			 //弹出确认在平台
			 var confirmUrl = 'workbenchController.do?confirmBakPower';
			 //获取任务数量
			 var taskNum = window.parent.frames['iframe_patroltask'].taskNum;
			 if(taskNum && taskNum == 1) {
				 confirmUrl = 'workbenchController.do?confirmBakPower';
			 } else if(taskNum && taskNum > 1) {
				 confirmUrl = 'workbenchController.do?confirmBakPower2';
			 } else {
				 confirmUrl = 'workbenchController.do?confirmBakPower';
			 }
			$.dialog({
				content: 'url:'+confirmUrl,
				lock : true,
				width: "500px",
				height: "200",
				title:"系统提示",
				opacity : 0.3,
				cache:false, 
				okVal: $.i18n.prop('dialog.submit'),
				ok:function() {
					iframe = this.iframe.contentWindow;
					var checkValue = iframe.$("input[type='radio']:checked").val();
					var chare_time = iframe.$("#chare_time").val();
					if(checkValue && checkValue == 1) { //终止当前任务，执行回桩充电
						//调用切换机器人状态 接口 
						var robotStateData = {interfaceNo:"changeRobotState", status:"2", taskid:"", chare_time:chare_time, robotId:robotId};
						$.ajax({
							url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
							type : 'post',
							data: JSON.stringify(robotStateData),
							datatype:'json',
							cache : false,
							success : function(data) {
								var d = $.parseJSON(data);
								var msg = "终止当前任务，执行回桩充电";
								if(d) {
									if (d.ErrorNo == '0') {
										addNoticeMsg("01",msg+"成功");
									} else if(d.ErrorNo == '-1') {
										addNoticeMsg("03",msg+"失败");
									} else if(d.ErrorNo == '1') {
										addNoticeMsg("02",msg+"警告："+d.Message);
									} else if(d.ErrorNo == '2') {
										addNoticeMsg("01",msg+"弹窗确认中");
									} else {
										//其他
										addNoticeMsg("03",msg+"失败");
									}
								} else {
								}
								//调用通知页面加载数据方法
								window.parent.frames['iframe_noticemessage'].reloadData(robotId);
							}
						});
					} else { //取消回桩充电，继续执行当前任务（30s后未选择，则默认选择此项）
					}
				},
			    cancelVal: $.i18n.prop('dialog.close'),
			    cancel: true /*为true等价于function(){}*/
			});
		 } else { //有用户登录
			 //弹出确认在机器人
			 //addNoticeMsg("01","机器人弹窗确认中");
			 $.ajax({
					url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
					type : 'post',
					data: JSON.stringify({interfaceNo:"charge",robot_ip:robot_ip}),
					datatype:'json',
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if(d) {
							if (d.ErrorNo == '0') {
								addNoticeMsg("01",msg+"成功");
							} else if(d.ErrorNo == '-1') {
								addNoticeMsg("03",msg+"失败");
							} else if(d.ErrorNo == '1') {
								addNoticeMsg("02",msg+"警告："+d.Message);
							} else if(d.ErrorNo == '2') {
								addNoticeMsg("01",msg+"弹窗确认中");
							} else {
								//其他
								addNoticeMsg("03",msg+"失败");
							}
						} else {
						}
						//调用通知页面加载数据方法
						window.parent.frames['iframe_noticemessage'].reloadData(robotId);
					}
				});
		 }
	} else { //回桩充电
		$.ajax({
			url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
			type : 'post',
			data: JSON.stringify({interfaceNo:"charge",robot_ip:robot_ip}),
			datatype:'json',
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				if(d) {
					if (d.ErrorNo == '0') {
						addNoticeMsg("01",msg+"成功");
					} else if(d.ErrorNo == '-1') {
						addNoticeMsg("03",msg+"失败");
					} else if(d.ErrorNo == '1') {
						addNoticeMsg("02",msg+"警告："+d.Message);
					} else if(d.ErrorNo == '2') {
						addNoticeMsg("01",msg+"弹窗确认中");
					} else {
						//其他
						addNoticeMsg("03",msg+"失败");
					}
				} else {
				}
				//调用通知页面加载数据方法
				window.parent.frames['iframe_noticemessage'].reloadData(robotId);
			}
		});
	}
	
	/* var msg = "回桩充电";
	$.dialog.confirm('确认要回桩充电？<br/>回桩充电会取消当前任务。', function(r) {
		   if (r) {
				$.ajax({
					url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
					type : 'post',
					data: JSON.stringify({interfaceNo:"charge",robot_ip:robot_ip}),
					datatype:'json',
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if(d) {
							if (d.ErrorNo == '0') {
								addNoticeMsg("01",msg+"成功");
							} else if(d.ErrorNo == '-1') {
								addNoticeMsg("03",msg+"失败");
							} else if(d.ErrorNo == '1') {
								addNoticeMsg("02",msg+"警告："+d.Message);
							} else if(d.ErrorNo == '2') {
								addNoticeMsg("01",msg+"弹窗确认中");
							} else {
								//其他
							}
						} else {
						}
						//调用通知页面加载数据方法
						window.parent.frames['iframe_noticemessage'].reloadData(robotId);
					}
				});
			}
	}); */
}
 
//加入任务队列
function immePatrol() {
	var robot_ip = $("#robotsIp").val();
	var robotId = $("#robotsInfoId").val();
	var robotStatus = $("#robotStatus").text();
	var robotStatusCode = $("#robotStatusCode").val();
	if(!robotId) {
		tip("请先选择机器人");
		return;
	}
	if(!isConn()) { //判断机器人是否在线
		 return false;
	}
	//0,待命中 2,回充 3,低电回充 4,充电中 5,任务中 6,引导中 7, 录像中 8 ,控制中
	if(robotStatusCode && robotStatusCode==8){
		if(!isLogin()) { //判断机器人是否有用户在登录  未登录
			 //弹出确认在平台
			 var confirmUrl = 'workbenchController.do?confirmTask';
			$.dialog({
				content: 'url:'+confirmUrl,
				lock : true,
				width: "500px",
				height: "200",
				title:"系统提示",
				opacity : 0.3,
				cache:false, 
				okVal: $.i18n.prop('dialog.submit'),
				ok:function() {
					iframe = this.iframe.contentWindow;
					var checkValue = iframe.$("input[type='radio']:checked").val();
					if(checkValue && checkValue == 1) { //终止当前任务，执行远程控制
						//调用切换机器人状态 接口 
						var robotStateData = {interfaceNo:"changeRobotState", status:"5", taskid:"", chare_time:"0", robotId:robotId};
						$.ajax({
							url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
							type : 'post',
							data: JSON.stringify(robotStateData),
							datatype:'json',
							cache : false,
							success : function(data) {
								var d = $.parseJSON(data);
								var msg = "终止远程控制，将巡检任务加入到任务队列，并立即执行任务队列中巡检任务"
								if(d) {
									if (d.ErrorNo == '0') { //弹出加入任务队列的选择窗口
										addNoticeMsg("01",msg+"成功");
										var title = "加入任务队列";
										var url = 'workbenchController.do?immePatrol&robotId='+robotId+'&robotIp='+robot_ip;
										$.dialog({
											content: 'url:'+url,
											lock : true,
											zIndex: getzIndex(),
											width:300,
											height:200,
											title:title,
											opacity : 0.3,
											cache:false,
										    ok: function(){
										    	iframe = this.iframe.contentWindow;
										    	var patrolTaskId = iframe.$("#patrolTaskId").val();
										    	var patrolTaskName = iframe.$('#patrolTaskId').select2('data')[0].text;
										    	doImmePatrol(robot_ip, patrolTaskId, patrolTaskName);
												return true;
										    },
										    okVal: "加入任务队列",
										    cancelVal: "取消",
										    cancel: true 
										});
									} else if(d.ErrorNo == '-1') {
										addNoticeMsg("03",msg+"失败");
									} else {
										//其他
									}
								} else {
								}
								//调用通知页面加载数据方法
								window.parent.frames['iframe_noticemessage'].reloadData(robotId);
							}
						});
					} else { //取消远程控制，继续执行当前任务（30s后未选择，则默认选择此项）
					}
				},
			    cancelVal: $.i18n.prop('dialog.close'),
			    cancel: true /*为true等价于function(){}*/
			});
		 } else { //有用户登录
			 //弹出确认在机器人
			 addNoticeMsg("01","机器人弹窗确认中");
		 }
	} else {
		var title = "加入任务队列";
		var url = 'workbenchController.do?immePatrol&robotId='+robotId+'&robotIp='+robot_ip;
		$.dialog({
			content: 'url:'+url,
			lock : true,
			zIndex: getzIndex(),
			width:300,
			height:200,
			title:title,
			opacity : 0.3,
			cache:false,
		    ok: function(){
		    	iframe = this.iframe.contentWindow;
		    	var patrolTaskId = iframe.$("#patrolTaskId").val();
		    	var patrolTaskName = iframe.$('#patrolTaskId').select2('data')[0].text;
		    	doImmePatrol(robot_ip, patrolTaskId, patrolTaskName);
				return true;
		    },
		    okVal: "加入任务队列",
		    cancelVal: "取消",
		    cancel: true /*为true等价于function(){}*/
		});
	}
}

//立即执行巡检任务
function doImmePatrol(robot_ip, patrolTaskId, patrolTaskName){
	if(!isConn()) { //判断机器人是否在线
		 return false;
	 }
	if(patrolTaskId) {
		var msg = "加入任务队列【"+patrolTaskName+"】";
		 $.ajax({
				url:'workbenchController.do?selectgotoWork',
				type:'post',
				data:{id:patrolTaskId},
				dataType:'JSON',
				cache: false,
				async:false,
				success: function(datas){
					 datas.interfaceNo="gotowork";
					 datas.robotsIp=robot_ip;
					$.ajax({
						url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
						type : 'post',
						data: JSON.stringify(datas),
						datatype:'json',
						cache : false,
						success : function(data) {
							var d = $.parseJSON(data);
							if(d) {
								if (d.ErrorNo == '0') {
									addNoticeMsg("01",msg+"成功");
								} else if(d.ErrorNo == '-1') {
									addNoticeMsg("03",msg+"失败");
								} else if(d.ErrorNo == '1') {
									addNoticeMsg("02",msg+"警告："+d.Message);
								} else if(d.ErrorNo == '2') {
									addNoticeMsg("01",msg+"弹窗确认中");
								} else {
									//其他
								}
							} else {
								if (data.ErrorNo == '0') {
									addNoticeMsg("01",msg+"成功");
								} else if(data.ErrorNo == '-1') {
									addNoticeMsg("01",msg+"失败");
								} else if(data.ErrorNo == '1') {
									addNoticeMsg("01",msg+"执行中");
								} else {
									//其他
								}
							}
							//调用通知页面加载数据方法
							window.parent.frames['iframe_noticemessage'].reloadData(robotId);
						}
					});
					
				}
			});  
	} else {
		tip("没有选择巡检任务");
	}
}

//定点巡检
function fixedPatrol() {
	var robot_ip = $("#robotsIp").val();
	var robotId = $("#robotsInfoId").val();
	var robotsName = $("#robotsName").val();
	var robotStatus = $("#robotStatus").text();
	var robotStatusCode = $("#robotStatusCode").val();
	if(!robotId) {
		tip("请先选择机器人");
		return;
	}
	if(!isConn()) { //判断机器人是否在线
		 return false;
	}
	//0,待命中 2,回充 3,低电回充 4,充电中 5,任务中 6,引导中 7, 录像中 8 ,控制中
	if(robotStatusCode && robotStatusCode==8){
		if(!isLogin()) { //判断机器人是否有用户在登录  未登录
			 //弹出确认在平台
			 var confirmUrl = 'workbenchController.do?confirmTask';
			$.dialog({
				content: 'url:'+confirmUrl,
				lock : true,
				width: "500px",
				height: "200",
				title:"系统提示",
				opacity : 0.3,
				cache:false, 
				okVal: $.i18n.prop('dialog.submit'),
				ok:function() {
					iframe = this.iframe.contentWindow;
					var checkValue = iframe.$("input[type='radio']:checked").val();
					if(checkValue && checkValue == 1) { //终止当前任务，执行远程控制
						//调用切换机器人状态 接口 
						var robotStateData = {interfaceNo:"changeRobotState", status:"5", taskid:"", chare_time:"0", robotId:robotId};
						$.ajax({
							url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
							type : 'post',
							data: JSON.stringify(robotStateData),
							datatype:'json',
							cache : false,
							success : function(data) {
								var d = $.parseJSON(data);
								var msg = "终止远程控制，将巡检任务加入到任务队列，并立即执行任务队列中巡检任务"
								if(d) {
									if (d.ErrorNo == '0') { //跳转到定点巡检页面
										addNoticeMsg("01",msg+"成功");
										var url = 'workbenchController.do?fixedPatrol&robotId='+robotId;
										url += '&robot_ip='+robot_ip;
										addOneTab(robotsName+'定点巡检', url);
									} else if(d.ErrorNo == '-1') {
										addNoticeMsg("03",msg+"失败");
									} else {
										//其他
									}
								} else {
								}
								//调用通知页面加载数据方法
								window.parent.frames['iframe_noticemessage'].reloadData(robotId);
							}
						});
					} else { //取消远程控制，继续执行当前任务（30s后未选择，则默认选择此项）
					}
				},
			    cancelVal: $.i18n.prop('dialog.close'),
			    cancel: true /*为true等价于function(){}*/
			});
		 } else { //有用户登录
			 //弹出确认在机器人
			 addNoticeMsg("01","机器人弹窗确认中");
		 }
	} else {
		var url = 'workbenchController.do?fixedPatrol&robotId='+robotId;
		url += '&robot_ip='+robot_ip;
		addOneTab(robotsName+'定点巡检', url);
	}
}

//远程控制
var taskCurNum = 0;
function remoteControl() {
	var robot_ip = $("#robotsIp").val();
	var robotId = $("#robotsInfoId").val();
	var robotsName = $("#robotsName").val();
	var robotStatus = $("#robotStatus").text();
	var robotStatusCode = $("#robotStatusCode").val();
	if(!robotId) {
		tip("请先选择机器人");
		return;
	}
	if(!isConn()) { //判断机器人是否在线
		 return false;
	 }
	//0,待命中 2,回充 3,低电回充 4,充电中 5,任务中 6,引导中 7, 录像中 8 ,控制中
	if(robotStatusCode && robotStatusCode==5){
		if(!isLogin()) { //判断机器人是否有用户在登录  未登录
			 //弹出确认在平台
			 var confirmUrl = 'workbenchController.do?confirmControl';
			$.dialog({
				content: 'url:'+confirmUrl,
				lock : true,
				width: "500px",
				height: "200",
				title:"系统提示",
				opacity : 0.3,
				cache:false, 
				okVal: $.i18n.prop('dialog.submit'),
				ok:function() {
					iframe = this.iframe.contentWindow;
					var checkValue = iframe.$("input[type='radio']:checked").val();
					if(checkValue && checkValue == 1) { //终止当前任务，执行远程控制
						//调用切换机器人状态 接口 
						var robotStateData = {interfaceNo:"changeRobotState", status:"8", taskid:"", chare_time:"0", robotId:robotId};
						$.ajax({
							url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
							type : 'post',
							data: JSON.stringify(robotStateData),
							datatype:'json',
							cache : false,
							success : function(data) {
								var d = $.parseJSON(data);
								var msg = "终止当前任务，执行远程控制"
								if(d) {
									if (d.ErrorNo == '0') { //跳转到远程控制页面
										taskCurNum = window.parent.frames['iframe_patroltask'].taskNum;//记录当前任务队列的任务数量
										addNoticeMsg("01",msg+"成功");
										var url = 'workbenchController.do?remoteControl&robotId='+robotId;
										url += '&robotIp='+robot_ip;
										addOneTab(robotsName+'远程控制', url);
									} else if(d.ErrorNo == '-1') {
										addNoticeMsg("03",msg+"失败");
									} else {
										//其他
									}
								} else {
								}
								//调用通知页面加载数据方法
								window.parent.frames['iframe_noticemessage'].reloadData(robotId);
							}
						});
					} else { //取消远程控制，继续执行当前任务（30s后未选择，则默认选择此项）
					}
				},
			    cancelVal: $.i18n.prop('dialog.close'),
			    cancel: true /*为true等价于function(){}*/
			});
		  } else { //有用户登录
			 //跳转到控制页面
			  var url = 'workbenchController.do?remoteControl&robotId='+robotId;
			  url += '&robotIp='+robot_ip;
			  addOneTab(robotsName+'远程控制', url);
		 }
	} else {
		var url = 'workbenchController.do?remoteControl&robotId='+robotId;
		url += '&robotIp='+robot_ip;
		addOneTab(robotsName+'远程控制', url);
	}
}
 
 //语音播报  status: 0 否，1 是；
 function voiceAnnoun(obj) {
	 var isFlag = $("#cmn-toggle-1").is(':checked');
	 if(!isConn()) { //判断机器人是否在线
	 if(isFlag){
		 $("#cmn-toggle-1").attr("checked",false);
	 }else{
		 $("#cmn-toggle-1").attr("checked",true);
	 }
		 return false;
	 
	 }
	 var robot_ip = $("#robotsIp").val();
	 var robotId = $("#robotsInfoId").val();
	 if(!robotId) {
			tip("请先选择机器人");
			return;
	 }
	
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
		url : "http://"+'${localhostIP}'+":7002/jk/api/isplayvoiceSZ",
		type : 'post',
		data: JSON.stringify({interfaceNo:"isplayvoice",status:status,robotId:robotId, robot_ip:robot_ip}),
		datatype:'json',
		cache : false,
		success : function(data) {
			var d = $.parseJSON(data);
			if(d) {
				if (d.ErrorNo == '0') {
					 var Message = d.Message;
					 addNoticeMsg("01",msg+"成功");
				} else {
					addNoticeMsg("01",msg+"失败");
				}
				
			} else {
				if (data.ErrorNo == '0') {
					//添加通知消息
					addNoticeMsg("01",msg+"成功");
				} else {
					addNoticeMsg("01",msg+"失败");
				}
				
				
			}
		}
	 }); 
 }
 
 //语音交互
 function voiceInteraction(obj) {
	 var isFlag = $("#cmn-toggle-2").is(':checked');
	 if(!isConn()) { //判断机器人是否在线
		 if(isFlag){
			 $("#cmn-toggle-2").attr("checked",false);
		 }else{
			 $("#cmn-toggle-2").attr("checked",true);
		 }
		 return false;
	 }
	 var robot_ip = $("#robotsIp").val();
	 var robotId = $("#robotsInfoId").val();
	 if(!robotId) {
			tip("请先选择机器人");
			return;
	 }
	
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
			url : "http://"+'${localhostIP}'+":7002/jk/api/isvoiceanswerSZ",
			type : 'post',
			data: JSON.stringify({interfaceNo:"isvoiceanswer",status:status,robotId:robotId, robot_ip:robot_ip}),
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
 
 //添加通知消息 : noticeMessageType消息类型、 noticeMessageContent消息内容
 function addNoticeMsg(noticeMessageType, noticeMessageContent){
	 $.ajax({
			url : "workbenchController.do?addNoticeMsg",
			type : 'post',
			data: {noticeMessageType: noticeMessageType,
				     computerRoomId:$("#computerRoomId").val(),
				     robotsInfoId:$("#robotsInfoId").val(),//对象机器人信息表ID，平台发起和接受对象
				     noticeMessageContent:noticeMessageContent //消息内容
			     },
			cache : false,
			success : function(data) {
				//调用通知页面加载数据方法
				window.parent.frames['iframe_noticemessage'].reloadData($("#robotsInfoId").val());
			}
		 });
 }
 
 //获取接口路径 interface_no
function getInterUrl(interfaceNo) {
	var interfaceUrl = "";
	$.ajax({
		url : "workbenchController.do?getInterUrl",
		type : 'post',
		data: {interfaceNo: interfaceNo},
		cache : false,
		async : false,
		success : function(data) {
			var d = $.parseJSON(data);
			interfaceUrl = d.attributes.interfaceUrl;
		}
	});
	return interfaceUrl;
}

 var robot_id = "";
 var websocket = null;
 var addrIp = '<%=request.getRemoteAddr()%>';
//根据机器人IP切换webSocket路径
function connWebSocket(robotId) {
	robot_id = robotId;
	//判断当前浏览器是否支持WebSocket
	if('WebSocket' in window){
		if(websocket != null){
			websocket.close();
			websocket = null;
		}
	   var wsUrl = "ws://"+'${localhostIP}'+":7002/api/robotinfo/"+robotId+"admin"+addrIp;
	   //var wsUrl = "ws://localhost:7002/api/robotinfo/"+robotId+"admin";
	   websocket = new WebSocket(wsUrl);
	}else{
	   alert('Not support websocket');
	}

	//连接发生错误的回调方法
	websocket.onerror = function(){
	   //setMessageInnerHTML("error");
	};

	//连接成功建立的回调方法
	websocket.onopen = function(event){
	   //setMessageInnerHTML("open");
	};

	//接收到消息的回调方法
	websocket.onmessage = function(event){
	     setMessageInnerHTML(event.data);
	};

	//连接关闭的回调方法
	websocket.onclose = function(){
	   //setMessageInnerHTML("close");
	};

	
}
//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
window.onbeforeunload = function(){
	console.log("onbeforeunload");
	if (websocket != null) {
		websocket.close();
	}
};
var webData;
//将消息显示在网页上
function setMessageInnerHTML(innerHTML){
   if(innerHTML) {
	   var d = $.parseJSON(innerHTML);
	  // $("#webData").val(d);
	   webData = d;
	   if(d.robot_id == robot_id) { //首页是当前选择的机器人
		   $("#power").text(d.power+"%");
		   $("#robotStatus").text(getRobotsStatus(d.robot_status, d.charger, d.task_type));
		 	//加载机房动环数据
		 	var flag = true;
		    setInterval(function(){
		    	if(flag) {
		    		var criframe = window.parent.frames['iframe_computerroom'];
			 		var robotInfo = criframe.$("#robot_info");
			 		if(robotInfo) {
			 			flag = false;
			 			criframe.setRobotInfo(d);
			 		}
		    	}
		   },500);
	   } else {
			window.parent.frames['iframe_computerroom'].setRobotInfo("");
	   }
   } else {
	   $("#power").text("--");
	   $("#robotStatus").text("未连接");
	   $("#robotStatusCode").val("1");
	   window.parent.frames['iframe_computerroom'].setRobotInfo("");
   }
}

//0,待命中 2,回充 3,低电回充 4,充电中 5,任务中 6,引导中 7, 录像中 8 ,控制中
function getRobotsStatus (robotStatus,charger,task_type) {
	var str;
	var strCode;
	if(robotStatus) {
		if(robotStatus == 0) {
			str = "待命中";
		} else if(robotStatus == 2) {
			str = "回充";
		} else if(robotStatus == 3) {
			str = "低电回充";
		} else if(robotStatus == 4) {
			str = "充电中";
			//增加手工/自动区分
			if(charger) {
				if(charger == 3) {
					str = "自动充电中";
				} else if(charger == 4) {
					str = "手动充电中";
				}
			}
		} else if(robotStatus == 5) {
			str = "任务中";
			//增加 日常/定点巡检任务中区分 
			if(task_type) {
				if(task_type == 'daily') {
					str = "日常巡检中";
				} else if(task_type == 'fixed') {
					str = "定点巡检中";
				}
			}
		} else if(robotStatus == 6) {
			str = "引导中";
		} else if(robotStatus == 7) {
			str = "录像中";
		} else if(robotStatus == 8) {
			str = "控制中";
		} else {
			str = "未连接";
			strCode = 1;
		}
		strCode = robotStatus;
	} else {
		str = "未连接";
		strCode = 1;
	}
	$("#robotStatusCode").val(strCode);
	return str;
}

</script>
</html>
