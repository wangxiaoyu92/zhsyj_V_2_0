<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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

<title>量化分级统计</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
// 企业大类
var v_niandulist = <%=SysmanageUtil.getcheckyearlist()%>;

$(function() {
		//年度列表
		$('#checkyear').combobox({
			data:v_niandulist,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});
	
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			fit:true,
			toolbar: '#toolbar',
			//url: basePath + '/lhfj/queryLhfjtj',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 200,
			pageList : [ 200, 400, 600,800,1000 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'comid', //该列是一个唯一列
		    nowrap:false,	
		    onClickRow:function(rowIndex, rowData){
		    },
			columns : [ [
	        {
				width : '100',
				title : '企业ID',
				field : 'comid',
				hidden : true
			},{
				width : '100',
				title : '年度',
				field : 'checkyear',
				hidden : false
			},{
				width : '150',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '企业地址',
				field : 'comdz',
				hidden : false
			},{
				width : '80',
				title : '检查总次数',
				field : 'checkcountsum',
				hidden : false
			},{
				width : '80',
				title : '完成次数',
				field : 'checkovercount',
				hidden : false
			} ,{
				width : '80',
				title : '未完成次数',
				field : 'checknoovercount',
				hidden : false
			} ,{
				width : '80',
				title : '符合次数',
				field : 'checkfhcount',
				hidden : false
			},{
				width : '80',
				title : '不符合次数',
				field : 'checkbfhcount',
				hidden : false
			},{
				width : '120',
				title : '限期整改次数',
				field : 'checkxqzgcount',
				hidden : false
			},{
				width : '210',
				title : '根据年度等级判断本年度应检查次数',
				field : 'lhfjpdndyjccs',
				hidden : false
			},{
				width : '170',
				title : '根据等级判定还应检查次数',
				field : 'hyjccs',
				hidden : false
			} 
			] ],
			toolbar: '#toolbar'
		});
});
	
	function query() {
		var param = {
			'comid': $('#comid').val(),
			'commc': $('#commc').val(),
			'checkyear':$('#checkyear').combobox('getValue'),
			'checkcountsumstart':$('#checkcountsumstart').val(),
			'checkcountsumend':$('#checkcountsumend').val(),
			
			'checkovercountstart':$('#checkovercountstart').val(),
			'checkovercountend':$('#checkovercountend').val(),
			
			'checknoovercountstart':$('#checknoovercountstart').val(),
			'checknoovercountend':$('#checknoovercountend').val(),
			
			'checkfhcountstart':$('#checkfhcountstart').val(),
			'checkfhcountend':$('#checkfhcountend').val(),
			
			'checkbfhcountstart':$('#checkbfhcountstart').val(),
			'checkbfhcountend':$('#checkbfhcountend').val(),
			
			'checkxqzgcountstart':$('#checkxqzgcountstart').val(),
			'checkxqzgcountend':$('#checkxqzgcountend').val(),
			
			'lhfjpdndyjccsstart':$('#lhfjpdndyjccsstart').val(),
			'lhfjpdndyjccsend':$('#lhfjpdndyjccsend').val(),
			
			'hyjccsstart':$('#hyjccsstart').val(),
			'hyjccsend':$('#hyjccsend').val()			
			
		};
		mygrid.datagrid({
			url : basePath + '/lhfj/queryLhfjtj',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections'); 
	}

	//从单位信息表中读取
	function myselectcom(){
	    var url = basePath + 'pub/pub/selectcomIndex';
		var dialog = parent.sy.modalDialog({
				title : '选择企业',
				param : {
					singleSelect : "true"
				},
				width : 800,
				height : 600,
				url : url
		},function(dialogID) {
			v_retStr = sy.getWinRet(dialogID);
			if (v_retStr!=null && v_retStr.length>0){
			    for (var k=0;k<=v_retStr.length-1;k++){
			      var myrow=v_retStr[k];
			      $("#commc").val(myrow.commc); //公司名称   
			      $("#comid").val(myrow.comid); //公司代码         
			    }
			}
		    sy.removeWinRet(dialogID);//不可缺少
		});    
	}
	
	function refresh(){
		parent.window.refresh();	
	} 	
	
	//查看结果明细
	var viewCheckDetail = function() {
	var row = $("#mygrid").datagrid('getSelected');
	var v_dokind="lhfjtj";
	if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看检查结果',
				width :1140,
			    height :560,
				url : basePath + 'jsp/supervision/lhfj/lhfjcx.jsp?dokind='+v_dokind+'&checkyear='+row.checkyear+'&comid='+row.comid,
				buttons : [ 
				{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
		    $.messager.alert('提示','请先选择要查看的记录！','info');
		}
	};
	
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true" style="border: 2px solid blue;">      
        <div region="north"  style="height:80px;overflow: false;border: 1px solid red;">
       		<table style="width: 100%;height:98%;overflow: false;">
       		    <tr>
					<td style="text-align:right;"><nobr>年度</nobr></td>
					<td><input id="checkyear" name="checkyear" style="width: 100px" /></td>        		    
					<td style="text-align:right;"><nobr>企业名称</nobr></td>
					<td colspan="5">
					    <input type="hidden" id="comid" name="comid"/>
					    <input id="commc" name="commc" style="width:300px" />
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="myselectcom()">选择企业 </a>						
					</td>	
				</tr>	
				<tr>
					<td style="text-align:center;" colspan="8">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
					</td>													
				</tr>				
			</table>             
        </div>
        <div region="center" style="overflow: false;border: 2px solid green;">
			<div id="nddtpj" class="easyui-tabs" style="" fit="true" >
			    <div title="未评定" style="border: 1px solid red;" >
					<div id="mygrid" style=""></div>
			    </div>
			    <div title="已评定"  style="border: 1px solid red;" >
					<div id="mygrid" style=""></div>
			    </div>
			</div>	             
        </div>      
    </div>   
</body>
</html>