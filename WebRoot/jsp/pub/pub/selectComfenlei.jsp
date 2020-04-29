<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String v_opkind=StringHelper.showNull2Empty(request.getParameter("opkind"));//操作类型1报请2已阅
	System.out.println("v_opkind"+v_opkind);
%>
<!DOCTYPE html>
<html>
<head>
<title>企业大类树</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<!-- ztree插件 -->
<link rel="stylesheet" href="<%=contextPath %>/jslib/ztree/css/demo.css" type="text/css">
<link rel="stylesheet" href="<%=contextPath %>/jslib/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=contextPath %>/jslib/ztree/js/jquery.ztree.core-3.4.js"></script>
<script type="text/javascript" src="<%=contextPath %>/jslib/ztree/js/jquery.ztree.excheck-3.4.js"></script>
<script type="text/javascript">
	var v_mycomfenleiztree;
	
	var v_mycomdaleicode=sy.IsNull(sy.getUrlParam("mycomdaleicode"));
	var v_mycomxiaoleicode=sy.IsNull(sy.getUrlParam("mycomxiaoleicode"));
	
	function myinitchecked(){
		var mycomdaleicodearr=new Array();
		var mycomxiaoleicodearr=new Array();
		
		if (v_mycomdaleicode!=null){
			mycomdaleicodearr=v_mycomdaleicode.split(",");
		}
		if (v_mycomxiaoleicode!=null){
			mycomxiaoleicodearr=v_mycomxiaoleicode.split(",");
		}
		for (var i=0;i<mycomdaleicodearr.length;i++){
			var node = v_mycomfenleiztree.getNodeByParam("aaa102", mycomdaleicodearr[i], null);
			if (null != node) {
				v_mycomfenleiztree.checkNode(node, true, false, true);
			}			
		}
		for (var i=0;i<mycomxiaoleicodearr.length;i++){
			var node2 = v_mycomfenleiztree.getNodeByParam("aaa102", mycomxiaoleicodearr[i], null);
			if (null != node2) {
				v_mycomfenleiztree.checkNode(node2, true, false, true);
			}			
		}		
	}
	
	var settingComfeilei = {
			view: {
				showLine: true
			},	
			check: {
				enable: true,
				chkboxType: { "Y" : "s", "N" : "s" }
			},		
			data: {
				simpleData: {						
					enable: true,
					idKey: "aaa102",
					pIdKey: "aaa104",
					rootPId: null		
				},
				key: {
					name: "aaa103"
				}
			},
			callback: {
				onCheck: ''
			}
			
		};
	

	$(function() { 
		initUserComfeileiZTree();	
	}); 
	
	// 初始化【统筹区授权】树
	function initUserComfeileiZTree(){
		$.ajax({
			url: basePath + '/pub/pub/queryComfeileiZTree',
			type: 'post',
			async: true,
			cache: false,
			timeout: 100000,
			data: '',
			dataType: 'json',
			error: function() {
				$.messager.alert('提示','服务器繁忙，请稍后再试！','info');						
			},
			success: function(result) {
				if (result.code == '0') {
					//准备zTree数据
					var zNodesComfeilei = eval(result.comfeileiData);
					v_mycomfenleiztree=$.fn.zTree.init($("#treeDemo_comfeilei"), settingComfeilei, zNodesComfeilei);
					//initUserAaa027CheckedZTreeNodes();   
					myinitchecked();
				} else {
					$.messager.alert('提示', result.msg, 'error');
				}				
			}
		});
	}
    function myquedingold(){
        var mycheckedNodes = v_mycomfenleiztree.getCheckedNodes(true);

        var v_comdaleicode = "";
        var v_comdaleiname = "";
        var v_comxiaoleicode="";
        var v_comxiaoleiname="";

        for(var i=0;i<mycheckedNodes.length;i++){
            if (mycheckedNodes[i].treejibie=='1'){//1大类2小类
                if (v_comdaleicode==""){
                    v_comdaleicode=mycheckedNodes[i].aaa102;
                    v_comdaleiname=mycheckedNodes[i].aaa103;
                }else{
                    v_comdaleicode+=','+mycheckedNodes[i].aaa102;
                    v_comdaleiname+='|'+mycheckedNodes[i].aaa103;
                }
            }else{
                if (v_comxiaoleicode==""){
                    v_comxiaoleicode=mycheckedNodes[i].aaa102;
                    v_comxiaoleiname=mycheckedNodes[i].aaa103;
                }else{
                    v_comxiaoleicode+=','+mycheckedNodes[i].aaa102;
                    v_comxiaoleiname+='|'+mycheckedNodes[i].aaa103;
                }
                //获取小类的父类
                var v_parent=mycheckedNodes[i].getParentNode();
                var v_parentcode=v_parent.aaa102;
                var v_parentname=v_parent.aaa103;
                if(v_comdaleicode.indexOf(v_parentcode)<0)
                {

                    if (v_comdaleicode==""){
                        v_comdaleicode=v_parentcode;
                        v_comdaleiname=v_parentname;
                    }else{
                        v_comdaleicode+=','+v_parentcode;
                        v_comdaleiname+='|'+v_parentname;
                    }
                }
            }
        }
        var obj = new Object();
        obj.comdaleicode =v_comdaleicode;
        obj.comdaleiname = v_comdaleiname;
        obj.comxiaoleicode=v_comxiaoleicode;
        obj.comxiaoleiname=v_comxiaoleiname;
//		sy.setWinRet(obj);
        parent.$('#comdaleiname').val(JSON.stringify(obj));
        closeWindow();
    }

	function myqueding(){
		var mycheckedNodes = v_mycomfenleiztree.getCheckedNodes(true);
		
		var v_comdaleicode = "";
		var v_comdaleiname = "";
		var v_comxiaoleicode="";
		var v_comxiaoleiname="";
		var v_comdaleifullname="";
		
		for(var i=0;i<mycheckedNodes.length;i++){
            if (v_comdaleicode==""){
                v_comdaleicode=mycheckedNodes[i].aaa102;
                v_comdaleiname=mycheckedNodes[i].aaa103;
                //v_comdaleifullname=mycheckedNodes[i].getPath();
            }else{
                v_comdaleicode+=','+mycheckedNodes[i].aaa102;
                v_comdaleiname+='|'+mycheckedNodes[i].aaa103;
                //v_comdaleifullname+='|'+mycheckedNodes[i].getPath();
            }
		}
		var obj = new Object();
		obj.comdaleicode =v_comdaleicode; 
		obj.comdaleiname = v_comdaleiname;
		obj.comdaleifullname=v_comdaleifullname;
		//sy.setWinRet(obj);
		//parent.$('#comdaleiname').val(JSON.stringify(obj));
		//closeWindow();
		return obj;
	}
	function closeWindow(){
//		parent.$("#"+sy.getDialogId()).dialog("close");
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
</script>
</head>
<body>
<input type="hidden" id="childVlaue" name="childVlaue" >
	<div class="easyui-layout" fit="true">
	  <div data-options="region:'center',title:'企业分类列表'" fit="true"
	    style="overflow:hidden;" >
	    <ul id="treeDemo_comfeilei" class="ztree" style="width: 97%;height: 310px;"></ul>
	  </div>
<%--	  <div data-options="region:'south'" style="width:100%;height:40px;overflow:hidden;">
	      <table class="table" style="width: 100%;height: 100%;">
			<tr>
			  	<td colspan="2" style="text-align: right;">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="myqueding()"> 确定</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-reload" onclick="closeWindow()"> 退出 </a>
				</td>
			</tr>
		</table>
	  </div>    --%>

    </div>   
</body>
</html>