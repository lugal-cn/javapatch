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
<t:base type="bootstrap,layer,validform,webuploader,bootstrap-form"></t:base><t:base type="tools"></t:base><t:base type="tools"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbCrComputerRoomController.do?doAdd" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<input type="hidden" id="mapUrl1" name="mapUrl1"/>
		<div class="form-group">
			<label for="computerRoomName" class="col-sm-3 control-label">机房名称：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="computerRoomName" name="computerRoomName" type="text"  validType="tb_cr_computer_room,computer_room_name,id" maxlength="200" class="form-control input-sm" placeholder="请输入机房名称"  datatype="*"  ignore="checked" />
				</div>
			</div>
			<font style="color: red;">*</font>
		</div>
		<div class="form-group">
			<label for="mapUrl" class="col-sm-3 control-label">地图存储路径：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
				<t:webUploader name="mapUrl" outJs="true" auto="true" showImgDiv="filediv_mapUrl" fileNumLimit="1" type="image" buttonText='添加地图' displayTxt="false" datatype="*"></t:webUploader>
				<div class="form" id="filediv_mapUrl"></div>
				<span id="tpfd">
					<input type="button" value="图片放大" onclick="tpfd()">
				</span>
				</div>
			</div>
			<font style="color: red;">*</font>
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
	$('#tpfd').hide();
});
/* //正则限制机房名称的输入格式
computerRoomName.onkeyup=function(){
	var re=/^[\u4E00-\u9FA5A-Za-z0-9]+$/;//只允许输入中文，英文和数字
	if(!re.test(this.value)){
	alert("请勿输入特殊字符");
	this.value=this.value.substr(0,this.value.length-1);//将最后输入的字符去除
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
	function tpfd(){
		var mapUrl1 = $("#mapUrl1").val();
		openwindow("查看","tbCrComputerRoomController.do?viewPic&mapUrl1="+mapUrl1,'',800,400);
	}
</script>
</body>
</html>