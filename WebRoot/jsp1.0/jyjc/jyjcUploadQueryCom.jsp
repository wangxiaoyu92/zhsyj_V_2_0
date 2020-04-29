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
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
//显示当前日期
formatterDate = function (date,kind) {
var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
+ (date.getMonth() + 1);
var hor = date.getHours();
var min = date.getMinutes();
var sec = date.getSeconds();
if (kind==1) {
	hor="00";
	min="00";
	sec="00";
	}
return date.getFullYear() + '-' + month + '-' + day+" "+hor+":"+min+":"+sec;
};

	var v_gridmain;
	$(function() {
		$('#startimpczsj').datetimebox('setValue', formatterDate(new Date(),1));
		$('#endimpczsj').datetimebox('setValue', formatterDate(new Date()),2);
		
		v_gridmain = $('#gridmain').datagrid({
			toolbar : '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			nowrap : true,// True数据长度超出列宽时将会自动截取
			singleSelect : false,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,		
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			idField: 'impbatchno', //该列是一个唯一列
			sortOrder: 'asc',
			columns : [ [
			{field:'opt',title:'操作',align:'center',width:80,
              formatter:function(value,rec){   
                  return '<span style="color:blue" mce_style="color:blue">&nbsp;<a href="javascript:chakanUploadDetail(\''+rec.impbatchno+'\')" mce_href="#"><img src="<%=basePath%>/images/pub/news.png" align="absmiddle">明细</a></span>';  
              }   
	        }, 
	        {
				width : '50',
				title : '企业id',
				field : 'comid',
				hidden : true
			},{
				width : '200',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},{
				width : '180',
				title : '上传批次',
				field : 'impbatchno',
				hidden : false
			},{
				width : '80',
				title : '企业法人',
				field : 'comfrhyz',
				hidden : false
			},{
				width : '90',
				title : '企业负责人',
				field : 'comfzr',
				hidden : false
			},{
				width : '90',
				title : '固定电话',
				field : 'comgddh',
				hidden : false
			},{
				width : '90',
				title : '移动电话',
				field : 'comyddh',
				hidden : false
			},{
				width : '200',
				title : '企业地址',
				field : 'comdz',
				hidden : false
			}]]
		});			
		
	});////////////////////////////////////////////
	
	function chakanUploadDetail(v_impbatchno){
		var url=basePath + '/jyjc/jyjcUploadQueryComDetailIndex';
		var dialog = parent.sy.modalDialog({
		title : '附件',
		param : {
		impbatchno : v_impbatchno
		},
		width : 800,
		height : 600,
		url : url
		});
	}
	
	
	// 查询主要信息
	function query() {
		var mygrid=$("#gridmain");
		var param = {
			'startimpczsj': $('#startimpczsj').datetimebox('getValue'),
			'endimpczsj': $('#endimpczsj').datetimebox('getValue'),
			'comid': $('#comid').val()
		};
		mygrid.datagrid({
			url : basePath + '/jyjc/queryJyjcUploadCom',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections');
	}
	
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 	
	
	//从单位信息表中读取
	function myselectcom(){
		var url = "<%=basePath%>pub/pub/selectcomIndex";
		var dialog = parent.sy.modalDialog({
		title : '选择企业',
		param : {
		a : new Date().getMilliseconds(),
		singleSelect:"true",
		comjyjcbz : "1"
		},
		width : 800,
		height : 600,
		url : url
		},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj!=null && obj.length>0){
		 for (var k=0;k<=obj.length-1;k++){
		 var myrow=obj[k];
	      $("#commc").val(myrow.commc); //公司名称   
	      $("#comid").val(myrow.comid); //公司代码     
	 }
	}
	sy.removeWinRet(dialogID);//不可缺少	
	})
	}	

</script>
</head>
<body >
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>开始时间:</nobr></td>
						<td><input id="startimpczsj" name="startimpczsj" style="width: 150px" 
						class="easyui-datetimebox"  /></td>					
						<td style="text-align:right;"><nobr>结束时间:</nobr></td>
						<td><input id="endimpczsj" name="endimpczsj" style="width: 150px" 
						class="easyui-datetimebox" /></td>								
					</tr>
					<tr>
					    <td>当事人名称:</td>
						<td colspan="3"><input type="hidden" id="comid" name="comid" style="width: 150px" class="easyui-validatebox" 
						data-options="validType:'length[0,50]'" />
						<input id="commc" name="commc" style="width: 580px" class="easyui-validatebox" 
						  readonly="readonly"/>
							<a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>						
						</td>	
					</tr>
					<tr>	
						<td colspan="4">
						   <div align="right">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						    </div>		
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="企业上传记录">
				<div id="gridmain" style="height:430px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>    
</body>
</html>