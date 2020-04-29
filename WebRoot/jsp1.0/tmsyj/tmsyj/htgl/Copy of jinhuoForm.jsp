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
    String v_hjchid=StringHelper.showNull2Empty(request.getParameter("hjchid")); //进出库表主键
	String v_title="进货管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="进货 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="进货 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="进货 查看";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>进货管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//食品计量单位
	var v_spjldw = <%=SysmanageUtil.getAa10toJsonArray("SPJLDW")%>;
	//检测方式
	var v_jcfs = <%=SysmanageUtil.getAa10toJsonArray("JCFS")%>;
	//进出库合格证明类型
	var v_jchhgzmlx = <%=SysmanageUtil.getAa10toJsonArray("JCHHGZMLX")%>;	
	//生产检验结论
	var v_jchscjyjl = <%=SysmanageUtil.getAa10toJsonArray("JCHSCJYJL")%>;	
	//企业查验结论
	var v_jchqycyjl = <%=SysmanageUtil.getAa10toJsonArray("JCHQYCYJL")%>;	
	
	
	$(function() {
		// 计量单位
		 $('#spjldw').combobox({
			data:v_spjldw,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});
		// 检测方式
		 $('#jcfs').combobox({
			data:v_jcfs,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});	
		 $('#jchhgzmlx').combobox({
			data:v_jchhgzmlx,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		});		
		 $('#jchscjyjl').combobox({
			data:v_jchscjyjl,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		});	
		 $('#jchqycyjl').combobox({
				data:v_jchqycyjl,
				valueField:'id',
				textField:'text',
				required:false,
				edittable:false,
				panelHeight : '200' 
			});		
		
		if ($('#hjchid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmsyjhtgl/queryJinchuhuoDTO', {
				hjchid : $('#hjchid').val()
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
			$("#jchscjyjl").combobox('disable',true);
			$("#jchqycyjl").combobox('disable',true);
			$("#jchhgzmlx").combobox('disable',true);
			$("#btnselectHgzmpic").css('display','none');
			$("#btnselectHgzmpic").linkbutton("disable");
			$("#jchscrq").datebox({disabled:true});
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
		var url='<%=basePath%>/tmsyjhtgl/saveJinhuo';
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
	        			$grid.datagrid('load');
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
        var v_fjwid=$("#hjchid").val();
        var v_fjtype="9";
		var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=jchhgzm&fjwid="+v_fjwid+"&fjtype="+v_fjtype; 
		var obj = new Object();
		obj.uploadOne="yes";//yes 或 no
		var retVal = popwindow(url,obj,900,700); 
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
	
	//从单位信息表中读取
	function myselectShangpin(){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectShangpinIndex?a="+new Date().getMilliseconds(),obj,
	        860,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      $("#jcypid").val(myrow.jcypid); //公司名称   
		      $("#jcypmc").val(myrow.jcypmc); //公司代码 
		      
		    }      
	    }
	}	
	
	//从单位信息表中读取
	function myselectGongyingshang(prm_jgztkhgx){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retStr=mySahowModalDialog("<%=basePath%>pub/pub/selectGongyingshangIndex?jgztkhgx="+prm_jgztkhgx+"&a="+new Date().getMilliseconds(),obj,
	        900,460);
	    if (v_retStr != null && v_retStr.length > 0) {
		    for (var k=0;k<=v_retStr.length-1;k++){
		      var myrow=v_retStr[k];
		      if (prm_jgztkhgx=='1'){//供应商
			      $("#jchgysid").val(myrow.hjgztkhgxid); //  
			      $("#jchgysmc").val(myrow.jgztkhmc); //	    	  
		      }else if (prm_jgztkhgx=='2'){//生产商
			      $("#jchscsid").val(myrow.hjgztkhgxid); //  
			      $("#jchscsmc").val(myrow.jgztkhmc); //		    	  
		      }
		    }      
	    }
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
	  <input type="hidden" id="hjchid" name="hjchid" value="<%=v_hjchid %>">
        
      <table class="table" style="width:100%;height: 99%">
        <tr>
          <td width="13%" style="text-align:right;"><nobr><font class="myred">
           *</font>商品:</nobr>
           </td>
		  <td width="37%">
		  <input type="hidden" id="jcypid" name="jcypid">
		  <input id="jcypmc" name="jcypmc" readonly="readonly" style="width: 200px" 
			  class="easyui-validatebox" data-options="required:true" />
		  <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectShangpin()">选择 </a>	
			<%} %>				  
		  </td>   
          <td width="13%" style="text-align:right;"><nobr><font class="myred">
           *</font>数量:</nobr>
           </td>
		  <td width="37%">
		  <input id="jchsl" name="jchsl" style="width: 200px" 
			  class="easyui-validatebox" data-options="required:true" />
		  </td>  		         
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>计量单位:</nobr>
			</td>
			<td>
			<input id="spjldw" name="spjldw" style="width: 200px" 
			class="easyui-validatebox" />
			</td>     
			<td style="text-align:right;">单价<nobr>:</nobr>
			</td>
			<td>
			<input id="jcypprice" name="jcypprice" style="width: 200px" 
			class="easyui-validatebox" data-options="required:true"/>
			</td> 			
		   
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>生产地:</nobr>
			</td>
			<td>
			<input id="jchscd" name="jchscd" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'"/>
			</td> 	
			<td style="text-align:right;"><nobr>生产日期:</nobr>
			</td>
			<td>
			<input id="jchscrq" name="jchscrq" style="width: 200px" 
			class="easyui-datebox" data-options="required:false"/>
			</td>  			 			      
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>供应商:</nobr>
			</td>
			<td>
			<input type="hidden" id="jchgysid" name="jchgysid"> 
			<input id="jchgysmc" name="jchgysmc" readonly="readonly" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
		    <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectGongyingshang(1)">选择</a>	
				<%} %>				
			</td>  
			<td style="text-align:right;">生产商<nobr>:</nobr>
			</td>
			<td>
			<input type="hidden" id="jchscsid" name="jchscsid">
			<input id="jchscsmc" name="jchscsmc" readonly="readonly" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
		    <% if(!"view".equalsIgnoreCase(op)){%>
			<a id="btnselectShangpin" href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" onclick="myselectGongyingshang(2)">选择 </a>	
				<%} %>				
			</td>  			      
        </tr>         
        <tr>
			<td style="text-align:right;"><nobr>商品条码:</nobr>
			</td>
			<td>
			<input id="jchsptm" name="jchsptm" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td>  
			        
			<td style="text-align:right;"><nobr>检测方式:</nobr>
			</td>
			<td>
			<input id="jcfs" name="jcfs" style="width: 200px" 
			class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" />
			</td> 
					      
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>生产检验结论:</nobr>
			</td>
			<td>
			<input id="jchscjyjl" name="jchscjyjl" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td>  
			<td style="text-align:right;">企业查验结论<nobr>:</nobr>
			</td>
			<td>
			<input id="jchqycyjl" name="jchqycyjl" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td>  			      
        </tr>  
        <tr>
			<td style="text-align:right;"><nobr>合格证明类型:</nobr>
			</td>
			<td>
			<input id="jchhgzmlx" name="jchhgzmlx" style="width: 200px" 
			class="easyui-validatebox" data-options="required:false"/>
			</td>  
			<td colspan="2" rowspan="4" style="text-align: center;">
			    <div style="width:130;height:160;text-align: center;" id="ryzhaopian_div" >
			    	<img src="<%=contextPath%>/images/default.jpg" name="jchhgzmpic" id="jchhgzmpic" height="140" width="120"
			    	onclick="g_showBigPic(this.src);"/>
			   	</div>
			   	<a id="btnselectHgzmpic" href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-search"
				onclick="uploadFjViewCanNoId(9)">选择合格证明图片</a> 
				<input type="hidden" id="jchhgzmpath" name="jchhgzmpath">	
				<input type="hidden" id="jchhgzmname" name="jchhgzmname">	
    		</td>		      
        </tr>                  
      </table> 
      </form>
    </div>
    
</div>
</body>
</html>