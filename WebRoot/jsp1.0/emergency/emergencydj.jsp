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
<title>突发事件登记管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉列表
	var eventlevel = <%=SysmanageUtil.getAa10toJsonArray("EVENTLEVEL")%>;
	var eventstate = <%=SysmanageUtil.getAa10toJsonArray("EVENTSTATE")%>;
	var cb_eventlevel;
	var cb_eventstate;
	var mygrid;

	$(function() {
		cb_eventlevel = $('#eventlevel').combobox({
	    	data : eventlevel,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_eventstate = $('#eventstate').combobox({
	    	data : eventstate,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		mygrid = $('#mygrid').datagrid({
			toolbar: '#toolbar',
			url: basePath + '/emergency/queryEmergency',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'eventid', //该列是一个唯一列
		    sortOrder: 'asc',
		    onClickRow:function(rowIndex, rowData){
			  if (rowData.eventstate == "1"){
			  	//$("#btn_updateEmergency").linkbutton('disable');
				//$("#btn_delEmergency").linkbutton('disable');
			  }else{
				//$("#btn_updateEmergency").linkbutton('enable');
				//$("#btn_delEmergency").linkbutton('enable');
			  }
		    },	
			columns : [ [{
				width : '200',
				title : '突发事件ID',
				field : 'eventid',
				hidden : false
			},{
				width : '300',
				title : '事件内容',
				field : 'eventcontent',
				hidden : false
			},{
				width : '200',
				title : '事件发生地点',
				field : 'eventaddress',
				hidden : false
			},{
				width : '150',
				title : '事件发生时间',
				field : 'eventdate',
				hidden : false
			} ,{
				width : '100',
				title : '事件等级',
				field : 'eventlevel',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(eventlevel,value);
				}
			},{
				width : '120',
				title : '事件处理状态',
				field : 'eventstate',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(eventstate,value);
				}
			},{
				width : '100',
				title : '事件上报人',
				field : 'newsinitiator',
				hidden : false
			},{
				width : '100',
				title : '上报人联系方式',
				field : 'eventfinder',
				hidden : false
			},{
				width : '100',
				title : '经办人',
				field : 'operateperson',
				hidden : false
			},{
				width : '150',
				title : '经办时间',
				field : 'operatedate',
				hidden : false
			}  ] ]
		});
	});

	// 新增
	var addEmergency = function() {
		var dialog = parent.sy.modalDialog({
			title : '添加突发事件信息',
			width : 900,
			height : 600,
			url : basePath + '/emergency/emergencyFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};
	
	// 编辑突发事件登记信息
	function updateEmergency() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑突发事件登记信息',
				width : 870,
				height : 600,
				url : basePath + '/emergency/emergencyFormIndex?eventid=' + row.eventid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
					}
				},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的突发事件登记信息！', 'info');
		}
	};
	
	// 查看突发事件登记信息
	function showEmergency() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看突发事件登记信息',
				width : 870,
				height : 600,
				url : basePath + '/emergency/emergencyFormIndex?op=view&eventid=' + row.eventid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的突发事件登记信息！', 'info');
		}
	};

	// 删除突发事件登记信息
	function delEmergency() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_eventid = row.eventid;

			$.messager.confirm('警告', '您确定要删除该突发事件信息吗?',function(r) {
				if (r) {
					$.post(basePath + '/emergency/delEmergency', {
						eventid: v_eventid
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
			$.messager.alert('提示', '请先选择要删除的突发事件登记信息！', 'info');
		}
	} 
	// 查询
	function query() {
		var param = {
			'eventlevel': $('#eventlevel').combobox('getValue'),
			'eventstate': $('#eventstate').combobox('getValue') 
		};
		mygrid.datagrid({
			url : basePath + '/emergency/queryEmergency',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');  
	}
	
	// 刷新表格	
	function refresh(){
		parent.window.refresh();	
	} 
	
	// 从预案信息表中读取
	function myselectyaxx(){
		<%-- var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=myShowModalDialog("<%=basePath%>emergency/selectyaxxIndex?a="+new Date().getMilliseconds(),obj,
	        800,600); --%>
	    var url = '<%=basePath%>emergency/selectyaxxIndex';
	    var dialog = parent.sy.modalDialog({  
	    		title : "预案信息",
				width : 800,
				height : 600,  
				url : url
			},function(dialogID){
				var v_retStr = sy.getWinRet(dialogID); 
					if (v_retStr!=null && v_retStr.length>0){
				    for (var k=0;k<=v_retStr.length-1;k++){
				      var myrow = v_retStr[k];
				      $("#yaxxbh").val(myrow.newsid); // 新闻id   
				    }};      
				sy.removeWinRet(dialogID);
			});
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
						<td style="text-align:right;"><nobr>预案信息编号:</nobr></td>
						<td><input id="yaxxbh" name="yaxxbh" style="width: 175px"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectyaxx()">选择预案信息 </a>						
						</td>
						<td style="text-align:right;"><nobr>事件等级:</nobr></td>
						<td><input id="eventlevel" name="eventlevel" style="width: 175px" /></td>
						<td style="text-align:right;"><nobr>事件处理状态:</nobr></td>
						<td><input id="eventstate" name="eventstate" style="width: 175px" /></td>							
					</tr>
					<tr>
						<td style="text-align:left;" colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="突发事件登记列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addEmergency" id="btn_addEmergency"
								iconCls="icon-add" plain="true" onclick="addEmergency()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 	
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showEmergency" id="btn_showEmergency"
								iconCls="ext-icon-application_form_magnify" plain="true" onclick="showEmergency()">查看</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 	
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateEmergency" id="btn_updateEmergency"
								iconCls="icon-edit" plain="true" onclick="updateEmergency()">编辑</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delEmergency" id="btn_delEmergency" 
								iconCls="icon-remove" plain="true" onclick="delEmergency()">删除</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
						</tr>
					</table>
				</div>
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>   
</body>
</html>