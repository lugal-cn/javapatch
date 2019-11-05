<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>机房告警统计表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbRsReportAlarmRoomController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbRsReportAlarmRoom.id}"/>
	<div class="form-group">
		<label for="reportViewId" class="col-sm-3 control-label">报表查看ID：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="reportViewId" name="reportViewId" value='${tbRsReportAlarmRoom.reportViewId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入报表查看ID"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="cabineNo" class="col-sm-3 control-label">机柜编号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="cabineNo" name="cabineNo" value='${tbRsReportAlarmRoom.cabineNo}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入机柜编号"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="patrolTimes" class="col-sm-3 control-label">巡检次数：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="patrolTimes" name="patrolTimes" value='${tbRsReportAlarmRoom.patrolTimes}' type="text" maxlength="10" class="form-control input-sm" placeholder="请输入巡检次数"  datatype="n"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="alarmLightTimes" class="col-sm-3 control-label">指示灯告警次数：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="alarmLightTimes" name="alarmLightTimes" value='${tbRsReportAlarmRoom.alarmLightTimes}' type="text" maxlength="10" class="form-control input-sm" placeholder="请输入指示灯告警次数"  datatype="n"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="alarmLightFailurerate" class="col-sm-3 control-label">指示灯告故障率：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="alarmLightFailurerate" name="alarmLightFailurerate" value='${tbRsReportAlarmRoom.alarmLightFailurerate}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入指示灯告故障率"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="alarmMenvTimes" class="col-sm-3 control-label">动环告警次数：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="alarmMenvTimes" name="alarmMenvTimes" value='${tbRsReportAlarmRoom.alarmMenvTimes}' type="text" maxlength="10" class="form-control input-sm" placeholder="请输入动环告警次数"  datatype="n"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="alarmMenvFailurerate" class="col-sm-3 control-label">动环告警故障率：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="alarmMenvFailurerate" name="alarmMenvFailurerate" value='${tbRsReportAlarmRoom.alarmMenvFailurerate}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入动环告警故障率"  ignore="ignore" />
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