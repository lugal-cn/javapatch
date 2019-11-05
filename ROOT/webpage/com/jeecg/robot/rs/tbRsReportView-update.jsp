<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>报表查看表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbRsReportViewController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbRsReportView.id}"/>
	<div class="form-group">
		<label for="reportName" class="col-sm-3 control-label">报表名称：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="reportName" name="reportName" value='${tbRsReportView.reportName}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入报表名称"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="reportType" class="col-sm-3 control-label">报表类型：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="reportType" name="reportType" value='${tbRsReportView.reportType}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入报表类型"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="reportStyle" class="col-sm-3 control-label">报表样式：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="reportStyle" name="reportStyle" value='${tbRsReportView.reportStyle}' type="text" maxlength="2" class="form-control input-sm" placeholder="请输入报表样式"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="computerRoomId" class="col-sm-3 control-label">机房名称：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="computerRoomId" name="computerRoomId" value='${tbRsReportView.computerRoomId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入机房名称"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="createUserId" class="col-sm-3 control-label">创建人：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="createUserId" name="createUserId" value='${tbRsReportView.createUserId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入创建人"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="createTime" class="col-sm-3 control-label">创建时间：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="createTime" name="createTime" value='${tbRsReportView.createTime}' type="text" maxlength="21" class="form-control input-sm" placeholder="请输入创建时间"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="createDept" class="col-sm-3 control-label">创建部门：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="createDept" name="createDept" value='${tbRsReportView.createDept}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入创建部门"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="reportCycle" class="col-sm-3 control-label">统计周期：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="reportCycle" name="reportCycle" value='${tbRsReportView.reportCycle}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入统计周期"  ignore="ignore" />
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