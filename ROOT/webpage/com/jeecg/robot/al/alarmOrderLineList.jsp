<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#addAlarmOrderLineBtn${alarmLevel}').linkbutton({   
	    iconCls: 'icon-add'  
	});   
	$('#delAlarmOrderLineBtn${alarmLevel}').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addAlarmOrderLineBtn${alarmLevel}').bind('click', function(){   
 		 var tr =  $("#add_AlarmOrderLine_table_template${alarmLevel} tr").clone();
	 	 $("#add_AlarmOrderLine_table${alarmLevel}").append(tr);
	 	resetTrNumByAlarm('add_AlarmOrderLine_table${alarmLevel}','${alarmLevel}');
	 	 return false;
    });  
	$('#delAlarmOrderLineBtn${alarmLevel}').bind('click', function(){   
      	$("#add_AlarmOrderLine_table${alarmLevel}").find("input:checked").parent().parent().remove();   
      	resetTrNumByAlarm('add_AlarmOrderLine_table${alarmLevel}','${alarmLevel}'); 
        return false;
    }); 
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
			$(".datagrid-toolbar").hide();
		}
    });
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addAlarmOrderLineBtn${alarmLevel}" href="#">添加</a> <a id="delAlarmOrderLineBtn${alarmLevel}" href="#">删除</a> 
</div>
<table border="0" cellpadding="2" cellspacing="0" id="AlarmOrderLine_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td>
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">操作</td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						姓名
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						手机号
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						邮箱
				  </td>
	</tr>
	<tbody id="add_AlarmOrderLine_table${alarmLevel}">
	<c:if test="${fn:length(tbAlTempAlarmUserList)  <= 0 }">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh${alarmLevel}">1</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck${alarmLevel}"/></td>
					<input name="tbAlTempAlarmUserList${alarmLevel}[0].id" type="hidden"/>
				  <td align="left">
					  	<input name="tbAlTempAlarmUserList${alarmLevel}[0].userName" maxlength="128" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">姓名</label>
					</td>
				  <td align="left">
					  	<input name="tbAlTempAlarmUserList${alarmLevel}[0].phoneNumber" maxlength="32" type="text" class="inputxt"  style="width:120px;"  datatype="n"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">手机号</label>
					</td>
				  <td align="left">
					  	<input name="tbAlTempAlarmUserList${alarmLevel}[0].mailbox" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">邮箱</label>
					</td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(tbAlTempAlarmUserList)  > 0 }">
		<c:forEach items="${tbAlTempAlarmUserList}" var="tbAlTempAlarmUser" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
						<input name="tbAlTempAlarmUserList${alarmLevel}[${stuts.index }].id" type="hidden" value="${tbAlTempAlarmUser.id }"/>
				   <td align="left">
					  	<input name="tbAlTempAlarmUserList${alarmLevel}[${stuts.index }].userName" maxlength="128" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${tbAlTempAlarmUser.userName }"/>
					  <label class="Validform_label" style="display: none;">姓名</label>
				   </td>
				   <td align="left">
					  	<input name="tbAlTempAlarmUserList${alarmLevel}[${stuts.index }].phoneNumber" maxlength="32" type="text" class="inputxt"  style="width:120px;"  datatype="n"  ignore="ignore"  value="${tbAlTempAlarmUser.phoneNumber }"/>
					  <label class="Validform_label" style="display: none;">手机号</label>
				   </td>
				   <td align="left">
					  	<input name="tbAlTempAlarmUserList${alarmLevel}[${stuts.index }].mailbox" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${tbAlTempAlarmUser.mailbox }"/>
					  <label class="Validform_label" style="display: none;">邮箱</label>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
