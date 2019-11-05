<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="plug-in/echart/echarts.js"></script>
<link rel="shortcut icon" href="favicon.ico"> <link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="plug-in/hplus/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="plug-in/hplus/css/animate.css" rel="stylesheet">
<link href="plug-in/hplus/css/style.css?v=4.1.0" rel="stylesheet">
<style type="text/css">

.main-left3{
    width:25%;
    float:left;
 }
.main-right3{
     width:75%;
     float:right;
 }
 .main-left1{
     width:25%;
     height:200px;
     float:left;
 }

.main-center1{
    width:25%;
     height:200px;
     float:left;
 }
.main-right1{
   width:50%;
   float:right;
 } 
 img{
     width:200px;
     hright:200px;
 }
</style>
<t:base type="jquery,easyui,tools,layer,DatePicker,webuploader"></t:base>  
</head>
<body >
<div>
   <div class="main-left3"><h5>标准图</h5><input type="button" value="查看大图" class="ace_button" onclick="bzt()" style="margin-right:25px"></div>
   <div class="main-right3"><h5>异常图</h5><input type="button" value="查看大图" class="ace_button" onclick="yct()" style="margin-right:25px"></div>

</div>
<div class="input-group" style="width:100%">
				
			</div>
<div >
	<div class="main-left1">
	      <img src="${TbAlAlarmInfoEntity1.img_url}" width="250%" height="200%"/>
	      </div>
	<div class="main-center1">
	   <img src="${TbAlAlarmInfoEntity1.alarm_map_url}" width="250%" height="200%"/>    	     
	</div>
	<div class="main-right1">	
	  <div>
	   <div>
                <div class="bold" style="font-size:20px" >
                    相关信息:
                </div>
             </div>  
              <div class="row">
                <div class="col-sm-6" id="id1">	
                </div>
             </div> 	
             <div class="row">
                <div class="col-sm-6" id="id2">	
                    所属机房
                </div>
             </div> 
             <div class="row">
                <div class="col-sm-6" id="id3">	
                    机柜编号
                </div>
             </div> 
            <div class="row">
                <div class="col-sm-6" id="id4">	
                    告警编号
                </div>
             </div>   
            <div class="row">
                <div class="col-sm-6" id="id5">	
                   告警时间
                </div>
             </div>  
             <div class="row">
                <div class="col-sm-6" id="id6">	
                    告警级别
                </div>
             </div>        
           <div class="row">
                <div class="col-sm-6" id="id7">	
                    通知方式
                </div>
             </div>
             <div class="row" >
                <div class="col-sm-6" id="id8">	
                    告警接收人
                </div>
             </div>  
             <div class="row">
                <div class="col-sm-6" id="id9">	
                   处理状态
                </div>
             </div> 
                        
             <div style="width: auto;height: auto;" >
			<t:tabs id="tabs" iframe="false" tabPosition="top" fit="false">
			 <t:tab href="tbAlAlarmInfoController.do?indicator&id=${TbAlAlarmInfoEntity1.id}"  title="告警信息" id="xunjianpiont"></t:tab>
			</t:tabs>
		</div>    
		<div  style="display:none" id="typediv1">
            <div >
                <div class="bold" style="font-size:20px">
                     处理信息:
                </div>
             </div>  
               <div class="row">
                <div class="col-sm-6" id="cl1">	
                   处理时间:
                </div>
             </div> 
               <div class="row">
                <div class="col-sm-6" id="cl2">	
                     处理人	:
                </div>
             </div> 
               <div class="row">
                <div class="col-sm-6" id="cl3">	
                     故障原因:
                </div>
             </div> 
               <div class="row">
                <div class="col-sm-6" id="cl4" >	
                     解决方案:
                </div>
             </div> 
    </div> 
	  <div class="ibox-content p-xl" style="display:" style="padding-left: 240px;" id="ac_button" >
        <input type="button"  value="处理告警" class="ace_button" onclick="cl()" style="margin-right:25px">
        <input type="button"  value="忽略告警" class="ace_button" onclick="hl()" style="margin-right:25px">
        <input type="button"  value="修正告警" class="ace_button" onclick="xz()" style="margin-right:25px">
    </div>
      
	</div>
	
</div>   
    <script type="text/javascript">
	   var gj;
	  var hjLow;
	  var hjHeight;
	  var handTime=null;
	  var handUserName=null;
	  var failureCause=null;
	  var treatmentPlan=null;	
	       var id="${TbAlAlarmInfoEntity1.id}"; //id
	       handTime="${TbAlAlarmInfoEntity1.hand_time}";
		   handUserName="${TbAlAlarmInfoEntity1.hand_user_name}";
		   failureCause="${TbAlAlarmInfoEntity1.failure_cause}";
		   treatmentPlan="${TbAlAlarmInfoEntity1.treatment_plan}"; 
	       var robotsName= "机器人名称:"+"${TbAlAlarmInfoEntity1.robots_name}"; //机器人名称
	       var computerName="所属机房:"+"${TbAlAlarmInfoEntity1.computer_room_name}"; //所属机房
	       var cabineNo="机柜编号:"+"${TbAlAlarmInfoEntity1.cabine_no}"; //机柜编号
	       var alarmNo="告警编号:"+"${TbAlAlarmInfoEntity1.alarm_no}"; //告警编号
	       var alarmTime="告警时间:"+"${TbAlAlarmInfoEntity1.alarm_time}"; //告警时间
	       var tjfs="通知方式:"+"${TbAlAlarmInfoEntity1.alarm_mode}";
	       var typeName="告警级别:"+"${TbAlAlarmInfoEntity1.alarm_level_name}"; //告警级别
	       var departName="所属部门:"+"${TbAlAlarmInfoEntity1.departname}"; //所属部门
	       var typeName1="处理状态:"+"${TbAlAlarmInfoEntity1.typename1}"; //处理状态
	       var xsButton="${TbAlAlarmInfoEntity1.typename1}";  
	       var img_url = "${TbAlAlarmInfoEntity1.img_url}";
	       var alarm_map_url = "${TbAlAlarmInfoEntity1.alarm_map_url}";
       //回显处理信息
      if(handUserName!=null&&handUserName!=""){
	    	document.getElementById("typediv1").style.display="";
	    	document.getElementById("cl1").innerHTML ="处理时间:"+handTime;//处理时间
	    	document.getElementById("cl2").innerHTML = "处理人:"+handUserName;//处理人
	    	document.getElementById("cl3").innerHTML = "故障原因:"+failureCause;//故障原因
	    	document.getElementById("cl4").innerHTML = "解决方案:"+treatmentPlan;//解决方案
	    	//document.getElementById("ac_button").style.display="none";
      }  
       //隐藏按钮
      if(xsButton!="未处理"){
    	  document.getElementById("ac_button").style.display="none";
      }
     
	    document.getElementById("id1").innerHTML = robotsName;
	    document.getElementById("id2").innerHTML = computerName;
	    document.getElementById("id3").innerHTML = cabineNo;
	    document.getElementById("id4").innerHTML = alarmNo;
	    document.getElementById("id5").innerHTML = alarmTime;
	    document.getElementById("id6").innerHTML = typeName;
	    document.getElementById("id7").innerHTML = tjfs;
	    document.getElementById("id8").innerHTML = departName;
	    document.getElementById("id9").innerHTML = typeName1;
	    
	 
    function cl(){
        add('处理警告','tbAlAlarmInfoController.do?goAdd&id='+id,600,400);
         }
    function hl(){
    	$.dialog.confirm($.i18n.prop('是否忽略告警'), function(r) {
 		   if (r) {
 			  $.ajax({
 					url:'tbAlAlarmInfoController.do?hulue',
 					type:'GET',
 					dataType:'JSON',
 					delay: 250,
 					cache: true,
 					data:{'id':id},
 					success: function(data){
 						 if(data=="01"){location.reload();}
					     else{ tip("忽略失败")}
 					}
 				});
 			}
 		});
      }
    function xz(){
    	$.dialog.confirm($.i18n.prop('是否修正告警'), function(r) {
  		   if (r) {
  			  $.ajax({
					url:'tbAlAlarmInfoController.do?xiuzheng',
					type:'GET',
					dataType:'JSON',
					delay: 250,
					cache: true,
					data:{'id':id},
					success: function(data){
						   if(data=="01"){location.reload();}
						     else{ tip("修正失败")}
					}
				});	
  			}
  		});
    	
    } 
    
    function bzt(){
		openwindow("查看","tbCrComputerRoomController.do?viewPic&mapUrl1="+img_url,'',800,400);
	}
    function yct(){
		var mapUrl1 = $("#mapUrl1").val();
		openwindow("查看","tbCrComputerRoomController.do?viewPic&mapUrl1="+alarm_map_url,'',800,400);
	}
    </script>
</body>
</html>