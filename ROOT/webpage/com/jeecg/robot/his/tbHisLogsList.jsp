<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
$(function() {
    var datagrid = $("#tbHisLogsListtb");
    datagrid.find("div[name='searchColums']").find("form#tbHisLogsListForm").append($("#tempSearchColums div[name='searchColums']").html());
    $("#tempSearchColums").html('');
    
});
</script>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <div id="tempSearchColums" >
    <div name="searchColums">
      	操作时间：<input name="operTime_begin_tb" id="operTime_begin_tb" type="text" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'operTime_end_tb\')}'})"  />
      	~
      	<input name="operTime_end_tb" id="operTime_end_tb" type="text" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'operTime_begin_tb\')}'})" />
    </div>
   </div>
  <t:datagrid name="tbHisLogsList" checkbox="true" pagination="true" fitColumns="true" title="" actionUrl="tbHisLogsController.do?datagrid" idField="id" sortName="id" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="用户"  field="userId" query="true" width="120"></t:dgCol>
   <t:dgCol title="真实姓名"  field="userName" query="true" width="120"></t:dgCol>
   <t:dgCol title="用户IP"  field="operIp"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作内容"  field="operContent"  query="true"  width="300"></t:dgCol>
   <t:dgCol title="操作时间"  field="operTime" formatter="yyyy-MM-dd hh:mm:ss" queryMode="group"  width="120"></t:dgCol>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 
 //日期格式
 $(function() {
     $("input[name='operTime_begin']").attr("class", "Wdate");
     $("input[name='operTime_end']").attr("class", "Wdate"); //Wdate

     $("input[name='operTime_begin']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'

         });
     });
     $("input[name='operTime_end']").focus(function() {
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
	openuploadwin('Excel导入', 'tbHisLogsController.do?upload', "tbHisLogsList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbHisLogsController.do?exportXls","tbHisLogsList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbHisLogsController.do?exportXlsByT","tbHisLogsList");
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
