<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String v_qtbid = StringHelper.showNull2Empty(request.getParameter("qtbid"));
	String v_fsxtbz=URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fsxtbz")),"utf-8");//发送者系统级备注
	String v_opkind=StringHelper.showNull2Empty(request.getParameter("opkind"));//操作类型1报请2已阅
%>
<!DOCTYPE html>
<html>
<head>

<title>待办事项</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
$(function(){
	//案件承办人
	var v_jieshouren_table=$("#jieshouren_table");
	v_jieshouren_table.datagrid({
		title :'接收人',
		//iconCls : 'icon-tip',
		url : basePath+'/pub/pub/queryJieshouren',
		queryParams: {
			qtbid:'<%=v_qtbid%>'
		},
		nowrap:false,	
		striped : true, //奇偶行使用不同的颜色
		singleSelect : false, // 只允许选择一行
		checkOnSelect : true, //当用户点击行的时候就选中
		selectOnCheck : true,  //单击复选框将选择行
		pagination : false, //底部显示分页栏
		pageSize : 10,  //每页显示的页数
		pageList : [10,20,30],  //每页显示的页数（供选择）
		rownumbers : true,  //是否显示行号
		fitColumns :false,  //列自适应宽度  防止滚动
		idField : 'pdbsxjsrid',  //该列是一个唯一列 也是数据库中的表的主键
		sortOrder : 'asc',  //按升序排序
		columns :[[
			{
				title : '待办事项接收人表ID',
				field : 'pdbsxjsrid',
				width : 50,
				hidden : true
			},{
				title : '待办事项表主键',
				field : 'pdbsxid',
				width : 50,
				hidden:true
			},{
				title : '接收人所属机构id',
				field : 'jsorgid',
				align : 'center',
				width : 130,
				editor : 'textarea',
				hidden:true
			},{
				title : '接收人所属机构名称',
				field : 'jsorgname',
				align : 'center',
				width : 280,
				editor : 'textarea'
			},{
				title : '接收用户id',
				field : 'jsuserid',
				width : 50,
				editor : 'textarea',
				hidden:true
			},{
				title : '接收人姓名',
				field : 'jsusername',
				width : 90,
				editor : 'textarea',
				hidden:false
			},{
				title : '接收人已阅时间',
				field : 'jssj',
				width : 120,
				editor : 'textarea',
				hidden:false
			},{
				title : '接收人已阅回复',
				field : 'jsclyj',
				width : 320,
				editor : 'textarea',
				hidden:false
			}
		]],		
		//工具栏
		toolbar :[{
			iconCls : 'icon-add',
			text : '选择接收人',
			handler : function(){
				myselectAjdjXgry("jsr");
			 }
		    },{
				iconCls: 'icon-remove',
				text: '删除',
				handler: function () {
					mydatagrid_remove(v_jieshouren_table);
				}
			}]
	});
	
	if ($('#qtbid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + '/pub/pub/queryJieshourenDTO', {
			qtbid : $('#qtbid').val()
		}, 
		function(result) {
			if (result.code=='0') {
				var mydata = result.data;	
				$('form').form('load', mydata);			
			} else {
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
            }	
			parent.$.messager.progress('close');
		}, 'json');
	}	
	
	if('<%=v_opkind%>' == '2'){	
		$('form :input').addClass('input_readonly');
		$('form :input').attr('readonly','readonly');				
		//$('#btnselectcom').attr('visible',false);	
		//$('#savePhotoWeb').attr('disabled',true);
		$('.Wdate').attr('disabled',true);	
		//v_ajdjajly.combobox('disable',true);		
	}	
	$("#fsnr").focus();
});

//从单位信息表中读取
function myselectAjdjXgry(prm_rykind){
      var url= basePath + "jsp/pub/pub/selectuser.jsp";
        var dialog = parent.sy.modalDialog({ 
				title : '选择接收人',
				param : {
					singleSelect : "false",
					querykind : "all",
					a : new Date().getMilliseconds()
					
				},
				width : 1000,
				height : 600, 
				url : url
			},function(dialogID){
				var v_retStr = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				
				if (v_retStr!=null && v_retStr.length>0){
	    			for (var k=0;k<=v_retStr.length-1;k++){
	    				var myrow = v_retStr[k];
	    				mydatagrid_selectman_addRow(prm_rykind, myrow);      
	    }
    }; 
			});
}

function mydatagrid_selectman_addRow(v_tablekind, v_manrow) {
    var v_table;
    var v_rowindex;

    var v_userid = v_manrow.userid; //人员ID
    var v_orgname = v_manrow.orgname; //机构名称
    var v_orgid = v_manrow.orgid; //机构名称
    var v_description = v_manrow.description; //人员姓名
    var v_username = v_manrow.username; //用户登录账号
    
    if (v_tablekind!=null && v_tablekind=="jsr") {  //承办人
        v_table = $("#jieshouren_table");
        v_rowindex = mydatagrid_append(v_table);
        if (v_rowindex == -1) {
           return false;
        }
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'jsuserid'})).target).val(v_userid);//人员ID
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'jsusername'})).target).val(v_description);//姓名
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'jsorgid'})).target).val(v_orgid);//证件号码
        $((v_table.datagrid('getEditor', {index: v_rowindex, field: 'jsorgname'})).target).val(v_orgname);//人员ID
    }    
    mydatagrid_endEditing(v_table);
}

//添加一行
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

//编辑状态
function mydatagrid_endEditing(v_datagrid){
	//var editIndex = v_datagrid.datagrid('getRowIndex',v_datagrid.datagrid('getSelected'));
	var editIndex = editIndex=v_datagrid.datagrid('getRows').length-1;
	//如果某一行处于校验状态，那么这一行处于编辑状态
	if(v_datagrid.datagrid('validateRow',editIndex)){
		var ed = v_datagrid.datagrid('getEditor',{index:editIndex});  //根据行索引得到编辑器
		v_datagrid.datagrid('endEdit',editIndex);
		return true;
	}else{
		return false;
	}
}

//删除一行
function mydatagrid_remove(v_datagrid){
	var index = v_datagrid.datagrid('getRowIndex',v_datagrid.datagrid('getSelected'));
	if(index == -1){
		alert("请先选择行！");
		return false;
	}
	v_datagrid.datagrid('cancelEdit',index)
			.datagrid('deleteRow',index);
	if(index-1>=0){
		v_datagrid.datagrid('selectRow',index-1);
	}
}

/**
 * 保存
 */
function mysave(){
	var url= basePath+'/pub/pub/saveJieshouren';
    mydatagrid_endEditing($('#jieshouren_table'));
    var v_jieshouren_table_rows = $('#jieshouren_table').datagrid('getRows');
    $('#jieshouren_table_rows').val($.toJSON(v_jieshouren_table_rows));
          
    if (v_jieshouren_table_rows==null || v_jieshouren_table_rows==""){
    	alert('请选择接收人');
        return false;
    }
    parent.$.messager.progress({ text : '正在提交....'});	// 显示进度条
 		
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
		 		parent.$.messager.alert('提示','保存成功成功！','info',function(){
		 			$("#saveBtn").linkbutton('disable');
		 			closeWindow();
        		}); 
           	} else {
          		parent.$.messager.alert('提示','保存失败：'+result.msg,'error');
            }
        }    
	});
}
function closeWindow (){
	parent.$("#"+sy.getDialogId()).dialog("close"); 
}
</script>
</head>
<body>
<form id="myform" method="post">
	<div id="cc" class="easyui-layout" style="width:790px;height: 590px;" fit="true">
	<form id="myform" method="post">
		<div region="center" style="overflow: false;" border="false" >
		  <input type="hidden" id="jieshouren_table_rows" name="jieshouren_table_rows" value="接收人"/>
		  <input type="hidden" id="qtbid" name="qtbid" value="<%=v_qtbid%>"/>
		  <input type="hidden" id="pdbsxid" name="pdbsxid"/>
		  <input type="hidden" id="fsxtbz" name="fsxtbz" value="<%=v_fsxtbz%>"/>
		  
		  </br>
		  <table>
		    <tr>
		      <td>报请人</td>
		      <td>
		         <input id="fsusername" name="fsusername" style="width: 150px" 
		         class="easyui-validatebox" readonly="readonly" disabled="true"
		         data-options="validType:'length[0,50]'" />
		      </td>
		      <td>报请时间</td>
		      <td>
		         <input id="fssj" name="fssj" style="width: 150px" 
		         class="easyui-validatebox" readonly="readonly" disabled="true"
		         />		      
		      </td>		      
		    </tr>
		    <tr>
		      <td>报请内容</td>
		      <td colspan="3">
				<textarea  id="fsnr" 
				 name="fsnr" style="width: 620px;text-align: left" 
				 rows="6" data-options="required:true">
				 </textarea>		      
		      </td>	      
		    </tr>	
		  </table>

		  <div id="jieshouren_table" style="height:330px;width:780px;"></div>
		  </br>
		  <div style="height:30px;float:right;" >
		       <% if ("1".equals(v_opkind)) {%>
	           <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" 
	             onclick="mysave()"data-options="iconCls:'icon-save'">保存</a>
	             <%} %>
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" 
	              onclick="closeWindow();"
	              data-options="iconCls:'icon-back'">关闭</a>	
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   	    
		  </div>
		</div>  
	</form>
	</div>
</body>
</html>