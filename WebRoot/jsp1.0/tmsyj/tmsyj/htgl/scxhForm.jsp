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
    String v_hscxhbid=StringHelper.showNull2Empty(request.getParameter("hscxhbid")); //进出库表主键
	String v_title="生产销货 管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="生产销货 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="生产销货 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="生产销货 查看";
	};
	
%>
<!DOCTYPE html>
<html>
<head>
<title><%=v_title %>></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//食品计量单位
	var v_xhspjldw = <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
	$(function() {
		// 计量单位
		 $('#xhspjldw').combobox({
			data:v_xhspjldw,
			valueField:'id',
			textField:'text',
			edittable:false,
			panelHeight : '200' 
		});		
		if ($('#hscxhbid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmsyjhtgl/queryScxhDTO', {
				hscxhbid : $('#hscxhbid').val()
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
			$("#spjldw").combobox('disable',true);	
			$("#jcfs").combobox('disable',true);
			$("#jhscjyjl").combobox('disable',true);
			$("#jhqycyjl").combobox('disable',true);
			$("#jhhgzmlx").combobox('disable',true);
			$("#btnselectHgzmpic").css('display','none');
			$("#btnselectHgzmpic").linkbutton("disable");
			$("#jhscrq").datebox({disabled:true});
			$("a").each(function(index,object){
				object.removeAttribute("onclick");

			});
			$("#td[name='btntd']").hide();
		}		
		if('<%=op%>' == 'add'){
			$('#xssj').datetimebox('setValue', g_formatterDate(new Date()));
		}
		
	});/////////////////////////////////////////
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url='<%=basePath%>/tmsyjhtgl/saveScxh';
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
	
	//监管主体 prm_jgztlx监管主体类型 1企业2商户3供应商4生产商5经销商
	function myselectJianGuanZhuTi(prm_jgztlx){ 
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectJianGuanZhuTiIndex?selfwnfww=2&qykind=scqy&jgztlx="+prm_jgztlx+"&a="+new Date().getMilliseconds(),obj,
		        1000,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];//监管主体表3供应商4生产商5经销商
		      if (prm_jgztlx=='5'){//经销商
			      $("#jxsid").val(myrow.hviewjgztid); //  
			      $("#jxsmc").val(myrow.jgztmc); //	    	  
		      }
		    }      
	    }
	}	
	
	//监管主体 prm_jgztlx监管主体类型 1企业2商户3供应商4生产商5经销商
	function myselectJianGuanZhuTiBase(prm_jgztlx) {
		var v_singleSelect="true";
		var v_title='企业';
		if (prm_jgztlx=='2'){
			v_title='商户';
		}else if (prm_jgztlx=='3'){
			v_title='供应商';
		}else if (prm_jgztlx=='4'){
			v_title='生产商';
		}else if (prm_jgztlx=='5'){
			v_title='经销商';
		};
		
	    var dialog = parent.sy.modalDialog({
			title : v_title,
			width : 1060,
			height : 460,
			url : basePath + 'pub/pub/selectJianGuanZhuTiIndex?singleSelect='+v_singleSelect+'&selfwnfww=2&qykind=scqy&jgztlx='+prm_jgztlx+'&a='+new Date().getMilliseconds(),
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
		},function(dialogID){
			var obj = sy.getWinRet(dialogID);
			var v_retValue = obj.retValue;
			//var v_jgztlx = sy.getWinRet("jgztlx");
		    if (v_retValue != null && v_retValue.length > 0) {
			    for (var k=0;k<=v_retValue.length-1;k++){
				      var myrow=v_retValue[k];//监管主体表3供应商4生产商5经销商
				      if (prm_jgztlx=='5'){//经销商
					      $("#jxsid").val(myrow.hviewjgztid); //  
					      $("#jxsmc").val(myrow.jgztmc); //	    	    	  
				      }    
			    }      
		    }
		    sy.removeWinRet(dialogID);//不可缺少			
		});
	};
	
	//从生产批次表读取
	function myselectScpc(){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>tmsyjhtgl/selectScpcIndex?a="+new Date().getMilliseconds(),obj,
	        860,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      $("#hscpcbid").val(myrow.hscpcbid); //对应的进货表id
		      $("#jcypid").val(myrow.jcypid); //商品id
		      $("#jcypmc").val(myrow.jcypmc); //商品名称
		      $("#sysl").val(myrow.sysl); //库存量
		      $("#scspjldwmc").val(myrow.scspjldwmc); //库存量
		    }      
	    }
	}	
	
	//从生产批次表读取
	function myselectScpcBase(prm_jgztlx) {
		var v_singleSelect="true";
	    var dialog = parent.sy.modalDialog({
			title : '生产批次',
			width : 900,
			height : 460,
			url : basePath + 'tmsyjhtgl/selectScpcIndex?singleSelect='+v_singleSelect+'&a='+new Date().getMilliseconds(),
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
		},function(dialogID){
			var v_retValue = sy.getWinRet(dialogID);
		    if (v_retValue != null && v_retValue.length > 0) {
			    for (var k=0;k<=v_retValue.length-1;k++){
				      var myrow=v_retValue[k];//监管主体表3供应商4生产商5经销商
				      $("#hscpcbid").val(myrow.hscpcbid); //对应的进货表id
				      $("#jcypid").val(myrow.jcypid); //商品id
				      $("#jcypmc").val(myrow.jcypmc); //商品名称
				      $("#sysl").val(myrow.sysl); //库存量
				      $("#scspjldwmc").val(myrow.scspjldwmc); //库存量 
			    }      
		    }
		    sy.removeWinRet(dialogID);//不可缺少			
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
	  <input type="hidden" id="hscxhbid" name="hscxhbid" value="<%=v_hscxhbid%>">
	  <input type="hidden" id="aae011" name="aae011" ">
	  <input type="hidden" id="aae036" name="aae036" ">
	  <input type="hidden" id="hviewjgztid" name="hviewjgztid" ">
        
      <table class="table" style="width:100%;height: 99%">
        <tr>
          <td width="20%" style="text-align:right;"><nobr><font class="myred">
           *</font>请选择产品:</nobr>
           </td>
		  <td colspan="3">
		  <input type="hidden" id="jcypid" name="jcypid">
		  <input type="hidden" id="hscpcbid" name="hscpcbid">
		  <input id="jcypmc" name="jcypmc" readonly="readonly" style="width: 300px" 
			  class="easyui-validatebox"  data-options="required:true" />
		  <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectScpcBase()">选择生产的产品 </a>	
			<%} %>				  
		  </td>   
        </tr>
        <tr>
          <td width="20%" style="text-align:right;"><nobr><font class="myred">
           *</font>剩余数量:</nobr>
           </td>        
		  <td colspan="3">
		  <input id="sysl" name="sysl" style="width: 200px" 
			  class="easyui-validatebox input_readonly" readonly="readonly" />
		  <input id="scspjldwmc" name="scspjldwmc" style="width: 80px" 
			  class="easyui-validatebox input_readonly" readonly="readonly" />			  
		  </td>          
        </tr>
        <tr>
          <td style="height: 20px;">
          &nbsp;
          </td>
        </tr>        
        <tr>
			<td style="text-align:right;"><nobr>经销商:</nobr>
			</td>
			<td colspan="3">
			<input type="hidden" id="jxsid" name="jxsid"> 
			<input id="jxsmc" name="jxsmc" readonly="readonly" style="width: 200px" 
			class="easyui-validatebox" data-options="required:true"/>
		    <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectJianGuanZhuTiBase(5)">选择</a>	
				<%} %>				
			</td>  
        </tr>         

        <tr>
			<td style="text-align:right;"><nobr>销售时间:</nobr>
			</td>
			<td>
			<input id="xssj" name="xssj" style="width: 200px" 
			class="easyui-datetimebox" data-options="required:true"/>
		
			</td>     
			<td style="text-align:right;"><nobr>销售数量:</nobr>
			</td>
			<td>
			<input id="xssl" name="xssl" style="width: 120px" 
			class="easyui-validatebox" data-options="required:true"/>
			<input id="xhspjldw" name="xhspjldw" style="width: 80px" 
			class="easyui-validatebox" />				
			</td>   		
        </tr>        
           
      </table> 
      </form>
    </div>
    
</div>
</body>
</html>