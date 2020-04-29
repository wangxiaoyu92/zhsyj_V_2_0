<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userdalei = sysuser.getUserdalei();//1非企业用户2企业用户

%>
<!DOCTYPE html>
<html>
<head>
    <title>企业信息</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        // 企业大类
        var comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
        var mask;
        $(function () {
            intSelectData('comdalei', comdalei);
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                            elem: '#pcompanyTable'
                            , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                            , url: basePath + 'pcompany/queryCompany'
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
                                {field: 'comid', width: 220, title: '企业ID', event: 'trclick'}
                                , {field: 'comdm', width: 100, title: '企业代码', event: 'trclick'}
                                , {field: 'commc', width: 200, title: '企业名称', event: 'trclick'}
                                , {field: 'comrcjdglry', width: 150, title: '日常监督管理人员', event: 'trclick'}
                                , {field: 'comdaleiname', width: 170, title: '企业类别', event: 'trclick'}
                                //,{ field : 'comxiaoleiname', width : 150, title: '企业小类',event: 'trclick' }
                                , {field: 'comfrhyz', width: 100, title: '企业法人/业主', event: 'trclick'}
                                , {field: 'comyddh', width: 200, title: '移动电话', event: 'trclick'}
                                , {field: 'comdz', width: 200, title: '企业地址', event: 'trclick'}
                                , {field: 'comjdzb', width: 80, title: '经度坐标', event: 'trclick'}
                                , {field: 'comwdzb', width: 80, title: '纬度坐标', event: 'trclick'}
                                , {field: 'comzzjgdm', width: 150, title: '组织机构代码', event: 'trclick'}
                                , {field: 'comclrq', width: 150, title: '企业成立日期', event: 'trclick'}
                                , {field: 'aaa027name', width: 100, title: '所在地区', event: 'trclick'}
//					, {fixed: 'right', width : 200, align: 'center', toolbar: '#paramgridbtn'}
                            ]]
                            , done: function (res, curr, count) {
                                table.singleData = '';
                                selectTableDataId = '';
                                layer.close(mask);
                            }
                        }
                );
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.comid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.comid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addPcom: function () { // 添加
                        addPcom();
                    }
                    , updatePcom: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的企业！');
                        } else {
                            updatePcom(table.singleData.comid);
                        }
                    }
                    , delPcom: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的企业！');
                        } else {
                            delPcom(table.singleData.comid);
                        }
                    }
                    , showPcom: function () { // 显示
                        if (!table.singleData) {
                            layer.alert('请选择要查看的企业！');
                        } else {
                            showPcom(table.singleData.comid);
                        }
                    }
                    , Zzzmgl: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要修改的企业！');
                        } else {
                            Zzzmgl(table.singleData.comid);
                        }
                    }
                    , qydrIndex: function () {
                        qydrIndex();
                    }
                    , uploadFjView: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要上传附件的企业！');
                        } else {
                            uploadFjView(table.singleData.comid);
                        }
                    }
                    , delFjView: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要删除附件的企业！');
                        } else {
                            delFjView(table.singleData.comid);
                        }
                    }
                    , qrcodeManager: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择相应的企业！');
                        } else {
                            qrcodeManager(table.singleData.comid);
                        }
                    }
                    , createQRcodes: function () {
                        createQRcodes();
                    }
                    , importApproveCom: function () {
                        importApproveCom();
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            });

            function isNotNull(_this) {
                if (_this == "" || _this == null || _this == '') {
                    return false;
                }
                return true;
            }
        });
        // 查询企业信息
        function query() {
            var param = {
                'comdalei': $('#comdalei').val(),
                'commc': $('#commc').val(),
                'comfwnfww': '0',
                'aaa027': $('#aaa027').val()
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
            table.reload('pcompanyTable', {
                url: basePath + '/pcompany/queryCompany'
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

        // 新增企业
        function addPcom() {
            sy.modalDialog({
                title: '添加企业'
                , area: ['100%', '100%']
                , content: basePath + '/pcompany/pcompanyFormIndex'
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        //资质证明管理
        function Zzzmgl(comid) {
            sy.modalDialog({
                title: '企业资质证明管理'
                , area: ['100%', '100%']
                , content: basePath + '/jsp/baseinfo/pcompany/pcomZzzm.jsp?comid=' + comid
                , btn: ['关闭']
                , yes: function (index, layero) {
                    layer.close(index);
                }
            });
        }

        //查看企业信息
        function showPcom(comid) {
            sy.modalDialog({
                title: '查看企业'
                , area: ['100%', '100%']
                , content: basePath + '/pcompany/pcompanyFormIndex?op=view&comid=' + comid
                , btn: ['关闭']
            });
        }
        //编辑企业信息
        function updatePcom(comid) {
            sy.modalDialog({
                title: '修改企业'
                , area: ['100%', '100%']
                , content: basePath + '/pcompany/pcompanyFormIndex?op=edit&&comid=' + comid
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);

            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                refresh('', '');
            }
        }
        // 删除
        function delPcom(comid) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , icon: 3
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'pcompany/delPcompany', {
                                comid: comid
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
                                        if (table.cache.pcompanyTable.length == 1) {
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

        // 导入
        function qydrIndex() {
            sy.modalDialog({
                title: '导入企业'
                , area: ['100%', '100%']
                , content: basePath + '/pcompany/qydrIndex'
                , btn: ['关闭']
            });
        }

        // 导入审批企业
        function importApproveCom() {
            sy.modalDialog({
                title: '导入审批企业'
                , area: ['100%', '100%']
                , content: basePath + '/pcompany/importApproveComIndex'
                , btn: ['关闭']
            }, refresh('', ''));
        }

        // 上传图片附件
        function uploadFjView(comid) {
            var url = basePath + "/pub/pub/uploadFjViewIndex";
            sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传图片附件'
                , content: url
                , param: {
                    folderName: "company",
                    fjwid: comid
                }
                ,btn:['关闭']
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        //
                    }
                }
            });
        }

        // 删除图片附件
        function delFjView(comid) {
            var url = basePath + "/pub/pub/uploadFjViewIndex";
            sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传图片附件'
                , content: url
                , param: {
                    folderName: "company",
                    fjwid: comid
                }
                ,btn:['关闭']
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        //
                    }
                }
            });
        }

        // 二维码管理
        function qrcodeManager(comid) {
            var url = basePath + "jsp/baseinfo/pcompany/comQRcode.jsp";
            sy.modalDialog({
                area: ['100%', '100%'],
                title: '二维码信息'
                , content: url
                , param: {
                    folderName: "company",
                    comid: comid
                }
                , btn: ['生成二维码', '保存']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].createQRcode();
                }
                , btn2: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveQRcode();
                }
            });
        }
        // 批量生成二维码
        function createQRcodes() {
            var param = {
                'comdalei': $('#comdalei').val(),
                'commc': $('#commc').val(),
                'comfwnfww': '0'
            };
            layer.open({
                title: '警告'
                , type:1
                , area:['300px','200px']
                , content: '您确定要批量生成企业二维码吗?'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    layer.close(index);
                    mask = layer.load(1, {shade: [0.1, '#393D49']});
                    $.post(basePath + 'pcompany/createCompanyQRcodes',
                            function (result) {
                                table.singleData = '';
                                selectTableDataId = '';
                                if (result.code == '0') {
                                    layer.msg('批量生成企业二维码成功', {time: 500}, function () {
                                        layer.close(mask);
                                        refresh('', '');
                                    });
                                }
                            }, 'json');
                }
            });
        }

        function showMenu_aaa027() {
            sy.modalDialog({
                title: '选择地区'
                , area: ['300px', '400px']
                , content: basePath + 'jsp/pub/pub/selectAaa027.jsp'
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                if (typeof(k.type) != "undefined" && k.type != null && k.type == 'ok') {
                    $('#aaa027').val(k.aaa027);
                    $('#aaa027name').val(k.aaa027name);
                }
                sy.removeWinRet(dialogID);
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">企业名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc" placeholder="请输入企业名称"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">企业类别</label>

                                    <div class="layui-input-inline">
                                        <select name="comdalei" id="comdalei">
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">所在区域</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="aaa027name" name="aaa027name" placeholder="请输所在区域"
                                               onclick="showMenu_aaa027();"
                                               autocomplete="off" class="layui-input layui-bg-gray">
                                        <input name="aaa027" id="aaa027" type="hidden"/>
                                    </div>
                                    <div id="menuContent_aaa027" class="layui-side layui-bg-gray"
                                         style="display:none; position:fixed;z-index:333;height: 200px">
                                        <ul id="treeDemo_aaa027" class="ztree"></ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-row">

                                <div class="layui-col-md1 layui-col-xs1 layui-col-sm1 layui-col-md-offset5 layui-col-xs-offset5 layui-col-sm-offset5">
                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                lay-submit="">
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
            <ck:permission biz="addPcom">
                <button class="layui-btn" data-type="addPcom" data="btn_addPcom">增加</button>
            </ck:permission>
            <ck:permission biz="updatePcom">
                <button class="layui-btn" data-type="updatePcom" data="btn_updatePcom">修改</button>
            </ck:permission>
            <ck:permission biz="delPcom">
                <button class="layui-btn layui-btn-danger" data-type="delPcom" data="btn_delPcom">删除</button>
            </ck:permission>
            <ck:permission biz="showPcom">
                <button class="layui-btn " data-type="showPcom" data="btn_showPcom">查看</button>
            </ck:permission>
            <ck:permission biz="Zzzmgl">
                <button class="layui-btn " data-type="Zzzmgl" data="btn_Zzzmgl">企业资质证明管理</button>
            </ck:permission>
            <ck:permission biz="qydrIndex">
                <button class="layui-btn " data-type="qydrIndex" data="btn_qydrIndex">导入企业</button>
            </ck:permission>
            <ck:permission biz="uploadFjView">
                <button class="layui-btn" data-type="uploadFjView" data="btn_uploadFjView">上传企业图片</button>
            </ck:permission>
            <ck:permission biz="delFjView">
                <button class="layui-btn" data-type="delFjView" data="btn_delFjView">管理企业图片</button>
            </ck:permission>
            <ck:permission biz="qrcodeManager">
                <button class="layui-btn" data-type="qrcodeManager" data="btn_qrcodeManager">二维码管理</button>
            </ck:permission>
            <ck:permission biz="createQRcodes">
                <button class="layui-btn" data-type="createQRcodes" data="btn_createQRcodes">批量生成二维码</button>
            </ck:permission>
            <ck:permission biz="importApproveCom">
                <button class="layui-btn" data-type="importApproveCom" data="btn_importApproveCom">导入审批企业</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="pcompanyTable" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>