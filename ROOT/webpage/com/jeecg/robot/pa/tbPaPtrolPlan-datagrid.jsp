<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
$('#addJformGraphreportItemBtn').linkbutton({   
    iconCls: 'icon-add'  
});  
$('#delJformGraphreportItemBtn').linkbutton({   
    iconCls: 'icon-remove'  
}); 
$('#addJformGraphreportItemBtn').bind('click', function(){   
	var tr =  $("#add_jformGraphreportItem_table_template tr").clone();
 	 $("#add_jformGraphreportItem_table").append(tr);
 	 resetTrNum('add_jformGraphreportItem_table');
 	$tbody = $("#add_jformGraphreportItem_table");
 	var k=0;
	$tbody.find('>tr').each(function(i){
		if(i!=null){
			k++
		}
	});
	setPatrolTask(k-1);
 	 return false;
});  
$('#delJformGraphreportItemBtn').bind('click', function(){   
	var length=$("#add_jformGraphreportItem_table").find("input:checked").parent().parent().
	children('td').children('select').length;//这个地方是每列有多少数据就有多少个长度，再乘上多列
	var selectId="";
	for(var i=0;i<length;i=i+3){
		  selectId=$("#add_jformGraphreportItem_table").find("input:checked").parent().parent().
		children('td').children('select')[i].value;//任务id
		var robotsInfo='${robotsInfo}';
		//删除div 重新加载机器人图标     删除之前的坐标点
		$.ajax({
			url:'tbPaPatrolPlanController.do?getRobotsInfoXY&robotsInfoId='+robotsInfo+'&patrolTaskId='+selectId,
			type:'GET',
			dataType:'JSON',
			async:false, 
			delay: 250,
			cache: true,
			success: function(data){
				for(var j = 0; j < data.length; j++){
					//删除div 重新加载机器人图标     删除之前的坐标点
			 		var idObject = document.getElementById('div'+selectId+j);//巡检计划时div是巡检任务的id
			 	    if (idObject != null) {
			 	          idObject.parentNode.removeChild(idObject);
			 	    }
				}
			}
		});
	}
  	 $("#add_jformGraphreportItem_table").find("input:checked").parent().parent().remove();  
    resetTrNum('add_jformGraphreportItem_table');  
    return false;
}); 

//设置巡检任务下拉选择
function setPatrolTask (k) {
	var id = 'TbPaPatrolPlanTaskEntity['+k+'].patrolTaskIds';
	/*-------------------------------------------所属机器人下的任务----------------------------------------------*/
	var select2Data = new Array();
	$.ajax({
		url:"tbPaPatrolTaskController.do?patrolTaskSelect&robotsInfoId="+'${robotsInfo}',
		type:'GET',
		dataType:'JSON',
		delay: 250,
		cache: true,
		success: function(data){
			var obj = $("#"+id);
			document.getElementById(id).options.add(new Option("请选择","")); 
			for(var i = 0; i < data.length; i++){
				document.getElementById(id).options.add(new Option(data[i][1],data[i][0])); 
			} 
		}
	});
	/*-------------------------------------------所属机器人下的任务----------------------------------------------*/
}
$(document).ready(function(){
	$(".datagrid-toolbar").parent().css("width","auto");
	if(location.href.indexOf("load=detail")!=-1){
		$(":input").attr("disabled","true");
		$(".datagrid-toolbar").hide();
	}
	var id = "TbPaPatrolPlanTaskEntity[0].patrolTaskIds";
	/*-------------------------------------------所属机器人下的任务----------------------------------------------*/
	var select2Data = new Array();
	$.ajax({
		url:"tbPaPatrolTaskController.do?patrolTaskSelect&robotsInfoId="+'${robotsInfo}',
		type:'GET',
		dataType:'JSON',
		delay: 250,
		cache: true,
		success: function(data){
			document.getElementById(id).options.add(new Option("请选择","")); 
			for(var i = 0; i < data.length; i++){
				document.getElementById(id).options.add(new Option(data[i][1],data[i][0])); 
			} 
		}
	});
	/*-------------------------------------------所属机器人下的任务----------------------------------------------*/
	
	//将表格的表头固定
    $("#jformGraphreportItem_table").createhftable({
    	height:'300px',
		width:'auto',
		fixFooter:false
		});
});

var k=0;
function chengepatrolTaskId(obj) {
	var robotsInfo='${robotsInfo}';
	var id = obj.id;
	var inpId = id.substring(0,id.length-1);
	var idNum=id.split('[')[1];
	idNum=idNum.split(']')[0];//当前行的序号
	var x,y;
	if(k>idNum){
	}else{
		k=idNum;
	}
	for(var i=0;i<k;i++){
		var beforPatrolPointsNo=document.getElementById(inpId.split('[')[0]+'['+i+']'+inpId.split(']')[1]).value;
			 /* if(obj.value===beforPatrolPointsNo){  *///有相同的，提示不能选
				//选重复，删除之前选中的
				$.ajax({
					url:'tbPaPatrolPlanController.do?getRobotsInfoXY&robotsInfoId='+robotsInfo+'&patrolTaskId='+document.getElementById(id.substring(0,id.length-1)).value,
					type:'GET',
					dataType:'JSON',
					async:false, 
					delay: 250,
					cache: true,
					success: function(data){
						for(var i = 0; i < data.length; i++){
							//删除div 重新加载机器人图标     删除之前的坐标点
					 		var idObject = document.getElementById('div'+document.getElementById(id.substring(0,id.length-1)).value+i);//巡检计划时div是巡检任务的id
					 	    if (idObject != null) {
					 	          idObject.parentNode.removeChild(idObject);
					 	    }
						}
					}
				});
				 /* obj.value="";
				document.getElementById(id.substring(0,id.length-1)).value=obj.value;
				tip("已经选过了,请重选");  */
				//return;
			/* } */
		
	}//控制下拉选项不能选相同的
	var oldPatrolPointsNo=document.getElementById(inpId).value;
	document.getElementById(inpId).value=obj.value;
	var patrolPointsNo=document.getElementById(inpId).value;
	//查询出选中的巡检点的x,y坐标
	var patrolPointsNoMap = new Array();
	$.ajax({
	url:'tbPaPatrolPlanController.do?getRobotsInfoXY&robotsInfoId='+robotsInfo+'&patrolTaskId='+patrolPointsNo,
	type:'GET',
	dataType:'JSON',
	async:false, 
	delay: 250,
	cache: true,
	success: function(data){
			for(var i = 0; i < data.length; i++){
				x=data[i].xCoordinate;
				y=data[i].yCoordinate;
				
				//删除div 重新加载机器人图标     删除之前的坐标点
		 		var idObject = document.getElementById('div'+oldPatrolPointsNo+i);//巡检计划时div是巡检任务的id
		 	    if (idObject != null) {
		 	          idObject.parentNode.removeChild(idObject);
		 	    }
				//添加现在的坐标点
		 	   var div = document.createElement('div');
				div.id = 'div'+patrolPointsNo+i;
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
}
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addJformGraphreportItemBtn" href="javascript:void(0);">添加</a> <a id="delJformGraphreportItemBtn" href="javascript:void(0);">删除</a>
</div>

<div style="width: auto; height: 300px; overflow-y: hidden; overflow-x: scroll;">
<table border="0" cellpadding="2" cellspacing="0" id="jformGraphreportItem_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td>
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">操作</td>
		<td align="center" bgcolor="#EEEEEE">巡检任务</td>
		<td align="center" bgcolor="#EEEEEE" colspan="2">开始时间</td>
	</tr>
	<tbody id="add_jformGraphreportItem_table">
	<c:if test="${fn:length(tbPaPatrolPlan)  <= 0 }">
			<tr>
				 <td align="center"><div style="width: 25px;" name="xh">1</div></td> 
				<td align="center" id="ckid[0]"><input style="width:20px;"  type="checkbox" name="ck"/></td>
				  <td align="center">
					  	<input type="hidden" id="TbPaPatrolPlanTaskEntity[0].patrolTaskId" name="TbPaPatrolPlanTaskEntity[0].patrolTaskId">
					  	<select  name="patrolTaskIds" id="TbPaPatrolPlanTaskEntity[0].patrolTaskIds" onchange="chengepatrolTaskId(this)" ></select>
					  <label class="Validform_label" style="display: none;">巡检任务</label>
				  </td>
				  <td align="center">
				  	<input type="text"  name="TbPaPatrolPlanTaskEntity[0].startTime" id="TbPaPatrolPlanTaskEntity[0].startTime" class="Wdate" 
				  	style="width: 80%;" onClick="WdatePicker({qsEnabled:false,dateFmt:'HH'})" >
					  	  <%-- <t:dictSelect field="TbPaPatrolPlanTaskEntity[0].startTime" type="select" typeGroupCode="itacs_startHours" hasLabel="false" datatype="*"></t:dictSelect> --%>时  
					  <label class="Validform_label" style="display: none;">时</label>
				  </td>
				   <td align="center">
				   		<input type="text"  name="TbPaPatrolPlanTaskEntity[0].patrolPlanId" id="TbPaPatrolPlanTaskEntity[0].patrolPlanId" class="Wdate" 
				   		 style="width: 80%;" onClick="WdatePicker({qsEnabled:false,dateFmt:'mm'})" >
					  	 <%-- <t:dictSelect field="TbPaPatrolPlanTaskEntity[0].patrolPlanId" type="select" typeGroupCode="itacs_startMin" hasLabel="false" datatype="*"></t:dictSelect> --%>分
					  <label class="Validform_label" style="display: none;">分</label><!--用planid接分 -->
				  </td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(tbPaPatrolPlan)  > 0 }">
		<c:forEach items="${tbPaPatrolPlan}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center" id="ckid[${stuts.index }]"><input style="width:20px;"  type="checkbox" name="ck" /></td>
				   <td align="center">
				  	 <input id="id" type="hidden" />
						<input id="patrolPlanId" type="hidden" />
				 	  <%-- <input type="text" id="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolTaskId" name="patrolTaskId"  datatype="*"  value=""> --%>
				 	  <input type="hidden" id="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolTaskId" name="patrolTaskId"  >
					 <select  name="patrolTaskIds" id="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolTaskIds"  ></select>
					  <label class="Validform_label" style="display: none;">巡检任务</label>
				   </td>
				   <td align="center">
				   		<t:dictSelect field="TbPaPatrolPlanTaskEntity[${stuts.index }].startTime" type="select" typeGroupCode="itacs_startHours" hasLabel="false" datatype="*" defaultVal="${poVal.startH }"></t:dictSelect>时  
					  <label class="Validform_label" style="display: none;">时</label>
				   </td>
				   <td align="center">	
				   		<t:dictSelect field="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolPlanId" type="select" typeGroupCode="itacs_startHours" hasLabel="false" datatype="*" defaultVal="${poVal.startM }"></t:dictSelect>时  
					  <label class="Validform_label" style="display: none;">分</label>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>

</div>
<script type="text/javascript">
</script>
