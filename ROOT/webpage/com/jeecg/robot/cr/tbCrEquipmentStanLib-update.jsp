<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>设备标准库</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbCrEquipmentStanLibController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbCrEquipmentStanLib.id}"/>
	<div class="form-group">
		<label for="equipmentModel" class="col-sm-3 control-label">设备型号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="equipmentModel" name="equipmentModel" value='${tbCrEquipmentStanLib.equipmentModel}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入设备型号"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="equipmentType" class="col-sm-3 control-label">设备类型：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="equipmentType" name="equipmentType" value='${tbCrEquipmentStanLib.equipmentType}' type="text" maxlength="2" class="form-control input-sm" placeholder="请输入设备类型"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="equipmentManufacturer" class="col-sm-3 control-label">厂商：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="equipmentManufacturer" name="equipmentManufacturer" value='${tbCrEquipmentStanLib.equipmentManufacturer}' type="text" maxlength="500" class="form-control input-sm" placeholder="请输入厂商"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="equipmentHeight" class="col-sm-3 control-label">高度：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="equipmentHeight" name="equipmentHeight" value='${tbCrEquipmentStanLib.equipmentHeight}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入高度"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="equipmentSize" class="col-sm-3 control-label">尺寸：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="equipmentSize" name="equipmentSize" value='${tbCrEquipmentStanLib.equipmentSize}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入尺寸"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="frontalRecognitionPoints" class="col-sm-3 control-label">正面识别点：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="frontalRecognitionPoints" name="frontalRecognitionPoints" value='${tbCrEquipmentStanLib.frontalRecognitionPoints}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入正面识别点"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="backRecognitionPoints" class="col-sm-3 control-label">背面识别点：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="backRecognitionPoints" name="backRecognitionPoints" value='${tbCrEquipmentStanLib.backRecognitionPoints}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入背面识别点"  ignore="ignore" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="createTime" class="col-sm-3 control-label">创建时间：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="createTime" name="createTime" value='${tbCrEquipmentStanLib.createTime}' type="text" maxlength="21" class="form-control input-sm" placeholder="请输入创建时间"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="createUserId" class="col-sm-3 control-label">创建人：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="createUserId" name="createUserId" value='${tbCrEquipmentStanLib.createUserId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入创建人"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="createDept" class="col-sm-3 control-label">创建部门：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="createDept" name="createDept" value='${tbCrEquipmentStanLib.createDept}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入创建部门"  datatype="*"  ignore="checked" />
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