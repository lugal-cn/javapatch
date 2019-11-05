<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tb_cr_equipment</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
<t:base type="bootstrap,layer,validform,webuploader,bootstrap-form,jquery,easyui,tools"></t:base><t:base type="tools"></t:base>
<style type="text/css">
    .main_div{
        margin: auto;
        text-align: center;

    }
    .pic_div{
        position: relative;
        background-color: pink;
        border: 1px dotted red;
        margin: 10px auto;
        width: 98%;
        height: 98%;
    }
    img{
        width: 100%;
        height: 100%;
    }

</style>
<!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
</head>
 <body style="overflow:hidden;overflow-y:auto;margin-top: 20px">
 <form id="formobj" action="tbCrEquipmentController.do?doAdd" class="form-horizontal validform" role="form"  method="post">
	<input type="hidden" id="btn_sub" class="btn_sub"/>
	<input type="hidden" id="id" name="id"/>
	<div class="form-group">
		<label for="equipmentNo" class="col-sm-3 control-label">设备编码：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<input id="equipmentNo" name="equipmentNo" value='${tbCrEquipmentPage.equipmentNo}' type="text" maxlength="100" validType="tb_cr_equipment,equipment_no,id" class="form-control input-sm" placeholder="请输入设备编码"  datatype="*"  ignore="checked" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="equipmentName" class="col-sm-3 control-label">设备名称：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<input id="equipmentName" name="equipmentName" value='${tbCrEquipmentPage.equipmentName}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入设备名称"  datatype="*"  ignore="checked" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="equipmentDesc" class="col-sm-3 control-label">设备描述：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<textarea id="equipmentDesc" name="equipmentDesc" class="form-control" placeholder="请输入设备描述" rows="4">${tbCrEquipmentPage.equipmentDesc}</textarea>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="equipmentStatus" class="col-sm-3 control-label">设备状态：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<t:dictSelect field="equipmentStatus" type="select" defaultVal="${tbCrEquipmentPage.equipmentStatus}" hasLabel="false"  title="设备状态" extendJson="{class:'form-control input-sm'}"  datatype="*"  typeGroupCode="itacs_equipment_status" ></t:dictSelect>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="equipmentType" class="col-sm-3 control-label">设备类型：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<input type="text" id="equipmentType" name="equipmentType" value='${tbCrEquipmentPage.equipmentType}'  datatype="*" class="ac_input"  onchange="equipmentTypeChange()">
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="equipmentModel" class="col-sm-3 control-label">设备型号：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<input id="equipmentModel" name="equipmentModel" type="text" value='${tbCrEquipmentPage.equipmentModel}'  datatype="*" class="ac_input" onchange="equipmentModelChange()"/>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="frontalRecognitionPoints" class="col-sm-3 control-label">正面识别点：</label>
		<div class="col-sm-6">
			<div id="zmsbd" class="input-group" style="width:100%">
				<t:dictSelect id="frontalRecognitionPoints"  field="frontalRecognitionPoints" defaultVal="${tbCrEquipmentPage.frontalRecognitionPoints}"  datatype="*" type="checkbox" extendJson="{class:'i-checks'}"  typeGroupCode="itacs_frontal_recognition_points"  hasLabel="false"  title="正面识别点"></t:dictSelect>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="backRecognitionPoints" class="col-sm-3 control-label">背面识别点：</label>
		<div class="col-sm-6">
			<div id="bmsbd" class="input-group" style="width:100%">
				<t:dictSelect id="backRecognitionPoints"  field="backRecognitionPoints" defaultVal="${tbCrEquipmentPage.backRecognitionPoints}" datatype="*" type="checkbox" extendJson="{class:'i-checks'}"  typeGroupCode="itacs_back_recognition_points"  hasLabel="false"  title="背面识别点"></t:dictSelect>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="equipmentIp" class="col-sm-3 control-label">设备IP：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<input id="equipmentIp" name="equipmentIp"   datatype="ip" validEquipmentIp="equipmentIp" type="text" value='${tbCrEquipmentPage.equipmentIp}' maxlength="100" class="form-control input-sm" placeholder="请输入设备IP"   onblur="isValidIP()"/>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="equipmentGrade" class="col-sm-3 control-label">设备等级：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<t:dictSelect field="equipmentGrade" type="select"  defaultVal="${tbCrEquipmentPage.equipmentGrade}" datatype="*" hasLabel="false" title="设备等级" extendJson="{class:'form-control input-sm'}"   typeGroupCode="itacs_equipment_grade" ></t:dictSelect>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="computerRoomId" class="col-sm-3 control-label">所属机房：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<input type="text" id="computerRoomId" name="computerRoomId"  value='${tbCrEquipmentPage.computerRoomId}' datatype="*" class="ac_input" onchange="computerRoomIdChange()">
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="cabineNo" class="col-sm-3 control-label">所属机柜：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<input type="text" id="cabineNo"  datatype="*" value='${tbCrEquipmentPage.cabineNo}' name="cabineNo" class="ac_input">
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="uBitStart" class="col-sm-3 control-label">U位信息起始位：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<input id="uBitStart" name="uBitStart" type="text" maxlength="2"  datatype="*" validUbit="uBitEnd" class="form-control input-sm" placeholder="请输入U位信息起始位" />
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="uBitEnd" class="col-sm-3 control-label">U位信息结束位：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				<input id="uBitEnd" name="uBitEnd" type="text"  maxlength="2"  datatype="*" validUbit="uBitStart" class="form-control input-sm" placeholder="请输入U位信息结束位"/>
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="deptId" class="col-sm-3 control-label">所属部门：</label>
		<div class="col-sm-6">
			<div class="input-group" style="width:100%">
				 <input type="text" id="deptId"  datatype="*" value='${tbCrEquipmentPage.deptId}' name="deptId" class="ac_input">
			</div>
		</div>
		<font style="color: red;">*</font>
	</div>
	<div class="form-group">
		<label for="positiveReferenceUrl" class="col-sm-3 control-label">正面基准照路径：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<t:webUploader name="positiveReferenceUrl" outJs="true" auto="true" showImgDiv="filediv_positiveReferenceUrl" type="image" buttonText='添加图片' displayTxt="false"></t:webUploader>
				<div class="form" id="filediv_positiveReferenceUrl"></div>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="backDatumUrl" class="col-sm-3 control-label">背面基准照路径：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
				<t:webUploader name="backDatumUrl" outJs="true" auto="true" showImgDiv="filediv_backDatumUrl" type="image" buttonText='添加图片' displayTxt="false"></t:webUploader>
				<div class="form" id="filediv_backDatumUrl"></div>
			</div>
		</div>
	</div>
	<div class="ui_buttons">
		<input type="button" id="id1" value="提交" onclick="saveObj()" class="ui_state_highlight ui_state_close">
		<input type="button" id="id2" value="关闭" onclick="closeObj()" class="ui_state_close">
	</div>
</form>
<script type="text/javascript">
	var frontalRecognitionPoints = '${tbCrEquipmentPage.frontalRecognitionPoints}';
	var backRecognitionPoints = '${tbCrEquipmentPage.backRecognitionPoints}';
	equipmentModelChange();
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
		/* $("#formobj").Validform({
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
		}); */
		/*-------------------------------------------设备类型----------------------------------------------*/
		var select2Data = new Array();
		$.ajax({
			url:'tbCrEquipmentController.do?equipmentTypeSelect',
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
				$("#equipmentType").select2({
					data: select2Data,
					placeholder:'请选择设备类型',//默认文字提示
				    language: "zh-CN",//汉化
				    allowClear: true//允许清空
				});
			}
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
		computerRoomIdChange();
		equipmentTypeChange();
		
		/*-------------------------------------------所属部门----------------------------------------------*/
		var select5Data = new Array();
		$.ajax({
			url:'tbCrEquipmentController.do?deptIdSelect',
			type:'GET',
			dataType:'JSON',
			delay: 250,
			cache: true,
			success: function(data){
				for(var i = 0; i < data.length; i++){
					var select2Obj = {};
					select2Obj.id = data[i][0];
					select2Obj.text = data[i][1];
					select5Data.push(select2Obj);
				}
				$("#deptId").select2({
					data: select5Data,
					placeholder:'请选择所属部门',//默认文字提示
				    language: "zh-CN",//汉化
				    allowClear: true//允许清空
				});
			}
		});
	});
	//通过机房查询机柜 ftf
	function computerRoomIdChange(){
		var computerRoomId = $("#computerRoomId").val();
		var select3Data = new Array();
		$.ajax({
			url:'tbCrEquipmentController.do?cabineNoSelect&computerRoomId='+computerRoomId,
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
				$("#cabineNo").select2({
					data: select3Data,
					placeholder:'请选择机柜',//默认文字提示
				    language: "zh-CN",//汉化
				    allowClear: true//允许清空
				});
			}
		});
	}
	//通过设备类型查询设备型号 ftf
	function equipmentTypeChange(){
		var equipmentType = $("#equipmentType").val();
		var select3Data = new Array();
		$.ajax({
			url:'tbCrEquipmentController.do?equipmentModelSelect&equipmentType='+equipmentType,
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
				$("#equipmentModel").select2({
					data: select3Data,
					placeholder:'请选择设备型号',//默认文字提示
				    language: "zh-CN",//汉化
				    allowClear: true//允许清空
				});
			}
		});
	}
	
	//通过设备型号查询正面反面识别点 ftf
	function equipmentModelChange(){
		var equipmentModel = $("#equipmentModel").val();
		var equipmentType = $("#equipmentType").val();
		if(!equipmentType){
			alert("设备类型不能为空！");
			return;
		}
		/* $.ajax({
	        cache: true,
	        type: "GET",
	        url:"tbCrEquipmentController.do?recognitionPointsSelect&equipmentModel="+equipmentModel,
	        dataType:"JSON",
	        cache: true,
	        error: function(datas) {
	        },
	        success: function(datas) {
	        	var htmFrontal = "";
	        	var htmBack= "";
	            //正面识别点编码
	        	var frontal =  datas.frontal;
	        	//正面识别点名称
	        	var frontalName =  datas.frontalName;
	        	//反面识别点编码
	        	var back =  datas.back;
	        	//反面识别点名称
	        	var backName =  datas.backName;
	        	for(var i=0;i<frontal.split(",").length;i++){
        			if(datas.msg.indexOf(frontal.split(",")[i])!=-1){
        				htmFrontal +='<input checked="checked" type="checkbox" name="frontalRecognitionPoints" value="'+frontal.split(",")[i]+'" id="frontalRecognitionPoints"  class="i-checks" />'+frontalName.split(",")[i]+'&nbsp;&nbsp;';
        			}else{
        				htmFrontal +='<input type="checkbox" name="frontalRecognitionPoints" value="'+frontal.split(",")[i]+'" id="frontalRecognitionPoints"  class="i-checks" />'+frontalName.split(",")[i]+'&nbsp;&nbsp;';
        			}
	        		
	        	}
	        	$("#zmsbd").html(htmFrontal);
	        	for(var i=0;i<frontal.split(",").length;i++){
	        		if(datas.msg1.indexOf(frontal.split(",")[i])!=-1){
	        			htmBack +='<input checked="checked" type="checkbox"  name="backRecognitionPoints" value="'+back.split(",")[i]+'" id="backRecognitionPoints"  class="i-checks" />'+backName.split(",")[i]+'&nbsp;&nbsp;';
	        		}else{
	        			htmBack +='<input type="checkbox" name="backRecognitionPoints" value="'+back.split(",")[i]+'" id="backRecognitionPoints"  class="i-checks" />'+backName.split(",")[i]+'&nbsp;&nbsp;';
	        		}
	        	}
	        	$("#bmsbd").html(htmBack)
	        }
	    });  */
		$.ajax({
	        cache: true,
	        type: "GET",
	        url:"tbCrEquipmentController.do?recognitionPointsSelect&equipmentModel="+equipmentModel,
	        dataType:"JSON",
	        cache: true,
	        error: function(datas) {
	        },
	        success: function(datas) {
	        	var htmFrontal = "";
	        	var htmBack= "";
	        	if(datas) {
	        		var mapBack = datas.mapBack;
		        	var mapFrontal = datas.mapFrontal;
		        	if(mapBack) {
		        	/* 	for(var j = 0; j < mapBack.length; j++) {
		        			if(backRecognitionPoints.indexOf(mapBack[j].pointsNo) != -1) {
				        		htmFrontal +='<input checked="checked" type="checkbox" name="backRecognitionPoints" value="'+mapBack[j].pointsNo+'" id="frontalRecognitionPoints"  class="i-checks" />'+mapBack[j].pointsName+'&nbsp;&nbsp;';
		        			} else {
		        				htmFrontal +='<input type="checkbox" name="backRecognitionPoints" value="'+mapBack[j].pointsNo+'" id="frontalRecognitionPoints"  class="i-checks" />'+mapBack[j].pointsName+'&nbsp;&nbsp;';
		        			}
			        	} */
			        	for(var j = 0; j < mapBack.length; j++) {
		        			htmBack+='<input checked="checked" type="checkbox" name="backRecognitionPoints" value="'+mapBack[j].pointsNo+'" id="frontalRecognitionPoints"  class="i-checks" />'+mapBack[j].pointsName+'&nbsp;&nbsp;';
			        	}
		        	}
					if(mapFrontal) {
						/* for(var j = 0; j < mapFrontal.length; j++) {
							if(frontalRecognitionPoints.indexOf(mapFrontal[j].pointsNo) != -1) {
								htmBack +='<input checked="checked" type="checkbox" name="frontalRecognitionPoints" value="'+mapFrontal[j].pointsNo+'" id="frontalRecognitionPoints"  class="i-checks" />'+mapFrontal[j].pointsName+'&nbsp;&nbsp;';
		        			} else {
		        				htmBack +='<input type="checkbox" name="frontalRecognitionPoints" value="'+mapFrontal[j].pointsNo+'" id="frontalRecognitionPoints"  class="i-checks" />'+mapFrontal[j].pointsName+'&nbsp;&nbsp;';
		        			}
							
			        	} */
			        	for(var j = 0; j < mapFrontal.length; j++) {
							htmFrontal+='<input checked="checked" type="checkbox" name="frontalRecognitionPoints" value="'+mapFrontal[j].pointsNo+'" id="frontalRecognitionPoints"  class="i-checks" />'+mapFrontal[j].pointsName+'&nbsp;&nbsp;';
			        	}
		        	}
	        	}
	            //正面识别点编码
	        	//var frontal =  datas.frontal;
	        	//正面识别点名称
	        	//var frontalName =  datas.frontalName;
	        	//反面识别点编码
	        	//var back =  datas.back;
	        	//反面识别点名称
	        	//var backName =  datas.backName;
	        	//htmFrontal +='<input checked="checked" type="checkbox" style="display:none" name="frontalRecognitionPoints" value="'+datas.msg+'" id="frontalRecognitionPoints"  class="i-checks" />'+datas.msg+'&nbsp;&nbsp;';
	        	/* for(var i=0;i<frontal.split(",").length;i++){
        			if(datas.msg.indexOf(frontal.split(",")[i])!=-1){
        				htmFrontal +='<input checked="checked" type="checkbox" name="frontalRecognitionPoints" value="'+frontal.split(",")[i]+'" id="frontalRecognitionPoints"  class="i-checks" />'+frontalName.split(",")[i]+'&nbsp;&nbsp;';
        				
        				htmFrontal +='<input checked="checked" type="checkbox" name="frontalRecognitionPoints" value="'+frontal.split(",")[i]+'" id="frontalRecognitionPoints"  class="i-checks" />'+frontalName.split(",")[i]+'&nbsp;&nbsp;';
        			}else{
        				htmFrontal +='<input type="checkbox" name="frontalRecognitionPoints" value="'+frontal.split(",")[i]+'" id="frontalRecognitionPoints"  class="i-checks" />'+frontalName.split(",")[i]+'&nbsp;&nbsp;';
        			}
	        		
	        	} */
	        	
	        	//htmBack +='<input checked="checked" type="checkbox" name="backRecognitionPoints" style="display:none" value="'+datas.msg1+'" id="backRecognitionPoints"  class="i-checks" />'+datas.msg1+'&nbsp;&nbsp;';
	        /* 	for(var i=0;i<frontal.split(",").length;i++){
	        		if(datas.msg1.indexOf(frontal.split(",")[i])!=-1){
	        			htmBack +='<input checked="checked" type="checkbox"  name="backRecognitionPoints" value="'+back.split(",")[i]+'" id="backRecognitionPoints"  class="i-checks" />'+backName.split(",")[i]+'&nbsp;&nbsp;';
	        		}else{
	        			htmBack +='<input type="checkbox" name="backRecognitionPoints" value="'+back.split(",")[i]+'" id="backRecognitionPoints"  class="i-checks" />'+backName.split(",")[i]+'&nbsp;&nbsp;';
	        		}
	        	} */
	        	$("#zmsbd").html(htmFrontal); 
	        	$("#bmsbd").html(htmBack);
	        }
	    }); 
		
	}
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