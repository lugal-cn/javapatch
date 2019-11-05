<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>语音播报</title>
<t:base type="jquery,easyui,tools"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
<style type="text/css">
    .main_div{
        margin: auto;
        text-align: center;

    }
    .pic_div{
        position: relative;
        background-color: white;
        border: 0px dotted red;
        margin: 10px auto;
        width: 98%;
        height: 98%;
    }
    img{
        width: 100%;
        height: auto;
    }

</style>
<!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
	$(".tabs-wrap").css('width','100%');
});
</script>
</head>
<div class="easyui-layout" fit="true" style="width:1000px;height:600px;">
    <div region="west" split="true" title="" style="width:500px;overflow:hidden;">
        <%-- <t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" action="tbVoVoiceTemplateController.do?doupdate"> --%>
        <t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" action="tbVoVoiceTemplateController.do?doUpdate" callback="saveObjcallback">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="voiceTemplateStatus" name="voiceTemplateStatus" class="btn_sub" value='${tbVoVoiceTemplate.voiceTemplateStatus}'/>
		<input type="hidden" id="id" name="id" value='${tbVoVoiceTemplate.id}'/>
		<div class="form-group"> 
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<tr>
						<td>模板名称：</td>
						<td>
							<input id="voiceTemplateName" name="voiceTemplateName" value='${tbVoVoiceTemplate.voiceTemplateName}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入模板名称"  datatype="*"  ignore="checked" />
						</td>
						<font style="color: red;">*</font>
					</tr>
					
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<tr >
						<td>所属机器人：</td>
						<td>
							<input type="text" id="robotsInfoId" name="robotsInfoId"  datatype="*" value='${tbVoVoiceTemplate.robotsInfoId}' disabled="disabled" onchange="queryRobotsInfoId(this)">
						</td>
					</tr>
				</div>
			</div>
		</div>
		 <div style="width: auto;">
				<div style="width:600px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false" >
				 <t:tab href="tbVoVoiceTemplateController.do?robotsPointsListupdate&id=${tbVoVoiceTemplate.id}&robotsInfo=${tbVoVoiceTemplate.robotsInfoId}" icon="icon-search" title="巡检点列表" id="tbPaPtrolPlan"></t:tab>
				</t:tabs>
		</div> 
		<div class="ui_buttons">
		<input type="button" id="id1" value="提交" onclick="saveObj()" class="ui_state_highlight ui_state_close">
		<input type="button" id="id2" value="关闭" onclick="closeObj()" class="ui_state_close">
	</div>
	</t:formvalid>
		<!-- 添加 附表明细 模版 -->
	<table style="display:none">
	<tbody id="add_jformGraphreportItem_table_template">
		<tr>
			<!-- <td align="center"><div style="width: 22px;" name="xh"></div></td>  -->
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td> 
				    <td align="left">
					  <input type="hidden" id="TbVoVoiceTemplatePointsEntity[#index#].patrolPointsNo" name="TbVoVoiceTemplatePointsEntity[#index#].patrolPointsNo">
					  <select  name="patrolPointsNos" id="TbVoVoiceTemplatePointsEntity[#index#].patrolPointsNos" onchange="chengepatrolTaskId(this)" dataype="*"></select> 
 					  <font style="color: red;">*</font>
 					  <label class="Validform_label" style="display: none;">巡检点</label>
				  </td>
				  <td align="left">
				  		<input type="hidden" id="TbVoVoiceTemplatePointsEntity[#index#].patrolPointsText" name="TbVoVoiceTemplatePointsEntity[#index#].patrolPointsText">
				  	   <textarea id="TbVoVoiceTemplatePointsEntity[#index#].patrolPointsText" name="TbVoVoiceTemplatePointsEntity[#index#].patrolPointsTexts" maxlength="1500" rows="3" cols="3" style="width:230px" datatype="*" onchange="changePointsText(this)"></textarea>	
					  <font style="color: red;">*</font>
					  <label class="Validform_label" style="display: none;">文本编辑</label>
				  </td>
			</tr>
		 </tbody>
	</table> 
    </div>
    <div region="center" title="" style="width:500px;" id="sitePanel" class="easyui-panel">
    	<div id="dv2" class="pic_div" style="height: 94%; z-index: 1;" >
            <img id="SmallLiuYiFeiImg" src="" class="pic">
        </div>
    </div>
</div>
<script type="text/javascript">
/*-------------------------------------------所属机器人----------------------------------------------*/
var select2Data = new Array();
$.ajax({
	url:'tbPaPatrolTaskController.do?robotsInfoSelect',
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
		$("#robotsInfoId").select2({
			data: select2Data,
			placeholder:'请选择所属机器人',//默认文字提示
		    language: "zh-CN",//汉化
		    allowClear: true//允许清空
		});
		 $('#robotsInfoId').val(['${robotsInfo.robotsInfoId}']).trigger('change');
	}
});
/*-------------------------------------------所属机器人----------------------------------------------*/
 
//根据机器人查询机器人下面的巡检点
function queryRobotsInfoId(obj){
	var robotsInfoId=obj.value;
	//根据机器人id查询机房图片
		$.ajax({
		url:'tbVoVoiceTemplateController.do?getPictureByRobotsId&robotsInfoId='+robotsInfoId,
		type:'GET',
		dataType:'JSON',
		delay: 250,
		cache: true,
		success: function(data){
				if(data){
					$('#SmallLiuYiFeiImg').attr('src',data.mapUrl);
				}else{
					$('#SmallLiuYiFeiImg').attr('src',"");
				}
				
			}
		});
	
	if(robotsInfoId==='${robotsInfo.robotsInfoId}'){
		//给巡检点定点
		$.ajax({
		url:'tbVoVoiceTemplateController.do?getRobotsInfoXYById&robotsInfoId='+'${tbVoVoiceTemplate.robotsInfoId}'+'&id='+'${tbVoVoiceTemplate.id}',
		type:'GET',
		dataType:'JSON',
		async:false,
		delay: 250,
		cache: true,
		success: function(data){
				var patrolPointNo;
		 		var x;
		 		var y;
				for(var i = 0; i < data.length; i++){
					patrolPointNo = data[i].patrolPointNo;
			 		x = data[i].xCoordinate;
			 		y = data[i].yCoordinate;
			 		//删除div 重新加载机器人图标
			 		var idObject = document.getElementById('div'+patrolPointNo);
			 	    if (idObject != null) {
			 	          idObject.parentNode.removeChild(idObject);
			 	    }
			 		var div = document.createElement('div');
					div.id = 'div'+patrolPointNo;
					div.style.position = 'absolute';
			        div.style.left = x + 'px';
					div.style.top = y + 'px';
					div.style.zIndex = 2;
					div.style.width = '30px';
					div.style.height = '30px';
					div.style.background = 'url(<%=request.getContextPath() %>/images/u6079.png)';
					document.getElementById('sitePanel').appendChild(div);
				}
			}
		});
		var tab = $('#tt').tabs('getSelected');
		$('#tt').tabs('update',{
			tab: tab,
			options: {
				title: '巡检点列表',
				href: "tbVoVoiceTemplateController.do?robotsPointsListupdate&id=${tbVoVoiceTemplate.id}&robotsInfo="+robotsInfoId  // the new content URL
			}
		});
	}else{
		//给巡检点定点
				$.ajax({
				url:'tbVoVoiceTemplateController.do?getRobotsInfoXYById&robotsInfoId='+'${tbVoVoiceTemplate.robotsInfoId}'+'&id='+'${tbVoVoiceTemplate.id}',
				type:'GET',
				dataType:'JSON',
				async:false,
				delay: 250,
				cache: true,
				success: function(data){
						var patrolPointNo;
				 		var x;
				 		var y;
						for(var i = 0; i < data.length; i++){
							/* alert(data.length); */
							patrolPointNo = data[i].patrolPointNo;
					 		x = data[i].xCoordinate;
					 		y = data[i].yCoordinate;
					 		//删除div 重新加载机器人图标
					 		var idObject = document.getElementById('div'+patrolPointNo);
					 	    if (idObject != null) {
					 	          idObject.parentNode.removeChild(idObject);
					 	    }
						}
					}
				});
		var tab = $('#tt').tabs('getSelected');
		$('#tt').tabs('update',{
			tab: tab,
			options: {
				title: '巡检点列表',
				href: "tbVoVoiceTemplateController.do?robotsPointsListupdate&robotsInfo="+robotsInfoId  // the new content URL
			}
		});
	}
	
}
//辨别是查看还是编辑页面
var openType = '${openType}';
if(openType && openType == 1) {
	$("#id1").hide();
} else {
	$("#id1").show();
}
/**  执行保存 */
function saveObj() {
	$("#formobj").submit();
}
var framename = '${framename}';
function saveObjcallback(data) {
	alert(data.msg);
	/* alert(framename); */
	window.parent.frames[framename].reloadTable();
	closeObj();
	var my = window.parent.document.getElementById("ldg_lockmask");
    if (my != null) {
        my.parentNode.removeChild(my);
    }
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
