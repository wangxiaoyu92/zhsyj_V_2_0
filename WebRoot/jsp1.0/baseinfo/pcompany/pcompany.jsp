<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
	String v_userdalei=sysuser.getUserdalei();//1非企业用户2企业用户
		
%>
<!DOCTYPE html>
<html>
<head>
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">

	// 企业大类
	var comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
	var cb_comdalei;

	var grid;
	$(function() {
		//企业类别
		cb_comdalei = $('#comdalei').combobox({
			data:comdalei,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});
		var arr =[{mergeFiled:"comid",premiseFiled:"comid"},    //合并列的field数组及对应前提条件filed（为空则直接内容合并）
			{mergeFiled:"comdm",premiseFiled:"comid"},
			{mergeFiled:"commc",premiseFiled:"comid"},
			{mergeFiled:"comfrhyz",premiseFiled:"comid"},
			{mergeFiled:"comfrsfzh",premiseFiled:"comid"},
			{mergeFiled:"comdz",premiseFiled:"comid"},
			{mergeFiled:"comzzjgdm",premiseFiled:"comid"},
			{mergeFiled:"comclrq",premiseFiled:"comid"},
			{mergeFiled:"aaa027",premiseFiled:"comid"},
			{mergeFiled:"comyddh",premiseFiled:"comid"}
		];
		
		function onLoadSuccess (data) {
			var dg = $("#grid");   //要合并的datagrid中的表格id
			var rowCount = dg.datagrid("getRows").length;
			var cellName;
			var span;
			var perValue = "";
			var curValue = "";
			var perCondition = "";
			var curCondition = "";
			var flag = true;
			var condiName = "";
			var length = arr.length - 1;
			for (i = length; i >= 0; i--) {
				cellName = arr[i].mergeFiled;
				condiName = arr[i].premiseFiled;
				if(isNotNull(condiName)){
					flag = false;
				}
				perValue = "";
				perCondition = "";
				span = 1;
				for (row = 0; row <= rowCount; row++) {
					if (row == rowCount) {
						curValue = "";
						curCondition = "";
					} else {
						curValue = dg.datagrid("getRows")[row][cellName];
						/* if(cellName=="ORGSTARTTIME"){//特殊处理这个时间字段
						 curValue =formatDate(dg.datagrid("getRows")[row][cellName],"");
						 } */
						if(!flag){
							curCondition=dg.datagrid("getRows")[row][condiName];
						}
					}
					if (perValue == curValue&&(flag||perCondition==curCondition)) {
						span += 1;
					} else {
						var index = row - span;
						dg.datagrid('mergeCells', {
							index : index,
							field : cellName,
							rowspan : span,
							colspan : null
						});
						span = 1;
						perValue = curValue;
						if(!flag){
							perCondition=curCondition;
						}
					}
				}
			}
		}
		
		function isNotNull(_this){
			if(_this==""||_this==null||_this==''){
				return false;
			}
			return true;
		}

		grid = $('#grid').datagrid({
			//title: '企业信息列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + 'pcompany/queryCompany',
			queryParams : {'comfwnfww' : 0}, // 企业范围内
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'comid', //该列是一个唯一列
		    sortOrder: '',
			//onLoadSuccess: onLoadSuccess,
			columns : [ [ {
				width : '200',
				title : '企业ID',
				field : 'comid',
				hidden : false
			},{
				width : '70',
				title : '企业代码',
				field : 'comdm',
				hidden : false
			},{
				width : '200',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '100',
				title : '日常监督管理人员',
				field : 'comrcjdglry',
				hidden : false
			},{
				width : '100',
				title : '企业大类',
				field : 'comdalei',
				hidden : true
			},{
				width : '100',
				title : '企业大类',
				field : 'comdaleiname',
				hidden : false
			},{
				width : '100',
				title : '企业小类',
				field : 'comxiaolei',
				hidden : true
			},{
				width : '100',
				title : '企业小类',
				field : 'comxiaoleiname',
				hidden : false
			},{
				width : '120',
				title : '许可证编号',
				field : 'comxkzbh',
				hidden : true
			},{
				width : '80',
				title : '企业法人/业主',
				field : 'comfrhyz',
				hidden : false
			},{
				width : '120',
				title : '法人/业主身份证号',
				field : 'comfrsfzh',
				hidden : true
			},{
				width : '80',
				title : '企业负责人',
				field : 'comfzr',
				hidden : true
			},{
				width : '100',
				title : '固定电话',
				field : 'comgddh',
				hidden : true
			},{
				width : '100',
				title : '移动电话',
				field : 'comyddh',
				hidden : false
			},{
				width : '150',
				title : '企业地址',
				field : 'comdz',
				hidden : false
			},{
				width : '80',
				title : '经度坐标',
				field : 'comjdzb',
				hidden : false
			},{
				width : '80',
				title : '纬度坐标',
				field : 'comwdzb',
				hidden : false
			},{
				width : '150',
				title : '许可范围',
				field : 'comxkfw',
				hidden : true
			},{
				width : '100',
				title : '许可有效期始',
				field : 'comxkyxqq',
				hidden : true
			},{
				width : '100',
				title : '许可有效期止',
				field : 'comxkyxqz',
				hidden : true
			},{
				width : '200',
				title : '餐厅面积',
				field : 'comctmj',
				hidden : true
			},{
				width : '200',
				title : '厨房面积',
				field : 'comcfmj',
				hidden : true
			},{
				width : '200',
				title : '总面积',
				field : 'comzmj',
				hidden : true
			},{
				width : '200',
				title : '就餐人数',
				field : 'comjcrs',
				hidden : true
			},{
				width : '200',
				title : '从业人数',
				field : 'comcyrs',
				hidden : true
			},{
				width : '200',
				title : '持健康证人数',
				field : 'comcjkzrs',
				hidden : true
			},{
				width : '200',
				title : '专/兼职管理人数',
				field : 'comzjzglrs',
				hidden : true
			},{
				width : '200',
				title : '企业小类',
				field : 'comxiaolei',
				hidden : true
			},{
				width : '200',
				title : '店面类型',
				field : 'comdmlx',
				hidden : true
			},{
				width : '200',
				title : '特色菜系',
				field : 'comtscx',
				hidden : true
			},{
				width : '200',
				title : '特色菜',
				field : 'comtsc',
				hidden : true
			},{
				width : '200',
				title : '资质证明',
				field : 'comzzzm',
				hidden : true
			},{
				width : '200',
				title : '资质证明编号',
				field : 'comzzzmbh',
				hidden : true
			},{
				width : '200',
				title : '组织机构代码',
				field : 'comzzjgdm',
				hidden : false
			},{
				width : '200',
				title : '企业成立日期',
				field : 'comclrq',
				hidden : false
			},{
				width : '200',
				title : '注册资金',
				field : 'comzczj',
				hidden : true
			},{
				width : '100',
				title : '所在地区',
				field : 'aaa027name',
				hidden : false
			} ] ]
		});
	});
	// 查询企业信息
	function query() {
		var param = {
			'comdalei': $('#comdalei').combobox('getValue'),
			'commc': $('#commc').val(),
			'comfwnfww' : '0',
			'aaa027':$('#aaa027').val()
		};
		grid.datagrid({
			url : basePath + '/pcompany/queryCompany',			
			queryParams : param
		});
		grid.datagrid('clearSelections');
	}

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 
	
	// 新增企业
	function addPcom () {
		var obj = new Object();
		var url = '<%=basePath%>/pcompany/pcompanyFormIndex';
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : '企业信息',
			width : 950,
			height : 600,
			url : url
		}, function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if (obj != null && "ok"==obj){
				$("#grid").datagrid("reload");
			}
		});
	}
	
	//资质证明管理
	function Zzzmgl() {
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var v_comid=row.comid;
			var dialog = parent.sy.modalDialog({
				title : '资质证明管理',
				width : 800,
				height : 440,
				url : basePath + '/jsp/baseinfo/pcompany/pcomZzzm.jsp?op=zzzmgl&comid='+v_comid,
				buttons : [{
					text : '关闭',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				}]
			});			
		}else{
			$.messager.alert('提示','请先选择要修改的企业！','info');
		}
	}
	//编辑企业信息
	function updatePcom(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var url='<%=basePath%>/pcompany/pcompanyFormIndex?comid='+row.comid;
			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '企业信息',
				width : 950,
				height : 600,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if (obj!=null && "ok"==obj){
					$("#grid").datagrid("reload");
				}
			});
		}else{
			$.messager.alert('提示','请先选择要修改的企业！','info');
		}
	}
	
	// 删除
	function delPcom() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var comid = row.comid;
			$.messager.confirm('警告', '您确定要删除该企业信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'pcompany/delPcompany', {
						comid: row.comid,comdalei:row.comdalei
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的企业信息！', 'info');
		}
	}  	
	
	//审核企业信息
	function examPcom(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '审核企业信息',
				width : 950,
				height : 600,
				url : basePath +'/pcompany/pcompanyFormIndex?sh=exam&comid='+row.comid,
				buttons : [{
					text : '审核通过',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.examPass(dialog,grid,parent.$);
					}
				},{
					text:'审核未通过',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.examFailed(dialog,grid,parent.$);
					}
				},{
					text : '取消',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要审核的企业！','info');
		}
	}
	
	//查看企业信息
	function showPcom(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var obj=new Object();
			var url='<%=basePath%>/pcompany/pcompanyFormIndex?op=view&comid='+row.comid;
			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '企业信息',
				width : 950,
				height : 600,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少

				if (obj!=null && "ok"==obj){
//					$("#grid").datagrid("reload");
				}
			});
		}else{
			$.messager.alert('提示','请先选择要查看的企业！','info');
		}
	}
	
	//批量初始化企业地图坐标
	function MakeCompanyLngLat(){
		var row = $('#grid').datagrid('getSelected');
		$.messager.confirm('警告', '您确定要批量初始化企业地图坐标吗?',function(r) {
			if (r) {
				$.post(basePath + '/pcompany/MakeCompanyLngLatBatch', {
					"comid" : ""
				},
				function(result) {
					if (result.code == '0') {
						$.messager.alert('提示','批量初始化企业地图坐标成功！','info');															
					}
				},'json');
			}
		});
	}

	// 导入
	function qydrIndex(){
		var dialog = parent.sy.modalDialog({
			title : '导入企业',
			iconCcs : 'ext-icon-monitor',
			width : 970,
			height : 562,
			url : basePath + '/pcompany/qydrIndex',
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, grid, parent.$);
				}
			} ]
		});
	}
	
	// 导入审批企业
	function importApproveCom(){
		var dialog = parent.sy.modalDialog({
			title : '导入审批企业',
			iconCcs : 'ext-icon-monitor',
			width : 970,
			height : 562,
			url : basePath + '/pcompany/importApproveComIndex',
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, grid, parent.$);
				}
			} ]
		});
	}
	
	// 上传图片附件
	function uploadFjView(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=company&fjwid="+row.comid; 
			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '上传附件',
				width : 900,
				height : 600,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少

				if(obj != null){
					if(obj.type == 'ok'){
						//
					}
				}
			});

		}else{
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	}
	
	// 删除图片附件
	function delFjView(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "/pub/pub/delFjViewIndex?fjwid="+row.comid;
			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '附件信息',
				width : 900,
				height : 600,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少

				if(obj != null){
					if(obj.type == 'ok'){
						//
					}
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除附件的记录！', 'info');
		}
	}
	
	// 二维码管理
	function qrcodeManager(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "jsp/baseinfo/pcompany/comQRcode.jsp?comid="+row.comid;
			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '二维码信息',
				width : 900,
				height : 600,
				url : url
			});
		}else{
			$.messager.alert('提示', '请先选择相应的公司！', 'info');
		}
	}
	// 批量生成二维码
	function createQRcodes() {
		var param = {
			'comdalei': $('#comdalei').combobox('getValue'),
			'commc': $('#commc').val(),
			'comfwnfww' : '0'
		};
		$.messager.confirm('警告', '您确定要批量生成企业二维码吗?',function(r) {
			if (r) {
				$.post(basePath + 'pcompany/createCompanyQRcodes', param,
				function(result) {
					if (result.code == '0') {
						$.messager.alert('提示','批量生成企业二维码成功！','info');															
					}
				},'json');
			}
		});
	}
	
	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 

		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 300,
			height : 400,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
				$('#aaa027').val(obj.aaa027);
				$('#aaa027name').val(obj.aaa027name);
			}
		});
	}
</script>
</head>
<body >
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px" /></td>						
						<td style="text-align:right;"><nobr>企业分类</nobr></td>
						<td><input id="comdalei" name="comdalei" style="width: 200px" /></td>								
						<td style="text-align:right;"><nobr>所在区域:</nobr></td>
						<td>
							<input name="aaa027name" id="aaa027name"  style="width: 200px " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:false" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:150px;height:450px;"></ul>
							</div>							
						</td>
						
						<td colspan="2" style="text-align: right">						  
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>						   	
						</td>						
					</tr>

				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="企业列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
						    <% if ("1".equals(v_userdalei)){  %>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_savePcompany"
								iconCls="icon-add" plain="true" onclick="addPcom()">增加</a> 
							</td>
							<%} %>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_savePcompany"
								iconCls="icon-edit" plain="true" onclick="updatePcom()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<% if ("1".equals(v_userdalei)){  %>
							<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delPcompany"
								iconCls="icon-remove" plain="true" onclick="delPcom()">删除</a>
							</td>
							<%} %>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
<!-- 							<td> -->
<!-- 								<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_qyfjsc" -->
<!-- 								iconCls="icon-upload" plain="true" onclick="uploadFuJian()">附件</a> -->
<!-- 							</td> -->
<!-- 							<td>   -->
<!-- 								<div class="datagrid-btn-separator"></div> -->
<!-- 							</td>  -->
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_pcompanyFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showPcom()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_qydrIndex"
								   iconCls="ext-icon-bricks" plain="true" onclick="Zzzmgl()">企业资质证明管理</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>	
							<% if ("1".equals(v_userdalei)){  %>						
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_qydrIndex"
								   iconCls="ext-icon-report_go" plain="true" onclick="qydrIndex()">导入企业</a>
							</td>
							<%} %>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
<!-- 							<td><a href="javascript:void(0)" class="easyui-linkbutton"  
 								iconCls="icon-save" plain="true" onclick="MakeCompanyLngLat()">初始化企业坐标</a> 
							</td> 
 							<td>   
 								<div class="datagrid-btn-separator"></div> 
 							</td>  -->
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
							iconCls="icon-upload" plain="true" onclick="uploadFjView()">上传企业图片</a>
						</td>
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
							iconCls="icon-no" plain="true" onclick="delFjView()">管理企业图片</a>
						</td>   
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>   
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_qrcodeManager"
							iconCls="ext-icon-connect" plain="true" onclick="qrcodeManager()">二维码管理</a>
						</td>   
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>  
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_createQRcodes"
							iconCls="ext-icon-connect" plain="true" onclick="createQRcodes()">批量生成二维码</a>
						</td>   
						<td>
							<div class="datagrid-btn-separator"></div>
						</td> 
						<% if ("1".equals(v_userdalei)){  %>
						<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_importApproveCom"
							iconCls="ext-icon-connect" plain="true" onclick="importApproveCom()">导入审批企业</a>
						</td>  
						<%} %> 
						<td>
							<div class="datagrid-btn-separator"></div>
						</td>
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>