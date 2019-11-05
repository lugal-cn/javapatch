<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_his_patrol</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbHisPatrolController.do?doAdd" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<div class="form-group">
			<label for="robotsInfoId" class="col-sm-3 control-label">机器人信息表ID：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="robotsInfoId" name="robotsInfoId" type="text" maxlength="32" class="form-control input-sm" placeholder="请输入机器人信息表ID"  datatype="*"  ignore="checked" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="computerRoomId" class="col-sm-3 control-label">所属机房（来自机房列表）：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="computerRoomId" name="computerRoomId" type="text" maxlength="32" class="form-control input-sm" placeholder="请输入所属机房（来自机房列表）"  datatype="*"  ignore="checked" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="patrolTaskType" class="col-sm-3 control-label">任务类型：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="patrolTaskType" name="patrolTaskType" type="text" maxlength="2" class="form-control input-sm" placeholder="请输入任务类型"  datatype="*"  ignore="checked" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="patrolTaskId" class="col-sm-3 control-label">巡检任务表ID：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="patrolTaskId" name="patrolTaskId" type="text" maxlength="32" class="form-control input-sm" placeholder="请输入巡检任务表ID"  datatype="*"  ignore="checked" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="patrolStartTime" class="col-sm-3 control-label">巡检开始时间：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="patrolStartTime" name="patrolStartTime" type="text" maxlength="21" class="form-control input-sm" placeholder="请输入巡检开始时间"  ignore="ignore" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="patrolEndTime" class="col-sm-3 control-label">巡检结束时间：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="patrolEndTime" name="patrolEndTime" type="text" maxlength="21" class="form-control input-sm" placeholder="请输入巡检结束时间"  ignore="ignore" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="completionRate" class="col-sm-3 control-label">完成比例：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="completionRate" name="completionRate" type="text" maxlength="100" class="form-control input-sm" placeholder="请输入完成比例"  ignore="ignore" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="stopLocation" class="col-sm-3 control-label">停检位置：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="stopLocation" name="stopLocation" type="text" maxlength="100" class="form-control input-sm" placeholder="请输入停检位置"  ignore="ignore" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="alarmNum" class="col-sm-3 control-label">告警数量：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="alarmNum" name="alarmNum" type="text" maxlength="10" class="form-control input-sm" placeholder="请输入告警数量"  datatype="n"  ignore="ignore" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="createTime" class="col-sm-3 control-label">创建时间：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="createTime" name="createTime" type="text" maxlength="21" class="form-control input-sm" placeholder="请输入创建时间"  datatype="*"  ignore="checked" />
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