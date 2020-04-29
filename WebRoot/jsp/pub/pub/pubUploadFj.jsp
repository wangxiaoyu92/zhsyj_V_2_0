<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%--<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>--%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser,com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath + "/";
%>
<%
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));
    String v_fjcsdmz = StringHelper.showNull2Empty(request.getParameter("fjcsdmz"));

    Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userid = vSysUser.getUserid();
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>文件上传组件</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
    <script type="text/javascript">

        var v_tabUploadFjList;
        var selectTableDataId = '';
        var form;
        var table;
        var layer;
        var fjpath = [];
        var fjname = [];
        $(function () {
            var a = '图片', b = 'jpg,jpeg,png,gif';
            if ('JCJGFJ' == '<%=v_dmlb%>') {
                a = '文件';
                b = 'pdf'
            }
            //构造文件上传容器
            $("#uploader").pluploadQueue({
                runtimes: 'html5,flash',//设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html4
                flash_swf_url: '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.flash.swf',// Flash环境路径设置
                silverlight_xap_url: '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.silverlight.xap',//silverlight环境路径设置
                url: '<%=contextPath%>/servlet/UploadServlet?folderName=<%=v_dmlb%>',//上传文件URL
                max_file_size: '10mb',//100b, 10kb, 10mb, 1gb
                chunk_size: '1mb',//分块大小，小于这个大小的不分块
                unique_names: true,//生成唯一文件名
                // 如果可能的话，压缩图片大小
                // resize : { width : 320, height : 240, quality : 90 },
                // 指定要浏览的文件类型
                filters: [{
                    title: a,
                    extensions: b
                    //extensions: "zip,doc,docx,xls,xlsx,ppt,pptx,txt,jpg,jpeg,png,gif"
                }],
                init: {
                    FileUploaded: function (up, file, info) {//文件上传完毕触发
                        var response = $.parseJSON(info.response);
                        if (response.status) {
                            fjpath.push(response.fileUrl);
                            fjname.push(file.name);
                        }
                    }
                }
            });
            initData();
            //lay ui上传
            <%--var url = '<%=contextPath%>/servlet/UploadServlet?folderName=<%=v_dmlb%>';//上传文件URL
            var status = $("#fm").validationEngine("validate");
            layui.use('upload', function (status) {
                var $ = layui.jquery;
                upload = layui.upload;

                upload.render({
                    elem: '#test10'
                    , url: url
                    , data: {'name':status}
                    , done: function (res) {
                        alert('上传完成回调');
                    }

                });
            });--%>
        });
        //初始化附件列表
        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: '<%=basePath%>pub/pub/querySCFjListDetail'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , where: {
                        ajdjid: '<%=v_ajdjid%>',
                        fjcsdmz: '<%=v_fjcsdmz%>'
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'fjwid', title: '编号', event: 'trclick'}
                        , {field: 'fjcsdmz', title: '附件参数代码值', event: 'trclick'}
                        , {field: 'fjcsdmmc', title: '附件名称', event: 'trclick'}
                        , {field: 'fjname', title: '上传文件名', event: 'trclick'}
                        , {field: 'fjczyxm', title: '操作员', event: 'trclick'}
                        , {field: 'fjczsj', title: '操作时间', event: 'trclick'}
                    ]]
                });
                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.fjid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.fjid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    chakanFuJian: function () { // 查看
                        if (!table.singleData) {
                            parent.layer.alert('请选择要查看的附件！');
                        } else {
                            chakanFuJian(table.singleData.fjwid, table.singleData.fjcsdmz, table.singleData.fjid);
                        }
                    }
                    , deleteFuJian: function () { // 删除
                        if (!table.singleData) {
                            parent.layer.alert('请选择要删除的附件！');
                        } else {
                            deleteFuJian(table.singleData.fjid);
                        }
                    }
                };
                $('.demoTable1 .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                $('.demoTable2 .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            $('#btnSave').click(function () {
                uploadFj();
            })
        }

        //查看附件
        function chakanFuJian(v_fjwid, v_fjcsdmz, v_fjid) {

            var v_dmlb='<%=v_dmlb%>';
            var url = "<%=contextPath %>/pub/pub/pubUploadFjViewIndex?fjwid=" + v_fjwid + "&fjcsdmz=" + v_fjcsdmz + "&fjid=" + v_fjid + "&dmlb="+v_dmlb+"&time=" + new Date().getMilliseconds();
            parent.layer.open({
                type: 2
                , title: '查看附件'
                , area: ['100%', '100%']
                , content: url
                ,btn:['关闭']
            })
        }

        //删除附件
        function deleteFuJian(v_fjid) {
            parent.layer.open({
                title: '警告!'
                , icon: 3
                , btn: ['确定', '取消']
                , content: '确定删除此附件吗？'
                , yes: function (index, layero) {
                    $.post(basePath + '/pub/pub/uploadFjdel', {
                                fjid: v_fjid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    parent.layer.msg('删除成功', {
                                        time: 1000
                                    }, function (index) {
                                        parent.layer.close(index);
                                        window.location.reload();

                                    });
                                } else {
                                    parent.layer.open({
                                        content: "删除失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            },
                            'json');
                }
            });
        }

        //上传附件
        var uploadFj = function () {
            var status = $("#fm").validationEngine("validate");
            if (status) { //表单验证通过
//                $('#btnSave').linkbutton('disable');//

                var uploader = $('#uploader').pluploadQueue();
                if (uploader.files.length > 0) {// 判断队列中是否有文件需要上传
                    uploader.bind('StateChanged', function () {// 在所有的文件上传完毕时，提交表单
                        if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
                            //alert("您上传了：" + uploader.files.length + "个文件！");
                            //alert(fjpath);
                            //alert(fjname);
                            $('#fjpath').val(fjpath);
                            $('#fjname').val(fjname);

                            var formData = $("#fm").serialize();
                            $.ajax({
                                url: basePath + 'pub/pub/uploadFjsave?ajdjid=<%=v_ajdjid%>&fjcsdmz=<%=v_fjcsdmz%>&fjcsdmlb=<%=v_dmlb%>',
                                type: 'post',
                                async: true,
                                cache: false,
                                timeout: 100000,
                                data: formData,
                                dataType: 'json',
                                error: function () {
                                    layer.open({
                                        title: '提示'
                                        , content: '服务器繁忙，请稍后再试！'
                                        , yes: function (index, layero) {
                                            $('#btnSave').linkbutton('enable');
                                            layer.close(index);
                                        }
                                    });
                                },
                                success: function (result) {
                                    if (result.code == '0') {
                                        layer.open({
                                            title: '提示'
                                            , content: '上传成功'
                                            , yes: function (index, layero) {
                                                layer.close(index);
                                                window.location.reload();
                                            }
                                        });
                                    } else {
                                        layer.open({
                                            title: '提示'
                                            , content: '上传失败' + result.msg
                                            , yes: function (index, layero) {
                                                $('#btnSave').linkbutton('enable');
                                                layer.close(index);
                                            }
                                        });
                                    }
                                }
                            });
                        }
                    });
                    uploader.start();
                } else {
                    layer.alert('请至少选择一个文件进行上传！');
                    $('#btnSave').linkbutton('enable');//
                }
            }
        };


        //上传成功回显图片
        //        function showUploadFj() {
        //            if (fjpath.length > 0) {
        //                for (var i = 0; i < fjpath.length; i++) {
        //                    $('#picbox').append("<div style=\"float:left;text-align:center;margin:0 20px 20px 0;\"><a href=" + sy.contextPath + fjpath[i] + " data-lightbox=\"fj\" ><img width=\"200px\" height=\"150px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" + sy.contextPath + fjpath[i] + "\"/></a></div>");
        //                }
        //            }
        //        }
        //        function closeWindow() {
        //            parent.$("#" + sy.getDialogId()).dialog("close");
        //        }

        //        关闭窗口并刷新
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<body>
<form id="fm" method="post">
    <input id="fjpath" name="fjpath" type="hidden"/>
    <input id="fjname" name="fjname" type="hidden"/>

    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">文件上传组件</h2>

            <div class="layui-colla-content layui-show">
                <table style="width: 99%;">
                    <tr>
                        <td>
                            <div id="uploader">您的浏览器没有安装Flash插件，或不支持HTML5！</div>
                        </td>
                    </tr>
                </table>
                <br/>
                <table style="width: 99%;">
                    <tr>
                        <td style="text-align:center;">
                            <input class="layui-btn" type="button" id="btnSave" value="开始上传">
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</form>
<div class="layui-collapse">
    <div class="layui-colla-item">
        <h2 class="layui-colla-title">已上传附件</h2>

        <div class="layui-colla-content layui-show">
            <fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
                <div class="layui-btn-group demoTable2">
                    <ck:permission biz="chakanYiChuanFuJian">
                        <button class="layui-btn" data-type="chakanFuJian" data="btn_chakanFuJian">
                            <img src="<%=basePath%>images/pub/view.png" align="absmiddle">查看
                        </button>
                    </ck:permission>
                    <ck:permission biz="deleteFuJian">
                        <button class="layui-btn layui-btn-danger" data-type="deleteFuJian" data="btn_deleteFuJian">
                            <img src="<%=basePath%>images/pub/delete.gif" align="absmiddle">删除
                        </button>
                    </ck:permission>
                </div>
            </fieldset>

            <table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
        </div>
    </div>
</div>
</body>
</html>