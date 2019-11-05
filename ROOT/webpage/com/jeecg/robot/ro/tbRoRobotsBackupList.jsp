<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbRoRobotsBackupList" checkbox="true" pagination="true" fitColumns="true" title="机器人备份表" 
  	actionUrl="tbRoRobotsBackupController.do?datagrid&robotsInfoId=${robotsInfoId}" idField="id" sortName="backupTime" fit="true" queryMode="group" >
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机器人名称"  field="robotsInfoId" hidden="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="序号"  field="serialNo"  hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="备份时间"  field="backupTime"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="文件大小"  field="fileSize"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="版本号"  field="versionNo"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="文件路径"  field="fileUrl" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="备份人"  field="backupUserId" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="恢复状态"  field="recoveryStatus" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="恢复时间"  field="recoveryTime" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="恢复人"  field="recoveryUserId" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgToolBar title="备份" icon="icon-put" url="tbRoRobotsBackupController.do?goAdd&robotsInfoId=${robotsInfoId}" funname="addback"  width="768"></t:dgToolBar>
   <t:dgToolBar title="恢复" icon="icon-putout" url="tbRoRobotsBackupController.do?doUpdate&robotsInfoId=${robotsInfoId}" funname="update"  width="768"></t:dgToolBar>
   <t:dgToolBar title="删除"  icon="icon-remove" url="tbRoRobotsBackupController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 var robotsInfoId = '${robotsInfoId}';
 var computerRoomId = '${computerRoomId}';
 $(document).ready(function(){
 });
 var sum=0;
 inital();
 function inital(){
	  $.ajax({
			url:'tbRoRobotsBackupController.do?backupSum&robotsInfoId='+robotsInfoId,
			type:'GET',
			dataType:'JSON',
			async:false, 
			delay: 250,
			cache: true,
			success: function(data){
					sum=data;
			}
		});
 }

function addback(){
	var obj='${robotsInfoId}';
	//接口数据
	 var datas={};
	 $.ajax({
			url:'tbRoRobotsBackupController.do?backuplist&robotsInfoId='+obj,
			type:'GET',
			dataType:'JSON',
			async:false, 
			delay: 250,
			cache: true,
			success: function(data){
				datas=data[0];
			}
		});
	 var msg="";
	 var msgType="";
	 //接口-备份接口 backup
	 $.ajax({
		 url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
			type :'post',
			data: JSON.stringify({interfaceNo:"backup",robot_ip:datas.robot_ip,backup_time:datas.backup_time}),
			datatype:'json',
			cache : false,
			async:false,
			error:function(e){
				msg="备份:网络异常，请检查机器人网络状态！";
				tip(msg);
				addNoticeMsg("03",msg);
			},
			success : function(data) {
				var d = $.parseJSON(data);
				if(d) {
						if (d.ErrorNo == '0') {
							msg = "备份指令发送成功";
							msgType = "01";
						} else if(d.ErrorNo == '-1') {
							msg ="备份指令发送失败";
							msgType = "03";
						} else if(d.ErrorNo == '1') {
							msg = "备份指令发送执行中";
							msgType = "01";
						} else {
							msgType = "01";
							msg = "备份指令发送执行中";
						}
				} else {
					msgType = "03";
					msg = "备份指令发送失败";
				}
				addNoticeMsg(msgType,msg);
				tip(msg);
				reloadTable();
			}
	       
		});
	 //reloadTable();
}
	
   setInterval( function () {
	
	  $.ajax({
			url:'tbRoRobotsBackupController.do?backupSum&robotsInfoId='+robotsInfoId,
			type:'GET',
			dataType:'JSON',
			async:false, 
			delay: 250,
			cache: true,
			success: function(data){
				if(data!=sum){
					location.reload();
					 //reloadTable();
				}
			}
		});
	
	  }, 3000 ); 
 /**
  * 恢复
  * @param addurl//目标页面地址
  * @param id//主键字段
  */
 function update(title,url, id,width,height,isRestful) {
 	gridname=id;
 	var rowsData = $('#'+id).datagrid('getSelections');
 	if (!rowsData || rowsData.length==0) {
 		tip('请选择一条数据恢复');
 		return;
 	}
 	if (rowsData.length>1) {
 		tip('请选择一条数据恢复');
 		return;
 	}
 	if(isRestful!='undefined'&&isRestful){
 		url += '/'+rowsData[0].id;
 	}else{
 		url += '&id='+rowsData[0].id;
 	}
 	var id=rowsData[0].id;
 	 var datas={};
	 $.ajax({
			url:'tbRoRobotsBackupController.do?restorelist&id='+id,
			type:'GET',
			dataType:'JSON',
			async:false, 
			delay: 250,
			cache: true,
			success: function(data){
				datas=data[0];
			}
		});
	 var msg="";
	 var msgType="";
 	var url = "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient"; //恢复 调用机器人接口 TODO  restore
 	datas.interfaceNo="restore";
 	datas.robotId=robotsInfoId;
	$.dialog.confirm('请确认是否恢复数据？', function(r) {
	   if (r) {
			$.ajax({
				url : url,
				type : 'post',
				data : JSON.stringify(datas),
				cache : false,
				error:function(e){
					msg="备份恢复:网络异常，请检查机器人网络状态！";
					tip(msg);
					addNoticeMsg("03",msg);
				},
				success : function(data) {
					var d = $.parseJSON(data);
					if(d) {
						if (d.ErrorNo == '0') {
							msg = "备份恢复成功";
							msgType="01";
						} else if(d.ErrorNo == '-1') {
							msg ="备份恢复失败";
							msgType="03";
						} else {
							msg ="备份恢复失败";
							msgType="03";
						}
					} else {
						if (data.ErrorNo == '0') {
							msg ="备份恢复成功";
							msgType="01";
						} else if(data.ErrorNo == '-1') {
							msg ="备份恢复失败";
							msgType="03";
						} else {
							msg ="备份恢复失败";
							msgType="03";
						}	
					}
					tip(msg);
					addNoticeMsg(msgType,msg);
					reloadTable();
				}
			});
		}
	});
 }
 function deleteALLSelect(title,url,gname) {
		gridname=gname;
	    var ids = [];
	    var rows = $("#"+gname).datagrid('getSelections');
	    if (rows.length > 0) {
	    	$.dialog.setting.zIndex = getzIndex(true);
	    	$.dialog.confirm('您确定要删除！', function(r) {
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
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tbRoRobotsBackupController.do?upload', "tbRoRobotsBackupList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tbRoRobotsBackupController.do?exportXls","tbRoRobotsBackupList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tbRoRobotsBackupController.do?exportXlsByT","tbRoRobotsBackupList");
}

//bootstrap列表图片格式化
function btListImgFormatter(value,row,index){
	return listFileImgFormat(value,"image");
}
//bootstrap列表文件格式化
function btListFileFormatter(value,row,index){
	return listFileImgFormat(value);
}

//添加通知消息 : noticeMessageType消息类型、 noticeMessageContent消息内容
function addNoticeMsg(noticeMessageType, noticeMessageContent){
	 $.ajax({
			url : "workbenchController.do?addNoticeMsg",
			type : 'post',
			data: {noticeMessageType: noticeMessageType,
				     computerRoomId:computerRoomId,
				     robotsInfoId:robotsInfoId,//对象机器人信息表ID，平台发起和接受对象
				     noticeMessageContent:noticeMessageContent //消息内容
			     },
			cache : false,
			error : function(e){},
			success : function(data) {
			}
		 });
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
