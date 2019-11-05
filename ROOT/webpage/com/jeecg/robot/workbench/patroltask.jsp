<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>任务队列</title>
    <style type="text/css">
	</style>
	<style type="text/css">
		body{
	    	width:auto;
	    }
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
		.btn{
	        text-align: center;
	        width: 60px;
	        height: 20px;
	        cursor: pointer;
	    }
	    .myheader{
			width: 98%; 
			text-align: center;
			font-weight: bold; 
			font-family: "微软雅黑","新宋体","open sans","Helvetica Neue",Helvetica,Arial,"sans-serif";
		}
	</style>
	<script type="text/javascript">
		var robotsIp = '${robotsIp}';
		var robotId = '${robotId}';
		
	    $(document).ready(function () {
	        $("#tabs li").bind("click", function () {
	            var index = $(this).index();
	            var divs = $("#tabs-body > div");
	            $(this).parent().children("li").attr("class", "tab-nav");//将所有选项置为未选中
	            $(this).attr("class", "tab-nav-action"); //设置当前选中项为选中样式
	            divs.hide();//隐藏所有选中项内容
	            divs.eq(index).show(); //显示选中项对应内容
	        });
	        var robotStatus = window.parent.frames['iframe_robotsinfo'].$("#robotStatus").text();
	        if(robotStatus && robotStatus != "未连接") { //获取机器人的状态
	        	$("#lable-2").show();
		        $("#lable-3").show();
	        	reloadData(robotsIp);//加载数据
		        autoSchedulingState();//获取自动调度状态
	        }
	    });
	    
	    //鼠标移动事件
	    function movetest(id, taskstate) { 
	    	var html = "";
	    	if(taskstate && taskstate == '0') { //任务状态 -1异常 0，已完成并且正常 1，未执行 2，执行中  //-1异常 0，未执行 1，执行中 2，已完成  
	    		html += "<input type=\"button\" value=\"立即执行\" onclick=\"startTask('"+id+"')\" class=\"btn\"/>&nbsp;&nbsp;";
	    		html += "<input type=\"button\" value=\"删除任务\" onclick=\"delTask('"+id+"')\" class=\"btn\"/>";
			} else if (taskstate == '-1') {
			} else if (taskstate == '2') {
			} else if (taskstate == '1') {
				html = "<input type=\"button\" value=\"终止任务\" onclick=\"stopTask('"+id+"')\" class=\"btn\"/>";
			}
	    	$("#"+id).html(html);
	    	$(".btn").click(function(event){
		        event.stopPropagation();//阻止事件冒泡即可
		        if (this.value == '立即执行') {
		        	startTask(id);
		        }
				if (this.value == '删除任务') {
					delTask(id);
		        }
				if (this.value == '终止任务') {
					stopTask(id);
				}
		    });
	    }
	    //鼠标离开事件
	    function outtest(id, taskstate) {
	    	var html = "";
	    	if(taskstate && taskstate == '0') { //任务状态 -1异常 0，已完成并且正常 1，未执行 2，执行中   //-1异常 0，未执行 1，执行中 2，已完成  
	    		html += "（未执行）";
			} else if (taskstate == '-1') {
			} else if (taskstate == '2') {
			} else if (taskstate == '1') {
				html = "（正在执行）";
			}
	    	$("#"+id).html(html);
	    }
	    
	    //终止任务
	    function stopTask(taskId) {
	    	/* if(taskNum == 1) { //如果任务队列中只有一个任务
	    		var robotStatus = window.parent.frames['iframe_robotsinfo'].$("#robotStatus").text();
	    		//0,待命中 2,回充 3,低电回充 4,充电中 5,任务中 6,引导中 7, 录像中 8 ,控制中
	    		if(robotStatus && robotStatus=="任务中"){
	    			if(!window.parent.frames['iframe_robotsinfo'].isLogin()) { //判断机器人是否有用户在登录  未登录
	    				 //弹出确认在平台 
	    				 var confirmUrl = 'workbenchController.do?confirmStopTask';
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
	    						if(checkValue && checkValue == 1) { //终止当前任务，机器人待命中。
	    							//调用切换机器人状态 接口 
	    							var robotStateData = {interfaceNo:"changeRobotState", status:"0", taskid:taskId, chare_time:""};
	    							$.ajax({
	    								url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
	    								type : 'post',
	    								data: JSON.stringify(robotStateData),
	    								datatype:'json',
	    								cache : false,
	    								success : function(data) {
	    									var d = $.parseJSON(data);
	    									var msg = "终止当前任务，机器人待命中";
	    									if(d) {
	    										if (d.ErrorNo == '0') {
	    											window.parent.frames['iframe_robotsinfo'].addNoticeMsg("01",msg+"成功");
	    										} else if(d.ErrorNo == '-1') {
	    											window.parent.frames['iframe_robotsinfo'].addNoticeMsg("03",msg+"失败");
	    										} else if(d.ErrorNo == '1') {
	    											window.parent.frames['iframe_robotsinfo'].addNoticeMsg("02",msg+"警告："+d.Message);
	    										} else if(d.ErrorNo == '2') {
	    											window.parent.frames['iframe_robotsinfo'].addNoticeMsg("01",msg+"弹窗确认中");
	    										} else {
	    											//其他
	    											window.parent.frames['iframe_robotsinfo'].addNoticeMsg("03",msg+"失败");
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
	    				    cancel: true
	    				});
	    			 } else { //有用户登录
	    				 //弹出确认在机器人
	    				 //window.parent.frames['iframe_robotsinfo'].addNoticeMsg("01","机器人弹窗确认中");
	    				 var msg = "终止任务";
	    			    	var msgType = "";
	    			    	$.ajax({
	    						url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
	    						type : 'post',
	    						data: JSON.stringify({interfaceNo:"cancelQueueTask",robot_ip:robotsIp,task_id: taskId }),
	    						datatype:'json',
	    						cache : false,
	    						success : function(data) {
	    							var d = $.parseJSON(data);
	    							if(d) {
	    								if (d.ErrorNo == '0') {
	    									msg = msg+"成功";
	    									msgType = "01";
	    								} else if(d.ErrorNo == '-1') {
	    									msg = msg+"失败";
	    									msgType = "03";
	    								} else if(d.ErrorNo == '1') {
	    									msg = msg+"告警"+d.Message;
	    									msgType = "02";
	    								} else if(d.ErrorNo == '2') {
	    									msg = msg+"机器人弹出确认中";
	    									msgType = "01";
	    								} else {
	    									//其他
	    									msg = msg+"失败";
	    									msgType = "03";
	    								}
	    							} else {
	    								if (data.ErrorNo == '0') {
	    									msg = msg+"成功";
	    								} else if(data.ErrorNo == '-1') {
	    									msg = msg+"失败";
	    								} else if(data.ErrorNo == '1') {
	    									msg = msg+"执行命令中";
	    								} else if(d.ErrorNo == '2') {
	    									msg = msg+"机器人弹出确认中";
	    								} else {
	    									//其他
	    								}
	    							}
	    							//添加通知消息
	    		   					window.parent.frames['iframe_robotsinfo'].addNoticeMsg(msgType,msg);
	    						}
	    					});
	    			 }
	    		} else { //状态不在任务中，不会存在此逻辑，不做处理
	    		}
	    	} else { //任务队列中有多个任务不用处理
	    		var msg = "终止任务";
		    	var msgType = "";
		    	$.ajax({
					url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
					type : 'post',
					data: JSON.stringify({interfaceNo:"cancelQueueTask",robot_ip:robotsIp,task_id: taskId }),
					datatype:'json',
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if(d) {
							if (d.ErrorNo == '0') {
								msg = msg+"成功";
								msgType = "01";
							} else if(d.ErrorNo == '-1') {
								msg = msg+"失败";
								msgType = "03";
							} else if(d.ErrorNo == '1') {
								msg = msg+"告警"+d.Message;
								msgType = "02";
							} else if(d.ErrorNo == '2') {
								msg = msg+"机器人弹出确认中";
								msgType = "01";
							} else {
								//其他
								msg = msg+"失败";
								msgType = "03";
							}
						} else {
							if (data.ErrorNo == '0') {
								msg = msg+"成功";
							} else if(data.ErrorNo == '-1') {
								msg = msg+"失败";
							} else if(data.ErrorNo == '1') {
								msg = msg+"执行命令中";
							} else if(d.ErrorNo == '2') {
								msg = msg+"机器人弹出确认中";
							} else {
								//其他
							}
						}
						//添加通知消息
	   					window.parent.frames['iframe_robotsinfo'].addNoticeMsg(msgType,msg);
					}
				});
	    	} */
    	$.dialog.confirm('请确认是否终止任务？', function(r) {
		   if (r) {
		    	var msg = "终止任务";
		    	var msgType = "";
		    	$.ajax({
					url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
					type : 'post',
					data: JSON.stringify({interfaceNo:"cancelQueueTask",robot_ip:robotsIp,task_id: taskId }),
					datatype:'json',
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if(d) {
							if (d.ErrorNo == '0') {
								msg = msg+"成功";
								msgType = "01";
							} else if(d.ErrorNo == '-1') {
								msg = msg+"失败";
								msgType = "03";
							} else if(d.ErrorNo == '1') {
								msg = msg+"告警"+d.Message;
								msgType = "02";
							} else if(d.ErrorNo == '2') {
								msg = msg+"机器人弹出确认中";
								msgType = "01";
							} else {
								//其他
								msg = msg+"失败";
								msgType = "03";
							}
						} else {
							if (data.ErrorNo == '0') {
								msg = msg+"成功";
							} else if(data.ErrorNo == '-1') {
								msg = msg+"失败";
							} else if(data.ErrorNo == '1') {
								msg = msg+"执行命令中";
							} else if(d.ErrorNo == '2') {
								msg = msg+"机器人弹出确认中";
							} else {
								//其他
							}
						}
						//添加通知消息
	   					window.parent.frames['iframe_robotsinfo'].addNoticeMsg(msgType,msg);
					}
				});
			   }
	    	});
	    }
	    
	  	//执行任务
	    function startTask(taskId) {
	    	$.dialog.confirm('请确认是否执行任务？', function(r) {
	 		   if (r) {
	    	var msg = "执行任务";
	    	var msgType = "";
			$.ajax({
				url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
				type : 'post',
				data: JSON.stringify({interfaceNo:"goToQueueTask",robot_ip:robotsIp,task_id: taskId }),
				datatype:'json',
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					if(d) {
						var taskName = "";
						if(d.Data && d.Data.Task_Name) {
							taskName = d.Data.Task_Name
						}
						if (d.ErrorNo == '0') {
							msg = msg+taskName+"成功";
							msgType = "01";
						} else if(d.ErrorNo == '-1') {
							msg = msg+taskName+"失败";
							msgType = "03";
						} else if(d.ErrorNo == '1') {
							msg = msg+taskName+"告警"+d.Message;
							msgType = "02";
						} else if(d.ErrorNo == '2') {
							msg = msg+"机器人弹出确认中";
							msgType = "01";
						} else {
							//其他
							msg = msg+"失败";
							msgType = "03";
						}
					} else {
						var taskName = "";
						if(data.Data && data.Data.Task_Name) {
							taskName = data.Data.Task_Name
						}
						if (data.ErrorNo == '0') {
							msg = msg+taskName+"成功";
						} else if(data.ErrorNo == '-1') {
							msg = msg+taskName+"失败";
						} else if(data.ErrorNo == '1') {
							msg = msg+taskName+"执行命令中";
						} else if(d.ErrorNo == '2') {
							msg = msg+"机器人弹出确认中";
						} else {
							//其他
						}
					}
					//添加通知消息
   					window.parent.frames['iframe_robotsinfo'].addNoticeMsg(msgType,msg);
				}
			});
	 		  }
	    	});
	    }
	  
	  	//删除任务
	    function delTask(taskId) {
	    	$.dialog.confirm('请确认是否删除任务？', function(r) {
		 		   if (r) {
	    	var msg = "删除任务";
	    	var msgType = "";
	    	$.ajax({
				url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
				type : 'post',
				data: JSON.stringify({interfaceNo:"cancelQueueTask",robot_ip:robotsIp,task_id: taskId }),
				datatype:'json',
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					if(d) {
						if (d.ErrorNo == '0') {
							msg = msg+"成功";
							msgType = "01";
						} else if(d.ErrorNo == '-1') {
							msg = msg+"失败";
							msgType = "03";
						} else if(d.ErrorNo == '1') {
							msg = msg+"告警"+d.Message;
							msgType = "02";
						} else if(d.ErrorNo == '2') {
							msg = msg+"机器人弹出确认中";
							msgType = "01";
						} else {
							//其他
							msg = msg+"失败";
							msgType = "01";
						}
					} else {
						if (data.ErrorNo == '0') {
							msg = msg+"成功";
						} else if(data.ErrorNo == '-1') {
							msg = msg+"失败";
						} else if(data.ErrorNo == '1') {
							msg = msg+"执行命令中";
						} else if(d.ErrorNo == '2') {
							msg = msg+"机器人弹出确认中";
						} else {
							//其他
						}
					}
					//添加通知消息
   					window.parent.frames['iframe_robotsinfo'].addNoticeMsg(msgType,msg);
				}
			});
		    }
		});
	    }
	    
	    var flag = false;
	    var interval3=setInterval(function(){
	    	$("#tabs li").bind("click", function () {
	            var index = $(this).index();
	            var divs = $("#tabs-body > div");
	            $(this).parent().children("li").attr("class", "tab-nav");//将所有选项置为未选中
	            $(this).attr("class", "tab-nav-action"); //设置当前选中项为选中样式
	            divs.hide();//隐藏所有选中项内容
	            divs.eq(index).show(); //显示选中项对应内容
	        });
	        var robotStatus = window.parent.frames['iframe_robotsinfo'].$("#robotStatus").text();
	        if(robotStatus && robotStatus != "未连接") { //获取机器人的状态
	        	$("#lable-2").show();
		        $("#lable-3").show();
	        	reloadData(robotsIp);//加载数据
		        autoSchedulingState();//获取自动调度状态
	        }
	   },2000);
	    var taskNum = 0; //任务数量
	    var liData; //任务队列数据
	    var selArr = []; //收缩的任务ID集合 解决刷新全部展开的问题
	    //重新加载数据
	    function reloadData(robotsIp) {
	    	if(!robotsIp){ //机器人IP为空时不加载数据
	    		return;
	    	}
	    	var msg = "任务队列获取";
	    	$.ajax({
	    		url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
	    		type : 'post',
	    		data: JSON.stringify({interfaceNo:"tasklist",robot_ip:robotsIp, robotId: robotId}),
				datatype:'json',
	    		cache : false,
	    		error:function () {
	    			flag = false;
	    		},
	    		success : function(data) {
	    			flag = true;
	    			var html = "";
	    			var d = $.parseJSON(data);
	    			if(d) {
	    				if (d.ErrorNo == '0') {
							if(d.Data && d.Data.Task_List) {
								if(d.Data.Task_List.length > 0) {
									taskNum = d.Data.Task_List.length;
									liData = d.Data.Task_List;
									//任务循环
									for(var i = 0; i < d.Data.Task_List.length; i++){
										var taskList = d.Data.Task_List[i];
										var Tast_Id = taskList.Tast_Id;
										var Task_Name = taskList.Task_Name;
										var Task_State = taskList.Task_State;
										var Pois = taskList.Pois;
										html += "<ul>";
										html += "<li id=\"li"+Tast_Id+"\" style=\"margin:0px; padding-top:10px;\">";
										html += "<a href=\"#\">";
										html += "<img id=\"u5902_img\" src=\"images/u5902_selected.png\">&nbsp;&nbsp;";
										html += Task_Name;
										html += "</a>";
										if(Task_State && Task_State == '0') { //任务状态 -1异常 0，已完成并且正常 1，未执行 2，执行中  //-1异常 0，未执行 1，执行中 2，已完成  
											html += "<label id=\""+Tast_Id+"\" class=\"taskstate\" name=\""+Task_State+"\" style=\"float: right;margin-right: 10px;\" >（未执行）</label>";
										} else if (Task_State == '-1') {
											html += "<label id=\""+Tast_Id+"\" class=\"taskstate\" name=\""+Task_State+"\" style=\"float: right;margin-right: 10px;\" >（异常）</label>";
										} else if (Task_State == '2') {
											html += "<label id=\""+Tast_Id+"\" class=\"taskstate\" name=\""+Task_State+"\" style=\"float: right;margin-right: 10px;\" >（已完成并且正常）</label>";
										} else if (Task_State == '1') {
											html += "<label id=\""+Tast_Id+"\" class=\"taskstate\" name=\""+Task_State+"\" style=\"float: right;margin-right: 10px;\" >（正在执行）</label>";
										}
										html += "<ul style=\"margin-left: 40px;\">";
										if(Pois && Pois.length > 0) {
											//巡检点循环
											for (var j = 0; j < Pois.length; j++){
												var Poi = Pois[j];
												var Point_Name = Poi.Point_Name;
												var Point_State = Poi.Point_State;
												var Photo_State = Poi.Photo_State;
												var Voice_State = Poi.Voice_State;
												var Sensor_State = Poi.Sensor_State;
												var OpenDoor_State = Poi.OpenDoor_State;
												var CloseDoor_State = Poi.CloseDoor_State;
												/* var Is_Photo = Poi.Is_Photo;
												var Is_Voice = Poi.Is_Voice;
												var Is_Sensor = Poi.Is_Sensor;
												var Is_Opendoor = Poi.Is_Opendoor;
												var Is_Closedoor = Poi.Is_Closedoor; */
												if(Photo_State && Photo_State != '-2') { //是否需要拍照
													html += "<li>";
													html += "<a href=\"#\">"+Point_Name+"拍照</a>";
													if(Photo_State && Photo_State == '1') { //点位状态 -1异常 0，已完成并且正常 1，未执行 2，执行中  改为：-2不需要，不显示 -1 异常0，未执行 1，执行中 2 已完成正常
														html += "";
													} else if (Photo_State == '-1') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5960.png\">";
													} else if (Photo_State == '2') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5959.png\">";
													} else if (Photo_State == '1') {
														html += "";
													}
													html += "</li>";
												}
												if(Voice_State &&Voice_State != '-2') { //是否需要语音播报
													html += "<li>";
													html += "<a href=\"#\">"+Point_Name+"语音播报</a>";
													if(Voice_State && Voice_State == '1') { //点位状态 -1异常 0，已完成并且正常 1，未执行 2，执行中
														html += "";
													} else if (Voice_State == '-1') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5960.png\">";
													} else if (Voice_State == '2') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5959.png\">";
													} else if (Voice_State == '1') {
														html += "";
													}
													html += "</li>";
												}
												if(Sensor_State && Sensor_State != '-2') { //是否需要动环检测
													html += "<li>";
													html += "<a href=\"#\">"+Point_Name+"动环检测</a>";
													if(Sensor_State && Sensor_State == '1') { //点位状态 -1异常 0，已完成并且正常 1，未执行 2，执行中
														html += "";
													} else if (Sensor_State == '-1') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5960.png\">";
													} else if (Sensor_State == '2') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5959.png\">";
													} else if (Sensor_State == '1') {
														html += "";
													}
													html += "</li>";
												}
												if(OpenDoor_State && OpenDoor_State != '-2') { //是否需要开门
													html += "<li>";
													html += "<a href=\"#\">"+Point_Name+"开门</a>";
													if(OpenDoor_State && OpenDoor_State == '1') { //点位状态 -1异常 0，已完成并且正常 1，未执行 2，执行中
														html += "";
													} else if (OpenDoor_State == '-1') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5960.png\">";
													} else if (OpenDoor_State == '2') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5959.png\">";
													} else if (OpenDoor_State == '1') {
														html += "";
													}
													html += "</li>";
												}
												if(CloseDoor_State && CloseDoor_State != '-2') { //是否需要关门
													html += "<li>";
													html += "<a href=\"#\">"+Point_Name+"关门</a>";
													if(CloseDoor_State && CloseDoor_State == '1') { //点位状态 -1异常 0，已完成并且正常 1，未执行 2，执行中
														html += "";
													} else if (CloseDoor_State == '-1') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5960.png\">";
													} else if (CloseDoor_State == '2') {
														html += "<img id=\"u5959_img\" style=\"float: right; margin-right: 30px;\" src=\"images/u5959.png\">";
													} else if (CloseDoor_State == '1') {
														html += "";
													}
													html += "</li>";
												}
											}
										}
										html += "</ul>";
										html += "</li>";
										html += "</ul>";
									}
								}
							}
						} else if(d.ErrorNo == '-1') {
						} else if(d.ErrorNo == '1') {
						} else if(d.ErrorNo == '-3') {
							//设置机器人状态/电量
							window.parent.frames['iframe_robotsinfo'].$("#robotStatus").text("未连接");
							window.parent.frames['iframe_robotsinfo'].$("#power").text("--");
							window.parent.frames['iframe_robotsinfo'].$("#robotStatusCode").val("1");
							window.parent.frames['iframe_computerroom'].setRobotInfo("");
						} else {
							//其他
						}
					} else {
					}
	    			$("#mypatroltask").html(html);
	    			$(".taskstate").bind("mouseenter",function(){movetest($(this).attr("id"), $(this).attr("name"));});
	    	        $(".taskstate").bind("mouseleave",function(){outtest($(this).attr("id"), $(this).attr("name"));});
	    	        if(liData) { //设置重新加载前的选中展开样式
	    	        	for(var i = 0; i < liData.length; i++){
							var taskList = liData[i];
							var Tast_Id = "li"+taskList.Tast_Id;
							for (var j = 0; j < selArr.length; j++) {
								if(Tast_Id === selArr[j].Tast_Id) {
									$("#"+Tast_Id).children("ul").hide();
									$("#"+Tast_Id).find("img")[0].src="images/u5902.png";
								}
							}
	    	        	}
	    	        }
	    	        $("#mypatroltask ul li").click(function() {
	    	        	$(this).children("ul").toggle();
	    	        	var path = $(this).find("img")[0].src;
	    	        	var liId = $(this).attr('id');
	    	        	if(path.indexOf("u5902.png") != -1) {
	    	        		path = "images/u5902_selected.png";
	    	        		$(this).find("img")[0].src = path;
	    	        		//删除元素
    	        			for(var i = 0; i < selArr.length; i++){
    	        			    if(selArr[i].Tast_Id === liId){
    	        			    	selArr.splice(i,1);
    	        			    }
    	        			}
    	        			//console.log("删除："+JSON.stringify(selArr));
	    	        	} else if (path.indexOf("u5902_selected.png") != -1) {
	    	        		path = "images/u5902.png";
	    	        		$(this).find("img")[0].src = path;
	    	        		//添加元素
	    	        		selArr.push({Tast_Id: liId});
	    	        		//console.log("添加："+JSON.stringify(selArr));
	    	        	}
	    	        });
	    		}
	    	});
	    }
	    
	  	//获取自动调度状态 Status: 1 开；0 关；
		function autoSchedulingState() {
	   	 	if(!robotsIp) {
	   			return;
	   	 	}
		   	 var isFlag = $("#cmn-toggle-1").is(':checked');
		   	 var msg = "";
		   	 $.ajax({
		   		url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
		   		type : 'post',
		   		data: JSON.stringify({interfaceNo:"autoSchedulingState",robot_ip:robotsIp}),
				datatype:'json',
		   		cache : false,
		   		error:function(e){
		   		},
		   		success : function(data) {
		   			var d = $.parseJSON(data);
		   			if(d) {
		   				if (d.ErrorNo == '0') {
		   					if (d.Status && d.Status == '1') { //设置自动调度 状态开
		   						$("#cmn-toggle-1").attr("checked",true);
		   					} else {
		   						$("#cmn-toggle-1").attr("checked",false);
		   					}
		   				} else {
		   				}
		   				
		   			} else {
		   				if (data.ErrorNo == '0') {
		   					if (data.Status && data.Status == '1') { //设置自动调度 状态开
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
	    
	  	//自动调度  status: 0 否，1 是；
		function autoDispatch(obj) {
	   	 	if(!robotsIp) {
	   			return;
	   	 	}
		   	 var isFlag = $("#cmn-toggle-1").is(':checked');
		   	 var status = 0;
		   	 var msg = "";
		   	 var msgType = "";
		   	 if(isFlag) { //选中时，启用
		   		 status = 1;
		   		 msg = "自动调度启用";
		   	 } else {
		   		 status = 0;
		   		 msg = "自动调度停用";
		   	 }
		   	 $.ajax({
		   		url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
		   		type : 'post',
		   		data: JSON.stringify({interfaceNo:"updateAutoSchedulingState",status:status, robotsIp:robotsIp}),
		   		datatype:'json',
		   		cache : false,
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
		   				}
		   			} else {
		   				if (data.ErrorNo == '0') {
		   					msg = msg+"成功";
		   				} else {
		   					msg = msg+"失败";
		   				}
		   			}
		   			//添加通知消息
   					window.parent.frames['iframe_robotsinfo'].addNoticeMsg(msgType,msg);
		   		}
		   	 });
	    }
	    
	    
	</script>
  </head>
  
  <body marginwidth="0px" marginheight="0px">
  	<div class="myheader">
  		<label style="font-size: 15px;">任务队列</label>
  		<hr>
 	</div>
 	<div class="switch" >
	 <label id="lable-2" style="display: none; float: left;">自动调度：</label>
	 <div id="lable-3" style="padding-left: 60px;display: none;">
	 	<input id="cmn-toggle-1" class="cmn-toggle cmn-toggle-round" type="checkbox" onclick="autoDispatch(this)">
	    <label id="lable-1" for="cmn-toggle-1"></label>
	 </div>
	</div>
	<div id="mypatroltask" style="padding-left: 10px;">
	</div>
  </body>
</html>
