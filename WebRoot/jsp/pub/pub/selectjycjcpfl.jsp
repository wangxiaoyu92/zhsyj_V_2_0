<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }


%>
<!DOCTYPE html>
<html>
<head>
    <title>抽检产品分类</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <!-- ztree插件 -->
    <link rel="stylesheet" href="<%=contextPath %>/jslib/ztree/css/demo.css" type="text/css">
    <link rel="stylesheet" href="<%=contextPath %>/jslib/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=contextPath %>/jslib/ztree/js/jquery.ztree.core-3.4.js"></script>
    <script type="text/javascript" src="<%=contextPath %>/jslib/ztree/js/jquery.ztree.excheck-3.4.js"></script>
    <script type="text/javascript">
        var obj = new Object();
        obj.type = '';
        sy.setWinRet(obj);
        var v_url = basePath + '/jyjc/querySystcqZTree';  //调用后台的方法
        var setting_aaa027 = {
            async: {
                enable: true, //启用异步加载
                url: v_url,
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter_aaa027 //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "parentchildid",
                    pIdKey: "parentid",
                    rootPId: 0
                },
                key: {
                    name: "mc"
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
                obj.viewjycjcpflid = nodes[0].parentchildid;
                obj.viewjycjcpflname = nodes[0].mc;
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
//			parent.$("#"+sy.getDialogId()).dialog("close");
            } else {
                $.messager.alert('提示', '请先选择抽检产品分类！', 'info');
            }
        }
    </script>
</head>
<body>
<div class="layui-table" fit="true">
    <div style="overflow: true;">
        <h2 class="layui-colla-title">抽检产品分类</h2>

        <div style="overflow: hidden;" border="false">
            <ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:400px;height:300px;"></ul>
        </div>
    </div>
</div>
</body>
</html>