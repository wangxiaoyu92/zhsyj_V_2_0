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
    String v_hscpcbid=StringHelper.showNull2Empty(request.getParameter("hscpcbid")); //进出库表主键
	String v_title="产品生产 管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="产品生产 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="产品生产 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="产品生产 查看";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title><%=v_title %>></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//食品计量单位
	var v_scspjldw = <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
	//食品生产检验结论
	var v_cpscjyjl = <%=SysmanageUtil.getAa10toJsonArray("CPSCJYJL")%>;
	$(function() {
		// 计量单位
		 $('#scspjldw').combobox({
			data:v_scspjldw,
			valueField:'id',
			textField:'text',
			edittable:false,
			panelHeight : '200' 
		});		
		// 计量单位
		 $('#cpscjyjl').combobox({
			data:v_cpscjyjl,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});
		if ($('#hscpcbid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmsyjhtgl/queryScpcDTO', {
				hscpcbid : $('#hscpcbid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
					var v_jchgzmpath = $("#jchhgzmpath").val();
		            if (v_jchgzmpath != "") {
		            	$("#jchhgzmpic").attr("src", "<%=basePath%>"+v_jchgzmpath);
		            };						
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
		
	});/////////////////////////////////////////
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url='<%=basePath%>/tmsyjhtgl/saveScpc';
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
	
	// 上传图片附件
	function uploadFjViewCanNoId(prm_fjtype){
        var v_fjwid=$("#hscpcbid").val();
        var v_fjtype="9";
		var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=jchhgzm&fjwid="+v_fjwid+"&fjtype="+v_fjtype; 
		var obj = new Object();
		obj.uploadOne="yes";//yes 或 no
		var retVal = paopwindow(url,obj,900,700);
		
		if(retVal != null){
			if(retVal.type == 'ok'){
				if (prm_fjtype=="9"){//检测合格证明图片
				  $("#jchhgzmpath").val(retVal.fjpath);
				  $("#jchhgzmname").val(retVal.fjname);	
				  $("#jchhgzmpic").attr("src", "<%=contextPath%>"+retVal.fjpath);
				}
			}
			if(retVal.type == 'deleteok'){
				var v_defaultpic="/images/default.jpg";
				if (prm_fjtype=="9"){//检测合格证明图片
				  $("#jchhgzmpath").val("");
				  $("#jchhgzmname").val("");	
				  $("#jchhgzmpic").attr("src", "<%=contextPath%>"+v_defaultpic);
				}
			}		
		}

	};
	
	function uploadFjViewCanNoIdBase(prm_fjtype) {
        var v_fjwid=$("#hscpcbid").val();
        var v_fjtype="9";
	    var dialog = parent.sy.modalDialog({
			title : '选择图片',
			width : 900,
			height : 700,
			param : {
				uploadOne:"yes"
			},			
			url : basePath + "/pub/pub/uploadFjViewIndexEasyui?folderName=jchhgzm&fjwid="+v_fjwid+"&fjtype="+v_fjtype
		},function(dialogID){
			var retVal = sy.getWinRet(dialogID);
			if(retVal != null){
				if(retVal.type == 'ok'){
					if (prm_fjtype=="9"){//检测合格证明图片
					  $("#jchhgzmpath").val(retVal.fjpath);
					  $("#jchhgzmname").val(retVal.fjname);	
					  $("#jchhgzmpic").attr("src", "<%=contextPath%>"+retVal.fjpath);
					}
				}
				if(retVal.type == 'deleteok'){
					var v_defaultpic="/images/default.jpg";
					if (prm_fjtype=="9"){//检测合格证明图片
					  $("#jchhgzmpath").val("");
					  $("#jchhgzmname").val("");	
					  $("#jchhgzmpic").attr("src", "<%=contextPath%>"+v_defaultpic);
					}
				}		
			};	
			sy.removeWinRet(dialogID);//不可缺少
		});
	};
	
	function closeModalDialogCallbackPic(dialogID){	
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
	
	
	
	//从商品表中读取
	function myselectShangpin(){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectShangpinIndex?spsjlx=1&querykind=1&a="+new Date().getMilliseconds(),obj,
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
	    var dialog = parent.sy.modalDialog({
			title : '选择产品',
			width : 860,
			height : 460,
			url : basePath + 'pub/pub/selectShangpinIndexEasyui?spsjlx=1&querykind=1&singleSelect='+v_singleSelect+'&a='+new Date().getMilliseconds(),
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
	  <input type="hidden" id="hscpcbid" name="hscpcbid" value="<%=v_hscpcbid %>">
	  <input type="hidden" id="sysl" name="sysl" ">
	  <input type="hidden" id="aae011" name="aae011" ">
	  <input type="hidden" id="aae036" name="aae036" ">
	  <input type="hidden" id="hviewjgztid" name="hviewjgztid" ">
        
      <table class="table" style="width:100%;height: 99%">
        <tr>
          <td width="20%" style="text-align:right;"><nobr><font class="myred">
           *</font>请选择产品:</nobr>
           </td>
		  <td width="40%">
		  <input type="hidden" id="jcypid" name="jcypid">
		  <input id="jcypmc" name="jcypmc" readonly="readonly" style="width: 200px" 
			  class="easyui-validatebox" data-options="required:true" />
		  <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectShangpinBase()">选择 </a>	
			<%} %>				  
		  </td>   
          <td width="10%" style="text-align:right;"><nobr><font class="myred">
           *</font>生产批次号:</nobr>
           </td>
		  <td width="30%">
		  <input id="scpch" name="scpch" style="width: 200px" 
			  class="easyui-validatebox" data-options="required:true" />
		  </td>  		         
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>生产数量:</nobr>
			</td>
			<td>
			<input id="scsl" name="scsl" style="width: 120px" 
			class="easyui-validatebox" />
			<input id="scspjldw" name="scspjldw" style="width: 80px" 
			class="easyui-validatebox" />			
			</td>     
			<td style="text-align:right;"><nobr>商品条码:</nobr>
			</td>
			<td>
			<input id="sptm" name="sptm" style="width: 200px" 
			class="easyui-validatebox" />
			</td>   		
        </tr>        
        <tr>
			<td style="text-align:right;">生产日期<nobr>:</nobr>
			</td>
			<td>
			<input id="scrq" name="scrq" style="width: 200px" 
			class="easyui-validatebox" data-options="required:true"
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
			</td> 	        
			<td style="text-align:right;"><nobr>到期日期:</nobr>
			</td>
			<td>
			<input id="bzrq" name="bzrq" style="width: 200px" 
			class="easyui-validatebox" data-options="required:true"
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
			</td>     
        </tr>    
        <tr>
			<td style="text-align:right;"><nobr>检验日期:</nobr>
			</td>
			<td>
			<input id="jyrq" name="jyrq" style="width: 200px" 
			class="easyui-validatebox"class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
			</td>   
			<td colspan="2" rowspan="5" style="text-align: center;">
			    <div style="width:130;height:160;text-align: center;" id="ryzhaopian_div" >
			    	<img src="<%=contextPath%>/images/default.jpg" name="jchhgzmpic" id="jchhgzmpic" height="140" width="120"
			    	onclick="g_showBigPic(this.src);"/>
			   	</div>
			   	<a id="btnselectHgzmpic" href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-search"
				onclick="uploadFjViewCanNoIdBase(9)">选择合格证明图片</a> 
				<input type="hidden" id="jchhgzmpath" name="jchhgzmpath">	
				<input type="hidden" id="jchhgzmname" name="jchhgzmname">	
    		</td>		      
        </tr>      
		<tr>	   
			<td style="text-align:right;">检验执行标准号<nobr>:</nobr>
			</td>
			<td>
			<input id="jyzxbzh" name="jyzxbzh" style="width: 200px" 
			class="easyui-validatebox" />
			</td> 			
		   
        </tr> 	    
        <tr>
			<td style="text-align:right;"><nobr>产品检验报告编号:</nobr>
			</td>
			<td>
			<input id="spjybgbh" name="spjybgbh" style="width: 200px" 
			class="easyui-validatebox" />
			</td>  
		</tr>	    
	    <tr>		   
			<td style="text-align:right;">产品生产检验结论<nobr>:</nobr>
			</td>
			<td>
			<input id="cpscjyjl" name="cpscjyjl" style="width: 200px" 
			class="easyui-validatebox" />
			</td> 			
        </tr>                         
           
      </table> 
      </form>
    </div>
    
</div>
</body>
</html>