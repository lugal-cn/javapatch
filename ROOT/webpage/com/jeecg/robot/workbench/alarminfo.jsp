<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>告警信息</title>
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
	</style>
	<link rel="stylesheet" href="./webpage/com/jeecg/robot/workbench/myPageStyle.css" type="text/css" />
	
	<script type="text/javascript">
	    $(document).ready(function () {
	    	initAlarmLevel();//获取告警级别
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
	    
	    var alarmLeveArr;
	    //获取告警级别
	    function initAlarmLevel() {
	    	var alarmLevel = "<li class=\"tab-nav-action\" >全部</li>";
	    	var alarmDiv = "<div style=\"display:block\">"
					    	+"<table id=\"alltableid\" cellspacing=\"0px\" style=\"width: 100%; height:auto;\">"
					    	+"</table>"
					    	+"</div>";
	    	$.ajax({
	    		url : "workbenchController.do?getAlarmLevel",
	    		type : 'post',
	    		data : {},
	    		cache : false,
	    		async : false,
	    		error:function(e){
		   		},
	    		success : function(data) {
	    			var d = $.parseJSON(data);
	    			if(d && d.lstMap) {
	    				alarmLeveArr = d.lstMap;
	    				var lstMap = d.lstMap;
	    		        for (var i = 0; i < lstMap.length; i++) {
	    					var typecode = lstMap[i].typecode; //告警级别
	    					var typename = lstMap[i].typename; //告警类型
	    					alarmLevel += "<li class=\"tab-nav\">"+typename+"</li>";
	    					alarmDiv += "<div style=\"display:none\">"
						    	+"<table id=\"alarmtableid"+typecode+"\" cellspacing=\"0px\" style=\"width: 100%; height:auto;\">"
						    	+"</table>"
						    	+"</div>";
	    		        }
	    			}
	    		}
	    	});
	    	alarmLevel += "<li class=\"tab-nav\">动环告警</li>";
	    	alarmLevel += "<li class=\"tab-nav\">机器人告警</li>";
	    	alarmDiv += "<div style=\"display:none\">"
		    	+"<table id=\"alarmtableid06\" cellspacing=\"0px\" style=\"width: 100%; height:auto;\">"
		    	+"</table>"
		    	+"</div>";
	    	alarmDiv += "<div style=\"display:none\">"
		    	+"<table id=\"alarmtableid07\" cellspacing=\"0px\" style=\"width: 100%; height:auto;\">"
		    	+"</table>"
		    	+"</div>";
	    	$("#tabs").html(alarmLevel);
	    	$("#tabs-body").html(alarmDiv);
	    }
	    
	    var flag = false;
	    var robotsInfoId;
	    var interval3=setInterval(function(){
	    	var robotStatus = window.parent.frames['iframe_robotsinfo'].$("#robotStatus").text();
	    	if(robotsInfoId) {
	    		reloadData(robotsInfoId);
	    	}
	    	/*    if(robotStatus && robotStatus != "未连接") { //获取机器人的状态
		    	if(robotsInfoId) {
		    		reloadData(robotsInfoId);
		    	}
	        } */
	   },3000);
	    
	    //重新加载数据
	    function reloadData(robotId) {
	    	robotsInfoId = robotId;
	    	$.ajax({
	    		url : "workbenchController.do?getAlarmMsg",
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
    					var alarm1tableHtml = "";
    					var alarm2tableHtml = "";
    					var alarm3tableHtml = "";
    					var alarm4tableHtml = "";
    					var alarm5tableHtml = "";
    					var alarm6tableHtml = "";
    					var alarm7tableHtml = "";
	    				for (var i = 0; i < lstMap.length; i++) {
	    					var id=lstMap[i].id;
	    					var alarmLevel = lstMap[i].alarmLevel; //告警级别
	    					var alarmType = lstMap[i].alarmType; //告警类型
	    					var alarmTime = lstMap[i].alarmTime; //告警时间
	    					var cabineNo = lstMap[i].cabineNo; //机柜编号
	    					var alarmEquipment = lstMap[i].alarmEquipment; //告警设备
	    					var alarmDesc = lstMap[i].alarmDesc; //告警描述
	    					var computerRoomName=lstMap[i].computerRoomName;//所属机房
	    					var alarmLevelName=lstMap[i].alarm_level_name;//告警级别名称
	    					var trid=id+'_'+alarmType;
	    					var con = "<tr id=\""+trid+"\">"
	    		    			+"<td width=\"30px\" height=\"20px\" colspan=\"3\" style=\"border-top: 1px solid #000;\">"+alarmTime+"</td>"
	    		    			+"<td width=\"15px\" height=\"20px\" style=\"border-top: 1px solid #000;\">"+alarmType+"</td>"
	    		    			+"</tr>"
	    		    			+"<tr id=\""+trid+"\">"
	    		    			+"<td width=\"15px\" height=\"15px\">"+computerRoomName+"</td>"
	    		    			+"<td width=\"15px\" height=\"15px\">"+cabineNo+"</td>"
	    		    			+"<td width=\"15px\" height=\"15px\">"+alarmLevelName+"</td>"
	    		    			+"<td width=\"15px\" height=\"15px\">"+alarmEquipment+"</td>"
	    		    			+"<td width=\"15px\" height=\"15px\">"+alarmDesc+"</td>"
	    		    			+"</tr>";
	    					if(alarmLevel && alarmLevel == '01') { //01	一级
	    						alarm1tableHtml += con;
	    					} else if (alarmLevel && alarmLevel == '02') {//02
	    						alarm2tableHtml += con;
	    					} else if (alarmLevel && alarmLevel == '03') { //03
	    						alarm3tableHtml += con;
	    					} else if (alarmLevel && alarmLevel == '04') { //04
	    						alarm4tableHtml += con;
	    					} else if (alarmLevel && alarmLevel == '05') { //05
	    						alarm5tableHtml += con;
	    					} else if (alarmLevel && alarmLevel == '06') { //06
	    						alarm6tableHtml += con;
	    					} else if (alarmLevel && alarmLevel == '07') { //07
	    						alarm7tableHtml += con;
	    					}
	    					alltableHtml += con;
	    				}
	    				//全部
    					$("#alltableid").html(alltableHtml);
	    				if($("#alarmtableid01")) {$("#alarmtableid01").html(alarm1tableHtml);}
	    				if($("#alarmtableid02")) {$("#alarmtableid02").html(alarm2tableHtml);}
	    				if($("#alarmtableid03")) {$("#alarmtableid03").html(alarm3tableHtml);}
	    				if($("#alarmtableid04")) {$("#alarmtableid04").html(alarm4tableHtml);}
	    				if($("#alarmtableid05")) {$("#alarmtableid05").html(alarm5tableHtml);}
	    				$("#alarmtableid06").html(alarm6tableHtml);
	    				$("#alarmtableid07").html(alarm7tableHtml);
	    			}
	    		}
	    	});
	    }
	    
	    $(document).on('click','tr',function(obj){
	    	var arr=$(this).eq(0).attr("id").split("_");
	    	if(arr[1]=='动环告警'){
	            addOneTab('动环告警详情','tbAlAlarmInfoController.do?check&id='+arr[0],800,1200);
	    	}
	    	else{
	    		addOneTab('指示灯告警详情','tbAlAlarmInfoController.do?indicatorCheck&id='+arr[0],800,1200);
	    	}
	    	
	    	});
	    
	</script>
  </head>
  
  <body marginwidth="0px" marginheight="0px">
  	<div class="myheader">
  		<label style="font-size: 15px;">告警消息</label>
  		<hr>
 	</div>
  	<div class="tabs">
	    <ul id="tabs">
	        <!-- <li class="tab-nav-action" style="border-left: 1px solid #000;">全部</li>
	        <li class="tab-nav">一级</li>
	        <li class="tab-nav">二级</li>
	        <li class="tab-nav">三级</li>
	        <li class="tab-nav">四级</li>
	        <li class="tab-nav">五级</li>
	        <li class="tab-nav">动环告警</li>
	        <li class="tab-nav">机器人告警</li> -->
	    </ul>
	</div>
	<div id="tabs-body" class="tabs-body">
	    <!-- <div style="display:block">
	    	<table id="alltableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="alarm1tableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="alarm2tableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="alarm3tableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="alarm4tableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="alarm5tableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="alarm6tableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div>
	    <div style="display:none">
	    	<table id="alarm7tableid" cellspacing="0px" style="width: 100%; height:auto;">
	    	</table>
	    </div> -->
	</div>
  </body>
</html>
