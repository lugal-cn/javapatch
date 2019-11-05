<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>定点巡检</title>
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
	    
	     .tablepp{
	        padding-left: 20px;
	        padding-top: 10px;
	        overflow: auto;
	        display: inline-block;
	        width: 95%;
	        max-height: 90%;
	        height: 86%;
	    }
	    .tablepp tr{
	        height: 30px;
	    }
	    .tablepp tr td{
	        border-right: 1px solid #000;
	        border-bottom: 1px solid #000;
	        height: 20px;
	    }
	
	</style>
    <script type="text/javascript">
    var createName='${createName}'
    var taskId = '${taskId}';
    var requrl = '${requrl}';
    var robotId = '${robotId}';
	
	//查看图片
	function seepicture() {
		add('查看图片', 'tbPaPatrolTaskController.do?seePicture', 'tbPaPatrolTaskController.do?seePicture');
	}
	$(document).ready(function () {
		var xcoordinates = $('input[name="xcoordinate"]');
		var ycoordinates = $('input[name="ycoordinate"]');
		var patrolPointNos = $('input[name="patrolPointNo"]');
	 	for(var i=0;i<xcoordinates.length;i++) {
	 		var patrolPointNo = patrolPointNos[i].value;
	 		var x = xcoordinates[i].value;
	 		var y = ycoordinates[i].value;
	 		//删除div 重新加载机器人图标
	 		var idObject = document.getElementById('div'+patrolPointNo);
	 	    if (idObject != null) {
	 	          idObject.parentNode.removeChild(idObject);
	 	    }
	 		var div = document.createElement('div');
			div.id = 'div'+patrolPointNo;
			div.style.position = 'absolute';
	        div.style.left = x + 'px';
			div.style.top = y + 'px';
			div.style.zIndex = 2;
			div.style.width = '30px';
			div.style.height = '30px';
			div.style.background = 'url(<%=request.getContextPath() %>/images/u6079.png)';
			document.getElementById('sitePanel').appendChild(div);
	 	}
	});
	
	//立即巡检
	function doFixedPatrol() {
		//获取选中巡检点数据
		var data = {interfaceNo:"fixedPointsTask", "Task_Id":taskId, "Create_Name":createName , "Pois":[] , robotId:robotId};
        var arra = $('input[name="ck"]');
        var cabineType=$('input[name="cabineType"]');
        if(arra) {
        	for (var i = 0; i < arra.length; i++) {
        		if(arra[i].checked) {
        			var poisobj = {};
        			poisobj.Point_Name = arra[i].value;
        			var ca=cabineType[i].value;
        		if(ca==undefined){
        			poisobj.Rack_Num=0;
        		}else{
        			poisobj.Rack_Num=1;
        		}
        			if(cabineType!=null){
        				poisobj.Rack_Num=1;
        			}else{
        				poisobj.Rack_Num=0;
        			}
        			var actName = "execAction" + i;
        			var execActions = $('input[name='+actName+']');
        			if(execActions[0].checked) {
        				poisobj.Is_OpenDoor = "1";
        			} else {
        				poisobj.Is_OpenDoor = "0";
        			}
        			if(execActions[2].checked) {
        				poisobj.Is_Sensor = "1";
        			} else {
        				poisobj.Is_Sensor = "0";
        			}
        			if(execActions[1].checked) {
        				poisobj.Is_Photo = "1";
        			} else {
        				poisobj.Is_Photo = "0";
        			}
        			if(execActions[3].checked) {
        				poisobj.Is_Voice = "1";
        			} else {
        				poisobj.Is_Voice = "0";
        			}
        			if(execActions[4].checked) {
        				poisobj.Is_CloseDoor = "1";
        			} else {
        				poisobj.Is_CloseDoor = "0";
        			}
        			data.Pois.push(poisobj);
        		} 
        		else {
        		}
        	}
        }
        var msg = "";
        var msgType = "";
		$.ajax({
			url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
			type : 'post',
			data: JSON.stringify(data),
			datatype:'json',
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				if(d) {
					if (d.ErrorNo == '0') {
						msg = "定点巡检执行下发成功";
						msgType = "01";
					} else if(d.ErrorNo == '-1') {
						msg = "定点巡检执行下发失败";
						msgType = "03";
					} else if(d.ErrorNo == '1') {
						msg = "定点巡检执行下发警告"+d.Message;
						msgType = "02";
					} else if(d.ErrorNo == '2') {
						msg = "定点巡检执行弹出确认中";
						msgType = "01";
					} else {
						//其他
						msg = "定点巡检执行下发失败";
						msgType = "03";
					}
				
				} else {
					
					if (data.ErrorNo == '0') {
						msg = "定点巡检执行下发成功";
					} else if(data.ErrorNo == '-1') {
						msg = "定点巡检执行下发失败";
					} else if(data.ErrorNo == '1') {
						msg = "定点巡检执行下发执行中";
					} else if(data.ErrorNo == '2') {
						msg = "定点巡检执行弹出中";
					} else {
						//其他
						msg = "定点巡检执行下发失败";
					}
					
					
				}
				//调用机器人信息页面 添加通知方法
				window.parent.frames['tab_home'].frames['iframe_robotsinfo'].addNoticeMsg(msgType,msg);
				//关闭页签
				docancel();
			}
		});
	}
	
	//取消
	function docancel() {
		var tabId = '${tabId}';
		window.top.closeTab("tab_"+tabId);
		/* var aobj = window.top.$("a[data-id='"+requrl+"']");
		window.top.closePage2(aobj); */
	}
	
	</script>
  </head>
  
  <body>
    <div class="easyui-layout" fit="true" style="width:100%;height:90%;">
    	<div region="west" split="true" title="" style="width:600px;">
			<t:formvalid formid="formobj" dialog="true"  layout="table" tiptype="1" action="tbPaPatrolTaskController.do?doUpdate">	
				<input type="hidden" id="btn_sub" class="btn_sub"/>
				<input type="hidden" id="id" name="id" value="${tbPaPatrolTask.id}"/>
				<div style="width: auto;height: auto;" >
					<div style="width: 98%; padding-top: 10px; padding-left: 10px;">
				  		<label style="font-size: 15px;">选择巡检点：</label>
				 	</div>
					<table border="0" cellpadding="2" cellspacing="0" id="jformOrderCustomer_table" align="center"
						class="tablepp">
						<tr>
							<td align="center" style="width: 30px;border-left: 1px solid #000;border-top: 1px solid #000;">操作</td>
						  	<td align="center" style="width: 60px;border-top: 1px solid #000;"">
								点编号
						  	</td>
						  	<td align="center" style="width: 80px;border-top: 1px solid #000;"">
								机柜类型
						  	</td>
						  	<td align="center" style="width: 60px;border-top: 1px solid #000;"">
								机柜编号
						  	</td>
						  	<td align="center" style="width: 380px;border-top: 1px solid #000;"">
								执行动作
						  	</td>
						  <!-- 	<td align="center" style="width: 80px;border-top: 1px solid #000;"">
								设备图片
						  	</td> -->
						</tr>
						<tbody id="add_jformOrderCustomer_table">
						<c:if test="${fn:length(patrolPoint)  > 0 }">
							<c:forEach items="${patrolPoint}" var="poVal" varStatus="stuts">
								<tr id="tasktr[${stuts.index }]">
									 <td align="center" id="cktd[${stuts.index }]" style="width: 30px;border-left: 1px solid #000;">
									 	<input type="hidden" name="xcoordinate" value="${poVal.xcoordinate }"/>
									 	<input type="hidden" name="ycoordinate" value="${poVal.ycoordinate }"/>
									 	<input type="hidden" name="cabineType" value="${poVal.cabineType}"/>
									 	<input type="hidden" name="patrolPointNo" value="${poVal.patrolPointNo }"/>
									 	<input type="checkbox" id="ck[${stuts.index }]" name="ck" value="${poVal.patrolPointNo }"/>
								 	</td>
									   <td align="center"  style="width: 60px;" id="patrolPointsNo[${stuts.index }]">
										 	<label>${poVal.patrolPointNo }</label>
									   </td>
									   <td align="center" style="width: 80px;" id="cabineType">
										  <label>${poVal.cabineType }</label>
									   </td>
									   <td align="center" style="width: 60px;">
										  <label>${poVal.cabineNo}</label>
									   </td>
									   <td align="center"  style="width: 380px;">
									   	  <t:dictSelect id="execAction${stuts.index }" field="execAction${stuts.index }" type="checkbox" typeGroupCode="itacs_executionAction"></t:dictSelect>     
										</td>
										<!-- <td align="center" style="width: 80px;">
											<a id="seepicture" href="javascript:void(0);" onclick="seepicture()">查看</a>
										</td> -->
					   			</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
				</div>	
			</t:formvalid>
			<div style="width: 98%; padding-bottom:10px; text-align: center;">
		  		<input type="button" value="加入任务队列" class="ace_button" onclick="doFixedPatrol()" style="margin-right:25px">
		        <input type="button" value="取消" class="ace_button" onclick="docancel()" style="margin-right:25px">
		 	</div>
		</div>
	    <div region="center" title="" style="width:500px;" id="sitePanel" class="easyui-panel">
	    	<div id="dv2" class="pic_div" style="height: 94%; z-index: 1;" >
	            <img id="SmallLiuYiFeiImg" src="${mapUrl}" class="pic">
	        </div>
	    </div>
	</div>
  </body>
</html>
