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
    <input name="controlName" type="radio" value="1"/>  终止当前任务，机器人待命中。
    <br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input name="controlName" type="radio" checked="checked" value="2"/>  取消操作，机器人继续执行当前任务。（30s后未选择，则默认选择此项）
  </body>
</html>
