<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page
        import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.utils.StringHelper,com.zzhdsoft.siweb.service.workflow.WorkflowService,java.net.URLDecoder" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
    //String jcypid = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("jcypid")),"UTF-8");
    String v_jcypid = StringHelper.showNull2Empty(request.getParameter("jcypid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测结果</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var mygrid;
        //检测检验类别
        var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
        // 检验检测结论
        var v_jyjcjl = <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
        //检测检验审核标志
        var v_shbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        var layer;
        var table;
        var form;
        //检验检测名称
        $(function () {
            layui.use(['form', 'table', 'layer'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                table.render({
                    elem: '#jycpzTable',
                    url: basePath + 'jyjc/queryJyjcjg',
                    where: {
                        jcypid:'<%=v_jcypid%>'
                    }
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项jyjc
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    ,cols: [[
                        { field : 'jcjylb', width : 100, title: '检测检验类别' ,template:function (d) {
                            return sy.formatGridCode(v_jcjylb,d.jcjylb);
                        }},{
                            field:'jcypmc',width:100,title:'检测样品名称'
                        }
                        ,{
                            field:'commc',width:100,title:'受检单位名称'
                        }
                        ,{
                            field:'jcxmmc',width:100,title:'检测项目名称'
                        }
                        ,{
                            field:'jcxmbzz',width:100,title:'标准值'
                        }
                        ,{
                            field:'imphl',width:100,title:'结果值'
                        }
                        ,{
                            field:'fjjg',width:100,title:'复检结果'
                        }
                        ,{
                            field:'impjcjg',width:100,title:'结论',template:function (d) {
                                return sy.formatGridCode(v_jyjcjl,d.impjcjg);
                            }
                        }
                        ,{
                            field:'impjcsj',width:100,title:'检测日期'
                        }
                        ,{
                            field:'impjcry',width:100,title:'检验员'
                        }
                        ,{
                            field:'jcjycljg',width:100,title:'处理结果'
                        }
                        ,{
                            field:'jcjyshbz',width:100,title:'审核标志',template:function (d) {
                                return sy.formatGridCode(v_shbz,d.jcjyshbz);
                            }
                        }
                    ]]
                })
            })
        })
    </script>
</head>
<body>
<div class="layui-fluid">
    <table class="layui-hide" id="jycpzTable">
        <input type="hidden" id="jcjgid" name="jcjgid">
    </table>
</div>
</body>
</html>