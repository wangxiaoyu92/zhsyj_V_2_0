<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
    String v_opkind = StringHelper.showNull2Empty(request.getParameter("opkind"));//操作类型1报请2已阅
    String v_aaa027flag = StringHelper.showNull2Empty(request.getParameter("aaa027flag"));//操作类型1报请2已阅


    System.out.println("v_aaa027flag" + v_aaa027flag);
%>
<!DOCTYPE html>
<html>
<head>
    <title>统筹区树</title>
    <jsp:include page="${contextPath}/inc_easyui.jsp"></jsp:include>
    <!-- ztree插件 -->
    <link rel="stylesheet" href="<%=contextPath %>/jslib/ztree/css/demo.css" type="text/css">
    <link rel="stylesheet" href="<%=contextPath %>/jslib/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=contextPath %>/jslib/ztree/js/jquery.ztree.core-3.4.js"></script>
    <script type="text/javascript" src="<%=contextPath %>/jslib/ztree/js/jquery.ztree.excheck-3.4.js"></script>
    <script type="text/javascript">
        var obj = new Object();
        obj.type = '';
        sy.setWinRet(obj);

        var v_opkind = "<%=v_opkind%>";
        var v_url = basePath + '/sysmanager/sysorg/querySystcqZTreeAsync?opkind=<%=v_opkind%>';  //调用后台的方法
        if (v_opkind != null && v_opkind == 'comreg') {
            v_url = basePath + '/pub/pub/querySystcqZTreeAsyncPub?aaa027flag=<%=v_aaa027flag%>&opkind=<%=v_opkind%>';  //调用后台的方法
        }
        var setting_aaa027 = {
            async: {
                enable: true, //启用异步加载
                url: v_url,
                autoParam: ["aaa027"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter_aaa027 //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "aaa027",
                    pIdKey: "aaa148",
                    rootPId: 0
                },
                key: {
                    name: "aaa129"
                }
            },
            callback: {
                onClick: onClick_aaa027
            }
        };

        $(function () {
            refreshZTree_aaa027();
        });

        //初始化zTree树
        function refreshZTree_aaa027() {
            $.fn.zTree.init($("#treeDemo_aaa027"), setting_aaa027);
        }

        function ajaxDataFilter_aaa027(treeId, parentNode, responseData) {
            var array = [];
            var zNodes = eval(responseData.aaa027Data);//获取后台传递的数据
            return zNodes;
        }

        //单击节点事件
        function onClick_aaa027(e, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo_aaa027");
            var nodes = zTree.getSelectedNodes();
            if (nodes.length > 0) {
                obj.type = 'ok';
                obj.aaa027 = nodes[0].aaa027;
                obj.aaa027name = nodes[0].aaa129;
                var aab301 = '';
                var checkNode = nodes[0];
                while (checkNode.aaa148 > 0) {
                    if (checkNode.aaa148 != 0) {
                        checkNode = checkNode.getParentNode();
                        aab301 = checkNode.aaa129 + aab301;
                    } else {
                        break;
                    }
                }
                obj.aab301 = aab301 + nodes[0].aaa027name;
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
//			parent.$("#"+sy.getDialogId()).dialog("close");
            } else {
                $.messager.alert('提示', '请先选择统筹区！', 'info');
            }
        }
    </script>
</head>
<body>
<div class="layui-table" fit="true">
    <div style="overflow: true;">
        <h2 class="layui-colla-title">统筹区树</h2>

        <div style="overflow: auto;" border="false">
            <ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:400px;height:300px;"></ul>
        </div>
    </div>
</div>
</body>
</html>