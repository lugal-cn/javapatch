<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%-- <t:base type="jquery,easyui,tools"></t:base> --%>
<script type="text/javascript">
	
</script>
<!-- <div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addJformOrderCustomerBtn" href="#">添加</a> <a id="delJformOrderCustomerBtn" href="#">删除</a> 
</div> -->
<table border="0" cellpadding="2" cellspacing="0" id="jformOrderCustomer_table" align="center">
<!-- 	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td>	
				  <td align="center" bgcolor="#EEEEEE" style="width: 126px;">
						
				  </td>
				  <td align="center" bgcolor="#EEEEEE" style="width: 126px;">
						机柜类型
				  </td>
				  <td align="center" bgcolor="#EEEEEE" style="width: 126px;">
						机柜编号
				  </td>	 
				  
	</tr> -->
	<tbody id="add_jformOrderCustomer_table">
	<c:if test="${fn:length(TbAlAlarmIndiLight)  > 0 }">
		<c:forEach items="${TbAlAlarmIndiLight}" var="poVal" varStatus="stuts">
		<tr>
		
		<td align="left" style="width: 126px;">
		<label class="Validform_label">故障设备</label>
		</td>
		
		<td align="center" style="width: 126px;">
		<label class="Validform_label">设备型号</label>
		</td>
		
		<td align="center" style="width: 126px;">
		<label class="Validform_label">告警描述</label>
		</td>
		
		</tr>
			<tr>			
		       <%-- <td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td> --%>
				<%--<td align="center"><input style="width:20px;"   type="checkbox" id="ck[${stuts.index }]" name="ck[${stuts.index }]"   /></td>
						<input name="TbAlAlarmIndiLight[${stuts.index }].id" id="id[${stuts.index }]" type="hidden" value="${poVal.id }"/>
						<input name="TbAlAlarmIndiLight[${stuts.index }].ckk" id="ckk[${stuts.index }]" name="ckk[${stuts.index }]" type="hidden" value="${poVal.ck }"/>
						<input name="TbAlAlarmIndiLight[${stuts.index }].robotsInfoId" type="hidden" value="${poVal.robotsInfoId }"/> --%>
				  <%--  <td align="center"> 
					       	<input name="TbAlAlarmIndiLight[${stuts.index }].alarm_Indi_light_sou" maxlength="32" type="text" readonly class="inputxt"  style="width:80px;"  ignore="ignore"  value="${poVal.alarm_Indi_light_sou  }"/>
					  <label class="Validform_label" style="display: none;">告警来源</label>
				   </td> --%>
				   	   <td align="center"  style="width: 126px;">
				   <input name="TbAlAlarmIndiLight[${stuts.index }].equipment_name" maxlength="32" type="text" class="inputxt" readonly style="width:126px;"  ignore="ignore"  value="${poVal.equipment_name }"/>
					  <label class="Validform_label" style="display: none;">故障设备</label>
				   </td>
				   
				     <td align="center" style="width: 126px;">
				   <input name="TbAlAlarmIndiLight[${stuts.index }].equipment_no" maxlength="32" type="text" class="inputxt" readonly style="width:100px;"  ignore="ignore"  value="${poVal.equipment_no }"/>
					  <label class="Validform_label" style="display: none;">设备型号</label>
				   </td>
				   
				   <td align="center" style="width: 126px;">
				   	<input name="TbAlAlarmIndiLight[${stuts.index }].point_warring_msg" maxlength="32" type="text" readonly class="inputxt"  style="width:100px;"  ignore="ignore"  value="${poVal.point_warring_msg }"/>    
					  <label class="Validform_label" style="display: none;">告警描述</label>
				   </td>
			
				
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

function jiaoyan(i){//控制操作选了的话必须选择执行动作
	 var el=document.getElementById("ck["+i+"]");
	 if(el.checked){//true   flase
		//为true时执行动作必须选
		$("TbPaPatrolPointsEntity["+i+"].execAction").attr("datatype","*");
	 }else{
		 $("#TbPaPatrolPointsEntity["+i+"].execAction").attr("datatype","");
	 }
} 
</script>
