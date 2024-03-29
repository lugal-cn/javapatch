<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_ro_robots_set_version</title>
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
		<input type="hidden" id="robotsInfoId" name="robotsInfoId" value="${tbRoRobotsParam.robotsInfoId}"/>
		<%-- <div class="form-group">
			<label for="identifyCamerasNumber" class="col-sm-3 control-label">识别摄像头编号：</label>
			<div class="col-sm-2">
				<div class="input-group" style="width:100%">
					<input id="identifyCamerasNumber" name="identifyCamerasNumber" type="text" maxlength="20" class="form-control input-sm" 
						placeholder="请输入识别摄像头编号" datatype="/\b\d{1}\b/g" errormsg="请输入一位整数" ignore="checked" value = "${tbRoRobotsParam.identifyCamerasNumber}"/>
				</div>
				<div>注：此处输入的数量与工作台-远程控制中推流画面数量一致。</div>
			</div>
		</div> --%>
		
		<div class="form-group">
			<label for="sliderCamerasTakeNumber" class="col-sm-3 control-label">滑竿拍照摄像头数量：</label>
			<div class="col-sm-2">
				<div class="input-group" style="width:100%">
					<input id="sliderCamerasTakeNumber" name="sliderCamerasTakeNumber" type="text" maxlength="20" class="form-control input-sm" 
						placeholder="请输入滑竿拍照摄像头数量" datatype="/\b\d{1}\b/g" errormsg="请输入一位整数" ignore="checked" value = "${tbRoRobotsParam.sliderCamerasTakeNumber}"/>
				</div>
				<div>注：此处输入的数量与工作台-远程控制中推流画面数量一致。</div>
			</div>
		</div>
		
			<div class="form-group">
			<label for="sliderCamerasLiveNumber" class="col-sm-3 control-label">滑竿直播摄像头数量：</label>
			<div class="col-sm-2">
				<div class="input-group" style="width:100%">
					<input id="sliderCamerasLiveNumber" name="sliderCamerasLiveNumber" type="text" maxlength="20" class="form-control input-sm" 
						placeholder="请输入滑竿直播摄像头数量" datatype="/\b\d{1}\b/g" errormsg="请输入一位整数" ignore="checked" value = "${tbRoRobotsParam.sliderCamerasLiveNumber}"/>
				</div>
				<div>注：此处输入的数量与工作台-远程控制中推流画面数量一致。</div>
			</div>
		</div>
		
		<div class="form-group">
			<label for="imgCamerasNumber" class="col-sm-3 control-label">热成像仪数量：</label>
			<div class="col-sm-2">
				<div class="input-group" style="width:100%">
					<input id="imgCamerasNumber" name="imgCamerasNumber" type="text" maxlength="20" class="form-control input-sm" 
						placeholder="请输入热成像摄像头编号" datatype="/\b\d{1}\b/g" errormsg="请输入一位整数" ignore="checked" value = "${tbRoRobotsParam.imgCamerasNumber}"/>
				</div>
			</div>
			<div class="col-sm-2">
				注：此处输入的数量与工作台中和工作台-远程控制中推流画面数量一致。
			</div>
		</div>
		<div class="form-group">
			<label for="sensors" class="col-sm-3 control-label">选择传感器：</label>
			<div class="col-sm-2">
				<div class="input-group" style="width:100%">
					<t:dictSelect field="sensors" type="checkbox" typeGroupCode="itacs_sensors" datatype="*" hasLabel="false" title="数据库类型" defaultVal="${tbRoRobotsParam.sensors}"></t:dictSelect>
				</div>
			</div>
			<div class="col-sm-2">
				注：此处选择与机器人列表-参数设置-动环阈值设置中一致。
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