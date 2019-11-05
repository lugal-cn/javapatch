<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_al_alarm_Indi_light</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbAlAlarmIndiLightController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbAlAlarmIndiLight.id}"/>
	<div class="form-group">
		<label for="alarmInfoId" class="col-sm-3 control-label">告警信息ID：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="alarmInfoId" name="alarmInfoId" value='${tbAlAlarmIndiLight.alarmInfoId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入告警信息ID"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="alarmIndiLightSou" class="col-sm-3 control-label">告警来源：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="alarmIndiLightSou" name="alarmIndiLightSou" value='${tbAlAlarmIndiLight.alarmIndiLightSou}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入告警来源"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="equipmentId" class="col-sm-3 control-label">故障设备ID：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="equipmentId" name="equipmentId" value='${tbAlAlarmIndiLight.equipmentId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入故障设备ID"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="faultEquipmentUrl" class="col-sm-3 control-label">故障图片路径：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="faultEquipmentUrl" name="faultEquipmentUrl" value='${tbAlAlarmIndiLight.faultEquipmentUrl}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入故障图片路径"  ignore="ignore" />
			</div>
		</div>
	</div>
					<div class="form-group">
					<label for="alarmIndiLightDesc" class="col-sm-3 control-label">告警描述：</label>
					<div class="col-sm-7">
					<div class="input-group" style="width:100%">
						  	 	<textarea name="alarmIndiLightDesc" class="form-control input-sm" rows="6"  datatype="*"  ignore="checked" >${tbAlAlarmIndiLight.alarmIndiLightDesc}</textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">告警描述</label>
			          </div>
						</div>
					<div class="form-group">
					<label for="faultEquipment" class="col-sm-3 control-label">故障设备：</label>
					<div class="col-sm-7">
					<div class="input-group" style="width:100%">
						  	 	<textarea name="faultEquipment" class="form-control input-sm" rows="6"  datatype="*"  ignore="checked" >${tbAlAlarmIndiLight.faultEquipment}</textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">故障设备</label>
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