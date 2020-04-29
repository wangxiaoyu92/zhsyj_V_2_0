<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
    String orgname = StringHelper.showNull2Empty(request.getParameter("orgname"));

%>
<!DOCTYPE html>
<html>
<head>
    <title>科室</title>
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
        var v_mycomfenleiztree;
        var v_url = basePath + '/sysmanager/sysorg/querySystcqJxmZTree';  //调用后台的方法
        var setting_aaa027 = {
          async: {
                enable: true, //启用异步加载
                url: v_url,
              autoParam: ["orgid"], //向后台传递的参数
              otherParam: {}, //额外的参数
               /* otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter_aaa027 //用于对 Ajax返回数据进行预处理*/
            },
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
                    idKey: "orgid",
                    pIdKey: "parent",
                    rootPId: 0
                },
                key: {
                    name: "orgname"
                }
            },
            callback: {
                onClick: onClick_aaa027
            }
        };

        $(function () {
            refreshZTree_aaa027();
        });
        function check(){
            var s='<%=orgname%>';
            var orgname=new Array();
            if (s!=null){
                orgname=s.split(",");
            }

            for (var i=0;i<orgname.length;i++){
                var node = v_mycomfenleiztree.getNodeByParam("orgid", orgname[i], null);
                if (null != node) {
                    v_mycomfenleiztree.checkNode(node, true, false, true);
                }
            }
        }
        //初始化zTree树
        function refreshZTree_aaa027() {
            /*$.fn.zTree.init($("#treeDemo_aaa027new"), setting_aaa027);*/
            $.ajax({
                url: basePath + '/sysmanager/sysorg/querySystcqJxmZTree',
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
                        var zNodesComfeilei = eval(result.aaa027Data);
                        v_mycomfenleiztree=$.fn.zTree.init($("#treeDemo_aaa027new"), setting_aaa027, zNodesComfeilei);

                    } else {
                        $.messager.alert('提示', result.msg, 'error');
                    }
                }
            });
        }

        function ajaxDataFilter_aaa027(treeId, parentNode, responseData) {
            var array = [];
            var zNodes = eval(responseData.aaa027Data);//获取后台传递的数据
            return zNodes;
        }

        //单击节点事件
        function onClick_aaa027(e, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo_aaa027new");
            var nodes = treeObj.getCheckedNodes(true);
            var param = "";
            for(var i=0;i<nodes.length;i++){
                param = param + "orgid=" + nodes[i].orgid + "&";
            }
            $('#treeCheckedNodes').val(param);
           /* var nodes = zTree.getSelectedNodes();
            if (nodes.length > 0) {
                obj.type = 'ok';
                obj.jyxmdesc = nodes[0].jyjcxmid;
                obj.jyxmdescname = nodes[0].jcxmmc;
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
//			parent.$("#"+sy.getDialogId()).dialog("close");
            } else {
                $.messager.alert('提示', '请先选择检测项目！', 'info');
            }*/
        }

        function myqueding(){
            var nodes = v_mycomfenleiztree.getCheckedNodes(true);
            var orgid="";
            var orgname="";
            var fz="";
            for(var i=0;i<nodes.length;i++){
                if(orgid==""){
                    orgid=nodes[i].orgid;
                    orgname=nodes[i].orgname;
                } else{
                    orgid+=','+nodes[i].orgid;
                    orgname+=','+nodes[i].orgname;
                    //v_comdaleifullname=mycheckedNodes[i].getPath();
                }
                if(nodes[i].fz==undefined){
                }else{
                    if(fz==""){
                        fz=nodes[i].fz;
                    }else{
                        fz+=','+nodes[i].fz;
                    }
                }
            }
            if (nodes.length > 0) {
                obj.type = 'ok';
                obj.orgid = orgid;
                obj.orgname = orgname;
                obj.fz = fz;
                return obj;
//			parent.$("#"+sy.getDialogId()).dialog("close");
            } else {
                $.messager.alert('提示', '请先选择科室！', 'info');
            }
        }
    </script>
</head>
<body>
<div class="layui-table" fit="true">
    <div style="overflow: true;">
        <h2 class="layui-colla-title">科室</h2>

        <div style="overflow: hidden;" border="false">
            <ul id="treeDemo_aaa027new" class="ztree" style="margin-top:0px;width:400px;height:300px;"></ul>
            <input type="hidden" id="treeCheckedNodes">
        </div>
    </div>
</div>
</body>
</html>