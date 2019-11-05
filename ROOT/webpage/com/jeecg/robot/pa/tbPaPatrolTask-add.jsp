<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>巡检任务表</title>
<t:base type="jquery,easyui,validform,tools"></t:base>
<link  rel="stylesheet"  href="../plug-in/easyui/themes/black/mystyle.css" type="text/css" charset="utf-8">
<!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
<style type="text/css">
	.pic_div{
        position: relative;
        background-color: white;
        border: 0px dotted red;
        margin: 10px auto;
    }
    .pic{
        width: 100%;
        height: auto;
    }
   </style>
  <script type="text/javascript">
  $(document).ready(function(){
	  var robotsInfoId="${robotsInfoId}";
		document.getElementById('robotsInfoId').value=robotsInfoId;
		queryxunjian(robotsInfoId);
	$('#tabs').tabs({
	   onSelect:function(title){
	       $('#tabs .panel-body').css('width','auto');
		}
	});
	$(".tabs-wrap").css('width','100%');
  });
 </script>
</head>
 <body style="overflow:hidden;overflow-y:auto;">
 <div class="easyui-layout" fit="true" style="width:1000px;height:600px;">
    <div region="west" split="true" title="" style="width:500px;">                                <!--从list页面点击按钮跳转过来  -->
	  <t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" action="tbPaPatrolTaskController.do?doAdd&robotsInfoId=${robotsInfoId}"
	   callback="saveObjcallback" >
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<div class="form-group" >
			<label for="patrolTaskName" class="col-sm-3 control-label"></label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<tr >
						<td id="patrolTaskName" name="patrolTaskName">任务名称：</td>
						<td>
							<input id="patrolTaskName" name="patrolTaskName" datatype="*" type="text" maxlength="200" class="form-control input-sm" placeholder="请输入任务名称"  ignore="checked" />
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
							<input type="text" id="robotsInfoId" name="robotsInfoId"  datatype="*" disabled="disabled" onchange="queryxunjian(this.value);">
						</td>					
					</tr>
				</div>
			</div>
		</div>
		<div style="width: auto;height: auto;" >
			<t:tabs id="tabs" iframe="false" tabPosition="top" fit="false">
			 <t:tab href="tbPaPatrolTaskController.do?queryxunjian&robotInfoId=" icon="icon-add" title="请选择巡检点" id="xunjianpiont"></t:tab>
			</t:tabs>
		</div>
	</t:formvalid>
	<div class="ui_buttons">
	<input type="button" value="提交" onclick="saveObj()" class="ui_state_highlight ui_state_close">
	<input type="button" value="关闭" onclick="closeObj()" class="ui_state_close"></div>
	</div>
    <div region="center" title="" style="width:500px;" id="sitePanel" class="easyui-panel">
    	<div id="dv2" class="pic_div" style="height: 94%; z-index: 1;" >
            <img id="SmallLiuYiFeiImg" src="" class="pic">
        </div>
    </div>
</div>
<script type="text/javascript">
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
	var tab = $('#tabs').tabs('getSelected');
	$('#tabs').tabs('update',{
		tab: tab,
		options: {
			title: '请选择巡检点',
			href: "tbPaPatrolTaskController.do?queryxunjian&robotInfoId="+obj  // the new content URL
		}
	});
}
/*-------------------------------------------根据机器人的id查询该机器人的巡检点信息----------------------------------------------*/
var subDlgIndex = '';

$(document).ready(function() {
	
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
	
	
	
});
//正则限制任务名称的输入格式
/* patrolTaskName.onkeyup=function(){
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