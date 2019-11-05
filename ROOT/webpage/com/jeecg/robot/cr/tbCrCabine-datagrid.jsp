<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
function resetTrNum(tableId) {
	$tbody = $("#"+tableId+"");
	$tbody.find('>tr').each(function(i){
		$(':input, select,button,a', this).each(function(){
			var $this = $(this), name = $this.attr('name'),id=$this.attr('id'),onclick_str=$this.attr('onclick'), val = $this.val();
			if(name!=null){
				if (name.indexOf("#index#") >= 0){
					$this.attr("name",name.replace('#index#',i));
				}else{
					var s = name.indexOf("[");
					var e = name.indexOf("]");
					var new_name = name.substring(s+1,e);
					$this.attr("name",name.replace(new_name,i));
				}
			}
			if(id!=null){
				if (id.indexOf("#index#") >= 0){
					$this.attr("id",id.replace('#index#',i));
				}else{
					var s = id.indexOf("[");
					var e = id.indexOf("]");
					var new_id = id.substring(s+1,e);
					$this.attr("id",id.replace(new_id,i));
				}
			}
			if(onclick_str!=null){
				if (onclick_str.indexOf("#index#") >= 0){
					$this.attr("onclick",onclick_str.replace(/#index#/g,i));
				}else{
				}
			}
		});
		$(this).find('div[name=\'xh\']').html(i+1);
	});
}
	$('#addJformGraphreportItemBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#delJformGraphreportItemBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addJformGraphreportItemBtn').bind('click', function(){   
 		 var tr =  $("#add_jformGraphreportItem_table_template tr").clone();
	 	 $("#add_jformGraphreportItem_table").append(tr);
	 	 resetTrNum('add_jformGraphreportItem_table');
	 	 return false;
    });  
	$('#delJformGraphreportItemBtn').bind('click', function(){   
      	$("#add_jformGraphreportItem_table").find("input:checked").parent().parent().remove();   
        resetTrNum('add_jformGraphreportItem_table'); 
        return false;
    }); 
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
			$(".datagrid-toolbar").hide();
		}
    	var hight=document.body.clientHeight - 2;
		//将表格的表头固定
	    $("#jformGraphreportItem_table").createhftable({
	    	
	    	height:hight,
			width:'auto',
			fixFooter:false
			});
		
	    // IE 默认点击下添加按钮
	    if(document.all) {
	        document.getElementById("addJformGraphreportItemBtn").click();
	    } else {// 其它浏览器
	        var e = document.createEvent("MouseEvents");
	        e.initEvent("click", true, true);
	        document.getElementById("addJformGraphreportItemBtn").dispatchEvent(e);
	    }
    });
    
  //正则限制机柜编号的输入格式
   /*  cabineNo.onkeyup=function(){
    	var re=/^[\u4E00-\u9FA5A-Za-z0-9]+$/;//只允许输入中文，英文和数字
    	if(!re.test(this.value)){
    	alert("请勿输入特殊字符");
    	this.value=this.value.substr(0,this.value.length-1);//将最后输入的字符去除
    	  }
    	} */
    	var fz=document.getElementById('id');
    	fz.style.height=hight;
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addJformGraphreportItemBtn" href="javascript:void(0);">添加</a> <a id="delJformGraphreportItemBtn" href="javascript:void(0);">删除</a>
</div>

<div id="id" style="width: auto; height: 300px; overflow-y: auto; overflow-x: scroll;">
<table border="0" cellpadding="2" cellspacing="0" id="jformGraphreportItem_table">
	<tr bgcolor="#E6E6E6">
	
	     <!--  <td align="left" bgcolor="#EEEEEE"><label class="Validform_label">序号</label></td>  -->
		 <td align="left" style="width: 40px;" bgcolor="#EEEEEE"><label class="Validform_label">操作</label></td>
		<td align="left" style="width:140px;" bgcolor="#EEEEEE"><label class="Validform_label">机柜编号</label></td>
		<td align="left" style="width:140px;" bgcolor="#EEEEEE"><label class="Validform_label">机柜类型</label></td>
		<td align="left" style="width:140px;" bgcolor="#EEEEEE"><label class="Validform_label">边框尺寸</label></td>
		<td align="left" style="width:200px;" bgcolor="#EEEEEE"><label class="Validform_label">机柜描述</label></td>
	</tr>
	<tbody id="add_jformGraphreportItem_table">
	<%-- <c:if test="${fn:length(tbCrCabine)  <= 0 }">
			<tr>
		<!-- 		<td align="center"><div style="width: 25px;" name="xh">1</div></td> -->
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/>
					</td>
				  <td align="left">
					  	<input id="cabineNo" name="TbCrCabineEntity[0].cabineNo" maxlength="20" onkeyup="checkCabineNo()" 
					  		type="text" class="inputxt"  style="width:120px;" datatype="*"/>
					  <label class="Validform_label" style="display: none;">机柜编号</label>
					  <font style="color: red;">*</font>
				  </td>
				  <td align="left">
					  	  <t:dictSelect field="TbCrCabineEntity[0].cabineType" type="select" typeGroupCode="itacs_cabinetType" hasLabel="false" datatype="*"></t:dictSelect>  
					  <label class="Validform_label" style="display: none;">机柜类型</label>
					  <font style="color: red;">*</font>	
				  </td>
				  <td align="left">
					  	<input name="TbCrCabineEntity[0].borderSize" maxlength="36" 
					  		type="text" class="inputxt"  style="width:120px;" datatype="*"/>
					  <label class="Validform_label" style="display: none;">边框尺寸</label>
					  <font style="color: red;">*</font>
				  </td>
				   <td align="left">
					  	<input name="TbCrCabineEntity[0].cabineDesc" maxlength="52"	 
					  		type="text" class="inputxt"  style="width:200px;" />
					  <label class="Validform_label" style="display: none;">机柜描述</label>
				  </td>
   			</tr>
	</c:if> --%>
	</tbody>
</table>
</div>