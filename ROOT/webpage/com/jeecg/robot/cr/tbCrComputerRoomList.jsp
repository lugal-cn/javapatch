<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbCrComputerRoomList" checkbox="true" pagination="true" fitColumns="true" title="机房列表" actionUrl="tbCrComputerRoomController.do?datagrid" idField="id" sortName="createTime" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机房名称"  field="computerRoomName" query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="机器人数量"  field="robotsNumber"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机柜数量"  field="cabinetNumber"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <%-- <t:dgCol title="地图存储路径"  field="mapUrl"  hidden="true"  queryMode="group"  image="true" imageSize="50,50" formatterjs="btListImgFormatter" width="120"></t:dgCol>
   <t:dgCol title="创建人"  field="createUserId"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建部门"  field="createDept"  hidden="true"  queryMode="group"  width="120"></t:dgCol> --%>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgFunOpt title="查看地图" funname="openImg(id)" urlclass="ace_button"  urlfont="fa-picture-o"/>
   <%-- <t:dgFunOpt  title="删除" funname="doDel(id)"  urlclass="ace_button"  urlfont="fa-trash-o" /> --%>
   <t:dgToolBar title="录入" icon="icon-add" url="tbCrComputerRoomController.do?goAdd" funname="add"  width="768"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbCrComputerRoomController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="删除"  icon="icon-remove" url="tbCrComputerRoomController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <%-- <t:dgToolBar title="查看" icon="icon-search" url="tbCrComputerRoomController.do?goUpdate" funname="detail"  width="768"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
	 gridname="tbCrComputerRoomList";
 });
 
//添加
function add() {
 	 var framename = window.frameElement.name;
 	 var url = 'tbCrComputerRoomController.do?goAdd';
 	 url += '&framename='+framename;
 	 addOneTab('添加机房', url);
  } 
//更新
 function update() {
	var rows = $("#tbCrComputerRoomList").datagrid('getSelections');
	if (!rows || rows.length==0) {
		tip($.i18n.prop('edit.selectItem'));
		return;
	}
   if (rows.length == 1) {
   	 var url = 'tbCrComputerRoomController.do?goUpdate&id='+rows[0].id+'&openType=2';
   	 var framename = window.frameElement.name;
   	 url += '&framename='+framename;
   	 addOneTab('修改机房信息', url);
   }else{
	   tip('请选择一条记录再编辑');
   }
} 
//查看地图 
function openImg(id) {
	openwindow("查看","tbCrComputerRoomController.do?viewPic&id="+id,'tbCrComputerRoomList',800,400);
}
   
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbCrComputerRoomController.do?upload', "tbCrComputerRoomList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbCrComputerRoomController.do?exportXls","tbCrComputerRoomList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbCrComputerRoomController.do?exportXlsByT","tbCrComputerRoomList");
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
function doDel(id){
	
	$.dialog.confirm('删除机房将使此机房内机柜信息、设备信息数据异常并且机器人将无法正常工作！', function(r) {
		   if (r) {
			   //获取机器人参数表
		$.ajax({
				url:'tbCrComputerRoomController.do?doDel',
				type:'post',
				data:{id:id},
				cache : false,
				success : function(data) {
					reloadTable();
				}
			});	
			}
		});
	
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
    	$.dialog.confirm('删除机房将使此机房内机柜信息、设备信息数据异常并且机器人将无法正常工作！', function(r) {
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
