<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbPaPatrolPlanList" checkbox="true" pagination="true" fitColumns="true" 
  	title="巡检计划" actionUrl="tbPaPatrolPlanController.do?datagrid&robotsInfoId=${id}" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="所属机器人"  field="robotsInfoId" dictionary="tb_ro_robots_info,id,robots_name" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="巡检计划名称"  field="patrolPlanName"  queryMode="single" query="true"  width="120"></t:dgCol>
   <t:dgCol title="巡检任务数量"  field="patrolPlanNum"  queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="创建人"  field="createUserId" dictionary="t_s_base_user,id,realname"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="状态"  field="patrolPlanStatus"  dictionary="itacs_planStatus"  queryMode="group"   width="100"></t:dgCol>
     <t:dgCol title="创建时间"  field="createTime" hidden="true" queryMode="group"  width="120"></t:dgCol> 
   <%-- <t:dgCol title="创建部门"  field="createDept"  queryMode="group"  width="120"></t:dgCol> --%>
   <t:dgCol title="操作" field="opt" width="140"></t:dgCol>
  <%--  <t:dgFunOpt title="状态启用/停用" funname="statusChange(id)" urlclass="ace_button" ></t:dgFunOpt> --%>
   <t:dgFunOpt title="启用" funname="statusChange(id,robotsInfoId)" exp="patrolPlanStatus#eq#2" urlclass="ace_button" ></t:dgFunOpt>
   <t:dgFunOpt title="停用" funname="statusChange(id,robotsInfoId)" exp="patrolPlanStatus#eq#1" urlclass="ace_button" ></t:dgFunOpt>
   <t:dgDelOpt title="删除" url="tbPaPatrolPlanController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbPaPatrolPlanController.do?goAdd&robotsInfoId=${id}" funname="add"  width="1000"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbPaPatrolPlanController.do?goUpdate&robotsInfoId=${id}" funname="update"  width="1000"></t:dgToolBar>
    <t:dgToolBar title="查看" icon="icon-search" url="tbPaPatrolPlanController.do?goUpdate" funname="detail"  width="1000"></t:dgToolBar>
  <%--  <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbPaPatrolPlanController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
		 $("#tbPaPatrolPlanListtb").find("span")[3].style.width="100px";
		 gridname="tbPaPatrolPlanList";
 });
 
 var robotId = '${id}'; //机器人ID 
 
 //添加
 function add() {
	 var framename = window.frameElement.name;
	 var url = 'tbPaPatrolPlanController.do?goAdd&robotsInfoId='+robotId;
	 url += '&framename='+framename;
	 addOneTab('添加计划', url);
 }
 
//更新
 function update() {
	var rows = $("#tbPaPatrolPlanList").datagrid('getSelections');
	if (!rows || rows.length==0) {
		tip($.i18n.prop('edit.selectItem'));
		return;
	}
    if (rows.length == 1) {
    	var url = 'tbPaPatrolPlanController.do?goUpdate&id='+rows[0].id+'&openType=2';
   	 	var framename = window.frameElement.name;
   	 	url += '&framename='+framename;
   	 	addOneTab('修改计划', url);
    }else{
 	   tip('请选择一条记录再编辑');
    }
 }
 
//查看
 function detail() {
	 var rows = $("#tbPaPatrolPlanList").datagrid('getSelections');
	 if (!rows || rows.length==0) {
			tip($.i18n.prop('read.selectItem'));
			return;
		}
    if (rows.length == 1) {
    	 var url = 'tbPaPatrolPlanController.do?goUpdate&id='+rows[0].id+'&openType=1';
    	 addOneTab('查看计划', url);
    }else{
 	   tip('请选择一条记录再查看');
    }
 }
 
//下发巡检任务
 function insplan(id,robotsInfoId) {
	var msg = "";
	 var datas={};
		$.ajax({
			url:'tbPaPatrolPlanController.do?getPlaninforlist&robotsInfoId='+robotsInfoId,
			type:'GET',
			dataType:'JSON',
			async:false, 
			delay: 250,
			cache: true,
			success: function(data){
				datas=data[0];
			}
		});
		 datas.interfaceNo="insplan";
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
						msg = "获取巡检计划成功";
					} else if(d.ErrorNo == '-1') {
						msg = "获取巡检计划失败";
					} else if(d.ErrorNo == '1') {
						msg = "获取巡检计划执行中";
					} else {
						//其他
					}
				} else {
					if (data.ErrorNo == '0') {
						msg ="获取巡检计划成功";
					} else if(data.ErrorNo == '-1') {
						msg = "获取巡检计划失败";
					} else if(data.ErrorNo == '1') {
						msg = "获取巡检计划执行中";
					} else {
						//其他
					}
				}
				tip(msg);
			}
		});
 }
 
 
 //计划状态编辑
 function statusChange(id,robotsInfoId){
	 $.dialog.confirm('请确认是否调整计划状态', function(r) {
		if (r) {
		   	$.ajax({
			url:'tbPaPatrolPlanController.do?statusChange&id='+id+'&robotsInfoId='+robotsInfoId,
			type:'post',
			data:{},
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success) {
					var msg = d.msg;
					if(d.obj){//该机器人中有启动的计划时
						var datas={};
						$.ajax({
							url:'tbPaPatrolPlanController.do?getPlaninforlist&robotsInfoId='+robotsInfoId,
							type:'GET',
							dataType:'JSON',
							async:false, 
							delay: 250,
							cache: true,
							success: function(data){
								datas=data[0];
							}
						});
						 datas.interfaceNo="insplan";
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
										msg = msg+";获取巡检计划成功";
									} else if(d.ErrorNo == '-1') {
										msg =msg+ ";获取巡检计划失败";
									} else if(d.ErrorNo == '1') {
										msg = msg+";获取巡检计划执行中";
									} else {
										//其他
									}
								} else {
									if (data.ErrorNo == '0') {
										msg =msg+";获取巡检计划成功";
									} else if(data.ErrorNo == '-1') {
										msg = msg+";获取巡检计划失败";
									} else if(data.ErrorNo == '1') {
										msg = msg+";获取巡检计划执行中";
									} else {
										//其他
									}
									
								}
								tip(msg);
							}
						});
					}else{//停止巡检任务
						$.ajax({
							url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
							type : 'post',
							data: JSON.stringify({interfaceNo: "canselTaskPlan", plan_id: id, robotId: robotsInfoId}),
							datatype:'json',
							cache : false,
							async:false,
							success : function(data) {
								var d = $.parseJSON(data);
								if(d) {
									if (d.ErrorNo == '0') {
										msg = msg+";停用巡检计划成功";
									} else if(d.ErrorNo == '-1') {
										msg =msg+ ";停用巡检计划失败";
									} else if(d.ErrorNo == '1') {
										msg = msg+";停用巡检计划执行中";
									} else {
										//其他
									}
								} else {
									if (data.ErrorNo == '0') {
										msg =msg+";停用巡检计划成功";
									} else if(data.ErrorNo == '-1') {
										msg = msg+";停用巡检计划失败";
									} else if(data.ErrorNo == '1') {
										msg = msg+";停用巡检计划执行中";
									} else {
										//其他
									}
								}
								tip(msg);
							}
						});
					}
					reloadTable();
				}
			}
		})
	}
  });
 }

//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbPaPatrolPlanController.do?upload', "tbPaPatrolPlanList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbPaPatrolPlanController.do?exportXls","tbPaPatrolPlanList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbPaPatrolPlanController.do?exportXlsByT","tbPaPatrolPlanList");
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
