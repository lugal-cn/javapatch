<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_vo_voice_template_points</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbVoVoiceTemplatePointsController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbVoVoiceTemplatePoints.id}"/>
	<div class="form-group">
		<label for="voiceTemplateId" class="col-sm-3 control-label">语音模板ID：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="voiceTemplateId" name="voiceTemplateId" value='${tbVoVoiceTemplatePoints.voiceTemplateId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入语音模板ID"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="patrolPointsNo" class="col-sm-3 control-label">巡检点编号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="patrolPointsNo" name="patrolPointsNo" value='${tbVoVoiceTemplatePoints.patrolPointsNo}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入巡检点编号"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="xCoordinate" class="col-sm-3 control-label">X坐标：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="xCoordinate" name="xCoordinate" value='${tbVoVoiceTemplatePoints.xCoordinate}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入X坐标"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="yCoordinate" class="col-sm-3 control-label">Y坐标：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="yCoordinate" name="yCoordinate" value='${tbVoVoiceTemplatePoints.yCoordinate}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入Y坐标"  ignore="ignore" />
			</div>
		</div>
	</div>
					<div class="form-group">
					<label for="patrolPointsText" class="col-sm-3 control-label">巡检点语音文本：</label>
					<div class="col-sm-7">
					<div class="input-group" style="width:100%">
						  	 	<textarea name="patrolPointsText" class="form-control input-sm" rows="6"  datatype="*"  ignore="checked" >${tbVoVoiceTemplatePoints.patrolPointsText}</textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">巡检点语音文本</label>
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