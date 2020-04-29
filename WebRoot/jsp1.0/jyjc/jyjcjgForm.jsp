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
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String jcjgid = StringHelper.showNull2Empty(request.getParameter("jcjgid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>检验检测项目</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//检测检验类别
	var v_jcjylb= <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
	// 检验检测结论
	var v_jyjcjl= <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
	//检测检验审核标志
	var v_shbz= <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
	var grid;
	$(function() {
		//检测检验类别
		v_jcjylb= $('#jcjylb').combobox({
	    	data : v_jcjylb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    //检验检测结论
		v_jyjcjl= $('#impjcjg').combobox({
	    	data : v_jyjcjl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    //检测检验审核标志
		v_shbz= $('#jcjyshbz').combobox({
	    	data : v_shbz,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		if ($('#jcjgid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + '/jyjc/queryJyjcjgDTO',{
				jcjgid : $('#jcjgid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');

			if('<%=op%>' == 'view'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');  		
				$('.Wdate').attr('disabled',true);	
			}
		}
	});
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 
	//选择企业信息
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
	//选择样品信息
	function myselectyp(){
		var url="<%=basePath%>pub/pub/selectjyjcypIndex";
		var dialog = parent.sy.modalDialog({
			title : '样品信息',
			param : {
				a :new Date().getMilliseconds(),
				singleSelect : "true"
			},
			width : 800,
			height : 400,
			url : url,
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if (obj != null && obj.length > 0) {
				 for (var k=0;k<=obj.length-1;k++){
				 var myrow=obj[k];
				  $("#jcypid").val(myrow.jcypid); //样品id  
		     	  $("#jcypmc").val(myrow.jcypmc); //样品名称   
				 }
			}
			sy.removeWinRet(dialogID);//不可缺少	
		});
	}
	//选择项目信息
	function myselectxm(){
		var url="<%=basePath%>pub/pub/selectjyjcypIndex";
		var dialog = parent.sy.modalDialog({
			title : '项目信息',
			param : {
				a :new Date().getMilliseconds(),
				singleSelect : "true"
			},
			width : 800,
			height : 420,
			url : url,
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			 if (obj != null && obj.length > 0) {
			 	 for (var k=0;k<=obj.length-1;k++){
			 	 	 var myrow=obj[k];
			 	 	  $("#jcxmid").val(myrow.jcxmid); //项目类别  
		   			   $("#jcxmmc").val(myrow.jcxmmc); //项目名称 
		     			 $("#jcxmbzz").val(myrow.jcxmbzz); //标准值
			 	 }
			 }
			 sy.removeWinRet(dialogID);//不可缺少	
		})
	}
	
	// 保存检验检测结果
	var submitForm = function($dialog, $grid, $pjq) { 
		var url; 
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/jyjc/saveJyjcjg',
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
	        			$grid.datagrid('load');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}; 
	//验证标准值
	function checkBzz(){
		var bzz=$('#jcxmbzz').val();
		var jgz=$('#imphl').val();
		//结论    1是合格    2是不合格
		if(parseInt(bzz)>parseInt(jgz)){
			 $('#impjcjg').combobox('setValue','1') 
		}
		else{
			 $('#impjcjg').combobox('setValue','2') 
		}
	}
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
</script>
</head>

<body>
	<form id="fm" method="post">
		<input name="filepath" id="filepath"  type="hidden" />
        	<sicp3:groupbox title="检验检测结果">	
        		<table class="table" style="width: 99%;">
					<tr>
						<input id="jcjgid" name="jcjgid"  type="hidden" value="<%=jcjgid%>" />
						<td style="text-align:right;"><nobr>检验检测类别:</nobr></td>
						<td><input id="jcjylb" name="jcjylb" style="width: 150px;" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"/></td>						
						<td style="text-align:right;"><nobr>检测样品名称:</nobr></td>
						<td><input id="jcypmc" name="jcypmc" style="width: 150px"  readonly="readonly"   class="easyui-validatebox"   data-options="required:true"/>
							<input id="jcypid" name="jcypid" type="hidden" />
						<% if(!"view".equalsIgnoreCase(op)){%>
							<a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectyp()">选择样品 </a>	
								<%} %>	
						</td>						
					</tr>
						 
					<tr>		
						<td style="text-align:right;"><nobr>受检单位:</nobr></td>
						<td><input id="commc" name="commc" style="width: 150px" readonly="readonly" class="easyui-validatebox"    data-options="required:true"/>
						<input id="comid" name="comid"  type="hidden" />
						<% if(!"view".equalsIgnoreCase(op)){%>
							<a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>	
								<%} %>	
						</td>						
						<td style="text-align:right;"><nobr>检测项目名称:</nobr></td>
						<td><input id="jcxmmc" name="jcxmmc" style="width: 150px" readonly="readonly" class="easyui-validatebox"   data-options="required:true"/>
							<input id="jcxmid" name="jcxmid" type="hidden" />
						<% if(!"view".equalsIgnoreCase(op)){%>
							<a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectxm()">选择项目 </a>	
								<%} %>	
						</td>			
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr> 标准值:</nobr></td>
						<td><input id="jcxmbzz" name="jcxmbzz" style="width: 150px" readonly="readonly" class="easyui-validatebox"  data-options="required:true" /> </td>									
						<td style="text-align:right;"><nobr>结果值:</nobr></td>
						<td><input id="imphl" name="imphl" style="width: 150px"  onblur="checkBzz()" class="easyui-validatebox"  data-options="required:true,validType:['integer','length[0,6]']"/></td>			
					</tr>
					<tr> 
					<tr>						
						<td style="text-align:right;"><nobr> 检测日期:</nobr></td>
						<td>	<input	name="impjcsj" id="impjcsj" class="Wdate"
										onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
										readonly="readonly" style="width: 150px;"> </td>									
						<td style="text-align:right;"><nobr> 结论:</nobr></td>
						<td ><input id="impjcjg" name="impjcjg" readonly="readonly" style="width: 150px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>												
					</tr>
					<tr> 
						<td style="text-align:right;"><nobr> 复检结果:</nobr></td>
						<td ><input id="fjjg" name="fjjg" style="width: 150px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>									
						<td style="text-align:right;"><nobr> 处理结果:</nobr></td>
						<td ><input id="jcjycljg" name="jcjycljg" style="width: 150px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>									
					</tr>	 
	        </sicp3:groupbox>
	   </form>
</body>
</html>