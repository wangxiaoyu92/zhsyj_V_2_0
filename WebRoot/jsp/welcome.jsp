<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	};
	String v_wheresys=SysmanageUtil.g_wheresys;
%>
<html>
<head>
	<meta charset="utf-8">
	<title>食药监综合平台</title>
	<jsp:include page="${contextPath}/inc.jsp">
		<jsp:param name="isLayUIString" value="true"></jsp:param>
	</jsp:include>

	<link rel="stylesheet" href="<%=contextPath%>/jslib/plib/layui-v2.2.5/css/layui.css" media="all" />
	<script>
		var basthPath = "<%=basePath%>";
		var contextPath = "<%=contextPath%>";
	</script>
	<script src="<%=contextPath%>/jslib/plib/layui-v2.2.5/layui.js" charset="utf-8"></script>

	<script src="<%=contextPath%>/jslib/echarts/echarts.min.4.0.4.js"></script>
	<script src="<%=contextPath%>/jslib/echarts/macarons.4.0.4.js"></script>
	<script src="<%=contextPath%>/jslib/jquery-1.9.1.js"></script>
	<link href="<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.css"/>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<%--<link rel="stylesheet" href="//res.layui.com/layui/dist/css/layui.css"  media="all">--%>
	<!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
	<style>


		@font-face {font-family: "iconfont";
			src: url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.eot'); /* IE9*/
			src: url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.eot#iefix') format('embedded-opentype'), /* IE6-IE8 */
			url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.woff') format('woff'), /* chrome, firefox */
			url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.ttf') format('truetype'), /* chrome, firefox, opera, Safari, Android, iOS 4.2+*/
			url('<%=contextPath%>/jslib/plib/kit_admin/build/css/font/iconfont.svg#iconfont') format('svg'); /* iOS 4.1- */
		}

		.iconfont {
			font-family:"iconfont" !important;
			font-size:35px;
			font-style:normal;
			-webkit-font-smoothing: antialiased;
			-webkit-text-stroke-width: 0.2px;
			-moz-osx-font-smoothing: grayscale;
		}

		.iconfont2 {
			font-family:"iconfont" !important;
			font-size:18px;
			font-style:normal;
			-webkit-font-smoothing: antialiased;
			-webkit-text-stroke-width: 0.2px;
			-moz-osx-font-smoothing: grayscale;
		}

		.signal-font {
			font-family:"iconfont" !important;
			font-size:25px;
			font-style:normal;
			-webkit-font-smoothing: antialiased;
			-webkit-text-stroke-width: 0.2px;
			-moz-osx-font-smoothing: grayscale;
		}
		/* æ …æ ¼ç¤ºä¾‹ */
		.grid-demo{padding: 10px;text-align: center; background-color: #ffffff; color: #000;}
		.grid-demo1 {padding: 10px; height: 110px; text-align: center; background-color: #ffffff; color: #000;}
		.grid-demo2 {text-align: center; background-color: #ffffff; color: #000;}
		.grid-demo2 div {text-align: center; background-color: #ffffff; color: #000;}
		.grid-line {text-align: center; background-color: #ffffff; color: #000;height: 51.3px}
		.grid-line2 {text-align: center; background-color: #ffffff; color: #000;height: 51.3px}
		.grid-line3 {text-align: center; background-color: #ffffff; color: #000;height: 51.3px}
		.grid-title {text-align: center; background-color: #ffffff; color: #000;height: 66px;fill-opacity: 0.1}
		.title {padding: 10px; line-height: 30px; text-align: left; background-color: #ffffff;     font-size: 15px;
			color: #393939;
			font-weight: 700;}

	</style>

	<script type="text/javascript">
        //下拉框列表
		var v_local_wheresys="<%=v_wheresys%>";
        var sfqygzl = <%=SysmanageUtil.getAa10toJsonArray("SFQYGZL")%>;
        var cb_sfqygzl;
        var grid;
        var layer; // 弹出层
		var table;
        var selectTableDataId1 = '';
        var selectTableDataId2 = '';
        var selectTableDataId3 = '';

        $(function() {
//		cb_sfqygzl = $('#sfqygzl').combobox({
//	    	data : sfqygzl,
//	        valueField : 'id',
//	        textField : 'text',
//	        required : false,
//	        editable : false,
//	        panelHeight : 'auto'
//	    });
//            setInterval("query()",60000);
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
//			intSelectData('slbz', v_slbz);
//			intSelectData('ajjsbz', V_AJJSBZ);
                form.render();
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#ajdjTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/workflow/queryWfywDaiban'
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
                        {field:'opt',title:'操作',align:'center',width:280,
                            templet: function (d) {
                                if(d.psbh=='WF2018070400359') {
                                    return '<a class="layui-btn layui-btn-danger" href="javascript:showYwbllog(\'' + d.ywbh + '\')" lay-event="detail">' + d.nodename + '</a>'
                                }else{
                                    return '<a class="layui-btn layui-btn-xs" href="javascript:wfywbl(\'' + d.ywlcid + '\',\'' + d.psbh + '\',\'' + d.nodeid + '\',\'' + d.nodename + '\',\'' + d.nodeurl + '\',\'' + d.ywbh + '\',\'' + d.nodename + '\',\'' + d.fjcsdmlb + '\',\'' + d.fjcsdlbh + '\')" lay-event="detail">' + d.nodename + '</a>' +
                                        '<a class="layui-btn layui-btn-primary layui-btn-xs" href="javascript:htdsyb(\'' + d.ywlcid + '\',\'' + d.psbh + '\',\'' + d.nodeid + '\',\'' + d.nodename + '\',\'' + d.ywbh + '\')" lay-event="edit">回退到上一步</a>';
                                }
                            }
                        }
                        , {field: 'psmc', width: 150, title: '工作流名称', event: 'trclick'}
                        , {field: 'commc', width: 220, title: '待办事项', event: 'trclick'}
                        , {field: 'nodename', width: 200, title: '节点名称', event: 'trclick'}
                        , {field: 'ywbh', width: 200, title: '业务编号', event: 'trclick'}
                        //, {field: 'fjcsdmlb', width: 100, title: '附件参数代码类别', event: 'trclick'}
                        //, {field: 'fjcsdlbh', width: 150, title: '附件参数大类编号', event: 'trclick'}
                        //, {field: 'nodeurl', width: 150, title: '附件参数大类编号', event: 'trclick'}
                        , {field: 'aaa027name', width: 200, title: '备注', event: 'trclick'}
                        , {
                            field: 'sxzt', width: 150, title: '时限状态'
                            , templet: function (d) {
                                var sxzt = d.id;
                                $.each(sfqygzl, function (i, n) {
                                    if (d.sxzt == n.id) {
                                        sxzt = n.text;
                                        return false; // 跳出本次循环
                                    }
                                });
                                return sxzt;
                            }
//						, templet: function (d) {
//							return formatGridColData(v_AJDJAJLY, d.ajdjajly);
//						}
                            , event: 'trclick'
                        }
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
                        if (selectTableDataId != data.ywlcid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#ajdjTable").next().find(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.ywlcid;
                        } else { // 再次选中清除样式
                            $("#ajdjTable").next().find(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    doWfprocess: function () { // 查看执法办案流程图
                        doWfprocess();
                    }
                    , showYwbllog: function () { // 查看办理日志
                        if (!table.singleData) {
                            layer.alert('请选择要查看办理日志！',{offset: ['200px', '450px']});
                        } else {
                            showYwbllog(table.singleData.ywbh);
                        }
                    },
                    showPcom: function () {
                        if (!table.singleData1) {
                            alert("请先选择要查看的工作任务！")
                        } else {
                            showDoc(table.singleData1);
                        }
                    },
                    wcPcom: function () {
                        if (!table.singleData1) {
                           alert("请先选择要完成的工作任务！")
                        } else {
                            wcDoc(table.singleData1);
                        }
                    },
                    bnwcPcom: function () {
                        if (!table.singleData1) {
                            alert("请先选择不能完成的工作任务！")
                        } else {
                            bnwcDoc(table.singleData1);
                        }
                    },
                    email: function () {
                        if (!table.singleData2) {
                            alert("请先选择回复的站内信！")
                        } else {
                            email(table.singleData2);
                        }
                    },
                    gzsb: function () {
                        if (!table.singleData3) {
                            alert("请先选择回复的工作上报！")
                        } else {
                            gzsb(table.singleData3);
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
                if (v_local_wheresys!="zhongmou") {
                    table.render({
                        elem: '#docTable'
                        , url: basePath + '/work/task/querysdTaskZJDB'
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
                            {
                                field: 'taskcontent', title: '任务内容', align: 'center', width: 500, event: 'trclick1',
                                templet: function (d) {
                                    return '<a  href="javascript:showtask(\'' + d.oataskid + '\',\'' + d.oataskmanid + '\')" lay-event="detail">' + '<span style="color:blue;">' + d.taskcontent + '</span></a>'
                                }
                            }
                            , {field: 'endtime', width: 150, title: '截止时间', event: 'trclick1'}
                            , {field: 'txr', width: 200, title: '阅读状态', event: 'trclick1'},
                            {
                                field: 'completestate',
                                width: 200,
                                title: '完成状态',
                                event: 'trclick1',
                                templet: function (d) {
                                    if (d.completestate == "1") {
                                        return '<span style="color:red">未完成(已超时)</span>';
                                    } else if (d.completestate == "2") {
                                        return '<span style="color:red">未完成(今天为最后期限)</span>';
                                    } else {
                                        return '<span style="color:blue">' + d.completestate + '</span>';
                                    }
                                }
                            }
                            , {field: 'aae011', width: 200, title: '发送人', event: 'trclick1'}
                            , {field: 'aae036', width: 200, title: '发送时间', event: 'trclick1'}
                        ]]
                        , done: function (res, curr, count) {
                            layer.close(mask);
                        }

                    })
                    // 监听工具条
                    table.on('tool(tableFilter)', function (obj) {
                        var data = obj.data;
                        if (obj.event === 'trclick1') { // 选中行
                            if (selectTableDataId1 != data.oataskid) {
                                // 清除所有行的样式
                                $(".layui-table-body tr").each(function (k, v) {
                                    $(v).removeAttr("style");
                                });
                                $("#docTable").next().find(obj.tr.selector).css("background", "#90E2DA");
                                table.singleData1 = data;
                                selectTableDataId1 = data.oataskid;
                            } else { // 再次选中清除样式
                                $("#docTable").next().find(obj.tr.selector).attr("style", "");
                                table.singleData1 = '';
                                selectTableDataId1 = '';
                            }
                        }
                    });
                    table.render({
                        elem: '#emailTable'
                        , url: basePath + '/oaeamil/queryOaemailGet?sfyd=0'
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
                            {
                                field: 'emailcontent', title: '站内信内容', align: 'center', width: 500, event: 'trclick2',
                                templet: function (d) {
                                    return '<a  href="javascript:showemail(\'' + d.oaemailid + '\',\'' + d.oaemailmanid + '\')" lay-event="detail">' + '<span style="color:blue;">' + d.emailcontent + '</span></a>'
                                }
                            }
                            , {field: 'txr', width: 300, title: '状态', event: 'trclick2'}
                            , {field: 'aae011', width: 200, title: '发送人', event: 'trclick2'}
                            , {field: 'aae036', width: 200, title: '发送时间', event: 'trclick2'}
                        ]]
                        , done: function (res, curr, count) {
                            layer.close(mask);
                        }

                    })
                    // 监听工具条
                    table.on('tool(emailFilter)', function (obj) {
                        var data = obj.data;
                        if (obj.event === 'trclick2') { // 选中行
                            if (selectTableDataId2 != data.oaemailid) {
                                // 清除所有行的样式
                                $(".layui-table-body tr").each(function (k, v) {
                                    $(v).removeAttr("style");
                                });
                                $("#emailTable").next().find(obj.tr.selector).css("background", "#90E2DA");
                                table.singleData2 = data;
                                selectTableDataId2 = data.oaemailid;
                            } else { // 再次选中清除样式
                                $("#emailTable").next().find(obj.tr.selector).attr("style", "");
                                table.singleData2 = '';
                                selectTableDataId2 = '';
                            }
                        }
                    });
                    table.render({
                        elem: '#gzsbTable'
                        , url: basePath + '/oaeamil/queryOareportGet?sfyd=0'
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
                            {
                                field: 'reportcontent', title: '工作上报内容', align: 'center', width: 500, event: 'trclick3',
                                templet: function (d) {
                                    return '<a  href="javascript:show(\'' + d.oareportid + '\',\'' + d.oareportmanid + '\')" lay-event="detail">' + '<span style="color:blue;">' + d.reportcontent + '</span></a>'
                                }
                            }
                            , {field: 'txr', width: 300, title: '状态', event: 'trclick3'}
                            , {field: 'aae011', width: 200, title: '发送人', event: 'trclick3'}
                            , {field: 'aae036', width: 200, title: '发送时间', event: 'trclick3'}
                        ]]
                        , done: function (res, curr, count) {
                            layer.close(mask);
                        }

                    })

                    // 监听工具条
                    table.on('tool(gzsbFilter)', function (obj) {
                        var data = obj.data;
                        if (obj.event === 'trclick3') { // 选中行
                            if (selectTableDataId3 != data.oareportid) {
                                // 清除所有行的样式
                                $(".layui-table-body tr").each(function (k, v) {
                                    $(v).removeAttr("style");
                                });
                                $("#gzsbTable").next().find(obj.tr.selector).css("background", "#90E2DA");
                                table.singleData3 = data;
                                selectTableDataId3 = data.oareportid;
                            } else { // 再次选中清除样式
                                $("#gzsbTable").next().find(obj.tr.selector).attr("style", "");
                                table.singleData3 = '';
                                selectTableDataId3 = '';
                            }
                        }
                    });
                };//where
            });

        });


        //查询
        function query() {
            var ywbh = $('#ywbh').val();
//		alert(ywbh);
            var param = {
                'ywbh': ywbh
            };
            refresh(param,'');
        }
        function querynew() {
            var param = {
            };
            refreshnew(param,'');
        }
        function query2() {
            var param = {
            };
            refresh2(param,'');
        }
        function query3() {
            var param = {
            };
            refresh3(param,'');
        }
        // 查看
        function showDoc(data) {
            var oataskid=data.oataskid;
            var oataskmanid=data.oataskmanid;
            url=basePath + 'work/task/gzrwsdFormIndex?op=view&oataskid=' + oataskid+ '&oataskmanid='+oataskmanid

            sy.modalDialog({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                ,offset: ['5px', '5px']
                , title: '查看工作任务'
                , content: url
                , btn: ['关闭']
            }, querynew);

        }
        function showtask(oataskid,oataskmanid) {
            url=basePath + 'work/task/gzrwsdFormIndex?op=view&oataskid=' + oataskid+ '&oataskmanid='+oataskmanid

            sy.modalDialog({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                ,offset: ['5px', '5px']
                , title: '查看工作任务'
                , content: url
                , btn: ['保存', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, querynew);

        }
        function email(data) {
            var oaemailid=data.oaemailid;
            var oaemailmanid=data.oaemailmanid;
            url=basePath + 'oaeamil/emailsdFormIndex?op=view&oaemailid=' + oaemailid+ '&oaemailmanid='+oaemailmanid

            sy.modalDialog({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                ,offset: ['5px', '5px']
                , title: '回复站内信'
                , content: url
                , btn: ['保存', '关闭'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, query2);

        }
        function showemail(oaemailid,oaemailmanid) {
            url=basePath + 'oaeamil/emailsdFormIndex?op=view&oaemailid=' + oaemailid+ '&oaemailmanid='+oaemailmanid
            sy.modalDialog({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                ,offset: ['5px', '5px']
                , title: '回复站内信'
                , content: url
                , btn: ['保存', '关闭'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, query2);

        }
        // 查看
        function gzsb(data) {
            var oareportid=data.oareportid;
            var oareportmanid=data.oareportmanid;
            url=basePath + 'oaeamil/reportsdFormIndex?op=view&oareportid=' + oareportid+ '&oareportmanid='+oareportmanid

            sy.modalDialog({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                ,offset: ['5px', '5px']
                , title: '回复工作上报'
                , content: url
                , btn: ['保存', '关闭'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, query3);

        }
        function wcDoc(data) {
            var oataskmanid=data.oataskmanid;
            /*sy.modalDialog({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                , title: '查看工作任务'
                , content: url
                , btn: ['保存', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, query);*/
            layer.open({
                title: '确认'
                , icon: '3'
                ,offset: ['200px', '200px']
                , content: '你确定要完成该项工作任务么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'work/task/wcoatsakman', {
                            oataskmanid: oataskmanid
                        },
                        function (result) {
                            if (result.code == '0') {
                                //保证不会重复删除
                                table.singleData = '';
                                selectTableDataId = '';
                                //本页的值
                                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                layer.msg('完成成功', {time: 1000}, function () {
                                    //如果是本页最后一条数据 则返回上一页
                                  querynew();
                                });

                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "完成失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json');
                }
            });
        }
        function bnwcDoc(data) {
            var oataskmanid=data.oataskmanid;
            url=basePath + 'work/task/bnwcFormIndex?op=view&oataskmanid='+oataskmanid

            sy.modalDialog({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['500px', '300px'] //
                ,offset: ['50px', '50px']
                , title: '不能完成原因'
                , content: url
                , btn: ['保存', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, querynew);
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

        // 刷新
        function refresh(param,cur) {
            //删除时 在本页面刷新
            if(cur==""){
                curr=1;
            }else{
                curr=cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('ajdjTable', {
                url: basePath +  '/workflow/queryWfywDaiban'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                ,done:function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
			/*		parent.window.refresh();*/
        }

        function refreshnew(param, cur) {
            table.singleData1 = '';
            selectTableDataId1 = '';
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('docTable', {
                url: basePath + '/work/task/querysdTaskZJDB'
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
        function refresh2(param, cur) {
            table.singleData2 = '';
            selectTableDataId2 = '';
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('emailTable', {
                url: basePath + '/oaeamil/queryOaemailGet?sfyd=0'
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
        function refresh3(param, cur) {
            table.singleData3 = '';
            selectTableDataId3 = '';
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('gzsbTable', {
                url: basePath + '/oaeamil/queryOaemailGet?sfyd=0'
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


        function doWfprocess() {
//            var url = basePath + 'jsp/workflowyewu/wfyw_zfbalct.jsp';
            var url=basePath+'jsp/gzlAN.jsp';
            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                ,offset: ['0px', '0px']
                , title: '流程图'
                , content: url
                , btn: ['关闭']
            });
        }

        function showYwbllog(_ywbh){
            var url = basePath + 'workflow/wfywlclogIndex';
            var dialog = sy.modalDialog({
                title : '查看日志'
                ,param : {
                    ywbh : _ywbh,
                    time : new Date().getMilliseconds()
                }
                ,area:[ '1000px','550px']
                ,offset: ['5px', '5px']
                ,content : url
            },function(dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj != null && "ok"==obj){
                    $("#grid").datagrid("reload");
                }
                sy.removeWinRet(dialogID);//不可缺少
            });
        }

        //		var dialog = parent.sy.modalDialog({
        //				title : '查看',
        //				width : 900,
        //				height : 600,
        //				url : url,
        //			    maximizable:true
        //		},function(dialogID) {
        //		    sy.removeWinRet(dialogID);//不可缺少
        //		});


        function wfywbl(v_ywlcid,v_psbh,v_nodeid,v_nodename,v_nodeurl,v_ywbh,v_fjcsdmlb,v_fjcsdlbh){
            //var v_ywlcid = row.ywlcid;
            //var v_ywbh = row.ywbh;
            //var v_psbh = row.psbh;
            //var v_nodeid = row.nodeid;
            //var v_nodename = row.nodename;
            //var v_nodeurl = row.nodeurl;
            var cfmMsg= "确定要【"+v_nodename+"】业务编号为【"+v_ywbh+"】的记录吗?";
            //var row = grid.datagrid('getSelected');
            if (true) {
                v_nodename=encodeURI(v_nodename);
                //询问框
                layer.confirm(cfmMsg, {
                    btn: ['确定','取消'], //按钮
				 offset:["100px","420px"]
                }, function(index){
                    layer.close(index);
                    var url = basePath + v_nodeurl;
                    sy.modalDialog({
                        title: '流程处理'
                        ,area: ['100%', '100%']
                        ,offset:["5px","5px"]
                      // ,maxmin: true
                        , content: url
                        ,param : {
                            ywlcid : v_ywlcid,
                            ywbh : v_ywbh,
                            psbh : v_psbh,
                            nodeid : v_nodeid,
                            nodename : v_nodename,
                            fjcsdmlb : v_fjcsdmlb,
                            fjcsdlbh : v_fjcsdlbh
                        },
                        btn: [ '关闭']
                        , btn1: function (index, layero) {
                            //当前页面刷新
                            layer.close(index);
//                            table.reload('ajdjTable', {
//                                url: basePath + '/workflow/queryWfywDaiban'
//                            });

//                            refresh(null,1);
                        }
                    }, function (dialogID) {
                        var obj = sy.getWinRet(dialogID);
                        sy.removeWinRet(dialogID);//不可缺少
                        layer.close(index);
						if('ok'==obj.type){
                            table.reload('ajdjTable', {
                                url: basePath + '/workflow/queryWfywDaiban'
                            });
						}
                    });
                  //  layer.full(v_index);
                }, function(){
                });

            }else{
                $.messager.alert('提示', '请先选择要操作的记录！', 'info');
            }
        };
        function htdsyb(v_ywlcid,v_psbh,v_nodeid,v_nodename,v_ywbh) {

            var cfmMsg = "确定要回退【" + v_nodename + "】业务编号为【" + v_ywbh + "】的记录吗?";
            var v_url = encodeURI(encodeURI(basePath + "/workflow/huituiWfprocess?ywlcid="
                + v_ywlcid + "&ywbh=" + v_ywbh + "&psbh=" + v_psbh + "&nodeid=" + v_nodeid));
            //询问框
            top.layer.confirm(cfmMsg, {
                    btn: ['确定', '取消'], //按钮
                    offset: ["100px", "420px"]
                }, function (index) {
                    top.layer.close(index);
                    $.ajax({
                        url: v_url,
                        type: 'post',
                        async: true,
                        cache: false,
                        timeout: 100000,
                        //data:formData,
                        error: function () {
                           // parent.$.messager.progress('close');
                            top.layer.alert("服务器繁忙，请稍后再试！",{offset:["100px","220px"]});
                        },
                        success: function (result) {
                            result = $.parseJSON(result);
                            if (result.code == '0') {
								layer.alert('回退成功！',{
								    skin:'layui-layer-molv'
									,closeBtn:1
									,btn:['确定','关闭']
                                    ,offset:["100px","220px"]
									,icon:6
								    ,yes:function(myindex){
								        layer.close(myindex);
                                        //window.location.href = window.location.href;
                                        table.reload('ajdjTable', {
                                            url: basePath + '/workflow/queryWfywDaiban'
                                        });
									}
									,btn2:function(){

									}
								});
//						 		$("#grid").datagrid('reload');
                                //parent.$.messager.progress('close');
//                                parent.$.messager.alert('提示', '回退成功！', 'info', function () {
//                                    window.location.href = window.location.href;
//                                });
                            } else {
                                layer.alert('回退失败！',{
                                    skin:'layui-layer-molv'
                                    ,closeBtn:1
                                    ,btn:['确定','关闭']
                                    ,offset:["100px","220px"]
                                    ,icon:6
                                    ,yes:function(){
                                       // window.location.href = window.location.href;
                                    }
                                    ,btn2:function(){

                                    }
                                });
//                                parent.$.messager.progress('close');
//                                parent.$.messager.alert('提示', '回退失败：' + result.msg, 'error');
//                                window.location.href = window.location.href;
                            }
                        }
                    })
                }
                , function () {
                })
        };

        //报请 已阅
        function baoqingchuli(){
            var url = basePath + 'pub/pub/baoqingchuliIndex';
            sy.modalDialog({
                content: url
                , title: '报请'
                , area: ['100%', '100%']
                , offset: '0px'
                , btn: ['关闭']
            });
//            var dialog = parent.sy.modalDialog({
//                title : '报请',
//                width : 1000,
//                height : 560,
//                url : url
//            },function(dialogID) {
//                huoqubaoqing();
//                sy.removeWinRet(dialogID);//不可缺少
//            });
        };

	</script>

</head>
<body style="background-color: #edf0f3;">
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
<script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
<script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<div class="layui-fluid" style="background-color: #edf0f3;">

	<div class="layui-row layui-col-space5" style="padding-top: 15px">

		<%--<div class="layui-col-md12">--%>
			<%--<div class="layui-row">--%>
				<%--<div class="layui-col-md12 title">--%>
					<%--待办任务--%>
				<%--</div>--%>
			<%--</div>--%>
			<%--<div class="layui-row">--%>
				<%--<div class="layui-col-md12 title">--%>
					<%--<iframe name="daibaniframe" id="daibaniframe" src="<%=basePath%>jsp/workflowyewu/wfyw_daiban.jsp?operatetype=welcome" width="100%" height="200px;"  scrolling="no" frameborder="0" ></iframe>--%>
				<%--</div>--%>
			<%--</div>--%>

		<%--</div>--%>
		<div class="layui-col-md12">
			<div class="layui-row">
				<div class="layui-col-md12 title">
				待办工作流任务
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-md12">
					<div class="layui-btn-group demoTable">
						<ck:permission biz="doWfprocess">
							<button class="layui-btn" data-type="doWfprocess" data="btn_doWfprocess">流程图</button>
						</ck:permission>
						<ck:permission biz="showYwbllog">
							<button class="layui-btn" data-type="showYwbllog" data="btn_showYwbllog" >办理日志
							</button>
						</ck:permission>

					</div>
					<table class="layui-hide" id="ajdjTable" lay-filter="AjdjFilter"></table>
				</div>
			</div>
		</div>
			<% if (!"zhongmou".equals(v_wheresys)){ %>
			<div class="layui-col-md12">
				<div class="layui-row">
					<div class="layui-col-md12 title">
						待办工作任务
					</div>
				</div>
				<div class="layui-row">
					<div class="layui-col-md12">
						<div class="layui-btn-group demoTable">
							<button class="layui-btn " data-type="showPcom" data="btn_showPcom">阅读</button>
							<button class="layui-btn " data-type="wcPcom" data="btn_wcPcom">完成任务</button>
							<button class="layui-btn " data-type="bnwcPcom" data="btn_bnwcPcom">不能完成任务</button>
						</div>
						<table class="layui-hide" id="docTable" lay-filter="tableFilter">
						</table>
					</div>
				</div>
			</div>
			<div class="layui-col-md12">
				<div class="layui-row">
					<div class="layui-col-md12 title">
						未读站内信
					</div>
				</div>
				<div class="layui-row">
					<div class="layui-col-md12">
						<div class="layui-btn-group demoTable">
							<button class="layui-btn " data-type="email" data="btn_email">回复站内信</button>
						</div>
						<table class="layui-hide" id="emailTable" lay-filter="emailFilter">
						</table>
					</div>
				</div>
			</div>
			<div class="layui-col-md12">
				<div class="layui-row">
					<div class="layui-col-md12 title">
						未读工作上报
					</div>
				</div>
				<div class="layui-row">
					<div class="layui-col-md12">
						<div class="layui-btn-group demoTable">
							<button class="layui-btn " data-type="gzsb" data="btn_gzsb">回复</button>
						</div>
						<table class="layui-hide" id="gzsbTable" lay-filter="gzsbFilter">
						</table>
					</div>
				</div>
			</div>
			<%}%>
		<div class="layui-col-md5">
			<div class="layui-row">
				<div class="layui-col-md12 title">
					待办提醒
				</div>
			</div>

			<div class="layui-row">
				<div class="layui-col-md4 grid-demo1">
					<div class="layui-row">
						<div class="layui-col-md3">
							<i class="iconfont">&#xe62a;</i>
						</div>
						<div class="layui-col-md9">
							<i id="baoqingsx" class="signal-font">0</i><br>
							<span><a href="javascript:baoqingchuli();">待处理报请事项</a></span>
						</div>
					</div>
				</div>

				<div class="layui-col-md4 grid-demo1">
					<div class="layui-row">
						<div class="layui-col-md3">
							<i class="iconfont">&#xe639;</i>
						</div>
						<div class="layui-col-md9">
							<i id="xkzdq" class="signal-font">0</i><br>
							<span>许可证将到期</span>
						</div>
					</div>
				</div>
				<div class="layui-col-md4 grid-demo1">
					<div class="layui-row">
						<div class="layui-col-md3">
							<i class="iconfont">&#xe616;</i>
						</div>
						<div class="layui-col-md9">
							<i class="signal-font">0</i><br>
							<span>当前逾期未处理</span>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-md6 grid-demo1">
					<div class="layui-row">
						<div class="layui-col-md3">
							<i class="iconfont">&#xe690;</i>
						</div>
						<div class="layui-col-md9">
							<i id="lianghuaJzCount" class="signal-font">0</i><br>
							<span>量化检查将截止</span>
						</div>
					</div>
				</div>
				<div class="layui-col-md6 grid-demo1">
					<div class="layui-row">
						<div class="layui-col-md3">
							<i class="iconfont">&#xe679;</i>
						</div>
						<div class="layui-col-md9">
							<i class="signal-font">0</i><br>
							<span>日常监管待处理</span>
						</div>
					</div>
				</div>
			</div>

		</div>
		<div class="layui-col-md7">
			<div class="layui-row">
				<div class="layui-col-md12 title">
					提醒区
				</div>
			</div>
			<div class="grid-demo2">
					<div class="layui-col-md4">
						<div class="layui-row grid-title">
								量化风险预警
						</div>
						<div class="layui-row grid-line">
								<i class="iconfont2 ">&#xe60d;</i>A级&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0
						</div>
						<div class="layui-row grid-line">
								<i class="iconfont2 ">&#xe60d;</i>B级&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0
						</div>
						<div class="layui-row grid-line">
								<i class="iconfont2 ">&#xe60d;</i>C级&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0
						</div>
					</div>
					<div class="layui-col-md4">
						<div class="layui-row grid-title">
							监督检查预警
						</div>
						<div class="layui-row grid-line2">
							监督检查覆盖率
							<div class="layui-progress layui-progress-big" lay-showPercent="true">
								<div id="ZhuTiFuGaiLv" class="layui-progress-bar layui-bg-orange" lay-percent="0%"></div>
							</div>
						</div>
						<div class="layui-row grid-line2">
							监督检查合格率
							<div class="layui-progress layui-progress-big" lay-showPercent="true">
								<div class="layui-progress-bar layui-bg-orange" lay-percent="50%"></div>
							</div>
						</div>
						<div class="layui-row grid-line2">
							专项检查合格率
							<div class="layui-progress layui-progress-big" lay-showPercent="true">
								<div class="layui-progress-bar layui-bg-blue" lay-percent="80%"></div>
							</div>
						</div>
					</div>
					<div class="layui-col-md4">

						<div class="layui-row grid-title">
							到期提醒
						</div>
						<div class="layui-row grid-line3">
							即将过期的许可证【<span id="xkzdq2">0</span>】个
						</div>
						<div class="layui-row grid-line3">
							即将过期的三小【0】个
						</div>
						<div class="layui-row grid-line3">
							即将截止的专项检查【0】个
						</div>
					</div>
			</div>
		</div>
	</div>

	<div class="layui-row layui-col-space5">
		<div class="layui-col-md6">
			<div class="layui-row">
				<div class="layui-col-md12 title">
					主体
				</div>
			</div>
			<div class="grid-demo2">
				<div class="layui-row">
					<div class="layui-col-md3" style="border-right: solid;border-color: #777; height: 175px;">
						<i class="iconfont">&#xe607;</i>
						<br>
						<br>
						<i id="companyAllCount" class="signal-font">0</i>
						<br>
						<br>
						<i class="signal-font">接入企业总数</i>
					</div>
					<div id="main" class="layui-col-md9 grid-demo2" style="height: 210px;">


					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-md6">
			<div class="layui-row">
				<div class="layui-col-md12 title">
					三小
				</div>
			</div>
			<div class="grid-demo2">
				<div class="layui-row">
					<div class="layui-col-md3" style="border-right: solid;border-color: #777; height: 175px;">
						<i class="iconfont">&#xe68b;</i>
						<br>
						<br>
						<i class="signal-font">0</i>
						<br>
						<br>
						<i class="signal-font">接入企业总数</i>
					</div>
					<div id="main2" class="layui-col-md9 grid-demo21" style="height: 210px;">


					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="layui-row layui-col-space5">
		<div class="layui-col-md12">
			<div class="layui-row">
				<div class="layui-col-md12 title">
					日常检查
				</div>
			</div>
			<div class="grid-demo2">
				<div class="layui-row">
					<div class="layui-col-md3" style="border-right: solid;border-color: #777; height: 175px;">
						<i class="iconfont">&#xe68b;</i>
						<br>
						<br>
						<i id="RichangAllCount" class="signal-font">0</i>
						<br>
						<br>
						<i class="signal-font">累计检查</i>
					</div>
					<div id="main3" class="layui-col-md9 grid-demo2" style="height: 210px;">


					</div>
				</div>

			</div>
		</div>
		<div class="layui-col-md12">
			<div class="layui-row">
				<div class="layui-col-md12 title">
					检查覆盖率排名
				</div>
			</div>
			<div id="main4" class="grid-demo2" style="height: 310px" ></div>
		</div>
	</div>
	<div class="layui-row layui-col-space5">
		<div class="layui-col-md8">
			<div class="layui-row">
				<div class="layui-col-md12 title">
					专项检查
				</div>
			</div>
			<div class="grid-demo2">
				<div class="layui-row">
					<div class="layui-col-md4" style="height: 175px;">
						<i class="iconfont">&#xe648;</i>
						<br>
						<br>
						<i id="ZhuanXiangCheckedCount" class="signal-font">0</i>
						<br>
						<br>
						<i class="signal-font">已完成</i>
					</div>
					<div class="layui-col-md4" style="height: 175px;">
						<i class="iconfont">&#xe605;</i>
						<br>
						<br>
						<i id="ZhuanXiangUncheckedCount" class="signal-font">0</i>
						<br>
						<br>
						<i class="signal-font">执行中</i>
					</div>
					<div class="layui-col-md4" style="height: 175px;">
						<i class="iconfont">&#xe621;</i>
						<br>
						<br>
						<i id="ZhuanXiangAllCount" class="signal-font"></i>
						<br>
						<br>
						<i class="signal-font">累计检查</i>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-md4">
			<div class="layui-row">
				<div class="layui-col-md12 title">
					量化检查
				</div>
			</div>
			<div class="grid-demo2">
				<div class="layui-col-md6" style="height: 180px;">
					<i class="iconfont">&#xe648;</i>
					<br>
					<br>
					<i id="LianghuaCheckedCount" class="signal-font">0</i>
					<br>
					<br>
					<i class="signal-font">已完成</i>
				</div>
				<div class="layui-col-md6" style="height: 180px;">
					<i class="iconfont">&#xe605;</i>
					<br>
					<br>
					<i id="LianghuaUncheckedCount" class="signal-font">0</i>
					<br>
					<br>
					<i class="signal-font">执行中</i>
				</div>
			</div>
		</div>
	</div>

</div>


<script src="<%=contextPath%>/jslib/plib/layui-v2.2.5/layui.js" charset="utf-8"></script>
<script>


	option3 = {
		title : {
			text: '主体企业分布',
			//subtext: '2018-03-27',
			x:'center'
		},
		tooltip : {
			trigger: 'item',
			formatter: "{a} <br/>{b} : {c} ({d}%)"
		},
		legend: {
			orient : 'vertical',
			x : 'left',
			data:['食品生产','食品流通','餐饮服务','三小','其他']
		},
		toolbox: {
			show : false,
			feature : {
				mark : {show: true},
				dataView : {show: true, readOnly: false},
				magicType : {
					show: true,
					type: ['pie', 'funnel'],
					option: {
						funnel: {
							x: '25%',
							width: '50%',
							funnelAlign: 'left',
							max: 1548
						}
					}
				},
				restore : {show: true},
				saveAsImage : {show: true}
			}
		},
		calculable : true,
		series : [
			{
				name:'日常检查企业分布',
				type:'pie',
				radius : '55%',
				center: ['50%', '60%'],
				data:[
					{value:32, name:'小作坊'},
					{value:830, name:'小摊贩'},
					{value:234, name:'餐饮服务'},
					{value:3, name:'三小'},
					{value:52, name:'其他'}
				]
			}
		]
	};
	var myChart3 = echarts.init(document.getElementById('main3'),"macarons");
	myChart3.setOption(option3);



</script>

<script>
	//注意进度条依赖 element 模块，否则无法进行正常渲染和功能性操作
	var element = null;
	layui.use('element', function(){
		element = layui.element;
	});
	function huoqubaoqing(){
        $.post(basePath + '/pub/pub/queryDaibanshixiang', {
            },
            function(result) {
                if (result.code=='0') {
                    var mydata = result.data;
                    $('#baoqingsx').html(mydata.baoqingsx);
                } else {
                    // parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }
                //  parent.$.messager.progress('close');
            }, 'json');
	};

	$(document).ready(function(){
//		$.getJSON(basthPath+"pub/pub/queryDaibanshixiang",function(result){
//			console.log("待办事项"+result.data.baoqingsx);
//		});
//		$.getJSON(basthPath+"common/sjb/daoQiYuJing",function(result){
//			console.log("许可到期提醒"+result.total);
//		});
		$.post(
            basthPath+"pub/pub/queryCount",
            {"flag":1},
            function(result){
                $("#xkzdq").html(result.count);
                $("#xkzdq2").html(result.count);
            },
            "json");

        huoqubaoqing();

		$.post(
				basthPath+"pub/pub/queryCount",
				function(result){
					$("#companyAllCount").html(result.count);
				},
				"json");

		$.post(
				basthPath+"pub/pub/queryCount",
				{"flag":2},
				function(result){
					$("#lianghuaJzCount").html(result.count);
				},
				"json");

		$.post(
				basthPath+"pub/pub/queryCount",
				{"flag":3},
				function(result){
					$("#RichangAllCount").html(result.count);
				},
				"json");

		$.post(
				basthPath+"pub/pub/queryCount",
				{"flag":4},
				function(result){
					$("#LianghuaCheckedCount").html(result.count);
				},
				"json");

		$.post(
				basthPath+"pub/pub/queryCount",
				{"flag":5},
				function(result){
					$("#LianghuaUncheckedCount").html(result.count);
				},
				"json");

		$.post(
				basthPath+"pub/pub/queryCount",
				{"flag":8},
				function(result){
					$("#ZhuanXiangCheckedCount").html(result.count);
				},
				"json");

		$.post(
				basthPath+"pub/pub/queryCount",
				{"flag":9},
				function(result){
					$("#ZhuanXiangUncheckedCount").html(result.count);
				},
				"json");

		$.post(
				basthPath+"pub/pub/queryCount",
				{"flag":10},
				function(result){
					$("#ZhuanXiangAllCount").html(result.count);
				},
				"json");

		$.post(
                basthPath+"pub/pub/queryCount1",
                {"flag":11},
                function(result){
                    option = {
                        title : {
                            text: '主体企业分布',
                            //subtext: '2018-03-27',
                            x:'center'
                        },
                        tooltip : {
                            trigger: 'item',
                            formatter: function (params, ticket, callback) {//气泡弹窗回调
                                $.post(basthPath + "pub/pub/queryCount2", {'flag': params.name}, function (content) {
                                    var data = JSON.parse(content).data;
                                    var str = params.name + "<br/>";
                                    for (var i = 0; i < data.length; i++) {
                                        str += data[i].name + '\t: \t';
                                        str += data[i].value + '<br/>';
                                    }
                                    callback(ticket, str);
                                });
                                return "loding";
                            }
                        },
                        legend: {
                            orient : 'vertical',
                            x : 'left',
                            data:['食品生产','食品流通','餐饮服务',"小作坊",'药品','医疗器械','化妆品','保健品']
                        },
                        toolbox: {
                            show : false,
                            feature : {
                                mark : {show: true},
                                dataView : {show: true, readOnly: false},
                                magicType : {
                                    show: true,
                                    type: ['pie', 'funnel'],
                                    option: {
                                        funnel: {
                                            x: '25%',
                                            width: '50%',
                                            funnelAlign: 'left',
                                            max: 1548
                                        }
                                    }
                                },
                                restore : {show: true},
                                saveAsImage : {show: true}
                            }
                        },
                        calculable : true,
                        series : [
                            {
                                name:'主体企业分布',
                                type:'pie',
                                radius : '55%',
                                center: ['50%', '60%'],
                                data:result.data
                            }
                        ]
                    };

                    var myChart = echarts.init(document.getElementById('main'),"macarons");
                    myChart.setOption(option);
                },
				"json");

		$.post(
				basthPath+"pub/pub/queryCount1",
				{"flag":12},
				function(result){
					var name = [];
					var value = [];
					for(var i=0;i<result.data.length;i++){
						name[i] = result.data[i].name;
						value[i] = result.data[i].value;
//						console.log(result.data[i].value)
					}
//					name[result.data.length] = "样例";
//					value[result.data.length] = 100;
//					console.log(value)
					option4 = {
						title : {
							text: ''
						},
						tooltip : {
							trigger: 'axis'
						},
						legend: {
							show : false,
							data:['2018年']
						},
						toolbox: {
							show : false,
							feature : {
								mark : {show: true},
								dataView : {show: true, readOnly: false},
								magicType: {show: true, type: ['line', 'bar']},
								restore : {show: true},
								saveAsImage : {show: true}
							}
						},
						calculable : true,
						xAxis : [
                            {
                                min:'dataMin',
                                axisLabel:{                 //---坐标轴 标签
                                    rotate:20,                  //---旋转角度
                                    fontStyle:'normal',      //字体样式
//                                    fontWeight:'bold',          //字体粗细
                                    fontSize:'14',               //字体大小
                                    //color:'black',
                                    fontFamily:'Courier New'
                                },
                                type : 'category',
                                data : name
                            }

						],

						yAxis : [
                            {
                                type : 'value',
                                boundaryGap : [0, 0.01]
                            }
						],
						series : [
							{
								name:'2018年',
								type:'bar',
								data:value
							}
						]
					};

					var myChart4 = echarts.init(document.getElementById('main4'),"macarons");
					myChart4.setOption(option4);
				},
				"json");

		$.post(
				basthPath+"pub/pub/queryCount",
				{"flag":14},
				function(result){
					$("#ZhuTiFuGaiLv").attr("lay-percent","3"+result.count+"%");
					element.render();
				},
				"json");

		$.post(
				basthPath+"pub/pub/queryCount",
				{"flag":13},
				function(result){
					option2 = {
						title : {
							text: '三小分布',
							//subtext: '2018-03-27',
							x:'center'
						},
						tooltip : {
							trigger: 'item',
							formatter: "{a} <br/>{b} : {c} ({d}%)"
						},
						legend: {
							orient : 'vertical',
							x : 'left',
							data:['食品小作坊','小摊贩','微型餐饮']
						},
						toolbox: {
							show : false,
							feature : {
								mark : {show: true},
								dataView : {show: true, readOnly: false},
								magicType : {
									show: true,
									type: ['pie', 'funnel'],
									option: {
										funnel: {
											x: '25%',
											width: '50%',
											funnelAlign: 'left',
											max: 1548
										}
									}
								},
								restore : {show: true},
								saveAsImage : {show: true}
							}
						},
						calculable : true,
						series : [
							{
								name:'三小分布',
								type:'pie',
								radius : '55%',
								center: ['50%', '60%'],
								data:result.data
							}
						]
					};

					var myChart2 = echarts.init(document.getElementById('main2'),"macarons");
					myChart2.setOption(option2);
				},
				"json");

//		$.post(basthPath+"pub/pub/queryCount?flag=1",function(result){
//			console.log("查询企业总数"+result.count);
//			$("#xkzdq").html(result.count);
//		});

	})
</script>

</body>
</html>