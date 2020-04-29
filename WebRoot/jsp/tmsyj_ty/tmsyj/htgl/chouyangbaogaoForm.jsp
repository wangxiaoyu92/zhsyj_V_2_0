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
    String v_hjdjccybgid=StringHelper.showNull2Empty(request.getParameter("hjdjccybgid")); //进出库表主键
	String v_title="抽样报告 管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="抽样报告 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="抽样报告 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="抽样报告 查看";
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
		if ($('#hjdjccybgid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmsyjhtgl/queryChouyangbaogaoDTO', {
				hjdjccybgid : $('#hjdjccybgid').val()
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
		var url='<%=basePath%>/tmsyjhtgl/saveChouyangbaogao';
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
	//选择商品
	function myselectShangpin(){
		var obj = new Object();
		obj.singleSelect="true";
		var v_spsjlx="0";//商品数据类型0商品1产品2原材料 生产企业只查原材料
		var v_querykind="0"; //查询数据类型 空或0 不加其他条件 为1 加只查本企业商品
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectShangpinIndex?spsjlx="+v_spsjlx+"&querykind="+v_querykind+"&a="+new Date().getMilliseconds(),obj,
	        860,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      $("#jcypid").val(myrow.jcypid); //公司名称   
		      $("#jcypmc").val(myrow.jcypmc); //公司代码 
		      
		    }      
	    }
	}	
	
	// 选择商品
	var myselectShangpinBase = function() {
		var v_singleSelect="true";
		var v_spsjlx="0";//商品数据类型0商品1产品2原材料 生产企业只查原材料
		var v_querykind="0"; //查询数据类型 空或0 不加其他条件 为1 加只查本企业商品		
	    var dialog = parent.sy.modalDialog({
			title : '选择商品',
			width : 860,
			height : 460,
			url : basePath + 'pub/pub/selectShangpinIndex?spsjlx='+v_spsjlx+'&querykind='+v_querykind+'&singleSelect='+v_singleSelect+'&a='+new Date().getMilliseconds(),
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.queding(dialog);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
				}
			} ]
		},closeModalDialogCallback);
	};
	
	function closeModalDialogCallback(dialogID){	
		var v_retValue = sy.getWinRet(dialogID);
	    if (v_retValue != null && v_retValue.length > 0) {
		    for (var k=0;k<=v_retValue.length-1;k++){
		      var myrow = v_retValue[k];
		      $("#jcypid").val(myrow.jcypid); //公司名称   
		      $("#jcypmc").val(myrow.jcypmc); //公司代码      
		    }      
	    }
	    sy.removeWinRet(dialogID);//不可缺少						
	}
	
	
	//监管主体 prm_jgztlx监管主体类型 1企业2商户3供应商4生产商5经销商
	function myselectJianGuanZhuTi(prm_jgztlx){ 
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectJianGuanZhuTiIndex?selfwnfww=1&jgztlx="+prm_jgztlx+"&a="+new Date().getMilliseconds(),obj,
		        1000,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];//监管主体表3供应商4生产商5经销商
		      $("#hviewjgztid").val(myrow.hviewjgztid); //  
		      $("#jgztmc").val(myrow.jgztmc); //	    	  
		    }      
	    }
	}	
	
	//监管主体 prm_jgztlx监管主体类型 1企业2商户3供应商4生产商5经销商
	function myselectJianGuanZhuTiBase(prm_jgztlx) {
		var v_singleSelect="true";
	    var dialog = parent.sy.modalDialog({
			title : '选择单位',
			width : 1000,
			height : 460,
			url : basePath + 'pub/pub/selectJianGuanZhuTiIndex?singleSelect='+v_singleSelect+'&selfwnfww=1&jgztlx='+prm_jgztlx+'&a='+new Date().getMilliseconds(),
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.queding(dialog);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
				}
			} ]
		},closeModalDialogCallbackZhuti);
	};
	
	function closeModalDialogCallbackZhuti(dialogID){	
		var obj = sy.getWinRet(dialogID);
		var v_jgztlx = obj.jgztlx;
		var v_retValue = obj.retValue;
		
	    if (v_retValue != null && v_retValue.length > 0) {
		    for (var k=0;k<=v_retValue.length-1;k++){
			      var myrow=v_retValue[k];//监管主体表3供应商4生产商5经销商
			      $("#hviewjgztid").val(myrow.hviewjgztid); //  
			      $("#jgztmc").val(myrow.jgztmc); //    
		    }      
	    }
	    sy.removeWinRet(dialogID);//不可缺少						
	}
	
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
	  <input type="hidden" id="hjdjccybgid" name="hjdjccybgid" value="<%=v_hjdjccybgid %>">
	  <input type="hidden" id="aae011" name="aae011">
	  <input type="hidden" id="aae036" name="aae036">
        
      <table class="table" style="width:100%;height: 99%">
        <tr>
			<td width="30%" style="text-align:right;"><nobr>监督抽样时间:</nobr>
			</td>
			<td width="70%">
			<input id="jdcysj" name="jdcysj" style="width: 260px" 
			class="easyui-datetimebox" data-options="required:true"/>
			</td>  			 			      
        </tr>        
        <tr>
			<td width="30%" style="text-align:right;"><nobr>请选择单位:</nobr>
			</td>
			<td width="70%">
			<input type="hidden" id="hviewjgztid" name="hviewjgztid"> 
			<input id="jgztmc" name="jgztmc" readonly="readonly" style="width: 260px" 
			class="easyui-validatebox" data-options="required:false"/>
		    <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectJianGuanZhuTiBase(999)">选择</a>	
				<%} %>				
			</td>  
        </tr> 
              
        <tr>
          <td width="30%" style="text-align:right;"><nobr><font class="myred">
           *</font>商品:</nobr>
           </td>
		  <td width="70%">
		  <input type="hidden" id="jcypid" name="jcypid">
		  <input id="jcypmc" name="jcypmc" readonly="readonly" style="width: 260px" 
			  class="easyui-validatebox" data-options="required:true" />
		  <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectShangpinBase()">选择 </a>	
			<%} %>				  
		  </td>   
        </tr>
        <tr>
			<td width="30%" style="text-align:right;"><nobr>任务来源:</nobr>
			</td>
			<td width="70%">
			<input id="rwly" name="rwly" style="width: 260px" 
			class="easyui-validatebox" />
			</td>     
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>抽样人:</nobr>
			</td>
			<td>
			<input id="cyr" name="cyr"  style="width: 260px" 
			class="easyui-validatebox" data-options="required:true"/>
			</td>  
        </tr>         
        <tr>
			<td style="text-align:right;"><nobr>抽样单位:</nobr>
			</td>
			<td>
			<input id="cydw" name="cydw" style="width: 260px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td> 
        </tr>
      </table> 
      </form>
    </div>
    
</div>
</body>
</html>