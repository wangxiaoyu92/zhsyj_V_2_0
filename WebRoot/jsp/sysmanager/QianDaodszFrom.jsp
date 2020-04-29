<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
	String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
	String v_qddszid = StringHelper.showNull2Empty(request.getParameter("qddszid"));  //企业id
	String sh = StringHelper.showNull2Empty(request.getParameter("sh"));  //审核
%>
<!DOCTYPE html>
<html>
<head>
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript"> 
    var qd_aae100;
	var grid;
	$(function(){
		var id=$("#qddszid").val();
	 	if(id==""){
	 		$("#ss").eq(0).hide();
	 	} 
		if ($('#qddszid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/sysmanager/sysuser/Queryqdd', {
				qddszid :id
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
              <%--    if('<%=op%>' == 'view'){	
				$('from:input').addClass('input_readonly');
				$('from:input').attr('readonly','readonly');
				$('input').attr('disabled','true');
				$('#btnselectcom').hide();
			} --%>
		} 
		qd_aae100 = $('#aae100').combobox({
	    	data : [{id:'0',text:'无效'}, {id:'1',text:'有效'}],      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto',
	        value : "1"  //默认选中value指定的选项 
	    });
	})
	// 从地区下拉树中读取
	function myselectarea(){
	    var url = basePath + 'pub/pub/selectareaIndex';
		var dialog = parent.sy.modalDialog({
				title : '选择地区',
				param : {
					singleSelect : "true",
					a : new Date().getMilliseconds()
				},
				width : 800,
				height : 600,
				url : url
		},function(dialogID) {
			var v_retSt = sy.getWinRet(dialogID);
			if (v_retSt != null){
			    $("#comshengmc").val(v_retSt.comshengmc); // 省名称
		        $("#comshimc").val(v_retSt.comshimc); // 市名称
		        $("#comxianmc").val(v_retSt.comxianmc); // 县名称
		        $("#comxiangmc").val(v_retSt.comxiangmc); // 乡名称
		        $("#comcunmc").val(v_retSt.comcunmc); // 村名称
		        $("#comshengdm").val(v_retSt.comshengdm); // 省代码
		        $("#comshidm").val(v_retSt.comshidm); // 市代码
		        $("#comxiandm").val(v_retSt.comxiandm); // 县代码
		        $("#comxiangdm").val(v_retSt.comxiangdm); // 乡代码
		        $("#comcundm").val(v_retSt.comcundm); // 村代码
			}
		    sy.removeWinRet(dialogID);//不可缺少
		});    
	}
	
	//地图定位获取经纬度
	function myselectjwd(){
	    var url = basePath + 'jsp/pub/pub/pubMap.jsp';
		var dialog = parent.sy.modalDialog({
				title : '选择经纬度',
				param : {
					address : $("#qdddz").val(),
					a : new Date().getMilliseconds()
				},
				width : 900,
				height : 700,
				url : url
		},function(dialogID) {
			var v_retSt = sy.getWinRet(dialogID);
			if (v_retSt != null){
	           $("#qddjdzb").val(v_retSt.jdzb);
	           $("#qddwdzb").val(v_retSt.wdzb);	 	
		    } 
		    sy.removeWinRet(dialogID);//不可缺少
		});    
	} 
	
	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp';
		var dialog = parent.sy.modalDialog({
				title : '选择地区',
				param : {
					opkind : "addcompany",
				},
				width : 300,
				height : 400,
				url : url
		},function(dialogID) {
			var k = sy.getWinRet(dialogID);
			if(k.type=='ok'){
				$('#aaa027').val(k.aaa027);
				$('#aaa027name').val(k.aaa027name);
				$('#qdddz').val(k.aab301);
			}
		    sy.removeWinRet(dialogID);//不可缺少
		}); 
	}
	var submitForm = function($dialog, $grid, $pjq) {
	 	 $pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url:basePath + '/sysmanager/sysuser/addqdd',
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
	}
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
     	$dialog.dialog('destroy');
	 };  
</script>
</head>

<body >
	<form id="fm" method="post" >
	<input type="hidden" id="qddszid" name="qddszid" value="<%=v_qddszid%>">
		<sicp3:groupbox title="签到点基本信息"> 
        		<table class="table" style="width:98%;height: 98%">
					<tr>
	 					<td style="text-align:right;"><nobr>签到点名称:</nobr></td>
	 					<td><input id="qddmc" name="qddmc" style="width: 200px" class="easyui-validatebox" data-options="required:true"/></td>
						<!-- <td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
						<td >
							<input name="aaa027name" id="aaa027name"  style="width: 200px; " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
													
						</td> -->
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>详细地址:</nobr></td><!-- onclick="showMenu_aaa027();"  -->
						<td colspan="3"><input id="qdddz" name="qdddz" style="width: 400px" class="easyui-validatebox" data-options="required:true"/>
						<a href="javascript:void(0)" class="easyui-linkbutton" id="dtdw" 
									iconCls="icon-search" onclick="showMenu_aaa027()">选择地点 </a>
						</td>
						<!-- <input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
							</div> -->		
					</tr>
					<tr>
                      <td style="text-align:right;"><nobr>地图定位:</nobr></td>
					  <td colspan="3">
					     经度坐标：<input id="qddjdzb" name="qddjdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
					     纬度坐标：<input id="qddwdzb" name="qddwdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
								<a href="javascript:void(0)" class="easyui-linkbutton" id="dtdw" 
									iconCls="icon-search" onclick="myselectjwd()">选择经纬度 </a>					     
					  </td>
					</tr> 
					<tr>
						<td style="text-align:right;"><nobr>有效距离:</nobr></td>
						<td ><input id="qddyxjl" name="qddyxjl" style="width: 200px"  class="easyui-validatebox" data-options="required:true"/></td>
						<td style="text-align:right;"><nobr>是否有效:</nobr></td>
						<td><input id="aae100" name="aae100" style="width: 200px"/></td>						
					</tr>
					<tr id="ss">
						<td style="text-align:right;"><nobr>操作员:</nobr></td>
						<td><input id="aae011" name="aae011" style="width: 200px" readonly="readonly"/></td>
						<td style="text-align:right;"><nobr>操作时间:</nobr></td>
						<td><input id="aae036" name="aae036" style="width: 200px" readonly="readonly"/></td>
					</tr>  
					<tr>
						<td style="text-align:right;"><nobr>备注:</nobr></td>
						<td colspan="3"><textarea id="aae013" name="aae013" style="width: 500px"></textarea></td>
					</tr>  
				</table>
			</sicp3:groupbox>  
	   </form>
</body>
</html>