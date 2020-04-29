<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.askj.zfba.dto.Zfwscssbbl34DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwscssbbl34DTO dto = new Zfwscssbbl34DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwscssbbl34DTO) request.getAttribute("mybean");
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
.p2{text-align:center;hyphenate:auto;font-family:宋体;font-size:22pt;}
.p3{margin-right:0.11111111in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.8020833in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-right:-0.12361111in;text-align:justify;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
#tb{line-height:24px;}
</style>
<title>陈述申辩笔录</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var layer;
var mygrid;
$(function() {
	layui.use('layer',function(){
		layer =layui.layer;
	});
		var v_cssbblid=$("#cssbblid").val();
		if (v_cssbblid==null || v_cssbblid=="" || v_cssbblid.length== 0){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		}
	});
	//保存

	function mysave() {
		var url = basePath + 'pub/wsgldy/saveZfwscssbbl34';
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
							$("#cssbblid").val(result.cssbblid);
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
		var v_cssbblid = $("#cssbblid").val();
		var url = "<%=basePath%>pub/wsgldy/Zfwscssbbl34IndexPrint?ajdjid="
			+v_zfwslydjid+"&zfwsqtbid="+v_cssbblid+"&time="+new Date().getMilliseconds();
		//创建模态窗口
		parent.sy.modalDialog({
			title:'打印',
			area : ['100%', '100%']
			,content :url
			,offset:'0px'
			,btn:['关闭']
		});
		 
	}
	
	//保存模板
	function saveAsMoban(){
	    var obj = new Object();
	    var v_ajdjid=$("#ajdjid").val();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    var v_cssbblid=$("#cssbblid").val();
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    }
	    if (v_cssbblid==null || v_cssbblid=="" || v_cssbblid.length== 0){
	    	alert('请先保存，保存成功后，才能另存为模板');
	    	return false;
	    }
	    
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
			+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
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
		var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
			+v_zfwsdmz+"&zfwsdmmc=<%=v_fjcsdmmc%>&time="+new Date().getMilliseconds()));
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
</head>
<div style="width: 210mm; margin: 0 auto">
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>" />
		<input id="cssbblid" name="cssbblid" type="hidden"
			value="${mybean.cssbblid}" />
			<p class="p2">
			<span class="s1">陈述申辩笔录</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
			<table id="tb">
				<tr>
					<td colspan="3" style="width: 695px; ">案由：<input id="ajdjay" name="ajdjay"
				style="width:600px;" value="${mybean.ajdjay}" /></td>
				</tr>
				<tr>
					<td colspan="3">当事人：<input id="cssbdsr" name="cssbdsr"
				style="width:590px;" value="${mybean.cssbdsr}" /></td>
				</tr>
				<tr>
					<td>陈述申辩人：<input id="cssbr" name="cssbr"
				style="width:100px;" value="${mybean.cssbr}" /></td>
				<td>联系方式：<input id="cssbrlxfs" name="cssbrlxfs"
				style="width:150px;" value="${mybean.cssbrlxfs}" /></td>
				<td></td>
				</tr>
				<tr>
				<td>委托代理人：<input id="cssbwtdlr" name="cssbwtdlr"
				style="width:100px;" value="${mybean.cssbwtdlr}" /></td>
				<td>职务：<input id="cssbwtdlrzw" name="cssbwtdlrzw"
				style="width:150px;" value="${mybean.cssbwtdlrzw}" /></td>
				<td>身份证号：<input id="cssbwtdlrsfzh" name="cssbwtdlrsfzh"
				style="width:170px;" value="${mybean.cssbwtdlrsfzh}" /></td>
				</tr>
				<tr>
				<td>承办人：<input id="cssbcbr" name="cssbcbr"
				style="width:100px;" value="${mybean.cssbcbr}" /></td>
				<td>记录人：<input id="cssbjlr" name="cssbjlr"
				style="width:150px;" value="${mybean.cssbjlr}" /></td>
				<td></td>
				</tr>
				<tr>
					<td>陈述申辩地点：<input id="cssbdd" name="cssbdd"
				style="width:145px;" value="${mybean.cssbdd}" /></td>
				<td colspan="2">时&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;间：<input name="cssbsj" id="cssbsj"
					class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
					style="width: 150px;" value="${mybean.cssbsj}" />至
					<input name="cssbjzsj" id="cssbjzsj" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
					style="width: 150px;" value="${mybean.cssbjzsj}" /></td>
				</tr>
			</table>
				<p class="p5">
				<span class="s2">陈述申辩内容：
					<textarea id="cssbnr" name="cssbnr" 
						style="width: 730px;height: 200px;">${mybean.cssbnr}</textarea>
				</span>
				</p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p4"></p>
				<p class="p4"></p>
				<p class="p4"></p>
				<p class="p4"></p>
				<p class="p4">
				<span class="s2">陈述申辩人：<input id="cssbrqz" name="cssbrqz"
				style="width:120px;" value="${mybean.cssbrqz}" />（签字）  
				承办人：<input id="cssbcbrqz" name="cssbcbrqz"
				style="width:60px;" value="${mybean.cssbcbrqz}" />
				     <input id="cssbcbrqz2" name="cssbcbrqz2"
				style="width:60px;" value="${mybean.cssbcbrqz2}" />（签字）
				  记录人：<input id="cssbjlrqz" name="cssbjlrqz"
				style="width:120px;" value="${mybean.cssbjlrqz}" />（签字）</span>
				</p>
				<p class="p6">
				<span class="s2">
					&nbsp;<input name="cssbrqzrq" id="cssbrqzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 150px;" value="${mybean.cssbrqzrq}" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
					<input name="cssbcbrqzrq" id="cssbcbrqzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 150px;" value="${mybean.cssbcbrqzrq}" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     
					<input name="cssbjlrqzrq" id="cssbjlrqzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 150px;" value="${mybean.cssbjlrqzrq}" /></span>
				</p>
				<p class="p7"></p>
				<p class="p8"></p>
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
