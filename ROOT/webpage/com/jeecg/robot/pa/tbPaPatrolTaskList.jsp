<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbPaPatrolTaskList" checkbox="true" pagination="true" fitColumns="true" 
  	title="巡检任务列表" actionUrl="tbPaPatrolTaskController.do?datagrid&robotsInfoId=${id}" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="id"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="任务名称"  field="patrolTaskName"   queryMode="single" query="true" width="120" ></t:dgCol>
   <t:dgCol title="巡检类型"  field="patrolTaskType"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="所属机器人"  field="robotsInfoId" dictionary="tb_ro_robots_info,id,robots_name" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="巡检点数量"  field="patrolPointsNum"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机柜数量"  field="cabinetNumber"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="预计用时"  field="estimateTime"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="任务状态"  field="patrolTaskStatus"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建人"  field="createUserId" dictionary="t_s_base_user,id,realname" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建部门"  field="createDept"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tbPaPatrolTaskController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbPaPatrolTaskController.do?goAdd&robotsInfoId=${id}" funname="add"  width="1200" ></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbPaPatrolTaskController.do?goUpdate&robotsInfoId=${id}" funname="update"  width="1200"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbPaPatrolTaskController.do?goUpdate" funname="detail"  width="1200	"></t:dgToolBar>
  <%--  <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbPaPatrolTaskController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbPaPatrolTaskController.do?goUpdate" funname="detail"  width="768"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 gridname="tbPaPatrolTaskList";
 });
 
 var robotId = '${id}'; //机器人ID
 //添加
 function add() {
	 var framename = window.frameElement.name;
	 var url = 'tbPaPatrolTaskController.do?goAdd&robotsInfoId='+robotId;
	 url += '&framename='+framename;
	 addOneTab('添加任务', url);
 }
//更新
 function update() {
	var rows = $("#tbPaPatrolTaskList").datagrid('getSelections');
	if (!rows || rows.length==0) {
		tip($.i18n.prop('edit.selectItem'));
		return;
	}
    if (rows.length == 1) {
    	 var url = 'tbPaPatrolTaskController.do?goUpdate&id='+rows[0].id+'&openType=2';
    	 var framename = window.frameElement.name;
    	 url += '&framename='+framename;
    	 addOneTab('修改任务', url);
    }else{
 	   tip('请选择一条记录再编辑');
    }
 }
//查看
 function detail() {
	 var rows = $("#tbPaPatrolTaskList").datagrid('getSelections');
	 if (!rows || rows.length==0) {
			tip($.i18n.prop('read.selectItem'));
			return;
		}
    if (rows.length == 1) {
    	 var url = 'tbPaPatrolTaskController.do?goUpdate&id='+rows[0].id+'&openType=1';
    	 addOneTab('查看任务', url);
    }else{
 	   tip('请选择一条记录再查看');
    }
 }
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbPaPatrolTaskController.do?upload', "tbPaPatrolTaskList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbPaPatrolTaskController.do?exportXls","tbPaPatrolTaskList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbPaPatrolTaskController.do?exportXlsByT","tbPaPatrolTaskList");
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
