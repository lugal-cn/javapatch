<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_al_alarm_menvironment</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbAlAlarmMenvironmentController.do?doAdd" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<div class="row">
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					告警信息ID：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="alarmInfoId" type="text" class="form-control input-sm" maxlength="32"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					温度：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="temperatureValue" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					湿度：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="humidityValue" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					噪声：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="noiseValue" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					PM2.5：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pm25Value" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					污染气体：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pollutionGasValue" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					设备温度：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="equipmentTemperatureValue" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					温度设置：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="temperatureLow" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					温度设置：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="temperatureHigh" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					湿度设置低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="humidityLow" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					湿度设置高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="humidityHigh" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					噪声低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="noiseLow" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					噪声高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="noiseHigh" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					PM2.5低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pm25Low" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					PM2.5高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pm25High" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					污染气体低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pollutionGasLow" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					污染气体高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="pollutionGasHigh" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					设备温度低：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="equipmentTemperatureLow" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					设备温度高：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="equipmentTemperatureHigh" type="text" class="form-control input-sm" maxlength="10"  ignore="ignore"  />
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