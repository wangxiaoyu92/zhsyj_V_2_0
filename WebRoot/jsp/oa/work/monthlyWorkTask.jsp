<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
    <title>月度工作台账管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <style>


        .layui-table-cell {
            height: auto;
            line-height: 28px;
            padding: 0 15px;
            position: relative;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: normal;
            box-sizing: border-box;
        }
    </style>
    <script type="text/javascript">

        var v_confirm = [{"id":"","text":"===请选择==="},{"id":"0","text":"未确认"},{"id":"2","text":"已确认"}];
        var v_process = [

            {"value":'10',"label":"科员未填写"},
            {"value":'11',"label":"科员已填写"},

            {"value":'20',"label":"！科室副领导审批未通过"},
            {"value":'21',"label":"科室副领导审批通过"},

            {"value":'30',"label":"！科室正领导审批未通过"},
            {"value":'31',"label":"科室正领导审批通过"},

            {"value":'40',"label":"！分管局领导审批未通过"},
            {"value":'41',"label":"分管局领导审批通过"},

            {"value":'50',"label":"！局领导审批未通过"},
            {"value":'51',"label":"局领导审批通过"},
            {"value":'60',"label":"！办公室驳回"},
            {"value":'61',"label":"办公室确认通过"},
        ];

        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        $(function () {
            layui.use(['form', 'table', 'layer', 'element', 'laydate'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#plandate'
                    ,type: 'month'
                    , range: '~'
                    , done: function (value, date, endDate) {
                        var val = value.split('~');
                        $('#start').val(val[0]);
                        $('#end').val(val[1]);
                    }
                });
                table.render({
                    elem: '#monthlyWorkTask'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/work/task/queryMonthlyWorkTask'
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
                        {field: 'orgname', width: 110, title: '科室', event: 'trclick'}
                        , {field: 'workTaskNo', width: 50, title: '序号', event: 'trclick'}
                        , {field: 'workTaskContent', width: 200, title: '工作任务', event: 'trclick'}
                        , {field: 'workTaskStep', width: 400, title: '工作措施', event: 'trclick'}
                        , {field: 'workTaskWeight', width: 50, title: '权重', event: 'trclick'}
                        , {field: 'wcsx', width: 200, title: '完成时限', event: 'trclick'}
                        , {field: 'workTaskStDate', width: 100, title: '开始时间', event: 'trclick'}
                        , {field: 'workTaskEdDate', width: 100, title: '结束时间', event: 'trclick'}
                        , {field: 'workScheduleDescribe', width: 200, title: '工作描述', event: 'trclick'}
                        , {field: 'jd1', width: 70, title: '进度', event: 'trclick'}
                        , {field: 'workScheduleConfirm', width: 100, title: '审核确认进度'
                            , templet: function (d) {
                                if (d.workScheduleConfirm==undefined) {
                                    return "";
                                } else {
                                    if (d.workScheduleConfirm.length != 2) {
                                        return '<span style="color:blue;">参数未配置</span>';
                                    }
                                    var undefined_flag = true;
                                    for (var i = 0; i < v_process.length; i++) {
                                        var _p = v_process[i];
                                        if (_p.value == d.workScheduleConfirm) {

                                            if (_p.value.length == 2) {
                                                undefined_flag = false;
                                                if (_p.value.split('')[1] == '1') {
                                                    return '<span style="color:green;">' + _p.label + '</span>';
                                                } else {
                                                    return '<span style="color:red;">' + _p.label + '</span>';
                                                }
                                            }


                                        }
                                    }
                                    if (undefined_flag) {
                                        return '<span style="color:blue;">参数未配置</span>';
                                    }
                                }
                            }

                            , event: 'trclick'
                        }
                        , {field: 'workTaskDutyPerson', width: 100, title: '责任人', event: 'trclick'}
                        , {field: 'workTaskDutyLeader', width: 100, title: '责任领导', event: 'trclick'}


                    ]]
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.workTaskId) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.workTaskId;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addMonthlyWork: function () { // 添加
                        addMonthlyWork();
                    }
                    , upMonthlyWork: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的月度工作台账！');
                        } else {
                            upMonthlyWork(table.singleData.workTaskId);
                        }
                    }
                    , delMonthlyWork: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的月度工作台账！');
                        } else {
                            delMonthlyWork(table.singleData.workTaskId);
                        }
                    }
                    , showMonthlyWork: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要查看的月度工作台账！');
                        } else {
                            showMonthlyWork(table.singleData.workTaskId);
                        }
                    }
                    , showMonthlyWorkSchedule: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要设置的月度工作台账！');
                        } else {
                            showMonthlyWorkSchedule(table.singleData.workTaskId);
                        }
                    }
                    , eaxmSchedule: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要审核的月度工作台账！');
                        } else {
                            eaxmSchedule(table.singleData.workTaskId,table.singleData.workScheduleConfirm);
                        }
                    }
                    , bgsSchedule: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要办公室确认的月度工作台账！');
                        } else {
                            bgsSchedule(table.singleData.workTaskId,table.singleData.workScheduleConfirm);
                        }
                    }  , cxsbSchedule: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要重新上报的月度工作台账！');
                        } else {
                            cxsbSchedule(table.singleData.workScheduleId,table.singleData.workScheduleConfirm);
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
        });

        function query() {
            table.singleData = '';
            selectTableDataId = '';
            var orgname = $('#orgname').val();
            var start = $('#start').val();
            var end = $('#end').val();
            var param = {
                'orgname': orgname,
                'end': end,
                'start': start
            };
            table.reload('monthlyWorkTask', {
                url: basePath + '/work/task/queryMonthlyWorkTask'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
            });
        }

        // 刷新
        function refresh() {
            window.location.reload();
        }

        function cxsbSchedule(workScheduleId,workScheduleConfirm) {
            if(workScheduleConfirm==undefined||workScheduleConfirm==0){
                layer.msg('未设置工作进度的工作台账不能重新上报');
            }else {
                var confirm=workScheduleConfirm.substring(1,2);
                if(confirm==1){
                    layer.msg('审批通过的工作台账不能重新上报');
                }else if(confirm==0){
                    layer.open({
                        title: '确认'
                        , content: '你确定要重新上报该条工作台账吗？'
                        , btn: ['确定', '取消'] //可以无限个按钮
                        , btn1: function (index, layero) {
                            $.post(basePath + '/work/task/cxsbTask', {
                                    workScheduleId: workScheduleId
                                },
                                function (result) {
                                    if (result.code == '0') {
                                        layer.msg('重新上报成功', {time: 1000
                                        }, function () {
                                            query();
                                            table.singleData = '';
                                            selectTableDataId = '';
                                        });
                                    } else {
                                        layer.open({
                                            title: "提示",
                                            content: "重新上报失败：" + result.msg //这里content是一个普通的String
                                        });
                                    }
                                },
                                'json');
                        }
                    });
                }

            }

        }
        // 新增月度工作台账
        function addMonthlyWork() {
            sy.modalDialog({
                title: '添加月度工作台账'
                , area: ['1100px', '600px']
                , content: basePath + '/work/task/workFormIndex?op=add'
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
                table.reload('monthlyWorkTask', {url: basePath + '/work/task/queryMonthlyWorkTask'});
                table.singleData = '';
                selectTableDataId = '';
            }
        }
        //编辑月度工作台账
        function upMonthlyWork(workTaskId) {
            sy.modalDialog({
                title: '编辑月度工作台账'
                , area: ['1100px', '600px']
                , content: basePath + '/work/task/workFormIndex?workTaskId=' + workTaskId
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        };

        //设置工作进度
        function showMonthlyWorkSchedule(workTaskId) {
            $.post(basePath + '/work/task/queryWorkSchedule', {
                    workTaskId:workTaskId
                },
                function (result) {
                    if (result.code == '0') {
                        var mydata = result.data;
                         var workSchedulePercent;
                         if(mydata!=null) {
                             workSchedulePercent = mydata.workSchedulePercent;
                         }
                         else{
                                 workSchedulePercent = 0;
                             }
                        sy.modalDialog({
                            title: '设置工作进度'
                            , area: ['1100px', '600px']
                            , content: basePath + '/work/task/workScheduleFormIndex?op=view&workTaskId='+workTaskId+'&workSchedulePercent='+workSchedulePercent
                            , btn: ['保存', '取消']
                            , btn1: function (index, layero) {
                                window[layero.find('iframe')[0]['name']].submitForm();
                            }
                        }, closeModalDialogCallback);
                    } else {
                        sy.modalDialog({
                            title: '设置工作进度'
                            , area: ['1100px', '600px']
                            , content: basePath + '/work/task/workScheduleFormIndex?op=view&workSchedulePercent=0&workTaskId=' + workTaskId
                            , btn: ['保存', '取消']
                            , btn1: function (index, layero) {
                                window[layero.find('iframe')[0]['name']].submitForm();
                            }
                        }, closeModalDialogCallback);
                    }
                }, 'json');

        };

        //审核工作进度
        function eaxmSchedule(workTaskId,workScheduleConfirm) {
            if(workScheduleConfirm==undefined){
                layer.msg('未设置工作进度的工作台账不能审核');
            }else {
                $.post(basePath + '/work/task/queryWorkSchedule', {
                        workTaskId: workTaskId
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            var userposition = (parseInt(result.userposition) - 1) * 10 + 1;
                            if(workScheduleConfirm!=userposition&&userposition!='21'){
                                layer.msg('没有审核权限');
                            }else {
                                var workSchedulePercent;
                                if (mydata != null) {
                                    workSchedulePercent = mydata.workSchedulePercent;
                                }
                                else {
                                    workSchedulePercent = 0;
                                }
                                sy.modalDialog({
                                    title: '审核'
                                    ,
                                    area: ['1100px', '600px']
                                    ,
                                    content: basePath + '/work/task/workScheduleFormIndex?op=shenhe&workTaskId=' + workTaskId + '&workSchedulePercent=' + workSchedulePercent
                                    ,
                                    btn: ['保存', '取消']
                                    ,
                                    btn1: function (index, layero) {
                                        window[layero.find('iframe')[0]['name']].submitForm();
                                    }
                                }, closeModalDialogCallback);
                            }
                        } else {
                            sy.modalDialog({
                                title: '设置工作进度'
                                ,
                                area: ['1100px', '600px']
                                ,
                                content: basePath + '/work/task/workScheduleFormIndex?workSchedulePercent=0&workTaskId=' + workTaskId
                                ,
                                btn: ['保存', '取消']
                                ,
                                btn1: function (index, layero) {
                                    window[layero.find('iframe')[0]['name']].submitForm();
                                }
                            }, closeModalDialogCallback);
                        }
                    }, 'json');
            }
        };

        //审核工作进度
        function bgsSchedule(workTaskId,workScheduleConfirm) {
            if(workScheduleConfirm==undefined){
                layer.msg('未设置工作进度的工作台账不能办公室确认');
            }else if(workScheduleConfirm==41||workScheduleConfirm==51){
                $.post(basePath + '/work/task/queryWorkSchedule', {
                        workTaskId: workTaskId
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            var userposition = (parseInt(result.userposition) - 1) * 10 + 1;
                                var workSchedulePercent;
                                if (mydata != null) {
                                    workSchedulePercent = mydata.workSchedulePercent;
                                }
                                else {
                                    workSchedulePercent = 0;
                                }
                                sy.modalDialog({
                                    title: '办公室确认'
                                    ,
                                    area: ['1100px', '600px']
                                    ,
                                    content: basePath + '/work/task/workScheduleFormIndex?workTaskId=' + workTaskId + '&workSchedulePercent=' + workSchedulePercent
                                    ,
                                    btn: ['保存', '取消']
                                    ,
                                    btn1: function (index, layero) {
                                        window[layero.find('iframe')[0]['name']].submitForm();
                                    }
                                }, closeModalDialogCallback);
                            }

                    }, 'json');
            }else{
                layer.msg('审核进度未到办公室确认');
            }
        };


        // 删除
        function delMonthlyWork(workTaskId) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/work/task/delTask', {
                            workTaskId: workTaskId
                        },
                        function (result) {
                            if (result.code == '0') {
                                layer.msg('删除成功', {time: 1000
                                }, function () {
                                    /*table.reload('monthlyWorkTask', {url: basePath + '/work/task/queryMonthlyWorkTask'});*/
                                    query();
                                    table.singleData = '';
                                    selectTableDataId = '';
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

        //查看月度工作台账
        function showMonthlyWork(workTaskId) {
            sy.modalDialog({
                title: '查看月度工作台账'
                , area: ['1100px', '600px']
                , content: basePath + '/work/task/workFormIndex?op=view&workTaskId=' + workTaskId
                , btn: ['关闭']
            });
        };

        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['900px', '470px']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true",
                    comjyjcbz: ""
                }
                , content: basePath + 'work/task/departmentIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if(obj==null||obj==''){
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#orgname").val(myrow.orgname); //科室名称
                    $("#orgid").val(myrow.orgid); //科室代码
                }
            });
        }
        /*
         //打印
         function print(){
         sy.doPrint('siweb/sysuser.cpt','')
         } 	*/
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>
            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: 90px">
                    <div class="layui-form-item">
                        <div class="layui-inline" style="width: auto">
                            <label class="layui-form-label">月份</label>

                            <div class="layui-input-inline">
                                <input type="text" id="plandate"
                                       class="layui-input">
                            </div>
                            <input type="text" name="start" id="start"
                                   hidden="hidden">
                            <input type="text" name="end" id="end"
                                   hidden="hidden">
                        </div>
                        <div class="layui-inline" style="width: auto">
                            <label class="layui-form-label">科室:</label>
                            <div class="layui-input-inline" >
                                <input type="text" id="orgname" name="orgname" readonly
                                       autocomplete="off" class="layui-input">
                                <input id="orgid" name="orgid" type="hidden">
                            </div>
                            <div class="layui-input-inline" style="width: 110px">
                                <a href="javascript:void(0)" class="layui-btn"
                                   iconCls="icon-search" onclick="myselectcom()">选择科室 </a>
                            </div>
                        </div>
                    </div>

                    <div class="layui-col-md2 layui-col-xs8 layui-col-sm4 layui-col-md-offset5 layui-col-xs-offset2 layui-col-sm-offset4">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 190px"></label>
                            <div class="layui-input-inline" style="margin-top: -15px;margin-left: -160px">
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
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addMonthlyWork">
                <button class="layui-btn" data-type="addMonthlyWork" data="btn_addMonthlyWork">增加</button>
            </ck:permission>
            <ck:permission biz="upMonthlyWork">
                <button class="layui-btn" data-type="upMonthlyWork" data="btn_upMonthlyWork">编辑</button>
            </ck:permission>
            <ck:permission biz="delMonthlyWork">
                <button class="layui-btn layui-btn-danger" data-type="delMonthlyWork" data="btn_delMonthlyWork">删除</button>
            </ck:permission>
            <ck:permission biz="showMonthlyWork">
                <button class="layui-btn " data-type="showMonthlyWork" data="btn_showMonthlyWork">查看</button>
            </ck:permission>
            <ck:permission biz="showMonthlyWorkSchedule">
                <button class="layui-btn " data-type="showMonthlyWorkSchedule" data="btn_showMonthlyWorkSchedule">设置工作进度</button>
            </ck:permission>
            <ck:permission biz="eaxmSchedule">
                <button class="layui-btn " data-type="eaxmSchedule" data="btn_eaxmSchedule">审核</button>
            </ck:permission>
            <ck:permission biz="bgsSchedule">
                <button class="layui-btn " data-type="bgsSchedule" data="btn_bgsSchedule">办公室确认</button>
            </ck:permission>
            <%--<ck:permission biz="cxsbSchedule">--%>
                <button class="layui-btn " data-type="cxsbSchedule" data="btn_cxsbSchedule">重新上报</button>
          <%--  </ck:permission>--%>
        </div>
        <table class="layui-hide" id="monthlyWorkTask" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>