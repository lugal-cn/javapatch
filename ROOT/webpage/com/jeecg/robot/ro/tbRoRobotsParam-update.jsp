<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_ro_robots_param</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbRoRobotsParamController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbRoRobotsParam.id}"/>
		<div class="row">
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					机器人ID：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="robotsInfoId" type="text" class="form-control" maxlength="32" value = "${tbRoRobotsParam.robotsInfoId}"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					识别摄像头数量（来源机器人型号表）：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="identifyCamerasNumber" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.identifyCamerasNumber}"  datatype="n"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					热成像摄像头数量（来源机器人型号表）：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="imgCamerasNumber" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.imgCamerasNumber}"  datatype="n"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					选择传感器（来源机器人型号表）：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="sensors" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.sensors}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					日常巡检开始前电量自检得最低电量值（立即巡检前也要电量自检）：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="powerValueMin" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.powerValueMin}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					低电量提醒中得初次提示电量：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="powerValueFirst" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.powerValueFirst}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					强制回充电量：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="forcedRecharge" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.forcedRecharge}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					遇障等待时间（机器人在遇障时，重新规划路径时间，在时间范围内若无法重新规划一条新的路径，机器人则返回充电）：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="obstaclesWaitingTime" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.obstaclesWaitingTime}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					非巡检状态下动环检测时间间隔：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="timeInterval" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.timeInterval}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					直播摄像头配置_IP：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="liveCamerasIp" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.liveCamerasIp}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					直播摄像头配置_用户名：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="liveCamerasName" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.liveCamerasName}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					直播摄像头配置_密码：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="liveCamerasPwd" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.liveCamerasPwd}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					热成像摄像头配置_IP：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="imgCamerasIp" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasIp}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					热成像摄像头配置_用户名：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="imgCamerasName" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasName}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					热成像摄像头配置_密码：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="imgCamerasPwd" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasPwd}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					热成像摄像头配置_IP：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="imgCamerasIp2" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasIp2}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					热成像摄像头配置_用户名：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="imgCamerasName2" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasName2}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					热成像摄像头配置_密码：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="imgCamerasPwd2" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasPwd2}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					serverIp：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="serverIp" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.serverIp}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					温度设置：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="temperatureLow" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.temperatureLow}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					温度设置：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="temperatureHigh" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.temperatureHigh}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					湿度设置低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="humidityLow" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.humidityLow}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					湿度设置高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="humidityHigh" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.humidityHigh}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					噪声低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="noiseLow" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.noiseLow}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					噪声高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="noiseHigh" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.noiseHigh}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					PM2.5低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pm25Low" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.pm25Low}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					PM2.5高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pm25High" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.pm25High}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					污染气体低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pollutionGasLow" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.pollutionGasLow}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					污染气体高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pollutionGasHigh" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.pollutionGasHigh}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					设备温度低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="equipmentTemperatureLow" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.equipmentTemperatureLow}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					设备温度高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="equipmentTemperatureHigh" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.equipmentTemperatureHigh}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					创建时间：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="createTime" type="text" class="form-control" maxlength="21" value = "${tbRoRobotsParam.createTime}"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					创建人：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="createUserId" type="text" class="form-control" maxlength="32" value = "${tbRoRobotsParam.createUserId}"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					创建部门：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="createDept" type="text" class="form-control" maxlength="32" value = "${tbRoRobotsParam.createDept}"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					温度设置标识：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="temperatureFlag" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.temperatureFlag}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					湿度设置标识：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="humidityFlag" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.humidityFlag}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					噪音设置标识：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="noiseFlag" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.noiseFlag}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					PM2.5设置标识：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pm25Flag" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.pm25Flag}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					污染气体设置标识：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pollutionGasFlag" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.pollutionGasFlag}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					设备温度设置标识：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="equipmentTemperatureFlag" type="text" class="form-control" maxlength="10" value = "${tbRoRobotsParam.equipmentTemperatureFlag}"  ignore="ignore"  />
				</div>
			</div>
		</div>
		</div>
	</form>
	</div>
 </div>
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
			    win.reloadTable();
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
</script>
</body>
</html>