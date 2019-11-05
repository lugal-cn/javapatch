<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>机器人备份表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbRoRobotsBackupController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbRoRobotsBackup.id}"/>
	<div class="form-group">
		<label for="robotsInfoId" class="col-sm-3 control-label">机器人ID：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
               <t:dictSelect field="robotsInfoId" type="list" extendJson="{class:'form-control input-sm'}"  datatype="*"   typeGroupCode=""  hasLabel="false"  title="机器人ID" defaultVal="${tbRoRobotsBackup.robotsInfoId}"></t:dictSelect>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="serialNo" class="col-sm-3 control-label">序号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="serialNo" name="serialNo" value='${tbRoRobotsBackup.serialNo}' type="text" maxlength="10" class="form-control input-sm" placeholder="请输入序号"  datatype="n"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="backupTime" class="col-sm-3 control-label">备份时间：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="backupTime" name="backupTime" value='${tbRoRobotsBackup.backupTime}' type="text" maxlength="21" class="form-control input-sm" placeholder="请输入备份时间"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="fileSize" class="col-sm-3 control-label">文件大小：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="fileSize" name="fileSize" value='${tbRoRobotsBackup.fileSize}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入文件大小"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="versionNo" class="col-sm-3 control-label">版本号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="versionNo" name="versionNo" value='${tbRoRobotsBackup.versionNo}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入版本号"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="fileUrl" class="col-sm-3 control-label">文件路径：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="fileUrl" name="fileUrl" value='${tbRoRobotsBackup.fileUrl}' type="text" maxlength="512" class="form-control input-sm" placeholder="请输入文件路径"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="backupUserId" class="col-sm-3 control-label">备份人：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="backupUserId" name="backupUserId" value='${tbRoRobotsBackup.backupUserId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入备份人"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="recoveryStatus" class="col-sm-3 control-label">恢复状态：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="recoveryStatus" name="recoveryStatus" value='${tbRoRobotsBackup.recoveryStatus}' type="text" maxlength="2" class="form-control input-sm" placeholder="请输入恢复状态"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="recoveryTime" class="col-sm-3 control-label">恢复时间：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="recoveryTime" name="recoveryTime" value='${tbRoRobotsBackup.recoveryTime}' type="text" maxlength="21" class="form-control input-sm" placeholder="请输入恢复时间"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="recoveryUserId" class="col-sm-3 control-label">恢复人：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="recoveryUserId" name="recoveryUserId" value='${tbRoRobotsBackup.recoveryUserId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入恢复人"  ignore="ignore" />
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