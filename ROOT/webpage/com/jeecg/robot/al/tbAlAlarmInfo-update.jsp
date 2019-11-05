<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<script type="text/javascript" src="plug-in/echart/echarts.js"></script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_al_alarm_info</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbAlAlarmInfoController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbAlAlarmInfo.id}"/>
		<div class="row">
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					告警编号：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="alarmNo" type="text" class="form-control" maxlength="200" value = "${tbAlAlarmInfo.alarmNo}"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					告警时间：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="alarmTime" type="text" class="form-control" maxlength="21" value = "${tbAlAlarmInfo.alarmTime}"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					告警级别：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="alarmLevel" type="text" class="form-control" maxlength="2" value = "${tbAlAlarmInfo.alarmLevel}"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					所属机房：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="computerRoomId" type="text" class="form-control" maxlength="32" value = "${tbAlAlarmInfo.computerRoomId}"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					机柜编号：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="cabineNo" type="text" class="form-control" maxlength="200" value = "${tbAlAlarmInfo.cabineNo}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					机器人ID：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="robotsInfoId" type="text" class="form-control" maxlength="32" value = "${tbAlAlarmInfo.robotsInfoId}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					告警类型包括指示灯告警、动环告警：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="alarmType" type="text" class="form-control" maxlength="2" value = "${tbAlAlarmInfo.alarmType}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					所属部门(设备对应的部门)：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="equipmentDeptId" type="text" class="form-control" maxlength="32" value = "${tbAlAlarmInfo.equipmentDeptId}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					处理状态：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="handStatus" type="text" class="form-control" maxlength="2" value = "${tbAlAlarmInfo.handStatus}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					处理类型：处理告警、忽略告警、修正告警：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="handType" type="text" class="form-control" maxlength="2" value = "${tbAlAlarmInfo.handType}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					处理时间：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="handTime" type="text" class="form-control" maxlength="21" value = "${tbAlAlarmInfo.handTime}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					处理人：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="handUserName" type="text" class="form-control" maxlength="100" value = "${tbAlAlarmInfo.handUserName}"  ignore="ignore"  />
				</div>
			</div>
		</div>
					<div class="bt-item col-md-6 col-sm-6">
			        <div class="row">
						<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
							故障原因：
						</div>
				     <div class="col-md-9 col-sm-9 col-xs-9 bt-content">
						  	 	<textarea name="failureCause" class="form-control input-sm" rows="6"  ignore="ignore" >${tbAlAlarmInfo.failureCause}</textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">故障原因</label>
			          </div>
						</div>
					<div class="bt-item col-md-6 col-sm-6">
			        <div class="row">
						<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
							处理方案：
						</div>
				     <div class="col-md-9 col-sm-9 col-xs-9 bt-content">
						  	 	<textarea name="treatmentPlan" class="form-control input-sm" rows="6"  ignore="ignore" >${tbAlAlarmInfo.treatmentPlan}</textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">处理方案</label>
			          </div>
						</div>
		</div>
	</form>
	</div>
 </div>
 <div id="main"></div>
<script type="text/javascript">
var subDlgIndex = '';
$(document).ready(function() {
	//单选框/多选框初始化
	$('.i-checks').iCheck({
		labelHover : false,
		cursor : true,
		checkboxClass : 'icheckbox_square-green',
		radioClass : 'iradio_square-green',
		increaseArea : '20%'
	});
	
	//表单提交
	$("#formobj").Validform({
		tiptype:function(msg,o,cssctl){
			if(o.type==3){
				validationMessage(o.obj,msg);
			}else{
				removeMessage(o.obj);
			}
		},
		btnSubmit : "#btn_sub",
		btnReset : "#btn_reset",
		ajaxPost : true,
		beforeSubmit : function(curform) {
		},
		usePlugin : {
			passwordstrength : {
				minLen : 6,
				maxLen : 18,
				trigger : function(obj, error) {
					if (error) {
						obj.parent().next().find(".Validform_checktip").show();
						obj.find(".passwordStrength").hide();
					} else {
						$(".passwordStrength").show();
						obj.parent().next().find(".Validform_checktip").hide();
					}
				}
			}
		},
		callback : function(data) {
			var win = frameElement.api.opener;
			if (data.success == true) {
				frameElement.api.close();
			   // win.reloadTable();
			    win.tip(data.msg);
			} else {
			    if (data.responseText == '' || data.responseText == undefined) {
			        $.messager.alert('错误', data.msg);
			        $.Hidemsg();
			    } else {
			        try {
			            var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
			            $.messager.alert('错误', emsg);
			            $.Hidemsg();
			        } catch (ex) {
			            $.messager.alert('错误', data.responseText + "");
			            $.Hidemsg();
			        }
			    }
			    return false;
			}
		}
	});
});
<c:forEach items="${TbAlAlarmInfosEntity}" var="item" varStatus="status" >  
	   var temp = "${item}";
	   var gj={name:'告警数据', type:'bar', data:[
			${item.temperature_value},
			${item.humidity_value},
			${item.noise_value},
			${item.pm25_value},
			${item.pollution_gas_value},
			${item.equipment_temperature_value}],};  //拼接告警数据
		var hjLow={name:'环境阈值', type:'bar', data:[
			${item.temperature_low},
			${item.humidity_low},
			${item.noise_low},
			${item.pm25_low},
			${item.pollution_gas_low},
			${item.equipment_temperature_low}],};  //拼接环境阈值（低）
		var hjHeight={name:'环境阈值', type:'bar', data:[
			${item.temperature_high},
			${item.humidity_high},
			${item.noise_high},
			${item.pm25_high},
			${item.pollution_gas_high},
			${item.equipment_temperature_high}]};  //拼接环境阈值（高）	
	</c:forEach>		   
    var echartsWarp= document.getElementById('main');     
    var resizeWorldMapContainer = function () {//用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽  
        echartsWarp.style.width = window.innerWidth-20+'px';  
        echartsWarp.style.height = window.innerHeight-20+'px';  
    };        
    resizeWorldMapContainer ();//设置容器高宽  
    var myChart = echarts.init(echartsWarp);
   var s= {
    	    title : {
    	        text: '动环告警详情',
    	  
    	    },
    	    tooltip : {
    	        trigger: 'axis'
    	    },
    	    legend: {
    	        data:['告警数据','环境阈值']
    	    },
    	    toolbox: {
    	        show : true,
    	        feature : {
    	            dataView : {show: true, readOnly: false},
    	            magicType : {show: true, type: ['line', 'bir'] ,
		    	            iconStyle: {
		                                borderColor: '#1e90ff'
		                            },
		                               emphasis:{
		                                iconStyle: {
		                                    borderColor: '#22bb22'
		                                },
		                            }
    	            
    	                          },
    	            restore : {show: true},
    	            saveAsImage : {show: true}
    	        }
    	    },
    	    calculable : true,
    	    xAxis : [
    	        {
    	            type : 'category',
    	            data : ['温度/°C','湿度/°C','噪音/DB','PM2.5/Ug/m3','污染气体/mmp','设备温度/°C']
    	        }
    	    ],
    	    yAxis : [
    	        {
    	            type : 'value'
    	        }
    	    ],
    	    series : [
    	      hjLow, gj,  hjHeight   
    	    ]
    	};
    	 option =s;
    	
    myChart.setOption(option);
</script>
</body>
</html>