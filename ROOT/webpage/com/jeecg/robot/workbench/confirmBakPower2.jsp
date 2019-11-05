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
    <input name="controlName" type="radio" value="1"/>  终止当前任务，执行回桩充电，并在充电<input type="text" id="chare_time" value="60" style="width:30px;" maxlength="3"/>分钟后执行下一个任务，该时间默认60分钟，用户可以手工设定
    <br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;
	<input name="controlName" type="radio" checked="checked" value="2"/>  取消回桩充电，继续执行当前任务（30s后未选择，则默认选择此项）
  </body>
</html>
