<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>

<title>推送消息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
var msgType = [{"id":"0","text":"系统消息"},{"id":"1","text":"个人消息"}
	,{"id":"1001","text":"日程"},{"id":"1002","text":"任务"},{"id":"1003","text":"会议"},{"id":"1004","text":"流程待办"}];
var mygrid;
$(function() {
	layui.use(['form', 'table', 'layer', 'element'], function () {
		form = layui.form;
		table = layui.table;
		layer = layui.layer;
		var element = layui.element;
	});
	// 消息类型
	msgType = $('#type').combobox({
		data : msgType,
		valueField : 'id',
		textField : 'text',
		required : false,
		edittable : false,
		panelHeight : 'auto',
		// 设置下拉框默认选中值
        onLoadSuccess: function () { 
            var data = $('#type').combobox('getData');
			$('#type').combobox('select', data[0].id);
        } 
	});
	
	// 消息接受人员
	mygrid =  $("#accertuseridgrid").datagrid({
		title :'消息接收人',
		striped : true, // 奇偶行使用不同的颜色
		singleSelect : true, // 只允许选择一行
		checkOnSelect : false, // 当用户点击行的时候就选中
		selectOnCheck : false,  // 单击复选框将选择行
		rownumbers : true,  // 是否显示行号
		fitColumns :false,  // 列自适应宽度  防止滚动
		idField : 'userid',  // 该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  // 按升序排序
		columns :[[
			{
				title : '人员ID',
				field : 'userid',
				width : 50,
				editor : 'textarea',
				hidden:true
			},{
				title : '姓名',
				field : 'username',
				align : 'center',
				editor : 'textarea',
				width : 150,
				hidden:false
			},{
				title : '所属部门',
				field : 'bmmc',
				align : 'center',
				editor : 'textarea',
				width : 250,
				hidden: false
			}
		]],
		//工具栏
		toolbar :[{
			iconCls : 'icon-add',
			text : '添加信息接收人员',
			handler : function(){
				addAcceptuser();
			 }
		    },{
				iconCls: 'icon-remove',
				text: '删除',
				handler: function () {
					mydatagrid_remove(v_rygrid);
				}
			}]
	});	
});
// 添加消息接收人
function addAcceptuser(){
	var obj = new Object();
	obj.singleSelect = "false";
    var url = "<%=basePath%>jsp/pub/pub/selectuser.jsp?a="+new Date().getMilliseconds();
	//创建模态窗口
	var dialog = sy.modalDialog({
		title : '选择人员',
		param : {
			singleSelect : "false"
		},
		content : url,
		btn: [ '确定'] //可以无限个按钮
		,btn1: function(){
			layer.closeAll();
		}
	},function (dialogID){
		alert(1)
		var obj = sy.getWinRet(dialogID);

		console.log(obj)
		sy.removeWinRet(dialogID);//不可缺少
		if (obj != null && obj.data.length > 0){
			obj = obj.data;
			for (var k = 0; k <= obj.length - 1; k++){
				var myrow = obj[k];
				var v_rowindex = mydatagrid_append(mygrid);
				$((mygrid.datagrid('getEditor', {index: v_rowindex, field: 'userid'})).target).val(myrow.userid); // 人员ID
				$((mygrid.datagrid('getEditor', {index: v_rowindex, field: 'username'})).target).val(myrow.description); // 人员描述
				$((mygrid.datagrid('getEditor', {index: v_rowindex, field: 'bmmc'})).target).val(myrow.orgname); // 组织机构名称
				mydatagrid_endEditing(mygrid);
			}
		}

	});

}

function mydatagrid_append(v_datagrid){
	var editIndex = -1;
	if(mydatagrid_endEditing(v_datagrid)){
		v_datagrid.datagrid('appendRow',{});  //在最后追加一行
		editIndex = v_datagrid.datagrid('getRows').length-1;
		v_datagrid.datagrid('selectRow',editIndex)
				  .datagrid('beginEdit',editIndex);
	}
	return editIndex;
}
function mydatagrid_endEditing(v_datagrid){
	var editIndex = v_datagrid.datagrid('getRows').length-1;
	//如果某一行处于校验状态，那么这一行处于编辑状态
	if(v_datagrid.datagrid('validateRow',editIndex)){
		var ed = v_datagrid.datagrid('getEditor',{index:editIndex});  //根据行索引得到编辑器
		v_datagrid.datagrid('endEdit',editIndex);
		return true;
	}else{
		return false;
	}
}
// 删除数据
function mydatagrid_remove(v_datagrid){
	var index = v_datagrid.datagrid('getRowIndex',v_datagrid.datagrid('getSelected'));
	if (index == -1) {
		alert("请先选择行！");
		return false;
	}
	v_datagrid.datagrid('cancelEdit',index).datagrid('deleteRow',index);
	if (index-1 >= 0) {
		v_datagrid.datagrid('selectRow',index-1);
	}
}
/**
 * 发送消息
 */
function sendMessage(){
	var v_accertuserid_rows = mygrid.datagrid('getRows');
	if (v_accertuserid_rows.length == 0) {
		alert("请选择要接受信息的人员！");
		return;
	}
    $('#accertuserid_rows').val($.toJSON(v_accertuserid_rows));
    
	var url= basePath + 'jpush/sendMessage';

    parent.$.messager.progress({
		text : '正在提交....'
	});	// 显示进度条
	
	$('#myform').form('submit',{
		url: url,
		onSubmit: function(){ 
			// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
			var isValid = $(this).form('validate'); 
			if(!isValid){
				// 如果表单是无效的则隐藏进度条
				parent.$.messager.progress('close');	 
			}					
			return isValid;
		},
        success: function(result){
       		parent.$.messager.progress('close');// 隐藏进度条  
        	result = $.parseJSON(result);  
		 	if (result.code=='0'){
		 		alert("发送消息成功！");
		 		 location.reload(); 
           	} else {
           		alert("发送消息失败失败：" + result.msg);
            }
        }    
	});
}
</script>
</head>
<body>
<div class="easyui-layout" fit="true">
	<form id="myform" method="post">
		<div region="center" style="overflow: true;" border="false">
			<sicp3:groupbox title="">
				<table class="table" style="width:98%;height: 98%">
        		   <tr>
        		     <td width="15%"></td>
        		     <td width="35%"></td>
        		     <td width="15%"></td>
        		     <td width="35%"></td>
        		   </tr>        		
					<tr>
						<td style="text-align:right;"><nobr>消息标题:</nobr></td>
						<td colspan="3"><input id="title" name="title" style="width: 700px" 
							class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'"/></td>
					</tr>
					<tr>
                        <td style="text-align:right;"><nobr>消息类型:</nobr></td>
						<td colspan="3"><input id="type" name="type" style="width: 700px"/></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>消息内容:</nobr></td>
	 					<td colspan="3"><textarea class="easyui-validatebox" id="message" name="message" 
	 						style="height:100px;width: 700px;" data-options="required:true,validType:'length[0,600]'"></textarea></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>消息接收人:</nobr></td>
	 					<td colspan="3">
	 						<input type="hidden" id="accertuserid_rows" name="accertuserid_rows" value="推送人员"/>
							<div id="accertuseridgrid" style="height:300px;width: 710px;"></div>
	 					</td>
					</tr>
				</table>
			</sicp3:groupbox>	
			<br/>
  			<div align="center">
          		<a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" 
            		onclick="sendMessage()"data-options="iconCls:'icon-save'">发送</a>
    		</div>
        </div> 
	</form>
</div>
</body>
</html>