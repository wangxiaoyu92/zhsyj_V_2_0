<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>在线用户统计</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var orgid = "";		
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法		     
		    autoParam: ["orgid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "orgid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "orgname"
			}
		},
		callback: {
			onClick: onClick
		}
	};
	
	$(function() { 
		refreshZTree();	
	}); 		
	
	//初始化【机构】树
	function refreshZTree(){
		$.fn.zTree.init($("#treeDemo"), setting);
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
	    return zNodes;
	}
	
	//单击节点事件
	function onClick(event, treeId, treeNode) {		
		//stopRydw();
		orgid = treeNode.orgid;        
		//startRydw();
		getSysuserLocation2();		  
	}
</script>
<script type="text/javascript">
	//下拉框列表
	var grid;
	
	$(function() {
		grid = $('#grid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			//toolbar: '#toolbar',
			//url: basePath + 'sysmanager/sysuser/querySysuser',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'userid', //该列是一个唯一列
		    sortOrder: 'asc',
		    frozenColumns : [[ {
				width : '200',
				title : '用户ID',
				field : 'userid',
				hidden : false
			},{
				width : '80',
				title : '用户名称',
				field : 'username',
				hidden : false
			},{
				width : '150',
				title : '用户描述',
				field : 'description',
				hidden : false
			}]],			
			columns : [ [ {
				width : '100',
				title : '手机号',
				field : 'mobile',
				hidden : false
			},{
				width : '100',
				title : '手机号2',
				field : 'mobile2',
				hidden : false
			},{
				width : '150',
				title : '定位时间',
				field : 'dwsj',
				hidden : false
			},{
				width : '600',
				title : '定位地址',
				field : 'address',
				hidden : false
			} ] ]
		});	
		
		$('#rydw').on('click',startRydw);
	});
	
	//启动人员定位
	var timerRydw;
	var startRydw = function(){
		//发送定位信息
	    getAllSysuserLocation();
		timerRydw = setInterval('getSysuserLocation()',6000);
		$("#rydw").linkbutton({
        	text: "停止人员定位",
            iconCls: "ext-icon-webcam"
        });
		$('#rydw').off('click',startRydw);
		$('#rydw').on('click',stopRydw);
	};
	//停止人员定位
	var stopRydw = function(){
		clearInterval(timerRydw);
		$("#rydw").linkbutton({
        	text: "开启人员定位",
            iconCls: "ext-icon-webcam"
        });
		$('#rydw').off('click',stopRydw);
		$('#rydw').on('click',startRydw);	
		 
		orgid = "";
		//$('#online').val(0);
		//grid.datagrid('loadData',{"total":0,"rows":[]});
	};
	
	//发布指令获取当前人员的位置
	var getAllSysuserLocation = function(){
		$.post(basePath + '/common/sjb/sendPushMsgAll','json');
	};
	
	//统计【监管员】实时分布情况
	var getSysuserLocation = function(){
		orgid = "";
		var param = {
			'orgid': orgid
		};
		grid.datagrid({
			url : basePath + '/common/sjb/getSysuserLocation',			
			queryParams : param
		});
		grid.datagrid('clearSelections');
		 		
		var data = grid.datagrid('getData');
		$('#online').val(data.total);
	};
	
	//统计【监管员】实时分布情况
	var getSysuserLocation2 = function(){
		var param = {
			'orgid': orgid
		};
		grid.datagrid({
			url : basePath + '/common/sjb/getSysuserLocation',			
			queryParams : param
		});
		grid.datagrid('clearSelections');
	};
	
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="west" style="width:250px;overflow: hidden;" border="false"> 
        	<ul id="treeDemo" class="ztree" ></ul>       
        </div>
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
        			<tr>
						<td style="text-align:right;">
							<font color="red">当前定位人数：</font><input id="online" name="online" style="width: 80px" /><font color="red">人</font>								
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a id="rydw" href="javascript:void(0)" class="easyui-linkbutton" iconCls="ext-icon-webcam" >开启人员定位</a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="用户列表">
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
    </div>             
</body>
</html>