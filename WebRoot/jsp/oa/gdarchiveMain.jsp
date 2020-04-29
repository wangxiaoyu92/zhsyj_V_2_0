<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page
        import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://"
                + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath()
                + "/";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>文档管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var table;
        var layer;
        var element;
        var mask;
        var selectTableDataId = '';
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form, table = layui.table, layer = layui.layer, element = layui, element;
                mask = layer.load('1', {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#docTable'
                    , url: basePath + '/egovernment/archive/queryGdarchive'
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
                        {field: 'filecode', width: 230, title: '公文编码', event: 'trclick'}
                        , {field: 'filetitle', width: 250, title: '公文标题', event: 'trclick'}
                        , {field: 'fileremark', width: 230, title: '备注', event: 'trclick'}
                        , {field: 'fileopperuser', width: 230, title: '操作人', event: 'trclick'}
                        , {field: 'fileopperdate', width: 250, title: '操作时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }

                })
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.fileid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.fileid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    delPcom: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要删除的文档！！');
                        } else {
                            delDoc(table.singleData.fileid);
                        }
                    },
                    showPcom: function () {
                        if (!table.singleData) {
                            layer.alert("请先选择要查看的文档！")
                        } else {
                            showDoc(table.singleData.fileid,table.singleData.messagetype);
                        }
                    },
                    slrzPcom: function () {
                        if (!table.singleData) {
                            layer.alert("请先选择要查看受理日志的文档！")
                        } else {
                            shoulirizhi(table.singleData.fileid);
                        }
                    }
                }
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            })


        });
        //根据参数查询
        function query() {
            var param = {
                'filetitle': $('#filetitle').val(),
                'fileopperuser': $('#fileopperuser').val()
            };
            refresh(param, '');
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
            table.reload('docTable', {
                url: basePath + '/egovernment/archive/queryGdarchive'
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
        //	// 刷新
        //	function refresh(){
        //		parent.window.refresh();
        //	}
        //查看项目信息
        function showDoc(fileid,messagetype) {
            /*layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                , title: '查看信息'
                , content: basePath + 'egovernment/archive/archiveFormIndex?op=view&archiveid=' + fileid
                , btn: ['关闭']
            });*/
            if(messagetype=="2") {
                sy.modalDialog({
                    title: '查看信息'
                    , area: ['100%', '100%']
                    , content: basePath + 'egovernment/archive/archiveswEditFormIndex?op=view&archiveid=' + fileid
                    , btn: ['关闭']
                });
            }else{
                sy.modalDialog({
                    title: '查看信息'
                    , area: ['100%', '100%']
                    , content: basePath + 'egovernment/archive/archiveFormIndex?op=view&archiveid=' + fileid
                    , btn: ['关闭']
                });
            }
        }
        // 删除
        function delDoc(fileid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/egovernment/archive/delgdArchive', {
                                fileid: fileid
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
                                        if (table.cache.docTable.length == 1) {
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
        function shoulirizhi(fileid){

            var url=basePath+'workflow/wfywlclogIndex';

            /*var dialog = parent.sy.modalDialog({
                title:'受理日志',
                param : {
                ywbh:table.singleData.archiveid,
                time :new Date().getMilliseconds()
                },
                width:1200,
                height:600,
                url:url,
            },function (dialogID){
                var obj = sy.getWinRet(dialogID);//不可缺少
                if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){ //传递回的type为ok的时候才刷新页面。
                //window.location.reload();
                //shuaxindata();
                }
            })*/
            sy.modalDialog({
                title: '受理日志'
                , area: ['100%', '100%']
                , param: {
                    ywbh: fileid
                }
                , content: url
                , btn: [ '关闭']
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok') { //传递回的type为ok的时候才刷新页面。
                    //window.location.reload();
                    //shuaxindata();

                }
            });

        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show" style="height: auto">
                <form id="myqueryform" class="layui-form">
                    <div class="layui-row">
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label">标题</label>

                                <div class="layui-input-inline">
                                    <input type="text" name="filetitle" id="filetitle" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label">操作员</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="fileopperuser" name="fileopperuser"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
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
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="showPcom">
                <button class="layui-btn " data-type="showPcom" data="btn_showPcom">查看</button>
            </ck:permission>
            <ck:permission biz="delPcom">
                <button class="layui-btn layui-btn-danger" data-type="delPcom" data="btn_delPcom">删除</button>
            </ck:permission>
            <ck:permission biz="delPcom">
            <button class="layui-btn " data-type="slrzPcom" data="btn_slrzPcom" >受理日志</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="docTable" lay-filter="tableFilter">
            <input type="hidden" name="fileid" id="fileid">
            <input type="hidden" name="filekey" id="filekey">
            <input type="hidden" name="filecontent" id="filecontent">
        </table>
    </div>
</div>
</body>
</html>
