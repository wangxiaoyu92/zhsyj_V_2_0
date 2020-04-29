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
%>
<%
	//商品数据类型aaa100=spsjlx0商品1生产企业产品2生产企业原材料*/
	String v_spsjlx = StringHelper.showNull2Empty(request.getParameter("spsjlx"));//商品数据类型
	if (v_spsjlx==null || "".equals(v_spsjlx)){
		v_spsjlx="0";
	}	
	String v_spsjlxmc="商品";
	if ("1".equals(v_spsjlx)){
		v_spsjlxmc="产品";
	}else if ("2".equals(v_spsjlx)){
		v_spsjlxmc="原材料";
	}

	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String jcypid = StringHelper.showNull2Empty(request.getParameter("jcypid"));
	String v_title=v_spsjlxmc+"管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title=v_spsjlxmc+" 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title=v_spsjlxmc+" 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title=v_spsjlxmc+" 查看";
	}	
	

%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//检测样品类别
	var jcyplb= <%=SysmanageUtil.getAa10toJsonArray("JCYPLB")%>;
	var jcypgl= <%=SysmanageUtil.getAa10toJsonArray("JCYPGL")%>;
	var v_spfenlei= <%=SysmanageUtil.getAa10toJsonArray("SPFENLEI")%>;
	
	$(function() {
		//检测样品类别
		$('#jcyplb').combobox({
	    	data : jcyplb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 180,
	        panelWidth:180  
	    });
		//检测样品类别
		$('#jcypgl').combobox({
	    	data : jcypgl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 180,
	        panelWidth:180,
			onSelect: function(rec){
				var selectId = rec.id;
				var spsbVal = $("#spsb").val();
				var jcypssppVal = $("#jcypsspp").val();
				if (selectId == '10102' && (!spsbVal || jcypssppVal)) { // 当为预包装食品，并且值不为空时
					$("#spsb").css("border-color", "red");
					$("#jcypsspp").css("border-color", "red");
				} else {
					$("#spsb").css("border-color", "");
					$("#jcypsspp").css("border-color", "");
				}
			}
	    });
		//商品分类
		 $('#spfenlei').combobox({
	    	data : v_spfenlei,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 180,
	        panelWidth:180  
	    });			
		if ($('#jcypid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + 'jyjc/queryJyjcypDTO',{
				jcypid : $('#jcypid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
					if ($("#jcypgl").combobox('getValue') == '10102') {
						$("#spsb").css("border-color", "red");
						$("#jcypsspp").css("border-color", "red");
					}
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				var sppicpath = $("#sppicpath").val();
	            if (sppicpath != "") {
	            	$("#sppic").attr("src", "<%=contextPath%>"+sppicpath);
	            };	
				parent.$.messager.progress('close');
			}, 'json');
		}
		
		if('<%=op%>' == 'view'){	
			$('form :input').addClass('input_readonly');
			$('form :input').attr('readonly','readonly');				
			$('.Wdate').attr('disabled',true);	
			$("#jcyplb").combobox('disable',true);	
			$("#jcypgl").combobox('disable',true);	
			$("#btn_selectsppic").linkbutton("disable");
			$("#comxkyxqz").datebox({
				disabled:true
			});			
			$("a").each(function(index,object){
				object.removeAttribute("onclick");

			});
			$("#td[name='btntd']").hide();
		}			
	});////////////////////////////////
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 保存检验检测样品
	var saveJyjcyp = function($dialog, $grid, $pjq) {
		var url = basePath + 'jyjc/saveJyjcyp';

		if ($("#jcypgl").combobox('getValue') == '10102' && !$("#spsb").val()) {
			$.messager.alert('提示','商标不能为空！','info',function(){
				$("#spsb").focus();
			});
			return;
		}
		if ($("#jcypgl").combobox('getValue') == '10102' && !$("#jcypsspp").val()) {
			$.messager.alert('提示','所属品牌不能为空！','info',function(){
				$("#jcypsspp").focus();
			});
			return;
		}
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
	        			$grid.datagrid('reload');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};

	//上传图片
	var uploadTp = function(){
		
	};
	//上传附件
	function uploadFuJian(){
		var url="<%=basePath%>jsp/jyjc/uploadyptu.jsp";
		var dialog = parent.sy.modalDialog({
			title : '上传附件',
			param : {
			style:"help:no;status:no;scroll:no;dialogWidth:800px;dialogHeight:500px;dialogTop:100px;" +
			"dialogLeft:400px;resizable:no;center:no",
			jcypid : '<%=jcypid%>',
			time:new Date().getMilliseconds()
			},
			url :url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			if (obj.uploadurl == "/upload/jyjc") {
				$("#jcyptp").attr("src", "<%=contextPath%>"+obj.uploadurl+"/"+obj.jcyptpwjm);
				$("#jcyptpwjm").val(obj.jcyptpwjm);
			}
			}
			sy.removeWinRet(dialogID);//不可缺少	
			
		})
	}
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 上传图片附件
	function uploadFjViewCanNoId(prm_fjtype){
		var v_fjwid=$("#jcypid").val();
		var url = "<%=basePath%>pub/pub/uploadFjViewIndexEasyui";
		var dialog = parent.sy.modalDialog({
		title : '上传图片附件',
		param : {
		folderName :"shangpin",
		fjwid :v_fjwid,
		fjtype :prm_fjtype,
		uploadOne : "yes"
		},
		width : 900,
		height : 700,
		url : url
		},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if(obj != null){
		if(obj.type == 'ok'){
			if (prm_fjtype=="8"){//商品图片
				  $("#sppicpath").val(obj.fjpath);
				  $("#sppicname").val(obj.fjname);	
				  $("#sppic").attr("src", "<%=contextPath%>"+obj.fjpath);
				}
		}
		if(obj.type == 'deleteok'){
				var v_defaultpic="/images/default.jpg";
				if (prm_fjtype=="8"){//商品图片
				  $("#sppicpath").val("");
				  $("#sppicname").val("");	
				  $("#sppic").attr("src", "<%=contextPath%>"+v_defaultpic);
				}
			}		
		}
		sy.removeWinRet(dialogID);//不可缺少	
		})
	};	
</script>
</head>

<body>
<div id="cc" class="easyui-layout" fit=true>
    <div data-options="region:'north'"
         style="height:40px;text-align:center;"  >
         <font style="font-size:200%;text-align:right;color: green;"><%=v_title%></font>
    </div>
    
    <div data-options="region:'center'"  fit=true>  
	<form id="fm" method="post">
 		    <input name="hviewjgztid" id="hviewjgztid"  type="hidden" />  
			<input type="hidden" id="jcypid" name="jcypid"  value="<%=jcypid%>"/></td>	
		    <input type="hidden" id="jcyptpwjm" name="jcyptpwjm"  />	
		    <input type="hidden" id="spsjlx" name="spsjlx" value="<%=v_spsjlx %>">
		    <input type="hidden" id="userid" name="userid" >
		    		
        		<table class="table" style="width: 99%;">
 					<tr>
					    <td style="padding-top: 0px;"></td>
					    <td style="padding-top: 0px;"></td> 					
						<td style="text-align: center;" colspan="2" rowspan="8">
						    <div style="width:140px;height:160px;text-align: center;" id="sppic_div" >
						    	<img src="<%=contextPath%>/images/default.jpg" name="sppic" 
						    	id="sppic" height="130" width="150"/>
						   	</div>
						   	<a id="btn_selectsppic" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-upload"
							onclick="uploadFjViewCanNoId(8)">选择商品图片</a> 
							<input type="hidden" id="sppicpath" name="sppicpath">	
							<input type="hidden" id="sppicname" name="sppicname">	
			    		</td>	
					</tr>   			     		
					<tr>
						<td style="text-align:right;"><nobr>类别:</nobr></td>
						<td><input id="jcyplb" name="jcyplb" style="width: 200px" 
						class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"
							data-options="required:true" /></td>
							
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>名称:</nobr></td>
						<td><input id="jcypmc" name="jcypmc" style="width: 200px" 
							class="easyui-validatebox" data-options="required:true" /></td>							
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>归类:</nobr></td>
						<td><input id="jcypgl" name="jcypgl" style="width: 200px" 
						class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"
							data-options="required:true" /></td>							
					</tr>					
<%-- 					<tr>
						<td style="text-align:right;"><nobr>上传图品预览:</nobr></td>
						<td>
						    <div style="width:130;height:160;" id="jcyptp_div">
						    	<img src="<%=contextPath%>/images/default.jpg" name="jcyptp" id="jcyptp" 
						    		height="140" width="110" />
						   	</div>
			    	    </td>
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>选择图片上传:</nobr></td>
						<td>
							<input type="button" onclick="uploadFuJian()" 
								value="选择图片" style="width: 200px;">
						</td>		
					</tr> --%>
					<tr>	
						<td style="text-align:right;"><nobr>分类:</nobr></td>
						<td><input id="spfenlei" name="spfenlei" style="width: 200px" 
						class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"
						data-options="required:true" /></td>							
					</tr>					
					<tr>	
						<td style="text-align:right;"><nobr>所属品牌:</nobr></td>
						<td><input id="jcypsspp" name="jcypsspp" style="width: 200px" /></td>
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>规格:</nobr></td>
						<td><input id="impcpgg" name="impcpgg" style="width: 200px" class="easyui-validatebox" 
							data-options="required:false" /></td>							
					</tr>	
					<tr>	
						<td style="text-align:right;"><nobr>商标:</nobr></td>
						<td ><input id="spsb" name="spsb" style="width: 200px; "/></td>
					</tr>	
					<tr>	
						<td style="text-align:right;"><nobr>规格型号:</nobr></td>
						<td><input id="spggxh" name="spggxh" style="width: 200px" class="easyui-validatebox" 
							data-options="required:false" /></td>							
					</tr>	
					<tr>	
						<td style="text-align:right;"><nobr>计量单位:</nobr></td>
						<td colspan="3"><input id="spjldw" name="spjldw" style="width: 200px" class="easyui-validatebox" 
							data-options="required:true" /></td>							
					</tr>	
					<tr>	
						<td style="text-align:right;"><nobr>执行标准号:</nobr></td>
						<td colspan="3"><input id="spzxbzh" name="spzxbzh" style="width: 200px" class="easyui-validatebox" 
							data-options="required:false" /></td>							
					</tr>	
					<tr>	
						<td style="text-align:right;"><nobr>保质期:</nobr></td>
						<td colspan="3"><input id="spbzq" name="spbzq" style="width: 200px" class="easyui-validatebox" 
							data-options="required:true" /></td>							
					</tr>																																		
				</table>
	       </form>
       </div>
    </div>	   
</body>
</html>