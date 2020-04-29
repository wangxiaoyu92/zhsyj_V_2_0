<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String v_comdalei = StringHelper.showNull2Empty(request.getParameter("comdalei"));  //企业大类
    String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));  //企业id
%>
<!DOCTYPE html>
<html>
<head>
    <title>检查计划管理</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        // 执法计划类别
        var planchecktype = <%=SysmanageUtil.getAa10toJsonArray("ITEMTYPE")%>;
        var form;
        var laydate;
        var table;
        var selectNodes;
        var selectTableDataId = '';
        // 初始化数据
        var mask;//进度条
        var layer;

        function initData() {

            layui.use(['form', 'laydate', 'table', 'element', 'layer'], function () {
                form = layui.form;
                laydate = layui.laydate;
                layer = layui.layer;
                table = layui.table;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#planTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + "supervision/queryPlan"
                    , where:{
                        comdalei:'<%=v_comdalei%>',
                        comid:'<%=v_comid%>',
                        querytype:'zongHeJianchaJihuaGuanli'
                    }
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [20, 30, 40] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'plantitle', width: 450, title: '名称', event: 'trclick'}
                        , {field: 'plancode', width: 140, title: '编号', event: 'trclick'}
                        , {
                            field: 'planchecktype', width: 100, title: '检查类别',
                            templet: function (d) {
                                return '<span style="color:blue;">'
                                        + formatGridColData(planchecktype, d.planchecktype) + '</span>';
                            }, event: 'trclick'
                        }
                        , {
                            field: 'plantype', width: 100, title: '计划类型'
                            , templet: function (d) {
                                if (d.plantype == "1") {
                                    return '<span style="color:blue">按类别</span>';
                                } else if (d.plantype == "2") {
                                    return '<span style="color:blue">按区域</span>';
                                } else if (d.plantype == "3") {
                                    return '<span style="color:blue">按特定对象</span>';
                                } else {
                                    return "";
                                }
                            }, event: 'trclick'
                        }
                        , {field: 'planstdate', width: 110, title: '开始时间', event: 'trclick'}
                        , {field: 'planeddate', width: 110, title: '结束时间', event: 'trclick'}
                        , {field: 'planoperatedate', width: 120, title: '经办时间', event: 'trclick'}
                        , {field: 'plancheckingcount', width: 150, title: '正在实施中的检查数', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.planid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.planid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                //按钮
                var $ = layui.$, active = {
                    addPlansIndex: function () { // 添加
                        addPlansIndex();
                    }
                    , updatePlansIndex: function () { // 编辑
                        if (!table.singleData) {
                            layer.alert('请选择要修改的计划！');
                        } else {
                            updatePlansIndex(table.singleData.planid, table.singleData.plantypearea,table.singleData.plancheckingcount);
                        }
                    }
                    , setPlanScope: function () { // 设置执行范围
                        if (!table.singleData) {
                            layer.alert('请选择要设置执行范围的计划！');
                        } else {
                            setPlanScopeFun(table.singleData.planid, table.singleData.plancode, table.singleData.plantypearea);
                        }
                    }
                    , delPlan: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的计划！');
                        } else {
                            delPlan(table.singleData.planid);
                        }
                    }
                    , showPlan: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的计划！');
                        } else {
                            showPlan(table.singleData.planid, table.singleData.plantypearea);
                        }
                    }
                    , setTaskByPlan: function () { // 派发任务
                        if (!table.singleData) {
                            layer.alert('请选择要派发任务的计划！');
                        } else {
                            setTaskByPlan(table.singleData.planid);
                        }
                    }
                    , autoCreatePlans: function () {
                        funAutoCreatePlans();
                    }
                };
                //按钮监测
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });

                laydate.render({
                    elem: '#plandate'
                    , range: '~'
                    , done: function (value, date, endDate) {
                        var val = value.split('~');
                        $('#planstdate').val(val[0]);
                        $('#planeddate').val(val[1]);
                    }
                });
            });
        }

        $(function () {
            if('<%=v_comdalei%>'){
                $('.layui-btn-group').attr('style','display:none');
            }else{
                $('.layui-btn-group').removeAttr('style','display:none');
            }
            $('#btn_reset').click(function(){
                location.reload();
                return false;
            });
            initData();
            $("#btn_query").click(function () {//查询
                query();
                return false;
            });
        });
        // 关闭窗口
        var closeWindow = function ($dialog, $pjq) {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };
        //确定
        function queding() {
            var obj = new Object();
            obj.type = "ok";
            obj.data=table.singleData;
            sy.setWinRet(obj);
            closeWindow();
        }

        // 查询
        function query() {
            var plantype = $("#plantype").val();
            var planstdate = $('#planstdate').val();
            var planeddate = $('#planeddate').val();
            var plantitle = $('#plantitle').val();
            var param = {
                'plantype': plantype,
                'planstdate': planstdate,
                'planeddate': planeddate,
                'plantitle': plantitle,
                comdalei:'<%=v_comdalei%>'
            };
            table.singleData = '';
            selectTableDataId = '';
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('planTable', {
                where: param
                , done: function (res, curr, count) {
                    layer.close(mask);
                }
            });
        }

        // 新增
        function addPlansIndex() {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '新增计划信息'
                , content: basePath + '/supervision/addPlansIndex'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        // 编辑信息
        function updatePlansIndex(planid, plantypearea,plancheckingcount) {
         //   var state = getResultNum(planid);
           // if (!state) {//可以修改
            //plancheckingcount=0;
            if (plancheckingcount==0){
//                String v_canedit="1";
//                if (state) {
//                    v_canedit="0";
//                }

                sy.modalDialog({
                    area: ['100%', '100%']
                    , title: '编辑计划信息'
                    , content: basePath + '/supervision/updatePlansIndex?op=edit&planid='
                    + planid + '&plantypearea=' + plantypearea
                    , btn: ['保存', '取消'] //可以无限个按钮
                    , btn1: function (index, layero) {
                        window[layero.find('iframe')[0]['name']].submitForm();
                    }
                }, closeModalDialogCallback);
            }else{//不可修改
                sy.modalDialog({
                    area: ['100%', '100%']
                    , title: '查看计划信息'
                    , content: basePath + '/supervision/updatePlansIndex?op=edit&planid='
                    + planid + '&plantypearea=' + plantypearea
                    , btn: [] //可以无限个按钮
                });
            }
        }

        // 删除
        function delPlan(planid) {
            var state = getResultNum(planid);
            if (!state) {
                layer.open({
                    title: '警告!'
                    , icon: '3'
                    , btn: ['确定', '取消']
                    , content: '您确定要删除该计划吗'
                    , btn1: function (index, layero) {
                        $.post(basePath + 'supervision/delPlan', {
                                    planid: planid
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
                                            if (table.cache.planTable.length == 1) {
                                                curent = curent - 1;
                                            }
                                           var param={ comdalei:'<%=v_comdalei%>'};
                                            refresh(param, curent);
                                        });
                                    } else {
                                        layer.msg('删除失败' + result.msg);
                                    }
                                },
                                'json');
                    }
                });
            }
        }

        // 刷新
        function refresh(param, cur) {
            table.singleData = '';
            selectTableDataId = '';
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('planTable', {
                url: basePath + 'supervision/queryPlan'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    layer.close(mask);
                }
            });
            /*		parent.window.refresh();*/
        }

        //设置范围
        function setPlanScopeFun(planid, plancode, plantypearea) {
            var state = getResultNum(planid);
            if (!state) {
                sy.modalDialog({
                    area: ['100%', '100%']
                    , title: '设置执行范围'
                    , content: basePath + '/supervision/setPlanScope?planid='
                    + planid + '&plancode=' + plancode + '&plantypearea=' + plantypearea
                    , btn: ['保存', '取消'] //可以无限个按钮
                    , btn1: function (index, layero) {
                        window[layero.find('iframe')[0]['name']].submitForm();
                    }
                }, closeModalDialogCallback);
            }
        }

        //子页面返回参数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return false;
            }
            sy.removeWinRet(dialogID);
            var param={ comdalei:'<%=v_comdalei%>'};
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();

                refresh(param, curent);
            } else {
                refresh(param, '');
            }
        }

        //查看信息
        function showPlan(planid, plantypearea) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看计划信息'
                , content: basePath + '/supervision/updatePlansIndex?op=view&planid='
                + planid + '&plantypearea=' + plantypearea
                , btn: ['关闭'] //可以无限个按钮
            })
        }

        //查询计划下的结果个数
        function getResultNum(planid) {
            var state = false;
            $.ajax({
                url: basePath + 'supervision/checkresult/getResultNumByPlanid',
                data: {planid: planid},
                dataType: 'json',
                async: false,//必须同步，不然取不到成功之后返回值
                error: function () {
                    layer.alert("网络连接异常");
                },
                success: function (result) {
                    if (result.code == '0') {
                        var total = result.total;
                        if (total > 0) {
                            state = true;
                            layer.alert("本计划已经在实施中，不能对其相关信息操作");
                        }
                    }
                }
            });
            return state;
        }

        // 派发任务
        function setTaskByPlan(planid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '派发任务'
                , content: basePath + "jsp/supervision/setTaskByPlan.jsp"
                , param: {
                    planid: planid,
                    a: new Date().getMilliseconds()
                }
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].save();
                }
            }, closeModalDialogCallback);
        }


        // 自动生成检查计划
        function funAutoCreatePlans() {
            var dialog = sy.modalDialog({
                area: ['100%', '100%'],
                title: '批量生成检查计划',
                content: basePath + 'jsp/supervision/autoCreatePlans.jsp',
                btn: ['确定', '取消'], //可以无限个按钮
                btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].autoCreatePlans();
                },
                btn2: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].closeWindow();
                }
            }, closeModalDialogCallback)
        }

    </script>
</head>
<body>
<div class="layui-fluid">
    <%--<input type="text" id="comdalei" name="comdalei" value="<%=v_comdalei%>">--%>
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form id="myqueryform" class="layui-form" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">计划名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" name="plantitle" id="plantitle" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">类型</label>

                                    <div class="layui-input-inline">
                                        <select id="plantype" name="plantype">
                                            <option value="">--请选择--</option>
                                            <option value="1">按类别</option>
                                            <option value="2">按区域</option>
                                            <option value="3">按特定对象</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">执法开始时间</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="plandate" class="layui-input">
                                    </div>
                                    <input type="text" name="planstdate" id="planstdate" hidden="hidden">
                                    <input type="text" name="planeddate" id="planeddate" hidden="hidden">
                                </div>
                            </div>
                            <div class="layui-col-md2 layui-col-xs8 layui-col-sm4 layui-col-md-offset5 layui-col-xs-offset2 layui-col-sm-offset4">
                                <div class="layui-form-item">
                                    <%--<label class="layui-form-label"></label>--%>

                                    <div class="layui-input-inline">
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
            <ck:permission biz="addPlansIndex">
                <button class="layui-btn" data-type="addPlansIndex" data="btn_addPlansIndex">增加</button>
            </ck:permission>
            <ck:permission biz="updatePlansIndex">
                <button class="layui-btn" data-type="updatePlansIndex" data="btn_updatePlansIndex">编辑</button>
            </ck:permission>
            <ck:permission biz="setPlanScope">
                <button class="layui-btn" data-type="setPlanScope" data="btn_setPlanScope">设置执行范围
                </button>
            </ck:permission>
            <ck:permission biz="showPlan">
                <button class="layui-btn" data-type="showPlan" data="btn_showPlan">查看
                </button>
            </ck:permission>
            <ck:permission biz="delPlan">
                <button class="layui-btn layui-btn-danger" data-type="delPlan" data="btn_delPlan">删除
                </button>
            </ck:permission>
            <ck:permission biz="setTaskByPlan">
                <button class="layui-btn" data-type="setTaskByPlan" data="btn_setTaskByPlan">派发任务</button>
            </ck:permission>
            <ck:permission biz="autoCreatePlans">
                <button class="layui-btn" data-type="autoCreatePlans" data="btn_autoCreatePlans">批量生成检查计划</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="planTable" lay-filter="paramgridfilter"></table>
    </div>
</div>
</body>
</html>