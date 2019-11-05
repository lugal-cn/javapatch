<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>访客登记</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
<!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
<!-- multiselect -->
<link rel="stylesheet" href="plug-in/ace/css/bootstrap-multiselect.css">
<script type="text/javascript" src="plug-in/ace/js/bootstrap-multiselect.js"></script>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbVrVisitorRegistrationController.do?doAdd" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<div class="form-group">
			<label for="visitorName" class="col-sm-3 control-label">访客姓名：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="visitorName" name="visitorName" type="text" maxlength="50" class="form-control input-sm" placeholder="请输入访客姓名"  datatype="*"  ignore="checked" />
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group">
			<label for="certNo" class="col-sm-3 control-label">身份证号：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="certNo" name="certNo" type="text" maxlength="50" class="form-control input-sm" placeholder="请输入身份证号"  datatype="cn" ignore="checked" />
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group">
			<label for="mobilephone" class="col-sm-3 control-label">手机：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="mobilephone" name="mobilephone" type="text" maxlength="50" class="form-control input-sm" placeholder="请输入手机" datatype="m" errormsg="手机号非法" />
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group">
			<label for="visitorTime" class="col-sm-3 control-label">来访时间：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="visitorTime" name="visitorTime" type="text" class="form-control input-sm" value='${tbVrVisitorRegistration.visitorTime}' readonly="readonly"/>
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group">
			<label for="computerRoomIds" class="col-sm-3 control-label">被访机房：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<select class="multiselect" multiple="multiple" id="computerRoomIds" name="computerRoomIds" >
					  	<c:if test="${fn:length(computerRooms)  > 0 }">
							<c:forEach items="${computerRooms}" var="cr" varStatus="stuts">
					  			<option value="${cr[0]}">${cr[1] }</option>
					  		</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="approver" class="col-sm-3 control-label">审批人：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input type="text" id="approver" name="approver" class="ac_input" datatype="*">
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group">
			<label for="visitorReasons" class="col-sm-3 control-label">来访事由：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<textarea id="visitorReasons" name="visitorReasons" class="form-control" placeholder="请输入来访事由" rows="4"></textarea>
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
	$('.multiselect').multiselect({
	      buttonClass: 'btn',
	      buttonWidth: 'auto',
	      buttonText: function(options) {
	        if (options.length == 0) {
	          return '请选择机房';
	        }
	        else {
	          var selected = '';
	          options.each(function() {
	            selected += $(this).text() + ',';
	          });
	          return selected.substr(0, selected.length -1) ;
	        }
	      },
	    });
	
	//单选框/多选框初始化
	$('.i-checks').iCheck({
		labelHover : false,
		cursor : true,
		checkboxClass : 'icheckbox_square-green',
		radioClass : 'iradio_square-green',
		increaseArea : '20%'
	});
		
	/*-------------------------------------------审批人----------------------------------------------*/
	var select2Data = new Array();
	$.ajax({
		url:'tbVrVisitorRegistrationController.do?queryApproverSelect',
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
			$("#approver").select2({
				data: select2Data,
				placeholder:'请选择审批人',//默认文字提示
			    language: "zh-CN",//汉化
			    allowClear: true//允许清空
			});
		}
	});
	/*-------------------------------------------审批人----------------------------------------------*/
		
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