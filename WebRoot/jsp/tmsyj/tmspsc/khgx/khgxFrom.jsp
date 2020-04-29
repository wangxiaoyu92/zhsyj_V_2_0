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
<% 	
    String jgztkhgx = StringHelper.showNull2Empty(request.getParameter("jgztkhgx"));
    String hjgztkhgxid = StringHelper.showNull2Empty(request.getParameter("hjgztkhgxid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
 %> 
<!DOCTYPE html>
<html>
<head>
<title>客户信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree2.jsp"></jsp:include>
<script type="text/javascript">  
 	var zzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
	var v_zzzm;
	var fwnw;
	$(function() {
	v_zzzm = $('#jgztkhzzzmmc').combobox({
			data :zzzm,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight :180
		});	
/* 	fwnw = $('#jgztfwnfww').combobox({
			data :[{id:'1',text:'范围内'},
			        {id:'2',text:'范围外'}],
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false ,
			editable :false ,
			panelHeight :60,
			 onLoadSuccess : function() {   
			        $("#jgztfwnfww").combobox("setValue", 1);  
			    } ,
		     onChange: function () {
		           var newPtion = $("#jgztfwnfww").combobox('getValue');
		           if (newPtion != 1) {  
		        	   $("#hi").hide();	   
		           } else {    
		        	   $("#hi").show();
		        	 //  class="easyui-validatebox" data-options="required:true" 
		           }  
		     }    
		});	 */
		if ($('#hjgztkhgxid').val().length > 0) { 
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/khgx/queryKhgxList', {
				hjgztkhgxid : $('#hjgztkhgxid').val()
			}, 
			function(result) {
				if (result.code=='0') { 
					var mydata = result.rows[0];					
					$('form').form('load', mydata);							
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
			}, 'json');
			 if ('<%=op%>' == 'show'){ 
			 	$('from:input').addClass('input_readonly');
			 	$('from:input').attr('readonly','readonly');
			 	$('input').attr('disabled','true');
				$('#btnselectcom').hide();
			 }
		} 
	});
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) { 
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
			//if($('#jgztfwnfww').val() == 2){ //范围外的企业清空jgztfwnztid
			//  $('#jgztfwnztid').val("");
			//}
		$('#fm').form('submit',{
			url: basePath + 'khgx/saveKhgx',
			onSubmit: function(){ 
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
	        			$grid.datagrid('reload');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};


	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	}; 
	 
</script> 
<script type="text/javascript">   
	//选择企业
	function myselectcom(){ 
		var obj = new Object();
		obj.singleSelect="true";	//
	
	    var v_retStr=myShowModalDialog("<%=basePath%>pub/pub/selectcomhviewjgztIndex?a="+new Date().getMilliseconds(),obj,800,600);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      $("#jgztkhbh").val(myrow.jgztbh); //公司编号    
		      $("#jgztkhmc").val(myrow.jgztmc); //公司名称    
		      $("#jgztfwnztid").val(myrow.hviewjgztid); //范围内主体ID
		      $("#jgztkhzzzmbh").val(myrow.jgztzzzmbh); //资质证明编号
		      $("#jgztkhzzzmmc").val(myrow.jgztzzzmmc); //资质证明名称 
		      $("#jgztkhgddh").val(myrow.jgztlxrgddh); //固定电话 
		      $("#jgztkhyddh").val(myrow.jgztlxryddh); //移动电话
		      $("#jgztkhlxr").val(myrow.jgztlxr); //联系人
		      $("#jgztkhlxdz").val(myrow.jgzttxdz); //地址
		     // $("#jgztfwnztid").val(myrow.jgztfwnfww); //范围 
		      $("#aaa027").val(myrow.aaa027); //统筹区
		    }      
	    }
	}
	</script> 
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" > 
		<input type="hidden" id="hjgztkhgxid" name="hjgztkhgxid" value="<%=hjgztkhgxid%>"/> 
		<input type="hidden" id="jgztkhgx" name="jgztkhgx" value="<%=jgztkhgx%>"/>
		<input type="hidden" id="jgztfwnfww" name="jgztfwnfww"> 
		<input type="hidden" id="jgztfwnztid" name="jgztfwnztid">
		<input type="hidden" id="hviewjgztid" name="hviewjgztid">
		
		 <input name="aaa027" id="aaa027" type="hidden"/>
	       <%-- 	<sicp3:groupbox title="商户信息">	 --%>
	       		<table class="table" style="width: 99%;"> 				
<!-- 					<tr>	
						<td style="text-align:right;">范围划分:</td>
						<td colspan="3"><input type="hidden" name="jgztfwnfww" id="jgztfwnfww" value="2" style="width: 175px; "/> 
						</td>
					</tr> 				
					<tr id = "hi">
						<td style="text-align:right;"><nobr>范围内主体ID:</nobr></td>
						<td colspan="3"><input name="jgztfwnztid" id="jgztfwnztid" style="width: 175px;" class="input_readonly" readonly="readonly" />	
						 <a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
						</td>
					</tr>  -->				
					<tr>
						<td style="text-align:right;"><nobr>名称:</nobr></td>
						<td><input name="jgztkhmc" id="jgztkhmc"  style="width: 175px;" class="easyui-validatebox" data-options="required:true"/>
						</td>								
						<td style="text-align:right;"><nobr>编号:</nobr></td>
						<td><input name="jgztkhbh" id="jgztkhbh"   style="width: 175px; "/></td>						
					</tr> 
					<tr>	
						<td style="text-align:right;"><nobr>移动电话:</nobr></td>
						<td><input name="jgztkhyddh" id="jgztkhyddh" style="width: 175px;" class="easyui-validatebox" data-options="validType:'mobile'"/></td>
						<td style="text-align:right;"><nobr>固定电话:</nobr></td>
						<td><input name="jgztkhgddh" id="jgztkhgddh"   style="width: 175px; " /></td>
					</tr> 	 
					<tr>	
						<td style="text-align:right;"><nobr>资质证明名称:</nobr></td>
						<td ><input name="jgztkhzzzmmc" id="jgztkhzzzmmc"   style="width: 175px; " /></td>		
						<td style="text-align:right;"><nobr>资质证明编号:</nobr></td>
						<td ><input name="jgztkhzzzmbh" id="jgztkhzzzmbh"   style="width: 175px; " /></td>		
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>联系人:</nobr></td>
						<td><input name="jgztkhlxr" id="jgztkhlxr"   style="width: 175px;" /></td>								
					</tr>				
					<tr>	
						<td style="text-align:right;"><nobr>通讯地址:</nobr></td>
						<td colspan="3"><input name="jgztkhlxdz" id="jgztkhlxdz" style="width:450px;"/></td>
					</tr> 				
				</table>
	    <%--     </sicp3:groupbox> --%>
		</form>
    </div>    
</body>
</html>