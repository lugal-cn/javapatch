<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
$(function() {
    var datagrid = $("#tbAlAlarmInfoListtb");
    datagrid.find("div[name='searchColums']").find("form#tbAlAlarmInfoListForm").append($("#tempSearchColums div[name='searchColums']").html());
    $("#tempSearchColums").html('');
    
});
</script>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
    <div id="tempSearchColums" >
    <div name="searchColums">
      	<span style="max-width: 79%;display: inline-block;margin-left:27px">告警时间：<input name="alarmTime_begin_tb" id="alarmTime_begin_tb" type="text" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'alarmTime_end_tb\')}'})"  />
      	~
      	<input name="alarmTime_end_tb" id="alarmTime_end_tb" type="text" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'alarmTime_begin_tb\')}'})" /></span>
    </div>
   </div>
  <t:datagrid name="tbAlAlarmInfoList" checkbox="true" pagination="true" fitColumns="true" title="告警信息" actionUrl="tbAlAlarmInfoController.do?datagrid" idField="id" sortName="alarmTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  ></t:dgCol>
   <t:dgCol title="告警编号"  field="alarmNo"  queryMode="group"  width="100"></t:dgCol>
   <t:dgCol title="告警时间"  field="alarmTime"  formatter="yyyy-MM-dd hh:mm:ss"  queryMode="group"  width="120"></t:dgCol>	
   <t:dgCol title="告警级别"  field="alarmLevelName"   query="true"  queryMode="single"  width="80"></t:dgCol>
   <t:dgCol title="所属机房"  field="computerRoomName"  query="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="机柜编号"  field="cabineNo"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机器人名称"  field="robotsInfoName"  query="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="告警类型"  field="alarmType"  dictionary="itacs_alarmType" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="处理状态"  field="handStatus" dictionary="itacs_handStatus" query="false" hidden="true" queryMode="single"  width="80"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   
  <%-- <t:dgDelOpt title="删除" url="tbAlAlarmInfoController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/> --%>
  <%-- <t:dgToolBar title="查看" icon="icon-search" url="tbAlAlarmInfoController.do?goUpdate" funname="detail"  width="800" height="500"></t:dgToolBar>    --%>
  <%--  <t:dgToolBar title="录入" icon="icon-add" url="tbAlAlarmInfoController.do?goAdd" funname="add"  width="800" height="500"></t:dgToolBar>  --%>
   <t:dgFunOpt title="查看" funname="check(id,alarmType)" urlclass="ace_button" urlfont="fa-search" />
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
 <%--   <t:dgToolBar title="修正" icon="icon-edit"  funname="update()"  width="1200" height="500"></t:dgToolBar> --%>
 <%--<t:dgToolBar title="批量删除"  icon="icon-remove" url="tbAlAlarmInfoController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar> 
     <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar> 
     <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>  --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 
//调整日期格式
 $(function() {
     $("input[name='alarmTime_begin']").attr("class", "Wdate");
     $("input[name='alarmTime_end']").attr("class", "Wdate"); //Wdate

     $("input[name='alarmTime_begin']").focus(function() {
         WdatePicker({
             'isShowClear' : true,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'

         });
     });
     $("input[name='alarmTime_end']").focus(function() {
         WdatePicker({
             'isShowClear' : true,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'
         });
     });
 }); 

 
 
 
 
 
 $(document).ready(function(){
	 gridname="tbAlAlarmInfoList";
});

 //查看
 function check(id,alarmType){//check
   if(alarmType=='02'){
     addOneTab('指示灯告警详情','tbAlAlarmInfoController.do?indicatorCheck&id='+id,800,1200);
       }
     else{
    	 addOneTab('动环告警详情','tbAlAlarmInfoController.do?check&id='+id,800,1200);
     }
 }
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbAlAlarmInfoController.do?upload', "tbAlAlarmInfoList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbAlAlarmInfoController.do?exportXls","tbAlAlarmInfoList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbAlAlarmInfoController.do?exportXlsByT","tbAlAlarmInfoList");
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
