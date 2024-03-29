<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_ms_mailbox_set</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbMsMailboxSetController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbMsMailboxSet.id}"/>
	<div class="form-group">
		<label for="smtpServerAddr" class="col-sm-3 control-label">SMTP服务器地址：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="smtpServerAddr" name="smtpServerAddr" value='${tbMsMailboxSet.smtpServerAddr}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入SMTP服务器地址"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="mailboxAccount" class="col-sm-3 control-label">邮箱账号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="mailboxAccount" name="mailboxAccount" value='${tbMsMailboxSet.mailboxAccount}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入邮箱账号"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="mailboxPassword" class="col-sm-3 control-label">密码：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="mailboxPassword" name="mailboxPassword" value='${tbMsMailboxSet.mailboxPassword}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入密码"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="encryptionMode" class="col-sm-3 control-label">加密方式有（不加密、SSL、TLS等）：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="encryptionMode" name="encryptionMode" value='${tbMsMailboxSet.encryptionMode}' type="text" maxlength="2" class="form-control input-sm" placeholder="请输入加密方式有（不加密、SSL、TLS等）"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="mailboxPort" class="col-sm-3 control-label">端口：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="mailboxPort" name="mailboxPort" value='${tbMsMailboxSet.mailboxPort}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入端口"  ignore="ignore" />
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