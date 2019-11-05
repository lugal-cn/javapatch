<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>系统参数配置表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbMsParamConfigureController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbMsParamConfigure.id}"/>
	<div class="form-group">
		<label for="paramConfigureType" class="col-sm-3 control-label">参数类型：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
               <t:dictSelect field="paramConfigureType" type="list" extendJson="{class:'form-control input-sm'}"  datatype="*"   typeGroupCode="itacs_alarm_level"  hasLabel="false"  title="参数类型" defaultVal="${tbMsParamConfigure.paramConfigureType}"></t:dictSelect>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="paramConfigureName" class="col-sm-3 control-label">是否按部门告警：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
               <t:dictSelect field="paramConfigureName" type="list" extendJson="{class:'form-control input-sm'}"  datatype="*"   typeGroupCode="sf_yn"  hasLabel="false"  title="是否按部门告警" defaultVal="${tbMsParamConfigure.paramConfigureName}"></t:dictSelect>
			</div>
		</div>
		<font style="color: red;">*</font>
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