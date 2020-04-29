<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 产品批次id
	String cppcid = StringHelper.showNull2Empty(request.getParameter("cppcid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>产品溯源码</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;

$(function() {					
		mygrid = $('#mygrid').datagrid({
			url: basePath + '/spsy/spproduct/queryProductSyms',  
			queryParams: {
				cppcid: "<%=cppcid%>"
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect:true,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,	
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'qsymscmxbid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '溯源码明细表ID',
				field : 'qsymscmxbid',
				hidden : true
			},{
				width : '100',
				title : '溯源码生成表id',
				field : 'qsymscbid',
				hidden : true
			},{
				width : '300',
				title : '溯源码',
				field : 'sym',
				hidden : false
			},{
				width : '300',
				title : '溯源码图片路径',
				field : 'qrcodepath',
				hidden : false
			},
			{field:'opt',title:'操作',align:'center',width:120,
	              formatter:function(value,rec){   
				    var v_ret='<span style="color:blue" mce_style="color:blue">';
				    v_ret+='<a href="javascript:qrcodeManager(\''+rec.qsymscmxbid+'\')" mce_href="#"><img src="<%=basePath%>/images/pub/view.gif" align="absmiddle">查看二维码</a> </span>';
				    return v_ret;
	             }   
	        } 				
			] ]
		});
});

// 二维码管理
function qrcodeManager(prm_qsymscmxbid){
	var url = basePath + "jsp/spsy/spproduct/showSymQRcode.jsp";
	var dialog = parent.sy.modalDialog({
			title : '溯源码',
			param : {
				qsymscmxbid : prm_qsymscmxbid
			},
			width : 400,
			height : 400,
			url : url,
			buttons : [{
				text : '关闭',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
	}, closeModalDialogCallback);
}
// 窗口关闭回掉函数
function closeModalDialogCallback(dialogID){		
	sy.removeWinRet(dialogID);//不可缺少		
}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="width: 900PX;" border="false">
        	<sicp3:groupbox title="产品溯源码">12121
				<div id="mygrid" style="width: 900PX;height:450px;overflow:false;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   
</body>
</html>