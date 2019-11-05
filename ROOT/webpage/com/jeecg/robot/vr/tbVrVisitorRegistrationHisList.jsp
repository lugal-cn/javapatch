<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
$(function() {
    var datagrid = $("#tbVrVisitorRegistrationListtb");
    datagrid.find("div[name='searchColums']").find("form#tbVrVisitorRegistrationListForm").append($("#tempSearchColums div[name='searchColums']").html());
    $("#tempSearchColums").html('');
    
});
</script>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
   <div id="tempSearchColums" >
    <div name="searchColums">
      	<span style="max-width: 79%;display: inline-block;margin-left:27px">来访时间：<input name="visitorTime_begin_tb" id="visitorTime_begin_tb" type="text" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'visitorTime_end_tb\')}'})"  />
      	~
      	<input name="avisitorTime_end_tb" id="visitorTime_end_tb" type="text" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'visitorTime_begin_tb\')}'})" /></span>
    </div>
   </div>
  <t:datagrid name="tbVrVisitorRegistrationList" checkbox="true" pagination="true" fitColumns="true" title="" 
  actionUrl="tbVrVisitorRegistrationController.do?hisdatagrid" idField="id" sortName="visitorTime" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="访客姓名"  field="visitorName" query="true" width="100"></t:dgCol>
   <t:dgCol title="身份证号"  field="certNo" query="true" width="180"></t:dgCol>
   <t:dgCol title="手机"  field="mobilephone" query="true" width="100"></t:dgCol>
   <t:dgCol title="来访时间"  field="visitorTime" formatter="yyyy-MM-dd hh:mm:ss" queryMode="group"  width="150"></t:dgCol>
   <t:dgCol title="来访机房"  field="computerRoomIds" query="true" dictionary="tb_cr_computer_room,id,computer_room_name" width="120"></t:dgCol>
   <t:dgCol title="来访事由"  field="visitorReasons"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="审批人"  field="approver" dictionary="t_s_base_user,id,realname" width="80"></t:dgCol>
   <t:dgCol title="审批状态"  field="approvalStatus" dictionary="itacs_approval_status" width="80"></t:dgCol>
   <t:dgCol title="离开时间"  field="departureTime" width="150"></t:dgCol>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 
//日期格式
 $(function() {
     $("input[name='visitorTime_begin']").attr("class", "Wdate");
     $("input[name='visitorTime_end']").attr("class", "Wdate"); //Wdate

     $("input[name='visitorTime_begin']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'

         });
     });
     $("input[name='visitorTime_end']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'
         });
     });
 }); 
 
 
 $(document).ready(function(){
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbVrVisitorRegistrationController.do?upload', "tbVrVisitorRegistrationList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbVrVisitorRegistrationController.do?exportXls","tbVrVisitorRegistrationList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbVrVisitorRegistrationController.do?exportXlsByT","tbVrVisitorRegistrationList");
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
