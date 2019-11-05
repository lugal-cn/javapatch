<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>立即巡检</title>
    <!-- select2 -->
	<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
	<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
	<script type="text/javascript">
		 var robotId = '${robotId}';
		 var robotIp = '${robotIp}';
		 var userName='${userName}';
		 $(document).ready(function() {
		 /*-------------------------------------------所属机器人----------------------------------------------*/
			var select2Data = new Array();
			$.ajax({
				url:'workbenchController.do?patrolTaskSelect',
				type:'GET',
				data:{robotId:robotId},
				delay: 250,
				dataType:'JSON',
				cache: true,
				success: function(data){
					for(var i = 0; i < data.length; i++){
						var select2Obj = {};
						select2Obj.id = data[i][0];
						select2Obj.text = data[i][1];
						select2Data.push(select2Obj);
					}
					$("#patrolTaskId").select2({
						data: select2Data,
						placeholder:'请选择巡检任务',//默认文字提示
					    language:{
					    	noResults: function (data) {
				                  return "";
				                  }},
					    allowClear: true//允许清空
					});
				}
			});
			/*-------------------------------------------所属机器人----------------------------------------------*/
		 });
		 
	 </script>
  </head>
  
  <body marginwidth="0px" marginheight="0px">
    <div class="container" style="width:90%;height: 80%; text-align: center; padding-top: 10px;">
		<form class="form-horizontal" role="form" id="formobj" action="workbenchController.do?doImmePatrol" method="POST">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" id="id" name="id"/>
			<label for="patrolTaskId" class="col-sm-3 control-label">巡检任务：</label>
			<input type="text" id="patrolTaskId" name="patrolTaskId">
		</form>
	</div>
  </body>
</html>
