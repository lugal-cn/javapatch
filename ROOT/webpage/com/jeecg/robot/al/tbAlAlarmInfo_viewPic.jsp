<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>机房列表</title>
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
        background-color: pink;
        border: 1px dotted red;
        margin: 10px auto;
        width: 98%;
        height: 98%;
    }
    img{
        width: 100%;
        height: 100%;
    }

</style>
<script type="text/javascript">

   /*  function bigit(){
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
    window.onmousewheel = document.onmousewheel = scrollFunc;  */
</script>
</head>
 <body>
<div  style="" class="main_div">

        <div class="pic_div">
            <img src="${tbAlAlarmMenvironment.equipmentTemperatureUrl}" class="pic">
        </div>
    </div>
    
<%-- <div align="center">
	<img src="<%=request.getContextPath() %>/upload/Teacher/pic3345280233.PNG"
		 style="width: 95%; height: 95%; object-fit: cover;padding-top: 2%; 
		 transform:scaleX(0.5) scaleY(0.5);"/>
</div> --%>
<!-- </div>  -->
 <%-- <div class="container" style="width:100%;">
	<div class="panel-heading"></div>
	<div class="panel-body">
	<form class="form-horizontal" role="form" id="formobj" action="tbCrComputerRoomController.do?doAdd" method="POST">
		<input type="hidden" id="btn_sub" class="btn_sub"/>
		<input type="hidden" id="id" name="id"/>
		<div class="form-group">
			<label for="computerRoomName" class="col-sm-3 control-label">机房名称：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<input id="computerRoomName" name="computerRoomName" type="text" maxlength="200" class="form-control input-sm" placeholder="请输入机房名称"  datatype="*"  ignore="checked" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="mapUrl" class="col-sm-3 control-label">地图存储路径：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
				<t:webUploader name="mapUrl" outJs="true" auto="true" showImgDiv="filediv_mapUrl" type="image" buttonText='添加地图' displayTxt="false" datatype="*"></t:webUploader>
				<div class="form" id="filediv_mapUrl"></div>
				</div>
			</div>
		</div>
	</form>
	</div>
 </div> --%>
 
<script type="text/javascript">
var subDlgIndex = '';
$(document).ready(function() {
	//单选框/多选框初始化
	$('.i-checks').iCheck({
		labelHover : false,
		cursor : true,
		checkboxClass : 'icheckbox_square-green',
		radioClass : 'iradio_square-green',
		increaseArea : '20%'
	});
	
	//表单提交
	$("#formobj").Validform({
		tiptype:function(msg,o,cssctl){
			if(o.type==3){
				validationMessage(o.obj,msg);
			}else{
				removeMessage(o.obj);
			}
		},
		btnSubmit : "#btn_sub",
		btnReset : "#btn_reset",
		ajaxPost : true,
		beforeSubmit : function(curform) {
		},
		usePlugin : {
			passwordstrength : {
				minLen : 6,
				maxLen : 18,
				trigger : function(obj, error) {
					if (error) {
						obj.parent().next().find(".Validform_checktip").show();
						obj.find(".passwordStrength").hide();
					} else {
						$(".passwordStrength").show();
						obj.parent().next().find(".Validform_checktip").hide();
					}
				}
			}
		},
		callback : function(data) {
			var win = frameElement.api.opener;
			if (data.success == true) {
				frameElement.api.close();
			    win.reloadTable();
			    win.tip(data.msg);
			} else {
			    if (data.responseText == '' || data.responseText == undefined) {
			        $.messager.alert('错误', data.msg);
			        $.Hidemsg();
			    } else {
			        try {
			            var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
			            $.messager.alert('错误', emsg);
			            $.Hidemsg();
			        } catch (ex) {
			            $.messager.alert('错误', data.responseText + "");
			            $.Hidemsg();
			        }
			    }
			    return false;
			}
		}
	});
		
});
</script>
</body>
</html>