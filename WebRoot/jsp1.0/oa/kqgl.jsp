<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null==basePath || "".equals(basePath)){
        basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>签到统计</title>
    <style type="text/css">
        td{
            text-align:center;
        }
    </style>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>
     <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop"
               width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
    </object>

    <script type="text/javascript">
        function query(){
            var start = $("#startDate").val();
            var end = $("#endDate").val();
            if(start == null || start == undefined){
                alert("起始日期不能为空");
                return ;
            }
            if(end == null || end == undefined){
                alert("结束日期不能为空");
                return ;
            }
            if(start > end){
                alert("结束日期必须大于开始日期");
                return ;
            }
            $("#table").empty();
            $.ajax({
                url :basePath+'/kqgl/qddc/getcsv',
                data:{"startDate":start,"endDate":end },
                type:'post',
                dataType:'json',
                success:function (result){
                    for (var  sone =0 ;sone < result.length ;sone ++){
                        var tr = "";
                        if(sone == 0){
                            tr ="<tr><td>姓名</td><td>正常</td><td>迟到</td><td>缺卡</td>"
                        }else{
                            tr = "<tr><td>"
                                    +result[sone].username+"</td><td>"
                                    +result[sone].normal+"</td><td>"
                                    +result[sone].late+"</td><td>"
                                    +result[sone].miss+"</td>";
                        }
                        var fgtd = new Array();
                        var fgtd =  (result[sone].stat).split(",");
                        var td = "";
                        for (var arr=0 ; arr<fgtd.length;arr++){
                            td += "<td>"+fgtd[arr]+"</td>";
                        }
                        tr+=td+"</tr>";
                        $("#table").append($(tr))
                    }
                }
            })
        }
    </script>
    <script>
        var LODOP; //声明为全局变量

        //打印预览
        function printView() {
            CreatePrintPage();
            LODOP.PREVIEW();
        };

        //直接打印
        function printData() {
            CreatePrintPage();
            LODOP.PRINT();
        };

        //打印维护
        function printSetup() {
            CreatePrintPage();
            LODOP.PRINT_SETUP();
        };

        //打印设计
        function printDesign() {
            CreatePrintPage();
            LODOP.PRINT_DESIGN();
        };

        function CreatePrintPage() {
            LODOP = getLodop();
            LODOP.PRINT_INITA(0, 0, "200mm", "280mm", "执法文书——立案审批表");
            //LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
            LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", strBodyStyle
                    + document.getElementById("table").innerHTML);
        }
    </script>
</head>
<body>
<div class="easyui-layout" fit="true">
    <div region="center" style="overflow: true;" border="false">
        <sicp3:groupbox title="查询条件">
            <table class="table" style="width: 99%;">
                <tr>
                    <td style="text-align:right;"><nobr>起始日期</nobr></td>
                    <td><input id="startDate" name="startDate" style="width: 200px" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>
                    <td style="text-align:right;"><nobr>结束日期</nobr></td>
                    <td><input id="endDate" name="endDate" style="width: 200px" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>

                    <td>
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           iconCls="icon-search" onclick="query()"> 查 询 </a>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           iconCls="icon-print" onclick="print()"> 打印 </a>
                    </td>
                </tr>
            </table>
        </sicp3:groupbox>
        <sicp3:groupbox title="打卡信息">
            <table id = 'table' border="1" cellspacing="0" cellpadding="0"></table>
        </sicp3:groupbox>
    </div>
</div>
</body>
</html>