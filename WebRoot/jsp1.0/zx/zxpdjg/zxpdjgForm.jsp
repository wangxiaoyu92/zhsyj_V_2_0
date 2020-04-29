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
	String pdjgid = StringHelper.showNull2Empty(request.getParameter("pdjgid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>诚信评定结果</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	//红黑榜等级
	var djcshh = <%=SysmanageUtil.getAa10toJsonArray("DJCSHH")%>;
	//生成方式
	var pdjgscfs = <%=SysmanageUtil.getAa10toJsonArray("PDJGSCFS")%>
	var cb_djcshh;
	var cb_pdjgscfs;
	var grid;
	$(function() {
		cb_djcshh = $('#djcshh').combobox({
			data : djcshh,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			disabled:true,
			panelHeight : 180,
			panelWidth : 280
		});
		cb_pdjgscfs = $('#pdjgscfs').combobox({
			data : pdjgscfs,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable : false,
			panelHeight : 180,
			panelWidth : 280
		});
		if ($('#pdjgid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + 'zx/zxpdjg/queryZxpdjgDTO',{
				pdjgid : $('#pdjgid').val()
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
	
	//页面加载完成自动生成年度信息
	$(function(){
		var year = new Date().getFullYear();
		for(var i = year;i>2010;i--){
			var temp = '<option value='+(i)+'>'+i+'</option>';
			//设置value的值和列表参数
			var $time = $(temp);
			$("#niandu").append($time);
		}
	});

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 保存诚信评定信息 
	var saveZxpdjg = function($dialog, $grid, $pjq) {
		var url = basePath + 'zx/zxpdjg/saveZxpdjg';

		//提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
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


	//从单位信息表中读取
	function myselectcom(){
		var url = "<%=basePath%>pub/pub/selectcomIndex?a="+new Date().getMilliseconds();

		var dialog = parent.sy.modalDialog({
			title : ' ',
			param : {
				singleSelect : true
			},
			width : 800,
			height : 600,
			url : url
		},function(dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);
			if (obj!=null && obj.length>0){
				for (var k=0;k<=obj.length-1;k++){
					var myrow=obj[k];
					$("#commc").val(myrow.commc); //公司名称
					$("#comid").val(myrow.comid); //公司代码
				}
			}
		});
	}
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	
	//判断企业名称和年度文本框是否为空  得出得分的信息、
	function  IsTextNull(){
		var comid=$("#comid").val();
		var niandu=$("#niandu").val();
		if(comid!="" && niandu!=""){
			$.ajax({
				url:basePath +"/zx/zxpdjg/sumScore",
				data:{
					"comid":comid,
					"niandu":niandu
					},
				dataType:"json",
				success: function(result){ 
					$("#pdjgdf").val(result.rows);	
				},
				error:function(){alert("系统有错误");}
			   }) ;
			
		}
		
	}
	//改变了企业的名称，则重新设置评定年份
	function setEmpty(){
		$("#niandu").val("");
	}
</script>
</head>

<body>
	<form id="fm" method="post">
		<input name="filepath" id="filepath"  type="hidden" />
        	<sicp3:groupbox title="诚信评定信息">	
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业代码:</nobr></td>
						<td><input id="comid" name="comid" style="width: 150px" class="easyui-validatebox" 
						data-options="required:true,validType:'length[0,50]'"/>
						<% if(!"view".equalsIgnoreCase(op)){%>
							<a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom(),setEmpty()">选择企业 </a>	
								<%} %>						
						</td>
						<td style="text-align:right;"><nobr>企业名称:</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px" class="easyui-validatebox" data-options="required:true" readonly="readonly"/>&nbsp;&nbsp;</td>						
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>年度:</nobr></td>
						<td>
							<select id="niandu" name="niandu" style="width: 200px" class="easyui-validatebox" data-options="required:true" onblur="IsTextNull()">
								<option value="">==请选择==</option>
							</select>
						</td>		
						<td style="text-align:right;"><nobr>得分:</nobr></td>
						<td><input id="pdjgdf" name="pdjgdf" style="width: 200px" class="easyui-validatebox" data-options="required:true" />&nbsp;&nbsp;</td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>等级编码:</nobr></td>
						<td><input id="djcsbm" name="djcsbm" style="width: 200px"  readonly="readonly" class="input_readonly" />&nbsp;&nbsp;</td>
						<td style="text-align:right;"><nobr>等级红黑:</nobr></td>
						<td><input id="djcshh" name="djcshh" style="width: 200px" readonly="readonly" class="easyui-combobox input_readonly" />&nbsp;&nbsp;</td>						
					</tr>
					<!-- <tr>						
						<td style="text-align:right;"><nobr>操作员姓名:</nobr></td>
						<td><input id="czyxm" name="czyxm" style="width: 200px" class="easyui-validatebox" data-options="required:false" /></td>		
						<td style="text-align:right;"><nobr>操作时间:</nobr></td>
						<td><input id="czsj" name="czsj" style="width: 200px" class="easyui-datebox" required="required" /></td>						
					</tr> -->
					<tr>						
						<td style="text-align:right;"><nobr>产生方式:</nobr></td>
						<td><input id="pdjgscfs" name="pdjgscfs" style="width: 200px" class="easyui-combobox" data-options="validType:'comboboxNoEmpty'" /></td>		
						<td style="text-align:right;"><nobr>备注:</nobr></td>
						<td><input id="beizhu" name="beizhu" style="width: 200px" class="easyui-validatebox" data-options="required:false" /></td>		
					</tr>
				</table>
				<td><input id="pdjgid" name="pdjgid" type="hidden" style="width: 200px;" readonly="readonly" class="input_readonly" value="<%=pdjgid%>"/></td>	
	        </sicp3:groupbox>
	   </form>
</body>
</html>