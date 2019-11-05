<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>我的工作台</title>
    <link rel="stylesheet" href="./webpage/com/jeecg/robot/workbench/myPageStyle.css" type="text/css" />
    
    
  </head>
  <body marginwidth="0px" marginheight="0px">
	
    <table width="100%" height="100%" cellspacing="15px;" style="background-color: #f3f3f3;border: 2px;">
    	<tr>
            <td colspan="1" rowspan="2" style="background-color: white; width: 25%;height: 30%; " class="class1">
            	<iframe id="iframe_robotsinfo" name="iframe_robotsinfo" width="100%" height="100%" 
						src="workbenchController.do?robotsinfo" frameborder="0"></iframe>
            </td>
            <td colspan="2" rowspan="3" style="background-color: white; width: 50%;height: 50%; " class="class1">
            	<iframe id="iframe_computerroom" name="iframe_computerroom" width="100%" height="100%" 
						src="workbenchController.do?computerroom" frameborder="0"></iframe>
            </td>
            <td colspan="1" rowspan="3" style="background-color: white; width: 25%;height: 50%; " class="class1">
            	<iframe name="iframe_alarminfo" width="100%" height="100%" 
						src="workbenchController.do?alarminfo" frameborder="0"></iframe>
            </td>
        </tr>
    	<tr>
        </tr>
        <tr>
            <td colspan="1" rowspan="4" style="background-color: white; width: 25%;height: 70%;" class="class1">
            	<iframe id="iframe_patroltask" name="iframe_patroltask" width="100%" height="100%" 
						src="workbenchController.do?patroltask" frameborder="0"></iframe>
				<!-- <iframe id="iframe_patroltask" name="iframe_patroltask" width="100%" height="100%" 
						src="workbenchController.do?websocketTest" frameborder="0"></iframe> -->
						
            </td>
        </tr>
        <tr>
            <td colspan="1" rowspan="3" style="background-color: white; width: 25%;height: 50%;" class="class1">
            	<iframe id="iframe_livecameras" name="iframe_livecameras" width="100%" height="100%" 
						src="workbenchController.do?livecameras" frameborder="0"></iframe>
            </td>
            <td colspan="1" rowspan="3" style="background-color: white; width: 25%;height: 50%;" class="class1">
            	<iframe id="iframe_imgcameras" name="iframe_imgcameras" width="100%" height="100%" 
						src="workbenchController.do?imgcameras" frameborder="0"></iframe>
            </td>
            <td colspan="1" rowspan="3" style="background-color: white; width: 25%;height: 50%;" class="class1">
            	<iframe id="iframe_noticemessage" name="iframe_noticemessage" width="100%" height="100%" 
						src="workbenchController.do?noticemessage" frameborder="0"></iframe>
            </td>
        </tr>
        <tr>
        </tr>
        <tr>
        </tr>
    </table>
</body>
</html>
