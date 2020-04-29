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
%>
<!DOCTYPE html>
<html>
<head>
<title>自动组卷</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var qsnTypeGrid; // 试题类型列表
	var paperTypeGrid; // 试卷试题类型表格
	var v_qsnInfoType = <%=SysmanageUtil.getAa10toJsonArray("QSNLX")%>; // 试题类型
	$(function() {
		// 试卷状态
		$("#paperInfoState").combobox({
	    	data : [{"id":"1","text":"启用"},{"id":"0","text":"禁用"}], // 试卷状态      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function(){
	        	$("#paperInfoState").combobox("select", "1");
        	}
	    });
		loadQsnTypeGrid();
		loadPaperQsnTypeGird();
	});
	// 加载试题类型列表
	function loadQsnTypeGrid() {
		// 试题类型列表
	    qsnTypeGrid = $('#qsnTypeGrid').datagrid({
			title: '试题类型',
			url: basePath + 'exam/paper/queryQsnNumOfType',
			striped : true, // 奇偶行使用不同背景色
			singleSelect : true, // True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 20,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度	
			idField: 'qsnInfoType', //该列是一个唯一列		
		    sortOrder: 'desc',
			columns : [ [ {
				width : '150',
				title : '试题类型',
				field : 'qsnInfoType',
				hidden : true
			},{
				width : '150',
				title : '试题类型',
				field : 'name',
				hidden : false
			},{
				width : '100',
				title : '试题数量',
				field : 'num',
				hidden : false
			}] ]
		});
	}
	// 加载试卷试题类型表格
	function loadPaperQsnTypeGird() {
		paperTypeGrid = $('#paperQsnTypegrid').datagrid({
			toolbar: '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度	
			columns : [ [ {
				title: '大题类型',
				field: 'qsnType',
				width : '100',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_qsnInfoType, value);
			    },
				editor : {
					type : 'combobox',
					options : {
						data : v_qsnInfoType,     
				        valueField : 'id',   
				        textField : 'text',
				        required : true,
				        panelHeight : 'auto' 
					}
				}
			},{
				title: '大题名称',
				field: 'qsnTypeTitle',
				width: '200',
				hidden: false,
				editor : {
					type : 'validatebox',
					options : {
						required : true
					}
				}
			},{
				title: '试题分值(每题)',
				field: 'qsnPoint',
				align: 'center',
				width: '100',
				hidden : false,
				editor : {
					type : 'numberbox',
					options : {
						required : true
					}
				}
			},{
				title: '试题条数',
				field: 'qsnNum',
				align:'center',
				width: '100',
				hidden : false,
				editor : {
					type : 'numberbox',
					options : {
						required : true
					}
				}
			} ] ],
			onDblClickRow:function(){ //双击事件 查看、修改等操作
		        var selected = paperTypeGrid.datagrid('getSelected');
				if (selected) {
					mydatagrid_edit(paperTypeGrid);
					mydatagrid_exceptEndEditing(paperTypeGrid);
				}
		    },
		    //工具栏
		    toolbar: [{
		    	iconCls: 'icon-add',
		    	text: '增加',
		    	handler: function() {
		    		mydatagrid_append(paperTypeGrid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-edit',
		    	text: '修改',
		    	handler: function() {
		    		mydatagrid_edit(paperTypeGrid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-remove',
		    	text: '删除',
		    	handler: function() {
	    			mydatagrid_remove(paperTypeGrid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-undo',
		    	text: '取消',
		    	handler: function() {
		    		mydatagrid_reject(paperTypeGrid);
		    	}
		    },
		    '-', {
		    	iconCls: 'icon-save',
		    	text: '保存',
		    	handler: function() {
		    		var row = paperTypeGrid.datagrid('getSelected'); // 获取选中行
		    		if (mydatagrid_endEditing(paperTypeGrid)) { 
		    			var rowIndex = qsnTypeGrid.datagrid('getRowIndex', row.qsnType);
				        var data = qsnTypeGrid.datagrid('getData').rows[rowIndex];
				        var num = data.num;
				        if (parseInt(row.qsnNum) > parseInt(num)) {
				        	$.messager.confirm('警告', '所出试题超出了题库试题！',function() {
				        		paperTypeGrid.datagrid('rejectChanges');
							});
				        } else {
				        	mydatagrid_endEditing(paperTypeGrid);
				        	paperTypeGrid.datagrid('acceptChanges');
				        	reloadPaperAllPoint(); // 重新加载试题总分
				        }
		    		}
		    	}
		    }]
		});
	}
	// 重新加载试卷总分
	function reloadPaperAllPoint() {
		var allPoint = 0; // 总分初始值设为0
		var rows = paperTypeGrid.datagrid('getRows'); // 所有行
		for (var i = 0; i < rows.length; i++) {
			var qsnPoint = parseInt(rows[i].qsnPoint);
			var qsnNum = parseInt(rows[i].qsnNum);
			allPoint += qsnPoint * qsnNum;
		}
		$("#allPoints").val(allPoint);
	}
	// 开始组卷
	function startMakePaper() {
		var fromData = getFormData();
		$.messager.progress();	// 显示进度条
		var isValid = $("#fm").form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
		if(!isValid){
			$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
			alert( "填写数据不符合规范");
			return;
		}
		$.ajax({
		   type : "POST",
		   url : basePath + "exam/paper/autoMakePaper",
		   data : fromData,
		   traditional : true,
		   success : function(result){
		   		$.messager.progress('close');// 隐藏进度条  
		   		result = eval('(' + result + ')');
			 	if (result.code == '0'){
			 		if (confirm("组卷成功，是否预览？")) {
						showPaperInfo(result.paperId);
					}	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：' + result.msg, 'error');
                }
		   }
		}); 
	}
	// 获取表单信息
	function getFormData() {
		var paperInfoData = paperTypeGrid.datagrid("getRows");
		var formData = {
			"paperInfoId" : $("#paperInfoId").val(), // 试卷id
			"paperInfoName" : $("#paperInfoName").val(), // 试卷名称
			"paperInfoPass" : $("#paperInfoPass").val(), // 几个分数
			"paperInfoState" : $("#paperInfoState").combobox('getValue'), // 试卷状态
			"aae013" : $("#aae013").val(), // 备注
			"paperInfoData" :  $.toJSON(paperInfoData)// 试题数据
		};
		return formData;
	}
	// 查看试卷
	function showPaperInfo(infoId){
		var dialog = parent.sy.modalDialog({
			title : '试卷预览',
			width : 600,
			height : 550,
			url : basePath + 'exam/paper/showPaperInfo?paperInfoId=' + infoId,
			buttons : [ {
				text : '关闭',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
				}
			} ]
		});
	}
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">   
		<div data-options="region:'west',split:true" title="导航" style="width: 260px; ">	
			<div region="center" style="width:250px;overflow: auto;" border="false">  
				<div id="qsnTypeGrid" style="width: 250px;height: 500px"></div>
		    </div>
		</div>               
        <div region="center" style="overflow: auto;" border="false">
        	<form id="fm" method="post" >	
        		<sicp3:groupbox title="试卷数据">
	        		<table class="table" style="width:98%;height: 98%">
	        		   <tr>
	        		     <td width="15%"></td>
	        		     <td width="35%"></td>
	        		     <td width="15%"></td>
	        		     <td width="35%"></td>
	        		   </tr> 
	        		   <tr>
	                        <td style="text-align:right;"><nobr>试卷名称:</nobr></td>
							<td colspan="3"><input id="paperInfoName" name="paperInfoName" 
								style="width: 500px" class="easyui-validatebox" data-options="required:true" /></td>
						</tr>
						<tr>
	                        <td style="text-align:right;"><nobr>试题总分:</nobr></td>
							<td colspan="3"><input id="allPoints" name="allPoints" style="width: 500px" 
								readonly="readonly" disabled="disabled" placeholder="自动累加所有试题分数"/></td>
						</tr>
						<tr>
	                        <td style="text-align:right;"><nobr>及格分数:</nobr></td>
							<td colspan="3"><input id="paperInfoPass" name="paperInfoPass" style="width: 500px" 
								class="easyui-validatebox" data-options="required:true,validType:'intOrFloat'" /></td>
						</tr>       		
						<tr>
							<td style="text-align:right;"><nobr>试卷状态:</nobr></td>
							<td colspan="3"><input id="paperInfoState" name="paperInfoState" 
								style="width: 500px" class="easyui-combobox" data-options="required:true" /></td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>备注:</nobr></td>
							<td colspan="3"><input id="aae013" name="aae013" style="width: 500px"  /></td>
						</tr>
					</table>
				</sicp3:groupbox>
				<sicp3:groupbox title="试卷包含题型">
					<div id="paperQsnTypegrid" style="min-height: 200px;"></div>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="startMakePaper()" id="btnSave">开始组卷 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="parent.window.refresh();" id="btnUndo">取消</a>
	        </div>
		</div>
	</div>
</body>
</html>