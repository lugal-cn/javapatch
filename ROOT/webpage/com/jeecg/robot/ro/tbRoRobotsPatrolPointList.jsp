<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<style type="text/css">
    .main_div{
        margin: auto;
        text-align: center;

    }
    .pic_div{
        position: relative;
        background-color: white;
        border: 0px dotted #2483de;
        margin: 10px auto;
        width: 98%;
        height: 98%;
    }
    img{
        width: 100%;
        height: auto;
        border: 1px dotted #2483de;
    }

</style>
<script type="text/javascript">
	//放大图片
    function bigit(){
        var image=document.getElementsByClassName("pic")[0];
        image.style.height=image.height*1.1+'px';
        image.style.width=image.width*1.1+'px';
        //机器人图标根据比例显示
        var div = document.getElementById('div3');
        var divleft = div.style.left;
        var divtop = div.style.top;
        div.style.left = divleft.replace("px","")*1.1 + 'px';
		div.style.top = divtop.replace("px","")*1.1 + 'px';
    }
	//缩小图片
    function littleit(){
        var image=document.getElementsByClassName("pic")[0];
        image.style.height=image.height/1.1+'px';
        image.style.width=image.width/1.1+'px';
      	//机器人图标根据比例显示
        var div = document.getElementById('div3');
        var divleft = div.style.left;
        var divtop = div.style.top;
        div.style.left = divleft.replace("px","")/1.1 + 'px';
		div.style.top = divtop.replace("px","")/1.1 + 'px';
    }
    
    var scrollFunc = function (e) {
        e = e || window.event;
        if (e.wheelDelta) {  //判断浏览器IE，谷歌滑轮事件            
            if (e.wheelDelta > 0) { //当滑轮向上滚动时
                bigit();
            }
            if (e.wheelDelta < 0) { //当滑轮向下滚动时
                littleit();
            }
        } else if (e.detail) {  //Firefox滑轮事件
            if (e.detail> 0) { //当滑轮向上滚动时
                bigit();
            }
            if (e.detail< 0) { //当滑轮向下滚动时
                littleit();
            }
        }
    }
    /*  //给页面绑定滑轮滚动事件
    if (document.addEventListener) {
        document.addEventListener('DOMMouseScroll', scrollFunc, false);
    }
    //滚动滑轮触发scrollFunc方法
    window.onmousewheel = document.onmousewheel = scrollFunc;   */
</script>
<div class="easyui-layout" fit="true" style="width:1000px;height:600px;">
    <div region="west" split="true" title="" style="width:500px;">
    	<ul id="siteSelect" style="width:98%;height: 100%;">
    		<t:datagrid name="tbRoRobotsPatrolPointList" checkbox="true" pagination="false" fitColumns="true" title="" 
  			actionUrl="tbRoRobotsPatrolPointController.do?datagrid&robotsInfoId=${robotsInfoId }" idField="id" 
  			sortName="id" fit="true" queryMode="group" onLoadSuccess="loadSuccess">
		   <t:dgCol title="唯一标识"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
		   <t:dgCol title="机器人ID"  field="robotsInfoId" hidden="true" queryMode="group"  width="120"></t:dgCol>
		   <t:dgCol title="点位编号"  field="patrolPointNo" extendParams="editor:'text'" width="130"></t:dgCol>
		   <t:dgCol title="机柜编号"  field="cabineNo"  dictionary="tb_cr_cabine,id,cabine_no" extendParams="editor:'combobox'"  width="130"></t:dgCol>
		   <t:dgCol title="机柜类型"  field="cabineType"  dictionary="itacs_cabinetType" extendParams="editor:'combobox'" width="130"></t:dgCol>
		   <t:dgCol title="机柜方向"  field="patrolPointType" dictionary="itacs_pointType" extendParams="editor:'combobox'" width="130"></t:dgCol>
		   <t:dgCol title="X坐标"  field="xCoordinate"   extendParams="editor:'text'" width="120"></t:dgCol>
		   <t:dgCol title="Y坐标"  field="yCoordinate" extendParams="editor:'text'" width="120"></t:dgCol>
		   <t:dgCol title="X"  field="xRate"  hidden="true"  width="120"></t:dgCol>
		   <t:dgCol title="Y"  field="yRate" hidden="true"  width="120"></t:dgCol>
			<%-- <t:dgToolBar  title="录入" icon="icon-add"  funname="addRow"></t:dgToolBar> --%>
			<t:dgToolBar  title="刷新" icon="icon-reload"  funname="reload"></t:dgToolBar>
			<t:dgToolBar  title="编辑" icon="icon-edit"  funname="editRow"></t:dgToolBar>
			<t:dgToolBar  title="保存" icon="icon-save" url="tbRoRobotsPatrolPointController.do?doUpdate" funname="saveData"></t:dgToolBar>
			<t:dgToolBar  title="取消编辑" icon="icon-undo" funname="reject"></t:dgToolBar>
			<%-- <t:dgToolBar title="批量删除"  icon="icon-remove" url="tbRoRobotsPatrolPointController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
			<t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
			<t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
			 <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar> --%>
		  </t:datagrid>
    	</ul>
    </div>
    <div region="center" title="" style="width:500px;height: 98%;" id="sitePanel" class="easyui-panel">
        <div id="dv1" style="position: absolute;z-index: 3;">
            0（MIN）
        </div>
        <div id="dv1" style="position: absolute; right: 10px;z-index: 3;" >
            X坐标（MAX）
        </div>
        <div id="dv1" style="position: absolute; bottom: 10px;z-index: 3;">
            Y坐标（MAX）
        </div>
        <div id="dv2" class="pic_div" style="height: 94%; z-index: 1;" >
            <img id="SmallLiuYiFeiImg" src="${mapUrl}" class="pic" onclick="test()">
        </div>
        <%-- <div id="div3" style="background:url(<%=request.getContextPath() %>/images/机器人图标.png); width:50px;height:50px; z-index:2;position: absolute; left:100px;top:100px;"></div> --%>
    </div>
</div>
 
 <script type="text/javascript">
 
 	var robotsInfoId = '${robotsInfoId }';
 	var cabineData;
 	initCabine();
 	//加载机柜数据
 	function initCabine() {
 		$.ajax({
			url:"tbRoRobotsPatrolPointController.do?getCabineListById",
			type:"post",
			data:{robotsInfoId:robotsInfoId},
			dataType:"json",
			success:function(data){
				if(data) {
					cabineData = data.lstMap;
				} else {
					cabineData = [];
				}
			}
		});
 	}
 	 function test () {
 		var image=document.getElementById("SmallLiuYiFeiImg");
		var e = event || window.event;
         /* console.log("jubu" + e.clientX+ "/" + e.clientY );
         console.log("imageoffsetLeft" + image.offsetLeft  + "/" + image.offsetTop );
         var dv2=document.getElementById("dv2"); */
         console.log("imageurl" + (e.clientX - 500)+ "/" + (e.clientY - 11) );
         tip("坐标参考值：x:"+(e.clientX - 500)+",y:"+(e.clientY - 11));
 	}
 	
	  function loadSuccess(data) {
	 	var patrolPointNo;
	 	var x;
	 	var y;
	 	var xRate;
	 	var yRate;
	 	var image=document.getElementById("SmallLiuYiFeiImg");
		var imageheight = image.height;
		var imagewidth = image.width;
	 	for(var i=0;i<data.total;i++) {
	 		patrolPointNo = data.rows[i]['patrolPointNo'];
	 		x = data.rows[i]['xCoordinate'];
	 		y = data.rows[i]['yCoordinate'];
	 		xRate = data.rows[i]['xRate'];
	 		yRate = data.rows[i]['yRate'];
	 		//删除div 重新加载机器人图标
	 		var idObject = document.getElementById('div'+patrolPointNo);
	 	    if (idObject != null) {
	 	          idObject.parentNode.removeChild(idObject);
	 	    }
	 		var div = document.createElement('div');
			div.id = 'div'+patrolPointNo;
			div.style.position = 'absolute';
	        div.style.left = (parseFloat(imagewidth)*parseFloat(xRate)) + 'px';
			div.style.top = (parseFloat(imageheight)*parseFloat(yRate)) + 'px';
			div.style.zIndex = 2;
			div.style.width = '30px';
			div.style.height = '30px';
			div.style.background = 'url(<%=request.getContextPath() %>/images/u6079.png)';
			/* div.innerHTML= "("+ x +","+y+")"; */
			document.getElementById('sitePanel').appendChild(div);
			/* alert(parseFloat(imagewidth) + "-" + parseFloat(xRate));
			alert(parseFloat(imageheight) + "-" + parseFloat(yRate)); */
			var newx = (parseFloat(imagewidth)*parseFloat(xRate)).toFixed(0);
			var newy = (parseFloat(imageheight)*parseFloat(yRate)).toFixed(0);
			 // -----
		    $('#tbRoRobotsPatrolPointList').datagrid('updateRow', {
		        index: i,
		        row: {
		        	xCoordinate: newx,
		        	yCoordinate: newy
		        }
		    });
	 	}	
	 } 
 
 	var robotsInfoId = '${robotsInfoId}';
	//添加行
	function addRow(title,addurl,gname){
		$('#'+gname).datagrid('appendRow',{});
		var editIndex = $('#'+gname).datagrid('getRows').length-1;
		$('#'+gname).datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
		//选择不同字段类型有不同的值设置
        var cellEdits = $('#'+gname).datagrid('getEditor', {
			index: editIndex,
			field: 'cabineNo'
		});
        cellEdits.target.combobox({
        	valueField: 'id',
			textField: 'cabine_no',
			width:70,
			data: cabineData,
            onChange: function (n, o) {
				var ed = $('#tbRoRobotsPatrolPointList').datagrid('getEditor', {
					index: editIndex,
					field: 'cabineType'
				});
				$.ajax({
					url:"tbRoRobotsPatrolPointController.do?getCabineTypeById",
					type:"post",
					data:{id:n},
					dataType:"json",
					success:function(data){
						if(data) {
							$(ed.target).combobox('setValue', data.msg);
						} else {
							$(ed.target).combobox('setValue', '');
						}
					}
				});
            }
        });
	}
	//保存数据
	function saveData(title,addurl,gname){
		if(!endEdit(gname)) {
			return false;
		}
		var rows=$('#'+gname).datagrid("getChanges","inserted");
		var uprows=$('#'+gname).datagrid("getChanges","updated");
		rows=rows.concat(uprows);
		if(rows.length<=0){
			tip("没有需要保存的数据！");
			return false;
		}
		var xCoordinate = 0;
		var yCoordinate = 0;
		var patrolPointNo = '';
		var result={};
		var image=document.getElementById("SmallLiuYiFeiImg");
		var imageheight = image.height;
		var imagewidth = image.width;
		var xrate = 0;
		var yrate = 0;
		
		for(var i=0;i<rows.length;i++){
			for(var d in rows[i]){
				if(d == 'xCoordinate') {
					xCoordinate = rows[i][d];
					xrate = (xCoordinate/imagewidth).toFixed(3);
				}
				if(d == 'yCoordinate') {
					yCoordinate = rows[i][d];
					yrate = (yCoordinate/imageheight).toFixed(3);
				}
				if(d == 'patrolPointNo') {
					patrolPointNo = rows[i][d];
				}
				result["tbRoRobotsPatrolPoints["+i+"]."+d]=rows[i][d];
			}
			if(!patrolPointNo) {
				tip("点位编号不能为空！");
				return false;
			}
			result["tbRoRobotsPatrolPoints["+i+"].robotsInfoId"]=robotsInfoId;
			result["tbRoRobotsPatrolPoints["+i+"].yRate"]=yrate;
			result["tbRoRobotsPatrolPoints["+i+"].xRate"]=xrate;
			setXY(xCoordinate, yCoordinate, patrolPointNo); //更新图片位置
		}
		$.ajax({
			url:"<%=basePath%>/"+addurl,
			type:"post",
			data:result,
			dataType:"json",
			success:function(data){
				tip(data.msg);
				if(data.success){
					//reloadTable();
					location.reload(true);
				}
			}
		});
	}
	//结束编辑
	function endEdit(gname){
		var  editIndex = $('#'+gname).datagrid('getRows').length-1;
		for(var i=0;i<=editIndex;i++){
			if($('#'+gname).datagrid('validateRow', i)){
				$('#'+gname).datagrid('endEdit', i);
			}else{
				tip("请选择必填项(带有红色三角形状的字段)!");
				return false;
			}
		}
		return true;
	}
	//编辑行
	function editRow(title,addurl,gname){
		var rows=$('#'+gname).datagrid("getChecked");
		if(rows.length==0){
			tip("请选择条目");
			return false;
		}
		for(var i=0;i<rows.length;i++){
			var index= $('#'+gname).datagrid('getRowIndex', rows[i]);
			$('#'+gname).datagrid('beginEdit', index);
			
			//选择不同字段类型有不同的值设置
	        var cellEdits = $('#'+gname).datagrid('getEditor', {
				index: index,
				field: 'cabineNo'
			});
		
        	var old = $(cellEdits.target).combobox('getValue');
	        cellEdits.target.combobox({
	        	valueField: 'id',
				textField: 'cabine_no',
				width:70,
				data: cabineData,
	            onChange: function (n, o) {
					var ed = $('#tbRoRobotsPatrolPointList').datagrid('getEditor', {
						index: index,
						field: 'cabineType'
					});
					if(!o){
						return;
					}
					$.ajax({
						url:"tbRoRobotsPatrolPointController.do?getCabineTypeById",
						type:"post",
						data:{id:n},
						dataType:"json",
						success:function(data){
							if(data) {
								alert(data.msg);
								$(ed.target).combobox('setValue', data.msg);
							} else {
								$(ed.target).combobox('setValue', '');
							}
						}
					});
	            }
	        });
	        if(old) { 	
	        	$(cellEdits.target).combobox('setValue',old);
	        } 
		}
	}
	//取消编辑
	function reject(title,addurl,gname){
		$('#'+gname).datagrid('clearChecked');
		$('#'+gname).datagrid('rejectChanges');
	}
	
	//导入
	function ImportXls() {
	openuploadwin('Excel导入', "tbRoRobotsPatrolPointController.do?upload&robotsInfoId="+robotsInfoId, "tbRoRobotsPatrolPointList");
	}
	//导出
	function ExportXls() {
		JeecgExcelExport("tbRoRobotsPatrolPointController.do?exportXls&robotsInfoId="+robotsInfoId,"tbRoRobotsPatrolPointList");
	}
	//模板下载
	function ExportXlsByT() {
		JeecgExcelExport("tbRoRobotsPatrolPointController.do?exportXlsByT&robotsInfoId="+robotsInfoId,"tbRoRobotsPatrolPointList");
	}

	
	//设置x,y坐标在机房地图上显示位置
	function setXY(x, y, patrolPointNo) {
		var div = document.getElementById('div'+patrolPointNo);
		if(div) {
			div.style.left = x + 'px';
			div.style.top = y + 'px';
		}
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
	    	$.dialog.confirm($.i18n.prop('del.forever.confirm.tip'), function(r) {
			   if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
						//删除div 机器人图标
				 		var idObject = document.getElementById('div'+rows[i].patrolPointNo);
				 	    if (idObject != null) {
				 	          idObject.parentNode.removeChild(idObject);
				 	    }
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
	
	var robotsIp = '${robotsIp}';
	//刷新  获取机器人的点位
	function reload() {
		var timestamp=new Date().getTime();
		$.ajax({
			url : "http://"+'${localhostIP}'+":7002/jk/api/interfaceClient",
			type : 'post',
			data: JSON.stringify({interfaceNo:"getfixedpoint",robot_ip:robotsIp,time:timestamp}),
			datatype:'json',
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				var msg = "获取点位";
				if(d) {
					if (d.ErrorNo == '0') {
						//同步到数据库中
						$.ajax({
							url : "tbRoRobotsPatrolPointController.do?fixedpoint",
							type : 'post',
							data : { FixedPoints : d.FixedPoint+"", robotsInfoId: robotsInfoId},
							cache : false,
							async  : false,
							success : function(data) {
								var d = $.parseJSON(data);
								msg += "成功";
								location.reload(true);
							}
						});
						
					} else if(d.ErrorNo == '-1') {
						msg += "失败";
					}else {
						msg += "失败";
					}
				} else {
					msg += "失败";
				}
				tip(msg);
			}
		});
	}

</script>
