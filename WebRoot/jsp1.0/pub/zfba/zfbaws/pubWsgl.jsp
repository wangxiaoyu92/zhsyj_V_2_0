<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,java.net.URLDecoder" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    //String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));
    String v_nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
    String v_nodename = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("nodename")),"UTF-8");
    String v_psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
    Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();
    String v_userid=vSysUser.getUserid();
    String v_ajslrbz=StringHelper.showNull2Empty(request.getParameter("ajslrbz"));
%>
<!DOCTYPE html>
<html>
<head>
<title>文书管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;

$(function() {
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/wsgldy/queryAjwslist',
		    queryParams:{
			    ajdjid:'<%=v_ajdjid%>'
			    //nodeid:'<%=v_nodeid%>'
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 100,
			pageList : [ 100, 200, 300 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'ajzfwsid', //该列是一个唯一列  
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '案件执法文书ID',
				field : 'ajzfwsid',
				hidden : true								
			},{
				width : '100',
				title : '案件登记ID',
				field : 'ajdjid',
				hidden : true
			},{
				width : '100',
				title : '执法文书URL',
				field : 'zfwsurl',
				hidden : true
			},{
				width : '100',
				title : '执法文书所在表ID',
				field : 'zfwsqtbid',
				hidden : true
			},{
				width : '120',
				title : '流程环节名称',
				field : 'nodename',
				hidden : true
			},{
				width : '200',
				title : '执法文书名称',
				field : 'fjcsdmmc',
				hidden : false
			},{
				width : '80',
				title : '执法文书编号',
				field : 'zfwsdmz',
				hidden : false
			},{
				width : '80',
				title : '已传附件张数',
				field : 'zfwsycfjzs',
				hidden : false
			},{
				width : '120',
				title : 'kk',
				field : 'fjcszfwstitle',
				hidden : true
			},{
				width : '120',
				title : '执法文书填写标志',
				field : 'zfwstzbz',
				hidden : false,
				formatter:function(value,rec){
				 	if(value=="0")
				 		return '<span style=color:red>未填写</span>';
				 	else
				 		return '<span style=color:green>已填写</span>';
				 }
			},{
				width : '120',
				title : 'kk',
				field : 'baoqingyiyuebz',
				hidden : true
			},
			{field:'opt',title:'操作',align:'left',width:300,
              formatter:function(value,rec){   
		    	  var v_OperRet='<a href="javascript:uploadFuJian(\''+rec.zfwsdmz+'\')" mce_href="#"><img src="<%=basePath%>images/pub/upload.png" align="absmiddle">以附件形式上传</a>&nbsp;';
		    	      v_OperRet+='<a href="javascript:wenshuguanli('+"'"+rec.zfwsqtbid+"'"+',\''+rec.zfwsurl+'\',\''+rec.zfwsdmz+'\',\''+rec.fjcsdmmc+'\',\''+rec.fjcszfwstitle+'\',\''+rec.zfwsuserid+'\',\''+rec.ajzfwsid+'\')" mce_href="#"><img src="<%=basePath%>images/pub/icon-modify.png" align="absmiddle">填写文书</a>&nbsp;';
		    	  var v_baoqingyiyuebz=rec.baoqingyiyuebz;
		    	  if (v_baoqingyiyuebz=='0'||v_baoqingyiyuebz==""||v_baoqingyiyuebz==null){
		    		  v_OperRet+='<a href="javascript:baoqing(\''+rec.ajzfwsid+'\',\''+rec.fjcsdmmc+'\')" mce_href="#"><img src="<%=basePath%>images/pub/export_file.png" align="absmiddle">报请</a>&nbsp;';		    		  
		    	  }else{
		    		  v_OperRet+='<a href="javascript:yiyue(\''+rec.ajzfwsid+'\',\''+rec.fjcsdmmc+'\')" mce_href="#"><img src="<%=basePath%>images/pub/icon-modify.png" align="absmiddle">已阅</a>&nbsp;';
		    	  }
		    	  return v_OperRet;	                   
             }   
	        },
            {
				width : '80',
				title : '操作员Id',
				field : 'zfwsuserid',
				hidden : true
			},
            {
				width : '80',
				title : '操作员',
				field : 'zfwsczyxm',
				hidden : false
			},
            {
				width : '120',
				title : '操作时间',
				field : 'zfwsczsj',
				hidden : false
			}
			] ]
		});
});

function baoqing(v_ajzfwsid,v_fjcsdmmc){
    var obj = new Object();
    var v_fsxtbz="执法文书:"+v_fjcsdmmc;
	var url="<%=basePath%>jsp/pub/pub/baoqing.jsp?time="+new Date().getMilliseconds();
    var dialog = parent.sy.modalDialog({ 
		title : '报请',
		width : 800,
		height : 550,
		param : {
			opkind : 1,
			qtbid : v_ajzfwsid,
			fsxtbz :encodeURI(encodeURI(v_fsxtbz))
		},  
		url : url
	},function(dialogID){
		var k = sy.getWinRet(dialogID); 
		    if(typeof(k.type)!="undefined" && k.type!=null){
				if(k.type=="ok" || k.type==""){ //传递回的type为ok的时候才刷新页面。   
					mygrid.datagrid('reload');
				}
		    }
		sy.removeWinRet(dialogID);
	});
}

function yiyue(v_ajzfwsid,v_fjcsdmmc){
    var obj = new Object();
    var v_fsxtbz="执法文书:"+v_fjcsdmmc;
  	var url="<%=basePath%>jsp/pub/pub/baoqing.jsp?time="+new Date().getMilliseconds();
    var dialog = parent.sy.modalDialog({ 
		title : '已阅',
		width : 800,
		height : 600,
		param : {
			opkind : 1,
			qtbid : v_ajzfwsid,
			fsxtbz : encodeURI(encodeURI(v_fsxtbz))
		},  
		url : url
	},function(dialogID){ 
		    if(typeof(k.type)!="undefined" && k.type!=null){
				if(k.type=="ok" || k.type==""){ //传递回的type为ok的时候才刷新页面。   
					mygrid.datagrid('reload');
				}
		    }
		sy.removeWinRet(dialogID);
	});
}


function wenshuguanli(v_zfwsqtbid,v_zfwsurl,v_zfwsdmz,v_fjcsdmmc,v_fjcszfwstitle,v_zfwsuserid,v_ajzfwsid){
    var obj = new Object();
    var v_dmlb="ZFAJZFWS";
    //v_zfwsurl类似 ：pub/ajwsgl/zfwsajlydjbIndex
    
    var v_sys_userid='<%=v_userid%>';
    var v_canbaocun="1";
    if (v_sys_userid!=v_zfwsuserid){
    	v_canbaocun="0";
    }
	var url="<%=basePath%>"+v_zfwsurl+"?time="+new Date().getMilliseconds();
	if(sy.IsNull(parent.sy.modalDialog) == ''){
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 1000,
			height : 650,
			url : url
		},function (dialogID){
			var k = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if(typeof(k.type)!="undefined" && k.type!=null){
				if(k.type=="ok" || k.type==""){ //传递回的type为ok的时候才刷新页面。
					mygrid.datagrid('reload');
				}
			}
		});
	}else{
		var dialog = parent.sy.modalDialog({ 
			title : '文书填写',
			width : 1000,
			height : 650,
			param : {
				ajdjid : '<%=v_ajdjid%>',
				zfwsqtbid : v_zfwsqtbid,
				zfwsdmz : v_zfwsdmz,
				fjcsdmmc : encodeURI(encodeURI(v_fjcsdmmc)),
				fjcszfwstitle : v_fjcszfwstitle,
				canbaocun : v_canbaocun,
				ajzfwsid : v_ajzfwsid
			},  
			url : url
		},function(dialogID){
			var k = sy.getWinRet(dialogID); 
				if(typeof(k.type)!="undefined" && k.type!=null){
					if(k.type=="ok" || k.type==""){ //传递回的type为ok的时候才刷新页面。
						mygrid.datagrid('reload');
					}
				}
			sy.removeWinRet(dialogID);
		});
	}
}

//从单位信息表中读取
 function myselectZfws(){ 
		var url = basePath + "/pub/wsgldy/pubWsglAddIndex"; 
		var dialog = parent.sy.modalDialog({
			title : '添加文书',
			param : {
				ajdjid : <%=v_ajdjid%> 
			},
			width : 800,
			height : 600,
			url : url
		} ,closeModalDialogCallback);  
	}   
function closeModalDialogCallback(dialogID){		
	var obj = sy.getWinRet(dialogID);
	sy.removeWinRet(dialogID);//不可缺少	
	
	var v_fjcsdmz="";
    if(obj==null){
        return;
    }
    for (var k=0;k<=obj.length-1;k++){
      var myrow=obj[k];
      if (v_fjcsdmz==""){
    	v_fjcsdmz=myrow.fjcsdmz;  
      }else{
    	v_fjcsdmz=v_fjcsdmz+","+myrow.fjcsdmz;   
      }
    }   
    
    if (v_fjcsdmz!=""){
		$.post(basePath + '/pub/wsgldy/saveZfwsadd', {
			fjcsdmzlist: v_fjcsdmz,
			ajdjid:'<%=v_ajdjid%>',
			psbh:'<%=v_psbh%>',
			nodeid:'<%=v_nodeid%>',
			nodename:'<%=v_nodename%>'
		},
		function(result) {
			if (result.code == '0') {
				$.messager.alert('提示','新增文书成功！','info',function(){
					$('#mygrid').datagrid('reload'); 
	       		});    	
			} else {
				$.messager.alert('提示', "新增文书失败：" + result.msg, 'error');
			}
		},
		'json');
    }	
}

// 删除
function delZfws() {
	var row = $('#mygrid').datagrid('getSelected');
	if (row) {
		var v_ajdjid = row.ajdjid;

		$.messager.confirm('警告', '您确定要删除该文书吗?',function(r) {
			if (r) {
				$.post(basePath + '/pub/wsgldy/delZfws', {
					ajzfwsid: row.ajzfwsid
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
	}else{
		$.messager.alert('提示', '请先选择要删除的案件文书！', 'info');
	}
} 	
	
//上传附件
function uploadFuJian(v_fjcsdmz){
    var obj = new Object();
    var v_dmlb="ZFAJZFWS";
    //var v_fjcsdlbh="ZFBAFJ";//附件参数大类编号 执法办案附件
	var url="<%=basePath%>jsp/pub/pub/pubUploadFj.jsp?time="+new Date().getMilliseconds();
    var dialog = parent.sy.modalDialog({ 
		title : '附件管理',
		width : 980,
		height : 500,
		param : {
			ajdjid:'<%=v_ajdjid%>',
			dmlb : v_dmlb,
			fjcsdmz : v_fjcsdmz
		},  
		url : url
	},function(dialogID){
		var k = sy.getWinRet(dialogID); 
		    if(typeof(k.type)!="undefined" && k.type!=null){
				if(k.type=="ok"){ //传递回的type为ok的时候才刷新页面。   
					//window.location.reload();
				    //shuaxindata();
				}
			}
		$('#mygrid').datagrid('reload');
		sy.removeWinRet(dialogID);
	});  

}
//关闭方法
var closeWindow = function($dialog){
	$dialog.dialog('close');//有入参$dialog的关闭方法
};	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="">
			    <div title="执法办案文书列表"  style="overflow:auto;">
					<table id="mygrid" style="height:390px;width:900px;"></table>
			    </div>        	
	        </sicp3:groupbox>
        </div>
				    
       	<div id="toolbar">
       		<table>
       		   <% if (v_ajslrbz!=null && !"0".equals(v_ajslrbz)){ %>
				<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
						iconCls="icon-add" plain="true" onclick="myselectZfws();">选择文书</a> 
					</td>
					<td>  
						<div class="datagrid-btn-separator"></div>
					</td> 
					
					<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delAjdj"
						iconCls="icon-remove" plain="true" onclick="delZfws()">删除</a>
					</td>
					
					<td>  
						<div class="datagrid-btn-separator"></div>
					</td> 
				</tr>
				<%} %>
			</table>
		</div>
						        
        </form>         
    </div>   
		    

</body>
</html>