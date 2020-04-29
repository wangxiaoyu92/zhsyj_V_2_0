<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.service.AjdjService,com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
    Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
    String v_userid = vSysUser.getUserid();
%>
<!DOCTYPE html>
<html>
<head>
<title>文书模板管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
$(function() {
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/zfba/wsmbgl/queryWsmb',
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
			columns : [ [
	        {
				width : '150',
				title : '执法文书模板id',
				field : 'zfwsmbid',
				hidden : true
			},{
				width : '150',
				title : '案件登记id',
				field : 'ajdjid',
				hidden : true
			},{
				width : '120',
				title : '执法文书编号',
				field : 'zfwsdmz',
				hidden : false
			},{
				width : '100',
				title : '执法文书所在表ID',
				field : 'zfwsqtbid',
				hidden : true
			},{
				width : '300',
				title : '文书模板名称',
				field : 'zfwsmbmc',
				hidden : false
			},{
				width : '150',
				title : '操作员',
				field : 'zfwsmbczy',
				hidden : false
			},{
				width : '150',
				title : '操作时间',
				field : 'zfwsmbczsj',
				hidden : false
			},{
				width : '100',
				title : '地区编码',
				field : 'aaa027',
				hidden : false
			},{
				width : '100',
				title : '操作员id',
				field : 'userid',
				hidden : true
			},{
				width : '120',
				title : '行政区划',
				field : 'aaa146',
				hidden : false
			},{
				width : '100',
				title : '执法文书id',
				field : 'ajzfwsid',
				hidden : true
			} ,{
				width : '100',
				title : '案件登记id',
				field : 'ajdjid',
				hidden : true
			} ,{
				width : '100',
				title : '执法文书名称',
				field : 'fjcsdmmc',
				hidden : true
			},{
				width : '100',
				title : '标题',
				field : 'fjcszfwstitle',
				hidden : true
			},{
				width : '120',
				title : '路径',
				field : 'zfwsurl',
				hidden : true
			},{
				width : '80',
				title : '操作员Id',
				field : 'zfwsuserid',
				hidden : true
			},{
				width : '80',
				title : '操作员',
				field : 'zfwsczyxm',
				hidden : true
			},{
				width : '120',
				title : '操作时间',
				field : 'zfwsczsj',
				hidden : true
			},{
				width : '80',
				title : '操作员Id',
				field : 'zfwsuserid',
				hidden : true
			}
			] ],
		    frozenColumns : [[ 
			{field:'opt',title:'操作',align:'left',width:100,
              formatter:function(value,rec){
		    	  var v_OperRet='<a data="btn_wsmbglYulan" href="javascript:showWsmb(\''+rec.ajdjid+'\',\''
		    	  	+rec.zfwsqtbid+'\',\''+rec.zfwsurl+'\',\''+rec.zfwsdmz+'\',\''
		    	  	+rec.fjcsdmmc+'\',\''+rec.fjcszfwstitle+'\',\''+rec.zfwsuserid
		    	  	+'\')" mce_href="#"><img src="<%=basePath%>images/pub/doc2.png " align="absmiddle">预览</a>&nbsp;';
	    		  	v_OperRet+='<a data="btn_wsmbglBianji" href="javascript:wenshuguanli(\''+rec.ajdjid+'\',\''
	    		  	+rec.zfwsqtbid+'\',\''+rec.zfwsurl+'\',\''+rec.zfwsdmz+'\',\''
	    		  	+rec.fjcsdmmc+'\',\''+rec.fjcszfwstitle+'\',\''+rec.zfwsuserid
	    		  	+'\')" mce_href="#"><img src="<%=basePath%>images/pub/icon-modify.png" align="absmiddle">编辑</a>&nbsp;';
	    		  /* v_OperRet+='<a href="javascript:deleteWsmb()" mce_href="#"><img src="../../images/pub/edit_remove.png" align="absmiddle">删除</a>&nbsp;'; */
		    	  return v_OperRet;	                   
             }   
	        }
			]]
		});
});

	//编辑文书模板
	function wenshuguanli(v_ajdjid,v_zfwsqtbid,v_zfwsurl,v_zfwsdmz,v_fjcsdmmc,v_fjcszfwstitle,v_zfwsuserid){
	    var v_dmlb="ZFAJZFWS";
	    //v_zfwsurl类似 ：pub/ajwsgl/zfwsajlydjbIndex
	    var v_sys_userid='<%=v_userid%>';
	    var v_canbaocun="1";
	    if (v_sys_userid!=v_zfwsuserid){
	    	v_canbaocun="0";
	    }
	    var url = encodeURI(encodeURI(basePath + v_zfwsurl));
		var dialog = parent.sy.modalDialog({
				title : '文书管理',
				param : {
					ajdjid : v_ajdjid,
					zfwsqtbid : v_zfwsqtbid,
					zfwsdmz : v_zfwsdmz,
					fjcsdmmc : v_fjcsdmmc,
					fjcszfwstitle : v_fjcszfwstitle,
					canbaocun : v_canbaocun,
					time : new Date().getMilliseconds()
				},
				width : 1000,
				height : 650,
				url : url
		},function(dialogID) {
			var obj = sy.getWinRet(dialogID);
			if(obj.type=='ok'){
				mygrid.datagrid('reload');
			}
		    sy.removeWinRet(dialogID);//不可缺少
		});
	}
	
	//预览文书模板
	function showWsmb(v_ajdjid,v_zfwsqtbid,v_zfwsurl,v_zfwsdmz,v_fjcsdmmc,v_fjcszfwstitle,v_zfwsuserid){
	    var obj = new Object();
	    var v_dmlb="ZFAJZFWS";
	    //v_zfwsurl类似 ：pub/ajwsgl/zfwsajlydjbIndex
	    var v_sys_userid='<%=v_userid%>';
	    var v_canbaocun="1";
	    if (v_sys_userid!=v_zfwsuserid){
	    	v_canbaocun="0";
	    }
	    var url = encodeURI(encodeURI(basePath + v_zfwsurl));
		var dialog = parent.sy.modalDialog({
				title : '预览',
				param : {
					ajdjid : v_ajdjid,
					zfwsqtbid : v_zfwsqtbid,
					zfwsdmz : v_zfwsdmz,
					fjcsdmmc : v_fjcsdmmc,
					fjcszfwstitle : v_fjcszfwstitle,
					canbaocun : v_canbaocun,
					time : new Date().getMilliseconds()
				},
				width : 1000,
				height : 650,
				url : url
		},function(dialogID) {
			var obj = sy.getWinRet(dialogID);
			if(obj.type=='ok'){
				mygrid.datagrid('reload');
			}
		    sy.removeWinRet(dialogID);//不可缺少
		});
	}
	
	function query() {
		var param = {
			'zfwsdmz': $('#zfwsdmz').val(),
			'zfwsmbmc': $('#zfwsmbmc').val(),
			'zfwsmbczy': $('#zfwsmbczy').val()
		};
		mygrid.datagrid({
			url : basePath + '/zfba/wsmbgl/queryWsmb',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections'); 
	}
	
	function refresh(){
		parent.window.refresh();	
	} 
	

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>执法文书编号</nobr></td>
						<td><input id="zfwsdmz" name="zfwsdmz" style="width:200px" /></td>	
						<td style="text-align:right;"><nobr>文书模板名称</nobr></td>
						<td><input id="zfwsmbmc" name="zfwsmbmc" style="width:200px" /></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>操作员</nobr></td>
						<td><input id="zfwsmbczy" name="zfwsmbczy" style="width: 200px" /></td>
						<td style="text-align:center;" colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>		
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="文书模板列表">
	        	<!-- <div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveAjdj"
								iconCls="icon-add" plain="true" onclick="addAjdj()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
						</tr>
					</table>
				</div> -->
				<div id="mygrid" class="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>   
</body>
</html>