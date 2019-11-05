<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tbRoRobotsFirmwareList" checkbox="true" pagination="true" fitColumns="true" title="机器人固件表" actionUrl="tbRoRobotsFirmwareController.do?datagrid&robotsInfoId=${robotsInfoId}" idField="id" sortName="id" fit="true" queryMode="group">
   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="机器人型号"  field="robotsType" dictionary="tb_ro_robots_model,id,robots_model" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="固件包版本号"  field="firmwareVersion"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="固件文件路径"  field="firmwareFileUrl" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="上传人"  field="uploadUserId" hidden="true" queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="上传时间"  field="uploadTime"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="预留字段"  field="bak"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tbRoRobotsFirmwareController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="上传" icon="icon-add" url="tbRoRobotsFirmwareController.do?goAdd&robotsInfoId=${robotsInfoId}" funname="add"  width="768"></t:dgToolBar>
   <t:dgToolBar title="升级" icon="icon-putout" url="tbRoRobotsFirmwareController.do?doUpdate&robotsInfoId=${robotsInfoId}" funname="update"  width="768"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 var robotsInfoId = '${robotsInfoId}';
 var computerRoomId = '${computerRoomId}';
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
 		tip('请选择一条数据升级');
 		return;
 	}
 	if (rowsData.length>1) {
 		tip('请选择一条数据升级');
 		return;
 	}
 	if(isRestful!='undefined'&&isRestful){
 		url += '/'+rowsData[0].id;
 	}else{
 		url += '&id='+rowsData[0].id;
 	}
 	//根据机器人的id拿机器人的ip
 	var datas={};
	 $.ajax({
			url:'tbRoRobotsFirmwareController.do?versionlist&robotsInfoId='+'${robotsInfoId}',
			type:'GET',
			dataType:'JSON',
			async:false, 
			delay: 250,
			cache: true,
			success: function(data){
				datas=data[0];//robot_ip、backup_time
			}
		});		
	  //接口-固件版本信息 version
	  var version="";
	  var build_time="";
	  $.ajax({
		 url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
			type :'post',
			data: JSON.stringify({interfaceNo:"version",robot_ip:datas.robot_ip,backup_time:datas.backup_time}),
			datatype:'json',
			cache : false,
			async:false,
			error:function(e){
			},
			success : function(data) {
				var d = $.parseJSON(data);
				if(d) {
					version=d.version;
					build_time=d.build_time;
				} else {
					version=data.version;
					build_time=data.build_time;
				}
			}
	 }); 
	 var tipmsg = '机器人当前运行的版本是:'+version+';是否要升级到版本:'+rowsData[0].firmwareVersion;
 	if(!version) {
 		tip("网络异常,请检查机器人是否在线!");
 		addNoticeMsg('03',"固件升级：网络异常,请检查机器人是否在线!");
		return;
 		version = "";
 		tipmsg = "未获取到机器人当前版本信息，请确认是否需要升级？";
 	} 
 	if(!build_time) {
 		build_time = "";
 	}
	 var id=rowsData[0].id;
	//根据固件id获取固件的信息
	 	var datasUp={};
		 $.ajax({
				url:'tbRoRobotsFirmwareController.do?firmwareUpdatelist&id='+id,
				type:'GET',
				dataType:'JSON',
				async:false, 
				delay: 250,
				cache: true,
				success: function(data){
					datasUp=data[0];//robot_ip、backup_time
				}
			});	
 	var url = "http://"+'${localhostIP}'+":7002/jk/api/fileUpInterface"; //固件升级 调用机器人接口 TODO firmwareUpdate、
 	var msg="";
 	var msgType="";
 	datasUp.interfaceNo="firmwareUpdate";
 	datasUp.robotId=robotsInfoId;
	$.dialog.confirm(tipmsg, function(r) {
	   if (r) {
		   $.messager.progress({
               title : '提示',
               text : '机器人固件升级中，请稍后。。。'
           });
			$.ajax({
				url : url,
				type : 'post',
				data : JSON.stringify(datasUp),
				timeout: 600000,
				cache : false,
				success : function(data) {
					$.messager.progress('close');
					var d = $.parseJSON(data);
					if(d) {
						if (d.ErrorNo == '0') {
							msg = "固件升级包下发成功";
							msgType="01";
						} else if(d.ErrorNo == '-1') {
							msg = "固件升级包下发失败，请检查机器人是否正常";
							msgType="03";
						} else {
							msg = "固件升级包下发失败，请检查机器人是否正常";
							msgType="03";
						}
					} else {
						if (data.ErrorNo == '0') {
							msg ="固件升级包下发成功";
							msgType="01";
						} else if(data.ErrorNo == '-1') {
							msg ="固件升级包下发失败，请检查机器人是否正常";
							msgType="03";
						} else {
							msg ="固件升级包下发失败，请检查机器人是否正常";
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
