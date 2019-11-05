<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
$(function() {
    var datagrid = $("#tbHisPatrolListtb");
    datagrid.find("div[name='searchColums']").find("form#tbHisPatrolListForm").append($("#tempSearchColums div[name='searchColums']").html());
    $("#tempSearchColums").html('');
    
});
</script>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <div id="tempSearchColums" >
    <div name="searchColums">
      	创建时间：<input name="createTime_begin_tb" id="createTime_begin_tb" type="text" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'createTime_end_tb\')}'})"  />
      	~
      	<input name="createTime_end_tb" id="createTime_end_tb" type="text" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'createTime_begin_tb\')}'})" />
    </div>
   </div>
  <t:datagrid name="tbHisPatrolList" checkbox="true" pagination="true" fitColumns="true" title="巡检历史"
   actionUrl="tbHisPatrolController.do?datagrid" idField="id"  sortName="patrolStartTime" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="所属机器人"  field="robotsInfoName"  query="true" dictionary="tb_his_patrol,distinct robots_info_name,robots_info_name" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属机房"  field="computerRoomName"  queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="巡检类型"  field="patrolTaskTypeName"  query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="巡检任务"  field="patrolTaskName"        query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="巡检开始时间"  field="patrolStartTime"   queryMode="single"  width="140"></t:dgCol>
   <t:dgCol title="巡检结束时间"  field="patrolEndTime"   queryMode="single"  width="140"></t:dgCol>
   <t:dgCol title="完成比例(%)"  field="completionRate"  queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="停检位置"  field="stopLocation"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="告警数量"  field="alarmNum"  queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime"   formatter="yyyy-MM-dd hh:mm:ss"   queryMode="group"  width="140"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgFunOpt title="查看" funname="check(id,computerRoomId)" urlclass="ace_button" urlfont="fa-search" />
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 
 
 /* //日期格式
 $(function() {
     $("input[name='createTime_begin']").attr("class", "Wdate");
     $("input[name='createTime_end']").attr("class", "Wdate"); //Wdate

     $("input[name='createTime_begin']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'

         });
     });
     $("input[name='createTime_end']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'
         });
     });
 });  */

 
 
 
 
 
 $(document).ready(function(){
	 $("#tbHisPatrolListtb").find("span")[3].style.width="100px"; 
 });
 
//查看
 function check(id,computerRoomId){//check
     addOneTab('日常巡检详情','tbHisPatrolRecordController.do?list&id='+id+'&computerRoomId='+computerRoomId);
 }
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbHisPatrolController.do?upload', "tbHisPatrolList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbHisPatrolController.do?exportXls","tbHisPatrolList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbHisPatrolController.do?exportXlsByT","tbHisPatrolList");
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
