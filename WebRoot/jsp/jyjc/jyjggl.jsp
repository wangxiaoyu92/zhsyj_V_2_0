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
    <title>检验机构管理</title>
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
                            elem: '#jcjgTable'
                            , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                            , url: basePath + 'pcompany/queryCompany'
                            , page: true // 展示分页
                            , where: {
                                "querytype": "jyjc"
                            }
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
                                {field: 'comid', width: 220, title: '机构ID', event: 'trclick'}
                                , {field: 'comdm', width: 100, title: '机构代码', event: 'trclick'}
                                , {field: 'commc', width: 200, title: '机构名称', event: 'trclick'}
                                , {field: 'comrcjdglry', width: 150, title: '日常监督管理人员', event: 'trclick'}
                                , {field: 'comdaleiname', width: 170, title: '机构类别', event: 'trclick'}
                                //,{ field : 'comxiaoleiname', width : 150, title: '企业小类',event: 'trclick' }
                                , {field: 'comfrhyz', width: 100, title: '机构法人/业主', event: 'trclick'}
                                , {field: 'comyddh', width: 200, title: '移动电话', event: 'trclick'}
                                , {field: 'comdz', width: 200, title: '机构地址', event: 'trclick'}
                                , {field: 'comjdzb', width: 80, title: '经度坐标', event: 'trclick'}
                                , {field: 'comwdzb', width: 80, title: '纬度坐标', event: 'trclick'}
                                , {field: 'comzzjgdm', width: 150, title: '组织机构代码', event: 'trclick'}
                                , {field: 'comclrq', width: 150, title: '机构成立日期', event: 'trclick'}
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
                    addJcjg: function () { // 添加
                        addJcjg();
                    }
                    , updateJcjg: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的机构！');
                        } else {
                            updateJcjg(table.singleData.comid);
                        }
                    }
                    , delJcjg: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的机构！');
                        } else {
                            delJcjg(table.singleData.comid);
                        }
                    }
                    , showJcjg: function () { // 显示
                        if (!table.singleData) {
                            layer.alert('请选择要查看的机构！');
                        } else {
                            showJcjg(table.singleData.comid);
                        }
                    }
                    , fjglJcjg: function () { // 附件上传
                        if (!table.singleData) {
                            layer.alert('请选择要上传附件的机构！');
                        } else {
                            fjglJcjg(table.singleData.comid);
                        }
                    }
                    , uploadFjViewJcjg: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要上传附件的机构！');
                        } else {
                            uploadFjViewJcjg(table.singleData.comid);
                        }
                    }
                    , delFjViewJcjg: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要删除附件的机构！');
                        } else {
                            delFjViewJcjg(table.singleData.comid);
                        }
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
        //        查询机构信息
        function query() {
            var param = {
                'comdalei': $('#comdalei').val(),
                'commc': $('#commc').val(),
                'comfwnfww': '0',
                'aaa027': $('#aaa027').val(),
                'querytype': "jyjc"
            };
            refresh(param, '');
        }

        //        //确定
        //        function queding() {
        //            if (table.singleData != null && table.singleData != '') {
        //                var obj = new Object();
        //                obj.data = table.singleData;
        //                obj.type = "ok";
        //                sy.setWinRet(obj);
        //                parent.layer.close(parent.layer.getFrameIndex(window.name));
        //            } else {
        //                layer.alert('请选择' + mc + '信息！');
        //            }
        //        }

        //附件管理
        function fjglJcjg(comid) {
            var v_ajdjid = comid;
            var v_fjcsdlbh = "";//附件参数大类编号：执法办案附件
            var v_dmlb = "JCJGFJ";//附件参数小类编号：法律附件
            var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid=' + v_ajdjid
                    + '&dmlb=' + v_dmlb + '&fjcsdlbh=' + v_fjcsdlbh + '&time=' + new Date().getMilliseconds();
            sy.modalDialog({
                title: '附件管理'
                , area: ['100%', '100%']
                , content: url
                , btn: ['关闭']
            });
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
            table.reload('jcjgTable', {
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

        // 新增机构
        function addJcjg() {
            sy.modalDialog({
                title: '添加机构'
                , area: ['100%', '100%']
                , content: basePath + '/pcompany/pcompanyFormIndex'
                , param: {
                    querytype: "jyjc"
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        //查看机构信息
        function showJcjg(comid) {
            sy.modalDialog({
                title: '查看机构信息'
                , area: ['100%', '100%']
                , content: basePath + '/pcompany/pcompanyFormIndex?op=view&comid=' + comid
                , param: {
                    'querytype': "jyjc"
                }
                , btn: ['关闭']
            });
        }
        //编辑机构信息
        function updateJcjg(comid) {
            sy.modalDialog({
                title: '修改机构信息'
                , area: ['100%', '100%']
                , content: basePath + '/pcompany/pcompanyFormIndex?op=edit&&comid=' + comid
                , param: {
                    'querytype': "jyjc"
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            var param = {'querytype': "jyjc"};
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh(param, curent);
            } else {
                refresh(param, '');
            }
        }
        // 删除
        function delJcjg(comid) {
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
                                        var param = {'querytype': "jyjc"};
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.jcjgTable.length == 1) {
                                            curent = curent - 1;
                                        }
                                        refresh(param, curent);
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

        // 上传图片附件
        function uploadFjViewJcjg(comid) {
            var url = basePath + "/pub/pub/uploadFjViewIndex";
            sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传图片附件'
                , content: url
                , param: {
                    'folderName': "company",
                    'fjwid': comid,
                    'querytype': "jyjc"
                }
                , btn: ['关闭']
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
        function delFjViewJcjg(comid) {
            var url = basePath + "/pub/pub/uploadFjViewIndex";
            sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传图片附件'
                , content: url
                , param: {
                    'folderName': "company",
                    'fjwid': comid,
                    'querytype': "jyjc"
                }
                , btn: ['关闭']
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
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">机构名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc" placeholder="请输入机构名称"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <%--<div class="layui-col-md4 layui-col-xs4 layui-col-sm4">--%>
                            <%--<label class="layui-form-label">企业类别</label>--%>

                            <%--<div class="layui-input-inline">--%>
                            <%--<select name="comdalei" id="comdalei">--%>
                            <%--</select>--%>
                            <%--</div>--%>
                            <%--</div>--%>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
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
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6 ">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

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
            <ck:permission biz="addJcjg">
                <button class="layui-btn" data-type="addJcjg" data="btn_addJcjg">增加</button>
            </ck:permission>
            <ck:permission biz="updateJcjg">
                <button class="layui-btn" data-type="updateJcjg" data="btn_updateJcjg">修改</button>
            </ck:permission>
            <ck:permission biz="delJcjg">
                <button class="layui-btn layui-btn-danger" data-type="delJcjg" data="btn_delJcjg">删除</button>
            </ck:permission>
            <ck:permission biz="showJyjcjg">
                <button class="layui-btn " data-type="showJcjg" data="btn_showJcjg">查看</button>
            </ck:permission>
            <ck:permission biz="fjglJcjg">
                <button class="layui-btn " data-type="fjglJcjg" data="btn_fjglJcjg">附件管理</button>
            </ck:permission>
            <%-- <ck:permission biz="Zzzmgl">
                 <button class="layui-btn " data-type="Zzzmgl" data="btn_Zzzmgl">机构资质证明管理</button>
             </ck:permission>
             <ck:permission biz="qydrIndex">
                 <button class="layui-btn " data-type="qydrIndex" data="btn_qydrIndex">导入机构</button>
             </ck:permission>--%>
            <ck:permission biz="uploadFjViewJcjg">
                <button class="layui-btn" data-type="uploadFjViewJcjg" data="btn_uploadFjViewJcjg">上传机构图片</button>
            </ck:permission>
            <ck:permission biz="delFjViewJcjg">
                <button class="layui-btn" data-type="delFjViewJcjg" data="btn_delFjViewJcjg">管理机构图片</button>
            </ck:permission>
            <%--<ck:permission biz="qrcodeManager">
                <button class="layui-btn" data-type="qrcodeManager" data="btn_qrcodeManager">二维码管理</button>
            </ck:permission>
            <ck:permission biz="createQRcodes">
                <button class="layui-btn" data-type="createQRcodes" data="btn_createQRcodes">批量生成二维码</button>
            </ck:permission>
            <ck:permission biz="importApproveCom">
                <button class="layui-btn" data-type="importApproveCom" data="btn_importApproveCom">导入审批机构</button>
            </ck:permission>--%>
        </div>
        <table class="layui-hide" id="jcjgTable" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>