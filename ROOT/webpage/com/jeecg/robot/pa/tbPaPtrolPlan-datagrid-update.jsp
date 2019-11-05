<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
function resetTrNum(tableId) {
	$tbody = $("#"+tableId+"");
	$tbody.find('>tr').each(function(i){
		$(':input, select,button,a', this).each(function(){
			var $this = $(this), name = $this.attr('name'),id=$this.attr('id'),onclick_str=$this.attr('onclick'), val = $this.val();
			if(name!=null){
				if (name.indexOf("#index#") >= 0){
					$this.attr("name",name.replace('#index#',i));
				}else{
					var s = name.indexOf("[");
					var e = name.indexOf("]");
					var new_name = name.substring(s+1,e);
					$this.attr("name",name.replace(new_name,i));
				}
			}
			if(id!=null){
				if (id.indexOf("#index#") >= 0){
					$this.attr("id",id.replace('#index#',i));
				}else{
					var s = id.indexOf("[");
					var e = id.indexOf("]");
					var new_id = id.substring(s+1,e);
					$this.attr("id",id.replace(new_id,i));
				}
			}
			if(onclick_str!=null){
				if (onclick_str.indexOf("#index#") >= 0){
					$this.attr("onclick",onclick_str.replace(/#index#/g,i));
				}else{
				}
			}
		});
		$(this).find('div[name=\'xh\']').html(i+1);
	});
}
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
	 var k=0;
		$tbody.find('>tr').each(function(i){
			if(i!=null){
				k++;
			}
		});
		setPatrolTask(k-1);
	 return false;
});  
var k='${num}'-1;
$('#delJformGraphreportItemBtn').bind('click', function(){  
	var length=$("#add_jformGraphreportItem_table").find("input:checked").parent().parent().
	children('td').children('select').length;//这个地方是每列有多少数据就有多少个长度，再乘上多列
	var selectId="";
	var idObject="";
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
				for(var i = 0; i < data.length; i++){
					//删除div 重新加载机器人图标     删除之前的坐标点
			 		var idObject = document.getElementById('div'+selectId+i);//巡检计划时div是巡检任务的id
			 	    if (idObject != null) {
			 	          idObject.parentNode.removeChild(idObject);
			 	    }
				}
			}
		});
	}
      	$("#add_jformGraphreportItem_table").find("input[name$='ck']:checked").parent().parent().remove();   
        resetTrNum('add_jformGraphreportItem_table'); 
        k--;
        return false;
    }); 
$(document).ready(function(){
	$(".datagrid-toolbar").parent().css("width","auto");
	if(location.href.indexOf("load=detail")!=-1){
		$(":input").attr("disabled","true");
		$(".datagrid-toolbar").hide();
	}
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
function chengepatrolTaskId(obj) {
	var id="";
	var robotsInfo='${robotsInfo}';
	if(obj.id===""){
		id=obj.name
		var inpId = id.substring(0,id.length-1);
		var idNum=id.split('[')[1];
		idNum=idNum.split(']')[0];//当前行的序号
		if(k>idNum){
		}else{
			k=idNum;
		}
		for(var i=0;i<=k;i++){
				var beforPatrolPointsNo=document.getElementById(inpId.split('[')[0]+'['+i+']'+inpId.split(']')[1]).value;
				/* if(obj.value===beforPatrolPointsNo){//有相同的，提示不能选
					tip("已经选过了,请重选"); */
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
					return;
				}  */
		}//控制下拉选项不能选相同的
	}else{
		id= obj.id;
		var inpId = id.substring(0,id.length-1);
		 var idNum=id.split('[')[1];
			idNum=idNum.split(']')[0];//当前行的序号
			if(k>idNum){
			}else{
				k=idNum;
			}
			for(var i=0;i<=k;i++){
					var beforPatrolPointsNo=document.getElementById(inpId.split('[')[0]+'['+i+']'+inpId.split(']')[1]).value;
					/* if(obj.value===beforPatrolPointsNo){//有相同的，提示不能选
						tip("已经选过了,请重选"); */
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
					/* 	obj.value="";
						document.getElementById(id.substring(0,id.length-1)).value=obj.value;
						return;
					}  */
			}//控制下拉选项不能选相同的
	}//更新是控制不能选相同的
	var inpId = id.substring(0,id.length-1);
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
	<a id="addJformGraphreportItemBtn" href="#">添加</a> 
	<a id="delJformGraphreportItemBtn" href="#">删除</a> 
</div>
<div style="width: auto; height: 300px; overflow-y: true; overflow-x: scroll;">
<table border="0" cellpadding="2" cellspacing="0" id="jformGraphreportItem_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td>
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">操作</td>
		<td align="center" bgcolor="#EEEEEE">巡检任务</td>
		<td align="center" bgcolor="#EEEEEE" colspan="2">开始时间</td>
	</tr>
	<tbody id="add_jformGraphreportItem_table">
	<c:if test="${fn:length(TbPaPatrolPlanTaskEntity)  > 0 }">
		<c:forEach items="${TbPaPatrolPlanTaskEntity}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
				   <td align="center">
				 	   <input type="hidden" id="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolTaskId" name="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolTaskId" value="${poVal.patrolTaskId }" >
					<%--  <select  name="patrolTaskIds" id="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolTaskIds"  ></select> --%>
					  <t:dictSelect field="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolTaskIds" defaultVal="${poVal.patrolTaskId }" 
					  dictTable="tb_pa_patrol_task" dictCondition="where robots_info_id='${robotsInfo}'" 
					  dictField="id" dictText="patrol_task_name"  datatype="*" title="任务" extendJson="{onchange:'chengepatrolTaskId(this)'}"></t:dictSelect>
					  <label class="Validform_label" style="display: none;">巡检任务</label>
				   </td>
				   <td align="center">
				    <input type="text"  name="TbPaPatrolPlanTaskEntity[${stuts.index }].startTime" id="TbPaPatrolPlanTaskEntity[${stuts.index }].startTime" class="Wdate" 
				    style="width: 80%;" value="${poVal.startH }"	onClick="WdatePicker({qsEnabled:false,dateFmt:'HH'})" >
				   	<%-- 	<t:dictSelect field="TbPaPatrolPlanTaskEntity[${stuts.index }].startTime" type="select" typeGroupCode="itacs_startHours" hasLabel="false" datatype="*" defaultVal="${poVal.startH }"></t:dictSelect> --%>时  
					  <label class="Validform_label" style="display: none;">时</label>
				   </td>
				   <td align="center">	
				    <input type="text" style="width: 80%" name="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolPlanId" id="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolPlanId" class="Wdate" 
				    style="width: 80%;" value="${poVal.startM }"	onClick="WdatePicker({qsEnabled:false,dateFmt:'mm'})" >
				   		<%-- <t:dictSelect field="TbPaPatrolPlanTaskEntity[${stuts.index }].patrolPlanId" type="select" typeGroupCode="itacs_startHours" hasLabel="false" datatype="*" defaultVal="${poVal.startM }"></t:dictSelect> --%>分 
					  <label class="Validform_label" style="display: none;">分</label>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
</div>
