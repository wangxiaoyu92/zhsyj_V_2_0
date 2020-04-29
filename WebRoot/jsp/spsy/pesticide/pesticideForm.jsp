<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}  
	String pesticideid = StringHelper.showNull2Empty(request.getParameter("pesticideid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
    Sysuser Vsuer= SysmanageUtil.getSysuser();
    String v_aaz001=Vsuer.getAaz001();
%>
<!DOCTYPE html>
<html>
<head>
<title>农药信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
 <script type="text/javascript"> 
	//保质期单位
	var v_bzqdwmc = <%=SysmanageUtil.getAa10toJsonArray("BZQDWMC")%>;
	//企业产品种类
	var v_zl = <%=SysmanageUtil.getAa10toJsonArray("PESTICIDEZL")%>;
   	$(function(){ 
	  	$('#pesticidebzqdwcode').combobox({
	    	data : v_bzqdwmc,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto',
	        onSelect:function(record){
	        	$("#pesticidebzqdwmc").val(record.text);
	        }
	   });
	   $('#pesticidezl').combobox({
	    	data : v_zl,
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto',
	        onSelect:function(record){
	        	$("#pesticidezl").val(record.text);
	        } 
	    });  
	     //加载
	   	if ($('#pesticideid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'spsy/pesticide/queryPesticide', {
                        pesticideid: $('#pesticideid').val()
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
			url:basePath + 'spsy/pesticide/savePesticide',
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
	function closeWindow($dialog, $pjq){
     	$dialog.dialog('destroy');
 	}
 </script>
</head>
<body>  
    <form id="myfm" name="fr" method="post">
        <input type="hidden"  value="<%=pesticideid%>" id="pesticideid" name="pesticideid" />
        <input type="hidden"  value="<%=v_aaz001%>" id="pesticidecomid" name="pesticidecomid" />
        <sicp3:groupbox title="农药信息">
            <table class="table" style="width: 99%;" >
                <tr>
                    <td class="title" width="15%"></td>
                    <td class="title" width="35%"></td>
                    <td class="title" width="15%"></td>
                    <td class="title" width="35%"></td>
                </tr>
	            <tr>
                    <td class="title" align="right">名称</td>
                    <td align="left">
                        <input type="text" id="pesticidename" name="pesticidename"
                            data-options="required:true" class="easyui-validatebox"  style="width: 200px;"/>
                    </td>
                    <td class="title" align="right">条码</td>
                    <td align="left">
                        <input type="text" id="pesticidesptm" name="pesticidesptm" style="width: 200px;"  />
                    </td>
                </tr>
                <tr>
                     <td class="title" align="right">商标</td>
                     <td align="left">
                        <input type="text" id="pesticidesb" name="pesticidesb" style="width: 200px;" />
                     </td>
                    <td class="title" align="right">品名</td>
                    <td align="left">
                        <input type="text" id="pesticidepm" name="pesticidepm"  style="width: 200px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="title" align="right">保质期</td>
                    <td align="left" colspan="3">
                        <input type="text" id="pesticidebzq" name="pesticidebzq"  class="easyui-numberbox"  />
                        <input id="pesticidebzqdwcode" name="pesticidebzqdwcode" style="width: 200px"/>
                        <input type="hidden" id="pesticidebzqdwmc" name="pesticidebzqdwmc" />
                    </td>
                </tr>
                <tr>
                    <td class="title" align="right">产品标准号</td>
                    <td align="left">
                        <input type="text" id="pesticidecpbzh" name="pesticidecpbzh" style="width: 200px;" />
                    </td>
                     <td class="title" align="right">规格</td>
                     <td align="left">
                        <input type="text" id="pesticidegg" name="pesticidegg" style="width: 200px;" /> 如180g
                     </td>
                </tr>
                <tr>
                     <td class="title" align="right">生产厂家</td>
                     <td align="left">
                        <input type="text" id="pesticidesccj" name="pesticidesccj" style="width: 200px;" />
                     </td>
                    <td class="title" align="right">厂家电话</td>
                    <td align="left">
                        <input type="text" id="pesticidecjdh" name="pesticidecjdh" style="width: 200px;" />
                    </td>
                </tr>
                <tr>
                    <td class="title" align="right">厂家地址</td>
                    <td align="left" colspan="3">
                        <input type="text" id="pesticidecjdz" name="pesticidecjdz" style="width: 580px;" />
                    </td>
                </tr>
                <tr>
                    <td class="title" align="right">产地/基地名称</td>
                    <td align="left" colspan="3">
                        <input type="text" id="pesticidecdjd" name="pesticidecdjd"  style="width: 580px;"/>
                    </td>
                </tr>
                <tr>
                     <td class="title" align="right">配料信息</td>
                     <td align="left" colspan="3">
                        <textarea class="easyui-validatebox" id="pesticideplxx" name="pesticideplxx"
                                  style="width: 580px;" rows="5" data-options="required:false"></textarea>
                     </td>
                </tr>
                <tr>
                     <td class="title" align="right">产品种类</td>
                     <td align="left">
                         <input id="pesticidezl" name="pesticidezl" style="width: 200px"/>
                     </td>
                    <td class="title" align="right">包装规格</td>
                    <td align="left">
                        <input type="text" id="pesticidebzgg" name="pesticidebzgg"  style="width: 200px;"/>
                        如1*12袋
                    </td>
                </tr>
                <tr>
                    <td class="title" align="right">简介</td>
                    <td align="left" colspan="3">
                            <textarea class="easyui-validatebox" id="pesticidejj" name="pesticidejj"
                                      style="width: 580px;" rows="5" data-options="required:false"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="title" align="right">农药适用范围</td>
                    <td align="left" colspan="3">
                        <textarea class="easyui-validatebox" id="pesticidesyfw" name="pesticidesyfw"
                                  style="width: 580px;" rows="5" data-options="required:false"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="title" align="right">农药对应症状</td>
                    <td align="left" colspan="3">
                        <textarea class="easyui-validatebox" id="pesticidedyzz" name="pesticidedyzz"
                                  style="width: 580px;" rows="5" data-options="required:false"></textarea>
                    </td>
                </tr>
            </table>
        </sicp3:groupbox>
    </form>
</body>
</html>