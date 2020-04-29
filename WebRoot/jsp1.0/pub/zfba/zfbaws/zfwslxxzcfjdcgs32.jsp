<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="java.net.URLDecoder,com.askj.zfba.dto.Zfwslxxzcfjdcgs32DTO"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwslxxzcfjdcgs32DTO dto = new Zfwslxxzcfjdcgs32DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwslxxzcfjdcgs32DTO) request.getAttribute("mybean");
	}
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=GB2312">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-indent:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-indent:0.35in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-indent:0.35in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-indent:0.35in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p9{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p10{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p11{text-indent:4.0833335in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p12{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p13{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p14{text-align:justify;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p15{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.t1{text-align:right;}
.p5{line-height:24px;}
.q1{text-align:right;}
.q2{text-align:left;}
</style>
<title>履行行政处罚决定催告书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);  
var mygrid;
	$(function(){
		var v_lxxzcfjdcgsid=$("#lxxzcfjdcgsid").val();
		if (v_lxxzcfjdcgsid==null || v_lxxzcfjdcgsid=="" || v_lxxzcfjdcgsid.length== 0){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		} 
	});				

	//保存
	function mysave() {
		var url = basePath + 'pub/wsgldy/saveZfwslxxzcfjdcgs32';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		parent.$.messager.progress({
			text : '正在提交....'
		}); // 显示进度条

		$('#myform').form(
				'submit',
				{
					url : url,
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
							$("#lxxzcfjdcgsid").val(result.lxxzcfjdcgsid);
							$("#saveBtn").linkbutton('disable');
							$("#lcwmbBtn").linkbutton('enable');	
							$("#printBtn").linkbutton({disabled:false});
							alert("保存成功！");
						} else {
							parent.$.messager.alert('提示', '保存失败：' + result.msg,
									'error');
						}
					}
				});
	}
	//提交
	function myprint() {
		var obj = new Object();
		var v_zfwslydjid = $("#ajdjid").val();
		var v_lxxzcfjdcgsid = $("#lxxzcfjdcgsid").val();
		var url = "<%=basePath%>pub/wsgldy/Zfwslxxzcfjdcgs32IndexPrint?ajdjid="
			+v_zfwslydjid+"&zfwsqtbid="+v_lxxzcfjdcgsid+"&time="+new Date().getMilliseconds();
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
		});
	}
	
	//保存模板
	function saveAsMoban(){
	    var obj = new Object();
	    var v_ajdjid=$("#ajdjid").val();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    var v_lxxzcfjdcgsid=$("#lxxzcfjdcgsid").val();
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    }
	    if (v_lxxzcfjdcgsid==null || v_lxxzcfjdcgsid=="" || v_lxxzcfjdcgsid.length== 0){
	    	alert('请先保存，保存成功后，才能另存为模板');
	    	return false;
	    }
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
			+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
	    //创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 650,
			height : 300,
			url : url
	});
	}
	
	//提取模板
	function tqMoban(){
	    var obj = new Object();
	    var v_zfwsdmz=$("#zfwsdmz").val();
		var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
			+v_zfwsdmz+"&zfwsdmmc=<%=v_fjcsdmmc%>&time="+new Date().getMilliseconds()));
	   //创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			param :obj,
			width : 900,
			height : 500,
			url : url
		},function (dialogID){
			var v_retStr = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if (v_retStr!=null && v_retStr.length>0){
		   		var myrow=v_retStr[0];
				parent.$.messager.progress({
				text : '数据加载中....'
			});
			var v_zfwsmbid=myrow.zfwsmbid;
			var v_zfwsqtbid=myrow.zfwsqtbid;
			$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
				zfwsmbid : v_zfwsmbid,
			    zfwsqtbid : v_zfwsqtbid,
			    xzcfjdsid: $("#xzcfjdsid").val(),
			    ajdjid : $("#ajdjid").val()
			}, 
			function(result) {
				if (result.code=='0') {			
					var retdata =result.data;
					//var kk=$.parseJSON(retdata);
					//$('form').form('load',retdata);
					GloballoadData(retdata);
				} else {
					parent.$.messager.alert('提示','查询模板信息失败：'+result.msg,'error');
			    }	
				parent.$.messager.progress('close');
			}, 'json');
		 }
		})
	}

// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();   
			s.type = "ok";       
			sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}
</script>
</head>
<div style="width: 210mm; margin: 0 auto">
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>" />
		<input id="lxxzcfjdcgsid" name="lxxzcfjdcgsid" type="hidden" value="${mybean.lxxzcfjdcgsid}" />
		<p class="p1">
			<span class="s1"><input type="text" id="xzjgmc" name="xzjgmc" 
				style="width: 300px;" value="${mybean.xzjgmc}"/></span>
		</p>
		<p class="p2">
			<span class="s1">履行行政处罚决定催告书</span>
		</p>
		<p class="p3">
			<span class="s2"><input id="lxcgwsbh" name="lxcgwsbh"
			style="width:220px;" class="easyui-validatebox bbtextarea"
			data-options="required:false" value="${mybean.lxcgwsbh}" /></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
			<span class="s2"><input id="lxcgdsr" name="lxcgdsr"
			style="width:220px;" class="easyui-validatebox bbtextarea"
			data-options="required:false" value="${mybean.lxcgdsr}" />： </span>
		</p>
		<p class="p5">
			<span class="s2">我局于</span>
			<span class="s2"><input id="lxcgxzcfjdsrq" name="lxcgxzcfjdsrq"
				class="Wdate easyui-validatebox bbtextarea"data-options="required:false"
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;" value="${mybean.lxcgxzcfjdsrq}" /></span>
			<span class="s2">向你（单位）送达了</span>
			<span class="s2"><input id="lxcgxzcfjdsbh" name="lxcgxzcfjdsbh"
				style="width:100px;" value="${mybean.lxcgxzcfjdsbh }" /></span>
			<span class="s2">《行政处罚决定书》，决定对你（单位）进行如下行政处罚：</span>
			<span class="s2"><input id="lxcgxzcfnr" name="lxcgxzcfnr"style="width:500px;"
				value="${mybean.lxcgxzcfnr}" /></span>
			<span class="s2">。并要求你（单位）</span>
			<span class="s2"><input id="lxcgjfkjzrq" name="lxcgjfkjzrq" class="Wdate easyui-validatebox bbtextarea"
				data-options="required:false" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;"value="${mybean.lxcgjfkjzrq}" /></span>
			<span class="s2">日前到</span>
			<span class="s2"><input id="fmkjkyh" name="fmkjkyh" style="width:100px;" value="${mybean.fmkjkyh}" /></span>
			<span class="s2">银行缴纳罚没款。由于你（单位）至今未(全部)履行处罚决定，根据《中华人民共和国行政处罚法》第五十一条第一项的规定，我局决定自</span>
			<span class="s2"><input id="lxcgjcfksrq" name="lxcgjcfksrq" class="Wdate easyui-validatebox bbtextarea"
				data-options="required:false"onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;"  value="${mybean.lxcgjcfksrq}" /></span>
			<span class="s2">起每日按罚款额3%加处罚款。请接到本催告书后10个工作日内到</span>
			<span class="s2"><input id="lxcgxjfkyh" name="lxcgxjfkyh"
				style="width:100px;" value="${mybean.lxcgxjfkyh}" /></span>
			<span class="s2">银行缴清应缴罚没款及加处罚款</span>
			<span class="s2"><input id="lxcgjcfk" name="lxcgjcfk"
				style="width:100px;" value="${mybean.lxcgjcfk}" /></span>
			<span class="s2">。逾期我局将根据《中华人民共和国行政强制法》第五十三条、五十四条的规定，依法向人民法院申请强制执行。</span>
		</p>
		<p class="p6">
			<span class="s2">如你（单位）对我局作出的履行行政处罚决定催告不服，可于</span>
			<span class="s2"><input name="lxcgcssbrq" id="lxcgcssbrq" class="Wdate easyui-validatebox bbtextarea"
			data-options="required:false" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
			style="width: 175px;" value="${mybean.lxcgcssbrq}" />日前进行陈述和申辩。</span>
		</p>
		<p class="p3"></p>
		<p class="p7"></p>
		<p class="p8"></p>
		<p class="p8">
		<span class="s2">                                            </span>
		</p>
		<p class="q1">
			<span class="s2">（公    章）</span>
		</p>
		<p class="q1">
			<span class="s2">                                                          
				&times;年&times;月&times;日:
				<input name="lxcggzrq" id="lxcggzrq"
				class="Wdate easyui-validatebox bbtextarea"
				data-options="required:false"
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;" value="${mybean.lxcggzrq}" /></span>
		</p>
		<p class="p6">
			<span class="s2">当事人：</span>
			<span class="s2"><input id="dsrqz" name="dsrqz"
				style="width:100px;" value="${mybean.dsrqz}" /></span>
			<span class="s2"><input name="dsrqzrq" id="dsrqzrq"
				class="Wdate easyui-validatebox bbtextarea"
				data-options="required:false"
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;" value="${mybean.dsrqzrq}" /></span>
		</p>
		<p class="p10"></p>
		<p class="q2">
			<span class="s2">注：正文3号仿宋体字，存档（1），必要时交 
			<input id="qzzzrmfy" name="qzzzrmfy"
				style="width:100px;" value="${mybean.qzzzrmfy}" />
			人民法院强制执行（1）。</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<div id="btn">
			<table>
				<tr align="right" style="height: 60px;">
					<td colspan=4 align="right">
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
			            <%}%>
			            
			           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		           	           	                
			           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeAndRefreshWindow();"
			           data-options="iconCls:'icon-back'">关闭</a>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</div>
</html>
