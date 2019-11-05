<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>图表配置</title>
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
 </head>
 <body style="overflow-x: hidden;">
  <t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" action="tbCrCabineController.do?doAdd" callback="saveObjcallback">		
				<div>
				<fieldset>     
	                 <tr>
	      	<td style="width:90px;text-align: right;">请选择机房:</td>
		            <td>
			<input type="text" id="computerRoomId" name="computerRoomId" class="ac_input" datatype="*" ><label class="Validform_label" style="display: none;">机房名称</label>
		          </td>
	          </tr>    
	          <font style="color: red;">*</font>
	          </div>
                </fieldset>
               <div style="width: auto;">
				<div style="width:600px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
				 <t:tab href="tbCrCabineController.do?tbCrCabineCustomerList&id=${tbCrCabineHeadPage.id}" icon="icon-search" title="添加机柜" id="TbCrCabineEntity"></t:tab>
				</t:tabs>
			</div> 
			</t:formvalid>
			<div class="ui_buttons">
	<input type="button" value="提交" onclick="saveObj()" class="ui_state_highlight ui_state_close">
	<input type="button" value="关闭" onclick="closeObj()" class="ui_state_close"></div>
			
			<!-- 添加 附表明细 模版 -->
	<table style="display:none">
	<tbody id="add_jformGraphreportItem_table_template">
		<tr>
			<!--  <td align="center"><div style="width: 22px;" name="xh"></div></td> -->
			 <td align="center" style="width:40px;"><input type="checkbox" name="ck"/></td>
				  <td align="left" style="width:140px;">
					  	<input name="TbCrCabineEntity[#index#].cabineNo" maxlength="20" validCabineNo="cabineNo"
					  		type="text" class="inputxt cabineNo"  style="width:120px;" datatype="*"/>
					  <label class="Validform_label" style="display: none;">机柜编号</label>
					  <font style="color: red;">*</font>
				  </td>
				  <td align="left" style="width:140px;">
					  	  <t:dictSelect field="TbCrCabineEntity[#index#].cabineType" type="select" typeGroupCode="itacs_cabinetType" hasLabel="false" datatype="*"></t:dictSelect>  
					  <label class="Validform_label" style="display: none;">机柜类型</label>
					  <font style="color: red;">*</font>
				  </td>
				  <td align="left" style="width:140px;">
					  	<input name="TbCrCabineEntity[#index#].borderSize" maxlength="36" 
					  		type="text" class="inputxt"  style="width:120px;" datatype="*"/>
					  <label class="Validform_label" style="display: none;">边框尺寸</label>
					  <font style="color: red;">*</font>
				  </td>
				   <td align="left" style="width:220px;">
					  	<input name="TbCrCabineEntity[#index#].cabineDesc" maxlength="52"	 
					  		type="text" class="inputxt"  style="width:200px;" />
					  <label class="Validform_label" style="display: none;">机柜描述</label>
				  </td>
			</tr>
		 </tbody>
		</table> 
 </body>
 <!-- <script src = "webpage/jeecg/graphreport/jformGraphreportHead.js"></script> -->
 <script type="text/javascript">
 $(function() {
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
 });
 
 /**  执行保存 */
 function saveObj() {
	/*  var computerRoomId=document.getElementById("computerRoomId").value;
	 alert(computerRoomId);
	 if(computerRoomId==""){
		 tip('请选择机房');
		 return;
	 } */
 	$("#formobj").submit();
 }
 var framename = '${framename}';
 function saveObjcallback(data) {
 	//alert(framename);
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
	 //alert(tabId);
	 window.top.closeTab("tab_"+tabId);
 	/* var aobj = window.top.$("a[data-id='"+requrl+"']");
 	window.top.closePage2(aobj); */
 }
 
 </script>