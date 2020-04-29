<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
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
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String basetype = StringHelper.showNull2Empty(request.getParameter("basetype"));
	String itemtype = StringHelper.showNull2Empty(request.getParameter("itemtype"));
%>
<!DOCTYPE html>
<html>
<head>
<title>项目内容</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var grid;
	var op ="<%=op%>";
	$(function() {
	
		if (op=="edit") {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$.post(basePath + '/supervision/checkinfo/queryCheckAndType',{
				basetype : $('#basetype').val(),
				itemid : $('#itemtype').val().trim()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					if(mydata!=null){
					$('#'+mydata.aaa100.toLowerCase()).prop("checked",true);
					//加载类别列表	
					 showcomList(mydata.aaa100);	
					$('form').form('load', mydata);
					}
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
			}, 'json');
			
		}else {
		//加载类别列表
		showcomList("comdalei");
		}
	});
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 

	// 保存检查项目内容信息 
	var saveContent = function($dialog, $grid, $pjq) {
		var url = basePath + '/supervision/checkinfo/saveCheckAndType';
		//提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
		     	if($("#aaa102").combobox("getValue")==null || $("#aaa102").combobox("getValue")==""){
				alert("请选择类别");
				isValid=false;
				}
				if($('#itemname').val()==null || $('#itemname').val()==""){
				alert("请选择计划项");
				isValid=false;
				}
				
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

	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	//获取类别列表
	function showcomList(val){
	//下拉框列表
	var type;
	$('#aaa100').val(val);
	if("comdalei"==val.toLowerCase()){
	 type = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>
	}else if("comxiaolei"==val.toLowerCase()){
	 type = <%=SysmanageUtil.getAa10toJsonArray("COMXIAOLEI")%>
	}else if ("jcsbjcgm"==val.toLowerCase()){
	 type = <%=SysmanageUtil.getAa10toJsonArray("jcsbjcgm")%>
	}
	var basetypeCommbox = $('#aaa102').combobox({
	    	data : type,      
	        valueField : 'id',   
	        textField : 'text',
	        required : true,
	        editable : false,
	        panelHeight : 'auto'
	    });
	}
</script>
<script type="text/javascript">
	var setting2 = { 
		async: {    
		    enable: true, //启用异步加载   
		    url: basePath + '/supervision/checkinfo/queryItemZTreeAsync',  //调用后台的方法		     
		    autoParam: ["itemid"], //向后台传递的参数
		    otherParam: {}, //额外的参数
		    dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理		                  		      		    
		},   		    
		view: {
			showLine: true
		},
		data: {
			simpleData: {						
				enable: true,
				idKey: "itemid",
				pIdKey: "itempid",
				rootPId: 0		
			},
			key: {
				name: "itemname"
			}
		},
		callback: {
			onClick: onClick2
		}
	};

	//单击节点事件
	function onClick2(event, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		var nodes = zTree.getSelectedNodes();		
		$("#itemid").val(nodes[0].itemid);
		$("#itemname").val(nodes[0].itemname);
		hideMenu();		  
	}

	function showMenu() {
		var cityObj = $("#itemname");
		var cityOffset = $("#itemname").offset();
		$("#menuContent").css({
			left: cityOffset.left + "px",
			top: cityOffset.top + cityObj.outerHeight() + "px"
		}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
		queryItemCombotree();
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (! (event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
			hideMenu();
		}
	}

	function queryItemCombotree() { //初始化项目树下拉框
		$.fn.zTree.init($("#treeDemo2"), setting2);
	}

	function ajaxDataFilter(treeId, parentNode, responseData) {
		var array = [];
		var zNodes = eval(responseData.orgData);//获取后台传递的数据
	    if (!responseData) {
	    	for(var i =0; i < responseData.length; i++) {
	    		//将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
	    		array[i] = {
					id: responseData[i].itemid,
					name: responseData[i].itemname,
					isParent: false,
					itemdesc:itemdesc
				}; 
	      	}
	    }
	    return zNodes;
	}
	
	
</script>
</head>

<body>
	<form id="fm" method="post">
	<input id="op" name="op" style="width: 200px;" hidden="true" value='<%=op%>'/>
	<input id="basetype" name="basetype" style="width: 200px;" hidden="true" value='<%=basetype%>'/>
	<input id="itemtype" name="itemtype" style="width: 200px;" hidden="true" value='<%=itemtype%>'/>
		<input name="filepath" id="filepath"  type="hidden" />
        	<sicp3:groupbox title="计划和类别关联">	
        		<table class="table" style="width: 99%;">
					<tr>
					<td></td>
						<td><input type="radio" id="comdalei" name="comdalei" onclick="showcomList(this.value)" checked="checked" value="comdalei" />企业大类	
						<input type="radio" id="comxiaolei" name="comdalei"  onclick="showcomList(this.value)" value="comxiaolei" />企业小类
						<input type="radio" id="jcsbjcgm" name="comdalei"  onclick="showcomList(this.value)" value="jcsbjcgm" />聚餐规模						
						
						</td>			
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>类别</nobr></td>
						<td><input id="aaa102" name="aaa102" style="width: 260px;"/>
						<input id="aaa100" name="aaa100" hidden="true" value=""/>
						</td>		
						
				</tr>				
						<tr>
						<td style="text-align:right;"><nobr>计划项</nobr></td>										
						<td>
							<input name="itemname" id="itemname"  style="width: 260px; " onclick="showMenu();" 
							   readonly="readonly" class="input_readonly"/>
							<input name="itemid" id="itemid" hidden="true" style="width: 200px; " />							
						</td>
					</tr>			
				</table>
				       </sicp3:groupbox>
	   </form>
	    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="treeDemo2" class="ztree" style="margin-top:0px;width:205px;height:230px;"></ul>
		</div>      
</body>
</html>