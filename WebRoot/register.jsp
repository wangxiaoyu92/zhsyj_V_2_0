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
<title>企业信息注册</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	//企业大类
	var comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
	var cb_comdalei2;
	$(function() {
		//企业类别：添加
		cb_comdalei2 = $('#comdalei2').combobox({
			data:comdalei,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight:'auto'
		});
	}); 

	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 保存企业信息
	function savePcompany() {
		$('#fm').form('submit',{
			url: basePath + 'pcompany/savePcompany',
			onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
	        		$.messager.alert('提示','保存成功！','info',function(){
	        			$('#dlg').dialog('close');
						$('#grid').datagrid('reload');  
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	} 
	
	
	// 保存授权
	function saveSysuserRole() {
		var row = grid.datagrid('getSelected'); 
		var rows = grid3.datagrid("getRows");
		if(rows.length>0){
			var JsonStr = $.toJSON(rows);//zjf
			var param = {
				'JsonStr' : JsonStr,
				'userid' : row.userid
			};  
			$.post(basePath + 'sysmanager/sysuser/saveSysuserRole', param, function(result) {
				if (result.code=='0'){
	        		$.messager.alert('提示','用户授权成功！','info',function(){
	        			$('#dlg2').dialog('close'); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','用户授权失败：'+result.msg,'error');
                }
			}, 'json');
		}
	}
</script>
</head>
<body>
<div class="easyui-layout" fit="true">   
        <div region="center" style="overflow: hidden;" border="false">
	<div id="pcomhead" align="center" style="font-size: 24px">企业信息注册</div>
		<form id="fm" method="post">
        	<table class="table" style="width: 99%;" align="center">
        			<tr>
						<td style="text-align:right;"><nobr>登录用户名:</nobr></td>
						<td><input id="username2" name="username" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>企业代码:</nobr></td>
						<td><input id="comdm2" name="comdm" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>		
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>企业名称:</nobr></td>
						<td><input id="commc2" name="commc" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>企业分类:</nobr></td>
						<td><input id="comdalei2" name="comdalei" style="width: 200px" class="easyui-combobox" data-options="validType:'comboboxNoEmpty'" /></td>						
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>许可证编号:</nobr></td>
						<td><input id="comxkzbh2" name="comxkzbh" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>			
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>企业法人/业主:</nobr></td>
						<td><input id="comfrhyz2" name="comfrhyz" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>									
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>法人/业主身份证号:</nobr></td>
						<td><input id="comfrsfzh2" name="comfrsfzh" style="width: 200px" class="easyui-validatebox"  data-options="required:true" /></td>			
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>法人/业主性别:</nobr></td>
						<td><input id="comfrxb2" name="comfrxb" style="width: 200px" class="easyui-validatebox"  data-options="required:true" /></td>			
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>法人/业主职务:</nobr></td>
						<td><input id="comfrzw2" name="comfrzw" style="width: 200px" class="easyui-validatebox"  data-options="required:true" /></td>			
					</tr>
					<tr>
					    <td style="text-align:right;"><nobr>企业负责人:</nobr></td>
						<td><input id="comfzr2" name="comfzr" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>固定电话:</nobr></td>
						<td><input id="comgddh2" name="comgddh" style="width: 200px" class="easyui-validatebox" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>移动电话:</nobr></td>
						<td><input id="comyddh2" name="comyddh" style="width: 200px" class="easyui-validatebox" data-options="required:true,validType:'mobile'" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>电子邮箱:</nobr></td>
						<td><input id="comemail2" name="comemail" style="width: 200px" class="easyui-validatebox" data-options="required:true,validType:'email'"/></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>企业地址:</nobr></td>
						<td><input id="comdz2" name="comdz" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>许可范围:</nobr></td>
						<td><input id="comxkfw2" name="comxkfw" style="width: 200px" class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>许可有效期始:</nobr></td>
						<td><input id="comxkyxqq2" name="comxkyxqq" style="width: 200px" class="easyui-datebox" required="required"/></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>许可有效期止:</nobr></td>
						<td><input id="comxkyxqz2" name="comxkyxqz" style="width: 200px" class="easyui-datebox" required="required"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>餐厅面积:</nobr></td>
						<td><input id="comctmj2" name="comctmj" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>厨房面积:</nobr></td>
						<td><input id="comcfmj2" name="comcfmj" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>总面积:</nobr></td>
						<td><input id="comzmj2" name="comzmj" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>就餐人数:</nobr></td>
						<td><input id="comjcrs2" name="comjcrs" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>从业人数:</nobr></td>
						<td><input id="comcyrs2" name="comcyrs" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>持健康证人数:</nobr></td>
						<td><input id="comcjkzrs2" name="comcjkzrs" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>专/兼职管理人员数:</nobr></td>
						<td><input id="comzjzglrs2" name="comzjzglrs" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>企业小类:</nobr></td>
						<td><input id="comxiaolei2" name="comxiaolei" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>店面类型:</nobr></td>
						<td><input id="comdmlx2" name="comdmlx" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>所在地区:</nobr></td>
						<td>
							<input id="comshengdm2" name="comshengdm" style="width: 70px" class="easyui-combobox" required="required"/>
							<input id="comshidm2" name="comshidm" style="width: 70px" class="easyui-combobox" required="required"/>
							<input id="comxiandm2" name="comxiandm" style="width: 70px" class="easyui-combobox" required="required"/>
							<!-- <input id="comxiangdm2" name="comxiangdm" style="width: 70px" class="easyui-combobox" required="required"/>
							<input id="comcundm2" name="comcundm" style="width: 70px" class="easyui-combobox" required="required"/> -->
						</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>特色菜系:</nobr></td>
						<td><input id="comtscx2" name="comtscx" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>特色菜:</nobr></td>
						<td><input id="comtsc2" name="comtsc" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>资质证明:</nobr></td>
						<td><input id="comzzzm2" name="comzzzm" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>资质证明编号:</nobr></td>
						<td><input id="comzzzmbh2" name="comzzzmbh" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>组织机构代码:</nobr></td>
						<td><input id="comzzjgdm2" name="comzzjgdm" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>企业成立日期:</nobr></td>
						<td><input id="comclrq2" name="comclrq" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>注册资金(万元):</nobr></td>
						<td><input id="comzczj2" name="comzczj" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>								
					</tr>
				</table>
				<td><input id="userid2" name="comid" type="hidden" style="width: 200px;" readonly="readonly" class="input_readonly" /></td>						
	   </form>	
	   <div id="dlg-buttons" align="center">
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="savePcompany();">注册</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
	</div>
	</div>
</body>
</html>
