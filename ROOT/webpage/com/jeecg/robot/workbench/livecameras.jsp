<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>机器人巡检直播视频画面</title>
    <!-- <link href="/plug-in/ueditor/third-party/video-js/video-js.css" rel="stylesheet" type="text/css">
	<script src="/plug-in/ueditor/third-party/video-js/video.js"></script> -->
	<%-- <link href="<%=basePath%>/plug-in/ueditor/third-party/video-js/video-js.css" rel="stylesheet" type="text/css">
	<script src="<%=basePath%>/plug-in/ueditor/third-party/video-js/video.js"></script> --%>
	<!-- <link href="/plug-in/video-js.css" rel="stylesheet">
	<script src="/plug-in/video.js"></script> -->
	<link href="/plug-in/5.20.1/video-js.css" rel="stylesheet">
	<script src="/plug-in/5.20.1/video.js"></script>
	<!-- <script src="http://vjs.zencdn.net/5.20.1/video.js"></script>
	<link href="http://vjs.zencdn.net/5.20.1/video-js.css" rel="stylesheet"> -->
    <!-- <script src="http://vjs.zencdn.net/5.20.1/videojs-ie8.min.js"></script> -->
	<style type="text/css">
		body{
	    	width:auto;
	    }
	</style>
	<script type="text/javascript">
	videojs.options.flash.swf = "/plug-in/ueditor/third-party/video-js/video-js.swf";
	var robotId = '${robotId}'
    /* $(function(){
        if($.cookie("refresh")!="no"){
			var panduan = true;
			var interval3=setInterval(function(){
				var aobj = window.top.$("a[data-id='workbenchController.do?workbench']");
		    	if(aobj.hasClass("active")){ //显示状态
		    		if(panduan){
		    			panduan=false;
		    		}
		    	} else {
		    		location.reload();
		    	}
		   },10);
        }
    }); */
    
	</script>
  </head>
  
  <body marginwidth="0px" marginheight="0px">
    <div id="example_video_1" class="video-js vjs-default-skin" style="width: 98%;height: 100%;"></div>
  	<!-- <video id="example_video_1" class="video-js vjs-default-skin vjs-big-play-centered flex-grid " controls preload="auto" width="280" height="240" data-setup="{}">
	  <source src="rtmp://192.168.216.187:1940/live/stream" type='rtmp/flv'/>
	</video> -->
	<!-- <input type="button" value="播放/停止" onclick="aj()"/>
	<input type="button" value="播放" onclick="testPlay()"/>
	<input type="button" value="停止" onclick="testpause()"/> -->
  </body>
  <script type="text/javascript">
  var width = document.body.clientWidth - 2;
  var height = document.body.clientHeight - 2;
  var panduan1 = true;
  var panduan2 = true;
  var rtmp='${rtmp}';
  var interval3=setInterval(function(){
	  if(robotId) {
	  //var aobj = window.top.$("a[data-id='workbenchController.do?workbench']"); 
	  var aobj = window.top.$("li[id='tab_tab_home']");
		  	if(aobj.hasClass("active")){ //显示状态
		  		if(panduan1){
	  				panduan1=false;
		  			panduan2 = true;
		  			testPlay();
		  		}
		  	
		  	} else {
		  		if(panduan2){
		  			panduan2=false;
		  			panduan1 = true;
		  			testpause();
		  		}
		  	}
	  }
	 },100);
  var videoParams;
  var player;
  if(robotId) {
		videoParams = {
	            link: rtmp, 
	            type: 'rtmp/flv', 
	            tech: [ 'flash' ] };
		player = new videojs( '#example_video_1', 
				{
				'techOrder': videoParams.tech,
				'controls': true,
				'autoplay': true,
				'preload': 'none',
				'width':width,
				'height':height
				},
				function() {}
			);
		player.src(rtmp);
  }
    
  function testPlay() {
	  videoParams = {
	            link: rtmp, 
	            type: 'rtmp/flv', 
	            tech: [ 'flash' ] };
	  player = new videojs( '#example_video_1', 
				{
				'techOrder': videoParams.tech,
				'controls': true,
				'autoplay': true,
				'preload': 'none',
				'width':width,
				'height':height
				},
				function() {}
			);
	  player.src(rtmp);
      player.load();
	  player.play();
  }
 /*  function testpause() {
  	var player = new videojs('#example_video_1', {}, function() {});
  	player.dispose();
  	player=null;
  } */
  function testpause() {
  	if(player.paused){
  		player.src(rtmp);
      	player.load();
      	player.play();
  	} else {
  		player.src(rtmp);
      	player.load();
      	player.pause();
  	}
  }
	/* 
	var width = document.body.clientWidth - 2;
	var height = document.body.clientHeight - 2;
	var div = document.getElementById("example_video_1");
	div.width = width;
	div.height = height; */
	
	//每5分钟重新加载一次播放器
	var interval4=setInterval(function(){
		location.reload();
	 },300000);
  </script>
</html>
