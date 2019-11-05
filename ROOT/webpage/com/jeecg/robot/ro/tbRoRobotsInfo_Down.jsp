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

	
  </head>
  
  <body marginwidth="0px" marginheight="50px">
    <div class="container" style="width:100%;height: 60%; text-align: center; padding-top: 10px;">
		<form class="form-horizontal" role="form" id="formobj" action="workbenchController.do?doImmePatrol" method="POST">
			<div class="form-group" rowspan="3">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" id="id" name="id"/>
			<label for="patrolTaskId" class="col-sm-3 control-label">请选择日期：</label>
			<input type="date" name="departureTime" id="departureTime"  pattern="yyyy-MM-dd" value="${time}" onchange="xuanzehou()"/> 
			</div>
			<div class="form-group"  id="yincang1" rowspan="3">
			<a id="xiazai"   class="button"  >日志下载</a>
			</div>
		</form>
	</div>
  </body>
  
</html>
<script type="text/javascript">
		 var robotsIp = '${robotsIp}';
		 var time='${time}';
	     var time1="http://"+robotsIp+":8080/api/downloadController/"+time+".log";  
	     document.getElementById("xiazai").href=time1;
	 function xuanzehou(){
		var cabineNo = $("#departureTime").val();
		var ss="http://"+robotsIp+":8080/api/downloadController/"+cabineNo+".log";
		document.getElementById("xiazai").href=ss;
		document.getElementById("yincang1").style.display="";
	 }
	
	 </script>