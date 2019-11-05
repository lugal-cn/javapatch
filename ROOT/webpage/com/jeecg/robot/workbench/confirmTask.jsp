<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>远程控制弹窗确认</title>

  </head>
  
  <body marginwidth="0px" marginheight="0px">
  	<br/>&nbsp;&nbsp;&nbsp;&nbsp;
    <input name="controlName" type="radio" value="1"/>  终止远程控制，将巡检任务加入到任务队列，并立即执行任务队列中巡检任务。
    <br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input name="controlName" type="radio" checked="checked" value="2"/>  将巡检任务加入到任务队列，待引导结束后执行任务队列中巡检任务。（30s后未选择，则默认选择此项）
  </body>
</html>
