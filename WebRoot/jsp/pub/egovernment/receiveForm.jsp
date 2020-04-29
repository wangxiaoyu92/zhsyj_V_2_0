<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.workflow.Wf_node_trans" %>
<%@ page import="java.util.List,com.zzhdsoft.siweb.service.workflow.WorkflowService,java.net.URLDecoder" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ywbh"));
	String v_ywlcid = StringHelper.showNull2Empty(request.getParameter("ywlcid"));
	String v_psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
	String v_transfrom=StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_nodename=URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("nodename")),"UTF-8");
	String v_nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_fjcsdmlb = StringHelper.showNull2Empty(request.getParameter("fjcsdmlb"));
	String v_fjcsdlbh = StringHelper.showNull2Empty(request.getParameter("fjcsdlbh"));
	String v_ywbh = StringHelper.showNull2Empty(request.getParameter("ywbh"));



	//获取分支节点流向值
	WorkflowService v_WorkflowService=new WorkflowService();
	List<Wf_node_trans> v_listWf_node_trans=(List<Wf_node_trans>)v_WorkflowService.queryWfnodeTransList(v_psbh,v_transfrom);

	String v_nextchecked="";
	int v_transCount=0;
	if (v_listWf_node_trans!=null){
		v_transCount=v_listWf_node_trans.size();
		if (v_transCount==1){
			v_nextchecked="checked='checked'";
		}

	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>公文流程办理：<%=v_nodename %></title>
	<!--收文-->
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<style>
		.layui-table td {
			border-color: #ff0000;
		}
		.font_main {
			color: #ff0000;
			font-size: 15pt;
		}
		.font_main_title {
			color: #ff0000;
			font-size: 25pt;
		}

		.margin_main_line {
			margin-left: 2%;
		}
		.margin_main_line_1 {
			margin-left: 35%;
		}
		.margin_main_line3 {
			margin-left: 10%;
		}
	</style>
	<script type="text/javascript">

		var layer;
		var form;
        //下拉框列表
        var v_lwjg = <%=SysmanageUtil.getAa10toJsonArray("lwjg")%>; // 来文机关
        function gongwen(){
            layui.use([ 'layer'], function () {
                layer = layui.layer;
            });
            document.getElementById("ajslcommonframe").src='<%=basePath%>egovernment/archive/archiveFormIndex?op=view&archiveid=' + '<%=v_ajdjid%>';
        };
        $(function () {
            gongwen();
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                // 来文机关下拉框
                intSelectData('lwjg', v_lwjg);
				form.render();
                $.post(basePath + '/workflow/queryYwlclog', {
                    ywbh: '<%=v_ywbh%>'
                }, function (result) {
//                    alert(result.size);
                    if (result.code == '0') {
                        var data = result.rows;
                        for(var i=0;i<data.length;i++) {
                            if (data[i].nodeid == 3) {
                                $("#createUser").html(data[0].aae011)
                            }
                            if (data[i].nodeid == 10) {
                                $("#setup").html(data[0].aae011)
                            }
                            if (data[i].nodeid == 4) {
                                $("#batches").html(data[0].aae011)
                            }
                        }

                    }
                }, 'json')
            })
            var text;
            $.ajax({
                type:'POST',
                url:basePath + '/egovernment/archive/queryArchiveDTO',
                dataType:'json',
                data:{ archiveid:'<%=v_ajdjid%>'},
                async:false,
                success:function(result){
                    var mydata = result.data;
                    text=mydata.archivetitle;
                }
            });
            $("#biaoti").html(text);

        })

	</script>
	<script type="text/javascript">
        //下拉框列表
        <%--var v_lwjg = <%=SysmanageUtil.getAa10toJsonArray("lwjg")%>; // 来文机关--%>
		var s = new Object();
		s.type = "";   //设为空不刷新父页面
		sy.setWinRet(s);
        var layer;
        function gongwen(){
            layui.use([ 'layer'], function () {
                layer = layui.layer;
            });
            document.getElementById("ajslcommonframe").src='<%=basePath%>egovernment/archive/archiveFormIndex?op=view&archiveid=' + '<%=v_ajdjid%>';
        };

		//提交流程
		function tijiaoliucheng(){

			var v_transname ="";
			v_transname=$('#xuanzeliuxiang input[name="transname"]:checked ').val();
			if (v_transname==undefined){
				alert("请选择办理流向");
				return false;
			}
            var cyryid = $("#cyryid").val();
                var cfmMsg = "确定要提交流程吗?";
                var v_transyy = $("#transyy").val();

                var v_transval = "七日内做出决定";
                var v_shifouTongguo = "1";
                var v_url = "<%=basePath%>/egovernment/archive/a2Rearchive?archiveid=<%=v_ajdjid%>";
                var v_url2 = encodeURI(encodeURI("<%=basePath%>workflow/doWfprocess?ywlcid=<%=v_ywlcid%>&transval=" + v_transval + "&shifouTongguo=" + v_shifouTongguo+ "&ywlcuserid=" + cyryid + "&transname=" + v_transname + "&transyy=" + v_transyy + "&time=" + new Date().getMilliseconds()));
                $.messager.confirm('确认', cfmMsg, function (r) {
                    if (r) {
                        parent.$.messager.progress({
                            text: '数据加载中....'
                        });

                        $.ajax({
                            url: v_url,
                            type: 'post',
                            async: true,
                            cache: false,
                            timeout: 100000,
                            error: function () {
                                parent.$.messager.progress('close');
                                alert("服务器繁忙，请稍后再试！");
                            },
                            success: function (result) {
                                parent.$.messager.progress('close');
                                result = $.parseJSON(result);
                                if (result.code == '0') {
                                    $.ajax({
                                        url: v_url2,
                                        type: 'post',
                                        async: true,
                                        cache: false,
                                        timeout: 100000,
                                        //data:formData,
                                        error: function () {
                                            parent.$.messager.progress('close');
                                            alert("服务器繁忙，请稍后再试！");
                                        },
                                        success: function (result) {
                                            parent.$.messager.progress('close');
                                            result = $.parseJSON(result);
                                            if (result.code == '0') {
                                                layer.confirm('提示! 提交流程成功！', {
                                                    btn: ['确定'] //按钮
                                                }, function () {
                                                    window.parent.location.reload();
                                                    var index = parent.layer.getFrameIndex(window.name);
                                                    parent.layer.close(index);
                                                });
                                            } else {
                                                parent.$.messager.alert();
                                                layer.alert('提示!-提交流程失败：' + result.msg);
                                            }
                                        }

                                    });
                                } else {
                                    parent.$.messager.alert('提示', '提交流程失败：' + result.msg, 'error');
                                }
                            }

                        });


                    }
                })

		}
		function closeWindow(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
        function myselectAjdjXgry_layui(prm_rykind) {
            var v_useridstr = $("#workTaskDutyPerson").val();
            var url = "<%=basePath%>jsp/pub/pub/selectuserMore.jsp?useridstr=" + v_useridstr + "&a=" + new Date().getMilliseconds();
            var v_comrcjdglryid = "";
            var v_comrcjdglryname = "";
            sy.modalDialog({
                title: '选择人员'
                , area: ['800px', '450px']
                , content: url
                , btn: ['保存']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少

                if (v_retStr != null && v_retStr.length > 0) {
                    for (var k = 0; k <= v_retStr.length - 1; k++) {
                        var myrow = v_retStr[k];
                        if ("" == v_comrcjdglryid) {
                            v_comrcjdglryid = myrow.userid;
                            v_comrcjdglryname = myrow.description;
                        } else {
                            v_comrcjdglryid = v_comrcjdglryid + "," + myrow.userid;
                            v_comrcjdglryname = v_comrcjdglryname + "," + myrow.description;
                        }
                    }
                    $("#cyry").val(v_comrcjdglryname);
                    $("#cyryid").val(v_comrcjdglryid);
                }
            });
        }
	</script>
</head>
<body>
<iframe name="ajslcommonframe" id="ajslcommonframe" src="" width="100%" height="800px;"  scrolling="no" frameborder="0" ></iframe>
<div style="text-align: center;">
	<sicp3:groupbox title="">
		<table width="100%" height="60px;">
			<tr>
				<td width="15%" align="right">请选择下一节点流向：</td>
				<td width="88%" align="left">
					<div id="xuanzeliuxiang">
						<%for (Wf_node_trans v_Wf_node_trans:v_listWf_node_trans){%>
						<input type="radio" name="transname" <%=v_nextchecked%> id="transname"  value="<%=v_Wf_node_trans.getTransname() %>" style="cursor: pointer;"/><%=v_Wf_node_trans.getTransname() %>&nbsp;&nbsp;&nbsp;&nbsp;
						<%} %>
					</div>
				</td>
			</tr>

			<tr>
				<td align="right">
					处理意见：
				</td>
				<td align="left">
					<textarea class="layui-textarea" id="transyy" name="transyy"></textarea>
			</tr>
			<tr>
				<td align="right">下一节点负责人:</td>
				<td>
					<div class="layui-form-item">
						<div class="layui-input-inline">
							<input type="hidden" id="fileid" name="fileid" value="<%=v_ajdjid%>"/>
							<input type="text" id="cyry" name="cyry"
								   autocomplete="off" class="layui-input" style="width: 300px;" readonly="readonly">
							<input id="cyryid" name="cyryid" type="hidden"/>
						</div>
						<div class="layui-input-inline" style="padding-left:80px">
							&nbsp;
							<a href="javascript:void(0)" class="layui-btn" id="btn_rcjdglry"
							   iconCls="icon-search" onclick="myselectAjdjXgry_layui(1)">选择人员 </a>
							&nbsp;&nbsp;
							<a href="javascript:void(0)" class="layui-btn" id="remove"
							   iconCls="icon-no" onclick="myclearRcjdgly()">清除 </a>
						</div>
					</div>
				</td>
			</tr>
		</table>

	</sicp3:groupbox>
</div>
<div style="text-align: center;height: 100px">
	<br>
	<button class="layui-btn"  id="saveBtn" onclick="tijiaoliucheng()">提交流程</button>
	<button class="layui-btn" id="BtnFanhui" onclick="closeWindow()">关闭</button>
</div>





<center><span class="font_main_title">中牟市食品药品监督管理局收文联单</span></center><br/>
<span class="font_main">收文总编号: </span>
<span class="font_main margin_main_line3">收文20</span>
<span class="font_main margin_main_line"> </span>
<span class="font_main margin_main_line">年 </span>
<span class="font_main margin_main_line"> </span>
<span class="font_main margin_main_line">月 </span>
<span class="font_main margin_main_line"> </span>
<span class="font_main margin_main_line">日</span>
<form class="layui-form" action="" id="pcompany">
	<table class="layui-table">
		<tr>
			<td  style="text-align:center;width: 8%">
				<span class="font_main" style="padding-top: 50px">来文<br/>机关</span>
			</td>
			<td colspan="2" style="text-align:center;width: 44%">
				<span class="font_main" style="padding-top: 50px">
 <div class="layui-input-inline">

				<select name="lwjg" id="lwjg" autocomplete="off" >
				</select>
 </div>
</span>
			</td>
			<td  style="text-align:center;width: 8%">
				<span class="font_main" style="padding-top: 50px">密级</span>
			</td>
			<td  style="text-align:left;width: 10%">
				<span class="font_main" style="padding-top: 50px"></span>
			</td>
			<td  style="text-align:center;width: 10%">
				<span class="font_main" style="padding-top: 10px">份数</span>
			</td>
			<td  style="text-align:left;width: 10%">
				<span class="font_main" style="padding-top: 50px"></span>
			</td>

		</tr>
		<td  style="text-align:center;width: 8%">
			<span class="font_main" style="padding-top: 50px">来文<br/>字号</span>
		</td>
		<td  style="text-align:left;width: 10%">
			<span class="font_main" style="padding-top: 50px">
				<span class="font_main margin_main_line_1">字( </span>
				<span >&nbsp;  ) &nbsp;&nbsp; 号 </span>
</span>

		</td>
		<td  style="text-align:center;width: 6%">
			<span class="font_main" style="padding-top: 50px">附件</span>
		</td>
		<td colspan="4"  style="text-align:left;width: 10%">
			<span class="font_main" style="padding-top: 50px"></span>
		</td>
		<tr/>

		<tr>
			<td  style="text-align:center;width: 8%">
				<span class="font_main" style="padding-top: 50px">标<br/>题</span>
			</td>
			<td colspan="6"  style="text-align:left;width: 10%">
				<span class="font_main" style="padding-top: 50px"></span>
				<span id="biaoti"></span>
			</td>
		</tr>

		<tr>
			<td  style="text-align:center;width: 8%">
				<span class="font_main" style="padding-top: 50px"><br/>分<br/><br/><br/>办</span>
			</td>
			<td colspan="6"  style="text-align:left;width: 10%">
				<span class="font_main" style="padding-top: 50px"></span>
				<span id="division"></span>
			</td>
		</tr>
		<tr>
			<td  style="text-align:center;width: 8%">
				<span class="font_main" style="padding-top: 50px"><br/>拟<br/><br/><br/>办</span>
			</td>
			<td colspan="6"  style="text-align:left;width: 10%">
				<span class="font_main" style="padding-top: 50px"></span>
				<span id="setup"></span>
			</td>
		</tr>

		<tr>
			<td  style="text-align:center;width: 8%">
				<span class="font_main" style="padding-top: 50px"><br/>批<br/><br/><br/>示</span>
			</td>
			<td colspan="6"  style="text-align:left;width: 10%">
				<span class="font_main" style="padding-top: 50px"></span>
				<span id="batches"></span>
			</td>
		</tr>

	</table>
</form>

</body>
</html>