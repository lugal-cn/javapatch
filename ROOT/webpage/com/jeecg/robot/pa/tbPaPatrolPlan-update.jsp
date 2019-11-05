<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>巡检计划</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
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
 <body style="overflow:hidden;overflow-y:auto;">
  <div class="easyui-layout" fit="true" style="width:1000px;height:600px;">
    <div region="west" split="true" title="" style="width:500px;overflow:hidden;" >
	<t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" action="tbPaPatrolPlanController.do?doUpdate" callback="saveObjcallback">	
	<!-- <form class="form-horizontal" role="form" id="formobj" action="tbPaPatrolPlanController.do?doUpdate" method="POST"> -->
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbPaPatrolPlan.id}"/>
		<input type="hidden" id="patrolPlanStatus" name="patrolPlanStatus" value="${tbPaPatrolPlan.patrolPlanStatus}"/>
		<div class="form-group">
			<!-- <label for="patrolPlanName" class="col-sm-3 control-label">巡检计划名称：</label> -->
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<tr >
						<td id="patrolPlanName" name="patrolPlanName">巡检计划名称：</td>
						<td>
							<input id="patrolPlanName" name="patrolPlanName" value='${tbPaPatrolPlan.patrolPlanName}' type="text" maxlength="200" class="form-control input-sm" placeholder="请输入巡检计划名称"  datatype="*"  ignore="checked" />
						</td>
						<font style="color: red;">*</font>
					</tr>
				</div>
			</div>
		</div>
		<div class="form-group">
			<!-- <label for="robotsInfoId" class="col-sm-3 control-label">所属机器人：</label> -->
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<tr >
						<td id="robotsInfoId" name="robotsInfoId">所属机器人：</td>
						<td>
							<%-- <input type="text" id="robotsInfoName" name="robotsInfoName"  datatype="*" value='${robotsInfo.robotsInfoName}'   onchange="queryxunjian(this.value);"> --%>
							 <input type="text" id="robotsInfoId" name="robotsInfoId"  datatype="*" disabled="disabled"  value='${tbPaPatrolPlan.robotsInfoId }'  onchange="queryPatrolTask(this.value);">
						</td>
					</tr>
				</div>
			</div>
		</div>
	    <div style="width: auto;">
				<div style="width:600px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false"><!--&id=${tbCrCabineHeadPage.id}  -->
				 <t:tab href="tbPaPatrolPlanController.do?tbPaPtrolPlanTaskListupdate&id=${tbPaPatrolPlan.id}&robotsInfo=${tbPaPatrolPlan.robotsInfoId }" icon="icon-add" title="添加计划的任务" id="tbPaPtrolPlan"></t:tab>
				</t:tabs>
		</div> 
			<div class="ui_buttons">
		<input type="button" id="id1" value="提交" onclick="saveObj()" class="ui_state_highlight ui_state_close">
		<input type="button" id="id2" value="关闭" onclick="closeObj()" class="ui_state_close">
	</div>
	</t:formvalid>

	</div>
		<!-- 添加 附表明细 模版 -->
	<table style="display:none">
	<tbody id="add_jformGraphreportItem_table_template">
		<tr>
			 <td align="center"><div  name="xh"></div></td>
			 <td align="center"><input  type="checkbox" name="ck"/></td> 
			 <input id="id" type="hidden" "/>
			 <input id="patrolPlanId" type="hidden" />
				  <td align="center">
					  	<!-- <input name="TbPaPatrolPlanTaskEntity[0].cabineNo" maxlength="20" type="text" class="inputxt"  style="width:120px;" datatype="*"/> -->
					  <!-- 	<input type="text" id="TbPaPatrolPlanTaskEntity[#index#].patrolTaskId" datatype="*" > -->
					  <input type="hidden" id="TbPaPatrolPlanTaskEntity[#index#].patrolTaskId" name="TbPaPatrolPlanTaskEntity[#index#].patrolTaskId">
					  <select  name="patrolTaskIds" id="TbPaPatrolPlanTaskEntity[#index#].patrolTaskIds" onchange="chengepatrolTaskId(this)"></select> 
					  	<%-- <t:dictSelect field="patrolTaskId" defaultVal="1" dictTable="tb_pa_patrol_task" dictCondition="" dictField="id" dictText="patrol_task_name"  datatype="*" title="任务"></t:dictSelect>  --%>
 					  <label class="Validform_label" style="display: none;">巡检任务</label>
				  </td>
				  <td align="left">
				  		 <input type="text"  name="TbPaPatrolPlanTaskEntity[#index#].startTime" id="TbPaPatrolPlanTaskEntity[#index#].startTime" class="Wdate" 
				    	style="width: 80%;" onClick="WdatePicker({qsEnabled:false,dateFmt:'HH'})" >
					  	  <%-- <t:dictSelect field="TbPaPatrolPlanTaskEntity[#index#].startTime" type="select" typeGroupCode="itacs_startHours" hasLabel="false" datatype="*"></t:dictSelect> --%>时  
					  <label class="Validform_label" style="display: none;">时</label>
				  </td>
				  <td align="left">
				  	 <input type="text"  name="TbPaPatrolPlanTaskEntity[#index#].patrolPlanId" id="TbPaPatrolPlanTaskEntity[#index#].patrolPlanId" class="Wdate" 
				    	style="width: 80%;" onClick="WdatePicker({qsEnabled:false,dateFmt:'mm'})" >
					  	 <%-- <t:dictSelect field="TbPaPatrolPlanTaskEntity[#index#].patrolPlanId" type="select" typeGroupCode="itacs_startMin" hasLabel="false" datatype="*"></t:dictSelect> --%>分
					  <label class="Validform_label" style="display: none;">分</label><!-- -->
				  </td> 
			</tr>
		 </tbody>
	</table> 
 <div region="center" title="" style="width:500px;" id="sitePanel" class="easyui-panel">
    	<div id="dv2" class="pic_div" style="height: 94%; z-index: 1;" >
            <img id="SmallLiuYiFeiImg" src="" class="pic">
        </div>
    </div>
</div>
</body>
</html>
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
//tabs跳转  查询机器人下的所有任务
function queryPatrolTask(obj){
	//根据机器人id查询机房图片
			$.ajax({
			url:'tbVoVoiceTemplateController.do?getPictureByRobotsId&robotsInfoId='+obj,
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
	if(obj==='${robotsInfo.robotsInfoId}'){
		var a=0;
		//给巡检点定点
				$.ajax({
				url:'tbPaPatrolPlanController.do?getRobotsInfoXYupdate&robotsInfoId='+obj+'&patrolTaskId='+'${tbPaPatrolPlan.id}',
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
							patrolPointNo = data[i].patrolTaskId;
					 		x = data[i].xCoordinate;
					 		y = data[i].yCoordinate;
					 		if(i>0 && i<data.length){
					 			if(data[i].patrolTaskId===data[i-1].patrolTaskId){//相同
						 			a++;
						 		}else{
						 			a=0;
						 		}
					 		}else if(i>=data.length){
					 			a++;
					 		}
					 		//删除div 重新加载机器人图标
					 		var idObject = document.getElementById('div'+patrolPointNo+a);
					 	    if (idObject != null) {
					 	          idObject.parentNode.removeChild(idObject);
					 	    }
					 		var div = document.createElement('div');
							div.id = 'div'+patrolPointNo+a;
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
				title: '添加计划的任务',
				href: "tbPaPatrolPlanController.do?tbPaPtrolPlanTaskListupdate&id=${tbPaPatrolPlan.id}&robotsInfo="+obj // the new content URL
			}
		});
	}else{
		var a=0;
		//给巡检点定点
				$.ajax({
				url:'tbPaPatrolPlanController.do?getRobotsInfoXYupdate&robotsInfoId='+'${tbPaPatrolPlan.robotsInfoId }'+'&patrolTaskId='+'${tbPaPatrolPlan.id}',
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
							patrolPointNo = data[i].patrolTaskId;
					 		x = data[i].xCoordinate;
					 		y = data[i].yCoordinate;
					 		
					 		if(i>0 && i<data.length){
					 			if(data[i].patrolTaskId===data[i-1].patrolTaskId){//相同
						 			a++;
						 		}else{
						 			a=0;
						 		}
					 		}else if(i>=data.length){
					 			a++;
					 		}
					 		//删除div 重新加载机器人图标
					 		var idObject = document.getElementById('div'+patrolPointNo+a);
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
				title: '添加计划的任务',
				href: "tbPaPatrolPlanController.do?tbPaPtrolPlanTaskListupdate&robotsInfo="+obj  // the new content URL
			}
		});
	}
 }
//设置查看时，不显示提交按钮
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
	 //alert(framename); 
	window.parent.frames[framename].reloadTable();
	//给机器人下发巡检计划
	 /* var patrolPlanStatus = $("#patrolPlanStatus").val();
	var robotsInfoId = $("#robotsInfoId").val();
	var id = $("#id").val();
	if(patrolPlanStatus && patrolPlanStatus == '1'){ //启用
		window.parent.frames[framename].insplan(id,robotsInfoId);
	}  */
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
