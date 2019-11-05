<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>机房列表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,webuploader,bootstrap-form"></t:base><t:base type="tools"></t:base>
<t:base type="tools"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbCrComputerRoomController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbCrComputerRoom.id}"/>
		<input type="hidden" id="mapUrl1" name="mapUrl1" value="${tbCrComputerRoom.mapUrl}"/>
	<div class="form-group">
		<label for="computerRoomName" class="col-sm-3 control-label">机房名称：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="computerRoomName" name="computerRoomName" value='${tbCrComputerRoom.computerRoomName}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入机房名称"  datatype="*"  ignore="checked" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="mapUrl" class="col-sm-3 control-label">地图存储路径：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<t:webUploader name="mapUrl" outJs="true" auto="true" showImgDiv="filediv_mapUrl" fileNumLimit="1" type="image" buttonText='更换图片' displayTxt="false" pathValues="${tbCrComputerRoom.mapUrl}" datatype="*"></t:webUploader>
				<div class="form" id="filediv_mapUrl"></div>
				<span id="tpfd">
					<input type="button" value="图片放大" onclick="tpfd()">
				</span>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<%-- <div class="form-group">
		<label for="createTime" class="col-sm-3 control-label">创建时间：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="createTime" name="createTime" value='${tbCrComputerRoom.createTime}' type="text" maxlength="21" class="form-control input-sm" placeholder="请输入创建时间"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="createUserId" class="col-sm-3 control-label">创建人：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="createUserId" name="createUserId" value='${tbCrComputerRoom.createUserId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入创建人"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="createDept" class="col-sm-3 control-label">创建部门：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="createDept" name="createDept" value='${tbCrComputerRoom.createDept}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入创建部门"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div> --%>
	<div class="ui_buttons">
		<input type="button" id="id1" value="提交" onclick="saveObj()" class="ui_state_highlight ui_state_close">
		<input type="button" id="id2" value="关闭" onclick="closeObj()" class="ui_state_close">
	</div>
	</form>
	</div>
 </div>
<script type="text/javascript">
//alert("${tbCrComputerRoom.mapUrl}");
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
	var mapUrl1 = $("#mapUrl1").val();
	if(!mapUrl1){
		$('#tpfd').hide();
	}
	
});
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
function tpfd(){
	var mapUrl1 = $("#mapUrl1").val();
	openwindow("查看","tbCrComputerRoomController.do?viewPic&mapUrl1="+mapUrl1,'',800,400);
}
</script>
</body>
</html>