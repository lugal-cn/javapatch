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
$('#addTbVoVoiceTemplateBtn').linkbutton({   
    iconCls: 'icon-add'  
});  
$('#delTbVoVoiceTemplateBtn').linkbutton({   
    iconCls: 'icon-remove'  
}); 
$('#addTbVoVoiceTemplateBtn').bind('click', function(){   
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
$('#delTbVoVoiceTemplateBtn').bind('click', function(){   
	var length=$("#add_jformGraphreportItem_table").find("input:checked").length;
	var selectId="";
	var idObject="";
	for(var i=0;i<length;i++){
		 selectId=$("#add_jformGraphreportItem_table").find("input:checked").parent().parent().
		children('td').children('select')[i].value;//点编号
		//删除div 重新加载机器人图标     删除之前的坐标点
 		 idObject = document.getElementById('div'+selectId);
 	     if (idObject != null) {
 	          idObject.parentNode.removeChild(idObject);
 	    }
	}
  	$("#add_jformGraphreportItem_table").find("input:checked").parent().parent().remove();  
    resetTrNum('add_jformGraphreportItem_table'); 
    return false;
}); 

//设置巡检任务下拉选择
function setPatrolTask (k) {
	var id = 'TbVoVoiceTemplatePointsEntity['+k+'].patrolPointsNos';
	/*-------------------------------------------所属机器人下的巡检点----------------------------------------------*/
	var select2Data = new Array();
	$.ajax({
		url:"tbVoVoiceTemplateController.do?robotsPointsSelect&robotsInfoId="+'${robotsInfo}',
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
	/*-------------------------------------------所属机器人下的巡检点----------------------------------------------*/
}
$(document).ready(function(){
	$(".datagrid-toolbar").parent().css("width","auto");
	if(location.href.indexOf("load=detail")!=-1){
		$(":input").attr("disabled","true");
		$(".datagrid-toolbar").hide();
	}
	var id = "TbVoVoiceTemplatePointsEntity[0].patrolPointsNos";
	/*-------------------------------------------所属机器人下的巡检点----------------------------------------------*/
	var select2Data = new Array();
	$.ajax({
		url:"tbVoVoiceTemplateController.do?robotsPointsSelect&robotsInfoId="+'${robotsInfo}',
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
	/*-------------------------------------------所属机器人下的巡检点----------------------------------------------*/
	
});
var k=0;
//点击巡检点
function chengepatrolTaskId(obj) {
	var robotsInfo='${robotsInfo}';
	var id = obj.id;
	var inpId = id.substring(0,id.length-1);
	var idNum=id.split('[')[1];
	idNum=idNum.split(']')[0];//当前行的序号
	if(k>idNum){
	}else{
		k=idNum;
	}
	for(var i=0;i<=k;i++){
		var beforPatrolPointsNo=document.getElementById(inpId.split('[')[0]+'['+i+']'+inpId.split(']')[1]).value;
			if(obj.value===beforPatrolPointsNo){//有相同的，提示不能选
				tip("已经选过了,请重选");
				var idObject = document.getElementById('div'+document.getElementById(id.substring(0,id.length-1)).value);
		 	    if (idObject != null) {
		 	          idObject.parentNode.removeChild(idObject);
		 	    }
				obj.value="";
				document.getElementById(id.substring(0,id.length-1)).value=obj.value;
				return;
			} 
	}//控制下拉选项不能选相同的
	var inpId = id.substring(0,id.length-1);
	var oldPatrolPointsNo=document.getElementById(inpId).value;
	document.getElementById(inpId).value=obj.value;
	var patrolPointsNo=document.getElementById(inpId).value;
	//查询出选中的巡检点的x,y坐标
	var patrolPointsNoMap = new Array();
	var x,y;
	$.ajax({
	url:'tbVoVoiceTemplateController.do?getRobotsInfoXY&robotsInfoId='+robotsInfo+'&patrolPointsNo='+patrolPointsNo,
	type:'GET',
	dataType:'JSON',
	async:false, 
	delay: 250,
	cache: true,
	success: function(data){
			for(var i = 0; i < data.length; i++){
				var patrolPointsNoM={};
				patrolPointsNoM.xCoordinate=data[i].xCoordinate;
				patrolPointsNoM.yCoordinate=data[i].yCoordinate;
				patrolPointsNoMap.push(patrolPointsNoM);
				x=patrolPointsNoMap[0].xCoordinate;
				y=patrolPointsNoMap[0].yCoordinate
			}
		}
	});
	//删除div 重新加载机器人图标     删除之前的坐标点
	 		var idObject = document.getElementById('div'+oldPatrolPointsNo);
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

function changePointsText(obj){
	var id = obj.id;
	var inpId = id.substring(0,id.length);
	document.getElementById(inpId).value=obj.value;
}
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addTbVoVoiceTemplateBtn" href="javascript:void(0);">添加</a> <a id="delTbVoVoiceTemplateBtn" href="javascript:void(0);">删除</a>
	
</div>

<div style="width: auto; height: 300px; overflow-y: auto; overflow-x: scroll;">
<table border="0" cellpadding="2" cellspacing="0" id="jformGraphreportItem_table">
	<tr bgcolor="#E6E6E6">
		<!--  <td align="left" bgcolor="#EEEEEE" style="width: 25px;">序号</td>  -->
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">操作</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">巡检点</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">文本编辑</label></td>
	</tr>
	<tbody id="add_jformGraphreportItem_table">
	<c:if test="${fn:length(tbPaPatrolPlan)  <= 0 }">
			<tr id="TbVoVoiceTemplatePointsEntity[0].trid">
				<!-- <td align="center" ><div style="width: 25px;" name="xh" >1</div></td>  -->
				<td align="center" id="TbVoVoiceTemplatePointsEntity[0].cck"><input style="width:20px;"  type="checkbox" name="ck"/></td>
				  <td align="left" width="300px" heigth="100px" id="TbVoVoiceTemplatePointsEntity[0].ppatrolPointsNo">
					  	<input type="hidden" id="TbVoVoiceTemplatePointsEntity[0].patrolPointsNo" name="TbVoVoiceTemplatePointsEntity[0].patrolPointsNo">
					  	<select  name="patrolPointsNos" id="TbVoVoiceTemplatePointsEntity[0].patrolPointsNos" onchange="chengepatrolTaskId(this)" datatype="*"></select>
					  <font style="color: red;">*</font>
					  <label class="Validform_label" style="display: none;">巡检点</label>
				  </td>
				  <td align="left" width="300px" >
				  	  <!-- <input type="text" id="TbPaPatrolPlanTaskEntity[0].123" name="123" style="width:260px"> -->
				  	  <input type="hidden" id="TbVoVoiceTemplatePointsEntity[0].patrolPointsText" name="TbVoVoiceTemplatePointsEntity[0].patrolPointsText">
				  	   <textarea id="TbVoVoiceTemplatePointsEntity[0].patrolPointsText" name="TbVoVoiceTemplatePointsEntity[0].patrolPointsTexts" maxlength="1500" rows="3" cols="3" style="width:230px" datatype="*" onchange="changePointsText(this)"></textarea>	
					  <font style="color: red;">*</font>
					  <label class="Validform_label" style="display: none;">文本编辑</label>
				  </td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(tbPaPatrolPlan)  > 0 }">
		<c:forEach items="${TbVoVoiceTemplatePointsEntity}" var="poVal" varStatus="stuts">
			<tr id="TbVoVoiceTemplatePointsEntity[${stuts.index }].trid">
				 <td align="center" hidden><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center"  id="TbVoVoiceTemplatePointsEntity[${stuts.index }].cck"><input style="width:20px;"  type="checkbox" name="ck" /></td>
						<input id="id" type="hidden" value="${poVal.id }" />
						<input id="voiceTemplateId" type="hidden" value="${poVal.voiceTemplateId }" />
				   <td align="left" width="300px" heigth="100px" id="TbVoVoiceTemplatePointsEntity[${stuts.index }].ppatrolPointsNo">
				 	  <%-- <input type="hidden" id="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsNo" value="${poVal.patrolPointsNo }"  >
					 <t:dictSelect field="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsNo" defaultVal="${poVal.patrolTaspatrolPointsNo }" dictTable="tb_ro_robots_patrol_point" dictCondition="where id='${robotsInfo}'" dictField="id" dictText="patrol_point_no"  datatype="*" title="任务"></t:dictSelect> --%>
					  <input type="hidden" id="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsNo" name="patrolPointsNo"  value="${poVal.patrolTaspatrolPointsNo }">
					 <select  name="patrolPointsNos" id="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsNos"  ></select>
					  <label class="Validform_label" style="display: none;">巡检点</label>
				   </td>
				   <td align="left"  width="300px" heigth="100px">
				   	  <input type="hidden" id="TbVoVoiceTemplatePointsEntity[0].patrolPointsText" maxlength="1500"  minlength="15" name="TbVoVoiceTemplatePointsEntity[0].patrolPointsText" value="${poVal.patrolPointsText }">
				   	  <%-- <textarea id="TbVoVoiceTemplatePointsEntity[0].patrolPointsText" name="TbVoVoiceTemplatePointsEntity[0].patrolPointsTexts" rows="3" cols="3" style="width:260px" datatype="*" value="${poVal.patrolPointsText }" ></textarea>	 --%>
					  <label class="Validform_label" style="display: none;">文本编辑</label>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
</div>
<script type="text/javascript">
</script>
