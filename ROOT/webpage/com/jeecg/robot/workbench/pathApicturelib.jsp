<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="apicturelibList" checkbox="false" pagination="true" fitColumns="true" 
  	title="" actionUrl="workbenchController.do?apicturelibDatagrid&robotIp=${robotIp}&fileType=${fileType}" idField="id" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true" width="120"></t:dgCol>
   <t:dgCol title="文件路径"  field="file_url"  hidden="true" width="120"></t:dgCol>
   <t:dgCol title="摄像头类型" field="file_type" width="120"></t:dgCol>
   <t:dgCol title="拍照时间" field="file_time" width="120"></t:dgCol>
   <t:dgCol title="拍照人" field="realname" width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="140"></t:dgCol>
   <t:dgFunOpt title="查看" funname="seeApicture(file_url)" urlclass="ace_button" ></t:dgFunOpt>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	// $("#robotsPatrolPlanListtb").find("span")[3].style.width="100px"; 
 });
 
 //查询巡检计划列表
 function seeApicture(file_url) {
	 openwindow("查看图片","workbenchController.do?seeApicture&pathApicture="+file_url,'',800,400);
 }

</script>
