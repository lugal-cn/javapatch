<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>机器人固件表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
<!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
<style>
	/*下拉框样式开始*/
	.selectBox{
		width: 400px;
		height: 28px;
		line-height: 36px;
	}
	input::-ms-clear, input::-ms-reveal{
		/*clear去掉叉  reveal去掉眼睛;但是只能去掉ie10及以上，ie9及以下去不掉*/
	    display: none;  
	}
	
	.inputCase{
		position: relative;
		width: 100%;
		height: 100%;
		box-sizing: border-box;
	}
	.inputCase input.imitationSelect{
		width: 100%;
		height: 100%;
		box-sizing: border-box;
		border: 1px solid #ccc;
		display: block;
		text-indent: 20px;
		cursor: default;
	}
	.inputCase i.fa{
		position: absolute;
		right: 10px;
		top: 5px;
		font-size: 20px;
		z-index: 99999;
	}
	.inputCase .fa{
		cursor: pointer;
	}
	.inputCase .fa {
	    display: inline-block;
	    font: normal normal normal 14px/1 FontAwesome;
	    font-size: inherit;
	    text-rendering: auto;
	    -webkit-font-smoothing: antialiased;
	    -moz-osx-font-smoothing: grayscale;
	}
	.fa-caret-down:before {
	    content: "\f0d7";
	}
	.fa-caret-up:before {
	    content: "\f0d8";
	}
	.selectUl{
		display: none;
		padding: 0;
		margin: 0;
		border-bottom: 1px solid  #ccc;
		border-left: 1px solid  #ccc;
		border-right: 1px solid  #ccc;
	    max-height: 222px;
		overflow: auto;
		list-style-type: disc;
	    position: relative;
	    z-index: 10000;
	    background: white;
	}
	.selectUl::-webkit-scrollbar {
	    width: 10px;
	    height: 10px;
	    background-color: #F5F5F5;
	}
	.selectUl::-webkit-scrollbar-thumb {
	    background: #555;
	}
	.selectUl::-webkit-scrollbar-track {
	    background: #F5F5F5;
	}
	.selectUl li{
		height: 36px;
		line-height: 36px;
		list-style: none;
		text-indent: 20px;
		border-bottom: 1px dashed #ccc;
	}
	.selectUl li:hover{
		background: #ddd;
	}
	.selectUl li:last-child{
		border-bottom: 0 none;
	}
	/*下拉框样式结束*/
	/*文件框样式开始*/
	.form-label {
	    position: relative;
	    float: left;
	    display: block;
	    padding: 5px;
	    width: 120px;
	    font-weight: 400;
	    line-height: 20px;
	    text-align: right;
	    color: #666;
	}
	.textbox {
	    position: relative;
	    border: 1px solid #D3D3D3;
	    background-color: #fff;
	    vertical-align: middle;
	    display: inline-block;
	    overflow: hidden;
	    white-space: nowrap;
	    margin: 0;
	    padding: 0;
	    -moz-border-radius: 2px;
	    -webkit-border-radius: 2px;
	    border-radius: 2px;
	}
	.textbox .textbox-text {
	    border: 0;
	    margin: 0;
	    padding: 4px;
	    white-space: normal;
	    vertical-align: top;
	    outline-style: none;
	    resize: none;
	    -moz-border-radius: 2px;
	    -webkit-border-radius: 2px;
	    border-radius: 2px;
	}
	
	.textbox .textbox-button-right{
		position: absolute;
	    top: 0;
	    padding: 0;
	    vertical-align: top;
	    -moz-border-radius: 0;
	    -webkit-border-radius: 0;
	    border-radius: 0;
	    right: 0;
	    border-width: 0 0 0 1px;
	}
	.fa-folder:before {
	    content: "\f07b";
	}
	.l-btn {
	    margin: 0;
	  		overflow: hidden;
		cursor: pointer;
	    outline: 0;
	    text-align: center;
	    vertical-align: middle;
	    line-height: normal;
	    color: #444;
	    border: 1px solid #bbb;
	    background: -webkit-linear-gradient(top,#fff 0,#eee 100%);
	    background: -moz-linear-gradient(top,#fff 0,#eee 100%);
	    background: -o-linear-gradient(top,#fff 0,#eee 100%);
	    background: linear-gradient(to bottom,#fff 0,#eee 100%);
	    background-repeat: repeat-x;
	    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#ffffff, endColorstr=#eeeeee, GradientType=0);
	    /* -moz-border-radius: 2px;
	    -webkit-border-radius: 2px;
	    border-radius: 2px; */
	    padding: 0;
	}
	.l-btn-left {
		color: #444;
		position: relative;
	    margin: 0;
	    margin-top: 2px !important;
	    padding: 0;
	    vertical-align: top;
	    display: inline-block;
	    overflow: hidden;
	}
	.filebox-label {
	    width: 100%;
	    height: 100%;
	    cursor: pointer;
	    left: 0;
	    z-index: 10;
	}
	.filebox-label{
	    display: inline-block;
	       top: 0;
	    position: absolute;
	}
	.filebox .textbox-value {
	    vertical-align: top;
	    left: -5000px;
	}
	.filebox .textbox-value{
	    top: 0;
	    position: absolute;
	}
	
	.button, a.l-btn span.l-btn-left {
	    height: 24px;
	    cursor: pointer;
	    line-height: 20px;
	    display: inline-block;
	    color: rgb(68, 68, 68);
	    white-space: nowrap;
	    border-width: 0px;
	    border-left: 1px;
	    border-color: rgb(204, 204, 204);
	    border-image: initial;
	    border-radius: 0px;
	    background: -webkit-gradient(linear, 0 0, 0 100%, from(rgb(255, 255, 255)), to(rgb(242, 242, 242)));
	    padding: 3px 3px;
	}
	
	.button:hover, a.l-btn:hover span.l-btn-left {
	    border: 0px solid #76B4AC;
	    border-radius: 0px;
	    border-left: 1px;
	    background-color: #f7f5f5;
	    background: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff),
	 to(#f2f2f2));
	    background: -moz-gradient(linear, 0 0, 0 100%, from(#f7f7f7),
	 to(#f2f2f2));
	    background: -o-gradient(linear, 0 0, 0 100%, from(#e9e9e9), to(#f2f2f2));
	    background: -ms-gradient(linear, 0 0, 0 100%, from(#e9e9e9), to(#f2f2f2));
	    filter: progid:DXImageTransform.Microsoft.gradient(startcolorstr=#f7f7f7,
	 endcolorstr=#f2f2f2, gradientType=0);
	    color: #007465;
	    cursor: pointer;
	}
	/*文件框样式结束*/
</style>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbRoRobotsFirmwareController.do?doAdd" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<div class="form-group">
			<label for="robotsType" class="col-sm-3 control-label">机器人型号：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input type="text" id="robotsType" name="robotsType" class="ac_input" datatype="*">
					<input type="hidden" id="robotsInfoId" name="robotsInfoId" class="ac_input"  value="${robotsInfoId }">
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="firmwareVersion" class="col-sm-3 control-label">固件包版本号：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="firmwareVersion" name="firmwareVersion" type="text" maxlength="10" class="form-control input-sm" placeholder="请输入固件包版本号"  datatype="*"/>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="firmwareFileUrl" class="col-sm-3 control-label">固件文件：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					 <t:webUploader name="firmwareFileUrl" fileSingleSizeLimit="1048576000" buttonStyle="btn-green btn-M mb20" fileNumLimit="1" auto="true" datatype="*"></t:webUploader>
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
	
	/*-------------------------------------------机器人型号----------------------------------------------*/
	var select3Data = new Array();
	$.ajax({
		url:'tbRoRobotsInfoController.do?robotsModelSelect',
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
			$("#robotsType").select2({
				data: select3Data,
				placeholder:'请选择型号',//默认文字提示
			    language: "zh-CN",//汉化
			    allowClear: true//允许清空
			});
		}
	});
	/*-------------------------------------------机器人型号----------------------------------------------*/
	
	$("#filebox_file_id_1").change(function(){
   		var vl = $("#filebox_file_id_1").val();
   		var valArr = vl.split("\\");
   		$("#_easyui_textbox_input1").val(valArr[valArr.length-1]);
   	});
});
</script>
</body>
</html>