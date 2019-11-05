<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
$(function() {
    var datagrid = $("#tbHisNoticeMessageListtb");
    datagrid.find("div[name='searchColums']").find("form#tbHisNoticeMessageListForm").append($("#tempSearchColums div[name='searchColums']").html());
    $("#tempSearchColums").html('');
    
});
</script>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <div id="tempSearchColums" >
    <div name="searchColums">
      	时间：<input name="noticeMessageTime_begin_tb" id="noticeMessageTime_begin_tb" type="text" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'noticeMessageTime_end_tb\')}'})"  />
      	~
      	<input name="noticeMessageTime_end_tb" id="noticeMessageTime_end_tb" type="text" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'noticeMessageTime_begin_tb\')}'})" />
    </div>
   </div>
  <t:datagrid name="tbHisNoticeMessageList" checkbox="true" pagination="true" fitColumns="true" title="通知消息历史" actionUrl="tbHisNoticeMessageController.do?datagrid" idField="id" sortName="noticeMessageTime" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="消息类型"  field="noticeMessageType"  dictionary="itacs_messageType" query="true" queryMode="single"  width="60"></t:dgCol>
   <t:dgCol title="所属机房"  field="computerRoomName" query="true" queryMode="single"  width="60"></t:dgCol>
   <t:dgCol title="时间"  field="noticeMessageTime"  formatter="yyyy-MM-dd hh:mm:ss"  queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="对象(机器人)"  field="robotsInfoName"  queryMode="single" query="true" dictionary="tb_his_patrol,distinct robots_info_name,robots_info_name"   width="60"></t:dgCol>
   <t:dgCol title="消息内容"  field="noticeMessageContent"  queryMode="single" query="true" width="320"></t:dgCol>
    <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <%-- <t:dgCol title="操作" field="opt" width="100"></t:dgCol> --%>
  <%--  <t:dgDelOpt title="删除" url="tbHisNoticeMessageController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/> --%>
  <%-- <t:dgToolBar title="录入" icon="icon-add" url="tbHisNoticeMessageController.do?goAdd" funname="add"  width="768"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbHisNoticeMessageController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbHisNoticeMessageController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>  --%>
  <%--  <t:dgToolBar title="查看" icon="icon-search" url="tbHisNoticeMessageController.do?goUpdate" funname="detail"  width="768"></t:dgToolBar> --%>
  <%--  <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar> --%>
   <%-- <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 
 //日期格式
 $(function() {
     $("input[name='noticeMessageTime_begin']").attr("class", "Wdate");
     $("input[name='noticeMessageTime_end']").attr("class", "Wdate"); //Wdate

     $("input[name='noticeMessageTime_begin']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'

         });
     });
     $("input[name='noticeMessageTime_end']").focus(function() {
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
	openuploadwin('Excel导入', 'tbHisNoticeMessageController.do?upload', "tbHisNoticeMessageList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbHisNoticeMessageController.do?exportXls","tbHisNoticeMessageList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbHisNoticeMessageController.do?exportXlsByT","tbHisNoticeMessageList");
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
