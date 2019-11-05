<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>数据同步页面</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
<script type="text/javascript" src="/plug-in/themes/fineui/jquery/jquery.easyui.min.js"></script>
<!-- <link rel="stylesheet" href="/plug-in/easyui/themes/default/easyui.css" type="text/css"></link> -->
<link rel="stylesheet" href="/plug-in/easyui/themes/metrole/easyui.css" type="text/css"></link> 
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbRoRobotsParamController.do?synchData" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="robotsInfoId" name="robotsInfoId" value="${robotsInfoId}"/>
		<input type="hidden" id="robotsIp" name="robotsIp" value="${robotsIp}"/>
		<input type="hidden" id="data1" name="data1" value=""/>
		<input type="hidden" id="data2" name="data2" value=""/>
		<input type="hidden" id="data3" name="data3" value=""/>
		<input type="hidden" id="data4" name="data4" value=""/>
		<input type="hidden" id="data5" name="data5" value=""/>
		<!-- <input type="hidden" id="data6" name="data6" value=""/> -->
		<div class="form-group">
			<label for="sensors" class="col-sm-3 control-label">选择同步的数据模块：</label>
			<div class="col-sm-2">
				<div class="input-group" style="width:100%">
					<input type="checkbox" id="e1" name="e1" value="1" />  机房，机柜，设备等信息<br>
					<input type="checkbox" id="e2" name="e2" value="2" />  数据同步—机器人配置参数<br>
					<input type="checkbox" id="e3" name="e3" value="3" />  语音播报，语音交互信息<br>
					<input type="checkbox" id="e4" name="e4" value="4" />  巡检任务，巡检计划信息<br>
					<!-- <input type="checkbox" id="e5" name="e5" value="5" />  <br> -->
					<input type="checkbox" id="e5" name="e5" value="5" />  人员信息，访客历史信息<br>
				</div>
			</div>
			
		</div>
	</form>
	</div>
 </div>
<script type="text/javascript">
var robotsInfoId = '${robotsInfoId}';
var robotsIp = '${robotsIp}';

//同步设备数据
function synchData() {
	$.ajax({
		url : "tbRoRobotsParamController.do?synchData",
		type : 'post',
		data: {robotsInfoId:robotsInfoId, robotsIp:robotsIp},
		datatype:'json',
		cache : false,
		async : false,
		success : function(data) {
			var d = $.parseJSON(data);
			var msg = d.msg;
		}
	});
}
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
			//机房，机柜，设备等信息
			var e1 = document.getElementById("e1").checked;
			var e2 = document.getElementById("e2").checked;
			var e3 = document.getElementById("e3").checked;
			var e4 = document.getElementById("e4").checked;
			var e5 = document.getElementById("e5").checked;
			if(!e1 && !e2 && !e3&&!e4&&!e5) {
				$.messager.alert("提示","没有选中要下发的数据模块！");
				return false;
			}
			if(e1){
				$("#data1").val(1);
			}else {
				$("#data1").val("");
			}
			if(e2){
				$("#data2").val(2);
			}else {
				$("#data2").val("");
			}
			if(e3){
				$("#data3").val(3);
			}else {
				$("#data3").val("");
			}
			if(e4){
				$("#data4").val(4);
			}else{
				$("#data4").val("");
			}
			if(e5){
				$("#data5").val(5);
			}else{
				$("#data5").val("");
			}
			$.messager.progress({
                title : '提示',
                text : '数据同步中，请稍后。。。'
            });
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
			$.messager.progress('close');
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