<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>机柜管理</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,webuploader,bootstrap-form,jquery,easyui,tools"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
<!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbCrCabineController.do?doUpdate" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbCrCabine.id}"/>
	<div class="form-group">
		<label for="computerRoomId" class="col-sm-3 control-label">所属机房：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
               <input type="text" id="computerRoomId" name="computerRoomId" class="ac_input" datatype="*" value="${tbCrCabine.computerRoomId}">
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="cabineNo" class="col-sm-3 control-label">机柜编号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="cabineNo" name="cabineNo" value='${tbCrCabine.cabineNo}' type="text" maxlength="200" class="form-control input-sm" validCabineNo="cabineNo" placeholder="请输入机柜编号"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="cabineType" class="col-sm-3 control-label">机柜类型：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
<%-- 							<t:dictSelect field="cabineType" type="select" defaultVal="${tbCrCabine.cabineType}" hasLabel="false"  title="机柜类型" extendJson="{class:'form-control input-sm'}"  datatype="*"  typeGroupCode="itacs_cabinetType" ></t:dictSelect>
 --%>				<input id="cabineType" name="cabineType" value='${tbCrCabine.cabineType}' dictionary="itacs_cabinetType" type="text" maxlength="2" class="ac_input"  placeholder="请输入机柜类型"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="borderSize" class="col-sm-3 control-label">边框尺寸：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="borderSize" name="borderSize" value='${tbCrCabine.borderSize}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入边框尺寸"  datatype="*"  ignore="checked" />
			</div>
		</div>
	</div>
					<div class="form-group">
					<label for="cabineDesc" class="col-sm-3 control-label">描述：</label>
					<div class="col-sm-7">
					<div class="input-group" style="width:100%">
						  	 	<textarea name="cabineDesc" class="form-control input-sm" rows="6"  ignore="ignore" >${tbCrCabine.cabineDesc}</textarea>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">描述</label>
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
});
/*-------------------------------------------所属机房----------------------------------------------*/
var select2Data = new Array();
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
			select2Data.push(select2Obj);
		}
		$("#computerRoomId").select2({
			data: select2Data,
			placeholder:'请选择机房',//默认文字提示
		    language: "zh-CN",//汉化
		    allowClear: true//允许清空
		});
	}
});
/*-------------------------------------------所属机房----------------------------------------------*/

/*-------------------------------------------机柜类型----------------------------------------------*/
		var select3Data = new Array();
		$.ajax({
			url:'tbCrCabineController.do?cabineTypeSelect',
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
				$("#cabineType").select2({
					data: select3Data,
					placeholder:'请选择机柜类型',//默认文字提示
				    language: "zh-CN",//汉化
				    allowClear: true//允许清空
				});
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
</script>
</body>
</html>