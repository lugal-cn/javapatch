<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>

        电量<input id="text1" type="text" /> <br/>
		状态<input id="text2" type="text" /><br/> 
        <button onclick="send()"> Send </button>   
        <button   onclick="closeWebSocket()"> Close </button>
        <div id="message">   </div>       
 <script type="text/javascript">
//判断当前浏览器是否支持WebSocket
 if('WebSocket' in window){
     websocket = new WebSocket("ws://"+'${localhostIP}'+":7002/api/robotinfo/ff8080816d3d751f016d3efe890e0089");
     console.log("link success");
 }else{
     alert('Not support websocket');
 }
 
 //连接发生错误的回调方法
 websocket.onerror = function(){
     setMessageInnerHTML("error");
 };
  
 //连接成功建立的回调方法
 websocket.onopen = function(event){
     setMessageInnerHTML("open");
 };
  console.log("-----");
 //接收到消息的回调方法
 websocket.onmessage = function(event){
       setMessageInnerHTML(event.data);
 };
  
 //连接关闭的回调方法
 websocket.onclose = function(){
     setMessageInnerHTML("close");
 };
  
 //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
 window.onbeforeunload = function(){
     websocket.close();
 };
  
 //将消息显示在网页上
 function setMessageInnerHTML(innerHTML){
     document.getElementById('message').innerHTML += innerHTML + '<br/>';
 }
  
 //关闭连接
 function closeWebSocket(){
     websocket.close();
 }
  
 //发送消息
 function send(){
     var text1 = document.getElementById('text1').value;
     var text2 = document.getElementById('text2').value;
     //机器人在线
     var message = {robot_id:"ff8080816d3d751f016d3efe890e0089", power:text1, robot_status:text2,patrol_point_no:"5",
    		 temperature_text: "温度",
    		    temperature_value: "30.0",
    		    humidity_text: "湿度",
    		    humidity_value: "23",
    		    noise_text: "噪声",
    		    noise_value: "22",
    		    pm25_text: "pm2.5",
    		    pm25_value: "2",
    		    pollution_gas_text: "污染气体",
    		    pollution_gas_value: "12",
    		    equipment_temperature_text: "设备温度",
    		    equipment_temperature_value: "27.0" 
     			};
     
     websocket.send(JSON.stringify(message));
 }
 
 </script>
 
