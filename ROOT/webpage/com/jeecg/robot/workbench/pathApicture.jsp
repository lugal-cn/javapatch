<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>热成像图片</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<t:base type="bootstrap,layer,validform,webuploader,bootstrap-form"></t:base><t:base type="tools"></t:base>
<style type="text/css">
    .main_div{
        margin: auto;
        text-align: center;
    }
    .pic_div{
        position: relative;
        background-color: white;
        border: 0px dotted red;
        margin: 10px auto;
        width: 98%;
        height: 98%;
    }
    img{
        width: 100%;
        height: auto;
    }
</style>
<script type="text/javascript">
    function bigit(){
        var image=document.getElementsByClassName("pic")[0];
        image.style.height=image.height*1.1+'px';
        image.style.width=image.width*1.1+'px';
    }
    function littleit(){
        var image=document.getElementsByClassName("pic")[0];
        image.style.height=image.height/1.1+'px';
        image.style.width=image.width/1.1+'px';
    }
    
    var scrollFunc = function (e) {
        var direct = 0;
        e = e || window.event;
        if (e.wheelDelta) {  //判断浏览器IE，谷歌滑轮事件            
            if (e.wheelDelta > 0) { //当滑轮向上滚动时
                bigit();
            }
            if (e.wheelDelta < 0) { //当滑轮向下滚动时
                littleit();
            }
        } else if (e.detail) {  //Firefox滑轮事件
            if (e.detail> 0) { //当滑轮向上滚动时
                bigit();
            }
            if (e.detail< 0) { //当滑轮向下滚动时
                littleit();
            }
        }
        //ScrollText(direct);
    }
    //给页面绑定滑轮滚动事件
    if (document.addEventListener) {
        document.addEventListener('DOMMouseScroll', scrollFunc, false);
    }
    //滚动滑轮触发scrollFunc方法
    window.onmousewheel = document.onmousewheel = scrollFunc; 
</script>
</head>
 <body>
<div  style="" class="main_div">
        <div class="pic_div">
            <img src="${pathApicture}" class="pic">
        </div>
    </div>
</body>
</html>