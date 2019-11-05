<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>巡检任务表</title>
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
</head>
 <body style="overflow:hidden;overflow-y:auto;">
<div class="easyui-layout" fit="true" style="width:1000px;height:600px;">
    <div region="west" split="true" title="" style="width:500px;"> 
	<t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" action="tbPaPatrolTaskController.do?doUpdate&robotsInfoId=${tbPaPatrolTask.robotsInfoId}" callback="saveObjcallback">	
	<!-- <form class="form-horizontal" role="form" id="formobj" action="tbPaPatrolTaskController.do?doUpdate" method="POST"> -->
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id" value="${tbPaPatrolTask.id}"/>
	<div class="form-group" >
			<label for="patrolTaskName" class="col-sm-3 control-label"></label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<tr >
						<td id="patrolTaskName" name="patrolTaskName">任务名称：</td>
						<td>
							<input id="patrolTaskName" name="patrolTaskName" value='${tbPaPatrolTask.patrolTaskName}'   type="text" maxlength="200" class="form-control input-sm" placeholder="请输入任务名称"  datatype="*"  ignore="checked" />
						</td>
						<font style="color: red;">*</font>
					</tr>
				</div>
			</div>
		</div>
		<br/>
		<div class="form-group">
			<!-- <label for="robotsInfoId" class="col-sm-3 control-label">所属机器人：</label> -->
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<tr >
						<td id="robotsInfoId" name="robotsInfoId">所属机器人：</td>
						<td>
							<%-- <input type="text" id="robotsInfoName" name="robotsInfoName"  datatype="*" value='${robotsInfo.robotsInfoName}'   onchange="queryxunjian(this.value);"> --%>
							 <input type="text" id="robotsInfoId" name="robotsInfoId"  value='${tbPaPatrolTask.robotsInfoId}'  datatype="*"   disabled="disabled"    onchange="queryxunjian(this.value);">
						</td>
					</tr>
				</div>
			</div>
		</div>
		<div style="width: auto;height: auto;" >
			<t:tabs id="tabs" iframe="false" tabPosition="top" fit="false">
			 <t:tab href="tbPaPatrolTaskController.do?gogoupdate&robotsInfoId=${tbPaPatrolTask.id}" icon="icon-search" title="巡检点列表" id="xunjianpiont"></t:tab>
			</t:tabs>
		</div>
		<br/>
<div>
</div>
	<div class="ui_buttons">
		<input type="button" id="id1" value="提交" onclick="saveObj()" class="ui_state_highlight ui_state_close">
		<input type="button" id="id2" value="关闭" onclick="closeObj()" class="ui_state_close">
	</div>
	</t:formvalid>
	</div>
    <div region="center" title="" style="width:500px;" id="sitePanel" class="easyui-panel">
    	<div id="dv2" class="pic_div" style="height: 94%; z-index: 1;" >
            <img id="SmallLiuYiFeiImg" src="" class="pic">
        </div>
    </div>
</div>
<script type="text/javascript">
var openType = '${openType}';
if(openType && openType == 1) {
	$("#id1").hide();
} else {
	$("#id1").show();
}
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
	 


/*-------------------------------------------根据机器人的id查询该机器人的巡检点信息----------------------------------------------*/
function queryxunjian(obj){
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
		//遍历巡检点的图
		$.ajax({
				url:'tbPaPatrolTaskController.do?getRobotsInfoXYupdate&robotsInfoId='+obj+'&patrolTaskId='+'${tbPaPatrolTask.id}',
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
		//相同就不需要查询下面的，把选中的给去掉了   走tabs回显选中的
		var tab = $('#tabs').tabs('getSelected');
		$('#tabs').tabs('update',{
			tab: tab,
			options: {
				title: '巡检点',
				href: "tbPaPatrolTaskController.do?gogoupdate&robotsInfoId="+'${tbPaPatrolTask.id}'  // the new content URL
			}
		});
	}else{
		//遍历巡检点的图
				$.ajax({
						url:'tbPaPatrolTaskController.do?getRobotsInfoXYupdate&robotsInfoId='+'${tbPaPatrolTask.robotsInfoId}'+'&patrolTaskId='+'${tbPaPatrolTask.id}',
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
							 		
								}
							}
						});
		var tab = $('#tabs').tabs('getSelected');
		$('#tabs').tabs('update',{
			tab: tab,
			options: {
				title: '请选择巡检点',
				href: "tbPaPatrolTaskController.do?queryxunjian&robotInfoId="+obj  // the new content URL
			}
		});
	}
}
var subDlgIndex = '';
$(document).ready(function() {
});
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