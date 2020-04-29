<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>人员诚信管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

	<script type="text/javascript">
        //证件类型
        var ryzjlx = <%=SysmanageUtil.getAa10toJsonArray("RYZJLX")%>;
        //人员性别
        var ryxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
        //人员民族
        var rymz = <%=SysmanageUtil.getAa10toJsonArray("AAC005")%>;
        //人员学历
        var ryxueli = <%=SysmanageUtil.getAa10toJsonArray("RYXUELI")%>;
        //人员健康情况
        var v_ryjkqk = <%=SysmanageUtil.getAa10toJsonArray("RYJKQK")%>;

        //        var v_discredtype = [{"id":"","text":""},{"id":"1","text":"严重失信"},{"id":"2","text":"失信"}];

        var url ="<%=basePath%>/aqcx/trust/queryTrustInfos";
        var form;
        var table;
        var layer;
        var selectNodes;
        var element; //
        var selectTableDataId = '';
        $(function() {
            initData();
//            initSelectData();
        });
        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: url
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度
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
                        {field: 'ryxm',  title: '人员姓名', event: 'trclick'}
                        , {field: 'rymz',  title: '民族'
                          ,templet : function(d){
                      		var userkind = d.id;
                   			 $.each(rymz, function(i, n) {
                       			 if (d.rymz == n.id){
                           			 userkind = n.text;
                            		return false; // 跳出本次循环
                        }
                    });
                        return userkind;
                        },event: 'trclick'}
                        , {field: 'ryxb',  title: '人员性别'
                            ,templet : function(d){
                                return formatGridColData(ryxb, d.ryxb);
							}
                            ,event: 'trclick'}

                        , {field: 'ryjkqk',  title: '健康状况'
                            ,templet : function(d){
                                var userkind = d.id;
                                $.each(v_ryjkqk, function(i, n) {
                                    if (d.ryjkqk == n.id){
                                        userkind = n.text;
                                        return false; // 跳出本次循环
                                    }
                                });
                                return userkind;
                            },event: 'trclick'}
                        , {field: 'rynl',  title: '年龄', event: 'trclick'}
                        , {field: 'rycsrq', width: 210, title: '出生日期', event: 'trclick'}
                        , {field: 'rybyyx',  title: '毕业院校', event: 'trclick'}
                        , {field: 'ryjg',  title: '籍贯', event: 'trclick'}
                        , {field: 'cxrecord',width: 210,  title: '行为类型'
                            ,templet: function (d) {
                                if (d.cxrecord == "1" ) {
                                    return '<span style="color:blue">诚信行为记录</span>';
                                }
                                else{
                                    return '<span style="color:red">失信行为记录</span>';
                                }
                            }
                            ,event: 'trclick'}

                        , {field: 'starttime',width: 210,  title: '开始时间', event: 'trclick'}
                        , {field: 'endtime',width: 210,  title: '结束时间', event: 'trclick'}
                        , {field: 'situation',width: 210,  title: '具体情况', event: 'trclick'}
                        , {field: 'score',  title: '分值', event: 'trclick'}
                        , {field: 'telephone', width: 150, title: '联系电话', event: 'trclick'}
					]]
				});
                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.id) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.id;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    showtrust: function () { // 查看结果明细
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的人员信息！');
                        } else {
                            showtrust(table.singleData);
                        }
                    }
//                    ,adddiscred: function () {
//                        adddiscred();
//                }
                ,updatetrust: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要修改的人员信息！');
                        } else {
                            updatetrust(table.singleData);
                        }
                    },addtetrust: function () {
                            addtetrust();
                    },adddishonesty: function () {
                        adddishonesty();
                    }
                    ,deltrust: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要删除的人员信息！');
                        } else {
                            deltrust(table.singleData);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function(){
                    query();
                    return false;
                });
			})
        };
        // 重置
        function reload() {
            table.reload('roleTable', {
                url : basePath + '/aqcx/trust/queryTrustInfos'
            });
        };
		function query() {
            // 查询
            var ryname = $('#ryname').val();
            var param = {
                'ryname': ryname,
            }
            table.reload('roleTable', {
                url : basePath + '/aqcx/trust/queryTrustInfos'
                ,where: param //设定异步数据接口的额外参数
            });
		}


        function showtrust(data) {
            var url = basePath + '/aqcx/trust/trustFormIndex?' +
				'op=view&id=' + data.id+'&cxrecord='+data.cxrecord+'&ryxm='+data.ryxm;
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看人员档案'
                , content: url
                , btn: ['关闭']
            });
        }

        function addtetrust() {
		    var cxrecord="1";
            sy.modalDialog({
                title : '新增信息'
                ,content : basePath + '/aqcx/trust/trustFormIndex?cxrecord='+cxrecord
                ,area : ['100%', '100%']
                ,btn : ['保存', '取消'] //可以无限个按钮
                ,btn1: function(index, layero){
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            },closeModalDialogCallback);
        }
        function adddishonesty() {
            var cxrecord="2";
            sy.modalDialog({
                title : '新增信息'
                ,content : basePath + '/aqcx/trust/trustFormIndex?cxrecord='+cxrecord
                ,area : ['100%', '100%']
                ,btn : ['保存', '取消'] //可以无限个按钮
                ,btn1: function(index, layero){
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            },closeModalDialogCallback);
        }
//        function adddiscred(){
//            sy.modalDialog({
//                title : '新增信息'
//                ,content : basePath + 'aqcx/discred/discredFormIndex'
//                ,area : ['900px', '550px']
//                ,btn : ['保存', '取消'] //可以无限个按钮
//                ,btn1: function(index, layero){
//                    window[layero.find('iframe')[0]['name']].submitForm();
//                }
//            },closeModalDialogCallback);
//		}
        // 关闭窗口回掉函数
        function closeModalDialogCallback(dialogID){
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if(obj.type == "ok"){
                table.reload('roleTable', {
                    url : basePath + '/aqcx/trust/queryTrustInfos'
                });
            }
        }
        function updatetrust(data) {
            var id=data.id;
            var url = basePath + '/aqcx/trust/trustFormIndex?id=' + id+'&cxrecord='+data.cxrecord+'&ryid='+data.ryid+'&ryxm='+data.ryxm;
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '编辑人员诚信信息'
                , content: url
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function deltrust(data) {
            var id=data.id;
            layer.open({
                title : '警告'
                ,content : '你确定要删除该项记录么？'
                ,btn : ['确定', '取消'] //可以无限个按钮
                ,btn1: function(index, layero){
                    $.post(basePath + '/aqcx/trust/delTrust', {
                            id : id
                    },
                        function(result) {
                            if (result.code == '0') {
                                layer.msg('删除成功', {time:500},function(){
                                    table.reload('roleTable', {
                                        url : basePath + '/aqcx/trust/queryTrustInfos'
                                    });
                                    table.singleData = '';
                                    selectTableDataId = '';
                                });
                            } else {
                                layer.open({
                                    title : "提示",
                                    content : "删除失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json')
                }
			})

        }


	</script>

</head>
<body>
<div class="layui-fluid">
	<div class="layui-collapse">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">失信查询条件信息</h2>
			<div class="layui-colla-content layui-show" style="height: 40px">
				<form id="myqueryform" class="layui-form">
					<div class="layui-form-item">
						<label class="layui-form-label">人员名称</label>
						<div class="layui-input-inline">
							<input type="text" id="ryname" name="ryname"
								   autocomplete="off" class="layui-input">
						</div>
						<div class="layui-input-inline" >
							<fieldset class="layui-elem-field site-demo-button" style="border: none;">
								<div>
									<button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
										<i class="layui-icon">&#xe615;</i>搜索
									</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal"
											id="btn_reset">
										<i class="layui-icon">&#xe621;</i>重置
									</button>
								</div>
							</fieldset>
						</div>
					</div>
				</form>
			</div>
				<fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
					<div class="layui-btn-group demoTable">
						<ck:permission biz="showtrust">
							<button class="layui-btn" data-type="showtrust" data="btn_showtrust">查看</button>
						</ck:permission>
						<%--<ck:permission biz="adddiscred">--%>
							<%--<button class="layui-btn" data-type="adddiscred" data="btn_adddiscred">添加</button>--%>
						<%--</ck:permission>--%>
						<ck:permission biz="updatetrust">
							<button class="layui-btn" data-type="updatetrust" data="btn_updatetrust">修改</button>
						</ck:permission>
						<ck:permission biz="addtetrust">
							<button class="layui-btn" data-type="addtetrust" data="btn_addtetrust">添加诚信行为记录</button>
						</ck:permission>

						<ck:permission biz="adddishonesty">
							<button class="layui-btn" data-type="adddishonesty" data="btn_adddishonesty">添加失信行为记录</button>
						</ck:permission>

						<ck:permission biz="deltrust">
							<button class="layui-btn" data-type="deltrust" data="btn_deltrust">删除</button>
						</ck:permission>
					</div>
				</fieldset>
				<table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
			</div>

	</div>
</div>
</body>
</html>