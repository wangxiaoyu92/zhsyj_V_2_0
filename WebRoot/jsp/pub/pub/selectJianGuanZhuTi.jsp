<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	
	String v_jgztlx = StringHelper.showNull2Empty(request.getParameter("jgztlx"));  //监管主体类型 1企业2商户3供应商4生产商5经销商
	String v_gxmc="企业";
	if ("1".equalsIgnoreCase(v_jgztlx)){
		v_gxmc="企业";
	}else if ("2".equalsIgnoreCase(v_jgztlx)){
		v_gxmc="商户";
	}else if ("3".equalsIgnoreCase(v_jgztlx)){
		v_gxmc="供货商";
	}else if ("4".equalsIgnoreCase(v_jgztlx)){
		v_gxmc="生产商";
	}else if ("5".equalsIgnoreCase(v_jgztlx)){
		v_gxmc="经销商";
	}
	
	//默认选择范围内还是范围外 1范围内 2范围外
	String v_selfwnfww = StringHelper.showNull2Empty(request.getParameter("selfwnfww"));  //
	if (null==v_selfwnfww || "".equals(v_selfwnfww)){
		v_selfwnfww="1";
	}
	String v_fwnChecked="";
	String v_fwwChecked="";			
	if ("1".equals(v_selfwnfww)){
	  v_fwnChecked="checked='checked'";	
	}else{
	  v_fwwChecked="checked='checked'";		
	};
	
	String v_singleSelect = StringHelper.showNull2Empty(request.getParameter("singleSelect"));//是否单选
	Boolean b_singleSelect=false;
	if (v_singleSelect!=null && "true".equals(v_singleSelect)){
		b_singleSelect=true;
	};
	String v_comjyjcbz = StringHelper.showNull2Empty(request.getParameter("comjyjcbz"));//检验检测标志
	
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
// 监管主体范围内范围外
var v_jgztfwnfww = <%=SysmanageUtil.getAa10toJsonArray("JGZTFWNFWW")%>;
var v_jgztlxdata=<%=SysmanageUtil.getAa10toJsonArray("JGZTLX")%>;
var mygrid;

$(function() {		
		mygrid = $('#mygrid').datagrid({
			title: '<%=v_gxmc%>',
			url : basePath + '/pub/pub/queryJianGuanZhuTi',			
			queryParams : {
				jgztfwnfww: '<%=v_selfwnfww%>',	
				jgztlx:'<%=v_jgztlx%>'
			},
			toolbar: '#toolbar',
			striped : true,// 奇偶行使用不同背景色
			singleSelect:'<%=b_singleSelect%>',
			checkOnSelect : true,
			selectOnCheck : true,	
			onLoadSuccess:function(data){
			  $(this).datagrid('clearSelections');
			},
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'hviewjgztid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [[ 
            {width : '100',
				//title : '企业ID',
				checkbox:'true',
				field : 'hviewjgztid',
				hidden : false
			},{
				width : '200',
				title : '主体名称',
				field : 'jgztmc',
				hidden : false
			},{
				width : '90',
				title : '主体名称简称',
				field : 'jgztmcjc',
				hidden : false
			},{
				width : '120',
				title : '主体范围内范围外',
				field : 'jgztfwnfww',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jgztfwnfww,value);
				}				
			},{
				width : '80',
				title : '监管主体类型',
				field : 'jgztlx',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jgztlxdata,value);
				}				
			},{
				width : '90',
				title : '主体编号',
				field : 'jgztbh',
				hidden : false
			},{
				width : '70',
				title : '联系人',
				field : 'jgztlxr',
				hidden : false
			},{
				width : '100',
				title : '移动电话',
				field : 'jgztlxryddh',
				hidden : false
			},{
				width : '80',
				title : '固定电话',
				field : 'jgztlxrgddh',
				hidden : false
			},{
				width : '120',
				title : '联系地址',
				field : 'jgzttxdz',
				hidden : false
			},{
				width : '100',
				title : '资质证明名称',
				field : 'jgztzzzmmc',
				hidden : false
			},{
				width : '80',
				title : '资质证明编号',
				field : 'jgztzzzmbh',
				hidden : false
			},{
				width : '80',
				title : '监管主体归属主体',
				field : 'jgztgsztid',
				hidden : true
			}
			]]
		});
	var v_local_fwnfww="<%=v_selfwnfww%>";	
});///////////////////////////////

	function query() {
	    var v_jgztfwnfww=$('input:radio[name="jgztfwnfww"]:checked').val();
		var param = {
			'jgztfwnfww': v_jgztfwnfww,	
			'jgztmc': $('#jgztmc').val(),
			'jgztmcjc': $('#jgztmcjc').val(),
			'jgztlx':'<%=v_jgztlx%>'
		};
		mygrid.datagrid({
			url : basePath + '/pub/pub/queryJianGuanZhuTi',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections'); 
	}

	function refresh(){
		$('#jgztkhmc').val('');
		$('#jgztkhmcjc').val('');
	} 
	
/*    function queding(){
     var rows=mygrid.datagrid('getSelections'); 
	   if (rows!="") {
			 window.returnValue=rows;
			 window.close(); 
		}else{
			$.messager.alert('提示', '请先选择记录！', 'info');
		} 
   } */
   
   // 保存 
	var queding = function($dialog) {
	    var rows = mygrid.datagrid('getSelections'); 
		if (rows!="") {
			var obj = new Object();
			obj.retValue = rows;
			obj.jgztlx='<%=v_jgztlx%>';
			sy.setWinRet(obj);
  			 //sy.setWinRetObj("retValue",rows);
  			 //sy.setWinRet("jgztlx",'<%=v_jgztlx%>');
  			 closeWindow($dialog); 				 
		}else{
			$.messager.alert('提示', '请先选择记录！', 'info');
		} 
	}; 

	// 关闭窗口
	var closeWindow = function($dialog){
   	$dialog.dialog('close');
	};  

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false">
           <input type="hidden" name="jgztlx" id="jgztlx" value="<%=v_jgztlx%>">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width:1000px;">
					<tr>
						<td style="text-align:right;"><nobr><%=v_gxmc%>名称</nobr></td>
						<td><input id="jgztmc" name="jgztmc" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr><%=v_gxmc%>简称</nobr></td>
						<td><input id="jgztmcjc" name="jgztmcjc" style="width: 100px" /></td>																		
                        <td>
                          <input type="radio" value="1" name="jgztfwnfww" id="jgztfwnfww" <%=v_fwnChecked %>/>范围内
                          <input type="radio" value="2" name="jgztfwnfww" id="jgztfwnfww"<%=v_fwwChecked %>/>范围外
                        </td>  
					  	<td colspan="2">
					  	    &nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;							
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="监管主体列表">
				<div id="mygrid" style="width:1000px;height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   

</body>
</html>