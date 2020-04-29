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
<title>红黑榜管理</title>
 <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
 <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
  <script type="text/javascript">
  var comqyxz = <%=SysmanageUtil.getAa10toJsonArray("aab020")%>;
  var comqygm= <%=SysmanageUtil.getAa10toJsonArray("COMQYGM")%>;
  var bangdan= <%=SysmanageUtil.getAa10toJsonArray("ZXSYSJBMC")%>;
  var aaa;
  $(function(){
	  $('#comqyxz').combobox({
	    	data : comqyxz,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : '200' 
	    }); 
	  $('#comqygm').combobox({
	    	data : comqygm,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    }); 
		$('#bangdan').combobox({
		    	data : bangdan,      
		        valueField : 'id',   
		        textField : 'text',
		        required : false,
		        editable : false,
		        panelHeight : 'auto' 
		    });
   		loading();
   });
   
   function loading(){
     $("#aaa").datagrid({
	    title:'企业红黑榜公示管理',
	    url:  basePath + 'zx/integritypub/findAllgs', 
    	iconCls:'icon-ok',
    	height:450,
    	pageSize:10,
    	pageList:[10,20,30],
    	nowrap:true,//True 就会把数据显示在一行里
    	striped:true,//奇偶行使用不同背景色
    	collapsible:true,
    	singleSelect:true,//True 就会只允许选中一行
    	fit:false,//让DATAGRID自适应其父容器
    	fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
    	pagination:true,//底部显示分页栏
    	rownumbers:true,//是否显示行号
    	loadMsg:'数据加载中,请稍后...',
        
			columns : [ [ {
						title : '年度',
						field : 'spyear',
						align : 'left',
						width : 100
					}, {
						title : 'ipid',
						field : 'ipid',
						align : 'left',
						width : 100,
						hidden : true
					}, {
						title : 'iaid',
						field : 'iaid',
						align : 'left',
						width : 100,
						hidden : true
					}, {
						title : '企业id',
						field : 'comid',
						align : 'left',
						width : 100,
						hidden : true
					}, {
						title : '企业名称',
						field : 'commc',
						align : 'left',
						width : 100
					}, {
						title : '企业性质',
						field : 'comqyxz',
						align : 'left',
						width : 100
					}, {
						title : '企业规模',
						field : 'comxiaolei',
						align : 'left',
						width : 100
					}, {
						title : '是否上榜',
						field : 'ipnote',
						align : 'left',
						width : 100,
						formatter : function(value, row, index) {
							if (value == "1") {
								return "是";
								//return value;
							} else {
								return "否";
							}
						}
					}, {
						title : '对应榜单',
						field : 'spzxgrade',
						align : 'left',
						width : 100,
						formatter : function(value, row, index) {
							if (value == "A") {
								return "红榜";
							} else if (value == "D") {
								return "黑榜";
							} else {
								return "";
							}
						}
					},

					{
						title : '评估得分',
						field : 'iascore',
						align : 'left',
						width : 100
					}, {
						title : '上榜时间',
						field : 'iaaccessdate',
						align : 'left',
						width : 100
					} ] ]
				});
			}
			//查询
			function query() {
				var comqyxz = $('#comqyxz').combobox('getValue');
				var comxiaolei = $('#comqygm').combobox('getValue');
				var spzxgrade = $('#bangdan').combobox('getValue');
				alert(comqyxz);
				var param = {
					'comqyxz' : comqyxz,
					'comxiaolei' : comxiaolei,
					'spzxgrade' : spzxgrade
				};
				$('#aaa').datagrid('reload', param);
				$('#aaa').datagrid('clearSelections');
			}
			
			function del() {
				parent.window.refresh();
			}
			
			//企业评估明细
			function zxintegrityassessdetail() {
				var row = $('#aaa').datagrid('getSelected');
				if (row) {
					var comid = row.comid;
					var dialog = parent.sy
							.modalDialog({
								title : '评估明细',
								width : 800,
								height : 450,
								url : basePath
										+ 'zx/integritypub/queryzxbusinesscodeIndex?comid='
										+ row.comid,
								buttons : [
										{
											text : '确定',
											handler : function() {
												dialog.find('iframe').get(0).contentWindow
														.submitForm(dialog,
																aaa, parent.$);
											}
										},
										{
											text : '取消',
											handler : function() {
												dialog.find('iframe').get(0).contentWindow
														.closeWindow(dialog,
																parent.$);
											}
										} ]
							});
				} else {
					$.messager.alert('提示', '请先选择要查看的企业！', 'info');
				}
			};

			/*
			function zxintegrityassessdetail () {
				var row = $('#aaa').datagrid('getSelected'); 
				if (row) {
					var dialog = parent.sy.modalDialog({
						title : '企业评估明细',
						width : 870,
						height : 500,
						url : basePath + '/zx/integritypub/queryzxbusinesscodeIndex?comid='+row.comid ,
						buttons : [ {
							text : '确定',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
							}
						},{
							text : '取消',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
							}
						} ]
					});
				}else{
					$.messager.alert('提示', '请先选择要查看的企业！', 'info');
				}
			}*/
			
////////////////////////////////////////////////////////////////////////			
			function byla() {   
					var dialog = parent.sy.modalDialog({
						title : '不予立案案件明细',
						width : 870,
						height : 500,
						url : basePath + '/pub/zfbalc/bylaIndex?ajdjid=2',
						buttons : [  {
							text : '取消',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
							}
						} ]
					}); 
				}
			function hy() {   
					var dialog = parent.sy.modalDialog({
						title : '合议结论案件明细',
						width : 870,
						height : 500,
						url : basePath + '/pub/zfbalc/hyIndex?ajdjid=2',
						buttons : [  {
							text : '取消',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
							}
						} ]
					}); 
				}
		 
			//强制下榜
			function constraintup() {
				var row = $('#aaa').datagrid('getSelected');
				var spzxgrade;
				var ipid;
				var iaid;
				var ok = false;
				if (row) {
					var spzxgrade = row.spzxgrade;
					if ("B" == spzxgrade || "C" == spzxgrade) {
						return $.messager.alert('提示', '这个企业没有上榜，不用强制操作！',
								'info');
					} else if ("A" == spzxgrade) {
						ok = true;
						var ipid = row.ipid;
						var iaid = row.iaid;
						var spzxgrade = "ZXSYSJBMC2";
						var iascore = "75";
					} else if ("D" == spzxgrade) {
						ok = true;
						var ipid = row.ipid;
						var iaid = row.iaid;
						var spzxgrade = "ZXSYSJBMC3";
						var iascore = "60";
						var ipnote = "2";
					}

					if (ok) {
						shangxiabangdan(ipid, iaid, spzxgrade, iascore, ipnote);
					}
				} else {
					$.messager.alert('提示', '请先选择要修改的企业！', 'info');
				}
			}
			//强制上榜
			function constrainton() {
				var row = $('#aaa').datagrid('getSelected');
				var spzxgrade;
				var ipid;
				var iaid;
				var ok = false;
				if (row) {
					var spzxgrade = row.spzxgrade;
					if ("A" == spzxgrade || "D" == spzxgrade) {
						return $.messager.alert('提示', '这个企业已经上榜，不用强制操作！',
								'info');
					} else if ("B" == spzxgrade) {
						ok = true;
						var ipid = row.ipid;
						var iaid = row.iaid;
						var spzxgrade = "ZXSYSJBMC1";
						var iascore = "80";
					} else if ("C" == spzxgrade) {
						ok = true;
						var ipid = row.ipid;
						var iaid = row.iaid;
						var spzxgrade = "ZXSYSJBMC4";
						var iascore = "55";
						var ipnote = "1";
					}
					if (ok) {
						shangxiabangdan(ipid, iaid, spzxgrade, iascore, ipnote);
					}
				} else {
					$.messager.alert('提示', '请先选择要修改的企业！', 'info');
				}
			}
			//公用的ajax
			function shangxiabangdan(ipid, iaid, spzxgrade, iascore, ipnote) {
				$.ajax({
					url : basePath + '/zx/integritypub/updateIntegrityPubDTO ',
					type : "post",
					data : {
						"ipid" : ipid,
						"ipnote" : ipnote,
						"iaid" : iaid,
						"spzxgrade" : spzxgrade,
						"iascore" : iascore
					},
					dataType : "json",
					success : function(result) {
						if (result.code == '0') {
							$.messager.alert('提示', '修改成功！', 'info', function() {
								$('#aaa').datagrid('reload');
							});
						} else {
							$.messager.alert('提示', "修改失败：" + result.msg,
									'error');
						}
					},
					error : function() {
						alert("有错误")
					}
				})
			}
		</script>
  
  </head>
  

   <body> 
		
    	<div class="easyui-layout" fit="true">
		                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:center;"><nobr>企业性质</nobr></td>
					    <td><input id="comqyxz" name="comqyxz" style="width: 200px"/></td>
						<td style="text-align:center;"><nobr>企业规模</nobr></td>
					    <td><input id="comqygm" name="comqygm" style="width: 200px" /></td>								
					</tr>
					<tr>
						<td style="text-align:center;"><nobr>榜单</nobr></td>
					<td><input id="bangdan" name="bangdan" style="width: 200px" /></td>					
						<td colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="del()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>	   
      	<sicp3:groupbox title="榜单列表">
	        	<div id="toolbar">
	        	<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateIntegrityPubDTO"
								iconCls="icon-ok" plain="true" onclick="constrainton() ">强制上榜</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateIntegrityPubDTO"
								iconCls="icon-cancel" plain="true" onclick="constraintup()">强制下榜</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateIntegrityPubDTO"
								iconCls="icon-remove" plain="true" onclick="zxintegrityassessdetail()">详细明细</a>
							</td>
							<td>   
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateIntegrityPubDTO"
								iconCls="icon-remove" plain="true" onclick="byla()">不予立案</a>
							</td>
							<td>   
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateIntegrityPubDTO"
								iconCls="icon-remove" plain="true" onclick="hy()">合议</a>
							</td>
							<td>   
								<div class="datagrid-btn-separator"></div>
							</td> 
						</tr>
					</table>
				</div>
				<div id="aaa" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>  
</body>
</html>