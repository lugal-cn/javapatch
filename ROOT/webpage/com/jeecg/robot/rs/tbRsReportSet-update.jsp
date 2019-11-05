<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>报表设置表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
<!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbRsReportSetController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbRsReportSet.id}"/>
	<div class="form-group">
		<label for="reportSetName" class="col-sm-3 control-label">报表名称：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="reportSetName" name="reportSetName" value='${tbRsReportSet.reportSetName}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入报表名称" validType="tb_rs_report_set,report_set_name,id"  datatype="*"  ignore="checked" onblur="reportSetNameChecked()"/>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="reportSetStatus" class="col-sm-3 control-label">报表状态：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
               <t:dictSelect field="reportSetStatus" type="list" extendJson="{class:'form-control input-sm'}"  datatype="*"   typeGroupCode="itacs_report_set_status"  hasLabel="false"  title="报表状态" defaultVal="${tbRsReportSet.reportSetStatus}"></t:dictSelect>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	
	<div class="form-group">
		<label for="computerRoomId" class="col-sm-3 control-label">机房选择：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="computerRoomId" class="ac_input" name="computerRoomId" value='${tbRsReportSet.computerRoomId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入机房选择"  datatype="*"  ignore="checked" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="reportSetStyle" class="col-sm-3 control-label">报表样式：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
               <t:dictSelect field="reportSetStyle" type="list" extendJson="{class:'form-control input-sm',onchange:'isInter(this)'}"  datatype="*"   typeGroupCode="itacs_report_set_style"  hasLabel="false"  title="报表样式" defaultVal="${tbRsReportSet.reportSetStyle}"></t:dictSelect>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group" id="leixing1" style="display:none">
		<label for="reportSetType" class="col-sm-3 control-label">选择类型：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
               <t:dictSelect field="reportSetType" type="list" extendJson="{class:'form-control input-sm'}"   typeGroupCode="itacs_report_set_type"  hasLabel="false"  title="选择类型" defaultVal="${tbRsReportSet.reportSetType}"></t:dictSelect>
			</div>
		</div>
	</div>
	<div class="form-group" id="leixing2" style="display:none">
		<label for="reportSetType" class="col-sm-3 control-label">选择类型：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
               <t:dictSelect field="reportSetType1" readonly="readonly"   type="list" extendJson="{class:'form-control input-sm'}"   typeGroupCode="itacs_report_set_type"  hasLabel="false"  title="选择类型" defaultVal="01"></t:dictSelect>
			</div>
		</div>
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
	
	/*-------------------------------------------所属机房----------------------------------------------*/
	var select3Data = new Array();
	$.ajax({
		url:'tbRoRobotsInfoController.do?computerRoomSelect',
		type:'GET',
		dataType:'JSON',
		delay: 250,
		cache: true,
		success: function(data){
			for(var i = 0; i < data.length; i++){
				var select2Obj = {};
				select2Obj.id = data[i][0];
				select2Obj.text = data[i][1];
				select3Data.push(select2Obj);
			}
			$("#computerRoomId").select2({
				data: select3Data,
				placeholder:'请选择机房',//默认文字提示
			    language: "zh-CN",//汉化
			    allowClear: true//允许清空
			});
		}
	});
});
var setStyle= ${tbRsReportSet.reportSetStyle};
yangshi();
function yangshi(){
	if(setStyle=='1'||setStyle=='01'){
		document.getElementById("leixing2").style.display="";
		document.getElementById("leixing1").style.display="none";
	}else{
		document.getElementById("leixing1").style.display="";
		document.getElementById("leixing2").style.display="none";
		$("select[name='reportSetType'] option[value='01']").remove();
	}
}

function isInter(cthis){
    var isInter = cthis.value;
    if (isInter==01) {
    	document.getElementById("leixing1").style.display="none";
    	document.getElementById("leixing2").style.display="";
    }if (isInter==02) {
    	document.getElementById("leixing1").style.display="";
    	document.getElementById("leixing2").style.display="none";
    	$("select[name='reportSetType'] option[value='01']").remove();
    }
} 

/* function reportSetNameChecked(){
	var reportSetName = $("#reportSetName").val();
	var reg = /^[\u4E00-\u9FA5]{1,10}$/;
	if(reportSetName&&!reg.test(reportSetName)){
		alert("名称不能超过10个中文字符");
		$("#reportSetName").val("");
	}
} */

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