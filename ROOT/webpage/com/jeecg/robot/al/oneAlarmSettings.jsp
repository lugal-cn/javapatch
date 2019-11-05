<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
  <title>订单列表</title>
    <style>
  .ui-button {
  	  display: inline-block;
	  padding: 2px 2px;
	  margin-bottom: 0;
	  font-size: 8px;
	  font-weight: normal;
	  line-height: 1.42857143;
	  text-align: center;
	  white-space: nowrap;
	  vertical-align: middle;
	  -ms-touch-action: manipulation;
      touch-action: manipulation;
	  cursor: pointer;
	  -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
	  background-image: none;
	  border: 1px solid transparent;
	  border-radius: 4px;
  }
  tbody > tr > td[align='right']{
  	width:15%;
  }
  </style>
  <script type="text/javascript">
//告警级别
//var alarmLevel = "${alarmLevel}"; 
//机构改变事件
function orgCodeChange(orgid,alarmLevel,obj){

	if(obj.checked){
		ry(orgid,alarmLevel);
	}else{
		var ryTd = document.getElementById("ry"+alarmLevel);
		var userArr = document.getElementsByName(orgid+alarmLevel);
		if(userArr && userArr.length > 0) {
			for (var i = userArr.length; i > 0 ; i--) {
				ryTd.removeChild(userArr[i-1]);
			}
		}
	} 	
	
}
function ry(orgid,alarmLevel){
	$.ajax({
        cache: true,
        type: "POST",
        url:"tbAlAlarmSettingsController.do?getRy&orgid="+orgid+"&alarmLevel="+alarmLevel,
        data:$("form").serialize(),
        dataType:"json",
        async: false,
        error: function(datas) {
        },
        success: function(datas) {
        		$("#ry"+alarmLevel).append(datas.msg);
        }
    }); 
}
 </script>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="jfromOrderController.do?doAdd" >
		<input id="alarmLevel${alarmLevel}" name="alarmLevel${alarmLevel}" type="hidden" value="${alarmLevel}" />
		<input type="hidden" id="userids${alarmLevel}" name="userids${alarmLevel}" value="${userids}"/>
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right">
				<label class="Validform_label">告警信息接收部门:</label>
			</td>
			<td class="value" colspan="3">
				<%-- <input type="hidden" id="dept${alarmLevel}" name="dept${alarmLevel}"/> --%>
		     	<%-- <t:comboTree url="jeecgFormDemoController.do?getComboTreeData" name="deptId${alarmLevel}" id="deptId${alarmLevel}" width="200"></t:comboTree> --%>
				<c:if test="${fn:length(tsDeparts)  > 0 }">
					<c:forEach items="${tsDeparts}" var="tsDepart" varStatus="status">
						<input  name="orgCode${alarmLevel}" type="checkbox" value="${tsDepart.id}" 
						onchange="orgCodeChange('${tsDepart.id}','${alarmLevel}',this)">${tsDepart.departname}
					</c:forEach>
				</c:if>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">部门</label>
			</td>
		</tr>
		<tr>
			<td align="right">
				<label class="Validform_label">告警信息接收人员:</label>
			</td>
			<td class="value" id="ry${alarmLevel}">
				<span style="float: right;"><input type="button" name="tianjianame" class="button" onclick="tianjia('${alarmLevel}')" value="添加" style="width: 50px;height: 25px;font-size: 14px; "/></span>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">告警信息接收人员</label>
			</td>
		</tr>
		<%-- <tr>
			<td align="right" >
			</td>
			<td class="value" colspan="3" >
			<a href="javascript:void(0)" onclick="tianjia('${alarmLevel}')">添加</a>
			<input type="button" name="tianjianame" class="button" onclick="tianjia('${alarmLevel}')" value="添加" style="width: 50px;height: 25px;font-size: 14px; "/>
			</td>
		</tr> --%>
		<tr>
			<td align="right">
				<label class="Validform_label">接收方式:</label>
			</td>
			<td class="value" id="yx${alarmLevel}">
				<c:if test="${fn:length(tbAlAlarmSettingsList)  > 0 }">
					<c:forEach items="${tbAlAlarmSettingsList}" var="tbAlAlarmSettings" varStatus="stuts">
						<div id="div${alarmLevel}${stuts.index }">
						<div style="width:70%; float:left;margin-right: 1px;">
						<input type="hidden" id="id${alarmLevel}${stuts.index }" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].id" value="${tbAlAlarmSettings.id }"/>
						<input type="hidden" id="alarmUserId${alarmLevel}${stuts.index }" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmUserId" value="${tbAlAlarmSettings.alarmUserId }"/>
						${tbAlAlarmSettings.realName }:
						<c:if test="${fn:contains(tbAlAlarmSettings.alarmMode,'1')}">
							<input checked="checked" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="1" >邮件
						</c:if>
						<c:if test="${!fn:contains(tbAlAlarmSettings.alarmMode,'1')}">
							<input  name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="1" >邮件
						</c:if>
						
						<c:if test="${fn:contains(tbAlAlarmSettings.alarmMode,'2')}">
							<input checked="checked" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="2" >短信
						</c:if>
						<c:if test="${!fn:contains(tbAlAlarmSettings.alarmMode,'2')}">
							<input  name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="2" >短信
						</c:if>
						<c:if test="${fn:contains(tbAlAlarmSettings.alarmMode,'3')}">
							<input checked="checked" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="3" onchange="change('${stuts.index }','${alarmLevel}')">语音
						</c:if>
						<c:if test="${!fn:contains(tbAlAlarmSettings.alarmMode,'3')}">
							<input name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="3" onchange="change('${stuts.index }','${alarmLevel}')">语音
						</c:if>
						<c:if test="${fn:contains(tbAlAlarmSettings.alarmMode,'4')}">
							<input checked="checked" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="4" >弹窗
						</c:if>
						<c:if test="${!fn:contains(tbAlAlarmSettings.alarmMode,'4')}">
							<input name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="4" >弹窗
						</c:if>
						<c:if test="${fn:contains(tbAlAlarmSettings.alarmAllFlag,'1')}">
							<input checked="checked" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="5" >接收全部告警
						</c:if>
						<c:if test="${fn:contains(tbAlAlarmSettings.alarmAllFlag,'0')}">
							<input name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].alarmMode" type="checkbox" value="5" >接收全部告警
						</c:if>
						<span id="raid${alarmLevel}${stuts.index }">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;语音播放设置：
							<c:if test="${tbAlAlarmSettings.voicePlaySettings == '1' }">
								<input checked="checked" type="radio" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].voicePlaySettings" value="1">播放一次
								<input type="radio" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].voicePlaySettings" value="2">反复播放
							</c:if>
							 <c:if test="${tbAlAlarmSettings.voicePlaySettings == '2' }">
								<input  type="radio" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].voicePlaySettings" value="1">播放一次
								<input checked="checked" type="radio" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].voicePlaySettings" value="2">反复播放
							</c:if> 
							<c:if test="${tbAlAlarmSettings.voicePlaySettings != '1' && tbAlAlarmSettings.voicePlaySettings != '2'}">
								<input type="radio" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].voicePlaySettings" value="1">播放一次
								<input type="radio" name="tbAlAlarmSettingsList${alarmLevel}[${stuts.index }].voicePlaySettings" value="2">反复播放
							</c:if>
						</span>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<%-- <a href="javascript:void(0)" onclick="delRow('${tbAlAlarmSettings.alarmUserId }','${alarmLevel}','${stuts.index }')">删除</a> --%>
						</div>
							<div style="float: left;width: 29%;">
								<span style="float: right;">
								<input type="button" name="shanchuname" class="button" onclick="delRow('${tbAlAlarmSettings.alarmUserId }','${alarmLevel}','${stuts.index }')" value="删除" style="width: 50px;height: 22px;font-size: 13px; "/>
								</span>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</td>
		</tr>
	
	</table>
	<div style="width: auto">
		<%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
		<div style="width:800px;height:1px;"></div>
		<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
		 <t:tab href="tbAlAlarmSettingsController.do?alarmOrderLineList&alarmLevel=${alarmLevel}" icon="icon-search" title="临时告警接收人员" id="alarmOrderLine${alarmLevel}"></t:tab>
		</t:tabs>
	</div>
	</t:formvalid> 
	<div style="padding: 5px;text-align: center;" >
	<div style="width:800px;height:30px;"></div>
		<input id="save" type="button"  value=" 保 存 " class="button" onclick="saves('${alarmLevel}');" style="width: 70px;height: 30px;font-size: 14px; "/>
	</div>
	<!-- 添加 附表明细 模版 -->
	<table style="display:none">
	<tbody id="add_AlarmOrderLine_table_template${alarmLevel}">
		<tr>
			 <td align="center"><div style="width: 25px;" name="xh${alarmLevel}"></div></td>
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck${alarmLevel}"/></td>
				  <td align="left">
					  	<input name="tbAlTempAlarmUserList${alarmLevel}[#index#].userName" maxlength="128" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" />
					  <label class="Validform_label" style="display: none;">姓名</label>
				  </td>
				  <td align="left">
					  	<input name="tbAlTempAlarmUserList${alarmLevel}[#index#].phoneNumber" maxlength="32" type="text" class="inputxt"  style="width:120px;"  datatype="n"  ignore="ignore" />
					  <label class="Validform_label" style="display: none;">手机号</label>
				  </td>
				  <td align="left">
					  	<input name="tbAlTempAlarmUserList${alarmLevel}[#index#].mailbox" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" />
					  <label class="Validform_label" style="display: none;">邮箱</label>
				  </td>
			</tr>
		 </tbody>
		</table> 
 <script src = "webpage/com/jeecg/demo/jfromOrder.js"></script>
 <script type="text/javascript">
 //添加人员
function tianjia(alarmLevel){
	var useridflag = "2";
	var htm = "";
	obj = document.getElementsByName("userid"+alarmLevel);
	for(k in obj){
        if(obj[k].checked){
        	useridflag="1";
        }
           
    }
	if(useridflag == "2"){
		alert("人员不能为空！");
		return;
	}
	//已选人员的数量
	var checkboxNums = 0;
	//已选人员的对象
	useridsObj = $("#userids"+alarmLevel);
	//获取已选人员的值
	var userids = useridsObj.val();
	var useridsSp = userids.split(",");
	if(useridsSp[0]!=null&&useridsSp[0]!=""){
		if(useridsSp&&useridsSp.length > 0){
			checkboxNums += useridsSp.length;
		}
	}
	var check_val = [];
    for(var k=0 ;k<obj.length;k++){
    	if(obj[k].checked){
    		checkboxNums++;
    		check_val.push(obj[k].value);
    		htm+='<div id="div'+alarmLevel+(checkboxNums-1)+'"><div style="width:70%; float:left;margin-right: 1px;">';
    		htm+='<input type="hidden" id="tbAlAlarmSettingsList'+alarmLevel+'['+(checkboxNums-1)+'].id" name="tbAlAlarmSettingsList'+alarmLevel+'['+(checkboxNums-1)+'].id"/>';
    		htm += '<input  name="tbAlAlarmSettingsList'+alarmLevel+'['+(checkboxNums-1)+'].alarmUserId" id="alarmUserId'+(checkboxNums-1)+'"  type="hidden" value="'+obj[k].value+'"/>';
    		htm+=obj[k].nextSibling.nodeValue+":"
            var json = [{"value":"1","label":"邮件"},{"value":"2","label":"短信"},{"value":"3","label":"语音"},{"value":"4","label":"弹窗"},{"value":"5","label":"接收全部告警"},{"value":"1","label":"播放一次"},{"value":"2","label":"反复播放"}];
            for(var i=0;i<json.length;i++){
            	if(i<5){
            		if(i<=3){
        	    		if(i==2){
        	    			htm += '<input checked="checked" name="tbAlAlarmSettingsList'+alarmLevel+'['+(checkboxNums-1)+'].alarmMode" type="checkbox" value="'+json[i].value+'" onchange="change(\''+(checkboxNums-1)+'\',\''+alarmLevel+'\')">'+json[i].label;
        	    		}else{
        	    			htm += '<input checked="checked" name="tbAlAlarmSettingsList'+alarmLevel+'['+(checkboxNums-1)+'].alarmMode"  type="checkbox" value="'+json[i].value+'">'+json[i].label;
        	    		}
            		}else{
            			htm += '<input type="checkbox" name="tbAlAlarmSettingsList'+alarmLevel+'['+(checkboxNums-1)+'].alarmMode"  value="'+json[i].value+'">'+json[i].label;
            		}
            	}else{
            		if(i==5){
            			htm+='<span id="raid'+alarmLevel+''+(checkboxNums-1)+'">';
            			htm+='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;语音播放设置：';
            			htm += '<input type="radio" checked="checked" name="tbAlAlarmSettingsList'+alarmLevel+'['+(checkboxNums-1)+'].voicePlaySettings" value="'+json[i].value+'">'+json[i].label;
            		}
            		if(i==6){
            			htm += '<input type="radio" name="tbAlAlarmSettingsList'+alarmLevel+'['+(checkboxNums-1)+'].voicePlaySettings" value="'+json[i].value+'">'+json[i].label;
            			htm+='</span>';
            		}
            	}
            }
            //htm+='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="delRow(\''+obj[k].value+'\',\''+alarmLevel+'\',\''+(checkboxNums-1)+'\')">删除</a>';
            htm+='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div><div style="float: left;width: 29%;"><span style="float: right;"><input type="button" name="shanchuname" class="button" onclick="delRow(\''+obj[k].value+'\',\''+alarmLevel+'\',\''+(checkboxNums-1)+'\')" value="删除" style="width: 50px;height: 22px;font-size: 13px; "/>';
            htm+='</span></div></div>';
            if(useridsSp[0]!=null&&useridsSp[0]!=""){
	            if(useridsSp&&useridsSp.length>0){
           			if(userids.indexOf(obj[k].value) != -1){
           				htm="";
           			}else{
           				userids+=","+obj[k].value;
           			}
	            }
    		}
            $("#yx"+alarmLevel).append(htm);
            htm = "";
    	}
    }
    if((useridsSp[0]==""||useridsSp[0] == null)&&useridsSp.length==1){
    		userids+=check_val;
    }
    useridsObj.val(userids);
}
function change(value,alarmLevel){
	 var ids = document.getElementsByName("tbAlAlarmSettingsList"+alarmLevel+"["+value+"].alarmMode");               
     if((ids[2].value==3) && ids[2].checked){
    	 $("#raid"+alarmLevel+value).show();
     }else{
    	 $("#raid"+alarmLevel+value).hide();
    	 var radios = document.getElementsByName("tbAlAlarmSettingsList"+alarmLevel+"["+value+"].voicePlaySettings");
    	 for(var i=0;i<radios.length;i++){
    		 radios[i].checked = false;
    		 radios[i].removeAttribute('checked');
    	 }
    	 
     }
}
//保存方法
function saves(alarmLevel){
	$.ajax({
        cache: true,
        type: "POST",
        url:"tbAlAlarmSettingsController.do?doAdd&alarmLevel="+alarmLevel,
        data:$("form").serialize(),
        dataType:"json",
        async: false,
        error: function(datas) {
         	var data = eval(datas);
             alert(data.msg);
        },
        success: function(datas) {
        	var data = eval(datas);
        	alert(data.msg);
        	location.reload(true);
        }
    });
}
function delRow(alarmUserId,alarmLevel,status){
	var useridsObj = $("#userids"+alarmLevel).val();
	useridsObj = useridsObj.replace(alarmUserId, "");
	useridsObj = useridsObj.replace(",,", ",");
	if (useridsObj.charAt(0) == ',') {
		useridsObj = useridsObj.substr(1, (useridsObj.length - 1));
	}
	if (useridsObj.charAt(useridsObj.length - 1) == ',') {
		useridsObj = useridsObj.substr(0, (useridsObj.length - 1));
	}
	$("#userids"+alarmLevel).val(useridsObj);
	 var elem = document.getElementById("div"+alarmLevel+status);
     elem.parentNode.removeChild(elem);
}
</script>
		