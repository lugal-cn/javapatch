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
	<form class="form-horizontal" role="form" id="formobj" action="tbRsReportSetController.do?doAdd" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<div class="form-group">
			<label for="reportSetName" class="col-sm-3 control-label">报表名称：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="reportSetName" name="reportSetName" type="text" maxlength="200" validType="tb_rs_report_set,report_set_name,id" class="form-control input-sm" placeholder="请输入报表名称"  datatype="*"  ignore="checked" onblur="reportSetNameChecked()"/>
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group">
			<label for="reportSetStatus" class="col-sm-3 control-label">报表状态：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<t:dictSelect field="reportSetStatus" type="list" extendJson="{class:'form-control input-sm'}"  datatype="*"   typeGroupCode="itacs_report_set_status"  hasLabel="false"  title="报表状态"></t:dictSelect>     
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group">
			<label for="computerRoomId" class="col-sm-3 control-label">机房选择：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="computerRoomId" name="computerRoomId" class="ac_input" type="text" maxlength="32" class="form-control input-sm" placeholder="请输入机房"  datatype="*"  ignore="checked" />
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group">
			<label for="reportSetStyle" class="col-sm-3 control-label">报表样式：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<t:dictSelect field="reportSetStyle" type="list"  extendJson="{class:'form-control input-sm',onchange:'isInter(this)'}"  datatype="*"   typeGroupCode="itacs_report_set_style"  hasLabel="false"  title="报表样式"></t:dictSelect>     
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group" id="leixing1" style="display:">
			<label for="reportSetType" class="col-sm-3 control-label">选择类型：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<t:dictSelect field="reportSetType1"  type="list" id="reportSetType1" extendJson="{class:'form-control input-sm',onchange:'isInter1(cthis)'}"   typeGroupCode="itacs_report_set_type"  hasLabel="false"  title="选择类型"></t:dictSelect>     
				</div>
			</div>
		</div>
		<div class="form-group" id="leixing2" style="display:none">
			<label for="reportSetType" class="col-sm-3 control-label">选择类型：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<t:dictSelect field="reportSetType2"  readonly="readonly" defaultVal="01" type="list" id="reportSetType2" extendJson="{class:'form-control input-sm',onchange:'isInter1(cthis)'}"   typeGroupCode="itacs_report_set_type"  hasLabel="false"  title="选择类型"></t:dictSelect>     
				</div>
			</div>
		</div>
		<div class="form-group"  id="leixing3" style="display:none">
			<label for="reportSetType" class="col-sm-3 control-label">选择类型：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<t:dictSelect field="reportSetType" type="list" id="reportSetType" extendJson="{class:'form-control input-sm',onchange:'isInter1(cthis)'}"   typeGroupCode="itacs_report_set_type"  hasLabel="false"  title="选择类型"></t:dictSelect>     
				</div>
			</div>
		</div>
	</form>
	<div class="ui_buttons">
	<input type="button" value="提交" onclick="saveObj()" class="ui_state_highlight ui_state_close">
	<input type="button" value="关闭" onclick="closeObj()" class="ui_state_close"></div>
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


/* document.getElementById("typediv1").style.display=""; */
function isInter(cthis){
    var isInter = cthis.value;
    if (isInter==01) {
    	document.getElementById("leixing1").style.display="none";
    	document.getElementById("leixing2").style.display="";
    	document.getElementById("leixing3").style.display="none";	
    }if (isInter==02) {
    	document.getElementById("leixing1").style.display="none";
    	document.getElementById("leixing2").style.display="none";
    	document.getElementById("leixing3").style.display="";
    	$("select[name='reportSetType'] option[value='01']").remove();
    }
} 

 /* function isInter(cthis){
    var isInter = cthis.value;
     alert(isInter);
    if (isInter==01) {
    	$("#reportSetType").attr("disabled","disabled");
    	 document.getElementById("reportSetType")[1].selected=true; 
    }if (isInter==02) {
    	$("select[name='reportSetType'] option[value='01']").remove();
    	
    }
}  */

/* function isInter1(cthis){
    var isInter1 = cthis.value;
    alert(isInter1);
    if (isInter1==01) {
    	$("select[name='reportSetStyle'] option[value='02']").remove();
    }if (isInter1==02||isInter1==03) {
    	$("select[name='reportSetStyle'] option[value='01']").remove();
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
/* function reportSetNameChecked(){
	var reportSetName = $("#reportSetName").val();
	var reg = /^[\u4E00-\u9FA5]{1,10}$/;
	if(reportSetName&&!reg.test(reportSetName)){
		alert("名称不能超过10个中文字符");
		$("#reportSetName").val("");
	}
} */
</script>
</body>
</html>