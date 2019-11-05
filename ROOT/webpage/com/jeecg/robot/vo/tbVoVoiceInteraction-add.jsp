<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>语音交互</title>
<t:base type="jquery,easyui,tools"></t:base>
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
<div class="easyui-layout" fit="true" style="width:1000px;height:600px;">
    <div region="west" split="true" title="" style="width:500px;">
	<!-- <form class="form-horizontal" role="form" id="formobj" action="tbVoVoiceInteractionController.do?doAdd" method="POST"> -->
	<t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" action="tbVoVoiceInteractionController.do?doAdd">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<div class="form-group">
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<tr >
						<td>所属机器人：</td>
						<td>
							<input type="text" id="robotsInfoId" name="robotsInfoId"  datatype="*" >
						</td>
					</tr>
				</div>
			</div>
		</div>
		<div style="width: auto;">
				<div style="width:600px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false"><!--&id=${tbCrCabineHeadPage.id}  -->
				 <t:tab href="tbVoVoiceInteractionController.do?robotsPointsList" icon="icon-add" title="交互信息" id="tbVoVoiceInteraction" ></t:tab>
				</t:tabs>
		</div> 
	</t:formvalid>
		<!-- 添加 附表明细 模版 -->
	<table style="display:none">
	<tbody id="add_jformGraphreportItem_table_template">
		<tr>
			<!--  <td align="center"><div style="width: 22px;" name="xh"></div></td>  -->
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td> 
				    <td align="left">
					  <input type="text" id="TbVoVoiceInteractionEntity[#index#].keyWord" name="TbVoVoiceInteractionEntity[#index#].keyWord">
 					  <label class="Validform_label" style="display: none;">关键词</label>
				  </td>
				  <td align="left">
				  		<input type="hidden" id="TbVoVoiceInteractionEntity[#index#].voiceResponseText" name="TbVoVoiceInteractionEntity[#index#].voiceResponseText">
				  	   <textarea id="TbVoVoiceInteractionEntity[#index#].voiceResponseText" name="TbVoVoiceInteractionEntity[#index#].voiceResponseText" rows="3" cols="3" style="width:260px" datatype="*" onchange="changePointsText(this)"></textarea>	
					  <label class="Validform_label" style="display: none;">语音回复文本</label>
				  </td>
			</tr>
		 </tbody>
	</table> 
    </div>
    <div region="center" title="" style="width:500px;" id="sitePanel" class="easyui-panel">
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
	}
});
/*-------------------------------------------所属机器人----------------------------------------------*/
</script>
</body>
</html>