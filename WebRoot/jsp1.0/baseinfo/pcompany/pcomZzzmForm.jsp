<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck"%>
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
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));  //企业id
	String v_comxkzid = StringHelper.showNull2Empty(request.getParameter("comxkzid"));  //企业id
	String v_title="资质证明管理";
	if (op!=null && "add".equalsIgnoreCase(op)){
		v_title="资质证明 新增";
	}else if (op!=null && "edit".equalsIgnoreCase(op)){
		v_title="资质证明 编辑";
	}else if (op!=null && "view".equalsIgnoreCase(op)){
		v_title="资质证明 查看";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">

	// 资质证明
	var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;

	$(function() {
		// 资质证明
		cb_comxkzlx = $('#comxkzlx').combobox({
			data:comzzzm,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});
		
		if ($('#comxkzid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'pcompany/queryPcompanyXkzDTO', {
				comxkzid : $('#comxkzid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
					//$('#comdalei').combobox('setValues',eval("["+mydata.comdalei2+"]"));
					var zzzmpath = $("#zzzmpath").val();
		            if (zzzmpath != "") {
		            	$("#zzzmpic").attr("src", "<%=contextPath%>"+zzzmpath);
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
			//cb_comdalei.combobox('disable',true);		
			$("#comxkzlx").combobox('disable',true);		
			$("#btnzzzmpic").css('display','none');
			$("#btnzzzmpic").linkbutton("disable");
			$("#comxkyxqq").datebox({
				disabled:true
			});
			$("#comxkyxqz").datebox({
				disabled:true
			});			
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
		var url='<%=basePath%>/pcompany/savePcompanyXkzSingle';
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
        var v_fjwid=$("#comxkzid").val();
        var v_comxkzlx=$("#comxkzlx").combobox("getValue");
        var v_fjtype="1";
        if (v_comxkzlx!=null && v_comxkzlx!=""){
        	v_fjtype="ZZZM"+v_comxkzlx;
        }
        
		var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=companyzzzm&fjwid="+v_fjwid+"&fjtype="+v_fjtype;
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : '上传附件',
			param : {
				uploadOne : "yes"
			},
			width : 900,
			height : 700,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if(obj != null){

				if(obj.type == 'ok'){
					if (prm_fjtype=="zzzm"){//企业门头照
						$("#zzzmpath").val(obj.fjpath);
						$("#zzzmname").val(obj.fjname);
						$("#zzzmpic").attr("src", "<%=contextPath%>"+obj.fjpath);
					}
				}
				if(obj.type == 'deleteok'){
					var v_defaultpic="/images/default.jpg";
					if (prm_fjtype=="zzzm"){//企业门头照
						$("#zzzmpath").val("");
						$("#zzzmname").val("");
						$("#zzzmpic").attr("src", "<%=contextPath%>"+v_defaultpic);
					}
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
	    <input type="hidden" id="comxkzid" name="comxkzid" value="<%=v_comxkzid %>">
	    <input type="hidden" id="comid" name="comid" value="<%=v_comid %>">
	    <input type="hidden" id="sjdatatime" name="sjdatatime" >
	    <input type="hidden" id="sjdataid" name="sjdataid" >
	    <input type="hidden" id="sjdatacomdm" name="sjdatacomdm" >
        
      <table class="table" style="width:100%;height: 99%">
        <tr>
          <td width="30%" style="text-align:right;"><nobr><font class="myred">
           *</font>资质证明类型:</nobr>
           </td>
		  <td width="70%">
		  <input id="comxkzlx" name="comxkzlx" style="width: 300px" 
			  class="easyui-combobox" data-options="required:true" />
		  </td>          
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>编号(注册号):</nobr>
			</td>
			<td>
			<input id="comxkzbh" name="comxkzbh" style="width: 300px" 
			class="easyui-validatebox" data-options="required:true,validType:'length[0,50]'"/>
			</td>        
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>有效期起:</nobr>
			</td>
			<td>
			<input id="comxkyxqq" name="comxkyxqq" style="width: 300px" 
			class="easyui-datebox" data-options="required:true"/>
			</td>        
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>有效期止:</nobr>
			</td>
			<td>
			<input id="comxkyxqz" name="comxkyxqz" style="width: 300px" 
			class="easyui-datebox" data-options="required:true"/>
			</td>        
        </tr>
        <tr>
			<td style="text-align:right;"><nobr>许可范围(经营范围):</nobr>
			</td>
			<td>
			<textarea class="easyui-validatebox" id="comxkfw" name="comxkfw" 
			  style="width: 400px;" rows="5" 
			  data-options="required:false,validType:'length[0,4000]'"></textarea>
			</td>        
        </tr>   
        <tr>
			<td style="text-align:right;"><nobr>主体业态:</nobr>
			</td>
			<td>
			<input id="comxkzztyt" name="comxkzztyt" style="width: 400px" 
			class="easyui-validatebox" data-options="validType:'length[0,200]'"/>
			</td>        
        </tr>     
        <tr>
			<td style="text-align:right;"><nobr>经营场所:</nobr>
			</td>
			<td>
			<input id="comxkzjycs" name="comxkzjycs" style="width: 400px" 
			class="easyui-validatebox" data-options="validType:'length[0,200]'"/>
			</td>        
        </tr> 
        <tr>
			<td style="text-align:right;"><nobr>组成形式:</nobr>
			</td>
			<td>
			<input id="comxkzzcxs" name="comxkzzcxs" style="width: 400px" 
			class="easyui-validatebox" data-options="validType:'length[0,50]'"/>
			</td>        
        </tr>    
        <tr>
			<td style="text-align:right;"><nobr>资质证明图片:</nobr>
			</td>        
	    	<td>
	    	  <table style="border: none;width: 100%;height: 100%;" >
	    	    <tr>
	    	      <td width="60%" style="border: none;text-align:center;height: 165px;">
				    <div style="width:180;height:160;text-align: center;" 
				    id="zzzmzhaopian_div" >
				    <img src="<%=contextPath%>/images/default.jpg" 
				    	name="zzzmpic" id="zzzmpic" height="130" width="170"
				    	onclick="g_showBigPic(this.src);"/>
				   	</div>
				   	<% if (op!=null && !"view".equalsIgnoreCase(op)){ %>
				   	<a id="btnzzzmpic" href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-upload"
					onclick="uploadFjViewCanNoId('zzzm')">选择资质证明图片</a> 
					<%} %>
					<input type="hidden" id="zzzmpath" name="zzzmpath">	
					<input type="hidden" id="zzzmname" name="zzzmname">		    	      
	    	      </td>
	    	      <td width="40%" style="border: none;"></td>
	    	    </tr>
	    	  </table>
	   		</td>        
        </tr>
      </table> 
      </form>
    </div>
    
</div>
</body>
</html>