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
	String ryid = StringHelper.showNull2Empty(request.getParameter("ryid"));
	String sh = StringHelper.showNull2Empty(request.getParameter("sh"));
	System.out.println("ryidryid "+ryid);
%>
<!DOCTYPE html>
<html>
<head>
<title>企业人员信息管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	//证件类型
	var ryzjlx = <%=SysmanageUtil.getAa10toJsonArray("RYZJLX")%>;
	//人员性别
	var ryxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	//人员民族
	var rymz = <%=SysmanageUtil.getAa10toJsonArray("AAC005")%>;
	//人员学历
	var ryxueli = <%=SysmanageUtil.getAa10toJsonArray("RYXUELI")%>;
	//在职状态
	var v_ryzt = <%=SysmanageUtil.getAa10toJsonArray("RYZT")%>;
	//职务
	var v_ryzwgw = <%=SysmanageUtil.getAa10toJsonArray("RYZWGW")%>;		
	//技术职称
	var v_ryjszc = <%=SysmanageUtil.getAa10toJsonArray("RYJSZC")%>;		
	//人员健康情况
	var v_ryjkqk = <%=SysmanageUtil.getAa10toJsonArray("RYJKQK")%>;		
	//人员健康情况
	var v_rypxqk = <%=SysmanageUtil.getAa10toJsonArray("RYPXQK")%>;			
	//是否食品安全管理员
	var v_rysfspaqgly = <%=SysmanageUtil.getAa10toJsonArray("RYSFSPAQGLY")%>;		
	//是否监督公示人员
	var v_rysfjdgsry = <%=SysmanageUtil.getAa10toJsonArray("RYSFJDGSRY")%>;	
	//人员类别
	var v_rysflb = <%=SysmanageUtil.getAa10toJsonArray("RYSFLB")%>;	
	//人员是否执业药师
	var v_rysfzyys = <%=SysmanageUtil.getAa10toJsonArray("RYSFZYYS")%>;		
	
	
	
	var cb_ryzjlx;
	var cb_ryxb;
	var cb_ryxueli;
	var cb_rymz;
	var grid;
	$(function() {
		//是否监督公示人员
		cb_rysfzyys = $('#rysfzyys').combobox({
			data:v_rysfzyys,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});		
		//是否监督公示人员
		cb_rysflb = $('#rysflb').combobox({
			data:v_rysflb,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});			
		//是否监督公示人员
		cb_rysfjdgsry = $('#rysfjdgsry').combobox({
			data:v_rysfjdgsry,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});			
		//是否食品安全管理员
		cb_rysfspaqgly = $('#rysfspaqgly').combobox({
			data:v_rysfspaqgly,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});			
		//人员培训情况
		cb_rypxqk = $('#rypxqk').combobox({
			data:v_rypxqk,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});		
		//人员健康情况
		cb_ryjkqk = $('#ryjkqk').combobox({
			data:v_ryjkqk,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});			
		//技术职称
		cb_ryjszc = $('#ryjszc').combobox({
			data:v_ryjszc,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});			
		//职务
		cb_ryzwgw = $('#ryzwgw').combobox({
			data:v_ryzwgw,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});		
		//证件类型
		cb_ryzt = $('#ryzt').combobox({
			data:v_ryzt,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});
		//证件类型
		cb_ryzjlx = $('#ryzjlx').combobox({
			data:ryzjlx,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 190
		});
		//人员性别
		cb_ryxb = $('#ryxb').combobox({
			data:ryxb,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : 100
		});
		//人员学历
		cb_ryxueli = $('#ryxueli').combobox({
			data:ryxueli,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : 200
		});
		//人员民族
		cb_rymz = $('#rymz').combobox({
			data:rymz,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight: '125'
			/* panelHeight:'auto' */
		});
		
		if ($('#ryid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + 'pcomry/queryPcomryDTO',{
				ryid : $('#ryid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
					//getPersonPhoto($('#ryid').val());	
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }
				var ryzppath = $("#ryzppath").val();
	            if (ryzppath != "") {
	            	$("#ryzp").attr("src", "<%=contextPath%>"+ryzppath);
	            }
				var ryjkzpath = $("#ryjkzpath").val();
	            if (ryjkzpath != "") {
	            	$("#ryjkz").attr("src", "<%=contextPath%>"+ryjkzpath);
	            }
				var rypxzpath = $("#rypxzpath").val();
	            if (rypxzpath != "") {
	            	$("#rypxz").attr("src", "<%=contextPath%>"+rypxzpath);
	            }	            
				parent.$.messager.progress('close');
			}, 'json');

			if('<%=op%>' == 'view'||'<%=sh%>' == 'examPcom'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');				
				$('.Wdate').attr('disabled',true);	
				cb_comdalei2.combobox('disable',true);
			}
		}
	});
	
	// 从数据库获取照片
	function getPersonPhoto(v_ryid){	
		if (v_ryid != null && v_ryid != "") {
			$.post(basePath + '/pcomry/getComryzp', {
				'ryid':v_ryid
			},
			function(result) {
				$('#ryzp').attr('src',result.fileCtxPath + "?" + Math.random());
				if(result.code=='-1'){					
					$.messager.alert('提示', result.msg, 'error');	
				}				
			},
			'json');
		}	
	}
	
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 保存企业人员信息 
	var savePcomry = function($dialog, $grid, $pjq) {
		var url = basePath + 'pcomry/savePcomry';

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


	//选择企业名称
	function myselectcom(){
		var obj = new Object();
		obj.singleSelect="true";	//

	    var url ="<%=basePath%>/pub/pub/selectcomIndex?a="+new Date().getMilliseconds();

		var dialog = parent.sy.modalDialog({
			title : '选择企业',
			param : obj,
			width : 700,
			height : 530,
			url : url
		},function (dialogID){
			var v_retObj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if (v_retObj!=null && v_retObj.length>0){
				for (var k=0;k<=v_retObj.length-1;k++){
					var myrow=v_retObj[k];
					$("#commc").val(myrow.commc); //公司名称
					$("#comid").val(myrow.comid); //公司代码
				}
			}
		});

	}
	
	//上传人员照片
	function uploadFuJian(){
		var url = "<%=basePath%>jsp/baseinfo/pcomry/uploadryzp.jsp?ryid=<%=ryid%>&time="
			+new Date().getMilliseconds();

		var dialog = parent.sy.modalDialog({
			title : '上传人员照片',
			param : obj,
			width : 950,
			height : 600,
			url : url
		},function (dialogID){
			var v_retObj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if(typeof(v_retObj.type)!="undefined" && v_retObj.type!=null && v_retObj.type=='ok'){ //传递回的type为ok的时候才刷新页面。
				if (v_retObj.uploadurl == "/upload/pcomryzp") {
					$("#ryzp").attr("src", "<%=contextPath%>"+v_retObj.uploadurl+"/"+v_retObj.ryzpwjm);
					$("#ryzpwjm").val(v_retObj.ryzpwjm);
				}
			}
		});
	}
	
	// 关闭窗口
	var closeWindow = function(){
		parent.$("#"+sy.getDialogId()).dialog("close");
	};
	
	// 上传图片附件
	function uploadFjView(prm_fjtype){
        var v_fjwid=$("#ryid").val();
		var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=comry&fjwid="+v_fjwid+"&fjtype="+prm_fjtype; 
		var obj = new Object();
		obj.uploadOne="yes";
		var dialog = parent.sy.modalDialog({
			title : '上传人员照片',
			param : obj,
			width : 900,
			height : 700,
			url : url
		},function (dialogID){
			var retVal = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if(retVal != null){
				if(retVal.type == 'ok'){
					if (prm_fjtype=="5"){//健康证
						$("#ryjkzpath").val(retVal.fjpath);
						$("#ryjkzname").val(retVal.fjname);
						$("#ryjkz").attr("src", "<%=contextPath%>"+retVal.fjpath);
					}else if (prm_fjtype=="6"){//培训证
						$("#rypxzpath").val(retVal.fjpath);
						$("#rypxzname").val(retVal.fjname);
						$("#rypxz").attr("src", "<%=contextPath%>"+retVal.fjpath);
					}else if (prm_fjtype=="7"){//人员照片
						$("#ryzppath").val(retVal.fjpath);
						$("#ryzpname").val(retVal.fjname);
						$("#ryzp").attr("src", "<%=contextPath%>"+retVal.fjpath);
					}
				}
				if(retVal.type == 'deleteok'){
					var v_defaultpic="/images/default.jpg";
					if (prm_fjtype=="5"){//健康证
						$("#ryjkzpath").val("");
						$("#ryjkzname").val("");
						$("#ryjkz").attr("src", "<%=contextPath%>"+v_defaultpic);
					}else if (prm_fjtype=="6"){//培训证
						$("#rypxzpath").val("");
						$("#rypxzname").val("");
						$("#rypxz").attr("src", "<%=contextPath%>"+v_defaultpic);
					}else if (prm_fjtype=="7"){//人员照片
						$("#ryzppath").val("");
						$("#ryzpname").val("");
						$("#ryzp").attr("src", "<%=contextPath%>"+v_defaultpic);
					}
				}
			}
		});


	}
	
</script>
</head>

<body style="overflow-x:hidden;">
	<form id="fm" method="post">
		<input id="ryid" name="ryid" type="hidden" style="width: 200px;" readonly="readonly" class="input_readonly" value="<%=ryid%>"/>
		<input id="ryzpwjm" name="ryzpwjm" type="hidden" />
		<input id="comid" name="comid"   type="hidden" />
					
		<input name="filepath" id="filepath"  type="hidden" />
        	<sicp3:groupbox title="人员基本信息">	
        		<table class="table" style="width: 99%;">
        			<tr>
						<td style="text-align:right;"><nobr><font class="myred">*</font>企业名称:</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px" class="easyui-validatebox" data-options="required:true" readonly="readonly"/>
							<% if(!"view".equalsIgnoreCase(op)){%>
							<a id="btnselectcom" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search"
							onclick="myselectcom()">选择企业 </a> 
							<%} %>
						</td>
						<td style="text-align:right;" rowspan="4"><nobr>人员照片预览:</nobr></td>
						<td rowspan="5" colspan="1" style="text-align: center;">
						    <div style="width:130;height:160;text-align: center;" id="ryzhaopian_div" >
						    	<img src="<%=contextPath%>/images/default.jpg" name="ryzp" id="ryzp" height="140" width="120"
						    	onclick="g_showBigPic(this.src);"/>
						   	</div>
						   	<a id="btnselectcom" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search"
							onclick="uploadFjView(7)">选择人员照片</a> 
							<input type="hidden" id="ryzppath" name="ryzppath">	
							<input type="hidden" id="ryzpname" name="ryzpname">	
			    		</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr><font class="myred">*</font>人员姓名:</nobr></td>
						<td><input id="ryxm2" name="ryxm" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>
					</tr>					
					<tr>
						<td style="text-align:right;"><nobr><font class="myred">*</font>职务:</nobr></td>
						<td><input id="ryzwgw" name="ryzwgw" style="width: 200px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"/></td>								
					</tr>

					<tr>
					    <td style="text-align:right;"><nobr><font class="myred">*</font>职责:</nobr></td>
						<td><input id="ryzhize" name="ryzhize" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>	
					<tr>	
					    <td style="text-align:right;"><nobr>职称:</nobr></td>
						<td><input id="ryjszc" name="ryjszc" style="width: 200px" class="easyui-combobox"  /></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr><font class="myred">*</font>人员民族:</nobr></td>
						<td><input id="rymz" name="rymz" style="width: 200px" class="easyui-combobox" data-options="validType:'comboboxNoEmpty'"/></td>								

					    <td style="text-align:right;"><nobr>人员性别:</nobr></td>
						<td><input id="ryxb" name="ryxb" style="width: 200px" class="easyui-combobox"  /></td>							
					</tr>
					<tr>
						<td style="text-align:right;"><nobr><font class="myred">*</font>证件类型:</nobr></td>
						<td><input id="ryzjlx" name="ryzjlx" style="width: 200px" class="easyui-combobox" data-options="validType:'comboboxNoEmpty'"/></td>						
						<td style="text-align:right;"><nobr><font class="myred">*</font>证件号码:</nobr></td>
						<td><input id="ryzjh2" name="ryzjh" style="width: 200px" class="easyui-validatebox" data-options="required:true,validType:'idcard'"/></td>		
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>出生日期:</nobr></td>
						<td><input id="rycsrq" name="rycsrq" style="width: 200px"   class="easyui-datebox" data-options="validType:'hengdate'"/></td>			
						<td style="text-align:right;"><nobr>年龄:</nobr></td>
						<td><input id="rynl2" name="rynl" style="width: 200px" class="easyui-validatebox"/></td>									
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr><font class="myred">*</font>联系电话:</nobr></td>
						<td><input id="rylxdh2" name="rylxdh" style="width: 200px" class="easyui-validatebox" data-options="required:true,validType:'mobile'"/></td>											
						<td style="text-align:right;"><nobr>毕业院校:</nobr></td>
						<td><input id="rybyyx2" name="rybyyx" style="width: 200px" class="easyui-validatebox" /></td>								
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>籍贯:</nobr></td>
						<td><input id="ryjg" name="ryjg" style="width: 200px" class="easyui-validatebox"/></td>											
						<td style="text-align:right;"><nobr>在职状态:</nobr></td>
						<td><input id="ryzt" name="ryzt" style="width: 200px" class="easyui-validatebox" /></td>								
					</tr>	
					<tr>	
						<td style="text-align:right;"><nobr>人员通讯地址:</nobr></td>
						<td colspan="3"><input id="rytxdz" name="rytxdz" style="width: 500px" class="easyui-validatebox"/></td>											
					</tr>	
					<tr>	
						<td style="text-align:right;"><nobr>QQ:</nobr></td>
						<td><input id="ryqq" name="ryqq" style="width: 200px" class="easyui-validatebox"/></td>											
						<td style="text-align:right;"><nobr>email:</nobr></td>
						<td><input id="ryemail" name="ryemail" style="width: 200px" class="easyui-validatebox" data-options="validType:'email'"/></td>								
					</tr>														
					<tr>
						<td style="text-align:right;"><nobr>学历:</nobr></td>
						<td><input id="ryxueli" name="ryxueli" style="width: 200px;" class="easyui-combobox" /></td>			
						<td style="text-align:right;"><nobr>专业:</nobr></td>
						<td><input id="ryzhuanye2" name="ryzhuanye" style="width: 200px" class="easyui-validatebox"/></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>开始工作日期:</nobr></td>
						<td><input id="rybeginwork2" name="rybeginwork" style="width: 200px" class="easyui-datebox" data-options="validType:'hengdate'"/></td>					
						<td style="text-align:right;"><nobr>人员类别:</nobr></td>
						<td><input id="rysflb" name="rysflb" style="width: 200px;" class="easyui-combobox" /></td>												
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>人员简介:</nobr></td>
						<td colspan="3">
							<textarea class="easyui-validatebox" id="ryjianjie" name="ryjianjie" style="width: 700px;" 
						 	rows="5" data-options="required:false,validType:'length[0,100]'"></textarea>
						</td>				
					</tr>																
				</table>
	
					
	        </sicp3:groupbox>
	        <sicp3:groupbox title="餐饮相关信息">
	           <table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>健康情况:</nobr></td>
						<td><input id="ryjkqk" name="ryjkqk" style="width: 200px;" class="easyui-combobox" /></td>			
						<td style="text-align:right;"><nobr>培训情况:</nobr></td>
						<td><input id="rypxqk" name="rypxqk" style="width: 200px" class="easyui-combobox"/></td>						
					</tr>	
					<tr>
						<td style="text-align:right;"><nobr>是否食品安全管理员:</nobr></td>
						<td><input id="rysfspaqgly" name="rysfspaqgly" style="width: 200px;" class="easyui-combobox" /></td>			
						<td style="text-align:right;"><nobr>是否监督公示人员:</nobr></td>
						<td><input id="rysfjdgsry" name="rysfjdgsry" style="width: 200px" class="easyui-combobox"/></td>						
					</tr>	
					<tr>
						<td style="text-align:right;"><nobr>人员健康证号:</nobr></td>
						<td colspan="3"><input id="ryjkzh" name="ryjkzh" style="width: 200px" class="easyui-validatebox"/></td>	
					</tr>	
					<tr>
						<td style="text-align:right;"><nobr>健康证发证日期:</nobr></td>
						<td><input id="ryjkzfzrq" name="ryjkzfzrq" style="width: 200px" class="easyui-datebox" data-options="validType:'hengdate'"/></td>	
						<td style="text-align:right;"><nobr>健康证有效截止日期:</nobr></td>
						<td><input id="ryjkzyxjzrq" name="ryjkzyxjzrq" style="width: 200px" class="easyui-datebox" data-options="validType:'hengdate'"/></td>								
					</tr>
        			<tr>
						<td style="text-align:right;"><nobr>人员健康证:</nobr></td>
						<td style="text-align: center;">
						    <div style="width:130;height:160;" id="ryjkz_div">
						    	<img src="<%=contextPath%>/images/default.jpg" name="ryjkz" id="ryjkz" 
						    	height="140" width="160" onclick="g_showBigPic(this.src);"/>
						   	</div>
							<a id="btnselectcom" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search"
							onclick="uploadFjView(5)">选择健康证 </a> 
							<input type="hidden" id="ryjkzpath" name="ryjkzpath">	
							<input type="hidden" id="ryjkzname" name="ryjkzname">					   	
						</td>
						<td style="text-align:right;" rowspan="4"><nobr>人员培训证:</nobr></td>
						<td style="text-align: center;">
						    <div style="width:130;height:160;" id="rypxz_div">
						    	<img src="<%=contextPath%>/images/default.jpg" name="rypxz" id="rypxz" 
						    	height="140" width="160" onclick="g_showBigPic(this.src);"/>
						   	</div>
							<a id="btnselectcom" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search"
							onclick="uploadFjView(6)">选择培训证 </a> 	
							<input type="hidden" id="rypxzpath" name="rypxzpath">	
							<input type="hidden" id="rypxzname" name="rypxzname">													   	
			    		</td>
					</tr>					
				</table>			          
	        </sicp3:groupbox>
	        <sicp3:groupbox title="药品相关信息">
	            <table class="table" style="width: 99%;">
	               <tr>
					<td style="text-align:right;"><nobr>是否职业药师:</nobr></td>
					<td><input id="rysfzyys" name="rysfzyys" style="width: 200px" class="easyui-combobox"/></td>
					<td style="text-align:right;"><nobr>执业药师注册编号:</nobr></td>
					<td><input id="ryzyyszcbh2" name="ryzyyszcbh" style="width: 200px" class="easyui-validatebox" /></td>						               
	               </tr>
	               <tr>
					<td style="text-align:right;"><nobr>职业药师注册日期:</nobr></td>
					<td><input id="ryzyyszcrq2" name="ryzyyszcrq" style="width: 200px" class="easyui-datebox" data-options="validType:'hengdate'"/></td>
					<td style="text-align:right;"><nobr>职业药师证书有效期至:</nobr></td>
					<td><input id="ryzyyszsyxqz2" name="ryzyyszsyxqz" style="width: 200px" class="easyui-datebox" data-options="validType:'hengdate'"/></td>							               
	               </tr>
	            </table>
	        </sicp3:groupbox>	    
	        <sicp3:groupbox title="其它信息">
	            <table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>从业资格类别:</nobr></td>
					<td><input id="rycyzglb2" name="rycyzglb" style="width: 200px" class="easyui-validatebox"/></td>	
					<td style="text-align:right;"><nobr>资格证书编号:</nobr></td>
					<td><input id="ryzgzsbh2" name="ryzgzsbh" style="width: 200px" class="easyui-validatebox"/></td>								
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>资格证书发证日期:</nobr></td>
					<td><input id="ryzgzsfzrq2" name="ryzgzsfzrq" style="width: 200px" class="easyui-datebox" data-options="validType:'hengdate'"/></td>
					<td style="text-align:right;"><nobr>从业范围:</nobr></td>
					<td><input id="rycyfw2" name="rycyfw" style="width: 400px" class="easyui-validatebox" data-options="validType:'hengdate'"/></td>													
				</tr>	
				</table>          
	        </sicp3:groupbox>		            
	        
	   </form>
</body>
</html>