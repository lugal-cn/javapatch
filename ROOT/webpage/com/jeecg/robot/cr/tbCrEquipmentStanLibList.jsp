<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbCrEquipmentStanLibList" checkbox="true" pagination="true" fitColumns="true" title="设备标准库" actionUrl="tbCrEquipmentStanLibController.do?datagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="设备类型"  field="equipmentType" dictionary="itacs_equipment_type" query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="设备型号"  field="equipmentModel"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="厂商"  field="equipmentManufacturer"  query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="宽度(mm)"  field="equipmentSize"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="高度(mm)"  field="equipmentHeight"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgToolBar title="删除"  icon="icon-remove" url="tbCrEquipmentStanLibController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbCrEquipmentStanLibController.do?upload', "tbCrEquipmentStanLibList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbCrEquipmentStanLibController.do?exportXls","tbCrEquipmentStanLibList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbCrEquipmentStanLibController.do?exportXlsByT","tbCrEquipmentStanLibList");
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

/**
 * 多记录刪除請求
 * @param title
 * @param url
 * @param gname
 * @return
 */
function deleteALLSelect(title,url,gname) {
	gridname=gname;
    var ids = [];
    var rows = $("#"+gname).datagrid('getSelections');
    if (rows.length > 0) {
    	$.dialog.setting.zIndex = getzIndex(true);
    	$.dialog.confirm('请确认是否要删除？删除设备型号后，可能导致设备信息需要修改！', function(r) {
		   if (r) {
				for ( var i = 0; i < rows.length; i++) {
					ids.push(rows[i].id);
				}
				$.ajax({
					url : url,
					type : 'post',
					data : {
						ids : ids.join(',')
					},
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if (d.success) {
							var msg = d.msg;
							tip(msg);
							reloadTable();
							$("#"+gname).datagrid('unselectAll');
							ids='';
						}
					}
				});
			}
		});
	} else {
		tip($.i18n.prop('del.selectData.tip'));
	}
}
</script>
