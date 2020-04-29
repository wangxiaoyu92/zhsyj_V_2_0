<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.ZfwsxwdctzsDTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="java.net.URLDecoder"%>

<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
	ZfwsxwdctzsDTO dto = new ZfwsxwdctzsDTO();
	if (request.getAttribute("mybean") != null) {
		dto = (ZfwsxwdctzsDTO) request.getAttribute("mybean");
	}
	String v_ajdjid = StringHelper.showNull2Empty(request
			.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request
			.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
	String sjws=null;
	if (request.getAttribute("sjws") != null) {
		sjws= (String) request.getAttribute("sjws");
	}
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
.p3{text-indent:3.1930556in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-indent:0.072916664in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-indent:0.29166666in;margin-left:0.072916664in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;line-height: 2em;}
.p6{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-indent:3.8645833in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{margin-right:0.36458334in;margin-top:0.108333334in;text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p9{text-indent:0.072916664in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p10{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.p11{
	text-align:right;
}
.p12{
	text-align:right;
}
.p13{
	text-align:right;
}
</style>
<title>询问调查通知书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
    var s = new Object();   
	s.type = "";       
	sy.setWinRet(s);
var mygrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
	$(function(){
		var v_xwdctzsid=$("#xwdctzsid").val();
		if (v_xwdctzsid==null || v_xwdctzsid=="" || v_xwdctzsid.length== 0){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		} 
		if(<%=sjws%>=='2'){
		$("#lcwmbBtn").eq(0).hide();
		$("#lcwBtn").eq(0).hide();
		$("#BtnFanhui").eq(0).hide(); 
        } 
	});				


	//保存
	function mysave() {
		var url = basePath + 'pub/wsgldy/savexwdctzs';
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
							$("#xwdctzsid").val(result.xwdctzsid);
							$("#saveBtn").linkbutton('disable');
							$("#lcwmbBtn").linkbutton('enable');	
			 		  		$("#printBtn").linkbutton('enable');
							alert("保存成功！");
						} else {
							parent.$.messager.alert('提示', '保存失败：' + result.msg,
									'error');
						}
					}
				});
	}
	//打印
	  function myprint() { 
		var obj = new Object();
		var v_zfwslydjid = $("#ajdjid").val();
		var v_xwdctzsid = $("#xwdctzsid").val();
		if(<%=sjws%>=='2'){
	    var url="<%=basePath%>/common/sjb/getajdjDocumentsHtml?ajdjid="
		 	+v_zfwslydjid+"&zfwsqtbid="+v_xwdctzsid+"&type="+'4'+"&time="+new Date().getMilliseconds();
	    }else{
		var url = "<%=basePath%>pub/wsgldy/zfwsxwdctzsPrintIndex?ajdjid="+v_zfwslydjid+"&zfwsqtbid="+v_xwdctzsid+"&time="+new Date().getMilliseconds();
		}
		
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
	    var v_xwdctzsid=$("#xwdctzsid").val();
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    } 
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
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
		var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="+v_zfwsdmz+"&zfwsdmmc=<%=v_fjcsdmmc%>&time="+new Date().getMilliseconds()));
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
			var v_zfwsqtbid = myrow.zfwsqtbid;
			$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
				zfwsmbid : v_zfwsmbid,
			    zfwsqtbid : v_zfwsqtbid,
			    xwdctzsid : $("#xwdctzsid").val(),
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
		<input id="xwdctzsid" name="xwdctzsid" type="hidden"
			value="${mybean.xwdctzsid}" />
			<!-- <p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
			</p> -->
			<p class="p2">
			<span class="s1">询问调查通知书</span>
			</p>
			<p class="p3">
			<span class="s2"><input id="xwdcsbh" name="xwdcsbh" style="width:200px;" class="easyui-validatebox bbtextarea" value="${mybean.xwdcsbh}" /></span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
			<p class="p4">
			<span class="s2"><input name="xwdcdsr" id="xwdcdsr" value="${mybean.xwdcdsr}"/>：</span>
			</p>
			<p class="p5">
			<span class="s2">根据《中华人民共和国行政处罚法》第三十七条的规定，你有如实回答询问、协助调查的义务。为调查了解<input name="xwdczynr" id="xwdczynr"style="width:400px;"value="${mybean.xwdczynr}"
		/>（调查了解主要内容），请你于<input style="width:200px;" name="xwdcjzrq" value="${mybean.xwdcjzrq}"class="Wdate easyui-validatebox bbtextarea"
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;"/>到<input style="width:400px;" name="xwdcxwdz" value="${mybean.xwdcxwdz}"/>（具体地点）接受询问（调查），并携带以下资料：
				  <input id="xwdcxdzl" name="xwdcxdzl" style="width:400px;" class="easyui-validatebox bbtextarea"  value="${mybean.xwdcxdzl}" />。</span>
			</p> 
			<p class="p5">
			<span class="s2">特此通知。 </span>
			</p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<br/><br/><br/><br/>
			<p class="p11">
			<span class="s2">                                                    （公    章）</span>
			</p>
			<p class="p12">
			<span class="s2">                                                         
			&times;年&times;月&times;日:<input name="xwdcqzrq" id="xwdcqzrq" class="Wdate easyui-validatebox bbtextarea"
				 onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;" value="${mybean.xwdcqzrq}" /></span>
			</p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6">
			   <span class="s2">当事人签字：<input  name="xwdcdsrqz" id="xwdcdsrqz" value="${mybean.xwdcdsrqz}" /></span>
			   <span>&times;年&times;月&times;日 <input name="xwdcdsrqzrq" id="xwdcdsrqzrq"  class="Wdate" 
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					class="easyui-validatebox" data-options="required:false" style="width: 175px;" 
					value="${mybean.xwdcdsrqzrq}" ></span> 
			</p> 
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p13">
				<span class="s2">注：正文3号仿宋体字，存档（1）。</span>
			</p>
			<p class="p10"></p> 
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
			              data-options="iconCls:'ext-icon-book_add'">另存为模块</a>
			              
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
