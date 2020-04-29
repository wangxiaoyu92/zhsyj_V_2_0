<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
<%@ page import="com.zzhdsoft.siweb.dto.FjDTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>

<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ contextPath +"/";
%>
<%
    String v_ZuoWeiIframe = StringHelper.showNull2Empty(request.getParameter("ZuoWeiIframe"));
    String v_fjwid = StringHelper.showNull2Empty(request.getParameter("fjwid"));
    String v_fjtype = StringHelper.showNull2Empty(request.getParameter("fjtype"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>附件预览</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
<script type="text/javascript"> 
var mygrid;
$(function() {
	   mygrid = $('#mygrid').datagrid({
		//title: '进货主表',
		//iconCls: 'icon-tip',
		toolbar: '#toolbar',
		url : basePath + '/pub/pub/queryFjViewMap?fjtype=<%=v_fjtype%>&fjwid=<%=v_fjwid%>',
		striped : true,// 奇偶行使用不同背景色
		singleSelect : true,// True只允许选中一行
		checkOnSelect : false,
		selectOnCheck : false,			
		pagination : true,// 底部显示分页栏
		pageSize : 10,
		pageList : [ 10, 20, 30 ],
		rownumbers : true,// 是否显示行号
		fitColumns : false,// 列自适应宽度			
	    idField: 'hjhbid', //该列是一个唯一列
	    nowrap:false,	
	    onLoadSuccess:function(data){
	    	mygrid.datagrid("unselectAll"); 
	    },
		columns : [[  
        {
			width : '11',
			title : 'fjid',
			field : 'fjid',
			hidden : true
		},
		{
			width : '11',
			title : 'fjwid',
			field : 'fjwid',
			hidden : true
		}
		,{
			width : '350',
			title : '附件路径',
			field : 'fjpath',
			hidden : false					
		},{
			width : '260',
			title : '附件名称',
			field : 'fjname',
			hidden : false	
		},{field:'opt',title:'操作',align:'center',width:200,
            formatter:function(value,rec){   
			    var v_ret='<span style="color:blue" mce_style="color:blue">';
			    v_ret+='<a href="javascript:chakanFuJian(\''+rec.fjpath+'\')" mce_href="#"><img src="<%=basePath%>/images/pub/view.gif" align="absmiddle">查看附件</a> </span>';
			    v_ret+='&nbsp;&nbsp;<a href="javascript:deletefj(\''+rec.fjid+'\')" mce_href="#"><img src="<%=basePath%>/images/pub/no2.png" align="absmiddle">删除</a> </span>';
			    return v_ret;
             }   
        } 
		]]
	});
});/////////////////////////////////////////

function deletefj(prm_fjid) {
		$.messager.confirm('警告', '您确定要删除该记录吗?',function(r) {
			if (r) {
				$.post(basePath + '/pub/pub/delFj', {
					fjid: prm_fjid
				},
				function(result) {
					if (result.code == '0') {
						$.messager.alert('提示','删除成功！','info',function(){
							$('#mygrid').datagrid('reload'); 
		        		});    	
					} else {
						$.messager.alert('提示', "删除失败：" + result.msg, 'error');
					}
				},
				'json');
			}
		});

} 

//查看附件

	function chakanFuJian(prm_fjpath) {
		var dialog = parent.sy.modalDialog({
			title : '查看视频',
			width : 550,
			height : 450,
			url : basePath + 'jsp/jk/playvideo.jsp?videopath='+prm_fjpath,
			buttons : [{
				text : '关闭',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	} 

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
        <div region="center" style="overflow: true;" border="false">
		  <div id="mygrid" style="height:220px;overflow:auto;"></div>
        </div>
    </div> 
</body>
</html>