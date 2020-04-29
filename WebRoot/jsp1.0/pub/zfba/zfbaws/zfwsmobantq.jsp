<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="java.net.URLDecoder,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
    String v_zfwsdmz= StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
    String v_zfwsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("zfwsdmmc")),"UTF-8");
    v_zfwsdmmc=v_zfwsdmmc+" --模板列表";
    
    Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();
    String v_userid=vSysUser.getUserid();    
   
%>
<!DOCTYPE html>
<html>
<head>
<title>模板提取</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;

$(function() {
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/wsgldy/queryZfwsmobanlist',
		    queryParams:{
			  zfwsdmz:'<%=v_zfwsdmz%>'
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'zfwsmbid', //该列是一个唯一列  
		    sortOrder: 'asc',			
			columns : [ [{
				width : '60',
				title : '添加地区',
				field : 'aaa146',
				hidden : false
			},{
				width : '100',
				title : '执法文书模板ID',
				field : 'zfwsmbid',
				hidden : true								
			},{
				width : '100',
				title : '案件登记ID',
				field : 'ajdjid',
				hidden : true
			},{
				width : '100',
				title : '执法文书编号',
				field : 'zfwsdmz',
				hidden : true
			},{
				width : '100',
				title : '执法文书所在表ID',
				field : 'zfwsqtbid',
				hidden : true
			},{
				width : '400',
				title : '执法文书模板名称',
				field : 'zfwsmbmc',
				hidden : false
			},{
				width : '120',
				title : '操作员',
				field : 'zfwsmbczy',
				hidden : false
			},{
				width : '120',
				title : '操作时间',
				field : 'zfwsmbczsj',
				hidden : false
			},{
				width : '120',
				title : '用户ID',
				field : 'userid',
				hidden : true
			},
			{field:'opt',title:'操作',align:'left',width:120,
              formatter:function(value,rec){   
		    	  var v_OperRet='<a href="javascript:queding()" mce_href="#"><img src="<%=basePath%>images/pub/ok.png" align="absmiddle">确定选择</a>&nbsp;';		    	     
		    	  
		    	  var v_sysuserid='<%=v_userid%>';		    	  
		    	  if (rec.userid!=null && !rec.userid=="" && v_sysuserid==rec.userid){
		    	    v_OperRet+='<a href="javascript:deleteMoban(\''+rec.zfwsmbid+'\')" mce_href="#"><img src="<%=basePath%>images/pub/delete.gif" align="absmiddle">删除</a>';		    	  
		    	  }
		    	  return v_OperRet;	                   
             }   
	        }  
			] ]
		});
		
});

//删除附件
function deleteMoban(v_zfwsmbid){
  if ((v_zfwsmbid==null) || (v_zfwsmbid.length==0)){
    alert("请选择要删除的文书模板");
    return false;
  }
  
 var cfmMsg= "确定删除此条录吗?";
 $.messager.confirm('确认', cfmMsg, function (r) {
    if(r){
		$.ajax({
    		url: basePath+'/pub/wsgldy/wsgldyDel',
    		type: 'post',
    		async: true,
    		cache: false,
    		timeout: 100000,
    		data: 'zfwsmbid=' + v_zfwsmbid,
    		dataType: 'json',
    		error: function() {
    			$.messager.alert('提示','服务器繁忙，请稍后再试！','info');				
    		},
    		success: function(result){
    			if (result.code=='0'){	
	        		$.messager.alert('提示','删除成功','info',function(){
	        			mygrid.datagrid("reload");
	                }); 	                        
              	} else {
              		$.messager.alert('提示','删除失败:'+result.msg,'error');
                }
	        }  
		});
    }});
}


	function queding(){
		$.messager.confirm('警告', '您确定要选择该模板吗?',function(r) {
			if(r){
		    	var rows=mygrid.datagrid('getSelections'); 
			   	if (rows!="") {
					if(sy.IsNull(sy.getDialogId()) == ''){
						sy.setWinRet(rows);
					   	parent.$("#"+sy.getDialogId()).dialog("close");
				   	}else{
					   sy.setWinRet(rows);
					   parent.$("#"+sy.getDialogId()).dialog("close");
				   	}
				}else{
					$.messager.alert('提示', '请先选择模板信息！', 'info');
				} 
		   }	
		 });
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="<%=v_zfwsdmmc%>">
				<div id="mygrid" style="height:400px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>   
</body>
</html>