<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbVoVoiceTemplateList" checkbox="true" pagination="true" fitColumns="true" 
  	title="语音播报" actionUrl="tbVoVoiceTemplateController.do?datagrid&robotsInfoId=${id}" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="所属机器人"  field="robotsInfoId" query="false" queryMode="single" dictionary="tb_ro_robots_info,id,robots_name"  width="120"></t:dgCol>
   <t:dgCol title="模板名称"  field="voiceTemplateName"  queryMode="single" query="true"  width="120"></t:dgCol>
   <t:dgCol title="语音播报点数量"  field="voicePointsNum"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="备注"  field="voiceTemplateDesc"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="状态"  field="voiceTemplateStatus"  dictionary="itacs_templateStatus" queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
  <%--  <t:dgCol title="创建人"  field="createUserId"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建部门"  field="createDept"  queryMode="group"  width="120"></t:dgCol> --%>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgFunOpt title="启用" funname="statusChange(id,robotsInfoId)" exp="voiceTemplateStatus#eq#2" urlclass="ace_button" ></t:dgFunOpt>
   <t:dgFunOpt title="停用" funname="statusChange(id,robotsInfoId)" exp="voiceTemplateStatus#eq#1" urlclass="ace_button" ></t:dgFunOpt>
   <t:dgDelOpt title="删除" url="tbVoVoiceTemplateController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbVoVoiceTemplateController.do?goAdd&robotsInfoId=${id}" funname="add"  width="1000"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbVoVoiceTemplateController.do?goUpdate&robotsInfoId=${id}&voiceTemplateStatus=${voiceTemplateStatus}" funname="update"  width="1000"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbVoVoiceTemplateController.do?goUpdate" funname="detail"  width="1000"></t:dgToolBar>
  <%--<t:dgToolBar title="批量删除"  icon="icon-remove" url="tbVoVoiceTemplateController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbVoVoiceTemplateController.do?goUpdate" funname="detail"  width="768"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>--%>
  </t:datagrid> 
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 $("#tbVoVoiceTemplateListtb").find("span")[3].style.width="90px";
	 gridname="tbVoVoiceTemplateList";
	 
 });
 var robotId = '${id}'; //机器人ID
 //添加
 function add() {
	 var framename = window.frameElement.name;
	 var url = 'tbVoVoiceTemplateController.do?goAdd&robotsInfoId='+robotId;
	 url += '&framename='+framename;
	 addOneTab('添加语音播报', url);
 }
//更新
 function update() {
	var rows = $("#tbVoVoiceTemplateList").datagrid('getSelections');
	if (!rows || rows.length==0) {
		tip($.i18n.prop('edit.selectItem'));
		return;
	}
    if (rows.length == 1) {
    	 var url = 'tbVoVoiceTemplateController.do?goUpdate&id='+rows[0].id+'&openType=2&voiceTemplateStatus='+rows[0].voiceTemplateStatus;
    	 var framename = window.frameElement.name;
    	 url += '&framename='+framename;
    	 addOneTab('修改语音播报', url);
    }else{
 	   tip('请选择一条记录再编辑');
    }
 }
//查看
 function detail() {
	 var rows = $("#tbVoVoiceTemplateList").datagrid('getSelections');
	 if (!rows || rows.length==0) {
			tip($.i18n.prop('read.selectItem'));
			return;
		}
    if (rows.length == 1) {
    	 var url = 'tbVoVoiceTemplateController.do?goUpdate&id='+rows[0].id+'&openType=1';
    	 addOneTab('查看语音播报', url);
    }else{
 	   tip('请选择一条记录再查看');
    }
 }
 //语音状态编辑
 function statusChange(id,obj){
	 $.dialog.confirm('请确认是否调整模板状态', function(r) {
		if (r) {
		   	$.ajax({
			url:'tbVoVoiceTemplateController.do?statusChange&id='+id+'&robotsInfoId='+obj,
			type:'post',
			data:{},
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				var msg = d.msg;
				if(d.obj){//该机器人中有启动的模板时
					var datas={};
					$.ajax({
						url:'tbVoVoiceTemplateController.do?getvoiceforpoilist&robotsInfoId='+obj,
						type:'GET',
						dataType:'JSON',
						async:false, 
						delay: 250,
						cache: true,
						success: function(data){	
							datas=data[0];
						}
					});
					//调用接口:语音播报模版设置voiceforpoi
					 datas.interfaceNo="voiceforpoi";
					$.ajax({
						url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
						type : 'post',
						data: JSON.stringify(datas),
						datatype:'json',
						cache : false,
						async:false,
						success : function(data) {
							var d = $.parseJSON(data);
							if(d) {
								if (d.ErrorNo == '0') {
									msg = msg+";语音播报模版设置成功";
								} else if(d.ErrorNo == '-1') {
									msg =msg+ ";语音播报模版设置失败";
								} else if(d.ErrorNo == '1') {
									msg = msg+";语音播报模版设置执行中";
								} else {
									//其他
								}
								
								
							} else {
								if (data.ErrorNo == '0') {
									msg =msg+";语音播报模版设置成功";
								} else if(data.ErrorNo == '-1') {
									msg = msg+";语音播报模版设置失败";
								} else if(data.ErrorNo == '1') {
									msg = msg+";语音播报模版设置执行中";
								} else {
									//其他
								}
								
								
							}
							tip(msg);
						}
					});
				}else{
					tip(msg);
				}
				reloadTable();
			}
		})
	}
  });
 }
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbVoVoiceTemplateController.do?upload', "tbVoVoiceTemplateList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbVoVoiceTemplateController.do?exportXls","tbVoVoiceTemplateList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbVoVoiceTemplateController.do?exportXlsByT","tbVoVoiceTemplateList");
}

//bootstrap列表图片格式化
function btListImgFormatter(value,row,index){
	return listFileImgFormat(value,"image");
}
//bootstrap列表文件格式化
function btListFileFormatter(value,row,index){
	return listFileImgFormat(value);
}

//列表文件图片 列格式化方法
function listFileImgFormat(value,type){
	var href='';
	if(value==null || value.length==0){
		return href;
	}
	var value1 = "img/server/"+value;
	if("image"==type){
 		href+="<img src='"+value1+"' width=30 height=30  onmouseover='tipImg(this)' onmouseout='moveTipImg()' style='vertical-align:middle'/>";
	}else{
 		if(value.indexOf(".jpg")>-1 || value.indexOf(".gif")>-1 || value.indexOf(".png")>-1){
 			href+="<img src='"+value1+"' onmouseover='tipImg(this)' onmouseout='moveTipImg()' width=30 height=30 style='vertical-align:middle'/>";
 		}else{
 			var value2 = "img/server/"+value+"?down=true";
 			href+="<a href='"+value2+"' class='ace_button' style='text-decoration:none;' target=_blank><u><i class='fa fa-download'></i>点击下载</u></a>";
 		}
	}
	return href;
}

</script>
