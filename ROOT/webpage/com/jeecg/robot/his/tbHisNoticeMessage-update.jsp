<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_his_notice_message</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbHisNoticeMessageController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbHisNoticeMessage.id}"/>
	<div class="form-group">
		<label for="noticeMessageType" class="col-sm-3 control-label">消息类型（错误、警告和一般）：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="noticeMessageType" name="noticeMessageType" value='${tbHisNoticeMessage.noticeMessageType}' type="text" maxlength="2" class="form-control input-sm" placeholder="请输入消息类型（错误、警告和一般）"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="computerRoomId" class="col-sm-3 control-label">所属机房：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="computerRoomId" name="computerRoomId" value='${tbHisNoticeMessage.computerRoomId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入所属机房"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="noticeMessageTime" class="col-sm-3 control-label">时间：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="noticeMessageTime" name="noticeMessageTime" value='${tbHisNoticeMessage.noticeMessageTime}' type="text" maxlength="21" class="form-control input-sm" placeholder="请输入时间"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="robotsInfoId" class="col-sm-3 control-label">对象机器人信息表ID，平台
            发起和接受对象：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="robotsInfoId" name="robotsInfoId" value='${tbHisNoticeMessage.robotsInfoId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入对象机器人信息表ID，平台
            发起和接受对象"  ignore="ignore" />
			</div>
		</div>
	</div>
					<div class="form-group">
					<label for="noticeMessageContent" class="col-sm-3 control-label">消息内容：</label>
					<div class="col-sm-7">
					<div class="input-group" style="width:100%">
						  	 	<textarea name="noticeMessageContent" class="form-control input-sm" rows="6"  ignore="ignore" >${tbHisNoticeMessage.noticeMessageContent}</textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">消息内容</label>
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