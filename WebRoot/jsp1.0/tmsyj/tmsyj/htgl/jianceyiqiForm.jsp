<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
    String v_hjcjgjcyqbid=StringHelper.showNull2Empty(request.getParameter("hjcjgjcyqbid")); //进出库表主键
	String v_title="检测仪器 管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="检测仪器 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="检测仪器 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="检测仪器 查看";
	}	
%>
<!DOCTYPE html>
<html>
<head>
<title><%=v_title %>></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	
	$(function() {
		if ($('#hjcjgjcyqbid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmsyjhtgl/queryJianceyiqiDTO', {
				hjcjgjcyqbid : $('#hjcjgjcyqbid').val()
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
		};	
		
		if('<%=op%>' == 'view'){	
			$('form :input').addClass('input_readonly');
			$('form :input').attr('readonly','readonly');				
			$('.Wdate').attr('disabled',true);	
			$("#btnselectHgzmpic").css('display','none');
			$("#btnselectHgzmpic").linkbutton("disable");
			$("#jhscrq").datebox({disabled:true});
			$("a").each(function(index,object){
				object.removeAttribute("onclick");
			});
		}		
		
	});/////////////////////////////////////////
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url='<%=basePath%>/tmsyjhtgl/saveJianceyiqi';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#myform').form('submit',{
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
	
	</script>
</head>

<body>
<div id="cc" class="easyui-layout" fit=true>
    <div data-options="region:'north'"
         style="height:40px;text-align:center;"  >
         <font style="font-size:200%;text-align:right;color: green;"><%=v_title%></font>
    </div>
    
    <div data-options="region:'center'"  fit=true>   
    <form  id="myform" method="post">    
	  <input type="hidden" id="hjcjgjcyqbid" name="hjcjgjcyqbid" value="<%=v_hjcjgjcyqbid %>">
	  <input type="hidden" id="hviewjgztid" name="hviewjgztid">
	  <input type="hidden" id="aae011" name="aae011">
	  <input type="hidden" id="aae036" name="aae036">
        
      <table class="table" style="width:100%;height: 99%">
        <tr>
          <td width="13%" style="text-align:right;"><nobr><font class="myred">
           *</font>检测仪器名称:</nobr>
           </td>
		  <td width="37%">
		  <input id="jcyqmc" name="jcyqmc"  style="width: 200px" 
			  class="easyui-validatebox" data-options="required:true" />
		  </td>   
          <td width="13%" style="text-align:right;"><nobr><font class="myred">
           *</font>检测仪器型号:</nobr>
           </td>
		  <td width="37%">
		  <input id="jcyqxh" name="jcyqxh" style="width: 200px" 
			  class="easyui-validatebox" data-options="required:true" />
		  </td>  		         
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>检测仪器序列号:</nobr>
			</td>
			<td colspan="3">
			<input id="jcyqxlh" name="jcyqxlh" style="width: 200px" 
			class="easyui-validatebox" data-options="required:true"/>
			</td>     
		   
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>检测仪器购买日期:</nobr>
			</td>
			<td>
			<input id="jcyqgmrq" name="jcyqgmrq" style="width: 200px" 
			class="easyui-datebox" data-options="required:true"/>
			</td> 	
			<td style="text-align:right;"><nobr>检测仪器生产日期:</nobr>
			</td>
			<td>
			<input id="jcyqscrq" name="jcyqscrq" style="width: 200px" 
			class="easyui-datebox" data-options="required:false"/>
			</td>  			 			      
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>检测仪器生产厂家:</nobr>
			</td>
			<td colspan="3">
			<input id="jcyqsccj" name="jcyqsccj"  style="width: 500px" 
			class="easyui-validatebox" data-options="required:true"/>
			</td>  
        </tr>         
        <tr>
			<td style="text-align:right;"><nobr>检测仪器检测项目:</nobr>
			</td>
			<td colspan="3">
				<textarea class="easyui-validatebox" id="jcyqjcxm" name="jcyqjcxm" style="width: 580px;" 
			 	rows="5" data-options="required:false,validType:'length[0,1000]'"></textarea>
			</td> 
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>检测仪器产品用途:</nobr>
			</td>
			<td colspan="3">
				<textarea class="easyui-validatebox" id="jcyqcpyt" name="jcyqcpyt" style="width: 580px;" 
			 	rows="5" data-options="required:false,validType:'length[0,500]'"></textarea>
			</td> 
        </tr>
      </table> 
      </form>
    </div>
    
</div>
</body>
</html>