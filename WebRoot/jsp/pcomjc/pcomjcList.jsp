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
    <title>企业检查</title>
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
        //量化等级
        var v_LHFJNDPDDJ = <%=SysmanageUtil.getAa10toJsonArray("LHFJNDPDDJ")%>;
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
                                , {
                                    field: 'lhfjndpddj', width: 100, title: '是否量化',
                                    templet: function (d) {
                                        if(d.lhfjndpddj){
                                            return '<font style="color: blue">已量化</font>';
                                        }else{
                                            return '<font style="color: red">未量化</font>';
                                        }
                                    }, event: 'trclick'
                                }
                                , {
                                    field: 'lhfjndpddj', width: 100, title: '量化等级',
                                    templet: function (d) {
                                        if(formatGridColData(v_LHFJNDPDDJ, d.lhfjndpddj)){
                                            return formatGridColData(v_LHFJNDPDDJ, d.lhfjndpddj);
                                        }else{
                                            return '无'
                                        }

                                    }, event: 'trclick'
                                }
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
                    zxjc: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择相应的企业！');
                        } else {
                            if (table.singleData.lhfjndpddj) {
                                zxjc(table.singleData);
                            } else {
                                layer.alert('请先量化再检查!')
                            }

                        }
                    }
                    , handCreateNddj: function () { // 手动量化
                        if (!table.singleData) {
                            layer.alert('请先选择要手动生成的信息！');
                        } else {
                            autoCreateNddj(table.singleData, "1");
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            $('#btn_query').click(function () {
                query();
                return false;
            })
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

        /**
         * 手动生成年度等级
         */
        function autoCreateNddj(singleData, a) {//评定结果生产方式0自动1手动
            var prm_pdjgscfs = a;
            layer.confirm('确定要生成所选单位的年度等级信息吗?', function (index) {
                var v_lhfjndpddj = '';
                var v_sfcxsc = '';//0不重新生成1重新生成
                var v_url = basePath + "jsp/supervision/lhfj/lhfjqueren.jsp";
                sy.modalDialog({
                    title: '选择结果',
                    param: {
                        caozuokind: prm_pdjgscfs,
                        time: new Date().getMilliseconds()
                    }
                    , area: ['100%', '100%']
                    , content: v_url
                }, function (dialogID) {
                    var obj = sy.getWinRet(dialogID);
                    if (obj != null) {
                        var time=''+new Date().getFullYear();
                        v_lhfjndpddj = obj.lhfjndpddj;
                        v_sfcxsc = obj.sfcxsc;
                        var url = basePath + "/lhfj/saveCreateNddj?pdjgscfs=" + prm_pdjgscfs +
                        "&lhfjndpddj=" + v_lhfjndpddj + "&sfcxsc=" + v_sfcxsc +
                        "&time=" + new Date().getMilliseconds();

                        var formData = {'myLhfjtjGridchecked': $.toJSON([{'comid':singleData.comid,'checkyear':time}])};
                        $.post(url, formData, function (result) {
                            result = $.parseJSON(result);
                            if (result.code == '0') {
                                layer.msg('生成成功', {time: 500}, function () {
                                    query();
                                });
                            } else {
                                layer.open({
                                    title: '提示'
                                    , content: '生成失败' + result.msg
                                });
                            }
                        });
                        sy.removeWinRet(dialogID);//不可缺少
                    } else {
                        return false;
                    }
                });
                layer.close(index);
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

        //执行检查
        function zxjc(data) {
            sy.modalDialog({
                title: '选择检查计划'
                , area: ['100%', '100%']
                , param: {
                    comdalei: data.comdalei
                    , comid: data.comid
                }
                , content: basePath + 'supervision/plansIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                if (k != null && k != '') {
                    if (k.type === 'ok') {

                        sy.modalDialog({
                            title: '现场检查'
                            , area: ['100%', '100%']
                            , param: {
                                planid: k.data.planid
                                , comid: data.comid
                                , mark: 'qyjc'
                            }
                            , content: basePath + 'aqgl/jclsIndex'
                            , btn: ['关闭']
                        }, function (dialogID) {
                            var k = sy.getWinRet(dialogID);
                            if (k != null && k != '') {
                                if (k.type === 'ok') {

                                }
                            }

                            sy.removeWinRet(dialogID);
                        });
                    }
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
            <ck:permission biz="zxjc">
                <button class="layui-btn" data-type="zxjc" data="btn_zxjc">执行检查</button>
            </ck:permission>
            <ck:permission biz="handCreateNddj">
                <button class="layui-btn" data-type="handCreateNddj" data="btn_handCreateNddj">手动生成年度等级</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="pcompanyTable" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>