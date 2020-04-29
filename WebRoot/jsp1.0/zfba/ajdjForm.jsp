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
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;
var v_AJDJAJLY = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
var v_zxxmcsbm = <%=SysmanageUtil.getComboZxxmcsbm("1")%>;
var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;


$(function() {
	   v_ajdjajly= $('#ajdjajly').combobox({
	    	data : v_ajdjajly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	   
	    $('#aae140').combobox({
	    	data : v_aae140,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	   
		if ($('#ajdjid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/zfba/ajdj/queryAjdjDTO', {
				ajdjid : $('#ajdjid').val()
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
				//$('#btnselectcom').attr('visible',false);	
				$('#savePhotoWeb').attr('disabled',true);
				$('.Wdate').attr('disabled',true);	
				v_ajdjajly.combobox('disable',true);		
			}
		}
});

	// 保存 
	var submitForm = function() {
		var url = basePath + '/zfba/ajdj/saveAjdj';

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#ajdjAddDlgfm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						 sy.setWinRet("ok");
						 closeWindow(); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};

//从单位信息表中读取
function myselectcom(){
    var url = basePath + 'pub/pub/selectcomIndex';
	var dialog = parent.sy.modalDialog({
			title : '选择企业',
			param : {
				singleSelect : "true",
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 600,
			url : url
	},function(dialogID) {
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
		    for (var k = 0; k <= v_retStr.length - 1; k++){
		      var myrow = v_retStr[k];
		      $("#commc").val(myrow.commc); //公司名称   
		      $("#comdm").val(myrow.comdm); //公司代码 
		      $("#comid").val(myrow.comid); //公司id
		      $("#comdz").val(myrow.comdz); //企业地址 
		      $("#comfrhyz").val(myrow.comfrhyz); //法人/业主 
		      $("#comfrsfzh").val(myrow.comfrsfzh); //法人/业主身份证号 
		      $("#comyzbm").val(myrow.comyzbm); //邮政编码
		      $("#comyddh").val(myrow.comyddh); //电话号码    
		    }
		}
	    sy.removeWinRet(dialogID);//不可缺少
	});
}

//从单位信息表中读取
function myselectay(){
    var url = basePath + 'pub/pub/selectayIndex';
	var dialog = parent.sy.modalDialog({
			title : '选择案由',
			param : {
				singleSelect : "true",
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 600,
			url : url
	},function(dialogID) {
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
		    for (var k = 0; k <= v_retStr.length - 1; k++){
				var myrow = v_retStr[k];
		      	$("#ajdjay").val(myrow.wfxwms); // 案件登记案由   
	      		$("#wfxwbh").val(myrow.wfxwbh); // 违法行为编号         
		    }
		}
	    sy.removeWinRet(dialogID);//不可缺少
	});
}

// 关闭窗口
function closeWindow(){
   	parent.$("#"+sy.getDialogId()).dialog("close");
};

</script>
</head>
<body>
    
		<form id="ajdjAddDlgfm" name="ajdjAddDlgfm" method="post">
		  <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
        		<table class="table" style="width: 900px;">
        		   <tr>
        		     <td width="15%"></td>
        		     <td width="35%"></td>
        		     <td width="15%"></td>
        		     <td width="35%"></td>
        		   </tr>
					<tr>
						<td style="text-align:right;"><nobr>案件来源登记表编号:</nobr></td>
						<td><input id="ajdjbh" name="ajdjbh" style="width: 200px;" class="easyui-validatebox" 
						data-options="required:true,validType:'length[0,30]'" value="()食药监食案源(2016) 号"/></td>						
						<td style="text-align:right;"><nobr>企业id:</nobr></td>
						<td><input id="comid" name="comid" style="width: 150px;" readonly="readonly" class="easyui-validatebox" 
						data-options="required:true, validType:'length[0,50]'" />
						<% if(!"view".equalsIgnoreCase(op)){%>
							<a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>	
								<%} %>						
						</td>						
					</tr>
					<tr>
						<td style="text-align:right;" ><nobr>当事人名称:</nobr></td>
						<td colspan="3"><input id="commc" name="commc" style="width: 580px" class="easyui-validatebox" 
						data-options="required:true,validType:'length[0,200]'"/></td>		
					</tr>					
					<tr>
						<td style="text-align:right;"><nobr>地址:</nobr></td>
						<td colspan="3"><input id="comdz" name="comdz" style="width: 580px" class="easyui-validatebox" 
						data-options="required:false,validType:'length[0,200]'"/></td>		
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>法人/业主:</nobr></td>
						<td><input id="comfrhyz" name="comfrhyz" style="width: 200px" class="easyui-validatebox" 
						data-options="required:false,validType:'length[0,20]'" /></td>						
						<td style="text-align:right;"><nobr>法人/业主身份证号:</nobr></td>
						<td><input id="comfrsfzh" name="comfrsfzh" style="width: 200px" class="easyui-validatebox" 
						data-options="required:false,validType:'length[0,20]'"/></td>			
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>联系电话:</nobr></td>
						<td><input id="comyddh" name="comyddh" style="width: 200px" class="easyui-validatebox" data-options="required:false,validType:['length[0,20]','phoneAndMobile']" /></td>									
						<td style="text-align:right;"><nobr>邮政编码:</nobr></td>
						<td><input id="comyzbm" name="comyzbm" style="width: 200px" class="easyui-validatebox"  data-options="validType:['integer','zip','length[0,6]']" /></td>			
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>登记时间:</nobr></td>
						<td><input id="ajdjafsj" name="ajdjafsj" style="width: 200px" class="easyui-datetimebox"  data-options="required:true"/></td>
						<td style="text-align:right;"><nobr> 案件大类:</nobr></td>
						<td><input id="aae140" name="aae140" style="width: 200px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>									
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr> 案件来源:</nobr></td>
						<td><input id="ajdjajly" name="ajdjajly" style="width: 200px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>
															
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>案由:</nobr></td>
						<td colspan="3">
							<textarea class="easyui-validatebox" id="ajdjay" name="ajdjay" style="width: 580px;" 
						 	rows="5" data-options="required:false,validType:'length[0,100]'"></textarea>
					 		<% if(!"view".equalsIgnoreCase(op)){%>
								<a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectay()">选择案由</a>	
							<%} %>	
						</td>
					</tr>	
					<!-- <tr style="display: none;">	
						<td style="text-align:right;"><nobr>违法行为编号:</nobr></td>
						<td><input id="wfxwbh" name="wfxwbh" style="width: 200px" class="easyui-validatebox" 
						data-options="required:false,validType:'length[0,20]'" /></td>
					</tr>	 -->			
					<tr>						
						<td style="text-align:right;">案件基本情况介绍(负责人、案发时间、地点、重要证据、危害后果及其影响等):</td>
						<td colspan="3">
							<textarea class="easyui-validatebox" id="ajdjjbqk" name="ajdjjbqk" style="width: 580px;" 
							 rows="5" data-options="required:false"></textarea>
						</td>			
					</tr>
					<tr>						
						<td style="text-align:right;">违法事实:</td>
						<td colspan="3">
							<textarea class="easyui-validatebox" id="ajdjwfss" name="ajdjwfss" style="width: 580px;" 
							 rows="5" data-options="required:false"></textarea>
						</td>			
					</tr>						
					
					   <%-- 
					<tr>
					  <td colspan="4" style="height: 50px;" >
					    <div align="right">
					    <% if(!"view".equalsIgnoreCase(op)){%>
						<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-save" onclick="submitForm();"> 保存 </a>	
								&nbsp;&nbsp;&nbsp;&nbsp;
						<%} %>			
						<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-back" onclick="javascript:window.close();"> 取消 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
						</div> 
					  </td>
					</tr>									
						--%>														     
				</table>
	   </form>

</body>
</html>