<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<script type="text/javascript">
	// 下拉列表
	var comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
	var comhhbbz = <%=SysmanageUtil.getAa10toJsonArray("COMHHBBZ")%>;
	var comspjkbz = <%=SysmanageUtil.getAa10toJsonArray("COMSPJKBZ")%>;
	var combxbz = <%=SysmanageUtil.getAa10toJsonArray("COMBXBZ")%>;
	var cb_comdalei;
	var cb_comhhbbz;
	var cb_comspjkbz;
	var cb_combxbz;
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
		cb_comhhbbz = $('#comhhbbz').combobox({
			data:comhhbbz,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});
		cb_comspjkbz = $('#comspjkbz').combobox({
			data:comspjkbz,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});
		cb_combxbz = $('#combxbz').combobox({
			data:combxbz,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});
			    
		grid = $('#grid').datagrid({
			title: '统计信息',
			iconCls: 'icon-tip',
			//toolbar: '#toolbar',
			url: basePath + '/jk/jkgl/queryQysl',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 20,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'comdalei', // 该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '150',
				title : '企业分类',
				field : 'comdalei',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(comdalei,value);
				}
			}]],				
			columns : [ [ {
				width : '200',
				title : '企业数量',
				field : 'comsl',
				hidden : false
			},{
				width : '100',
				title : '保险',
				field : 'combxsl',
				hidden : false
			},{
				width : '100',
				title : '红榜',
				field : 'comhongbsl',
				hidden : false
			},{
				width : '100',
				title : '黑榜',
				field : 'comheibsl',
				hidden : false
			},{
				width : '100',
				title : '视频监控',
				field : 'comspjksl',
				hidden : false
			}] ],
			onClickRow : function(rowIndex, rowData){

			} 
		});
		
	});
	
	// 查询
	function query() {
		//grid.datagrid('loadData',{"total":0,"rows":[]});
		var aaa027 = $('#aaa027').val();
		var comdalei = $('#comdalei').combobox('getValue');
		var comhhbbz = $('#comhhbbz').combobox('getValue');
		var comspjkbz = $('#comspjkbz').combobox('getValue');
		var combxbz = $('#combxbz').combobox('getValue');
		var commc = $('#commc').val();
		var param = {
			"aaa027" : aaa027,
			"comdalei" : comdalei,
			"comhhbbz" : comhhbbz,
			"comspjkbz" : comspjkbz,
			"combxbz" : combxbz,
			"commc" : commc
		};
		grid.datagrid({
			url : basePath + '/jk/jkgl/queryQysl',			
			queryParams : param
		});
		grid.datagrid('clearSelections');

		showJk(aaa027,comdalei,comhhbbz,comspjkbz,combxbz,commc);
	}
	
	
	// 监控
	var showJk = function(aaa027,comdalei_v,comhhbbz,comspjkbz,combxbz,commc) {
		var	comdalei_name = sy.formatGridCode(comdalei,comdalei_v);	
		var tabTitle = "【" + comdalei_name + "】地图监控";
		var url = encodeURI("/jk/jkgl/qydtjkmonitorIndexForGIS?aaa027="+aaa027+"&comdalei="+comdalei_v+"&comhhbbz="+comhhbbz+"&comspjkbz="+comspjkbz+"&combxbz="+combxbz+"&commc="+commc);
		addTab(tabTitle,url,'ext-icon-monitor');		
	};

	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 
		var dialog = parent.sy.modalDialog({
			title : '监控',
			width : 300,
			height : 400,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
				$('#aaa027').val(obj.aaa027);
				$('#aaa027name').val(obj.aaa027name);
			}
				sy.removeWinRet(dialogID);//不可缺少
		})
	}
</script>
<div class="easyui-layout" fit="true">       		        
	<div region="center" style="width:250px;overflow: auto;" border="false">     	
		<sicp3:groupbox title="查询条件">
			<table class="table" style="width: 99%;">
	     		<tr>
					<td style="text-align:right;"><nobr>所属地区：</nobr></td>
					<td>
						<input name="aaa027name" id="aaa027name"  style="width: 150px " onclick="showMenu_aaa027();" 
						   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
						<input name="aaa027" id="aaa027"  type="hidden"/>
						<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
							<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:150px;height:450px;"></ul>
						</div>							
					</td>
				</tr>				
				<tr>						
					<td style="text-align:right;"><nobr>企业分类：</nobr></td>
					<td><input id="comdalei" name="comdalei" style="width: 150px" /></td>								
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>红黑榜标志：</nobr></td>
					<td><input id="comhhbbz" name="comhhbbz" style="width: 150px" /></td>								
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>监控标志：</nobr></td>
					<td><input id="comspjkbz" name="comspjkbz" style="width: 150px" /></td>								
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>保险标志：</nobr></td>
					<td><input id="combxbz" name="combxbz" style="width: 150px" /></td>								
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>企业名称：</nobr></td>
					<td><input id="commc" name="commc" style="width: 150px" /></td>								
				</tr>							
				<tr>	
					<td colspan="2">
					   <div align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="query()"> 查 询 </a>
					    </div>		
					</td>
	 
				</tr>
			</table>			
			<div id="grid" style="width: 250px;height: 500px"></div>
		</sicp3:groupbox>					             
    </div>   
</div>  			
          