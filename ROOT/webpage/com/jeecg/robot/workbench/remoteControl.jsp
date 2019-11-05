<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>远程控制</title>
    <link href="http://vjs.zencdn.net/5.20.1/video-js.css" rel="stylesheet">
	<script src="http://vjs.zencdn.net/5.20.1/video.js"></script>
    <style type="text/css">
    
    	.cmn-toggle {
		  position: absolute;
		  margin-left: -99999px;
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
		
		.pic_div{
	        position: relative;
	        background-color: white;
	        border: 0px dotted red;
	        margin: 10px auto;
	    }
	    .pic{
	        width: 100%;
	        height: auto;
	    }
	    .btn{
				width: 100px;
				height: 30px;
				background: green;
				border: none;
				color: white;
				margin: 6px 10px;
			}
			.btnStyle1{
				border-radius: 6px;
			}
			.btnStyle2{
				border-radius: 26px 6px;
			}
			.btnStyle3{
				border-radius: 20px 20px 0px 0px;
			}
			.btnStyle4{
				border-radius: 6px 126px 236px 346px;
			}
			.bolder{
				border: solid 1px green;
				width: 500px;
				height: 40px;
				border-radius: 10px;
			}
	</style>
	<link rel="stylesheet" href="./webpage/com/jeecg/robot/workbench/myPageStyle.css" type="text/css" />
	
	<script type="text/javascript">
		var requrl = '${requrl}';
		var robotId = '${robotId}';
		var robotIp = '${robotIp}';
		var patrol_point_no;
		var tabId = '${tabId}';
		//返回
		function goBack() {
			window.top.closeTab("tab_"+tabId);
			/* var aobj = window.top.$("a[data-id='"+requrl+"']");
			window.top.closePage2(aobj); */
		}
		
    	//移动机器人 
		function moverobot(moveType) {
			var isFlag = $("#cmn-toggle-1").is(':checked');
		   	 if(!isFlag) { //选中时，启用
		   		tip("远程控制未打开,不能控制机器人！");
		   		return;
		   	 }
    		if(!robotIp) {
    			return;
    		}
			var msg = "";
			var url = "";
			var data = {robotIp:robotIp};
			if(moveType == 'stop') {
				url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient";
				msg = "停止指令发送";
				data.interfaceNo = "movepause";
			} else if(moveType == 'up') {
				url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient";
				msg = "向前行走指令发送";
				data.interfaceNo = "moveforward";
			} else if(moveType == 'left') {
				url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient";
				msg = "向左行走发送";
				data.interfaceNo = "moveleft";
			} else if(moveType == 'right') {
				url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient";
				msg = "向右行走发送";
				data.interfaceNo = "moveright";
			} else if(moveType == 'down') {
				url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient";
				msg = "向后行走发送";
				data.interfaceNo = "moveback";
			} else {
				url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient";
				msg = "停止指令发送";
				data.status = "1";
				data.interfaceNo = "movepause";
			}
			/* tip(msg);
			//调用机器人信息页面 添加通知方法
			window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01",msg); */
			$.ajax({
				url : url,
				type : 'post',
				data: JSON.stringify(data),
				datatype:'json',
				cache : false,
				error:function () {
					msg = "网络异常，请检查机器人网络状态!";
					tip(msg);
					//调用机器人信息页面 添加通知方法
					window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg);
	    		},
				success : function(data) {
					if(data) {
						if (data.ErrorNo == '0') {
							msg = "成功";
						} else if(data.ErrorNo == '-1') {
							msg = "失败";
						} else if(data.ErrorNo == '1') {
							msg = "执行中";
						} else {
							//其他
						}
					} else {
						var d = $.parseJSON(data);
						if (d.ErrorNo == '0') {
							msg = "成功";
						} else if(d.ErrorNo == '-1') {
							msg = "失败";
						} else if(d.ErrorNo == '1') {
							msg = "执行中";
						} else {
							//其他
						}
					}
					//调用机器人信息页面 添加通知方法
					window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01",msg);
				}
			});
		}
    	
    	var pathApictureImg = ""; //热成像图片路径
		//拍照 热成像
		function takeApictureImg() {
			var isFlag = $("#cmn-toggle-1").is(':checked');
		   	 if(!isFlag) { //选中时，启用
		   		tip("远程控制未打开,不能控制机器人！");
		   		return;
		   	 }
    		if(!robotIp) {
    			return;
    		}
			var msg = "";
			var url = "";
			var data = {robotIp:robotIp};
			url = "workbenchController.do?takeApictureImg";
			$.ajax({
				url : url,
				type : 'post',
				data: data,
				cache : false,
				dataType:'JSON',
				error:function () {
					tip("热成像拍照失败");
					//调用机器人信息页面 添加通知方法
					window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg);
	    		},
				success : function(data) {
					if(data && data.obj) {
						pathApictureImg = data.obj;
						msg = "热成像拍照成功";
						tip(msg);
						//调用机器人信息页面 添加通知方法
						window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01",msg);
					} else {
						msg = "热成像拍照失败，请检查机器人拍照设备是否正常！";
						tip(msg);
						//调用机器人信息页面 添加通知方法
						window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg);
					}
				}
			});
		}
		
		//查看图片 热成像
		function seeApictureImg() {
			//openwindow("查看图片","workbenchController.do?seeApicture&pathApicture="+pathApictureImg,'',800,400);
			if(pathApictureImg) {
				openwindow("查看图片","workbenchController.do?seeApicture&pathApicture="+pathApictureImg,'',800,400);
			} else { //没有图片路径
				tip("没有拍照的图片");
			}
		}
		
		//查看历史拍照图片 2热成像 3直播
		function seeApicturelib(fileType) {
			openwindow("历史拍照图片","workbenchController.do?seeApicturelib&robotIp="+robotIp+"&fileType="+fileType,'',800,400);
		}
		
		var pathApictureSilder = ""; //滑杆直播图片路径
		//拍照 滑杆直播
		function takeApictureSilder() {
			var isFlag = $("#cmn-toggle-1").is(':checked');
		   	if(!isFlag) { //选中时，启用
		   		tip("远程控制未打开,不能控制机器人！");
		   		return;
		   	 }
    		if(!robotIp) {
    			return;
    		}
			var msg = "";
			var url = "";
			var data = {robotsIp:robotIp, interfaceNo:"pic"};
			url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient";
			msg = "拍照指令发送";
			$.ajax({
				url : url,
				type : 'post',
				data: JSON.stringify(data),
				datatype:'json',
				cache : false,
				error:function () {
					msg = "拍照：网络异常，请检查机器人网络状态!";
					tip(msg);
					//调用机器人信息页面 添加通知方法
					window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg);
	    		},
				success : function(data) {
					var d = $.parseJSON(data);
					if(d) {
						if (d.ErrorNo == '0') {
							msg += "成功";
							pathApictureSilder = d.url;
							tip(msg);
							window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01",msg);
						} else if(d.ErrorNo == '-1') {
							msg += "失败，请检查机器人是否正常！";
							tip(msg);
							window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg);
						} else {
							msg += "失败，请检查机器人是否正常！";
							tip(msg);
							window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg);
						}
					} else {
						if (data.ErrorNo == '0') {
							msg += "成功";
							pathApictureSilder = d.url;
							tip(msg);
							window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01",msg);
						} else if(data.ErrorNo == '-1') {
							msg += "失败，请检查机器人是否正常！";
							tip(msg);
							window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg);
						} else {
							msg += "失败，请检查机器人是否正常！";
							tip(msg);
							window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg);
						}
					}
				}
			});
		}
		
		//查看图片 滑杆直播
		function seeApictureSilder() {
			if(pathApictureSilder) {
				openwindow("查看图片","workbenchController.do?seeApicture&pathApicture="+pathApictureSilder,'',800,400);
			} else { //没有图片路径
				tip("没有拍照的图片");
			}
		}
		
		//滑杆移动按钮
		function videoupDown(moveType) {
			var isFlag = $("#cmn-toggle-1").is(':checked');
		   	 if(!isFlag) { //选中时，启用
		   		tip("远程控制未打开,不能控制机器人！");
		   		return;
		   	 }
    		if(!robotIp) {
    			return;
    		}
			var msg = "";
			var url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient";
			var data = {interfaceNo:"upDownController",robotIp:robotIp};
			if(moveType == '1') {
				msg = "滑杆向上移动";
				data.upDown = "1";
			} else if(moveType == '-1') {
				msg = "滑杆向下移动";
				data.upDown = "-1";
			} else {
				msg = "滑杆原点移动";
				data.upDown = "0";
			}
			$.ajax({
				url : url,
				type : 'post',
				data: JSON.stringify(data),
				datatype:'json',
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					if(d) {
						if (d.ErrorNo == '0') {
							msg = "成功";
						} else if(d.ErrorNo == '-1') {
							msg = "失败";
						} else if(d.ErrorNo == '1') {
							msg = "执行中";
						} else if(d.ErrorNo == '2') {
							msg = "弹出确认中";
						} else {
							//其他
						}
					} else {
						if (data.ErrorNo == '0') {
							msg = "成功";
						} else if(data.ErrorNo == '-1') {
							msg = "失败";
						} else if(data.ErrorNo == '1') {
							msg = "执行中";
						} else if(data.ErrorNo == '2') {
							msg = "弹出确认中";
						} else {
							//其他
						}
					}
					tip(msg);
					//调用机器人信息页面 添加通知方法
					//window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01",msg);
				}
			});
		}
		
		getControlState();
		//查询远程控制状态 Status: 1 开；0 关；
		function getControlState() {
	   	 	if(!robotIp) {
	   			return;
	   	 	}
		   	 var isFlag = $("#cmn-toggle-1").is(':checked');
		   	 var msg = "";
		   	 $.ajax({
		   		url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
		   		type : 'post',
		   		timeout : 10000,
		   		data: JSON.stringify({interfaceNo: "getControlState", robotsIp: robotIp}),
				datatype:'json',
		   		cache : false,
		   	    error:function(e){
		   		},
		   		success : function(data) {
		   			var d = $.parseJSON(data);
		   			if(d) {
		   				if (d.ErrorNo == '0') {
		   					if (d.Status && d.Status == '1') { //设置查询远程控制 状态开
		   						$("#cmn-toggle-1").attr("checked",true);
		   					} else {
		   						$("#cmn-toggle-1").attr("checked",false);
		   					}
		   				} else {
		   				}
		   			
		   			} else {
		   				if (data.ErrorNo == '0') {
		   					if (data.Status && data.Status == '1') { //设置查询远程控制 状态开
		   						$("#cmn-toggle-1").attr("checked",true);
		   					} else {
		   						$("#cmn-toggle-1").attr("checked",false);
		   					}
		   				} else {
		   				}
		   				
		   				
		   			}
		   		}
		   	 });
	    }
	    
	  	//远程控制状态更新  status: 0 否，1 是；
		function updateControlState(obj) {
	   	 	if(!robotIp) {
	   	 		$("#cmn-toggle-1").attr("checked",false);
	   			return;
	   	 	}
	   		//在远程控制页面弹出
			var robotStatusCode = window.parent.frames['tab_home'].frames['iframe_robotsinfo'].$("#robotStatusCode").text();
			if(robotStatusCode && robotStatusCode==5){
				if(!window.parent.frames['tab_home'].frames['iframe_robotsinfo'].isLogin()) { //判断机器人是否有用户在登录  未登录
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
								var robotStateData = {interfaceNo:"changeRobotState", status:"8", taskid:"", chare_time:"0", robotsIp: robotIp};
								$.ajax({
									url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
									type : 'post',
									data: JSON.stringify(robotStateData),
									datatype:'json',
									cache : false,
									error:function(e){
										tip("网络异常，请检查机器人网络状态！");
							   		},
									success : function(data) {
										var d = $.parseJSON(data);
										var msg = "终止当前任务，执行远程控制"
										if(d) {
											if (d.ErrorNo == '0') { //跳转到远程控制页面
												window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01",msg+"成功");
											} else if(d.ErrorNo == '-1') {
												window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg+"失败");
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
								//$("#cmn-toggle-1").attr("checked",false);
							}
						},
					    cancelVal: $.i18n.prop('dialog.close'),
					    cancel: true /*为true等价于function(){}*/
					});
				 } else { //有用户登录
					 //弹出确认在机器人
					 var isFlag = $("#cmn-toggle-1").is(':checked');
				   	 var status = 0;
				   	 var msg = "";
				   	 var msgType = "";
				   	 if(isFlag) { //选中时，启用
				   		 status = 1;
				   		 msg = "远程控制状态启用";
				   	 } else {
				   		 status = 0;
				   		 msg = "远程控制状态停用";
				   	 }
				   	 $.ajax({
				   		url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
				   		type : 'post',
				   		data: JSON.stringify({interfaceNo:"updateControlState",status:status, robotsIp: robotIp}),
				   		datatype:'json',
				   		cache : false,
				   		error:function(e){
							tip("网络异常，请检查机器人网络状态！");
				   		},
				   		success : function(data) {
				   			var d = $.parseJSON(data);
				   			if(d) {
				   				if (d.ErrorNo == '0') {
				   					msg = msg+"成功";
				   					msgType = "01";
				   				} else if (d.ErrorNo == '-1') {
				   					msg = msg+"失败";
				   					msgType = "03";
				   				} else if (d.ErrorNo == '1') {
				   					msg = msg+"告警"+d.Message;
				   					msgType = "02";
				   				} else if (d.ErrorNo == '2') {
				   					msg = msg+"弹窗确认中";
				   					msgType = "01";
				   				} else {
				   					msg = msg+"失败";
				   					msgType = "03";
				   				}
				   			} else {
				   				if (data.ErrorNo == '0') {
				   					msg = msg+"成功";
				   				} else {
				   					msg = msg+"失败";
				   				}
				   			}
				   			//调用机器人信息页面 添加通知方法
							window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg(msgType,msg);
				   		}
				   	 });
				   	getControlState();
				 }
			} else {
				//其他状态暂无操作
				var isFlag = $("#cmn-toggle-1").is(':checked');
			   	 var status = 0;
			   	 var msg = "";
			   	 var msgType = "";
			   	 if(isFlag) { //选中时，启用
			   		 status = 1;
			   		 msg = "远程控制状态启用";
			   	 } else {
			   		 status = 0;
			   		 msg = "远程控制状态停用";
			   	 }
			   	 $.ajax({
			   		url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
			   		type : 'post',
			   		data: JSON.stringify({interfaceNo:"updateControlState",status:status, robotsIp: robotIp}),
			   		datatype:'json',
			   		cache : false,
			   		error:function(e){
						tip("网络异常，请检查机器人网络状态！");
			   		},
			   		success : function(data) {
			   			var d = $.parseJSON(data);
			   			if(d) {
			   				if (d.ErrorNo == '0') {
			   					msg = msg+"成功";
			   					msgType = "01";
			   					getControlState();
			   				} else if (d.ErrorNo == '-1') {
			   					msg = msg+"失败";
			   					msgType = "03";
			   				} else if (d.ErrorNo == '1') {
			   					msg = msg+"告警"+d.Message;
			   					msgType = "02";
			   				} else if (d.ErrorNo == '2') {
			   					msg = msg+"弹窗确认中";
			   					msgType = "01";
			   				} else {
			   					msg = msg+"失败";
			   					msgType = "03";
			   				}
			   			} else {
			   				if (data.ErrorNo == '0') {
			   					msg = msg+"成功";
			   				} else {
			   					msg = msg+"失败";
			   				}
			   			}
			   			//调用机器人信息页面 添加通知方法
						window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg(msgType,msg);
			   		}
			   	 });
			}
	    }
	    
		//获取工作台-机器人信息页面的属性 websocket属性
		var interval3 = setInterval(function() {
			var robotStatus = window.parent.frames['tab_home'].frames['iframe_robotsinfo'].$("#robotStatus").text();
			var power = window.parent.frames['tab_home'].frames['iframe_robotsinfo'].$("#power").text();
			var data = window.parent.frames['tab_home'].frames['iframe_robotsinfo'].webData;
			 var html = "";
			 html += "<tr>";
			 html += "	<td colspan=\"2\" rowspan=\"1\" style=\"width: 20px;text-align: center;\" valign=\"top\">";
			 //html += "	<label style=\"font-weight: bold;font-size:16px;\">超维机器人</label> <br/><br/>";
			 html += "		<label>电量：</label>";
			 html += "		<label id=\"robotpower\">"+power+"</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			 html += "	<label>状态：</label>";
			 html += "	<label id=\"robotstatus\">"+robotStatus+"</label><br/><br/>";
			 html += "	<label></label>";
			 html += "   </td>";
			 html += "</tr>";
			 if(!data) {
				 return false;
			 }
			if(data.temperature_text && data.temperature_value) {
				html += "<tr><td style=\"height:30px; text-align: center;\">"+data.temperature_text+"：</td>";
				html += "    <td style=\"height:30px; text-align: center;\">"+data.temperature_value+"℃</td></tr>";
 			}
 			if(data.humidity_text && data.humidity_value) {
 				html += "<tr><td style=\"height:30px; text-align: center;\">"+data.humidity_text+"：</td>";
				html += "    <td style=\"height:30px; text-align: center;\">"+data.humidity_value+"%</td></tr>";
 			}
 			if(data.noise_text && data.noise_value) {
 				html += "<tr><td style=\"height:30px; text-align: center;\">"+data.noise_text+"：</td>";
				html += "    <td style=\"height:30px; text-align: center;\">"+data.noise_value+"dB</td></tr>";
 			}
 			if(data.pm25_text && data.pm25_value) {
 				html += "<tr><td style=\"height:30px; text-align: center;\">"+data.pm25_text+"：</td>";
				html += "    <td style=\"height:30px; text-align: center;\">"+data.pm25_value+"μg/m3</td></tr>";
 			}
 			if(data.pollution_gas_text && data.pollution_gas_value) {
 				html += "<tr><td style=\"height:30px; border-bottom: 1px solid #000;text-align: center;\">"+data.pollution_gas_text+"：</td>";
				html += "    <td style=\"height:30px; border-bottom: 1px solid #000;text-align: center;\">"+data.pollution_gas_value+"PPM</td></tr>";
 			}
 			/* if(data.equipment_temperature_text && data.equipment_temperature_value) {
 				html += "<tr><td style=\"height:30px; border-bottom: 1px solid #000;text-align: center;\">"+data.equipment_temperature_text+"：</td>";
				html += "    <td style=\"height:30px; border-bottom: 1px solid #000;text-align: center;\">"+data.equipment_temperature_value+"℃</td></tr>";
 			} */
 			$("#webDataTableId").html(html);
 			if(data.patrol_point_no) { //机器人当前所在点位
 				patrol_point_no = data.patrol_point_no;
 				var idObject = document.getElementById('div'+patrol_point_no);
 				if(idObject){
 					idObject.style.background = 'url(<%=request.getContextPath() %>/images/u6077.png)';
 					idObject.style.backgroundSize = "contain";
 				}
 				loadPoint();
 			}
		}, 1000);
		
		//获取任务队列中的巡检任务是否有新增
		var interval4 = setInterval(function() {
			//获取任务数量
			var taskNum = window.parent.frames['tab_home'].frames['iframe_patroltask'].taskNum;
			var taskCurNum = window.parent.frames['tab_home'].frames['iframe_robotsinfo'].taskCurNum;
			if(taskNum && taskCurNum) {
				if(taskNum > taskCurNum) { //任务队列中新增了任务
					//在远程控制页面弹出
					var robotStatusCode = window.parent.frames['tab_home'].frames['iframe_robotsinfo'].$("#robotStatusCode").val();
					if(robotStatusCode && robotStatusCode==8){
						if(!window.parent.frames['tab_home'].frames['iframe_robotsinfo'].isLogin()) { //判断机器人是否有用户在登录  未登录
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
									if(checkValue && checkValue == 1) { //终止远程控制，将巡检任务加入到任务队列，并立即执行任务队列中巡检任务。
										//调用切换机器人状态 接口 
										var robotStateData = {interfaceNo:"changeRobotState", status:"5", taskid:"", chare_time:"0", robotsIp: robotIp};
										$.ajax({
											url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
											type : 'post',
											data: JSON.stringify(robotStateData),
											datatype:'json',
											cache : false,
											success : function(data) {
												var d = $.parseJSON(data);
												var msg = "终止远程控制，将巡检任务加入到任务队列，并立即执行任务队列中巡检任务。"
												if(d) {
													if (d.ErrorNo == '0') { //跳转到远程控制页面
														window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01",msg+"成功");
													} else if(d.ErrorNo == '-1') {
														window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg+"失败");
													} else {
														//其他
													}
												} else {
												}
												//调用通知页面加载数据方法
												window.parent.frames['iframe_noticemessage'].reloadData(robotId);
											}
										});
									} else { //将巡检任务加入到任务队列，待引导结束后执行任务队列中巡检任务。（30s后未选择，则默认选择此项）
									}
								},
							    cancelVal: $.i18n.prop('dialog.close'),
							    cancel: true /*为true等价于function(){}*/
							});
						 } else { //有用户登录
							 //弹出确认在机器人
							 window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01","机器人弹窗确认中");
						 }
					} else {
						//其他状态暂无操作
					}
				}
			}
		}, 2000);
		
	</script>
  </head>
  
  <body marginwidth="0px" marginheight="0px">
    <table width="100%" height="100%"  cellspacing="0">
    	<tr>
    		<!-- <td rowspan="6" style="width: 5%;" valign="top">
    			返回
    			<a href="javascript:void(0);" onclick="goBack()"><img id="u7628_img" class="img " src="images/u7628.png"></a>
            </td> -->
            <td style="background-color: white; width: 25%;">
            	<table width="100%" height="100%"cellspacing="10px">
            	<tr>
            		<td rowspan="2" style="background-color: white;vertical-align: inherit;" width="20px">
									<!-- <button onclick="playPause()">开始录屏</button>
								<button onclick="makeNormal()">结束录屏</button>
								<br> -->
								<!-- 上线移动按钮 -->
								<a href="#" onclick="videoupDown('1')" class="upimg" title="摄像头向上移动">向上</a>
								<!-- <input type="button" onclick="videoupDown('1')" style="width: 18px;height: 60px;background:url('images/u231.svg') no-repeat;" />
								 -->
								 <br/><br/><br/>
								<!-- <input type="button" onclick="videoupDown('0')" style="width: 18px;height: 60px;background:url('images/u233.svg') no-repeat;" />
								 -->
								 <a href="#" onclick="videoupDown('0')" class="resimg" title="摄像头重置">重置</a>
								<br/><br/><br/>
				<!-- 				<input type="button" onclick="videoupDown('-1')" style="width: 18px;height: 60px;background:url('images/u232.svg') no-repeat;" />
				 -->            
				 				<a href="#" onclick="videoupDown('-1')" class="downimg" title="摄像头向下移动">向下</a>
				 	</td>
				 	<td style="background: white;height: 280px;" class="class1">
            			<!-- 滑杆直播摄像头： -->
		            	<div class="myheader">
					  		<label style="font-size: 15px;">滑杆直播摄像头</label>
					  		<span class="photographdiv" >
						  		<input type="button" onclick="takeApictureSilder()" class="photograph" title="拍照" />
						  		<input type="button" onclick="seeApictureSilder()" class="photoalbumzp" title="查看图片"/>
						  		<input type="button" onclick="seeApicturelib(3)" class="photoalbum" title="图库"/>
						 	</span>
						 	
					  		<hr>
					 	</div>
		            	<div id="example_video_silder" class="video-js vjs-default-skin" style="width: 280;height: 80%;"></div>
						<!-- <video id="example_video_silder" class="video-js vjs-default-skin" controls preload="auto" width="280" height="240" data-setup="{}">
						  <source src="rtmp://192.168.216.187:1936/live/stream" type='rtmp/flv'/>
						</video> -->
            		</td>
            	</tr>
            	<tr>
            		<td style="background: white;height: 280px;" class="class1">
            			<!-- 滑杆热成像摄像头： -->
		        		<div class="myheader">
					  		<label style="font-size: 15px;">滑杆热成像摄像头</label>
					  		<span class="photographdiv" >
						  		<input type="button" onclick="takeApictureImg()" class="photograph"  title="拍照"/>
						  		<input type="button" onclick="seeApictureImg()" class="photoalbumzp" title="查看图片"/>
						  		<input type="button" onclick="seeApicturelib(2)" class="photoalbum" title="图库"/>
						 	</span>
					  		<hr>
					 	</div>
		        		<div id="example_video_img" class="video-js vjs-default-skin" style="width: 280;height: 80%;"></div>
		        		<!-- <video id="example_video_img" class="video-js vjs-default-skin" controls preload="auto" width="280" height="240" data-setup="{}">
						  <source src="rtmp://192.168.216.187:1935/live/stream" type='rtmp/flv'/>
						</video> -->
            		</td>
            	</tr>
            	</table>
            </td>
            <td style="background-color: white; width: 25%;">
            	<table width="100%" height="100%"cellspacing="10px">
	            	<tr>
	            		<td style="background: white;height: 280px;" class="class1">
								<!-- <button onclick="playPause()">开始录屏</button>
								<button onclick="makeNormal()">结束录屏</button>
								<br> -->
								<!-- 巡检直播摄像头： -->
								<div class="myheader">
							  		<label style="font-size: 15px;">巡检直播摄像头</label>
							  		<hr>
							 	</div>
								<div id="example_video_live" class="video-js vjs-default-skin" style="width: 99%;height: 80%;;"></div>
								<!-- <video id="example_video_live" class="video-js vjs-default-skin" controls preload="auto" width="280" height="240" data-setup="{}" >
								  <source src="rtmp://192.168.216.187:1935/live/stream" type='rtmp/flv'/>
								</video> -->
				         </td>
            		</tr>
            		<tr>
            			<td style="background: white;height: 280px;" class="class1" align="center">
            				<div class="myheader">
						  		<label style="font-size: 15px;">远程控制</label>
						  		<hr>
						 	</div>
							<div class="switch">
							 <label id="lable-2" style="display: inline; color:black;">开启/关闭：</label>
							 <div style="display: inline-flex;">
							 	<input id="cmn-toggle-1" class="cmn-toggle cmn-toggle-round" type="checkbox" onclick="updateControlState(this)">
							    <label id="lable-1" for="cmn-toggle-1"></label>
							 </div>
							</div>
					        <div style="width:150px;height:155px;">
					        	<input type="button" onclick="moverobot('stop')" class="btnstop" />
						    	<input type="button" onclick="moverobot('up')" class="btnup"/>
						    	<input type="button" onclick="moverobot('left')" class="btnleft"/>
						    	<input type="button" onclick="moverobot('right')" class="btnright"/>
						    	<input type="button" onclick="moverobot('down')" class="btndown"/> 
					        </div>
            				<!-- <p style="color: black;">
            				 说明：<br/>
							1.方向键用于控制机器人移动。<br/>
							2.视频画面可放大，可拍照
							</p> -->
            			</td>
            		</tr>
            	</table>
            </td>
            <td style="background-color: white; width: 50%;" >
	            <table  width="100%" height="100%"cellspacing="12px">
	            	<tr>
	            		<td style="background: white;" class="class1">
	            			<div id="sitePanel" region="center" title="" style="width:500px;" class="easyui-panel">
						    	<div id="dv2" class="pic_div" style="height: 94%; z-index: 1;" >
						            <img id="SmallLiuYiFeiImg" src="${mapUrl}" class="pic">
						        </div>
					        </div>
	            		</td>
	            	</tr>
	            	<tr>
	            		<td style="background: white;" class="class1">
            				<div class="myheader">
						  		<label style="font-size: 15px;">超维机器人</label>
						  		<hr>
						 	</div>
			            	<table id="webDataTableId" width="100%" height="auto" cellspacing="0px;">
			            		<!-- <tr>
						    		<td colspan="2" rowspan="1" style="width: 20px; text-align: center;" valign="top">
										<label style="font-weight: bold;font-size:16px;">超维机器人：</label> <br/><br/>
										<label>电量：</label>
										<label id="robotpower">--</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<label>状态：</label>
										<label id="robotstatus">未连接</label><br/><br/>
										<label style=""></label>
						            </td>
					            </tr>
					            <tr>
						    		<td style="text-align: center;">
						    			电量：
						            </td>
						            <td style="text-align: center;">
						    			状态：
						            </td>
					            </tr> -->
			            	</table>
	            		</td>	
				   </tr>
	            </table>
            </td>
        </tr>
    </table>
  </body>
  <script type="text/javascript">
 		//加载机房巡检点坐标
 		loadPoint();
 		function loadPoint() {
 			var patrolPointNo;
 		 	var x;
 		 	var y;
 		 	var div;
 		 	var o =$("#sitePanel").position();
 		 	var left = o.left;
 		 	var top = o.top;
 		 	var image=document.getElementById("SmallLiuYiFeiImg");
 			var imageheight = image.height;
 			var imagewidth = image.width;
 			<c:forEach items="${lstMap}" var="item" varStatus="status" >  
	 		   var temp = "${item}";
	 		   patrolPointNo = "${item.patrol_point_no}";
		 		x = "${item.x_coordinate}";
		 		y = "${item.y_coordinate}";
		 		xrate = "${item.x_rate}";
		 		yrate = "${item.y_rate}";
		 		x = parseFloat(imagewidth)*parseFloat(xrate)+parseInt(left);
		 		y = parseFloat(imageheight)*parseFloat(yrate)+parseInt(top);
		 		//删除div 重新加载机器人图标
		 		var idObject = document.getElementById('div'+patrolPointNo);
		 	    if (idObject != null) {
		 	          idObject.parentNode.removeChild(idObject);
		 	    }
		 		div = document.createElement('div');
				div.id = 'div'+patrolPointNo;
				div.style.position = 'absolute';
		        div.style.left = x + 'px';
				div.style.top = y + 'px';
				div.style.zIndex = 2;
				var xtmp = 30*parseFloat(xrate);
				var ytmp = 30*parseFloat(yrate);
				div.style.width = xtmp+'px';
				div.style.height = ytmp+'px';
				if(patrol_point_no == patrolPointNo) {
					div.style.background = 'url(<%=request.getContextPath() %>/images/u6077.png) no-repeat center';
					div.style.backgroundSize = "contain";
				} else {
					div.style.background = 'url(<%=request.getContextPath() %>/images/u6079.png) no-repeat center';
					div.style.backgroundSize = "contain";
				}
				document.getElementById('sitePanel').appendChild(div);
				div.onclick=function(){ //点击点位图标 机器人移动到指定位置
					var isFlag = $("#cmn-toggle-1").is(':checked');
				   	if(!isFlag) { //选中时，启用
				   		tip("远程控制未打开,不能控制机器人！");
				   		return;
				   	}
					var pointName = this.id.replace("div","");
					var robotStateData = {interfaceNo:"moveMapPoint", pointName:pointName, robotsIp: robotIp};
					$.ajax({
						url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
						type : 'post',
						data: JSON.stringify(robotStateData),
						datatype:'json',
						cache : false,
						error:function(e){
							tip("网络异常，请检查机器人网络状态！");
				   		},
						success : function(data) {
							var d = $.parseJSON(data);
							var msg = "位置移动指令发送"
							if(d) {
								if (d.ErrorNo == '0') { //跳转到远程控制页面
									tip(msg+"成功");
									window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("01",msg+"成功");
								} else if(d.ErrorNo == '-1') {
									tip(msg+"失败");
									window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg+"失败");
								} else {
									tip(msg+"失败");
									window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg+"失败");
								}
							} else {
								tip(msg+"失败");
								window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg("03",msg+"失败");
							}
						}
					});
				};
	 		</c:forEach>
 		 }
 		
 		//加载推流播放器
 		var width = (document.body.clientWidth - 2)*0.3;
 		var height = (document.body.clientHeight - 2)*0.3;
 		var panduan1 = true;
 		var panduan2 = true;
 		var livertmp='${livertmp}';
 		var imgrtmp='${imgrtmp}';
 		var silderrtmp='${silderrtmp}';
 		setInterval(function(){
 			  if(robotId) {
 				  var aobj = window.top.$("li[id='tab_tab_"+tabId+"']");
 				  	if(aobj.hasClass("active")){ //显示状态
 				  		if(panduan1){
 			  				panduan1=false;
 				  			panduan2 = true;
 				  			testPlay();
 				  			testPlayImg();
 				  			testPlaySilder();
 				  		}
 				  	} else {
 				  		if(panduan2){
 				  			panduan2=false;
 				  			panduan1 = true;
 				  			testpause();
 				  			testpauseImg();
 				  			testpauseSilder();
 				  		}
 				  	}
 			  }
		},100);
 		//直播视频播放
 		var videoParams;
 		var player;
 		if(robotId) {
 				videoParams = { link: livertmp, type: 'rtmp/flv', tech: [ 'flash' ] };
 				player = new videojs( '#example_video_live', 
 						{ 'techOrder': videoParams.tech, 'controls': true, 'autoplay': true, 'preload': 'none', 'width':width, 'height':height },
 						function() {}
 					);
 				player.src(livertmp);
 		}
 		function testPlay() {
 			  videoParams = {link: livertmp,  type: 'rtmp/flv', tech: [ 'flash' ] };
 			  player = new videojs( '#example_video_live', 
 						{ 'techOrder': videoParams.tech, 'controls': true, 'autoplay': true,
 						'preload': 'none', 'width':width, 'height':height },
 						function() {}
 					);
 			  player.src(livertmp);
 		      player.load();
 			  player.play();
 		}
 		function testpause() {
 			if(player.paused){
 				player.src(livertmp);
 		    	player.load();
 		    	player.play();
 			} else {
 				player.src(livertmp);
 		    	player.load();
 		    	player.pause();
 			}
 		}
 		
 		//热成像视频播放
 		var videoParamsImg;
 		var playerImg;
 		if(robotId) {
			videoParamsImg = { link: imgrtmp, type: 'rtmp/flv', tech: [ 'flash' ] };
			playerImg = new videojs( '#example_video_img', 
					{ 'techOrder': videoParams.tech, 'controls': true, 'autoplay': true, 'preload': 'none', 'width':width, 'height':height },
					function() {}
				);
			playerImg.src(imgrtmp);
 		}
 		function testPlayImg() {
 			videoParamsImg = {link: imgrtmp,  type: 'rtmp/flv', tech: [ 'flash' ] };
 			playerImg = new videojs( '#example_video_img', 
 						{ 'techOrder': videoParams.tech, 'controls': true, 'autoplay': true,
 						'preload': 'none', 'width':width, 'height':height },
 						function() {}
 					);
 			playerImg.src(imgrtmp);
 			playerImg.load();
 			playerImg.play();
 		}
 		function testpauseImg() {
 			if(playerImg.paused){
 				playerImg.src(imgrtmp);
 				playerImg.load();
 		    	playerImg.play();
 			} else {
 				playerImg.src(imgrtmp);
 				playerImg.load();
 				playerImg.pause();
 			}
 		}
 		
 		//滑杆视频播放
 		var videoParamsSilder;
 		var playerSilder;
 		if(robotId) {
 			videoParamsSilder = { link: silderrtmp, type: 'rtmp/flv', tech: [ 'flash' ] };
 			playerSilder = new videojs( '#example_video_silder', 
 						{ 'techOrder': videoParams.tech, 'controls': true, 'autoplay': true, 'preload': 'none', 'width':width, 'height':height },
 						function() {}
 					);
 			playerSilder.src(silderrtmp);
 		}
 		function testPlaySilder() {
 			videoParamsSilder = {link: silderrtmp,  type: 'rtmp/flv', tech: [ 'flash' ] };
 			 playerSilder = new videojs( '#example_video_silder', 
 						{ 'techOrder': videoParams.tech, 'controls': true, 'autoplay': true,
 						'preload': 'none', 'width':width, 'height':height },
 						function() {}
 					);
 			playerSilder.src(silderrtmp);
 			playerSilder.load();
 			playerSilder.play();
 		}
 		function testpauseSilder() {
 			if(playerSilder.paused){
 				playerSilder.src(silderrtmp);
 				playerSilder.load();
 				playerSilder.play();
 			} else {
 				playerSilder.src(silderrtmp);
 				playerSilder.load();
 				playerSilder.pause();
 			}
 		}
 	</script>
</html>
