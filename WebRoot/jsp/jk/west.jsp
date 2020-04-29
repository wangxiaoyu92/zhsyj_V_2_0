<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String comdalei = StringHelper.showNull2Empty(request.getParameter("comdalei"));
%>
<script type="text/javascript">
    var comdalei_v = '<%=comdalei%>';
    //下拉框列表
    var comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
    var cb_comdalei;
    var grid;
    var grid2;
    var selectTableDataId = '';
    var table; // 数据表格
    var form; // form表单（查询条件）
    var layer; // 弹出层
    var mask;//进度条
    var element;
    $(function() {
//		//企业类别
//		cb_comdalei = $('#comdalei').combobox({
//			data:comdalei,
//			valueField:'id',
//			textField:'text',
//			required:false,
//			edittable:false,
//			panelHeight:'auto'
//		});
//
//
//		cb_comdalei.combobox('setValue',comdalei_v);
        layui.use(['form', 'table', 'layer', 'element'], function () {
            form = layui.form;
            table = layui.table;
            layer = layui.layer;
            element = layui.element;
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.render({
                elem: '#ycTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                , url: basePath + '/jk/jkgl/queryJkqy'
                ,where:{
                    'comcameraflag':1
                }
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
//                        { field : 'jcypid', width : 100, title: '检测样品ID' ,event: 'trclick'}
                    {field: 'jkqymc', width: 280, title: '监控企业名称', event: 'trclick'}
                ]]
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
            // 监听工具条
            table.on('tool(ycTable)', function (obj) {
                var data = obj.data;
                if (obj.event === 'trclick') { // 选中行
                    if (selectTableDataId != data.jkqybh) {
                        // 清除所有行的样式
                        $(".layui-table-body tr").each(function (k, v) {
                            $(v).removeAttr("style");
                        });
                        $(obj.tr.selector).css("background", "#90E2DA");
                        table.singleData = data;
                        selectTableDataId = data.jkqybh;
                        var jkqybh = data.jkqybh;
                        var jkqymc = data.jkqymc;
                        var camorgid = data.camorgid;
                        showSpjky(jkqybh,camorgid);
                    } else { // 再次选中清除样式
                        $(obj.tr.selector).attr("style", "");
                        table.singleData = '';
                        selectTableDataId = '';
                    }
                }
            });
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
        intSelectData("comdalei",comdalei);
        query();
    });

    // 查询
    function query() {
        if($("#aaa027name").val()==""){
			layer.alert("请填写所属地区");
			return
		}
        var aaa027 = $('#aaa027').val();
        var comdalei = $('#comdalei').val();
        var jkqybh = $('#jkqybh').val();
        var jkqymc = $('#jkqymc').val();
        var param = {
            'aaa027' : aaa027,
            'comdalei' : comdalei,
            'jkqybh': jkqybh,
            'jkqymc': jkqymc,
            'comcameraflag': 1
        };
        mask = layer.load(1, {shade: [0.1, '#393D49']});
        table.reload('ycTable', {
            url: basePath + '/jk/jkgl/queryJkqy'
            , page: {
                curr: 1 //重新从第 1 页开始
            }
            , where: param //设定异步数据接口的额外参数
            , done: function () {
                table.singleData = '';
                selectTableDataId = '';
                layer.close(mask);
            }
        });
//		grid.datagrid({
//			url : basePath + '/jk/jkgl/queryJkqy',
//			queryParams : param
//		});
//		grid.datagrid('clearSelections');
    }

    // 明厨亮灶视频监控
    function showSpjky(comid,camorgid) {
        var tabTitle = "视频监控";
        var url = '/jsp/jk/jkyAllList.jsp?comid=' + comid + '&jklx=1&camorgid=' + camorgid;
        addTab(tabTitle,url,'ext-icon-monitor');
    };

    function showMenu_aaa027() {
        var url = basePath + 'jsp/pub/pub/selectAaa027.jsp';
        sy.modalDialog({
            title : '监控',
            area:['300px','400px'],
            content : url
        },function (dialogID){
            var obj = sy.getWinRet(dialogID);//不可缺少
            if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
                $('#aaa027').val(obj.aaa027);
                $('#aaa027name').val(obj.aaa027name);
            }
            sy.removeWinRet(dialogID);//不可缺少
        })
    }
</script>

<div class="layui-collapse">
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">查询条件</h2>
		<div class="layui-colla-content layui-show">
			<form class="layui-form" id="myqueryform" action="" style="height: auto">
				<table class="layui-table" lay-skin="nob">
					<tr>
						<td><nobr>所属地区：</nobr></td>
						<td>
							<input name="aaa027name" id="aaa027name"  style="width: 150px " onclick="showMenu_aaa027();"
								   readonly class="layui-input" lay-verify="required" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:150px;height:450px;"></ul>
							</div>
						</td>
					</tr>
					<tr>
						<td><nobr>企业分类：</nobr></td>
						<td>
							<select id="comdalei" name="comdalei"></select>
						</td>
					</tr>
					<tr>
						<td><nobr>企业编号:</nobr></td>
						<td>
							<input class="layui-input" name="jkqybh" id="jkqybh">
						</td>
					</tr>
					<tr>
						<td><nobr>企业名称:</nobr></td>
						<td>
							<input class="layui-input" name="jkqymc" id="jkqymc">
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<div style="float: right">
								<button id="btn_query" type="button" class="layui-btn layui-btn-sm layui-btn-normal"
										>
									<i class="layui-icon">&#xe615;</i>搜索
								</button>
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
<table class="layui-hide" id="ycTable" lay-filter="ycTable">
	<input type="hidden" id="jkqybh" name="jkqybh">
	<input type="hidden" id="camorgid" name="camorgid">
</table>

