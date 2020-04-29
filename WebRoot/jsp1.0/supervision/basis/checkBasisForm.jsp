<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 检查内容id
	String contentid = StringHelper.showNull2Empty(request.getParameter("contentid"));
	// 
	String basisid = StringHelper.showNull2Empty(request.getParameter("basisid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>检查依据</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var contentid = '<%=contentid%>';
	// 下拉框列表
	var checkType = <%=SysmanageUtil.getAa10toJsonArray("CHECKTYPE")%>; // 检查方式
	var flfglx = <%=SysmanageUtil.getAa10toJsonArray("FLFGLX")%>; // 法律法规类型 
	var v_checkType;
	var basisLegalGrid; // 依据法律条款表
	var basisProblemGrid; // 依据问题表
	
	$(function() {
		v_checkType = $('#type').combobox({
	    	data : checkType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		loadBasisLegalGrid(); // 加载依据法律条款表
		loadBasisProblemGrid(); // 加载依据问题表
		loadCheckBasisInfo(); // 加载检查依据信息
	});
	
	// 加载检查依据信息
	function loadCheckBasisInfo(){
		if ($('#basisid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'supervision/checkbasis/queryCheckBasisObj', {
				basisid : $('#basisid').val()
			}, 
			function(result) {
				if (result.code == '0') {
					var mydata = result.basisInfo;					
					$('form').form('load', mydata); // 加载依据信息
					basisLegalGrid.datagrid('loadData', result.flfgInfo); // 加载法律法规信息
					basisProblemGrid.datagrid('loadData', result.problemInfo); // 加载问题信息
				} else {
					parent.$.messager.alert('提示', '查询失败：' + result.msg, 'error');
                }	
				parent.$.messager.progress('close');
			}, 'json');
		}
	}
	
	// 加载检查依据法律法规表格
	function loadBasisLegalGrid(){
		basisLegalGrid = $('#basisLegalGrid').datagrid({
			toolbar : '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField: 'contentid', //该列是一个唯一列
			sortOrder: 'asc',
			columns :[[
				{
					width : '150',
					title : '内容ID',
					field : 'contentid',
					hidden : true
				},
				{
					width : '100',
					title : '编号',
					field : 'contentcode',
					hidden : false
				},
				{
					width : '500',
					title : '内容',
					field : 'content',
					hidden : false
				},{
					width : '50',
					title : '排序号',
					field : 'contentsortid',
					hidden : false
				}] ]
		});
	}	
	// 加载依据问题表
	function loadBasisProblemGrid(){
		basisProblemGrid = $('#basisProblemGrid').datagrid({
			toolbar : '#toolbar2',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : false,// 底部显示分页栏
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'problemid', //该列是一个唯一列
		    sortOrder: 'desc',
			columns : [ [ {
				width : '200',
				title : 'id',
				field : 'problemid',
				hidden : true,
				editor : {
					type : 'text'
				}
			},{
				width : '650',
				title : '问题描述',
				field : 'problemdesc',
				hidden : false,
				editor : {
					type : 'text'
				}
			} ] ]
		});
	}
	
	// 选择法律法规
	function selectFlfg() {
		var url = basePath + "/jsp/pub/pub/selectLaw.jsp";
		var dialog = parent.sy.modalDialog({ 
				width : 800,
				height : 500,
				url : url
		},function(dialogID){ 
			var v_retObj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if (v_retObj != null && v_retObj.length > 0){
				for (var k = 0; k <= v_retObj.length - 1; k++){
					var myrow = {
						"contentid" : v_retObj[k].contentid, // 法律法规内容ID
						"contentcode" : v_retObj[k].contentcode, // 法律法规内容编号
						"content" : v_retObj[k].content, // 法律法规内容
						"contentsortid" : v_retObj[k].contentsortid // 法律法规排序号
					};
					basisLegalGrid.datagrid('insertRow', {row : myrow});
				}
			}
		});
	}
	
	// 删除法律法规
	function deleteFlfg() {
		mydatagrid_remove(basisLegalGrid);
	}
	
	// 添加
	function addBasisPro() {
		mydatagrid_append(basisProblemGrid);
	}
	
	// 删除
	function delBasisPro() {
		mydatagrid_remove(basisProblemGrid);
	}
	
	// 取消
	function cancelBasisPro() {
		mydatagrid_reject(basisProblemGrid);
	}
	
	// 保存
	function saveBasisPro() {
		mydatagrid_endEditing(basisProblemGrid);
	}
	
	
	// 保存 
	function saveCheckBasis($dialog, $grid, $pjq) {
		var url = basePath + 'supervision/checkbasis/saveCheckBasis';
		// 法律法规信息
		mydatagrid_endEditing($('#basisLegalGrid'));
        var v_flfgInfos = $('#basisLegalGrid').datagrid('getRows');
        $('#flfgInfo').val($.toJSON(v_flfgInfos));
        // 常见问题信息
		mydatagrid_endEditing($('#basisProblemGrid'));
        var v_problemInfos = $('#basisProblemGrid').datagrid('getRows');
        $('#problemInfo').val($.toJSON(v_problemInfos));
        
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url : url,
			onSubmit : function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$pjq.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$pjq.messager.alert('提示','保存成功！','info',function(){
	        			$grid.datagrid('load');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}
	
	// 关闭窗口
	function closeWindow($dialog, $pjq){
    	$dialog.dialog('destroy');
	}

</script>
</head>
<body>
	<div class="easyui-layout" fit="true"> 
		<div region="center" style="overflow: true;" border="false">		
			<sicp3:groupbox title="检查依据信息">		
				<form id="fm" method="post" >	
					<input id="contentid" name="contentid" type="hidden" value="<%=contentid%>">
					<input id="flfgInfo" name="flfgInfo" type="hidden">
					<input id="problemInfo" name="problemInfo" type="hidden">
		       		<table class="table" style="width: 99%;">
						<tr>
							<td style="text-align:right;"><nobr>检查依据ID:</nobr></td>
							<td><input name="basisid" id="basisid"  style="width: 175px; " 
								class="input_readonly" readonly="readonly" value="<%=basisid%>"/></td>
							<td style="text-align:right;"><nobr>检查方式:</nobr></td>
							<td><input name="type" id="type"  style="width: 175px; "/></td>																
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>检查方式描述:</nobr></td>
							<td colspan="3">
								<textarea class="easyui-validatebox" id="typedesc" name="typedesc" style="width: 700px;" 
							 	rows="6" data-options="required:false, validType:'length[0,500]'"></textarea>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>检查指南:</nobr></td>
							<td colspan="3"><input name="guide" id="guide"  style="width: 700px; "  
								class="easyui-validatebox" data-options="required:false, validType:'length[0,1000]'" /></td>
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>处罚措施:</nobr></td>
							<td colspan="3"><input name="punishmeasures" id="punishmeasures"  style="width: 700px; "  
								class="easyui-validatebox" data-options="required:false, validType:'length[0,1000]'" /></td>
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>检查依据描述:</nobr></td>
							<td colspan="3">
								<textarea class="easyui-validatebox" id="basisdesc" name="basisdesc" style="width: 700px;" 
							 	rows="6" data-options="required:false, validType:'length[0,4000]'"></textarea>
							</td>
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>法律依据:</nobr></td>
							<td colspan="3" style="height: 100px;">
								<div id="toolbar">
									<div style="float: left; margin-top: 0px;padding-top: 0px;">
										<a href="javascript:void(0)" class="easyui-linkbutton"
												iconCls="icon-add" plain="true" onclick="selectFlfg()">选择</a>
									</div>
									<div class="datagrid-btn-separator"></div>
									<div style="float: left;margin-top: 0px;padding-top: 0px;">
										<a href="javascript:void(0)" class="easyui-linkbutton"
												iconCls="icon-remove" plain="true" onclick="deleteFlfg()">删除</a>
									</div>
									<div class="datagrid-btn-separator"></div>
								</div>
								<div id="basisLegalGrid"></div>
							</td>
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>常见问题:</nobr></td>
							<td colspan="3" style="height: 100px;">
								<div id="toolbar2">
									<div style="float: left; margin-top: 0px;padding-top: 0px;">
										<a href="javascript:void(0)" class="easyui-linkbutton"
												iconCls="icon-add" plain="true" onclick="addBasisPro()">添加</a>
									</div>
									<div class="datagrid-btn-separator"></div>
									<div style="float: left;margin-top: 0px;padding-top: 0px;">
										<a href="javascript:void(0)" class="easyui-linkbutton"
												iconCls="icon-remove" plain="true" onclick="delBasisPro()">删除</a>
									</div>
									<div class="datagrid-btn-separator"></div>
									<div style="float: left;margin-top: 0px;padding-top: 0px;">
										<a href="javascript:void(0)" class="easyui-linkbutton"
												iconCls="icon-undo" plain="true" onclick="cancelBasisPro()">取消</a>
									</div>
									<div class="datagrid-btn-separator"></div>
									<div style="float: left;margin-top: 0px;padding-top: 0px;">
										<a href="javascript:void(0)" class="easyui-linkbutton"
												iconCls="icon-save" plain="true" onclick="saveBasisPro()">保存</a>
									</div>
									<div class="datagrid-btn-separator"></div>
								</div>
								<div id="basisProblemGrid"></div>
							</td>
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>经办人:</nobr></td>
							<td><input name="operatorname" id="operatorname" style="width: 175px; " 
								class="input_readonly" readonly="readonly"   /></td>					
							<td style="text-align:right;"><nobr>经办时间:</nobr></td>
							<td><input name="operatedate" id="operatedate" style="width: 175px; " 
								class="input_readonly" readonly="readonly"   /></td>
						</tr>							
					</table>
			        <br/>		
				</form>
		    </sicp3:groupbox> 
	    </div> 
    </div>   
</body>
</html>
