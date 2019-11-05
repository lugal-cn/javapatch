<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
/* $('#seepicture').bind('click', function(){ 
	
}); */
function seepicture(){
openwindow('查看图片', 'tbPaPatrolTaskController.do?seePicture', 'tbPaPatrolTaskController.do?seePicture',600,400);
}
//对右边的图片做处理
function jiaoyan(obj){
	var robotInfoId='${robotInfoId}'
	var idnum=obj.id.split("[")[1];
	idnum=idnum.split("]")[0];//下标
	el=document.getElementById("ck["+idnum+"]");
	var	 patrolPointsNo=document.getElementById("TbPaPatrolPointsEntity["+idnum+"].patrolPointsNo").value;
	var x,y;
	if(el.checked){//true   flase  添加图片
	 	var objs = document.getElementsByName("TbPaPatrolPointsEntity["+idnum+"].execAction");
		for(var i=0;i<objs.length;i++){
	        $("#"+objs[i].id).attr("datatype","need1");
	    } //上部分是控制选中行的执行东东至少要选中一个   Math.round(Math.random()*1000) +
		$.ajax({
			url:'tbPaPatrolTaskController.do?getRobotsInfoXY&robotsInfoId='+robotInfoId+'&patrolPointsNo='+patrolPointsNo,
			type:'GET',
			dataType:'JSON',
			async:false, 
			delay: 250,
			cache: true,
			success: function(data){
					for(var i=0;i<data.length;i++){
						x=data[i].xCoordinate;
						y=data[i].yCoordinate;
						
						//删除之前的
						var idObject = document.getElementById('div'+patrolPointsNo);//巡检计划时div是巡检任务的id
		 	    		if (idObject != null) {
		 	       			   idObject.parentNode.removeChild(idObject);
		 	    			}
		 	    		//添加现在的坐标点
		 		 	   var div = document.createElement('div');
		 				div.id = 'div'+patrolPointsNo;
		 				div.style.position = 'absolute';
		 		        div.style.left = x + 'px';
		 				div.style.top = y + 'px';
		 				div.style.zIndex = 2;
		 				div.style.width = '30px';
		 				div.style.height = '30px';
		 				div.style.background = 'url(<%=request.getContextPath() %>/images/u6079.png)';
		 				document.getElementById('sitePanel').appendChild(div);
					}
				}
			});
	 }else{//删除图片
		//删除之前的
		var idObject = document.getElementById('div'+patrolPointsNo);//巡检计划时div是巡检任务的id
  		if (idObject != null) {
     		idObject.parentNode.removeChild(idObject);
  		}
	 } 
} 
</script>
<!-- <div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addJformOrderCustomerBtn" href="#">添加</a> <a id="delJformOrderCustomerBtn" href="#">删除</a> 
</div> -->
<table border="0" cellpadding="2" cellspacing="0" id="jformOrderCustomer_table" align="center">
	<tr bgcolor="#E6E6E6">
		<!-- <td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td> -->
		<td align="center" bgcolor="#EEEEEE" style="width: 40px;">操作</td>
		  <td align="center" bgcolor="#EEEEEE" style="width: 60px;">
				点编号
		  </td>
		  <td align="center" bgcolor="#EEEEEE" style="width: 80px;">
				机柜类型
		  </td>
		  <td align="center" bgcolor="#EEEEEE" style="width: 80px;">
				机柜编号
		  </td>
		  <td align="center" bgcolor="#EEEEEE" style="width: 60px;">
				点类型
		  </td>
		  <td align="center" bgcolor="#EEEEEE" style="width: 300px;">
				执行动作
		  </td>
		  <!-- <td align="center" bgcolor="#EEEEEE" style="width: 70px;">
				设备图片
		  </td> -->
	</tr>
	<tbody id="add_jformOrderCustomer_table">
	<c:if test="${fn:length(TbPaPatrolPointsEntity)  > 0 }">
		<c:forEach items="${TbPaPatrolPointsEntity}" var="poVal" varStatus="stuts">
			<tr id="tasktr[${stuts.index }]">			
				<td align="center" hidden><div style="width: 40px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center" id="cktd[${stuts.index }]"><input style="width:20px;"   type="checkbox" id="ck[${stuts.index }]" name="ck[${stuts.index }]" onchange="jiaoyan(this);"  /></td>
						<input name="TbPaPatrolPointsEntity[${stuts.index }].id" id="id[${stuts.index }]" type="hidden" value="${poVal.id }"/>
						<input name="TbPaPatrolPointsEntity[${stuts.index }].ckk" id="ckk[${stuts.index }]" name="ckk[${stuts.index }]" type="hidden" value="${poVal.ck }"/>
						<input name="TbPaPatrolPointsEntity[${stuts.index }].robotsInfoId" type="hidden" value="${poVal.robotsInfoId }"/>
				   <td align="center"  style="width: 60px;" id="patrolPointsNo[${stuts.index }]">
					       	<input style="width: 100%;text-align:center; border: none;" id="TbPaPatrolPointsEntity[${stuts.index }].patrolPointsNo" name="TbPaPatrolPointsEntity[${stuts.index }].patrolPointsNo" maxlength="32" type="text" readonly class="inputxt"  style="width:80px;"  ignore="ignore"  value="${poVal.patrolPointNo  }"/>
					 		<label class="Validform_label" style="display: none;">点编号</label>
				   </td>
				   <td align="center" style="width: 80px;">
				  		 <input style="width: 100%;text-align:center; border: none;" id="TbPaPatrolPointsEntity[${stuts.index }].cabineType" name="TbPaPatrolPointsEntity[${stuts.index }].cabineType" maxlength="32" type="text" readonly class="inputxt"  style="width:80px;"  ignore="ignore"  value="${poVal.cabineType  }"/>
					  	<t:dictSelect extendJson="width:80px" field="TbPaPatrolPointsEntity[${stuts.index }].cabineType"   type="text"  datatype="*" readonly="readonly"  typeGroupCode="itacs_cabinetType"  defaultVal="${poVal.cabineType }" hasLabel="false"  title="点类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">机柜类型</label>
				   </td>
				   <td align="center" style="width: 80px;">
				  	 <input style="width: 100%;text-align:center; border: none;" name="TbPaPatrolPointsEntity[${stuts.index }].cabineNo" maxlength="32" type="text" class="inputxt" readonly   ignore="ignore"  value="${poVal.cabineNo }"/>
					  <label class="Validform_label" style="display: none;">机柜编号</label>
				   </td>
				   <td align="center" style="width: 60px;">
				    <input style="width: 100%;text-align:center; border: none;" id="TbPaPatrolPointsEntity[${stuts.index }].patrolPointType" name="TbPaPatrolPointsEntity[${stuts.index }].patrolPointType" maxlength="32" type="text" readonly class="inputxt"  style="width:80px;"  ignore="ignore"  value="${poVal.patrolPointType  }"/>
				   <t:dictSelect field="TbPaPatrolPointsEntity[${stuts.index }].patrolPointType" type="text"   readonly="readonly"  datatype="*"   typeGroupCode="itacs_pointType"  defaultVal="${poVal.patrolPointType }" hasLabel="false"  title="点类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">点类型</label>
				   </td>
				   <td align="center"  style="width: 300px;">
				   	  <t:dictSelect id="abc${stuts.index }" field="TbPaPatrolPointsEntity[${stuts.index }].execAction" type="checkbox"    typeGroupCode="itacs_executionAction"  defaultVal="${poVal.executionAction }" hasLabel="false"  title="执行动作"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">执行动作</label>
					</td>
					<%-- <td align="center" style="width: 70px;">
						<!-- <a href="javascript:;" id="seepicture" onclick="alert('11');   " >查看</a> -->
						<!-- <button onclick="seepicture()">查看</button> -->
						<a  style="width: 100%;" id="seepicture" href="javascript:void(0);" onclick="seepicture()">查看</a>
						 <label class="Validform_label" style="display: none;">设备图片</label>
					</td> --%>
   			</tr>
		</c:forEach>
	</c:if>	 
	</tbody>
</table>
<script type="text/javascript">
/*-------------------------------------------根据机器人的id查询该机器人的巡检点信息----------------------------------------------*/
//回显操作列是否选中
for(var i=0;i<${patrolPointsnum};i++){
	var ck=document.getElementById("ckk["+i+"]").value;
	if(ck && ck=="1"){
		document.getElementById("ck["+i+"]").checked=true;
	}
}
</script>
