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
 	 return false;
});  
$('#delTbVoVoiceTemplateBtn').bind('click', function(){   
  	$("#add_jformGraphreportItem_table").find("input:checked").parent().parent().remove();  
    resetTrNum('add_jformGraphreportItem_table'); 
    return false;
}); 
$(document).ready(function(){
	$(".datagrid-toolbar").parent().css("width","auto");
	if(location.href.indexOf("load=detail")!=-1){
		$(":input").attr("disabled","true");
		$(".datagrid-toolbar").hide();
	}
});

function chengepatrolTaskId(obj) {
	var id = obj.id;
	var inpId = id.substring(0,id.length-1);
	document.getElementById(inpId).value=obj.value;
}

function changePointsText(obj){
	var id = obj.id;
	var inpId = id.substring(0,id.length-1);
	document.getElementById(inpId).value=obj.value;
}
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addTbVoVoiceTemplateBtn" href="javascript:void(0);">添加</a> <a id="delTbVoVoiceTemplateBtn" href="javascript:void(0);">删除</a>
	
</div>

<div style="width: auto; height: 300px; overflow-y: auto; overflow-x: scroll;">
<table border="0" cellpadding="2" cellspacing="0" id="jformGraphreportItem_table">
	<tr bgcolor="#E6E6E6">
		<!-- <td align="left" bgcolor="#EEEEEE" style="width: 25px;">序号</td>  -->
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">操作</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">关键词</label></td>
		<td align="left" bgcolor="#EEEEEE"><label class="Validform_label">语音回复文本</label></td>
	</tr>
	<tbody id="add_jformGraphreportItem_table">
	<c:if test="${fn:length(TbVoVoiceInteractionEntity)  <= 0 }">
			<tr>
				<!--  <td align="center"><div style="width: 25px;" name="xh">1</div></td>  -->
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/></td>
				  <td align="left" width="300px" heigth="100px">
					  	<input type="text" id="TbVoVoiceInteractionEntity[0].keyWord" name="TbVoVoiceInteractionEntity[0].keyWord">
					  <label class="Validform_label" style="display: none;">关键词</label>
					  <span style="color: red;">*</span>
				  </td>
				  <td align="left" width="400px">
				  	  <input type="hidden" id="TbVoVoiceInteractionEntity[0].voiceResponseText" name="TbVoVoiceInteractionEntity[0].voiceResponseText">
				  	   <textarea id="TbVoVoiceInteractionEntity[0].voiceResponseTexts" name="TbVoVoiceInteractionEntity[0].voiceResponseTexts" 
				  	   rows="3" cols="3" style="width:300px" datatype="*" onchange="changePointsText(this)"></textarea>	
					  <label class="Validform_label" style="display: none;">语音回复文本</label>
					  <span style="color: red;">*</span>
				  </td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(TbVoVoiceInteractionEntity)  > 0 }">
		<c:forEach items="${TbVoVoiceInteractionEntity}" var="poVal" varStatus="stuts">
			<tr>
				 <%-- <td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>  --%>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
					<input id="TbVoVoiceInteractionEntity[${stuts.index }].id" name="TbVoVoiceInteractionEntity[${stuts.index }].id" type="hidden" value="${poVal.id }" />
					<input id="TbVoVoiceInteractionEntity[${stuts.index }].robotsInfoId" name="TbVoVoiceInteractionEntity[${stuts.index }].robotsInfoId" type="hidden" value="${poVal.robotsInfoId }" />
				   <td align="left" width="300px" heigth="100px">
				 	  <input type="text" id="TbVoVoiceInteractionEntity[${stuts.index }].keyWord" name="TbVoVoiceInteractionEntity[${stuts.index }].keyWord" value="${poVal.keyWord }" datatype="*"> 
					  <label class="Validform_label" style="display: none;">关键词</label> 
					  <span style="color: red;">*</span>                      
				   </td>
				   <td align="left"  width="400px" heigth="100px">
				   	  <input type="hidden" id="TbVoVoiceInteractionEntity[${stuts.index }].voiceResponseText" name="TbVoVoiceInteractionEntity[${stuts.index }].voiceResponseText" value="${poVal.voiceResponseText }"> 
				   	   <textarea id="TbVoVoiceInteractionEntity[${stuts.index }].voiceResponseTexts" name="TbVoVoiceInteractionEntity[${stuts.index }].voiceResponseTexts" 
				   	   	rows="3" cols="3" style="width:300px" datatype="*" onchange="changePointsText(this)">${poVal.voiceResponseText }</textarea>	
					  <label class="Validform_label" style="display: none;">语音回复文本</label>
					  <span style="color: red;">*</span>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
</div>
<script type="text/javascript">
</script>
