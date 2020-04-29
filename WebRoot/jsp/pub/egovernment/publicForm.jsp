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
	<!--公共页面-->
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

	<script type="text/javascript">
        var s = new Object();
        s.type = "";   //设为空不刷新父页面
        sy.setWinRet(s);

        function gongwen (){
            document.getElementById("ajslcommonframe").src='<%=basePath%>egovernment/archive/archiveFormIndex?op=view&archiveid=' + '<%=v_ajdjid%>';
        };

        //提交流程
        function tijiaoliucheng(){

            var v_transname ="";
            v_transname=$('#xuanzeliuxiang input[name="transname"]:checked ').val();
            if (v_transname==undefined){
                layer.alert("请选择办理流向");
                return false;
            }

            var cyryid = $("#cyryid").val();

                var cfmMsg = "确定要提交流程吗?";
                var v_transyy = $("#transyy").val();

                var v_transval = "七日内做出决定";
                var v_shifouTongguo = "1";

                var v_url = encodeURI(encodeURI("<%=basePath%>workflow/doWfprocess?ywlcid=<%=v_ywlcid%>&transval=" + v_transval + "&shifouTongguo=" + v_shifouTongguo+ "&ywlcuserid=" + cyryid + "&transname=" + v_transname + "&transyy=" + v_transyy + "&time=" + new Date().getMilliseconds()));
                layer.confirm(cfmMsg, {title: '确定'}, function (r) {
                    if (r) {
//                    parent.$.messager.progress({
//                        text : '数据加载中....'
//                    });

                        $.ajax({
                            url: v_url,
                            type: 'post',
                            async: true,
                            cache: false,
                            timeout: 100000,
                            //data:formData,
                            error: function () {
//                            parent.$.messager.progress('close');
                                layer.alert("服务器繁忙，请稍后再试！");
                            },
                            success: function (result) {
//                            parent.$.messager.progress('close');
                                result = $.parseJSON(result);
                                if (result.code == '0') {
                                    layer.confirm('提交流程成功！', {
                                        btn: ['确定'] //按钮
                                        , title: '提示!'
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


	<script type="text/javascript">
        var layer;
        var form;
        $(function () {
            gongwen();
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;

                $.post(basePath + '/workflow/queryYwlclog', {
                    ywbh: '<%=v_ywbh%>'
                }, function (result) {
//                    alert(result.size);
                    if (result.code == '0') {
                        var data = result.rows;
                        for(var i=0;i<data.length;i++) {
                            if (data[i].nodeid == 25) {
                                $("#createUser").html(data[0].aae011)
                            }
                            if (data[i].nodeid == 28) {
                                $("#manuscript").html(data[0].aae011)
                            }
                            if (data[i].nodeid == 37) {
                                $("#issue").html(data[0].aae011)
                            }
                            if (data[i].nodeid == 37) {
                                $("#issue").html(data[0].aae011)
                            }
//                            console.log(data);


                        }

                    }
                }, 'json')
            })
     		var text;
            var huigao;
            var  miji;
            var  qixian;
            var  dmyj;
            var  zhusong;
            var   chaosong;
            var   dazhi;
            var   xiaodui;
            var   fenshu;
            var  fawen;
            var   fawen1;
            var  fawen2;
            var shijian;
            var nian;
            var yue;
            var ri;
            var ztci;
            var newDate;


            $.ajax({
				type:'POST',
				url:basePath + '/egovernment/archive/queryArchiveDTO',
				dataType:'json',
				data:{ archiveid:'<%=v_ajdjid%>'},
				async:false,
				success:function(result){
					var mydata = result.data;
					text=mydata.archivetitle;

                       huigao=mydata.huigao;
                       miji=mydata.rank;
                       qixian=mydata.term;
                      dmyj=mydata.fixedbasis;
                     zhusong=mydata.maindelivery;
                       chaosong=mydata.copy;
                       dazhi=mydata.typing;
                       xiaodui=mydata.proofreading;
                       fenshu=mydata.number;
                      fawen=mydata.writing1;
                       fawen1=mydata.writing2;
                      fawen2=mydata.writing3;
                    shijian=mydata.sealtime;
                    var val = Date.parse(shijian);
                     newDate = new Date(val);
                     ztci=mydata.thematicwords;
				}
			});
			$("#biaoti").html(text);
            $("#huigao").html(huigao);
            $("#miji").html(miji);
            $("#qixian").html(qixian);
            $("#dmyj").html(dmyj);
            $("#zhusong").html(zhusong);
            $("#chaosong").html(chaosong);
            $("#dazhi").html(dazhi);
            $("#xiaodui").html(xiaodui);
            $("#fenshu").html(fenshu);
            $("#fawen3").html(fawen);
            $("#fawen1").html(fawen1);
            $("#fawen2").html(fawen2);
            $("#nian").html(newDate.getFullYear());
            $("#yue").html(newDate.getMonth()+1);
            $("#ri").html(newDate.getDate());
            $("#ztci").html(ztci);
            fj();

        })

        // 上传图片附件
        function uploadFjView(type) {
            var id="<%=v_ajdjid%>"
            var url = basePath + "jsp/pub/egovernment/uploadViewWare.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传文档附件'
                , content: url
                , param: {
                    folderName: "writing",
                    fjwid: id,
					fjtype:type
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    /*$("#ceshi").html(myrow.fjpath);*/ //人员id
                    var html=$("#ceshi").html();
                    html+="<a href='javascript:;' onclick=check('"+myrow.fjpath+"')>"+obj.fjname+"</a></br>";
                    $("#ceshi").html(html);
                }
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        //
                    }
                }
            });
        }
        function fj() {
            var html="";
            $.ajax({
                type:'POST',
                url:basePath + '/workflow/FJ',
                dataType:'json',
                data:{ fjwid:'<%=v_ajdjid%>'},
                async:false,
                success:function(result){
                    var mydata = result.data;
                    for(var i=0;i<mydata.length;i++){
                        var a=mydata[i].fjname;
                        var b=mydata[i].fjpath;
                        html+="<a href='javascript:;' onclick=check('"+b+"')>"+a+"</a></br>";

					}
                }
            });
            $("#ceshi").html(html);
        }
function check(s) {
    window.open(s);

}
        function chakan() {
            var ce=$("#ceshi").html();
            sy.modalDialog({
                title: '查看'
                , area: ['100%', '100%']
                , content: basePath + ce
                , btn: ['关闭']
            });

        }

	</script>
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
			margin-left: 8%;
		}
		.margin_main_line_1 {
			margin-left: 35%;
		}
	</style>
</head>
<body>
<iframe name="ajslcommonframe" id="ajslcommonframe" src="" width="100%" height="1000px;"  scrolling="no" frameborder="0" ></iframe>
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
			<%--<textarea class="easyui-validatebox" id="transyy" name="transyy" style="width: 600px;"
					  rows="8" data-options="required:false,validType:'length[0,200]'"></textarea>--%>
				<textarea class="layui-textarea" id="transyy" name="transyy"></textarea>
				</td>
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
	<%--<a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="tijiaoliucheng()"
	   data-options="iconCls:'icon-save'">提交流程</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeWindow()"
	   data-options="iconCls:'icon-back'">关闭</a>--%>
	<button class="layui-btn"  id="saveBtn" onclick="tijiaoliucheng()">提交流程</button>
	<button class="layui-btn" id="BtnFanhui" onclick="closeWindow()">关闭</button>

</div>






<center><span class="font_main_title">中牟市食品药品监督管理局发文稿纸</span></center>
<form class="layui-form" action="" id="fawen">
	<table class="layui-table">
		<tr>
			<td colspan="2" style="text-align:left;width: 60%">
				<span class="font_main">拟稿人:</span><span id="createUser"></span><br/>
				<span class="font_main">核稿人:</span><span id="manuscript"></span>

			</td>
			<td  rowspan="3" colspan="2" style="text-align: left">
				<span class="font_main" style="padding-top: 50px">签发:</span><span id="issue"></span>

			</td>
		</tr>
		</tr>
		<tr>
			<td  colspan="2" style="text-align:left;width: 60%">
				<span class="font_main">合法性审查:</span><br/>
				<br/>
				<br/>

			</td>
		</tr>
		<tr>
			<td  colspan="2" style="text-align:left;width: 60%"><span class="font_main">办公室审核:</span></td>

		</tr>
		<tr>
			<td colspan="2" rowspan="2" style="text-align:left;"><span class="font_main">会稿:</span><span id="huigao"></span></td>

			<td ><span class="font_main">密级:<span id="miji"></span></span>
			</td>
			<td ><span class="font_main">期限:</span><span id="qixian"></span>
			</td>
		</tr>
		<tr>
			<td colspan="2"><span class="font_main">定密依据:</span><span id="dmyj"></span>
			</td>

		</tr>
		<tr>
			<td rowspan="2" style="text-align:right;width:5%"><span class="font_main">发<br/>送<br/>机<br/>关</span></td>
			<td  colspan="3"><span class="font_main">主送</span><span id="zhusong"></span>

			</td>
		</tr>
		<tr>
			<td  colspan="3"><span class="font_main">抄送</span><span id="chaosong"></span>

			</td>
		</tr>
		<tr>
			<td  colspan="4">
				<span class="font_main">打字:</span><span id="dazhi"></span>
				<span class="font_main margin_main_line_1">校对:</span><span id="xiaodui"></span>
				<span class="font_main margin_main_line_1">份数:</span><span id="fenshu"></span>

			</td>
		</tr>
		<tr>
			<td  colspan="4">
				<span class="font_main">发文: </span><span id="fawen3"></span>
				<span class="font_main margin_main_line">中牟食药监(</span><span id="fawen1"></span>
				<span class="font_main margin_main_line">) </span><span id="fawen2"></span>
				<span class="font_main margin_main_line">号 </span></span><span id="nian"></span>
				<span class="font_main margin_main_line">年 </span><span id="yue"></span>
				<span class="font_main margin_main_line">月  </span><span id="ri"></span>
				<span class="font_main margin_main_line">日
				<span class="font_main margin_main_line">封发</span>

			</td>
		</tr>
		<tr>
			<td  colspan="4">
				<span class="font_main">标题:</span><br/><br/>
				<span id="biaoti"></span>
			</td>
		</tr>
		<tr>
			<td  colspan="4">
				<span class="font_main">附件:</span><br/><br/>
				<a id="btnselectcom" href="javascript:void(0)"
				   class="layui-btn" iconCls="icon-upload"
				   onclick="uploadFjView(2)">上传附件</a><br/>


				<span id="ceshi"></span>

			</td>
		</tr>
		<tr>
			<td  colspan="4">
				<span class="font_main">主题词:</span><span id="ztci"></span><br/><br/>

			</td>
		</tr>
	</table>
</form>

</body>
</html>


