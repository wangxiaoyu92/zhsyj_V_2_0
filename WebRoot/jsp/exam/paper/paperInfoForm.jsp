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
	// 试卷id
	String v_paperInfoId = StringHelper.showNull2Empty(request.getParameter("paperInfoId"));  
%>
<!DOCTYPE html>
<html>
<head>
<title>试卷信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var paperTypeGrid; // 试题表格
	var v_qsnInfoType = <%=SysmanageUtil.getAa10toJsonArrayXz("QSNLX")%>; // 试题类型
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
	    loadPaperTypeGird(); // 加载试卷试题类型表格 
	    // 如果试卷id不为空
	    if ($('#paperInfoId').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'exam/paper/queryPaperInfoObj', {
				paperInfoId : $('#paperInfoId').val()
			}, 
			function(result) {
				if (result.code == '0') {
					var mydata = result.paperInfo;					
					$('form').form('load', mydata);
					var v_paperInfoData = result.paperInfoData;
					paperTypeGrid.treegrid('loadData', $.parseJSON(v_paperInfoData));
					reloadPaperAllPoint();
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");     
	}
	// 加载试题类型表格
	function loadPaperTypeGird() {
		paperTypeGrid = $('#paperQsnTypegrid').treegrid({
			toolbar: '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度	
			idField : 'qsnTypePosition',    
    		treeField : 'qsnTypeTitle',		
			columns : [ [ {
				title: '试题类型',
				field: 'qsnType',
				width : '100',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_qsnInfoType, value);
			    }
			},{
				title: '试题名称',
				field: 'qsnTypeTitle',
				width: '200',
				hidden: false,
				formatter : function(value, row) {
					var qsnInfoDesc = "";
					var index = value.indexOf("<input");
					while (index >= 0) {
						qsnInfoDesc += value.substring(0, index) + "(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)";
						value = value.substring(index);
						index = value.indexOf("/>");
						value = value.substring(index + 2);
						index = value.indexOf("<input");
					}
					qsnInfoDesc += value;
				
					return qsnInfoDesc;
			    }
			},{
				title: '试题所处试卷位置',
				field: 'qsnTypePosition',
				width: '200',
				hidden: true
			},{
				title: '试题分值(每题)',
				field: 'qsnPoint',
				align:'center',
				width: '100',
				hidden : false
			}
			/* ,{
				title:'操作',
				field:'opt',
				align:'center',
				width:150,
	            formatter:function(value, row, index){
					var str = "";									
	                str += "<span style='color:blue'><a href='javascript:upSort(" + "\"" + row.qsnTypePosition;
	                str += "\"" + ")'>上移</a></span>&nbsp;&nbsp;";
	                str += "<span style='color:blue'><a href='javascript:downSort(" + "\"" + row.qsnTypePosition;
	                str += "\"" + ")'>下移</a></span>&nbsp;&nbsp;";
	                return str;  
	            }  
	      	} */] ]
		});
	}
	// 添加试题类型
	function addType() {
		var url=basePath + "jsp/exam/paper/paperTypeInfo.jsp";
		var dialog = parent.sy.modalDialog({
			title : '添加试题类型',
			width : 400,
			height : 200,
			url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
					if(obj != null){
					var gridRoots = paperTypeGrid.treegrid('getRoots'); // 获取所有跟节点
					var pos = 1;
					if (gridRoots.length >= 1) {
						pos = gridRoots[gridRoots.length - 1].qsnTypePosition + 1;
						}
					paperTypeGrid.treegrid('append',{
						data: [{
						qsnType : obj.type,
						qsnTypeTitle : obj.name,
						qsnPoint : obj.point,
						qsnTypePosition : pos
				}]
			});
		}
		sy.removeWinRet(dialogID);//不可缺少
			})
	}
	// 编辑试题类型
	function editType() {
		var row = paperTypeGrid.treegrid('getSelected');
		var url=basePath + "jsp/exam/paper/paperTypeInfo.jsp";
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑试题类型',
			param : {
			qsnType :row.qsnType,
			qsnTypeTitle:row.qsnTypeTitle,
			qsnPoint:row.qsnPoint
			},
			width : 400,
			height : 200,
			url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if(obj != null){
				paperTypeGrid.treegrid('update', {
					id : row.qsnTypePosition, 
					row : {
						qsnType : obj.type,
						qsnTypeTitle : obj.name,
						qsnPoint : obj.point
					}
				});
				// 修改当前结点子节点分数
				reloadChildrenPoint(row.qsnTypePosition, retVal.point);
				// 重新加载试卷总分数
				reloadPaperAllPoint();
			}
			sy.removeWinRet(dialogID);//不可缺少
			})
		} else {
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	}
	// 删除试题类型
	function delType() {
		var row = paperTypeGrid.treegrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除该试题吗?',function(r) {
				if (r) {
					paperTypeGrid.treegrid('remove', row.qsnTypePosition); // 移除数据
					reloadPaperAllPoint();
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的试题！', 'info');
		}
	}
	// 选择试题
	function selectQsn() {
		var currNode = paperTypeGrid.treegrid('getSelected');
		if (currNode) {
			// 判断当前结点是否为根节点
			var isParent = paperTypeGrid.treegrid('getParent', currNode.qsnTypePosition);
			var v_type; // 节点类型
			var v_point; // 分数
			var v_nodeId; // 节点id
			if (!isParent) { // 如果当前结点的父节点为空，则是根节点
				v_type = currNode.qsnType;
				v_point = currNode.qsnPoint;
				v_nodeId = currNode.qsnTypePosition;
			} else {
				v_type = isParent.qsnType;
				v_point = isParent.qsnPoint;
				v_nodeId = isParent.qsnTypePosition;
			}
			if (v_point == "" || v_point == null) {
				v_point = 1;
			}
			var url=basePath + "jsp/exam/paper/selectQuestion.jsp";
			var dialog = parent.sy.modalDialog({
				title : '选择试题',
				param : {
				qsnType : v_type,
				a:new Date().getMilliseconds()
			},
				width : 700,
				height : 400,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);//不可缺少
				if (obj != null && obj.length > 0){
			    for (var k = 0; k < obj.length; k++) {
			    	var myrow = obj[k];
			    	var flag = checkQsnIsExit(v_nodeId, myrow.qsnInfoId);
			    	if (!flag) {
			    		paperTypeGrid.treegrid('append',{
				    		parent : v_nodeId, 
							data: [{
								qsnType : myrow.qsnInfoType, // 试题类型
								qsnTypeTitle : myrow.qsnInfoDesc, // 试题内容
								qsnPoint : v_point,
								qsnTypePosition : myrow.qsnInfoId
							}]
						});
			    	}
			    }
			    reloadPaperAllPoint();
		    }
			})
		} else {
			$.messager.alert('提示', '请先添加对应的大题类型！', 'info');
		}
	}
	// 检验所选试题是否在该类大题中出现
	function checkQsnIsExit(parentId, qsnInfoId) {
		var flag = false; // 默认所选试题在该类大题中不存在
		var childrenNodes = paperTypeGrid.treegrid('getChildren', parentId); // 当前节点的所有子节点
		for (var i = 0; i < childrenNodes.length; i++) {
			if (childrenNodes[i].qsnTypePosition == qsnInfoId) {
				flag = true;
			}
		}
		return flag;
	}
	// 上移
	function upSort(v_id) {
		// 判断当前结点是否为根节点
		var isParent = paperTypeGrid.treegrid('getParent', v_id);
		var brotherNodes = []; // 兄弟节点
		if (!isParent) { // 如果当前结点的父节点为空，则是根节点
			brotherNodes = paperTypeGrid.treegrid('getRoots'); // 所有根节点
		} else {
			brotherNodes = paperTypeGrid.treegrid('getChildren', isParent.qsnTypePosition); // 当前节点父节点的所有子节点
		}
		for (var i = 0; i < brotherNodes.length; i++) {
			// 如果当前结点在第一个位置，不用移动
			if (brotherNodes[0].qsnTypePosition == v_id) {
				$.messager.alert('提示', '无法移动！', 'info');
				return;
			}
			if (brotherNodes[i].qsnTypePosition == v_id) {
				var preId = brotherNodes[i - 1].qsnTypePosition; // 当前结点的上个节点
				var currNode = paperTypeGrid.treegrid("pop", v_id);  // 当前结点及其子节点数据
	            paperTypeGrid.treegrid("insert", {before : preId, data : currNode});  // 当当前结点插入到上个节点前
	            paperTypeGrid.treegrid("refresh", currNode.qsnTypePosition); // 刷新该节点
	            paperTypeGrid.treegrid("select", v_id); // 选中当前结点 
			}
        }
	}
	
	// 下移
	function downSort(v_id) {
		// 判断当前结点是否为根节点
		var isParent = paperTypeGrid.treegrid('getParent', v_id);
		var brotherNodes = []; // 兄弟节点
		if (!isParent) { // 如果当前结点的父节点为空，则是根节点
			brotherNodes = paperTypeGrid.treegrid('getRoots'); // 所有根节点
		} else {
			brotherNodes = paperTypeGrid.treegrid('getChildren', isParent.qsnTypePosition); // 当前节点父节点的所有子节点
		}
		for (var i = 0; i < brotherNodes.length; i++) {
			// 如果当前结点在最后一个位置，不用移动
			if (brotherNodes[brotherNodes.length - 1].qsnTypePosition == v_id) {
				$.messager.alert('提示', '无法移动！', 'info');
				return;
			}
			if (brotherNodes[i].qsnTypePosition == v_id) {
				var nextId = brotherNodes[i + 1].qsnTypePosition; // 当前结点的下个节点
				var currNode = paperTypeGrid.treegrid("pop", v_id);  // 当前结点及其子节点数据
	            paperTypeGrid.treegrid("insert", {after : nextId, data : currNode});  // 当当前结点插入到上个节点前
	            paperTypeGrid.treegrid("refresh", currNode.qsnTypePosition); // 刷新该节点
	            paperTypeGrid.treegrid("select", v_id); // 选中当前结点 
			}
        }
	}
	// 重新加载子节点分数
	function reloadChildrenPoint(v_id, v_point) {
		// 获取当前结点子节点
		var children = paperTypeGrid.treegrid('getChildren', v_id);
		for (var j = 0; j < children.length; j++) {
			paperTypeGrid.treegrid('update', {
				id : children[j].qsnTypePosition, 
				row : {
					qsnPoint : v_point
				}
			});
		}
	}
	// 重新加载试卷总分
	function reloadPaperAllPoint() {
		var allPoint = 0; // 总分初始值设为0
		var roots = paperTypeGrid.treegrid('getRoots'); // 所有根节点
		for (var i = 0; i < roots.length; i++) {
			// 获取每个跟节点的子节点
			var children = paperTypeGrid.treegrid('getChildren', roots[i].qsnTypePosition);
			for (var j = 0; j < children.length; j++) {
				allPoint += parseInt(children[j].qsnPoint);
			}
		}
		$("#allPoints").val(allPoint);
	}
	// 保存试卷信息
	function savePaperInfo() {
		alert(222);
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
		   url : basePath + "exam/paper/savePaperInfo",
		   data : fromData,
		   traditional : true,
		   success : function(result){
		   		$.messager.progress('close');// 隐藏进度条  
		   		result = eval('(' + result + ')');
			 	if (result.code == '0'){
			 		$.messager.alert('提示', '保存成功！', 'info', function(){
						 closeAndRefreshWindow();
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：' + result.msg, 'error');
                }
		   }
		}); 
	}
	// 获取表单信息
	function getFormData() {
		var gridData = paperTypeGrid.treegrid("getData");
		var paperQsnData = [];
		// 表格数据
		for (var i = 0; i < gridData.length; i++) {
			var childrenData = [];
			for (var j = 0; j < gridData[i].children.length; j++) {
				var currParent = gridData[i].children[j];
				var childData = {
					qsnInfoType : currParent.qsnType, // 试题类型
					qsnInfoPoint : currParent.qsnPoint, // 试题分值
					qsnInfoId : currParent.qsnTypePosition // 试题id
				};
				childrenData.push(childData);
			}
			var parentData = {
				qsnType : gridData[i].qsnType, // 试题类型
				qsnTypeTitle  : gridData[i].qsnTypeTitle, // 试题名称
				qsnPoint : gridData[i].qsnPoint, // 试题分值
				children : childrenData// 子节点数据
			};
			paperQsnData.push(parentData);
		}
		var formData = {
			"paperInfoId" : $("#paperInfoId").val(), // 试卷id
			"paperInfoName" : $("#paperInfoName").val(), // 试卷名称
			"paperInfoPass" : $("#paperInfoPass").val(), // 几个分数
			"paperInfoState" : $("#paperInfoState").combobox('getValue'), // 试卷状态
			"aae013" : $("#aae013").val(), // 备注
			"paperInfoData" :  $.toJSON(paperQsnData)// 试题数据
		};
		return formData;
	}
</script>

</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: auto;" border="false">
        	<form id="fm" method="post" >	
        		<input id="paperInfoId" name="paperInfoId" type="hidden" value="<%=v_paperInfoId%>"/>
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
				<sicp3:groupbox title="试卷大题类型">
					<div id="toolbar">
		        		<table>
							<tr>	        		
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addType"
									iconCls="icon-add" plain="true" onclick="addType()">增加</a>
								</td>
								<td><div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_editType"
									iconCls="icon-edit" plain="true" onclick="editType()">编辑</a>
								</td>  
								<td><div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delType"
									iconCls="icon-remove" plain="true" onclick="delType()">删除</a>
								</td>  
								<td><div class="datagrid-btn-separator"></div></td>
								<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_selectQsn"
									iconCls="ext-icon-report_go" plain="true" onclick="selectQsn()">选择试题</a>
								</td>
							</tr>
						</table>
					</div>
					<div id="paperQsnTypegrid"></div>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="savePaperInfo()" id="btnSave">保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeAndRefreshWindow()" id="btnUndo">取消</a>
	        </div>
		</div>
	</div>
</body>
</html>