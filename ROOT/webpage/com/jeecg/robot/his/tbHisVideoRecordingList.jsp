<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script>
$(function() {
    var datagrid = $("#tbHisVideoRecordingListtb");
    datagrid.find("div[name='searchColums']").find("form#tbHisVideoRecordingListForm").append($("#tempSearchColums div[name='searchColums']").html());
    $("#tempSearchColums").html('');
    
});
</script>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <div id="tempSearchColums" >
    <div name="searchColums">
      	时间：<input name="fileTime_begin_tb" id="fileTime_begin_tb" type="text" class="Wdate" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'fileTime_end_tb\')}'})"  />
      	~
      	<input name="fileTime_end_tb" id="fileTime_end_tb" type="text" class="Wdate" onClick="WdatePicker({minDate:'#F{$dp.$D(\'fileTime_begin_tb\')}'})" />
    </div>
   </div>
  <t:datagrid name="tbHisVideoRecordingList" checkbox="true" pagination="true" fitColumns="true" title="录像历史数据" actionUrl="tbHisVideoRecordingController.do?datagrid" idField="id" sortName="id" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机房名称"  field="computerRoomId" dictionary="tb_cr_computer_room,id,computer_room_name" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机器人名称"  field="robotsInfoIp" dictionary="tb_ro_robots_info,robots_ip,robots_name"  query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作人"  field="createBy"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="时间"  field="fileTime"  queryMode="group" formatter="yyyy-MM-dd hh:mm:ss" width="120"></t:dgCol>
   <t:dgCol title="文件路径"  field="fileUrl"  hidden="true"   queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgFunOpt title="播放"  funname="setPlayVideo(id,fileUrl,createBy)" urlclass="ace_button" urlfont="fa-play-circle" />
   <t:dgDelOpt title="删除" url="tbHisVideoRecordingController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   
   <%-- <t:dgToolBar title="录入" icon="icon-add" url="tbHisVideoRecordingController.do?goAdd" funname="add"  width="768"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbHisVideoRecordingController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbHisVideoRecordingController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbHisVideoRecordingController.do?goUpdate" funname="detail"  width="768"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 
 <script type="text/javascript">
 
 //日期格式
 $(function() {
     $("input[name='fileTime_begin']").attr("class", "Wdate");
     $("input[name='fileTime_end']").attr("class", "Wdate"); //Wdate

     $("input[name='fileTime_begin']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'

         });
     });
     $("input[name='fileTime_end']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'
         });
     });
 }); 
 
 
 $(document).ready(function(){

	 $("#tbHisVideoRecordingListtb").find("span")[3].style.width="100px"; 
 });
 queryinster();
 function setPlayVideo(id,fileUrl,createBy){
	 var str=fileUrl.replace(/\&/g,"%26");
	 openwindow('视频播放','tbHisVideoRecordingController.do?playVideo&id='+id+'&fileUrl='+str+'&createBy'+createBy,'tbHisVideoRecordingList',800,400);
 }

 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbHisVideoRecordingController.do?upload', "tbHisVideoRecordingList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbHisVideoRecordingController.do?exportXls","tbHisVideoRecordingList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbHisVideoRecordingController.do?exportXlsByT","tbHisVideoRecordingList");
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
function queryinster(){
 	 $.ajax({
		url:'tbHisVideoRecordingController.do?robotsIpSelect',
		type:'GET',
		dataType:'JSON',
		cache: false,
		async:false,
		success: function(datas){
		  for(var i=0;i<datas.length;i++){
			 $.ajax({
					url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient1",
					type : 'post',
					data: JSON.stringify({interfaceNo:"getVideoList",robot_ip:datas[i].robotsIp}),
					datatype:'json',
					cache : false,
					async:false,
					error:function(){
				    },
					success : function(data) {
					}
				}); 
		 } 
		}
	});  
 	tbHisVideoRecordingListsearch();
}


</script>
