<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_al_alarm_info</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,jquery,easyui,layer,validform,bootstrap-form,autocomplete,DatePicker"></t:base> 
<%-- <t:base type="jquery,easyui,tools,autocomplete,DatePicker"></t:base>  --%>
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
					处理时间：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input id="d122" name="handTime" type="text" datatype="*" ignore="checked" class="form-control input-sm"  style="width:120px;" readonly="true"/>
		 	<!-- <img onclick="WdatePicker({el:'d122'})" src="plug-in/easyui/themes/black/images/datebox_arrow.png" style="opacity: 0.6;height:17px;width:17px;" align="absmiddle"> -->
			
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					处理人：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="handUserName" type="text" class="form-control input-sm" maxlength="100"  datatype="*" ignore="checked"   />
				</div>
			</div>
		</div>
		<div class="bt-item col-md-6 col-sm-6">
			<div class="row">
				<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
					故障原因：
				</div>
				<div class="col-md-9 col-sm-9 col-xs-9 bt-content">
					<input name="failureCause" type="text" class="form-control input-sm" maxlength="21"  datatype="*"  ignore="checked"  />
				</div>
			</div>
		</div>							
		
		
					<div class="bt-item col-md-6 col-sm-6">
			        <div class="row">
						<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
							处理方案：
						</div>
				     <div class="col-md-9 col-sm-9 col-xs-9 bt-content">
						  	 	<textarea name="treatmentPlan" value = "${tbAlAlarmInfo.id}" class="form-control input-sm" rows="6"  ignore="checked" ></textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">故障原因</label>
			          </div>
						</div>
					
	</form>
	</div>
 </div>
<script type="text/javascript">
document.getElementById('d122').value="${tbAlAlarmInfo.handTime}";
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
				  win.location.reload();
			   /*  win.reloadTable();
			    win.tip(data.msg); */
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