<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbVrVisitorRegistrationList" checkbox="false" pagination="true" fitColumns="true" 
  	title="" actionUrl="tbVrVisitorRegistrationController.do?appdatagrid" idField="id" sortName="visitorTime" fit="true" queryMode="group">
   <t:dgCol title="主键ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="访客姓名"  field="visitorName" query="true" width="100"></t:dgCol>
   <t:dgCol title="身份证号"  field="certNo" query="true" width="180"></t:dgCol>
   <t:dgCol title="手机"  field="mobilephone" query="true" width="100"></t:dgCol>
   <t:dgCol title="来访时间"  field="visitorTime"  queryMode="group"  width="150"></t:dgCol>
   <t:dgCol title="来访机房"  field="computerRoomIds" dictionary="tb_cr_computer_room,id,computer_room_name" width="120"></t:dgCol>
   <t:dgCol title="来访事由"  field="visitorReasons"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="审批人"  field="approver" dictionary="t_s_base_user,id,realname" width="80"></t:dgCol>
   <t:dgCol title="审批状态"  field="approvalStatus" dictionary="itacs_approval_status" width="80"></t:dgCol>
   <t:dgCol title="离开时间"  field="departureTime" width="150"></t:dgCol>
   <t:dgCol title="管理" field="opt" width="120"></t:dgCol>
   <t:dgFunOpt title="通过" funname="adopt(id,approvalStatus)" urlclass="ace_button" />
   <t:dgFunOpt title="取消" funname="cancel(id,approvalStatus)" urlclass="ace_button" />
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
 //通过
 function adopt(id,approvalStatus) {
	if(approvalStatus && approvalStatus == '01') {
		var url = 'tbVrVisitorRegistrationController.do?doUpdate';
		$.dialog.confirm('请确认是否通过？', function(r) {
		   if (r) {
				$.ajax({
					url : url,
					type : 'post',
					data : {id:id,approvalStatus:"02"},
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if (d.success) {
							/* var msg = d.msg; */
							var msg="审批已通过";
							tip(msg);
							reloadTable();
						}
					}
				});
			}
		});
	} else {
		tip("该数据已审批");
	}
 }
 //取消
 function cancel(id,approvalStatus) {
	 if(approvalStatus && approvalStatus == '01') {
		var url = 'tbVrVisitorRegistrationController.do?doUpdate';
		$.dialog.confirm('请确认是否取消？', function(r) {
		   if (r) {
				$.ajax({
					url : url,
					type : 'post',
					data : {id:id,approvalStatus:"03"},
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if (d.success) {
							/* var msg = d.msg; */
							var msg="审批未通过";
							tip(msg);
							reloadTable();
						}
					}
				});
			}
		});
	} else {
		tip("该数据已审批");
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
