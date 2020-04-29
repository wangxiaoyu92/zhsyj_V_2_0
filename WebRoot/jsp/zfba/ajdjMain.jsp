<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.service.AjdjService,com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }

    AjdjService v_AjdjService = new AjdjService();
    Wf_node v_wf_node = v_AjdjService.getStartNodeFromYwpym("zfbalc");
    String v_psbh = "";
    String v_nodeid = "";
    String v_nodename = "";
    if (v_wf_node != null) {
        v_psbh = v_wf_node.getPsbh();
        System.out.println(v_wf_node.getNodeid().toString());
        v_nodeid = v_wf_node.getNodeid().toString();
        v_nodename = v_wf_node.getNodename();
    }
%>
<!DOCTYPE html>
<html>
<head>

    <title>案件登记</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        // 案件状态
        var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;
        // 案件登记案件来源
        var v_AJDJAJLY = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
        // 案件受理标志
        var v_slbz = <%=SysmanageUtil.getAa10toJsonArray("SLBZ")%>;
        // 案件结束标志
        var V_AJJSBZ = <%=SysmanageUtil.getAa10toJsonArray("AJJSBZ")%>;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;
        var selectTableDataId = '';
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                intSelectData('slbz', v_slbz);
                intSelectData('ajjsbz', V_AJJSBZ);
                form.render();
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#ajdjTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/zfba/ajdj/queryAjdj'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'ajdjid', width: 150, title: '案件登记ID', event: 'trclick'}
                        , {field: 'commc', width: 150, title: '企业名称', event: 'trclick'}
                        , {field: 'comdz', width: 150, title: '企业地址', event: 'trclick'}
                        , {field: 'comfrhyz', width: 80, title: '企业法人', event: 'trclick'}
                        , {field: 'comfrsfzh', width: 130, title: '企业法人身份证号', event: 'trclick'}
                        , {field: 'comyddh', width: 120, title: '联系电话', event: 'trclick'}
                        , {field: 'ajdjafsj', width: 100, title: '案发时间', event: 'trclick'}
                        , {field: 'ajdjay', width: 150, title: '案由', event: 'trclick'}
                        , {
                            field: 'ajdjajly', width: 150, title: '案件来源'
                            , templet: function (d) {
                                return formatGridColData(v_AJDJAJLY, d.ajdjajly);
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'slbz', width: 90, title: '受理标志'
                            , templet: function (d) {
                                return formatGridColData(v_slbz, d.slbz);
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'ajjsbz', width: 80, title: '结束标志'
                            , templet: function (d) {
                                return formatGridColData(V_AJJSBZ, d.ajjsbz);
                            }
                            , event: 'trclick'
                        }
                        , {field: 'slczy', width: 100, title: '受理人', event: 'trclick'}
                        , {field: 'slsj', width: 100, title: '受理时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(AjdjFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.ajdjid) {
                            var slbz = data.slbz;
                            /*alert(slbz);*/
                            if (slbz == '0') {
                                $("#updateAjdj").removeClass('layui-btn-disabled').removeAttr("disabled");
                                $("#delAjdj").removeClass('layui-btn-disabled').removeAttr("disabled");
                                $("#kaishishouli").removeClass('layui-btn-disabled').removeAttr("disabled");
                                $("#shoulihuitui").addClass('layui-btn-disabled').attr("disabled", "true");
                            } else if (slbz == '1') {
                                $("#updateAjdj").addClass('layui-btn-disabled').attr("disabled", "true");
                                $("#delAjdj").addClass('layui-btn-disabled').attr("disabled", "true");
                                $("#kaishishouli").addClass('layui-btn-disabled').attr("disabled", "true");
                                $("#shoulihuitui").removeClass('layui-btn-disabled').removeAttr("disabled");
                            }
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.ajdjid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addAjdj: function () { // 添加
                        addAjdj();
                    }
                    , updateAjdj: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的案件登记信息！');
                        } else {
                            updateAjdj(table.singleData.ajdjid);
                        }
                    }
                    , delAjdj: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的案件登记信息！');
                        } else {
                            delAjdj(table.singleData);
                        }
                    }
                    , showAjdj: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要查看的案件登记信息');
                        } else {
                            showAjdj(table.singleData.ajdjid);
                        }
                    }
                    , uploadFuJian: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要操作的记录');
                        } else {
                            uploadFuJian(table.singleData.ajdjid);
                        }
                    }
                    , wenshuguanli: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要操作的案件登记信息');
                        } else {
                            wenshuguanli(table.singleData);
                        }
                    }
                    , kaishishouli: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要受理的案件登记信息');
                        } else {
                            kaishishouli(table.singleData);
                        }
                    }
                    , shoulihuitui: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要回退的案件登记信息');
                        } else {
                            shoulihuitui(table.singleData);
                        }
                    }
                    , shoulirizhi: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要受理的案件登记信息');
                        } else {
                            shoulirizhi(table.singleData.ajdjid);
                        }
                    }
                    , myAjdjSetRy: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要设置的案件登记信息');
                        } else {
                            myAjdjSetRy(table.singleData.ajdjid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            $("#btn_query").click(function () {
                query();
                return false;
            })
            //            $("#btn_reset").click(function () {
            //                refresh('','');
            //                return false;
            //            })
        });
        // 窗口关闭回掉函数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                //saveOk 在第一页刷新
                refresh('', '');
            }
        }
        // 新增
        function addAjdj() {
            sy.modalDialog({
                title: '案件新增'
                , area: ['100%', '100%']
                , content: basePath + '/zfba/ajdj/ajdjFormIndex'
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        // 查看
        function showAjdj(ajdjid) {
            sy.modalDialog({
                title: '查看案件登记'
                , area: ['100%', '100%']
                , content: basePath + '/zfba/ajdj/ajdjFormIndex?op=view&ajdjid=' + ajdjid
                , btn: ['关闭']
            });
        }
        // 编辑
        function updateAjdj(ajdjid) {
            sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: basePath + '/zfba/ajdj/ajdjFormIndex?op=edit&&ajdjid=' + ajdjid
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        // 删除
        function delAjdj(data) {
            var row = data;
            if (row.ajslrbz != null && row.ajslrbz == '0') {
                layer.alert("不是案件经办人，不能删除");
                return false;
            }
            var v_ajjsbz = row.ajjsbz;
            if (v_ajjsbz != null && v_ajjsbz == '9') {
                layer.alert("案件模板用，不允许删除");
                return false;
            }
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , icon: 3
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/zfba/ajdj/delAjdj', {
                                ajdjid: row.ajdjid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    //保证不会重复删除
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.ajdjTable.length == 1) {
                                            curent = curent - 1;
                                        }
                                        refresh('', curent);
                                    });
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "删除失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            },
                            'json');
                }
            });
        }
        //受理日志
        function shoulirizhi(ajdjid) {
            sy.modalDialog({
                title: '受理日志'
                , area: ['100%', '100%']
                , content: basePath + 'workflow/wfywlclogIndex?ywbh=' + ajdjid
                , btn: ['关闭']
            }, function (dialogID) {
                sy.removeWinRet(dialogID);//不可缺少
            });
        }

        //开始受理
        function kaishishouli(data) {
            var row = data;
            var v_ajdjid = row.ajdjid;
            var v_comdm = row.comdm;
            var v_commc = row.commc;
            var ajdjslsj; // 案件登记受理时间
            sy.modalDialog({
                title: '开始受理'
                , area: ['600px', '450px']
                , content: basePath + 'jsp/zfba/zfajslsj.jsp'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                ajdjslsj = obj.value;
                sy.removeWinRet(dialogID);//不可缺少
                var cfmMsg = "确定要受理申请编号为【" + v_ajdjid + "】的记录吗?";
                var v_yewumcpym = "zfbalc";
                var v_transval = "";
                var v_yewutablename = "zfajdj";
                var v_yewucolname = "ajdjid";
                var v_url = encodeURI(encodeURI("<%=basePath%>workflow/beginWfprocess?ywbh="
                + v_ajdjid + "&comdm=" + v_comdm + "&commc=" + "[执法办案]"+v_commc + "&yewumcpym="
                + v_yewumcpym + "&transval=" + v_transval + "&yewutablename=" + v_yewutablename + "&yewucolname="
                + v_yewucolname + "&ajdjslsj=" + ajdjslsj + "&time=" + new Date().getMilliseconds()));
                layer.open({
                    title: '确认'
                    , content: cfmMsg
                    , btn: ['确定', '取消'] //可以无限个按钮
                    , btn1: function (index, layero) {
                        $.post(v_url, {
                                    ajdjid: v_ajdjid
                                },
                                function (result) {
                                    if (result.code == '0') {
                                        layer.msg('受理成功', {time: 500}, function () {
                                            refresh('', '');
                                        });
                                    } else {
                                        layer.open({
                                            title: "提示",
                                            content: "受理失败：" + result.msg //这里content是一个普通的String
                                        });
                                    }
                                },
                                'json');
                    }
                });
            });
        }

        // 受理回退
        function shoulihuitui(data) {
            var row = data;
            if (row.ajslrbz != null && row.ajslrbz == '0') {
                layer.alert("不是案件经办人，不能受理回退");
                return false;
            }
            var v_ajdjid = row.ajdjid;
            var cfmMsg = "确定要回退受理编号为【" + v_ajdjid + "】的记录吗?";

            var v_yewumcpym = "zfbalc";
            var v_transval = "";
            var v_yewutablename = "zfajdj";
            var v_yewucolname = "ajdjid";

            var v_url = encodeURI(encodeURI("<%=basePath%>workflow/rollbackWfprocess?ywbh="
            + v_ajdjid + "&yewumcpym=" + v_yewumcpym + "&yewutablename=" + v_yewutablename + "&yewucolname="
            + v_yewucolname + "&time=" + new Date().getMilliseconds()));
            layer.open({
                title: '确认'
                , content: cfmMsg
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(v_url, {
                                ajdjid: v_ajdjid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    layer.msg('处理成功', {time: 500}, function () {
                                        refresh('', '');
                                    });
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "处理失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            },
                            'json');
                }
            });
        }
        //查询
        function query() {
            var param = {
                'comdm': $('#comdm').val(),
                'commc': $('#commc').val(),
                'slbz': $('#slbz').val(),
                'ajjsbz': $('#ajjsbz').val()
            };
            refresh(param, '');
        }
        // 刷新
        function refresh(param, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            table.reload('ajdjTable', {
                url: basePath + '/zfba/ajdj/queryAjdj'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comdm").val(myrow.comdm); //公司代码
                }
            });
        }
        //文书管理  统一修改
        function wenshuguanli(data) {
            var row = data;
//			alert(row.ajdjid);zfba
            if (row) {
                var v_ajdjid = row.ajdjid;
                var v_ajslrbz = row.ajslrbz;
                var url = basePath + "/pub/wsgldy/pubWsglIndex";
                sy.modalDialog({
                    title: '文书管理'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        ajdjid: v_ajdjid,
                        ajslrbz: v_ajslrbz,
                        psbh: '<%=v_psbh%>',
                        nodeid: '<%=v_nodeid%>',
                        nodename: encodeURI(encodeURI('<%=v_nodename%>'))
                    }
                    , btn: ['关闭']
                }, function (dialogID) {
                    sy.removeWinRet(dialogID);//不可缺少
                });
            }
        }
        //附件管理
        function uploadFuJian(ajdjid) {
            var v_ajdjid = ajdjid;
            var v_fjcsdlbh = "ZFBAFJ";//附件参数大类编号：执法办案附件
            var v_dmlb = "ZFAJDJFJ";//附件参数小类编号：法律附件
            var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid=' + v_ajdjid
                    + '&dmlb=' + v_dmlb + '&fjcsdlbh=' + v_fjcsdlbh + '&time=' + new Date().getMilliseconds();
            sy.modalDialog({
                title: '附件管理'
                , area: ['100%', '100%']
                , content: url
                , btn: ['关闭']
            });
        }

        //从单位信息表中读取
        function myAjdjSetRy(ajdjid) {
            sy.modalDialog({
                title: '经办人设置'
                , area: ['100%', '100%']
                , content: basePath + 'jsp/zfba/ajdjSetRy.jsp'
                , param: {'ajdjid': ajdjid}
                , btn: ['保存', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submit();
                }
                , btn2: function (index, layero) {
                    //当前页面刷新
                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                    refresh('', curent);
                }
            }, function (dialogID) {
                sy.removeWinRet(dialogID);//不可缺少
            });
        }

    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业编号:</label>

                                    <div class="layui-input-inline" style="width: 100px;">
                                        <input type="text" id="comdm" name="comdm" readonly
                                               autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-input-inline" style="width: 80px;">
                                        <a href="javascript:void(0)" class="layui-btn"
                                           iconCls="icon-search" onclick="myselectcom()">选择 </a>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业名称:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">受理标志:</label>

                                    <div class="layui-input-inline">
                                        <select id="slbz" name="slbz"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">案件结束标志:</label>

                                    <div class="layui-input-inline">
                                        <select id="ajjsbz" name="ajjsbz"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md8 layui-col-xs2 layui-col-sm2">
                                <div class="layui-form-item">
                                </div>
                            </div>
                            <div class="layui-col-md2 layui-col-xs4 layui-col-sm4">
                                <div class="layui-form-item" >
                                    <div class="layui-input-inline" style="width: auto">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                            <i class="layui-icon">&#xe615;</i>搜索
                                        </button>
                                        <button class="layui-btn layui-btn-sm layui-btn-normal"
                                                id="btn_reset">
                                            <i class="layui-icon">&#xe621;</i>重置
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addAjdj">
                <button class="layui-btn" data-type="addAjdj" data="btn_addAjdj">增加</button>
            </ck:permission>
            <ck:permission biz="updateAjdj">
                <button class="layui-btn" data-type="updateAjdj" data="btn_updateAjdj" id="updateAjdj">编辑
                </button>
            </ck:permission>
            <ck:permission biz="delAjdj">
                <button class="layui-btn layui-btn-danger" data-type="delAjdj" data="btn_delAjdj" id="delAjdj">
                    删除
                </button>
            </ck:permission>
            <ck:permission biz="showAjdj">
                <button class="layui-btn " data-type="showAjdj" data="btn_showAjdj">查看</button>
            </ck:permission>
            <ck:permission biz="uploadZfbaFuJian">
                <button class="layui-btn " data-type="uploadFuJian" data="btn_uploadFuJian">附件</button>
            </ck:permission>
            <ck:permission biz="wenshuguanli">
                <button class="layui-btn " data-type="wenshuguanli" data="btn_wenshuguanli">文书</button>
            </ck:permission>
            <ck:permission biz="kaishishouli">
                <button class="layui-btn " data-type="kaishishouli" data="btn_kaishishouli" id="kaishishouli">
                    受理
                </button>
            </ck:permission>
            <ck:permission biz="shoulihuitui">
                <button class="layui-btn " data-type="shoulihuitui" data="btn_shoulihuitui" id="shoulihuitui">
                    受理回退
                </button>
            </ck:permission>
            <ck:permission biz="shoulirizhi">
                <button class="layui-btn " data-type="shoulirizhi" data="btn_shoulirizhi">受理日志</button>
            </ck:permission>
            <ck:permission biz="myAjdjSetRy">
                <button class="layui-btn " data-type="myAjdjSetRy" data="btn_myAjdjSetRy">案件经办人设置</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="ajdjTable" lay-filter="AjdjFilter"></table>
    </div>
</div>
</body>
</html>