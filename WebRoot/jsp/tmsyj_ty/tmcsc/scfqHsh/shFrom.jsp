<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<% 	
    String pshid = StringHelper.showNull2Empty(request.getParameter("pshid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
 %> 
<!DOCTYPE html>
<html>
<head>
<title>菜品信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree2.jsp"></jsp:include>
<script type="text/javascript">  
 	var zzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
	var v_zzzm;
	$(function() {
	v_zzzm = $('#shzzzmmc').combobox({
			data :zzzm,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight :180
		});	
		if ($('#pshid').val().length > 0) { 
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmcsc/scfqHsh/querySh', {
				pshid : $('#pshid').val()
			}, 
			function(result) {
				if (result.code=='0') { 
					var mydata = result.rows[0];					
					$('form').form('load', mydata);							
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
			     showUploadFj($('#pshid').val());
			}, 'json');
			 if ('<%=op%>' == 'show'){ 
			 	$('from:input').addClass('input_readonly');
			 	$('from:input').attr('readonly','readonly');
			 	$('input').attr('disabled','true');
				$('#btnselectcom').hide();
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
			url: basePath + '/tmcsc/scfqHsh/saveSh',
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
	 
</script> 
<script type="text/javascript">  
	var setting = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/tmcsc/scfqHsh/queryScfq',  //调用后台的方法		     
		    autoParam: ["pscfqid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "pscfqid",
				pIdKey: "parent",
				rootPId: 0		
			},
			key: {
				name: "scfqmc"
			}
		},
		callback: {
			onClick: onClick
		}
	};
	
	$(function() { 
		refreshZTree();	
	}); 
	
	//初始化zTree树
	function refreshZTree(){
		ztree = $.fn.zTree.init($("#myTree"), setting);
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
	    return zNodes;
	}
	function onClick(event, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("myTree");
		var nodes = zTree.getSelectedNodes();		
		$("#pscfqid").val(nodes[0].pscfqid);
		$("#parentname").val(nodes[0].scfqmc);
		hideMenu();		  
	}
	function showMenu() {
		var cityObj = $("#parentname");
		var cityOffset = $("#parentname").offset();
		$("#menuContent").css({
			left: cityOffset.left + "px",
			top: cityOffset.top + cityObj.outerHeight() + "px"
		}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
		refreshZTree();
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (! (event.target.id == "menuBtn" 
			|| event.target.id == "menuContent" 
			|| $(event.target).parents("#menuContent").length > 0)) {
			hideMenu();
		}
	}
	//选择企业
	function myselectcom(){
			var url = basePath + "pub/pub/selectcomIndex?singleSelect=true&a="+new Date().getMilliseconds(); 

			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '选择企业',
				width : 800,
				height : 600,
				url : url
			},function (dialogID){
				var v_retStr = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
			    if (v_retStr != null && v_retStr.length > 0) {
				    for (var k=0;k<=v_retStr.length-1;k++){
				      var myrow=v_retStr[k];
				      //$("#commc").val(myrow.commc); //公司名称    
				      $("#comid").val(myrow.comid); //公司id
				      //$("#comdz").val(myrow.comdz); //企业地址 
				     // $("#comfrhyz").val(myrow.comfrhyz); //法人/业主 
				      //$("#comfrsfzh").val(myrow.comfrsfzh); //法人/业主身份证号 
				      //$("#comyzbm").val(myrow.comyzbm); //邮政编码
				      //$("#comyddh").val(myrow.comyddh); //电话号码
				    }      
			    }
			});
	}
	
	</script> 
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" > 
		<input type="hidden" id="pshid" name="pshid" value="<%=pshid%>"/>
		<!-- <input name="comid" id="comid" type="hidden" />   --> 
	       	<sicp3:groupbox title="商户信息">	
	       		<table class="table" style="width: 99%;"> 				
					<tr>	
						<td style="text-align:right;"><nobr>企业id:</nobr></td>
						<td><!-- <input name="comid" id="comid"   style="width: 175px;"/> -->
						 <input name="comid" id="comid"  style="width: 175px; " class="input_readonly" readonly="readonly" class="easyui-validatebox" data-options="required:true"/>
						 <a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
						</td>
						<td style="text-align:right;"><nobr>市场分区id:</nobr></td>
						<td>
						    <input name="parentname" id="parentname" class="easyui-validatebox" data-options="required:true"
						     style="width: 175px; " onclick="showMenu();" readonly="readonly" class="input_readonly" /> 
						        <input name="pscfqid" id="pscfqid" type="hidden"/>
						   		<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
									<ul id="myTree" class="ztree" style="margin-top:0px;width:170px;height:250px;"></ul>
								</div>  
						</td>
					</tr> 				
					<tr>
						<td style="text-align:right;"><nobr>商户名称:</nobr></td>
						<td><input name="shmc" id="shmc"  style="width: 175px; " class="easyui-validatebox" data-options="required:true" />
						</td>								
						<td style="text-align:right;"><nobr>商户简称:</nobr></td>
						<td><input name="shjc" id="shjc"   style="width: 175px; "/></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>商户联系人:</nobr></td>
						<td><input name="shlxr" id="shlxr"   style="width: 175px;" class="easyui-validatebox" data-options="required:true"/></td>								
						<td style="text-align:right;"><nobr>商户摊位号:</nobr></td>
						<td><input name="shtwh" id="shteh"   style="width: 175px;" class="easyui-validatebox" data-options="required:true"/></td>						
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>商户移动电话:</nobr></td>
						<td><input name="shyddh" id="shyddh"    style="width: 175px;" class="easyui-validatebox" data-options="validType:'mobile'"/></td>
						<td style="text-align:right;"><nobr>商户固定电话:</nobr></td>
						<td><input name="shgddh" id="shgddh"   style="width: 175px; " /></td>
					</tr> 	 
					<tr>	
						<td style="text-align:right;"><nobr>商户资质证明名称:</nobr></td>
						<td ><input name="shzzzmmc" id="shzzzmmc"   style="width: 175px; " /></td>		
						<td style="text-align:right;"><nobr>商户资质证明编号:</nobr></td>
						<td ><input name="shzzzmbh" id="shzzzmbh"   style="width: 175px; " /></td>		
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>商户身份证号:</nobr></td>
						<td><input name="shsfzh" id="shsfzh" style="width: 175px; " class="easyui-validatebox" data-options="required:false" /></td>									
						
					</tr> 				
					<tr>	
						<td style="text-align:right;"><nobr>商户通讯地址:</nobr></td>
						<td colspan="3"><input name="shtxdz" id="shtxdz" style="width:450px;"/></td>
					</tr> 				
				</table>
	        </sicp3:groupbox>
		</form>
    </div>    
</body>
</html>