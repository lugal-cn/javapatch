<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>机器人信息表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,webuploader,bootstrap-form"></t:base><t:base type="tools"></t:base>
<!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbRoRobotsInfo.id}"/>
	<div class="form-group">
		<label for="robotsUrl" class="col-sm-3 control-label">机器人图片：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<t:webUploader name="robotsUrl" outJs="true" auto="true" showImgDiv="filediv_robotsUrl" type="image" buttonText='添加图片' displayTxt="false" pathValues="${tbRoRobotsInfo.robotsUrl}" datatype="*"></t:webUploader>
				<div class="form" id="filediv_robotsUrl"></div>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="robotsNo" class="col-sm-3 control-label">机器人编号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="robotsNo" name="robotsNo" value='${tbRoRobotsInfo.robotsNo}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入机器人编码"  datatype="*" ignore="checked" readonly="readonly"/>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="robotsName" class="col-sm-3 control-label">机器人名称：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="robotsName" name="robotsName" value='${tbRoRobotsInfo.robotsName}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入机器人名称"  datatype="*" ignore="checked" readonly="readonly" />
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="robotsModelId" class="col-sm-3 control-label">机器人型号：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<%-- <input id="robotsModelId" name="robotsModelId" value='${tbRoRobotsInfo.robotsModelId}' type="text" maxlength="32" class="form-control input-sm" placeholder="请输入机器人型号"  datatype="*"  ignore="checked" /> --%>
				<input type="text" id="robotsModelId" disabled="disabled" name="robotsModelId" class="ac_input" datatype="*" value='${tbRoRobotsInfo.robotsModelId}'  >
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="robotsIp" class="col-sm-3 control-label">机器人IP：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<input id="robotsIp" name="robotsIp" value='${tbRoRobotsInfo.robotsIp}' type="text" maxlength="100" class="form-control input-sm" placeholder="请输入机器人IP"  datatype="*"  ignore="checked" readonly="readonly"/>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="computerRoomId" class="col-sm-3 control-label">所属机房：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
               <%-- <t:dictSelect field="computerRoomId" type="list" extendJson="{class:'form-control input-sm'}"  datatype="*"  typeGroupCode=""  hasLabel="false"  title="所属机房" defaultVal="${tbRoRobotsInfo.computerRoomId}"></t:dictSelect> --%>
               <input type="text" id="computerRoomId"  disabled="disabled" name="computerRoomId" class="ac_input" datatype="*" value="${tbRoRobotsInfo.computerRoomId}">
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
				//表单提交之后调用接口
				//根据机器人的id拿机器人的ip
 				var datas={};
				 $.ajax({
						url:'tbRoRobotsInfoController.do?systemversionlist&robotsInfoId='+'${tbRoRobotsInfo.id}',
						type:'GET',
						dataType:'JSON',
						async:false, 
						delay: 250,
						cache: true,
						success: function(data){	
							datas=data[0];//robot_ip、backup_time
						}
					});	
				 var msg="";
				 var url="http://localhost:8080/itacs/jk/api/systemversion";
				 //调用接口  13.获取机器人版本信息 systemversion
				$.ajax({
				url : url,
				type : 'post',
				data : JSON.stringify(datas),
				cache : false,
				async: false,
				success : function(data) {
					if(data) {
						if (data.ErrorNo == '0') {
							msg ="获取机器人版本信息成功";
						} else if(data.ErrorNo == '-1') {
							msg = "获取机器人版本信息失败";
						} else if(data.ErrorNo == '1') {
							msg = "获取机器人版本信息执行中";
						} else {
							//其他
						}
					} else {
						var d = $.parseJSON(data);
						if (d.ErrorNo == '0') {
							msg = "获取机器人版本信息成功";
						} else if(d.ErrorNo == '-1') {
							msg ="获取机器人版本信息失败";
						} else if(d.ErrorNo == '1') {
							msg = "获取机器人版本信息执行中";
						} else {
							//其他
						}
					}
					}
				});
				frameElement.api.close();
			    win.reloadTable();
			    win.tip(data.msg+";"+msg);
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
			$("#robotsModelId").select2({
				data: select3Data,
				placeholder:'请选择型号',//默认文字提示
			    language: "zh-CN",//汉化
			    allowClear: true//允许清空
			});
		}
	});
	/*-------------------------------------------机器人型号----------------------------------------------*/
});
</script>
</body>
</html>