<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>通知消息</title>
    <style type="text/css">
	    body{
	    	width:auto;
	    }
	    .tabs {
		    float:left;
		    width:98%;
		}
		.tabs ul 
		{
		    list-style: none outside none;
		    margin: 0;
		    padding: 0;
		}
		.tabs ul li
		{
		    float: left;
		    line-height: 24px;
		    margin: 0 2;
		    padding: 0px 10px 0 10px;
		    border:0px ;
		    /* border-bottom: 1px solid #1556cc;
		    border-right: 1px solid #1556cc;
		    border-top: 1px solid #1556cc; */
		    border-radius: 8px;
		    color: #fff;
		}
		.tab-nav{
		     background: #696767;
		     cursor:pointer;
		}
		.tab-nav-action{
		     /*  background: buttonshadow; */
		    cursor:pointer;
		    background-color: #35a0e8;
		    border: 1px #1556cc;
		}
		.tabs-body
		{
		    border: 1px solid #1873ca;
		    
		    float: left;
		    padding: 5px 0 0;
		    width: 98%;
		    height:75%;
		    overflow: auto;
		}
		.tabs-body div 
		{
		    padding:10px;
		}
		.tabs-body div table
		{
		}
		.tabs-body div table tr td
		{
		    border-top: 1px solid #000;
		}
		.myheader{
			width: 98%; 
			text-align: center;
			font-weight: bold; 
			font-family: "微软雅黑","新宋体","open sans","Helvetica Neue",Helvetica,Arial,"sans-serif";
		}
	</style>
	
	<script type="text/javascript">
	    $(document).ready(function () {
	        $("#tabs li").bind("click", function () {
	            var index = $(this).index();
	            var divs = $("#tabs-body > div");
	            $(this).parent().children("li").attr("class", "tab-nav");//将所有选项置为未选中
	            $(this).attr("class", "tab-nav-action"); //设置当前选中项为选中样式
	            divs.hide();//隐藏所有选中项内容
	            divs.eq(index).show(); //显示选中项对应内容
	        });
	        reloadData("");//加载数据
	    });
	    
	    var robotsInfoId;
	    var interval3=setInterval(function(){
	    	var robotStatus = window.parent.frames['iframe_robotsinfo'].$("#robotStatus").text();
	    	if(robotsInfoId) {
	    		reloadData(robotsInfoId);
	    	}
	       /*  if(robotStatus && robotStatus != "未连接") { //获取机器人的状态
		    	if(robotsInfoId) {
		    		reloadData(robotsInfoId);
		    	}
	        } */
	   },2000);
	    
	    //重新加载数据
	    function reloadData(robotId) {
	    	robotsInfoId = robotId;
	    	$.ajax({
	    		url : "workbenchController.do?getNoticeMsg",
	    		type : 'post',
	    		data : {id:robotId},
	    		cache : false,
	    		error:function(e){
		   		},
	    		success : function(data) {
	    			var d = $.parseJSON(data);
	    			if(d && d.lstMap) {
	    				var lstMap = d.lstMap;
	    				var alltableHtml = "";
    					var commonlytableHtml = "";
    					var warntableHtml = "";
    					var errortableHtml = "";
	    				for (var i = 0; i < lstMap.length; i++) {
	    					var noticeMessageType = lstMap[i].noticeMessageType; //通知类型
	    					var noticeMessageTime = lstMap[i].noticeMessageTime; //通知时间
	    					var noticeMessageContent = lstMap[i].noticeMessageContent; //通知内容
	    					var robotsName = lstMap[i].robotsName; //机器人名称
	    					alltableHtml += "<tr><td width=\"10px\" height=\"20px\">";
	    					if(noticeMessageType && noticeMessageType == '01') { //01	一般
	    						commonlytableHtml += "<tr><td width=\"10px\" height=\"20px\">";
	    						commonlytableHtml += "<img id=\"u6079_img\" src=\"images/u6079.png\"></td><td>";
	    						commonlytableHtml += noticeMessageTime+" "+robotsName+"<br/>"+noticeMessageContent;
	    						commonlytableHtml += "</td></tr>";
	    						alltableHtml += "<img id=\"u6077_img\" src=\"images/u6079.png\"></td><td>";
	    					} else if (noticeMessageType && noticeMessageType == '02') {//02	警告
	    						warntableHtml += "<tr><td width=\"10px\" height=\"20px\">";
	    						warntableHtml += "<img id=\"u6078_img\" src=\"images/u6078.png\"></td><td>";
	    						warntableHtml += noticeMessageTime+" "+robotsName+"<br/>"+noticeMessageContent;
	    						warntableHtml += "</td></tr>";
	    						alltableHtml += "<img id=\"u6077_img\" src=\"images/u6078.png\"></td><td>";
	    					} else if (noticeMessageType && noticeMessageType == '03') { //03	错误
	    						errortableHtml += "<tr><td width=\"10px\" height=\"20px\">";
	    						errortableHtml += "<img id=\"u6077_img\" src=\"images/u6077.png\"></td><td>";
	    						errortableHtml += noticeMessageTime+" "+robotsName+"<br/>"+noticeMessageContent;
	    						errortableHtml += "</td></tr>";
	    						alltableHtml += "<img id=\"u6077_img\" src=\"images/u6077.png\"></td><td>";
	    					} else {
	    					}
	    					alltableHtml += noticeMessageTime+" "+robotsName+"<br/>"+noticeMessageContent;
	    					alltableHtml += "</td></tr>";
	    				}
	    				//全部
    					$("#alltableid").html(alltableHtml);
	    				$("#commonlytableid").html(commonlytableHtml);
	    				$("#warntableid").html(warntableHtml);
	    				$("#errortableid").html(errortableHtml);
	    			}
	    		}
	    	});
	    }
	</script>
  </head>
  
  <body marginwidth="0px" marginheight="0px">
  	<div class="myheader">
  		<label style="font-size: 15px;">通知消息</label>
  		<hr>
 	</div>
  	<div class="tabs">
	    <ul id="tabs">
	        <li class="tab-nav-action">全部</li>
	        <li class="tab-nav">错误</li>
	        <li class="tab-nav">警告</li>
	        <li class="tab-nav">一般</li>
	    </ul>
	</div>
	<div id="tabs-body" class="tabs-body">
	    <div style="display:block">
	    	<table id="alltableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="errortableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="warntableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="commonlytableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	</div>
  </body>
</html>
