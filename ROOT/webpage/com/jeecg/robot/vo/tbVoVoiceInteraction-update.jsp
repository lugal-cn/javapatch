<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>语音交互</title>
<t:base type="jquery,easyui,tools"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
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
<div class="container" style="width:100%;overflow:hidden">
	<div class="panel-heading"></div>
	<div class="panel-body">
<t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" 
	action="tbVoVoiceInteractionController.do?doUpdate"  callback="saveObjcallback">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input  type="hidden" id="robotsInteractionFlag" name="robotsInteractionFlag" class="btn_sub" value='${robotsInteractionFlag}'/>
		<input type="hidden" id="id" name="id" />
		<div class="form-group">
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<tr >
						<td>所属机器人：</td>
						<td>
							<input id="robotsInfoName"  name="robotsInfoName" value='${robotsInfo.robotsInfoName}' type="text"  readonly maxlength="200" class="form-control input-sm" placeholder="请输入所属机器人"  datatype="*"  ignore="checked" />
							<input id="robotsInfoId" readonly name="robotsInfoId" value='${robotsInfo.robotsInfoId}' type="hidden" maxlength="32" class="form-control input-sm" placeholder="请输入所属机器人"  datatype="*"  ignore="checked" />
						</td>
					</tr>
				</div>
			</div>
		</div>
		<div style="width: auto;">
				<div style="width:600px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false"><!--&id=${tbCrCabineHeadPage.id}  -->
				 <t:tab href="tbVoVoiceInteractionController.do?robotsPointsList&robotsInfoId=${robotsInfo.robotsInfoId}" icon="icon-add" title="交互信息" id="tbVoVoiceInteraction" ></t:tab>
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
			<!--  <td align="center"><div style="width: 22px;" name="xh"></div></td>  -->
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td> 
				    <td align="left" width="300px" heigth="100px">
					  <input type="text" id="TbVoVoiceInteractionEntity[#index#].keyWord" name="TbVoVoiceInteractionEntity[#index#].keyWord" datatype="*">
 					  <span style="color: red;">*</span>
 					  <label class="Validform_label" style="display: none;">关键词</label>
				  </td>
				  <td align="left"  width="400px" heigth="100px">
				  		<input type="hidden" id="TbVoVoiceInteractionEntity[#index#].voiceResponseText" name="TbVoVoiceInteractionEntity[#index#].voiceResponseText">
				  	   <textarea id="TbVoVoiceInteractionEntity[#index#].voiceResponseTexts" name="TbVoVoiceInteractionEntity[#index#].voiceResponseTexts" rows="3" cols="3"  style="width:300px" datatype="*" onchange="changePointsText(this)"></textarea>	
					  <span style="color: red;">*</span>
					  <label class="Validform_label" style="display: none;">语音回复文本</label>
				  </td>
			</tr>
		 </tbody>
	</table> 
	</div>
 </div>
<script type="text/javascript">
function voiceforkeyword(){
	var obj='${robotsInfo.robotsInfoId}';
	//查询数据根据机器人id
		 var datas={};
		 $.ajax({
				url:'tbVoVoiceInteractionController.do?voiceforkeywordlist&robotsInfoId='+obj,
				type:'GET',
				dataType:'JSON',
				async:false, 
				delay: 250,
				cache: true,
				success: function(data){	
					datas=data[0];
				}
			});
		 var msg="";
		 //接口-语音交互设置 voiceforkeyword
		 datas.interfaceNo="voiceforkeyword";
		 $.ajax({
								url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
								type : 'post',
								data: JSON.stringify(datas),
								datatype:'json',
								cache : false,
								async:false,
								success : function(data) {
									var d = $.parseJSON(data);
									if(d) {
										if (d.ErrorNo == '0') {
											msg = "语音交互设置成功";
										} else if(d.ErrorNo == '-1') {
											msg ="语音交互设置失败";
										} else if(d.ErrorNo == '1') {
											msg = "语音交互设置执行中";
										} else {
											//其他
										}
										
									} else {
										if (data.ErrorNo == '0') {
											msg ="语音交互设置成功";
										} else if(data.ErrorNo == '-1') {
											msg = "语音交互设置失败";
										} else if(data.ErrorNo == '1') {
											msg = "语音交互设置执行中";
										} else {
											//其他
										}
										
										
									}
									tip(msg);
								}
							});
		 
}
/**  执行保存 */
function saveObj() {
	$("#formobj").submit();
	/* voiceforkeyword(); */
}
var framename = '${framename}';
function saveObjcallback(data) {
	alert(data.msg);
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
</body>
</html>