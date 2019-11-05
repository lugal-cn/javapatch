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
<style type="text/css"></style>
<t:base type="jquery,easyui,tools,layer,DatePicker"></t:base>  

</head>
<body >

 <div class="ibox-content p-xl">
            <div class="row">
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
             <!-- <div class="row" >
                <div class="col-sm-6" id="id8">	
                    告警接收人
                </div>
             </div>   -->
             <div class="row">
                <div class="col-sm-6" id="id9">	
                   处理状态
                </div>
             </div> 
   </div>
<div id="main"></div>
<div style="padding-left: 67%;">备注：点击设备温度指针可以查看设备异常图片</div>
<!-- <div id="main1"></div> -->
 <div class="ui_buttons" style="padding-left: 240px;" id="ac_button" >
        <input type="button"  value="处理告警" class="ace_button" onclick="cl()" style="margin-right:25px">
        <input type="button"  value="忽略告警" class="ace_button" onclick="hl()" style="margin-right:25px">
        <input type="button"  value="修正告警" class="ace_button" onclick="xz()" style="margin-right:25px">
    </div>
    <div class="ibox-content p-xl" style="display:none" id="typediv1">
      <div class="row" >
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
    <script type="text/javascript">
	  var gj;
	  var hjLow;
	  var hjHeight;
	  var handTime=null;
	  var handUserName=null;
	  var failureCause=null;
	  var treatmentPlan=null;
	    gj={name:'告警数据', type:'bar', data:[
			${TbAlAlarmInfosEntity.temperature_value},
			${TbAlAlarmInfosEntity.humidity_value},
			${TbAlAlarmInfosEntity.noise_value},
			${TbAlAlarmInfosEntity.pm25_value},
			${TbAlAlarmInfosEntity.pollution_gas_value},
			${TbAlAlarmInfosEntity.equipment_temperature_value}],};  //拼接告警数据
		  hjLow={name:'环境阈值', type:'bar', data:[
			${TbAlAlarmInfosEntity.temperature_low},
			${TbAlAlarmInfosEntity.humidity_low},
			${TbAlAlarmInfosEntity.noise_low},
			${TbAlAlarmInfosEntity.pm25_low},
			${TbAlAlarmInfosEntity.pollution_gas_low},
			${TbAlAlarmInfosEntity.equipment_temperature_low}],};  //拼接环境阈值（低） */
		 hjHeight={name:'环境阈值', type:'bar', data:[
			${TbAlAlarmInfosEntity.temperature_high},
			${TbAlAlarmInfosEntity.humidity_high},
			${TbAlAlarmInfosEntity.noise_high},
			${TbAlAlarmInfosEntity.pm25_high},
			${TbAlAlarmInfosEntity.pollution_gas_high},
			${TbAlAlarmInfosEntity.equipment_temperature_high}]};  //拼接环境阈值（高）	
           
	       var id="${TbAlAlarmInfoEntity1.id}"; //告警信息id
	       var moventId="${TbAlAlarmInfosEntity.Id}";//动环数据Id   
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
	    //   var departName="所属部门:"+"${TbAlAlarmInfoEntity1.departname}"; //所属部门
	       var typeName1="处理状态:"+"${TbAlAlarmInfoEntity1.typename1}"; //处理状态
	       var xsButton="${TbAlAlarmInfoEntity1.typename1}";
    var echartsWarp= document.getElementById('main');   
    //var echartsWarp1= document.getElementById('main1');   
    var resizeWorldMapContainer = function () {//用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽  
        echartsWarp.style.width = window.innerWidth+'px';  
        echartsWarp.style.height = (window.innerHeight*0.5)+'px';  
        //echartsWarp1.style.width = window.innerWidth+'px';  
        //echartsWarp1.style.height = (window.innerHeight*0.3)+'px';  
    };        
      resizeWorldMapContainer ();//设置容器高宽  
      var myChart = echarts.init(echartsWarp);
      //var myChart1= echarts.init(echartsWarp1);
       //回显处理信息
      if(handUserName!=null&&handUserName!=""){
	    	document.getElementById("typediv1").style.display="";
	    	document.getElementById("cl1").innerHTML ="处理时间:"+handTime;//处理时间
	    	document.getElementById("cl2").innerHTML = "处理人:"+handUserName;//处理人
	    	document.getElementById("cl3").innerHTML = "故障原因:"+failureCause;//故障原因
	    	document.getElementById("cl4").innerHTML = "解决方案:"+treatmentPlan;//解决方案
      }  
       //隐藏按钮
      if(xsButton!="未处理"){
    	  document.getElementById("ac_button").style.display="none";
      }
/*        var s= {
    	    title : {
    	        text: '动环告警详情',
    	  
    	    },
    	    tooltip : {
    	        trigger: 'axis'
    	    },
    	    legend: {
    	        data:['告警数据','环境阈值']
    	    },
    	    toolbox: {
    	        show : true,
    	        feature : {
    	            dataView : {show: true, readOnly: false},
    	            magicType : {show: true, type: ['line', 'bir'] ,
		    	            iconStyle: {
		                                borderColor: '#1e90ff'
		                            },
		                               emphasis:{
		                                iconStyle: {
		                                    borderColor: '#22bb22'
		                                },
		                            }
    	            
    	                          },
    	            restore : {show: true},
    	            saveAsImage : {show: true}
    	        }
    	    },
    	    calculable : true,
    	    xAxis : [
    	        {
    	            type : 'category',
    	            data : ['温度/°C','湿度/%','噪音/DB','PM2.5/μg/m³','污染气体/ppm','设备温度/°C']
    	        }
    	    ],
    	    yAxis : [
    	        {
    	            type : 'value'
    	        }
    	    ],
    	    series : [
    	      hjLow, gj,  hjHeight   
    	    ]	
    	}; */   	
    	//温度
    	var temperature_value=${TbAlAlarmInfosEntity.temperature_value};//当前值
    	var temperature_value_hight=${TbAlAlarmInfosEntity.temperature_high};//最高值
    	var temperature_value_low=${TbAlAlarmInfosEntity.temperature_low};//最低值
    	var temperature_minval = ((${TbAlAlarmInfosEntity.temperature_low})-(((${TbAlAlarmInfosEntity.temperature_high})-(${TbAlAlarmInfosEntity.temperature_low}))/3)).toFixed(2);
    	var temperature_maxval = ((${TbAlAlarmInfosEntity.temperature_high})+(((${TbAlAlarmInfosEntity.temperature_high})-(${TbAlAlarmInfosEntity.temperature_low}))/3)).toFixed(2);
    	if(temperature_value>temperature_value_hight){
    		temperature_value=temperature_value_hight+((temperature_maxval-temperature_value_hight)/2);
    	}else if(temperature_value<temperature_value_low){
    		temperature_value=temperature_value_low-((temperature_value_low-temperature_minval)/2);
    	}
    	//湿度
    	var  humidity_value=${TbAlAlarmInfosEntity.humidity_value};
    	var  humidity_value_hight=${TbAlAlarmInfosEntity.humidity_high};
    	var  humidity_value_low=${TbAlAlarmInfosEntity.humidity_low};
    	var  humidity_minval=(${TbAlAlarmInfosEntity.humidity_low}-((${TbAlAlarmInfosEntity.humidity_high}-${TbAlAlarmInfosEntity.humidity_low})/3)).toFixed(2)
    	var  humidity_maxval =(${TbAlAlarmInfosEntity.humidity_high}+((${TbAlAlarmInfosEntity.humidity_high}-${TbAlAlarmInfosEntity.humidity_low})/3)).toFixed(2)
    	if(humidity_value>humidity_value_hight){
    		humidity_value=humidity_value_hight+((humidity_maxval-humidity_value_hight)/2);
    	}else if(humidity_value<humidity_value_low){
    		humidity_value=humidity_value_low-((humidity_value_low-humidity_minval)/2);
    	}
    	//噪音
    	var  noice_value=${TbAlAlarmInfosEntity.noise_value};
    	var  noice_value_hight=${TbAlAlarmInfosEntity.noise_high};
    	var  noice_value_low=${TbAlAlarmInfosEntity.noise_low};
    	var  noice_minval=(${TbAlAlarmInfosEntity.noise_low}-((${TbAlAlarmInfosEntity.noise_high}-${TbAlAlarmInfosEntity.noise_low})/3)).toFixed(2);
    	var  noice_maxval =(${TbAlAlarmInfosEntity.noise_high}+((${TbAlAlarmInfosEntity.noise_high}-${TbAlAlarmInfosEntity.noise_low})/3)).toFixed(2);
    	if(noice_value>noice_value_hight){
    		noice_value=noice_value_hight+((noice_maxval-noice_value_hight)/2);
    	}else if(noice_value<noice_value_low){
    		noice_value_low=noice_value_low-((noice_value_low-noice_minval)/2);
    	}
    	//pm2.5
    	var  pm25_value=${TbAlAlarmInfosEntity.pm25_value};
    	var  pm25_value_hight=${TbAlAlarmInfosEntity.pm25_high};
    	var  pm25_value_low=${TbAlAlarmInfosEntity.pm25_low};
    	var  pm25_minval=(${TbAlAlarmInfosEntity.pm25_low}-((${TbAlAlarmInfosEntity.pm25_high}-${TbAlAlarmInfosEntity.pm25_low})/3)).toFixed(2);
    	var  pm25_maxval=(${TbAlAlarmInfosEntity.pm25_high}+((${TbAlAlarmInfosEntity.pm25_high}-${TbAlAlarmInfosEntity.pm25_low})/3)).toFixed(2);
    	if(pm25_value>pm25_value_hight){
    		pm25_value=pm25_value_hight+((pm25_maxval-pm25_value_hight)/2);
    	}else if(pm25_value<pm25_value_low){
    		pm25_value=pm25_value_low-((pm25_value_low-pm25_minval)/2);
    	}
    	//污染气体
    	 var poll_value=${TbAlAlarmInfosEntity.pollution_gas_value};
    	 var poll_value_hight=${TbAlAlarmInfosEntity.pollution_gas_high};
    	 var poll_value_low=${TbAlAlarmInfosEntity.pollution_gas_low};
    	 var poll_minval= (${TbAlAlarmInfosEntity.pollution_gas_low}-((${TbAlAlarmInfosEntity.pollution_gas_high}-${TbAlAlarmInfosEntity.pollution_gas_low})/3)).toFixed(2);
    	 var poll_maxval=(${TbAlAlarmInfosEntity.pollution_gas_high}+((${TbAlAlarmInfosEntity.pollution_gas_high}-${TbAlAlarmInfosEntity.pollution_gas_low})/3)).toFixed(2);
    	 if(poll_value>poll_value_hight){
    		 poll_value=poll_value_hight+((poll_maxval-poll_value_hight)/2);
    	 }else if(poll_value<poll_value_low){
    		 poll_value=poll_value_low-((poll_value_low-poll_minval)/2);
    	 }
    	 //设备温度
    	 var equ_value=${TbAlAlarmInfosEntity.equipment_temperature_value};
    	 var equ_value_high=${TbAlAlarmInfosEntity.equipment_temperature_high};
    	 var equ_value_low=${TbAlAlarmInfosEntity.equipment_temperature_low};
    	 var equ_minval =((${TbAlAlarmInfosEntity.equipment_temperature_low})-(((${TbAlAlarmInfosEntity.equipment_temperature_high})-(${TbAlAlarmInfosEntity.equipment_temperature_low}))/3)).toFixed(2);
    	 var equ_maxval= ((${TbAlAlarmInfosEntity.equipment_temperature_high})+(((${TbAlAlarmInfosEntity.equipment_temperature_high})-(${TbAlAlarmInfosEntity.equipment_temperature_low}))/3)).toFixed(2);
    	 if(equ_value>equ_value_high){
    		 equ_value=equ_value_high+((equ_maxval-equ_value_high)/2);
    	 }else if(equ_value<equ_value_low){
    		 equ_value=equ_value_low-((equ_value_low-equ_minval)/2);
    	 }
    	
    	 var s = {
    		    tooltip : {
    		        formatter: "{a} <br/>{c} {b}",
    		        show:false
    		    },
    		    toolbox: {
    		        show: true,
    		        feature: {
    		            restore: {show: false},
    		            saveAsImage: {show: false}
    		        }
    		    },
    		    series : [
    		        {
    		            name: '温度',
    		            type: 'gauge',
    		            min: temperature_minval,
    		            max: temperature_maxval,
    		            center:['10%','50%'],
    		            splitNumber: 5,  
    		          
    		            radius: '50%',	
    		            axisLine: {            // 坐标轴线
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    width: 1,
    		                    color:[
    		                        [0,'#930000'],
    		                        [0.2,'#930000'],
    		                        [0.8,'#006030'],
    		                        [1,'#930000']
    		                        ]
    		                }
    		            },
		   		            pointer: {
		   		                width:5,//指针的宽度
		   		                length:"70%", //指针长度，按照半圆半径的百分比
		   		                shadowColor : '#ccc', //默认透明
		   		                shadowBlur: 5,        
		   		            },
    		
    		            axisTick: {            // 坐标轴小标记
    		                length: 2,        // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            splitLine: {           // 分隔线
    		                length: 5,         // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            axisLabel: {
    		                backgroundColor: 'auto',
    		                borderRadius: 1,
    		                color: '#eee',
    		                padding: 1,
    		                textShadowBlur: 2,
    		                textShadowOffsetX: 1,
    		                textShadowOffsetY: 1,
    		                textShadowColor: '#222',
    		                formatter: function(e) {     		    
      		                     if(Math.abs(e-(${TbAlAlarmInfosEntity.temperature_low}))<1){
      		                    	 return ${TbAlAlarmInfosEntity.temperature_low};
      		                     }else if(Math.abs(e-${TbAlAlarmInfosEntity.temperature_high})<0.5){
      		                    	 return ${TbAlAlarmInfosEntity.temperature_high};
      		                     }
      		                     else {
      		                    	 if(temperature_minval == e) {
      		                    		return -40;
      		                    	 } else if(temperature_maxval == e) {
      		                    		return 85;
      		                    	 } else {
      		                    		e=e.toFixed(0);
      		                    		return e;
      		                    	 }
      		                    	 
      		                    	 
      		                     }
      		                    	 
      		                }  
    		            },
    		            title : {
    		            	 offsetCenter: [0, '-120%'],     
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                fontSize: 10,
    		                fontStyle: 'italic'
    		            },
    		            detail : {
    		            	formatter:function(e){
    		            		return ${TbAlAlarmInfosEntity.temperature_value};
    		            	},
    		            	 offsetCenter:[0, '80%'],
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                borderRadius: 1,
    		                backgroundColor: '#444',
    		                borderColor: '#aaa',
    		                shadowBlur: 10,
    		                shadowColor: '#333',
    		                shadowOffsetX: 0,
    		                shadowOffsetY: 1,
    		                borderWidth:1,
    		                textBorderColor: '#000',
    		                textBorderWidth: 1,
    		                textShadowBlur: 2,
    		                textShadowColor: '#fff',
    		                textShadowOffsetX: 0,
    		                textShadowOffsetY: 0,
    		                fontFamily: 'Arial',
    		                fontSize:15,
    		                width: 10,
    		                color: '#eee',
    		                rich: {}
    		            },
    		            data:[{value:temperature_value, name: '温度/°C'}]
    		        },
    		        {
    		            name: '湿度',
    		            type: 'gauge',
    		            z: 3,
    		            min: humidity_minval,
    		            max: humidity_maxval,
    		            center:['25%','50%'],
    		            splitNumber: 5,
    		            radius: '50%',
    		            axisLine: {            // 坐标轴线
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    width: 1,
    		                    color:[
    		                        [0,'#930000'],
    		                        [0.2,'#930000'],
    		                        [0.8,'#006030'],
    		                        [1,'#930000']
    		                        ]
    		                }
    		            },
    		            pointer: {
	   		                width:5,//指针的宽度
	   		                length:"70%", //指针长度，按照半圆半径的百分比
	   		                shadowColor : '#ccc', //默认透明
	   		                shadowBlur: 5
	   		            },
    		            axisTick: {            // 坐标轴小标记
    		                length: 2,        // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            splitLine: {           // 分隔线
    		                length: 5,         // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            axisLabel: {
    		                backgroundColor: 'auto',
    		                borderRadius: 1,
    		                color: '#eee',
    		                padding: 1,
    		                textShadowBlur: 2,
    		                textShadowOffsetX: 1,
    		                textShadowOffsetY: 1,
    		                textShadowColor: '#222',
    		                formatter: function(e) {
      		                	
      		                     if(Math.abs(e-(${TbAlAlarmInfosEntity.humidity_low}))<1){
      		                    	 return ${TbAlAlarmInfosEntity.humidity_low};
      		                     }else if(Math.abs(e-${TbAlAlarmInfosEntity.humidity_high})<0.5){
      		                    	 return ${TbAlAlarmInfosEntity.humidity_high};
      		                     }
      		                     else {
      		                    	 if(humidity_minval==e){
      		                    		 return 0;
      		                    	 }else if(humidity_maxval==e){
      		                    		 return 100;
      		                    	 }else{
      		                    		e=e.toFixed(0);
         		                    	 return e;
      		                    	 }
      		                    	 
      		                     }
      		                    	 
      		                }  
    		            },
    		            title : {
    		            	offsetCenter: [0, '-120%'],     
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                fontSize: 10,
    		                fontStyle: 'italic'
    		            },
    		            detail : {
    		            	formatter:function(e){
    		            		return ${TbAlAlarmInfosEntity.humidity_value};
    		            	},
    		            	 offsetCenter: [0, '80%'],
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                borderRadius: 1,
    		                backgroundColor: '#444',
    		                borderColor: '#aaa',
    		                shadowBlur: 5,
    		                shadowColor: '#333',
    		                shadowOffsetX: 0,
    		                shadowOffsetY: 2,
    		                borderWidth:2,
    		                textBorderColor: '#000',
    		                textBorderWidth: 2,
    		                textShadowBlur: 2,
    		                textShadowColor: '#fff',
    		                textShadowOffsetX: 0,
    		                textShadowOffsetY: 0,
    		                fontFamily: 'Arial',
    		                fontSize:15,
    		                width: 10,
    		                color: '#eee',
    		                rich: {}
    		            },
    		            data:[{value: humidity_value, name: '湿度/%'}]
    		        },
    		      {
    		            name: '噪音',
    		            type: 'gauge',
    		            z: 3,
    		            min: noice_minval,
    		            max: noice_maxval,
    		            center:['40%','50%'],
    		            splitNumber: 5,
    		            radius: '50%',
    		            axisLine: {            // 坐标轴线
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    width: 1,
    		                    color:[
    		                        [0,'#930000'],
    		                        [0.2,'#930000'],
    		                        [0.8,'#006030'],
    		                        [1,'#930000']
    		                        ]
    		                }
    		            },
    		            pointer: {
	   		                width:5,//指针的宽度
	   		                length:"70%", //指针长度，按照半圆半径的百分比
	   		                shadowColor : '#ccc', //默认透明
	   		                shadowBlur: 5
	   		            },
    		            axisTick: {            // 坐标轴小标记
    		                length: 2,        // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            splitLine: {           // 分隔线
    		                length: 5,         // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            axisLabel: {
    		                backgroundColor: 'auto',
    		                borderRadius: 1,
    		                color: '#eee',
    		                padding: 1,
    		                textShadowBlur: 2,
    		                textShadowOffsetX: 1,
    		                textShadowOffsetY: 1,
    		                textShadowColor: '#222',
   		                	 formatter: function(e) {
         		                     if(Math.abs(e-${TbAlAlarmInfosEntity.noise_low})<1){
         		                    	 return ${TbAlAlarmInfosEntity.noise_low};
         		                     }else if(Math.abs(e-${TbAlAlarmInfosEntity.noise_high})<1){
         		                    	 return ${TbAlAlarmInfosEntity.noise_high};
         		                     }
         		                     else {
         		                    	 if(noice_minval==e){
         		                    		 return 30;
         		                    		 }
         		                    	 else if(noice_maxval==e){
         		                    		 return 130;
         		                    	 }
         		                    	 else{
         		                    		 e=e.toFixed(0);
             		                    	 return e;
         		                    	 }
         		                    	
         		                     }
         		                    	 
         		                }  
    		            },
    		            title : {
    		            	 offsetCenter: [0, '-120%'],     
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                fontSize: 10,
    		                fontStyle: 'italic'
    		            },
    		            detail : {
    		            	formatter:function(e){
    		            		return ${TbAlAlarmInfosEntity.noise_value};
    		            	},
    		            	 offsetCenter: [0, '80%'],
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                borderRadius: 1,
    		                backgroundColor: '#444',
    		                borderColor: '#aaa',
    		                shadowBlur: 5,
    		                shadowColor: '#333',
    		                shadowOffsetX: 0,
    		                shadowOffsetY: 2,
    		                borderWidth:1,
    		                textBorderColor: '#000',
    		                textBorderWidth: 2,
    		                textShadowBlur: 2,
    		                textShadowColor: '#fff',
    		                textShadowOffsetX: 0,
    		                textShadowOffsetY: 0,
    		                fontFamily: 'Arial',
    		                fontSize:15,
    		                width: 10,
    		                color: '#eee',
    		                rich: {}
    		            },
    		            data:[{value:noice_value, name: '噪音/DB'}]
					},
					{
    		            name: 'PM2.5/μg/m³',
    		            type: 'gauge',
    		            z: 3,
    		            min: pm25_minval,
    		            max: pm25_maxval,
    		            center:['55%','50%'],
    		            splitNumber: 5,
    		            radius: '50%',
    		            axisLine: {            // 坐标轴线
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    width: 1,
    		                    color:[
    		                        [0,'#930000'],
    		                        [0.2,'#930000'],
    		                        [0.8,'#006030'],
    		                        [1,'#930000']
    		                        ]
    		                }
    		            },
    		            pointer: {
	   		                width:5,//指针的宽度
	   		                length:"70%", //指针长度，按照半圆半径的百分比
	   		                shadowColor : '#ccc', //默认透明
	   		                shadowBlur: 5
	   		            },
    		            axisTick: {            // 坐标轴小标记
    		                length: 2,        // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            splitLine: {          	 // 分隔线
    		                length: 5,         // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            axisLabel: {
    		                backgroundColor: 'auto',
    		                borderRadius: 1,
    		                color: '#eee',
    		                padding: 1,
    		                textShadowBlur: 2,
    		                textShadowOffsetX: 1,
    		                textShadowOffsetY: 1,
    		                textShadowColor: '#222',
    		                formatter: function(e) {
    		                	 
    		                     if(Math.abs(e-${TbAlAlarmInfosEntity.pm25_low})<1){
    		                    	 return ${TbAlAlarmInfosEntity.pm25_low};
    		                     }else if(Math.abs(e-${TbAlAlarmInfosEntity.pm25_high})<1){
    		                    	 return ${TbAlAlarmInfosEntity.pm25_high};
    		                     }
    		                     else {
    		                    	 if(pm25_minval==e){return 0;}
    		                    	 else if(pm25_maxval==e){
    		                    		 return 1000;
    		                    	 }else{
    		                    		 e=e.toFixed(0);
    		                    		 return e;
    		                    	 }
    		                    	
    		                     }
    		                    	 
    		                }  
    		            },
    		            title : {
    		            	 offsetCenter: [0, '-120%'],     
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                fontSize: 10,
    		                fontStyle: 'italic'
    		            },
    		            detail : {
    		            	formatter:function(e){
    		            		return ${TbAlAlarmInfosEntity.pm25_value};
    		            	},
    		            	 offsetCenter: [0, '80%'],
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                borderRadius: 1,
    		                backgroundColor: '#444',
    		                borderColor: '#aaa',
    		                shadowBlur: 5,
    		                shadowColor: '#333',
    		                shadowOffsetX: 0,
    		                shadowOffsetY: 2,
    		                borderWidth:2,
    		                textBorderColor: '#000',
    		                textBorderWidth: 2,
    		                textShadowBlur: 2,
    		                textShadowColor: '#fff',
    		                textShadowOffsetX: 0,
    		                textShadowOffsetY: 0,
    		                fontFamily: 'Arial',
    		                fontSize:15,
    		                width: 10,
    		                color: '#eee',
    		                rich: {}
    		            },
    		            data:[{value: pm25_value, name: 'PM2.5/μg/m³'}]
    		        },
    		        {
    		            name: '污染气体/ppm',
    		            type: 'gauge',
    		            z: 3,
    		            min: poll_minval,
    		            max: poll_maxval,
    		            center:['70%','50%'],
    		            splitNumber: 5,
    		            radius: '50%',
    		            axisLine: {            // 坐标轴线
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    width: 1,
    		                    color:[
    		                        [0,'#930000'],
    		                        [0.2,'#930000'],
    		                        [0.8,'#006030'],
    		                        [1,'#930000']
    		                        ]
    		                }
    		            },
    		            pointer: {
	   		                width:5,//指针的宽度
	   		                length:"70%", //指针长度，按照半圆半径的百分比
	   		                shadowColor : '#ccc', //默认透明
	   		                shadowBlur: 5
	   		            },
    		            axisTick: {            // 坐标轴小标记
    		                length:2,        // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            splitLine: {           // 分隔线
    		                length: 5,         // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            axisLabel: {
    		                backgroundColor: 'auto',
    		                borderRadius: 1,
    		                color: '#eee',
    		                padding: 1,
    		                textShadowBlur: 2,
    		                textShadowOffsetX: 1,
    		                textShadowOffsetY: 1,
    		                textShadowColor: '#222',
    		                formatter: function(e) {
   		                	
   		                     if(Math.abs(e-${TbAlAlarmInfosEntity.pollution_gas_low})<1){
   		                    	 return ${TbAlAlarmInfosEntity.pollution_gas_low};
   		                     }else if(Math.abs(e-${TbAlAlarmInfosEntity.pollution_gas_high})<1){
   		                    	 return ${TbAlAlarmInfosEntity.pollution_gas_high};
   		                     }
   		                     else {
   		                    	 if(poll_minval==e){return 10;}else if(poll_maxval==e){return 1000;}
   		                    	 else{
   		                    		 e=e.toFixed(0);
   		                    		 return e;
   		                    	 }
   		                    	
   		                     }
   		                    	 
   		                }  
    		            },
    		            title : {
    		            	 offsetCenter: [0, '-120%'],     
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                fontSize: 10,
    		                fontStyle: 'italic'
    		            },
    		            detail : {
    		            	formatter:function(e){
    		            		return ${TbAlAlarmInfosEntity.pollution_gas_value};
    		            	},
    		            	 offsetCenter: [0, '80%'],
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                borderRadius: 1,
    		                backgroundColor: '#444',
    		                borderColor: '#aaa',
    		                shadowBlur: 5,
    		                shadowColor: '#333',
    		                shadowOffsetX: 0,
    		                shadowOffsetY: 2,
    		                borderWidth:2,
    		                textBorderColor: '#000',
    		                textBorderWidth: 2,
    		                textShadowBlur: 2,
    		                textShadowColor: '#fff',
    		                textShadowOffsetX: 0,
    		                textShadowOffsetY: 0,
    		                fontFamily: 'Arial',
    		                fontSize:15,
    		                width: 10,
    		                color: '#eee',
    		                rich: {}
    		            },
    		            data:[{value: poll_value, name: '污染气体/ppm'}]
    		        },
    		        {
    		            name: '设备温度/°C',
    		            type: 'gauge',
    		            z: 3,
    		            min: equ_minval,
    		            max: equ_maxval,
    		            center:['85%','50%'],
    		            splitNumber: 5,
    		            radius: '50%',
    		            axisLine: {            // 坐标轴线
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    width: 1,
    		                    color:[
    		                        [0,'#930000'],
    		                        [0.2,'#930000'],
    		                        [0.8,'#006030'],
    		                        [1,'#930000']
    		                        ]
    		                }
    		            },
    		            pointer: {
	   		                width:5,//指针的宽度
	   		                length:"70%", //指针长度，按照半圆半径的百分比
	   		                shadowColor : '#ccc', //默认透明
	   		                shadowBlur: 5
	   		            },
    		            axisTick: {            // 坐标轴小标记
    		                length: 2,        // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            splitLine: {           // 分隔线
    		                length: 5,         // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
    		                    color: 'auto'
    		                }
    		            },
    		            axisLabel: {
    		            	
    		                backgroundColor: 'auto',
    		                borderRadius: 1,
    		                color: '#eee',
    		                padding: 1,
    		                textShadowBlur: 2,
    		                textShadowOffsetX: 1,
    		                textShadowOffsetY: 1,
    		                textShadowColor: '#222',
    		                
    		                formatter: function(e) {
   		                      if(Math.abs(e-(${TbAlAlarmInfosEntity.equipment_temperature_low}))<1){
   		                    	 return ${TbAlAlarmInfosEntity.equipment_temperature_low};
   		                     }else if(Math.abs(e-(${TbAlAlarmInfosEntity.equipment_temperature_high}))<1){
   		                    	 return ${TbAlAlarmInfosEntity.equipment_temperature_high};
   		                     }
   		                     else {
   		                    	 if(equ_minval==e){
   		                    		 return -40;
   		                    	 }
   		                    	 else if(equ_maxval==e){
   		                    		 return 85;
   		                    	 }else{
   		                    		 e=e.toFixed(0);
   		                    		 return e;
   		                    	 }
   		                    	
   		                     } 
   		                    	 
   		                }   
    		            },
    		            title : { 	 offsetCenter: [0, '-120%'],     
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                fontSize: 10,
    		                fontStyle: 'italic'
    		            },
    		            detail : {
    		            	formatter:function(e){
    		            		return ${TbAlAlarmInfosEntity.equipment_temperature_value};
    		            	},
    		            	 offsetCenter: [0, '80%'],
    		                // 其余属性默认使用全局文本样式，详见TEXTSTYLE
    		                fontWeight: 'bolder',
    		                borderRadius: 1,
    		                backgroundColor: '#444',
    		                borderColor: '#aaa',
    		                shadowBlur: 5,
    		                shadowColor: '#333',
    		                shadowOffsetX: 0,
    		                shadowOffsetY: 2,
    		                borderWidth:2,
    		                textBorderColor: '#000',
    		                textBorderWidth: 2,
    		                textShadowBlur: 2,
    		                textShadowColor: '#fff',
    		                textShadowOffsetX: 0,
    		                textShadowOffsetY: 0,
    		                fontFamily: 'Arial',
    		                fontSize:15,
    		                width: 10,
    		                color: '#eee',
    		                rich: {}
    		            },
    		            data:[{value: equ_value, name: '设备温度/°C'}]
    		        }
    		    ]
    	}; 


    	
    	
    	

    	 option =s;	
        myChart.setOption(option);
        //myChart1.setOption(option1);
	    document.getElementById("id1").innerHTML = robotsName;
	    document.getElementById("id2").innerHTML = computerName;
	    document.getElementById("id3").innerHTML = cabineNo;
	    document.getElementById("id4").innerHTML = alarmNo;
	    document.getElementById("id5").innerHTML = alarmTime;
	    document.getElementById("id6").innerHTML = typeName;
	    document.getElementById("id7").innerHTML = tjfs;
	  //  document.getElementById("id8").innerHTML = departName;
	    document.getElementById("id9").innerHTML = typeName1;
	    
	 
    function cl(){
    	 $.ajax({
				url:'tbAlAlarmInfoController.do?queryhandStatus&id='+id,
				type:'GET',
				dataType:'JSON',
				delay: 250,
				cache: true,
				success: function(data){
                     if(data=="2"){
                   add('处理警告','tbAlAlarmInfoController.do?goAdd&id='+id,600,400);
                     }        
                     else{
                    	  tip("这条数据已被处理");
                     }
				}
			});
    	
    	
       
         }
    function hl(){
    	$.dialog.confirm($.i18n.prop('是否忽略告警'), function(r) {
 		   if (r) {
 			  $.ajax({
 					url:'tbAlAlarmInfoController.do?queryhandStatus&id='+id,
 					type:'GET',
 					dataType:'JSON',
 					delay: 250,
 					cache: true,
 					success: function(data){
 	                     if(data=="2"){
 	                    	 $.ajax({
 	         					url:'tbAlAlarmInfoController.do?hulue',
 	         					type:'GET',
 	         					dataType:'JSON',
 	         					delay: 250,
 	         					cache: true,
 	         					data:{'id':id},
 	         					success: function(data){
 	         	                       if(data=="01"){
 	         	                    	  location.reload();
 	         	                       }
 	         	                       else{
 	         	                    	   tip("忽略失败");
 	         	                       }
 	         					}
 	         				});  
 	                     }        
 	                     else{
 	                    	  tip("这条数据已被处理");
 	                     }
 					}
 				});
 			   
 			   
 			   
 			 /*  $.ajax({
 					url:'tbAlAlarmInfoController.do?hulue',
 					type:'GET',
 					dataType:'JSON',
 					delay: 250,
 					cache: true,
 					data:{'id':id},
 					success: function(data){
 	                       if(data=="01"){
 	                    	  location.reload();
 	                       }
 	                       else{
 	                    	   tip("忽略失败");
 	                       }
 						
 					}
 				}); */
 			}
 		});
      }
    function xz(){
    	$.dialog.confirm($.i18n.prop('是否修正告警'), function(r) {
  		   if (r) {
  			   
  			 $.ajax({
 				url:'tbAlAlarmInfoController.do?queryhandStatus&id='+id,
 				type:'GET',
 				dataType:'JSON',
 				delay: 250,
 				cache: true,
 				success: function(data){
                      if(data=="2"){
                    	  $.ajax({
          					url:'tbAlAlarmInfoController.do?xiuzheng',
          					type:'GET',
          					dataType:'JSON',
          					delay: 250,
          					cache: true,
          					data:{'id':id},
          					success: function(data){
          						     if(data=="01"){location.reload();}
          						     else{ tip("忽略失败");}
          						
          					}
          				});
                      }        
                      else{
                     	  tip("这条数据已被处理");
                      }
 				}
 			});
  			}
  		});
    	
    }
    
    myChart.on('click',function(params){
    	if(params.name=="设备温度/°C"){
    		 openwindow('图片详情','tbAlAlarmInfoController.do?viewPic&id='+moventId,"tbAlAlarmInfo-check",600,400);
    	}
    });
    
    </script>
</body>
</html>