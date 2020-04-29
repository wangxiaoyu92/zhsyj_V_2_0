<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%@ page import="com.askj.zfba.dto.Zfwsspypxzcfwsfy36DTO"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	//附件参数代码值
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	//执法文书代码值
	String v_fycontent = StringHelper.showNull2Empty(request.getParameter("fycontent"));
	//副页内容
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_zybid = StringHelper.showNull2Empty(request.getParameter("zybid"));
	//执法文书所在表的id
	String v_zfwslydjid = StringHelper.showNull2Empty(request.getParameter("zfwsqtbid"));
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	//第36个文书   副页
	String v_fytitle = StringHelper.showNull2Empty(request.getParameter("fytitle"));
	String v_fydjy = StringHelper.showNull2Empty(request.getParameter("fydjy"));
	String v_fygjy = StringHelper.showNull2Empty(request.getParameter("fygjy"));
	String sjws=null;
	if (request.getAttribute("sjws") != null) {
		sjws= (String)request.getAttribute("sjws");
		System.out.print(sjws);
	}
	Zfwsspypxzcfwsfy36DTO dto = new Zfwsspypxzcfwsfy36DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsspypxzcfwsfy36DTO) request.getAttribute("mybean");
	}
%>

<html>
<head>
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>食品药品行政处罚文书</title>
	<script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>
	<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
		<embed id="LODOP_EM" type="application/x-print-lodop"
			   width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
	</object>
	<meta content="X" name="author">
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
		var LODOP; //声明为全局变量
		var layer;
		var s = new Object();
		s.type = "";   //设为空不刷新父页面
		sy.setWinRet(s);
		$(function() {
			layui.use('layer',function(){
				layer =layui.layer;
			});
			var v_spypxzcfwsfyid=$("#spypxzcfwsfyid").val();
			if (v_spypxzcfwsfyid==null || v_spypxzcfwsfyid=="" || v_spypxzcfwsfyid.length== 0){
				$("#lcwmbBtn").linkbutton('disable');
				$("#printBtn").linkbutton('disable');
			}else{
				$("#lcwmbBtn").linkbutton('enable');
				$("#printBtn").linkbutton('enable');
			}

		});
		function mysave() {
			//下面的例子演示了如何提交一个有效并且避免重复提交的表单url: basePath+'/pub/zfwslaspb/savezfwslaspb';
			parent.$.messager.progress({
				text : '正在提交....'
			});
			$('#myform').form(
					'submit',
					{
						url : basePath + '/pub/wsgldy/savezfwsfyInfo',
						onSubmit : function() {
							var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
							if (!isValid) {
								parent.$.messager.progress('close'); // 如果表单是无效的则隐藏进度条
							}
							return isValid;
						},
						success : function(result) {
							parent.$.messager.progress('close');// 隐藏进度条
							result = $.parseJSON(result);
							if (result.code == '0') {
								$("#saveBtn").linkbutton('disable');
								$("#lcwmbBtn").linkbutton('enable');
								$("#printBtn").linkbutton('enable');
								alert("保存成功！");

							} else {
								alert("保存失败:"+ result.msg);
							}
						}
					});
		}
			function myprint() {
				var obj = new Object();
				var v_ajdjid = $("#ajdjid").val();
				var sjws = '<%=sjws%>';
				var v_spypxzcfwsfyid = $("#spypxzcfwsfyid").val();
				if (sjws == '2') {
					var url = "<%=basePath%>/common/sjb/getajdjDocumentsHtml?ajdjid="
							+ v_ajdjid + "&spypxzcfwsfyid=" + v_spypxzcfwsfyid + "&type=" + 'zfwsfy' + "&time=" + new Date().getMilliseconds();
					self.location = url;
				} else {
					var url = basePath + '/common/sjb/getajdjDocumentsHtml?'
							+ 'ajdjid=' + v_ajdjid
							+ '&spypxzcfwsfyid=' + v_spypxzcfwsfyid
							+ '&type=' + 'zfwsfy';
					parent.sy.modalDialog({
						title: '检查结果',
						area: ['100%', '100%'],
						content: url,
						btn: ['打印', '关闭'],
						btn1: function () {
							var strID = url;
							print(strID);
						}
					});
				}
			}
		function print(strID) {
			LODOP = getLodop();
			LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_按网址打印");
			LODOP.ADD_PRINT_URL(30, 20, 746, "95%", strID);
			LODOP.SET_PRINT_STYLEA(0, "HOrient", 3);
			LODOP.SET_PRINT_STYLEA(0, "VOrient", 3);
			LODOP.SET_SHOW_MODE("MESSAGE_GETING_URL", ""); //该语句隐藏进度条或修改提示信息
			LODOP.SET_SHOW_MODE("MESSAGE_PARSING_URL", "");//该语句隐藏进度条或修改提示信息
			LODOP.PREVIEW();
		}
		//另存为模板
		function saveAsMoban(){
			var obj = new Object();
			var v_ajdjid=$("#ajdjid").val();
			var v_zfwsdmz=$("#zfwsdmz").val();
			var v_spypxzcfwsfyid=$("#spypxzcfwsfyid").val();
			if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
				alert('案件登记id为空，不能另存为模板');
				return false;
			}
			var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
			//创建模态窗口
			parent.sy.modalDialog({
				title:'另存模板',
				area : ['100%', '100%']
				,content :url
				,offset:'0px'
				,btn:['保存为文书模板','关闭']
				,btn1: function(index, layero){
					parent.window[layero.find('iframe')[0]['name']].submitForm();
				}
			});

		}

		//提取模板

		function tqMoban(){
			var obj = new Object();
			var v_zfwsdmz=$("#zfwsdmz").val();
			var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="+v_zfwsdmz+"&zfwsdmmc=<%=v_fjcsdmmc%>&time="+new Date().getMilliseconds()));
			//创建模态窗口
			parent.sy.modalDialog({
				title:'模板提取',
				area : ['100%', '100%']
				,content :url
				,offset:'0px'
				,btn:['关闭']
			},function (dialogID){
				var v_retStr = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if (v_retStr!=null && v_retStr.type==='ok'){
					var myrow = v_retStr.data;
					parent.$.messager.progress({
						text : '数据加载中....'
					});
					var v_zfwsmbid = myrow.zfwsmbid;
					$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
								zfwsmbid : v_zfwsmbid
							},
							function(result) {
								if (result.code == '0') {
									var retdata = result.data;
									GloballoadData(retdata);
								} else {
									parent.$.messager.alert('提示','查询模板信息失败：'+result.msg,'error');
								}
								parent.$.messager.progress('close');
							}, 'json');
				}
			});
		}

		// 关闭并刷新父窗口
		function closeAndRefreshWindow(){
			var s = new Object();
			s.type = "ok";
			sy.setWinRet(s);
			parent.layer.close(parent.layer.getFrameIndex(window.name));
		}
	</script>
	<style type="text/css">
		.b1 {
			white-space-collapsing: preserve;
		}

		.b2 {
			margin: 1.0in 1.25in 1.0in 1.25in;
		}

		.s1 {
			font-weight: bold;
			color: black;
		}

		.s2 {
			color: black;
		}

		.s3 {
			font-family: 仿宋_GB2312;
			color: black;
		}

		.s4 {
			text-decoration: underline;
		}

		.p1 {
			text-align: center;
			hyphenate: auto;
			font-family: 黑体;
			font-size: 16pt;
		}

		.p2 {
			text-align: center;
			hyphenate: auto;
			font-family: Times New Roman;
			font-size: 22pt;
		}

		.p3 {
			margin-top: 0.108333334in;
			text-align: end;
			hyphenate: auto;
			font-family: 仿宋;
			font-size: 10.5pt;
		}

		.p4 {
			margin-top: 0.108333334in;
			text-align: start;
			hyphenate: auto;
			font-family: 仿宋_GB2312;
			font-size: 10.5pt;
		}

		.p5 {
			text-align: justify;
			hyphenate: auto;
			font-family: Times New Roman;
			font-size: 10.5pt;
		}
	</style>



	<title>食品药品行政处罚文书</title>
	<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto">
	<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
		<input id="zybid" name="zybid" type="hidden" value="<%=v_zybid%>"/>
		<input id="spypxzcfwsfyid" name="spypxzcfwsfyid" type="hidden"
			   value="${mybean.spypxzcfwsfyid}" />
		<p class="p2">
				<span class="s1">（
				<input id="fytitle" name="fytitle" style="width: 260px;"
					   value="${mybean.fytitle}" />

				 ）副页</span>
		</p>
		<p class="p3">
			<span class="s2">
			第<input id="fydjy" name="fydjy" style="width: 50px;" value="${mybean.fydjy}" />页，
			共 <input id="fygjy" name="fygjy" style="width: 50px;" value="${mybean.fygjy}" />页
		    </span>
		</p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<textarea class="easyui-validatebox bbtextarea" id="fycontent" name="fycontent"
					  style="width: 770px;height: 300px;" >${mybean.fycontent}</textarea>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />

		<table>
			<tr align="right" style="height: 60px;">
				<td  align="right">
					<% if (v_canbaocun==null ||"".equals(v_canbaocun) || "1".equals(v_canbaocun)) {%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="mysave()"
					   data-options="iconCls:'icon-save'">保存</a>
					<%} %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<a href="javascript:void(0);" id="printBtn" class="easyui-linkbutton" onclick="myprint();"
					   data-options="iconCls:'icon-print'">打印</a>

					<% if (v_canbaocun==null ||"".equals(v_canbaocun) || "1".equals(v_canbaocun)) {%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<a href="javascript:void(0);" id="lcwmbBtn" class="easyui-linkbutton" onclick="saveAsMoban();"
					   data-options="iconCls:'ext-icon-book_add'">另存为模板</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<a href="javascript:void(0);" id="lcwBtn" class="easyui-linkbutton" onclick="tqMoban();"
					   data-options="iconCls:'ext-icon-book_go'">从模板提取</a>
					<%} %>

					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeAndRefreshWindow();"
					   data-options="iconCls:'icon-back'">关闭</a>
				</td>
			</tr>
		</table>
	</form>
	</body>
</html>
