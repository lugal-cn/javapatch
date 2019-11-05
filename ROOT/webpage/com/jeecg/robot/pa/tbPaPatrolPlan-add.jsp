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
	var robotsInfoId="${robotsInfoId}";
	document.getElementById('robotsInfoId').value=robotsInfoId;
	queryPatrolTask(robotsInfoId);
	/* $('#tt').tabs({
		   onSelect:function(title){
		       $('#tt .panel-body').css('width','auto');
			}
		});
		$(".tabs-wrap").css('width','100%'); */
});
/* var project_details = {
        minView: 0, 
        language:  'zh-CN',
        format: 'yyyy-mm-dd hh:ii',
        //todayBtn:  1,//今日按钮
        autoclose: 1,//选中关闭
        //todayHighlight : 1,
        //forceParse : 1,
    };
    $('.datetimepicker').datetimepicker(project_details); */

</script>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="easyui-layout" fit="true" style="width:1000px;height:600px;">
    <div region="west" split="true" title="" style="width:500px;overflow:hidden;">
	<!-- <form class="form-horizontal" role="form" id="formobj" action="tbPaPatrolPlanController.do?doAdd" method="POST"> -->
	<t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" action="tbPaPatrolPlanController.do?doAdd&robotsInfoId=${robotsInfoId}" callback="saveObjcallback">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<div class="form-group">
			<label for="patrolPlanName" class="col-sm-3 control-label">巡检计划名称：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="patrolPlanName" name="patrolPlanName" type="text" maxlength="200" class="form-control input-sm" placeholder="请输入巡检计划名称"  datatype="*"  ignore="checked" />
				<font style="color: red;">*</font>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="robotsInfoId" class="col-sm-3 control-label">所属机器人：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<!-- <input id="robotsInfoId" name="robotsInfoId" type="text" maxlength="32" class="form-control input-sm" placeholder="请输入所属机器人"  datatype="*"  ignore="checked" /> -->
					<tr >
						<td>
							<input type="text" id="robotsInfoId" name="robotsInfoId"  datatype="*" disabled="disabled" >
						</td>
					</tr>
				</div>
			</div>
		</div>
		 <div style="width: auto;">
				<div style="width:600px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false"><!--&id=${tbCrCabineHeadPage.id}  -->
				 <t:tab href="tbPaPatrolPlanController.do?tbPaPtrolPlanTaskListupdate&id=${tbPaPatrolPlan.id}&robotsInfo=${tbPaPatrolPlan.robotsInfoId }"  icon="icon-add" title="添加计划的任务" id="tbPaPtrolPlan"></t:tab>
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
			 <td align="center"><div  name="xh"></div></td>
			 <td align="center"><input  type="checkbox" name="ck"/></td> 
				    <td align="center">
					  <input type="hidden" id="TbPaPatrolPlanTaskEntity[#index#].patrolTaskId" name="TbPaPatrolPlanTaskEntity[#index#].patrolTaskId">
					  <select  name="patrolTaskIds" id="TbPaPatrolPlanTaskEntity[#index#].patrolTaskIds" onchange="chengepatrolTaskId(this)"></select> 
 					  <label class="Validform_label" style="display: none;">巡检任务</label>
				  </td>
				  <td align=center >
				    <input type="text"  name="TbPaPatrolPlanTaskEntity[#index#].startTime" id="TbPaPatrolPlanTaskEntity[#index#].startTime" class="Wdate" 
				    	style="width: 80%;" onClick="WdatePicker({qsEnabled:false,dateFmt:'HH'})" > 时
					  	 <%--  <t:dictSelect field="TbPaPatrolPlanTaskEntity[#index#].startTime" type="select" typeGroupCode="itacs_startHours" hasLabel="false" datatype="*"></t:dictSelect> --%>  
					  <label class="Validform_label" style="display: none;">时</label>
				  </td>
				  <td align="center">
				  		<input type="text"  name="TbPaPatrolPlanTaskEntity[#index#].patrolPlanId" id="TbPaPatrolPlanTaskEntity[#index#].patrolPlanId" class="Wdate"
				  		 style="width: 80%;" onClick="WdatePicker({qsEnabled:false,dateFmt:'mm'})" >分
					  	 <%-- <t:dictSelect field="TbPaPatrolPlanTaskEntity[#index#].patrolPlanId" type="select" typeGroupCode="itacs_startMin" hasLabel="false" datatype="*"></t:dictSelect> --%>
					  <label class="Validform_label" style="display: none;">分</label><!-- -->
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
	<!--  <script src = "webpage/jeecg/graphreport/jformGraphreportHead.js"></script> -->
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

//tabs跳转  查询机器人下的所有任务
function queryPatrolTask(obj){
	//根据机器人id查询机房图片
	$.ajax({
	url:'tbVoVoiceTemplateController.do?getPictureByRobotsId&robotsInfoId='+obj,
	type:'GET',
	dataType:'JSON',
	delay: 250,
	cache: true,
	async:false,
	success: function(data){
			if(data){
				$('#SmallLiuYiFeiImg').attr('src',data.mapUrl);
			}else{
				$('#SmallLiuYiFeiImg').attr('src',"");
			}
			
		}
	});
	 var tab = $('#tt').tabs('getSelected');
		$('#tt').tabs('update',{
			tab: tab,
			options: {
				title: '添加计划的任务',
				href: "tbPaPatrolPlanController.do?tbPaPtrolPlanTaskList&robotsInfoId="+obj // the new content URL
			}
		}); 	
	
}


//正则限制任务名称的输入格式
/* patrolPlanName.onkeyup=function(){
	var re=/^[\u4E00-\u9FA5A-Za-z0-9]+$/;//只允许输入中文，英文和数字
	if(!re.test(this.value)){
	alert("请勿输入特殊字符");
	this.value=this.value.substr(0,this.value.length-1);//将最后输入的字符去除
	  }
	} */
	
/**  执行保存 */
function saveObj() {
	$("#formobj").submit();
}
var framename = '${framename}';
function saveObjcallback(data) {
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
</body>
</html>