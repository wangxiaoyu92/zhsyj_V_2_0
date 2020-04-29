<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}  
	String proid = StringHelper.showNull2Empty(request.getParameter("proid")); 
	String op = StringHelper.showNull2Empty(request.getParameter("op")); 
	String cphyclbz = StringHelper.showNull2Empty(request.getParameter("cphyclbz"));
%>
<!DOCTYPE html>
<html>
<head>
<title>产品信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
 <script type="text/javascript"> 
	//保质期单位
	var v_bzqdwmc = <%=SysmanageUtil.getAa10toJsonArray("BZQDWMC")%>;
	//企业产品种类
	var v_prozl = <%=SysmanageUtil.getAa10toJsonArray("prozl")%>;
   	$(function(){ 
		//自动加载日期单位 
	  	$('#cate').combobox({
	    	data : v_bzqdwmc,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto',
	        onSelect:function(record){
	        	$("#probzqdwmc").val(record.text);
	        }
	   });
	   $('#prozl').combobox({
	    	data : v_prozl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto',
	        onSelect:function(record){
	        	$("#prozl").val(record.text);
	        } 
	    });  
	     //加载
	   	if ($('#proid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'spsy/productin/queryProductinDTO', {
				proid: $('#proid').val()
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
				$('input').attr('disabled','true');
			}
		}  
	});
	    
	var submitForm = function($dialog, $mytab, $pjq) {
		$pjq.messager.progress();	// 显示进度条 
		$('#myfm').form('submit',{
			url:basePath + 'spsy/productin/addProductin',
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
	        			$mytab.datagrid('load');
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
</head>
<body>  
 <form id="myfm" name="fr" method="post"> 
  <input type="hidden"  value="<%=proid%>" id="proid" name="proid" /> 
  <input type="hidden"  value="<%=cphyclbz%>" id="cphyclbz" name="cphyclbz" />
  <sicp3:groupbox title="产品或原材料信息">
   <table class="table" style="width: 99%;" >
	<tr>
         <td class="title" width="15%">产品名称</td>
         <td align="left" colspan="3" >
         <input type="text" id="proname" name="proname"
                data-options="required:true" class="easyui-validatebox"  style="width: 580px;"/>
         </td>
    </tr>
    <tr>
         <td class="title">商品条码</td>
         <td align="left" colspan="3">
         <input type="text" id="prosptm" name="prosptm" style="width: 580px;"  />
         </td>    
    </tr>
    <tr>
         <td class="title">商标</td>
         <td align="left" colspan="3">
         <input type="text" id="prosb" name="prosb" style="width: 580px;" />
         </td>
    </tr>
    <tr>
         <td class="title">规格</td>
         <td align="left" colspan="3">
         <input type="text" id="progg" name="progg" style="width: 580px;" />
                       如180g
         </td>    
    </tr>
    <tr>
         <td class="title">价格</td>
         <td align="left" colspan="3">
         <input type="text" id="proprice" name="proprice" style="width: 580px;" />
                       如 88元/瓶
         </td>    
    </tr>    
    <tr>
         <td class="title">生产厂家</td>
         <td align="left" colspan="3">
         <input type="text" id="prosccj" name="prosccj" style="width: 580px;" />
         </td>
    </tr>
    <tr>
         <td class="title">品名</td>
         <td align="left" colspan="3">
         <input type="text" id="propm" name="propm"  style="width: 580px;"/>
         </td>    
    </tr>
    <tr>
         <td class="title">保质期</td>
         <td align="left">
         <input type="text" id="probzq" name="probzq"  class="easyui-numberbox"  />
         <select id="cate" class="easyui-combobox "  name="probzqdwcode" style="width:100px;"  ></select>
         <input type="hidden" id="probzqdwmc" name="probzqdwmc" />
         </td>
    </tr>
    <tr>
         <td class="title">产地/基地名称</td>
         <td align="left" colspan="3">
            <input type="text" id="procdjd" name="procdjd"  style="width: 580px;"/>
         </td>    
    </tr>
    <tr>
         <td class="title">配料信息</td>
         <td align="left" colspan="3">
			<textarea class="easyui-validatebox" id="proplxx" name="proplxx" style="width: 580px;" 
			 rows="5" data-options="required:false"></textarea>         
         </td>
    </tr>
    <tr>
         <td class="title">包装规格</td>
         <td align="left" colspan="3">
         <input type="text" id="probzgg" name="probzgg"  style="width: 580px;"/>
                       如1*12袋
         </td>    
    </tr>
    <tr>
         <td class="title">产品标准号</td>
         <td align="left" colspan="3">
         <input type="text" id="procpbzh" name="procpbzh" style="width: 580px;" />
        
         </td>
    </tr>
    <tr>
         <td class="title">产品种类</td>
         <td align="left" colspan="3">
         <select id="prozl" name="prozl" style="width:120px;" class="easyui-combobox "
                 data-options="required:true"></select>
         </td>    
    </tr>
    <tr>
         <td class="title">产品溯源码</td>
         <td align="left" colspan="3">
         <input type="text" id="progtin14" name="progtin14" style="width: 580px;"/>
         </td>
    </tr>
    <tr>
         <td class="title">包装溯源码</td>
         <td align="left" colspan="3">
         <input type="text" id="bzgtin14" name="bzgtin14" style="width: 580px;"/>
         </td>    
    </tr>
    <tr>
         <td class="title">简介</td>
         <td align="left" colspan="3">
			<textarea class="easyui-validatebox" id="projj" name="projj" style="width: 580px;" 
			 rows="5" data-options="required:false"></textarea>         
         </td>
    </tr>  
   </table>
 </sicp3:groupbox>
 </form>  
</body>
</html>