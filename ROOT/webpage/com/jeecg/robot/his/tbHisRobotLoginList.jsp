<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
$(function() {
    var datagrid = $("#tbHisRobotLoginListtb");
    datagrid.find("div[name='searchColums']").find("form#tbHisRobotLoginListForm").append($("#tempSearchColums div[name='searchColums']").html());
    $("#tempSearchColums").html('');
    
});
</script>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <div id="tempSearchColums" >
    <div name="searchColums">
      	<span style="max-width: 79%;display: inline-block;margin-left:27px">登录时间：<input name="loginTime_begin_tb" id="loginTime_begin_tb" type="text" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'loginTime_end_tb\')}'})"  />
      	~
      	<input name="loginTime_end_tb" id="loginTime_end_tb" type="text" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'loginTime_begin_tb\')}'})" /></span>
    </div>
   </div>
  <t:datagrid name="tbHisRobotLoginList" checkbox="true" pagination="true" fitColumns="true" title="机器人登录历史" actionUrl="tbHisRobotLoginController.do?datagrid" idField="id" sortName="loginTime" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="人脸图像"  field="imgUrl"  queryMode="group"  image="true" imageSize="10,10" formatterjs="btListImgFormatter" width="60"></t:dgCol> 
   <t:dgCol title="机器人"  field="robotsInfoName"  query="true" dictionary="tb_his_robot_login,distinct robots_info_name,robots_info_name" queryMode="single"  width="60"></t:dgCol>
   <t:dgCol title="机房"  field="computerRoomName"  query="true"  queryMode="single"  width="60"></t:dgCol>
   <t:dgCol title="登录账户"  field="tlrCode"  queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="姓名"  field="tlrName"  queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="部门名称"  field="deptName"  queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="角色"  field="roleName"   queryMode="group"  width="60"></t:dgCol>
   <t:dgCol title="登录时间"  field="loginTime"   formatter="yyyy-MM-dd hh:mm:ss" queryMode="group"  width="80"></t:dgCol>
   <t:dgCol title="登录方式"  field="loginMode" query="true" queryMode="single"  width="60"></t:dgCol>
   <t:dgCol title="登录状态"    field="loginStatus"  query="true" queryMode="single"  width="60"></t:dgCol>
   <%--  <t:dgCol title="操作" field="opt" width="100"></t:dgCol> --%>    
   <%--  <t:dgDelOpt title="删除"  url="tbHisRobotLoginController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbHisRobotLoginController.do?goAdd" funname="add"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbHisRobotLoginController.do?goUpdate" funname="update"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbHisRobotLoginController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbHisRobotLoginController.do?goUpdate" funname="detail"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar> --%>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
    <%-- <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 
 //日期格式
 $(function() {
     $("input[name='loginTime_begin']").attr("class", "Wdate");
     $("input[name='loginTime_end']").attr("class", "Wdate"); //Wdate

     $("input[name='loginTime_begin']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'

         });
     });
     $("input[name='loginTime_end']").focus(function() {
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
	openuploadwin('Excel导入', 'tbHisRobotLoginController.do?upload', "tbHisRobotLoginList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbHisRobotLoginController.do?exportXls","tbHisRobotLoginList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbHisRobotLoginController.do?exportXlsByT","tbHisRobotLoginList");
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
		href+="-";
		return href;
	}
	var value1 = "img/server/"+value;
	if("image"==type){
		if(value==null || value.length==0){
			href+="-";
		} else {
			href+="<img src='"+value1+"' width=20 height=20  onmouseover='tipImg(this)' onmouseout='moveTipImg()' style='vertical-align:middle'/>";
		}
 		
	}else{
 		if(value.indexOf(".jpg")>-1 || value.indexOf(".gif")>-1 || value.indexOf(".png")>-1){
 			href+="<img src='"+value1+"' onmouseover='tipImg(this)' onmouseout='moveTipImg()' width=20 height=20 style='vertical-align:middle'/>";
 		}else{
 			var value2 = "img/server/"+value+"?down=true";
 			href+="<a href='"+value2+"' class='ace_button' style='text-decoration:none;' target=_blank><u><i class='fa fa-download'></i>点击下载</u></a>";
 		}
	}
	return href;
}

</script>
