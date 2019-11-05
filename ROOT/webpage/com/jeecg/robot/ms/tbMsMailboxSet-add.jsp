<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>uitags</title>
<t:base type="jquery,easyui,tools,autocomplete,DatePicker"></t:base>
<!-- select2 -->
<link rel="stylesheet" href="plug-in/select2/css/select2.min.css">
<script type="text/javascript" src="plug-in/select2/js/select2.full.min.js"></script>
<SCRIPT type="text/javascript">
        function parse(data){
            	var parsed = [];
		        	$.each(data.rows,function(index,row){
		        		parsed.push({data:row,result:row,value:row.id});
		        	});
        				return parsed;
        }
        /**
         * 选择后回调 
         * 
         * @param {Object} data
         */
        function callBack(data) {
        	$("#user").val(data.userName);
        }
        
         /**
          * 每一个选择项显示的信息
          * 
          * @param {Object} data
          */
        function formatItem(data) {
        	return data.userName + "-->" + " " + data.realName;
        }
          
          function setContentc(){
        	  tip("保存成功");
        	  /* location.reload(true); */
          }
          function ssm(){
        	  location.reload();
          }
         
          $(document).ready(function() {
        		
        		$('#encryptionMode').change(function(){
        			var mm=document.getElementById("encryptionMode").value;
        			/* alert(mm);
        			  var xuanze=$(this).children('option:selected').val();
        			 alert(xuanze);  */
        			if(mm=="01"){
        				document.getElementById('mailboxPort').value='101';
        			}
        			if(mm=="02"){
        				document.getElementById('mailboxPort').value='202';
        			}
        			if(mm=="03"){
        				document.getElementById('mailboxPort').value='303';
        			}  
        		});
          });
          /*-------------------------------------------加密方式----------------------------------------------*/		
          var select2Data = new Array();
          $.ajax({
          	url:'tbMsMailboxSetController.do?encryptionModeSelect',
          	type:'GET',
          	dataType:'JSON',
          	delay: 250,
          	cache: true,
          	success: function(data){
          		for(var i = 0; i < data.length; i++){
          			var select2Obj = {};
          			select2Obj.id = data[i][0];
          			select2Obj.text = data[i][1];
          			select2Data.push(select2Obj);
          		}
          		$("#encryptionMode").select2({
          			data: select2Data,
          			placeholder:'请选择加密方式',//默认文字提示
          		    language: "zh-CN",//汉化
          		    allowClear: true//允许清空
          		});
          	}
          });
          /*-------------------------------------------加密方式----------------------------------------------*/
  </SCRIPT>
  </head>
  <body>
<t:formvalid formid="formobj" dialog="false" layout="div"  action="tbMsMailboxSetController.do?baocun" beforeSubmit="setContentc">
	 <fieldset class="step" style="padding-bottom: 20px;">
	 <legend>发送邮箱设置</legend>
	  <input type="hidden" id="id" name="id" value="${tbMsMailboxSet.id}"/>
		<div class="form">
			<label class="Validform_label"> 请输入SMTP服务器地址： </label> 
			<input type="text" name="smtpServerAddr" id="smtpServerAddr" datatype="*"  value="${tbMsMailboxSet.smtp_server_addr}"  errormsg="该字段不为空"> 
			<span class="Validform_checktip"></span>
		</div>
		<div class="form">
			<label class="Validform_label"> 邮箱账号： </label> 
			<input type="text" name="mailboxAccount" id="mailboxAccount" datatype="e" value="${tbMsMailboxSet.mailbox_account}" errormsg="请输入邮箱格式的内容"> 
			<span class="Validform_checktip"></span>
		</div>
		<div class="form">
			<label class="Validform_label"> 密码： </label> 
			<input type="text" name="mailboxPassword" id="mailboxPassword" value="${tbMsMailboxSet.mailbox_password}" datatype="*" errormsg="该字段不为空"> 
			<span class="Validform_checktip"></span>
		</div>
		<div class="form">
			<label class="Validform_label">加密方式：</label> 
			<input type="text" id="encryptionMode" name="encryptionMode" class="ac_input" datatype="*" value="${tbMsMailboxSet.encryption_mode}">
			<span class="Validform_checktip"></span>
		</div>
		<div class="form">
			<label class="Validform_label"> 端口： </label> 
			<input type="text" name="mailboxPort" id="mailboxPort"  value="${tbMsMailboxSet.mailbox_port}" datatype="*" errormsg="该字段不为空"> 
			<span class="Validform_checktip"></span>
		</div>

		<div style="text-align:center">
		<input class="btn" type="submit" value="保存" style="height:30px;width:100px !important;border-radius:5px">
		<input class="btn" type="button" onclick="ssm()" value="取消" style="height:30px;width:100px !important;border-radius:5px">
		</div>
		
	</fieldset>
</t:formvalid>
</body>
</html>
<t:authFilter />