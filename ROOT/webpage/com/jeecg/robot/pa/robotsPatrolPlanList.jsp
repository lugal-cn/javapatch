<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="robotsPatrolPlanList" checkbox="false" pagination="true" fitColumns="true" 
  	title="巡检计划" actionUrl="tbPaPatrolPlanController.do?robotsPatrolPlanDatagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group" width="120"></t:dgCol>
   <t:dgCol title="机器人名称" field="robotsId" dictionary="tb_ro_robots_info,id,robots_name" query="true" width="120"></t:dgCol>
   <t:dgCol title="当前巡检计划" field="planName"  queryMode="single" width="120"></t:dgCol>
   <t:dgCol title="机器人名称" field="robotsName" hidden="true" width="120"></t:dgCol>
   <t:dgCol title="创建时间" field="createTime" hidden="true" width="120"></t:dgCol>
   <t:dgCol title="巡检计划数量" field="planCount"  queryMode="group" width="120"></t:dgCol>
   <t:dgCol title="查看巡检计划" field="opt" width="140"></t:dgCol>
   <t:dgFunOpt title="管理" funname="patrolPlanList(id,robotsName)" urlclass="ace_button" ></t:dgFunOpt>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 $("#robotsPatrolPlanListtb").find("span")[3].style.width="100px"; 
 });
 
 //查询巡检计划列表
 function patrolPlanList(id,robotsName) {
	var url = 'tbPaPatrolPlanController.do?list&id='+id;
	addOneTab(robotsName+'巡检计划', url);
 }

</script>
