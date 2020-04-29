<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwssxfzajyss5DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwssxfzajyss5DTO dto=new Zfwssxfzajyss5DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwssxfzajyss5DTO)request.getAttribute("mybean");
    }	
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
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
.s3{font-size:10pt;color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-right:0.038194444in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-indent:0.07152778in;margin-top:0.06944445in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-indent:0.29166666in;margin-left:0.072916664in;margin-right:0.038194444in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-indent:0.29166666in;margin-left:0.072916664in;margin-right:0.038194444in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p9{text-indent:0.33333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:12pt;}
.p10{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:12pt;}
.p11{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p12{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:16pt;}
.p13{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;text-align:left;}
.p14{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
#foot{float:right;}
#btn{ float:none;}
#btn{clear:both;}
.t1{text-align:end;}
</style>
<title>涉嫌犯罪案件移送书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();    
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);    
var mygrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;

	$(function(){
		var v_sxfzysid=$("#sxfzysid").val();
		if (v_sxfzysid==null || v_sxfzysid=="" || v_sxfzysid.length== 0){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		} 
	});
						
	//保存
	function mysave() {
		var url = basePath + 'pub/wsgldy/saveZfwssxfzajyss';
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
							$("#saveBtn").linkbutton('disable');
							$("#printBtn").linkbutton({disabled:false});
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
		var v_ajdjid = $("#ajdjid").val();
		var url = "<%=basePath%>pub/wsgldy/zfwssxfzajyss5PrintIndex?ajdjid="+v_ajdjid+"&time="+new Date().getMilliseconds();
		
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
	    var v_sxfzysid =$("#sxfzysid").val();
	    
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
			$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
				zfwsmbid : v_zfwsmbid
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
	<body class="b1 b2 zfwsbackgroundcolor">
	 <form id="myform" method="post">
	 	<input id="ajdjid" name="ajdjid"  type="hidden" value="<%=v_ajdjid %>" />
	 	<input id="zfwsdmz" name="zfwsdmz"  type="hidden"  value="<%=zfwsdmz %>" />
	 	<input id="sxfzysid" name="sxfzysid" type="hidden" value="${mybean.sxfzysid}"/>
		<div id="head">	
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s2">涉嫌犯罪案件移送书</span>
			</p>
			<p class="t1">
				<span style="padding-left:500px;"><input id="wsbh" name="wsbh" style="width: 250px;"  value="${mybean.wsbh}" class="easyui-validatebox bbtextarea" 
						data-options="required:true"/></span></p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
		</div>
			<p class="p4">
				<span class="s2"><input id="sysbmmc" name="sysbmmc" style="width:100px;"  class="easyui-validatebox bbtextarea" 
						data-options="required:true"    value="${mybean.sysbmmc}"/>公安局：</span>
			</p>
				<textarea class="easyui-validatebox bbtextarea" id="sxfzxw" name="sxfzxw" style="width: 750px;height: 200px;" 
    			data-options="required:true">${mybean.sxfzxw}</textarea>
			</p> 
			<p class="p7"></p>
			<p>
				 附   件: 
				<span class="s2"><textarea class="easyui-validatebox bbtextarea" id="fujian" name="fujian" style="width:750px;height:100px;" 
    			data-options="required:true">${mybean.fujian}</textarea></span>
			</p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p9"></p>
			<p class="p10">
				<span class="s2"></span>
			</p>
			<p class="p10">
			<div id="foot">
				<span class="s2"></br></br></br></span><span class="s3">（公    章）</br></br></br></span>
			</p>
			<p class="p11">
				<span class="s2">&times;年&times;月&times;日:<input name="ysrq" id="ysrq"  class="Wdate easyui-validatebox bbtextarea"
				data-options="required:true" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  style="width: 175px;"  value="${mybean.ysrq}" ></span>
			</p>
			<p class="p12"></p>
			<p class="p12"></p>
			<p class="p12"></p>
			<p class="p11"></p>
			<p class="p11"></p>
			</div>
			<p class="p14"></p>
				<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
			<p class="p13">
				<span class="s2">注：正文3号仿宋体字。抄送&times;&times;&times;人民检察院，存档（1）。</span>
			</p>
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
			</table>
		</div>
		
	  </form>
	</body>
</html>
