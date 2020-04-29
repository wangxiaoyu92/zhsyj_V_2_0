<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
			+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<% 	
    String hcycdid = StringHelper.showNull2Empty(request.getParameter("hcycdid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
 %> 
<!DOCTYPE html>
<html>
<head>
<title>菜品信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
    var caixi = <%=SysmanageUtil.getAa10toJsonArray("caixi")%>;
    var caipingl = <%=SysmanageUtil.getAa10toJsonArray("caipingl")%>;
    var sjbz = <%=SysmanageUtil.getAa10toJsonArray("sjbz")%>;
    var cx;
    var cpgl;
    var bz;
	//下拉框列表	
	$(function() {
	bz = $('#sjbz').combobox({
			data : sjbz,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable : false,
			panelHeight : 'auto'
		});				
	cx = $('#caixi').combobox({
			data : caixi,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight :180
		});				
	cpgl = $('#caipingl').combobox({
			data : caipingl,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight : 'auto'
		});				
		if ($('#hcycdid').val().length > 0) { 
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmcy/cdgl/QueryCd', {
				hcycdid : $('#hcycdid').val()
			}, 
			function(result) {
				if (result.code=='0') { 
					var mydata = result.rows[0];					
					$('form').form('load', mydata);							
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
			     showUploadFj($('#hcycdid').val());
			}, 'json');
			 if ('<%=op%>' == 'show'){ 
			 	$('from:input').addClass('input_readonly');
			 	$('from:input').attr('readonly','readonly');
			 	$('input').attr('disabled','true');
				$('#btnselectcom').hide();
				bz.combobox('disable',true);		
				cx.combobox('disable',true);		
				cpgl.combobox('disable',true);
			 }
		}else{
			$('#hid').hide();
		}
	});


	// 保存 
	var submitForm = function($dialog, $grid, $pjq) { 
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/tmcy/cdgl/SaveCd',
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


	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	}; 
	//选择企业
	function selectcom(){
	    var dialog =  parent.sy.modalDialog({
			title : '选择企业',
			width : 800,
			height : 500,
			param : {
				singleSelect : "true"
			},
			url : basePath + 'pub/pub/selectcomIndex',
		}, function(dialogID){
			var v_retStr = sy.getWinRet(dialogID);
			if (v_retStr != null && v_retStr.length > 0){
			    for (var k = 0; k <= v_retStr.length - 1; k++){
			      var myrow = v_retStr[k];
			      $("#comid").val(myrow.comid); //公司id 
			    }
			}
			sy.removeWinRet(dialogID);//不可缺少
		});
	}
	
	//获取上传的图片
	function showUploadFj(hcycdid){
		if(hcycdid!='' && hcycdid!=null){
			$.post(basePath + '/pub/pub/queryFjViewList', {
				'fjwid' : hcycdid
			},
			function(result) {
				var mydata = result.data;
				if(mydata!=null){
					var playerHtml = ''; 
					for(var i=0;i<mydata.length;i++){
						var imgUrl = contextPath + "/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src=" 
								+ contextPath + mydata[i].fjpath;
						playerHtml = playerHtml + "<div style='float:left;text-align:center;margin:0 20px 20px 0;'><a onclick=\"showPic('" 
								+ imgUrl +"')\"><img width=\"160px\" height=\"120px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" 
								+ sy.contextPath +  mydata[i].fjpath + "\"/></a></div>"; 
					}
					$('#picbox').append(playerHtml);
				}else{
					$('#picbox').append("暂未上传图片！");
				}			
			},'json');			
		}
	} 
	
	//预览图片
	function showPic(imgUrl){
		var dialog =  parent.sy.modalDialog({
			title : '查看图片',
			width : 800,
			height : 600,
			url : imgUrl,
		}, function(dialogID){
			sy.removeWinRet(dialogID);//不可缺少
		});
	}
	
</script>  
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" > 
		<input type="hidden" id="hcycdid" name="hcycdid" value="<%=hcycdid%>"/>
		<input name="comid" id="comid" type="hidden" />   
	       	<sicp3:groupbox title="菜品信息">	
	       		<table class="table" style="width: 99%;">
					<!-- <tr>
						<td style="text-align:right;"><nobr>企业id:</nobr></td>
						<td><input name="comid" id="comid"  style="width: 175px; " class="input_readonly" readonly="readonly" class="easyui-validatebox" data-options="required:true"/>
						 <a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="selectcom()">选择企业 </a></td>
						<td style="text-align:right;"><nobr>价格:</nobr></td>
						<td><input name="cpjg" id="cpjg"   style="width: 175px; " /></td>
					</tr>	 -->				
					<tr id='hid'>	
						<td style="text-align:right;"><nobr>操作员:</nobr></td>
						<td><input name="aae011" id="aae011"   style="width: 175px; "  /></td>
						<td style="text-align:right;"><nobr>操作时间:</nobr></td>
						<td><input name="aae036" id="aae036"    style="width: 175px; "  /></td>
					</tr> 				
					<tr>
						<td style="text-align:right;"><nobr>菜品上市时间:</nobr></td>
						<td><input name="cpsssj" id="cpsssj"  style="width: 175px; "  class="easyui-validatebox" data-options="required:true"  class="Wdate"
					     onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
						</td>								
						<td style="text-align:right;"><nobr>上架标志:</nobr></td>
						<td><input name="sjbz" id="sjbz"   style="width: 175px; " class="easyui-validatebox" data-options="required:false" /></td>						
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>菜系:</nobr></td>
						<td><input name="caixi" id="caixi"   style="width: 175px; "  /></td>
						<td style="text-align:right;"><nobr>菜品归类:</nobr></td>
						<td><input name="caipingl" id="caipingl"    style="width: 175px; "  /></td>
					</tr> 				
					<tr>	
						<td style="text-align:right;"><nobr>菜品简称:</nobr></td>
						<td><input name="cpjc" id="cpjc" style="width: 175px; " class="easyui-validatebox" data-options="required:false" /></td>									
						<td style="text-align:right;"><nobr>价格:</nobr></td>
						<td><input name="cpjg" id="cpjg"   style="width: 175px; " /></td>
					</tr>
					<tr>	
					<td style="text-align:right;"><nobr>菜品名称:</nobr></td>
						<td colspan="3"><input name="cpmc" id="cpmc"   style="width: 450px; "  class="easyui-validatebox" data-options="required:true" /></td>		
					</tr> 				
					<tr>	
						<td style="text-align:right;"><nobr>菜品简介:</nobr></td>
						<td colspan="3"><textarea name="cpjj" id="cpjj" style="width:450px; "></textarea></td>
					</tr> 				
				</table>
	        </sicp3:groupbox>
	        <div id="picbox" style="width:100%;text-align:center;">
			</div>
		</form>
    </div>    
</body>
</html>