<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>机房地图</title>
    <style type="text/css">
		body{
	    	width:auto;
	    }
		.pic_div{
	        position: absolute;
	        background-color: white;
	        border: 0px dotted;
	        margin: 10px auto;
	    }
	    .pic{
	        width: 100%;
	        height: auto;
	    }
	    .robot_div{
	        position: absolute;
	        padding: 10px 0px 0px 0px;
	        height: auto;
	        background-color:rgba(0,38,38,0.2);
	        right:10px;
	        bottom: 20px;
	    }
	</style>
 	<script type="text/javascript">
 		var patrol_point_no;
 		//设置机房动环数据
 		function setRobotInfo(data) {
 			var text = "";
 			if(data.temperature_text && data.temperature_value) {
 				text += data.temperature_text + ":" + data.temperature_value + "℃<br/>";
 			}
 			if(data.humidity_text && data.humidity_value) {
 				text += data.humidity_text + ":" + data.humidity_value + "%<br/>";
 			}
 			if(data.noise_text && data.noise_value) {
 				text += data.noise_text + ":" + data.noise_value + "dB<br/>";
 			}
 			if(data.pm25_text && data.pm25_value) {
 				text += data.pm25_text + ":" + data.pm25_value + "μg/m3<br/>";
 			}
 			if(data.pollution_gas_text && data.pollution_gas_value) {
 				text += data.pollution_gas_text + ":" + data.pollution_gas_value + "PPM<br/>";
 			}
 			/* if(data.equipment_temperature_text && data.equipment_temperature_value) {
 				text += data.equipment_temperature_text + ":" + data.equipment_temperature_value + "℃<br/>";
 			} */
 			if(data.patrol_point_no) { //机器人当前所在点位
 				patrol_point_no = data.patrol_point_no;
 				var idObject = document.getElementById('div'+patrol_point_no);
 				if(idObject){
 					idObject.style.background = 'url(<%=request.getContextPath() %>/images/u6077.png)';
 					idObject.style.backgroundSize = "contain";
 				}
 				loadPoint();//重新加载点位
 			}
 			$("#robot_info").html(text);
 		}
 	</script>
  </head>
  <body marginwidth="0px" marginheight="0px">
  <div id="sitePanel" region="center" title="" style="width:500px;height: 98%;" class="easyui-panel">
	<c:if test="${mapUrl != null}">
	    <div id="dv2" class="pic_div" style="height: 90%; z-index: 1;" >
	        <img id="SmallLiuYiFeiImg" src="${mapUrl}" class="pic">
	    </div>
	    <div id="robot_div" class="robot_div" style="z-index: 2;" >
			<pre id="robot_info"></pre>
	    </div>
    </c:if>
    </div>
  </body>
  <script type="text/javascript">
 		//加载机房巡检点坐标
 		function loadPoint() {
 			var patrolPointNo;
 		 	var x;
 		 	var y;
 		 	var div;
 		 	var image=document.getElementById("SmallLiuYiFeiImg");
 			var imageheight = image.height;
 			var imagewidth = image.width;
 			<c:forEach items="${lstMap}" var="item" varStatus="status" >  
	 		   var temp = "${item}";
	 		   patrolPointNo = "${item.patrol_point_no}";
	 		    x = "${item.x_coordinate}";
		 		y = "${item.y_coordinate}";
		 		xrate = "${item.x_rate}";
		 		yrate = "${item.y_rate}";
				if(xrate && yrate){
					/* console.log("x="+x+"-y="+y);
					console.log("xrate="+xrate+"-yrate="+yrate);
					console.log("imagewidth="+imagewidth+"-imageheight="+imageheight); */
					var xtmp = (30*(parseFloat(imagewidth)/(parseFloat(x)/parseFloat(xrate)))).toFixed(0);
					var ytmp = (30*(parseFloat(imageheight)/(parseFloat(y)/parseFloat(yrate)))).toFixed(0);
					x = parseFloat(imagewidth)*parseFloat(xrate)-(30-xtmp)/2;
			 		y = parseFloat(imageheight)*parseFloat(yrate)+(30-ytmp)/2;
			 		//console.log("xtmp="+xtmp+"-ytmp="+ytmp);
			 		//删除div 重新加载机器人图标
			 		var idObject = document.getElementById('div'+patrolPointNo);
			 	    if (idObject != null) {
			 	          idObject.parentNode.removeChild(idObject);
			 	    }
			 		div = document.createElement('div');
					div.id = 'div'+patrolPointNo;
					div.style.position = 'absolute';
			        div.style.left = x + 'px';
					div.style.top = y + 'px';
					div.style.zIndex = 2;
					div.style.width = xtmp+'px';
					div.style.height = ytmp+'px';
					if(patrol_point_no == patrolPointNo) {
						div.style.background = 'url(<%=request.getContextPath() %>/images/u6077.png) no-repeat center';
						div.style.backgroundSize = "contain";
					} else {
						div.style.background = 'url(<%=request.getContextPath() %>/images/u6079.png) no-repeat center';
						div.style.backgroundSize = "contain";
					}
					document.getElementById('sitePanel').appendChild(div);
				} else {
					
				}
	 		</c:forEach>
 		 } 
 		//图片加载成功触发事件
 		if(SmallLiuYiFeiImg) {
 			SmallLiuYiFeiImg.onload = function () {
 	 	       loadPoint();
 	 	    }
 		}
 	</script>
</html>
