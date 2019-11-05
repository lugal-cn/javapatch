<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbCrEquipmentList" checkbox="true" pagination="true" fitColumns="true" title="设备信息" actionUrl="tbCrEquipmentController.do?datagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="设备编号"  field="equipmentNo"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属机房"  field="computerRoomId" query="true" queryMode="single" dictionary="tb_cr_computer_room,id,computer_room_name" width="120"></t:dgCol>
   <t:dgCol title="所属机柜"  field="cabineNo" dictionary="tb_cr_cabine,id,cabine_no" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="U位信息起始位"  field="uBitStart"  queryMode="single"  width="150"></t:dgCol>
   <t:dgCol title="U位信息结束位"  field="uBitEnd"  queryMode="single" hidden="true" width="150"></t:dgCol>
   <t:dgCol title="设备名称"  field="equipmentName"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="设备型号"  field="equipmentModel"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="设备类型"  field="equipmentType" dictionary="itacs_equipment_type"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="设备IP"  field="equipmentIp"  queryMode="single"  width="150"></t:dgCol>
   <t:dgCol title="设备等级"  field="equipmentGrade" dictionary="itacs_equipment_grade" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属部门"  field="deptId"  dictionary="t_s_depart,id,departname" queryMode="single" width="120"></t:dgCol>
   <t:dgCol title="设备状态"  field="equipmentStatus" dictionary="itacs_equipment_status" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="正面基准照"  field="positiveReferenceUrl" formatterjs="lookPhoto" queryMode="single"   width="120"></t:dgCol>
   <t:dgCol title="背面基准照"  field="backDatumUrl"  queryMode="single" formatterjs="lookPhoto" width="120"></t:dgCol>	
   <t:dgCol title="创建时间"  field="createTime"  hidden="true" queryMode="single"  width="120"></t:dgCol>	
   <t:dgToolBar title="添加" icon="icon-add" url="tbCrEquipmentController.do?goAdd" funname="add"  width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="复制新增" icon="icon-edit" url="tbCrEquipmentController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit"  funname="update1"  width="768"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search"  funname="detail"  width="768"></t:dgToolBar>
   <t:dgToolBar title="删除"  icon="icon-remove" url="tbCrEquipmentController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 gridname="tbCrEquipmentList";
 });
 
 //添加
 function add() {
	 var framename = window.frameElement.name;
	 var url = 'tbCrEquipmentController.do?goAdd';
	 url += '&framename='+framename;
	 addOneTab('添加设备', url);
 }
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbCrEquipmentController.do?upload', "tbCrEquipmentList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbCrEquipmentController.do?exportXls","tbCrEquipmentList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbCrEquipmentController.do?exportXlsByT","tbCrEquipmentList");
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

function lookPhoto(value,row,index){
	var id = row.id;
	if(value){
		return  '<a href="javascript:void(0)" onclick="showPhoto(\'' +value+ '\')">查看</a>';
	}
}

 function showPhoto(value){
	openwindow("查看","tbCrEquipmentController.do?viewPic&value="+value,'tbCrEquipmentList',800,400);
} 
 //复制新增
 function update(){
	 var id= getSelected("id");
		if(id!=""){
		 var framename = window.frameElement.name;
		 var url = 'tbCrEquipmentController.do?goUpdate&id='+id;
		 url += '&framename='+framename;
		 addOneTab('复制新增', url);
		}else{
			tip("请选中一行数据");
		}
 }
 
//更新
 function update1() {
	 var id= getSelected("id");
	if(id!=""){
	 var framename = window.frameElement.name;
	 var url = 'tbCrEquipmentController.do?goUpdate1&id='+id;
	 url += '&framename='+framename;
	 addOneTab('修改设备信息', url);
	}else{
		tip("请选中一行数据");
	}
 }
 
//查看详情
 function detail() {
	 var id= getSelected("id");
	if(id!=""){
	 var framename = window.frameElement.name;
	 var url = 'tbCrEquipmentController.do?goUpdate12&id='+id;
	 url += '&framename='+framename;
	 url += '&openType=1';
	 addOneTab('查看设备信息', url);
	}else{
		tip("请选中一行数据");
	}
 }
 
</script>
