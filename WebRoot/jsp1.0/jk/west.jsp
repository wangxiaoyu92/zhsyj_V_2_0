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
%>
<%	
	String comdalei = StringHelper.showNull2Empty(request.getParameter("comdalei"));
%>
<script type="text/javascript">
	var comdalei_v = '<%=comdalei%>';
	//下拉框列表
	var comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
	var cb_comdalei;
	var grid;
	var grid2;
	
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
		    
		grid = $('#grid').datagrid({
			title: '监控企业列表',
			iconCls: 'icon-tip',
			//toolbar: '#toolbar',
			url: basePath + '/jk/jkgl/queryJkqy',
			queryParams:{'comcameraflag':1},
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jkqybh', // 该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '100',
				title : '监控企业编号',
				field : 'jkqybh',
				hidden : true
			}]],				
			columns : [ [ {
				width : '250',
				title : '监控企业名称',
				field : 'jkqymc',
				hidden : false
			}] ],
			onClickRow : function(rowIndex, rowData){
				var jkqybh = rowData.jkqybh;				
				var jkqymc = rowData.jkqymc;
                var camorgid = rowData.camorgid;
                showSpjky(jkqybh,camorgid);
			} 
		});
		
		cb_comdalei.combobox('setValue',comdalei_v);
		query();
	});

	// 查询
	function query() {
		var aaa027 = $('#aaa027').val(); 
		var comdalei = $('#comdalei').combobox('getValue');
		var jkqybh = $('#jkqybh').val();
		var jkqymc = $('#jkqymc').val();
		var param = {
			'aaa027' : aaa027,
			'comdalei' : comdalei,
			'jkqybh': jkqybh,
			'jkqymc': jkqymc,
			'comcameraflag': 1
		};
		grid.datagrid({
			url : basePath + '/jk/jkgl/queryJkqy',			
			queryParams : param
		});
		grid.datagrid('clearSelections');
	}

    // 明厨亮灶视频监控
	var showSpjky = function(comid,camorgid) {
		var tabTitle = "视频监控";
        var url = '/jsp/jk/jkyAllList.jsp?comid=' + comid + '&jklx=1&camorgid=' + camorgid;
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
	<div region="center" style="width:250px;overflow: true;" border="false">     	
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
					<td style="text-align:right;"><nobr>企业编号：</nobr></td>												
					<td><input id="jkqybh" name="jkqybh" style="width: 150px"/></td>												
				</tr>				
				<tr>						
					<td style="text-align:right;"><nobr>企业名称：</nobr></td>
					<td><input id="jkqymc" name="jkqymc" style="width: 150px" /></td>								
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
			<div id="grid" style="width: 300px;height: 450px"></div>						
		</sicp3:groupbox>	                   
    </div> 
</div>  	
