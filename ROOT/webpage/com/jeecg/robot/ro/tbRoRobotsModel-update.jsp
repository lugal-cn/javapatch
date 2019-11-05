<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>机器人型号表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbRoRobotsModelController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbRoRobotsModel.id}"/>
	<div class="form-group">
		<label for="robotsModel" class="col-sm-3 control-label">机器人型号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="robotsModel" name="robotsModel" value='${tbRoRobotsModel.robotsModel}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入机器人型号"  datatype="*"  ignore="checked" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<%-- <div class="form-group">
		<label for="identifyCamerasNumber" class="col-sm-3 control-label">识别摄像头数量：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="identifyCamerasNumber" name="identifyCamerasNumber" value='${tbRoRobotsModel.identifyCamerasNumber}' type="text" maxlength="10" class="form-control input-sm" placeholder="请输入识别摄像头数量"  datatype="/\b\d{1}\b/g" errormsg="请输入一位整数" ignore="ignore" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div> --%>
	<div class="form-group">
		<label for="sliderCamerasTakeNumber" class="col-sm-3 control-label">滑竿拍照摄像头数量：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="sliderCamerasTakeNumber" name="sliderCamerasTakeNumber" value='${tbRoRobotsModel.sliderCamerasTakeNumber}' type="text" maxlength="10" class="form-control input-sm" placeholder="请输入滑竿拍照摄像头数量"  datatype="/\b\d{1}\b/g" errormsg="请输入一位整数" ignore="ignore" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="sliderCamerasLiveNumber" class="col-sm-3 control-label">滑竿直播摄像头数量：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="sliderCamerasLiveNumber" name="sliderCamerasLiveNumber" value='${tbRoRobotsModel.sliderCamerasLiveNumber}' type="text" maxlength="10" class="form-control input-sm" placeholder="滑竿直播摄像头数量 "  datatype="/\b\d{1}\b/g" errormsg="请输入一位整数" ignore="ignore" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="imgCamerasNumber" class="col-sm-3 control-label">热成像仪摄像头数量：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="imgCamerasNumber" name="imgCamerasNumber" value='${tbRoRobotsModel.imgCamerasNumber}' type="text" maxlength="10" class="form-control input-sm" placeholder="请输入热成像摄像头数量"  datatype="/\b\d{1}\b/g" errormsg="请输入一位整数" ignore="ignore" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="sensors" class="col-sm-3 control-label">选择传感器：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<t:dictSelect field="sensors" type="checkbox" typeGroupCode="itacs_sensors" hasLabel="false" title="数据库类型" defaultVal="${tbRoRobotsModel.sensors}"></t:dictSelect>
			</div>
		</div>
	</div>
	<div class="ui_buttons">
		<input type="button" id="id1" value="提交" onclick="saveObj()" class="ui_state_highlight ui_state_close">
		<input type="button" id="id2" value="关闭" onclick="closeObj()" class="ui_state_close">
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
	
});
var openType = '${openType}';
if(openType && openType == 1) {
	$("#id1").hide();
} else {
	$("#id1").show();
}
/**  执行保存 */
function saveObj() {
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
			var framename = '${framename}';
			window.parent.frames[framename].reloadTable();
			closeObj();
			if (data.success == true) {
				var my = window.parent.document.getElementById("ldg_lockmask");
				 if (my != null) {
				        my.parentNode.removeChild(my);
				    }
			}
		}
	});
	$("#formobj").submit();
	//closeObj();
}
//关闭页面
var requrl = '${requrl}';
var tabId = '${tabId}';
function closeObj() {
	window.top.closeTab("tab_"+tabId);
	/* var aobj = window.top.$("a[data-id='"+requrl+"']");
	window.top.closePage2(aobj); */
}
</script>
</body>
</html>