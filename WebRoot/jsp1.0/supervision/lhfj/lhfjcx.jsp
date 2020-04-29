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
	
	String v_dokind = StringHelper.showNull2Empty(request.getParameter("dokind"));
	String v_checkyear = StringHelper.showNull2Empty(request.getParameter("checkyear"));
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>

<title>量化分级查询</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
// 年度
var v_niandulist = <%=SysmanageUtil.getcheckyearlist()%>;
//日常检查结果判定
var v_RESULTDECISION = <%=SysmanageUtil.getAa10toJsonArray("RESULTDECISION")%>;
//日常检查结果判定
var v_RESULTSTATE = <%=SysmanageUtil.getAa10toJsonArray("RESULTSTATE")%>;
//量化分级动态评定等级
var v_LHFJDTPDDJ = <%=SysmanageUtil.getAa10toJsonArray("LHFJDTPDDJ")%>;



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
			toolbar: '#toolbar',
			//url: basePath + '/lhfj/queryLhfjcx',
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
		    nowrap:false,	
		    onClickRow:function(rowIndex, rowData){
		    },
			columns : [ [
	        {
				width : '100',
				title : '检查结果主表ID',
				field : 'resultid',
				hidden : true
			},{
				width : '100',
				title : '计划ID',
				field : 'planid',
				hidden : true
			},{
				width : '150',
				title : '企业id',
				field : 'comid',
				hidden : false
			},{
				width : '150',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '150',
				title : '企业地址',
				field : 'comdz',
				hidden : false
			},{
				width : '150',
				title : '计划名称',
				field : 'plantitle',
				hidden : false
			},{
				width : '150',
				title : '计划检查类别',
				field : 'planchecktype',
				hidden : true
			},{
				width : '80',
				title : '结果判定',
				field : 'resultdecision',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_RESULTDECISION,value);
				}				
			},{
				width : '100',
				title : '结果不符合项说明',
				field : 'resulttng',
				hidden : false
			},{
				width : '80',
				title : '结果备注',
				field : 'resultremark',
				hidden : false
			},{
				width : '80',
				title : '结果得分',
				field : 'resultscore',
				hidden : false
			} ,{
				width : '80',
				title : '结果完成状态',
				field : 'resultstate',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_RESULTSTATE,value);
				}				
			} ,{
				width : '80',
				title : '项目经办人',
				field : 'operateperson',
				hidden : true
			},{
				width : '80',
				title : '项目经办人',
				field : 'operatepersonstr',
				hidden : false
			},{
				width : '80',
				title : '项目经办日期',
				field : 'operatedate',
				hidden : false
			},{
				width : '80',
				title : '结果检查人',
				field : 'resultperson',
				hidden : false
			},{
				width : '120',
				title : '结果检查日期',
				field : 'resultdate',
				hidden : false
			},{
				width : '100',
				title : '地理位置',
				field : 'location',
				hidden : false
			},{
				width : '70',
				title : '联系人',
				field : 'lxr',
				hidden : false
			},{
				width : '80',
				title : '联系电话',
				field : 'lxdh',
				hidden : false
			},{
				width : '80',
				title : '检查平均分',
				field : 'checkavgscore',
				hidden : false
			},{
				width : '150',
				title : '量化分级动态评定等级',
				field : 'lhfjdtpddj',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_LHFJDTPDDJ,value);
				}				
			},{
				width : '70',
				title : '检查内容数',
				field : 'jcnrcount',
				hidden : false
			},{
				width : '100',
				title : '已完成检查内容数',
				field : 'ywcjcnrcount',
				hidden : false
			},{
				width : '100',
				title : '关键检查内容数',
				field : 'impjcnrcount',
				hidden : false
			},{
				width : '100',
				title : '符合检查内容数',
				field : 'fhjcnrcount',
				hidden : false
			},{
				width : '120',
				title : '不符合检查内容数',
				field : 'bfhjcnrcount',
				hidden : false
			},{
				width : '120',
				title : '合理缺项检查内容数',
				field : 'hlqxjcnrcount',
				hidden : false
			},{
				width : '150',
				title : '关键不符合检查内容数',
				field : 'impbfhjcnrcount',
				hidden : false
			}
			] ],
			toolbar: '#toolbar'
		});
		
		var v_local_dokind="<%=v_dokind%>";
		if (v_local_dokind!=null && v_local_dokind=="lhfjtj"){
			myShowTjQuery();
		}		
});////////////////////////////
	
function myShowTjQuery() {
	    var v_comid="<%=v_comid%>";
	    var v_checkyear="<%=v_checkyear%>";
		mygrid.datagrid({
			url : basePath + '/lhfj/queryLhfjcx?comid='+v_comid+'&checkyear='+v_checkyear			
		});
		mygrid.datagrid('clearSelections'); 
	}

	function query() {
		var param = {
			'comid': $('#comid').val(),
			'planid': $('#planid').val(),
			'checkyear':$('#checkyear').combobox('getValue'),
			'operatedatestart':$('#operatedatestart').datebox('getValue'),
			'operatedateend':$('#operatedateend').datebox('getValue')
		};
		mygrid.datagrid({
			url : basePath + '/lhfj/queryLhfjcx',			
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
	
	//选择重大活动检查计划
	function myselectCheckplan(){
	    var url = basePath + 'jsp/pub/pub/selectCheckPlan.jsp';
		var dialog = parent.sy.modalDialog({
				title : '选择计划',
				param : {
					singleSelect : "true"
				},
				width : 900,
				height : 460,
				url : url
		},function(dialogID) {
			v_retStr = sy.getWinRet(dialogID);
			if (v_retStr!=null && v_retStr.length>0){
			    for (var k=0;k<=v_retStr.length-1;k++){
			    	var myrow = v_retStr[k];  
				    $("#planid").val(myrow.planid);
				    $("#plantitle").val(myrow.plantitle);	    	
			    }
		    }
		    sy.removeWinRet(dialogID);//不可缺少
		});    
	}
	
	function refresh(){
		parent.window.refresh();	
	} 	
	
	//查看结果明细
	var viewResult = function() {
	var row = $("#mygrid").datagrid('getSelected');
	if(row){
	 if(row.resultstate=="1"){//未检查完毕
		var dialog = parent.sy.modalDialog({
			title : '查看检查结果',
			param : {
				resultid : row.resultid,
				resultstate : row.resultstate,
				planchecktype : row.planchecktype
			},
			width :1040,
		    height :560,
			url : basePath + '/supervision/checkresult/resultdetail',
			buttons : [ 
			{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	}//固化
	else{
		var dialog = parent.sy.modalDialog({
				title : '查看检查结果',
				param : {
					resultid : row.resultid,
					resultstate : row.resultstate,
					planchecktype : row.planchecktype
				},
				width :1040,
				height :560,
				url : basePath +'/supervision/checkresult/viewResult',
				buttons : [{
					text : '取消',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
	}
		}else{
			$.messager.alert('提示','请先选择要查看的结果信息！','info');
		}
	};
	
	//附件管理
	function uploadFuJian(){
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'pub/pub/pubUploadFjListIndex';
			var dialog = parent.sy.modalDialog({
				title : '选择企业',
				param : {
					ajdjid : row.resultid,
					dmlb : "SPJGFJ",//附件参数小类编号
					fjcsdlbh : "SYJGFJ",
					time : new Date().getMilliseconds()
				},
				width : 900,
				height : 500,
				url : url
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}	 	
	}	
	
	//查看结果信息
	var viewResultinfo = function() {
	var row = $("#mygrid").datagrid('getSelected');
	if(row){
	//除未完成
	if(row.resultstate="4"){//结果固化
		var dialog = parent.sy.modalDialog({
				title : '查看检查结果',
				width :1040,
				height :560,
				url : basePath +'supervision/checkresult/viewResultinfo?resultid='+row.resultid+'&resultstate='+row.resultstate+'&planchecktype='+row.planchecktype,
				buttons : [{
					text : '取消',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
	}else if(row.resultstate="5"){//完毕
		var dialog = parent.sy.modalDialog({
				title : '查看检查结果',
				width :1040,
				height :560,
				url : basePath +'supervision/checkresult/viewResultinfo?resultid='+row.resultid+'&resultstate='+row.resultstate+'&planchecktype='+row.planchecktype,
				buttons : [{
					text : '取消',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
	}else{
	$.messager.alert('提示','还没有核查完毕无法查看核查结果信息！','info');
	}
		}else{
		$.messager.alert('提示','请先选择要查看的结果信息！','info');
		}
	};	
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
	   	$dialog.dialog('destroy');
	};	
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
          <% if (!"lhfjtj".equalsIgnoreCase(v_dokind)){ %>
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
        		    <tr>
						<td style="text-align:right;"><nobr>年度</nobr></td>
						<td><input id="checkyear" name="checkyear" style="width: 100px" /></td>        		    
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td colspan="5">
						    <input type="hidden" id="comid" name="comid"/>
						    <input id="commc" name="commc" style="width:300px" readonly="readonly" class="zfwstextReadonly"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>						
						</td>	
					</tr>
        		    <tr>
						<td style="text-align:right;"><nobr>操作时间</nobr></td>
						<td colspan="2">
						<input id="operatedatestart" name="operatedatestart" style="width: 100px" class="easyui-datebox"/>
						~<input id="operatedateend" name="operatedateend" style="width: 100px" class="easyui-datebox"/>
						</td>        		    
						<td style="text-align:right;"><nobr>检查计划</nobr></td>
						<td colspan="4">
						    <input type="hidden" id="planid" name="planid"/>
						    <input id="plantitle" name="plantitle" style="width:300px" readonly="readonly" class="zfwstextReadonly"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectCheckplan()">选择检查计划 </a>						
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
	        </sicp3:groupbox>
	        <%} %>
        	<sicp3:groupbox title="量化分级统计列表">
	        <div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_viewResult"
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewResult()">查看结果明细</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_uploadFj"
								iconCls="icon-upload" plain="true" onclick="uploadFuJian()">附件管理</a>
							</td>
							<td>   
								<div class="datagrid-btn-separator"></div>
 							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_savePcompany"
								iconCls="ext-icon-report_magnify" plain="true" onclick="viewResultinfo()">查看检查结果信息</a> 
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