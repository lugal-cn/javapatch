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
	<link href="http://vjs.zencdn.net/5.20.1/video-js.css" rel="stylesheet">
    <!-- <script src="http://vjs.zencdn.net/5.20.1/videojs-ie8.min.js"></script> -->
	<style type="text/css">
	</style>
	<script type="text/javascript">
	
	
	<%--  videojs.options.flash.swf = "<%=basePath%>/plug-in/ueditor/third-party/video-js/video-js.swf";
	
	//初始化视频，设为全局变量
    var myPlayer = videojs('rtmpVideo', {
        autoplay: true,
        controls: true,//控制条
        poster: "/images/camera/playStop.png",
        techOrder: ["flash"],
        muted: true,// 静音
        preload: "auto",// 预加载
        language: "zh-CN",// 初始化语言
        playbackRates: [1, 2, 3, 4, 5, 8, 10, 20]// 播放速度
    }, function () {
        console.log("--------------成功初始化视频--------------");
        myPlayer.one("playing", function () {         // 监听播放
            console.log("开始播放");
        });
        myPlayer.one("error", function (error) {      // 监听错误
            console.error("监听到异常，错误信息：%o",error);
        });
    });  --%>

	</script>
  </head>
   
  <body style="text-align:center;">
   	 <video id="example_video_1" class="video-js vjs-default-skin" controls preload="auto" width="750px" height="350px" data-setup="{}" style="text-align:center;">
	  <source src="${fileUrl}" type="video/mp4" />
	</video>
	<script src="http://vjs.zencdn.net/5.20.1/video.js"></script>  
  </body>
</html>
