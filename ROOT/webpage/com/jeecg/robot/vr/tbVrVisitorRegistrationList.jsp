<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbVrVisitorRegistrationList" checkbox="true" pagination="true" fitColumns="true" 
  	title="" actionUrl="tbVrVisitorRegistrationController.do?datagrid" idField="id" sortName="visitorTime" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="访客姓名"  field="visitorName" query="true" width="100"></t:dgCol>
   <t:dgCol title="身份证号"  field="certNo" query="true" width="180"></t:dgCol>
   <t:dgCol title="手机"  field="mobilephone" query="true" width="100"></t:dgCol>
   <t:dgCol title="来访时间"  field="visitorTime" formatter="yyyy-MM-dd hh:mm:ss" queryMode="group"  width="150"></t:dgCol>
   <t:dgCol title="来访机房"  field="computerRoomIds" dictionary="tb_cr_computer_room,id,computer_room_name" width="120"></t:dgCol>
   <t:dgCol title="来访事由"  field="visitorReasons"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="审批人"  field="approver" dictionary="t_s_base_user,id,realname" width="80"></t:dgCol>
   <t:dgCol title="审批状态"  field="approvalStatus" dictionary="itacs_approval_status" query="true" width="80"></t:dgCol>
   <t:dgCol title="离开时间"  field="departureTime" width="150"></t:dgCol>
   <t:dgCol title="管理" field="opt" width="120"></t:dgCol>
   <t:dgFunOpt title="确认离开时间" funname="confirmDepartureTime(id,approvalStatus)" urlclass="ace_button" />
   <t:dgToolBar title="添加" icon="icon-add" url="tbVrVisitorRegistrationController.do?goAdd" funname="addpage" width="768"></t:dgToolBar>
   <%-- <t:dgToolBar title="编辑" icon="icon-edit" url="tbVrVisitorRegistrationController.do?goUpdate" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="删除"  icon="icon-remove" url="tbVrVisitorRegistrationController.do?doBatchDel" funname="deleteALLSelect1"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 
 //日期格式
 $(function() {
     $("input[name='visitorTime_begin']").attr("class", "Wdate");
     $("input[name='visitorTime_end']").attr("class", "Wdate"); //Wdate

     $("input[name='visitorTime_begin']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'

         });
     });
     $("input[name='visitorTime_end']").focus(function() {
         WdatePicker({
             'isShowClear' : false,
             'readOnly' : true,
             dateFmt : 'yyyy-MM-dd'
         });
     });
 }); 
 
 
 $(document).ready(function(){
	 gridname="tbVrVisitorRegistrationList";
 });
 
//添加
 function addpage() {
 	 var framename = window.frameElement.name;
 	 var url = 'tbVrVisitorRegistrationController.do?goAdd';
 	 url += '&framename='+framename;
 	 addOneTab('添加访客信息', url);
  }
//更新
 function update() {
	var rows = $("#tbVrVisitorRegistrationList").datagrid('getSelections');
	if (!rows || rows.length==0) {
		tip($.i18n.prop('edit.selectItem'));
		return;
	}
   if (rows.length == 1) {
   	 var url = 'tbVrVisitorRegistrationController.do?goUpdate&id='+rows[0].id+'&openType=2';
   	 var framename = window.frameElement.name;
   	 url += '&framename='+framename;
   	 addOneTab('修改访客信息', url);
   }else{
	   tip('请选择一条记录再编辑');
   }
} 

 /**
  * 多记录刪除請求
  * @param title
  * @param url
  * @param gname
  * @return
  */
 function deleteALLSelect1(title,url,gname) {
 	gridname=gname;
     var ids = [];
     var rows = $("#"+gname).datagrid('getSelections');
     if (rows.length > 0) {
     	$.dialog.setting.zIndex = getzIndex(true);
     	$.dialog.confirm('确定删除访客信息？', function(r) {
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
 
//确认离开时间
function confirmDepartureTime(id,approvalStatus) {
	if(approvalStatus && approvalStatus == '02') {
		add('确认离开时间', 'tbVrVisitorRegistrationController.do?goConfirmDepartureTime&id='+id, 'tbVrVisitorRegistrationController.do?doUpdate');
	}else {
		tip("审批通过的数据才能确认离开时间");
	}
}
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbVrVisitorRegistrationController.do?upload', "tbVrVisitorRegistrationList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbVrVisitorRegistrationController.do?exportXls","tbVrVisitorRegistrationList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbVrVisitorRegistrationController.do?exportXlsByT","tbVrVisitorRegistrationList");
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
