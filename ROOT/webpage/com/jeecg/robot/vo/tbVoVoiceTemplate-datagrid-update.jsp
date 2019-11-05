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
			k++;
		}
	});
	setPatrolTask(k-1);
 	 return false;
});  
var k='${num}'-1;
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
    k--;
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
	}//更新是控制不能选相同的
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
		 <!-- <td align="left" bgcolor="#EEEEEE" style="width: 25px;">序号</td> -->
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">操作</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">巡检点</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">文本编辑</label></td>
	</tr>
	<tbody id="add_jformGraphreportItem_table">
	<%-- <c:if test="${fn:lengthTbVoVoiceTemplatePointsEntity)  > 0 }"> --%>
	<c:if test="${fn:length(TbVoVoiceTemplatePointsEntity)  > 0 }">
		<c:forEach items="${TbVoVoiceTemplatePointsEntity}" var="poVal" varStatus="stuts">
			<tr>
				 <%-- <td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>  --%>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
					<input id="TbVoVoiceTemplatePointsEntity[${stuts.index }].id" type="hidden" value="${poVal.id }" />
						<input id="TbVoVoiceTemplatePointsEntity[${stuts.index }].voiceTemplateId" type="hidden" value="${poVal.voiceTemplateId }" />
				   <td align="left" width="300px" heigth="100px">
				 	 <input type="hidden" id="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsNo" name="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsNo" value="${poVal.patrolPointsNo }"  >  
					 <t:dictSelect field="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsNos" defaultVal="${poVal.patrolPointsNo }" dictTable="tb_ro_robots_patrol_point" dictCondition="where robots_info_id='${robotsInfo}'" 
					 	dictField="patrol_point_no" dictText="patrol_point_no"  datatype="*" title="巡检点"  extendJson="{onchange:'chengepatrolTaskId(this)'}"></t:dictSelect> 
					 <font style="color: red;">*</font>
					  <label class="Validform_label" style="display: none;">巡检点</label>                       
				   </td>
				   <td align="left"  width="300px" heigth="100px">
				   	  <input type="hidden" id="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsText" name="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsText" value="${poVal.patrolPointsText }"> 
				   	   <textarea id="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsText" name="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsTexts" 
				   	   	 maxlength="1500" rows="3" cols="3" style="width:230px" datatype="*" onchange="changePointsText(this)">${poVal.patrolPointsText }</textarea>	
				   	  <%--  <textarea  id="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsTexts" name="TbVoVoiceTemplatePointsEntity[${stuts.index }].patrolPointsTexts" 
				   	   	rows="3" cols="3" style="width:260px" datatype="*"    onchange="changePointsText(this)" >${poVal.patrolPointsText }</textarea> --%>	
					  <font style="color: red;">*</font>
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
