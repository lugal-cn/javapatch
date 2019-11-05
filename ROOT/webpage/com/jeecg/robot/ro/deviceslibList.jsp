<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbRoRobotsFirmwareList" checkbox="false" pagination="true" fitColumns="true" title="机器人固件表" actionUrl="tbRoRobotsFirmwareController.do?devicesliDatagrid" idField="id" sortName="id" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="设备表名称"  field="firmwareVersion"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="固件文件路径"  field="firmwareFileUrl" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="上传人"  field="uploadUserId" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="上传时间"  field="uploadTime"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="预留字段"  field="bak"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tbRoRobotsFirmwareController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tbRoRobotsFirmwareController.do?goAddDeviceslib&robotsInfoId=${robotsInfoId}" funname="add"  width="768"></t:dgToolBar>
   <t:dgToolBar title="下发" icon="icon-putout" url="tbRoRobotsFirmwareController.do?doUpdate&robotsInfoId=${robotsInfoId}" funname="update"  width="768"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 var robotsInfoId = '${robotsInfoId}';
 $(document).ready(function(){
 });
 
 /**
  * 升级
  * @param addurl//目标页面地址
  * @param id//主键字段
  */
 function update(title,url, id,width,height,isRestful) {
 	gridname=id;
 	var rowsData = $('#'+id).datagrid('getSelections');
 	if (!rowsData || rowsData.length==0) {
 		tip('请选择一条数据下发');
 		return;
 	}
 	if (rowsData.length>1) {
 		tip('请选择一条数据下发');
 		return;
 	}
	var datasUp={};
	datasUp.url=rowsData[0].firmwareFileUrl;
 	datasUp.interfaceNo="deviceslib";
 	datasUp.robotId=robotsInfoId;
	// var id=rowsData[0].id;
 	//根据固件id获取固件的信息
 	var url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient"; //固件升级 调用机器人接口 TODO firmwareUpdate、
			$.ajax({
				url : url,
				type : 'post',
				data : JSON.stringify(datasUp),
				cache : false,
				success : function(data) {
					//reloadTable();
					var msg="";
					var d = $.parseJSON(data);
					if(d) {
						if (d.ErrorNo == '0') {
							msg = "设备下发接口成功";
						} else if(d.ErrorNo == '-1') {
							msg ="设备下发接口失败";
						} else if(d.ErrorNo == '1') {
							msg = "设备下发接口执行中";
						} else {
							//其他
						}
					} else {
						
						if (data.ErrorNo == '0') {
							msg ="设备下发接口成功";
						} else if(data.ErrorNo == '-1') {
							msg = "设备下发接口失败";
						} else if(data.ErrorNo == '1') {
							msg = "设备下发接口执行中";
						} else {
							//其他
						}	
					}
					tip(msg);
					reloadTable();
				}
			});
 }
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbRoRobotsFirmwareController.do?upload', "tbRoRobotsFirmwareList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbRoRobotsFirmwareController.do?exportXls","tbRoRobotsFirmwareList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbRoRobotsFirmwareController.do?exportXlsByT","tbRoRobotsFirmwareList");
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
