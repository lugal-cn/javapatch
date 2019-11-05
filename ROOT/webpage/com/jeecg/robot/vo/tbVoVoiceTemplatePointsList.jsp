<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbVoVoiceTemplatePointsList" checkbox="true" pagination="true" fitColumns="true" title="tb_vo_voice_template_points" actionUrl="tbVoVoiceTemplatePointsController.do?datagrid" idField="id" sortName="id" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="语音模板ID"  field="voiceTemplateId"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="巡检点编号"  field="patrolPointsNo"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="巡检点语音文本"  field="patrolPointsText"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="X坐标"  field="xCoordinate"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="Y坐标"  field="yCoordinate"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tbVoVoiceTemplatePointsController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbVoVoiceTemplatePointsController.do?goAdd" funname="add"  width="768"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbVoVoiceTemplatePointsController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbVoVoiceTemplatePointsController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbVoVoiceTemplatePointsController.do?goUpdate" funname="detail"  width="768"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbVoVoiceTemplatePointsController.do?upload', "tbVoVoiceTemplatePointsList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbVoVoiceTemplatePointsController.do?exportXls","tbVoVoiceTemplatePointsList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbVoVoiceTemplatePointsController.do?exportXlsByT","tbVoVoiceTemplatePointsList");
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
