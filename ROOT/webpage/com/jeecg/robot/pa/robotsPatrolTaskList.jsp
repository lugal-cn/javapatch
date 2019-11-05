<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="robotsPatrolTaskList" checkbox="true" pagination="true" fitColumns="true" 
  	title="巡检任务列表" actionUrl="tbPaPatrolTaskController.do?robotsPatrolTaskDatagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group" width="120"></t:dgCol>
   <t:dgCol title="机器人名称" field="robotsId" dictionary="tb_ro_robots_info,id,robots_name" query="true" width="120"></t:dgCol>
   <t:dgCol title="机器人名称" field="robotsName" hidden="true" width="120"></t:dgCol>
   <t:dgCol title="创建时间" field="createTime" hidden="true" width="120"></t:dgCol>
   <t:dgCol title="巡检任务数量" field="taskCount"  queryMode="group" width="120"></t:dgCol>
   <t:dgCol title="查看巡检任务" field="opt" width="140"></t:dgCol>
   <t:dgFunOpt title="管理" funname="patrolTaskList(id,robotsName)" urlclass="ace_button" ></t:dgFunOpt>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 $("#robotsPatrolTaskListtb").find("span")[3].style.width="100px"; 
 });
 
 //查询巡检任务列表
 function patrolTaskList(id,robotsName) {
	var url = 'tbPaPatrolTaskController.do?list&id='+id;
	addOneTab(robotsName+'巡检任务', url);
 }

</script>
