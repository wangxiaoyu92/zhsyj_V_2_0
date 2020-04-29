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
	<!--收文公共页面-->
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

	<script type="text/javascript">
        var s = new Object();
        s.type = "";   //设为空不刷新父页面
        sy.setWinRet(s);

        function gongwen (){
            document.getElementById("ajslcommonframe").src='<%=basePath%>egovernment/archive/archiveswEditFormIndex?op=view&archiveid=' + '<%=v_ajdjid%>';
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
                            data: {
                                fileid: $('#fileid').val(),
                                cyry: $('#cyry').val(),
                                cyryid: $('#cyryid').val()
                            },
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

	</script>


	<script type="text/javascript">
        $(function () {
            gongwen();
			var v_lwjg = <%=SysmanageUtil.getAa10toJsonArray("lwjg")%>; // 来文机关
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
                            console.log(data);


                        }

                    }
                }, 'json')
            })
            intSelectData('lwjg', v_lwjg);
            fj();
            var transname=$("#transname").val();

           if(transname=='分办') {
                $.ajax({
                    type: 'POST',
                    url: basePath + '/workflow/queryYwlclogDto',
                    dataType: 'json',
                    data: {
                        ywbh: '<%=v_ajdjid%>',
                        nodeid: 14
                    },
                    async: false,
                    success: function (result) {
                        var mydata = result.data;
                        pishi = mydata.transyy;
                        var playerHtml="";
                        playerHtml= playerHtml+pishi+"</br></br></br>";


                        if(mydata.fjpath== undefined){

                        }else {
                            playerHtml = playerHtml + "<div style='margin-left:550px;'><img src=\"" + sy.contextPath + mydata.fjpath + "\"/></div>";
                        }



                        $("#liban").html( playerHtml);
                    }
                })
            }else if(transname=='流程结束'){
               $.ajax({
                   type: 'POST',
                   url: basePath + '/workflow/queryYwlclogDto',
                   dataType: 'json',
                   data: {
                       ywbh: '<%=v_ajdjid%>',
                       nodeid: 14
                   },
                   async: false,
                   success: function (result) {
                       var mydata = result.data;
                       pishi = mydata.transyy;
                       var playerHtml="";
                       playerHtml= playerHtml+pishi+"</br></br></br>";

                      if(mydata.fjpath== undefined){

					  }else {
                          playerHtml = playerHtml + "<div style='margin-left:550px;'><img src=\"" + sy.contextPath + mydata.fjpath + "\"/></div>";
                      }

                       $("#liban").html( playerHtml);
                   }
               })
               $.ajax({
                   type: 'POST',
                   url: basePath + '/workflow/queryYwlclogDto',
                   dataType: 'json',
                   data: {
                       ywbh: '<%=v_ajdjid%>',
                       nodeid: 4
                   },
                   async: false,
                   success: function (result) {
                       var mydata = result.data;
                       pishi = mydata.transyy;
                       var playerHtml="";
                       playerHtml= playerHtml+pishi+"</br></br></br>";



                       if(mydata.fjpath== undefined){

                       }else {
                           playerHtml = playerHtml + "<div style='margin-left:550px;'><img src=\"" + sy.contextPath + mydata.fjpath + "\"/></div>";
                       }



                       $("#pishi").html( playerHtml);
                   }
               })
		   }
            var text;
			var lwjg;
			var swzbh;
			var rank;
			var number;
			var writing1;
            var writing2;
            var writing3;
            var sealtime;
			$.ajax({
				type:'POST',
				url:basePath + '/egovernment/archive/queryArchiveDTO',
				dataType:'json',
				data:{ archiveid:'<%=v_ajdjid%>'},
				async:false,
				success:function(result){
					var mydata = result.data;
					text=mydata.archivetitle;
					lwjg=mydata.lwjg;
					swzbh=mydata.swzbh;
					rank=mydata.rank;
					number=mydata.number;
                    writing1=mydata.writing1;
                    writing2=mydata.writing2;
                    writing3=mydata.writing3;
                    sealtime=mydata.sealtime;
				}
			});
			$("#biaoti").html(text);
            $("#transyy").val("同意");
			$("#lwjg").val(lwjg);
			$("#swzbh").html(swzbh);
			$("#rank").html(rank);
			$("#number").html(number);
            $("#writing1").html(writing1);
            $("#writing2").html(writing2);
            $("#writing3").html(writing3);
            $("#nian").html(sealtime.substring(2,4));
            $("#yue").html(sealtime.substring(5,7));
            $("#ri").html(sealtime.substring(8,10));
            form.render();

        })
        // 上传图片附件
        function uploadFjView(type) {
            var id="<%=v_ajdjid%>"
            var url = basePath + "jsp/pub/egovernment/uploadViewWare.jsp";
            sy.modalDialog({
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
        function myselectAjdjXgry_layui(prm_rykind){
            var v_useridstr=$("#workTaskDutyPerson").val();
            var url = "<%=basePath%>jsp/pub/pub/selectuserMore.jsp?useridstr="+v_useridstr+"&a="+new Date().getMilliseconds();
            var v_comrcjdglryid="";
            var v_comrcjdglryname="";
            sy.modalDialog({
                title:'选择人员'
                ,area : ['800px','450px']
                ,content:url
                ,btn:['保存']
                ,btn1: function(index, layero){
                    window[layero.find('iframe')[0]['name']].queding();
                }
            },function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少

                if (v_retStr!=null && v_retStr.length>0){
                    for (var k=0;k<=v_retStr.length-1;k++){
                        var myrow = v_retStr[k];
                        if (""==v_comrcjdglryid){
                            v_comrcjdglryid=myrow.userid;
                            v_comrcjdglryname=myrow.description;
                        }else{
                            v_comrcjdglryid=v_comrcjdglryid+","+myrow.userid;
                            v_comrcjdglryname=v_comrcjdglryname+","+myrow.description;
                        }
                    }
                    $("#cyry").val(v_comrcjdglryname);
                    $("#cyryid").val(v_comrcjdglryid);
                };
            });
        };
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
			font-size: 20pt;
		}

		.margin_main_line {
			margin-left: 10%;
		}
		.margin_main_line2 {
			margin-left: 20%;
		}
		.margin_main_line_1 {
			margin-left: 35%;
		}
	</style>
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
			<%--<textarea class="easyui-validatebox" id="transyy" name="transyy" style="width: 600px;"
					  rows="8" data-options="required:false,validType:'length[0,200]'"></textarea>--%>
				<textarea class="layui-textarea" id="transyy" name="transyy"></textarea>
				</td>
			</tr>
			<tr>
				<td  style="padding-left:80px">收文:</td>
				<td>
					<div class="layui-form-item">
						<div class="layui-input-inline">
							<input type="hidden" id="fileid" name="fileid" value="<%=v_ajdjid%>"/>
							<input type="text" id="cyry" name="cyry"
								   autocomplete="off" class="layui-input" style="width: 300px;" readonly="readonly" >
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






<center><span class="font_main_title">中牟市食品药品监督管理局收文联单</span></center>
<span class="font_main margin_main_line">收文总编号: </span>
<span id="swzbh"></span>
<span class="font_main margin_main_line">收文20</span>
<span id="nian"></span>
<span class="font_main margin_main_line">年 </span>
<span id="yue"></span>
<span class="font_main margin_main_line">月 </span>
<span id="ri"></span>
<span class="font_main margin_main_line">日</span>
<form class="layui-form" action="" id="fawen">
	<table class="layui-table">
		<tr>
			<td  style="text-align:center;width: 8%">
				<span class="font_main" style="padding-top: 50px">来文<br/>机关</span>
			</td>
			<td colspan="2" style="text-align:center;width: 44%">
				<span class="font_main" style="padding-top: 50px">
 <div class="layui-input-inline">

	 <select name="lwjg" id="lwjg"   >
	 </select>
 </div>
</span>
			</td>
			<td  style="text-align:center;width: 8%">
				<span class="font_main" style="padding-top: 50px">密级</span>
			</td>
			<td  style="text-align:left;width: 10%">
				<span id="rank"></span>
			</td>
			<td  style="text-align:center;width: 10%">
				<span class="font_main" style="padding-top: 10px">份数</span>
			</td>
			<td  style="text-align:left;width: 10%">
				<span id="number"></span>
			</td>

		</tr>
		<td  style="text-align:center;width: 8%">
			<span class="font_main" style="padding-top: 50px">来文<br/>字号</span>
		</td>
		<td  style="text-align:left;width: 36%">
			<span id="writing1"></span>
			<span class="font_main margin_main_line2">字( </span>
			<span id="writing2"></span>
			<span class="font_main margin_main_line">) </span>
			<span id="writing3"></span>
			<span class="font_main margin_main_line">号 </span>
		</td>
		<td  style="text-align:center;width: 8%">
			<span class="font_main" style="padding-top: 50px">附件</span>

		</td>
		<td colspan="4"  style="text-align:left;width: 10%">
			<span class="font_main" style="padding-top: 50px"></span>
			<a id="btnselectcom" href="javascript:void(0)"
			   class="layui-btn" iconCls="icon-upload"
			   onclick="uploadFjView(2)">上传附件</a><br/>
			<span id="ceshi"></span>
		</td>
		<tr/>


		<tr>
			<td  style="text-align:center;width: 8%">
				<span class="font_main" ><br/>标<br/>题</span><br/><br/>

			</td>
			<td  colspan="6">
				<span id="biaoti"></span>
			</td>
		</tr>
		<tr>
			<td  style="text-align:center;width: 8%">
				<span class="font_main"><br/><br/>分<br/><br/><br/>办</span><br/><br/><br/>
			</td>
			<td  colspan="6">
				<span id="fenban"></span>
			</td>
		</tr>
		<tr>
			<td  style="text-align:center;width: 8%">
				<span class="font_main"><br/><br/>拟<br/><br/><br/>办</span><br/><br/><br/>

			</td>
			<td  colspan="6">
				<span id="liban"></span>
			</td>
		</tr>
		<tr>
			<td style="text-align:center;width: 8%">
				<span class="font_main"><br/><br/><br/>批<br/><br/><br/><br/>示</span><br/><br/><br/><br/>

			</td>
			<td  colspan="6">
				<span id="pishi"></span>
			</td>
		</tr>
	</table>
</form>

</body>
</html>



