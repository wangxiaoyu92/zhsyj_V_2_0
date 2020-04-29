<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsajyss3DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() 
		 	+ ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 执法文书所在表id
	String v_zfwsqtbid = StringHelper.showNull2Empty(request.getParameter("zfwsqtbid"));
	// 执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	// 执法文书代码名称 
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	// 是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	// 执法文书表主键，用于更新填写标识
	String v_ajzfwsid = StringHelper.showNull2Empty(request.getParameter("ajzfwsid"));	
	// 执法文书案件移送书
	Zfwsajyss3DTO localZfwsajyss3DTO = new Zfwsajyss3DTO();
    if (request.getAttribute("mybean") != null) {
    	localZfwsajyss3DTO = (Zfwsajyss3DTO) request.getAttribute("mybean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{color:black;}
.s2{font-weight:bold;color:black;}
.s3{color:black;}
.p1{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p2{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p3{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p4{text-indent:3.1930556in;margin-right:0.06944445in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;margin-left:5.5in;}
.p5{text-indent:0.06944445in;margin-top:0.06944445in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:-0.072916664in;margin-left:0.072916664in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.29166666in;margin-top:0.21666667in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:0.36458334in;margin-top:0.21666667in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;margin-left:5.5in;}
.p10{text-indent:0.4375in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:3.7916667in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{margin-right:0.65625in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;margin-left:5.5in;}
.p13{text-indent:1.3125in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
</style>

<title>案件移送书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s); 
var mygrid;
$(function() {
		var v_ajysid = $("#ajysid").val();
		if (v_ajysid==null || v_ajysid=="" || v_ajysid.length== 0){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		}
});
/**
 * 保存
 */
function mysave(){
		var url= basePath+"/pub/wsgldy/saveZfwsajyss";

		// 提交内容
	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条
		
		$('#myform').form('submit',{
			url: url,
			onSubmit: function(){ 
				// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
				var isValid = $(this).form('validate'); 
				if(!isValid){
					parent.$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	parent.$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$("#ajysid").val(result.zfwszhujianid);
			 		$("#saveBtn").linkbutton('disable');
			 		$("#lcwmbBtn").linkbutton('enable');
			 		$("#printBtn").linkbutton('enable');
			 		alert("保存成功！");
              	} else {
              		alert("保存失败：" + result.msg);
                }
	        }    
		});
}
/**
 * 打印
 */	
function myprint(){
    var obj = new Object();
    // 案件登记id
    var v_ajdjid = $("#ajdjid").val();
    var v_ajysid=$("#ajysid").val();
	var url="<%=basePath%>pub/wsgldy/zfwsajyss3PrintIndex?ajdjid="
			+v_ajdjid+"&ajysid="+v_ajysid+"&time="+new Date().getMilliseconds();
   
   	//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
		});
}
/**
 * 另存为模板
 */
function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid = $("#ajdjid").val();
    var v_zfwsdmz = $("#zfwsdmz").val();
    var v_ajysid = $("#ajysid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    } 
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid
		+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
   
   	//创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		width : 650,
		height : 300,
		url : url
	});
}
/**
 * 从模板提取
 */
function tqMoban(){
    var obj = new Object();
    var v_zfwsdmz = $("#zfwsdmz").val();
    
	var url = encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
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
	   	var myrow = v_retStr[0];
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
		<input id="ajysid" name="ajysid" type="hidden" value="${mybean.ajysid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />
		<input id="ajzfwsid" name="ajzfwsid" type="hidden" value="<%=v_ajzfwsid%>" />		 
<p class="p1">
<span class="s1"></span>
</p>
<p class="p2">
<span class="s2">食品药品行政处罚文书</span>
</p>
<p class="p3">
<span class="s2">案件移送书</span>
</p>
<p class="p4">
<span class="s1">				
<input type="text" id="zfwsbh" name="zfwsbh" class="easyui-validatebox" 
data-options="required:true" style="width: 260px;text-align: right;" 
value="${mybean.zfwsbh}"/>
</span>
</p>
<hr style="height:2px;border:none;border-top:2px solid #555555;" />
<p class="p5">
<span class="s3">
<input type="text" id="ajysbmmc" name="ajysbmmc" 
			style="width: 260px;text-align: left;" class="easyui-validatebox"
			 value="${mybean.ajysbmmc}"/>：
</span>
</p>
<p class="p6">
<span class="s1">    </span>
<span class="s3"> 		
<textarea class="easyui-validatebox bbtextarea" id="ajysms" name="ajysms" 
style="width: 800px;height: 200px;">${mybean.ajysms}
</textarea>（当事人姓名或名称+涉嫌构成的违法行为的概述）
</span>

<span class="s1">一案，经调查，</span>
<span class="s3">		
<textarea class="easyui-validatebox bbtextarea" id="ajysysyy" name="ajysysyy" 
style="width: 800px;height: 200px;">${mybean.ajysysyy}
</textarea>
</span>

<span class="s1">（案件发生的时间、主要违法事实及移送原因），根据《中华人民共和国行政处罚法》第
<input type="text" id="ajysdjt" name="ajysdjt" class="easyui-validatebox"  
style="width: 60px;text-align: right;" value="${mybean.ajysdjt}"/>条的规定，现移送你单位处理。案件处理结果请函告我局。
</span>
</p>
<p class="p7"></p>
<p class="p8">
<span class="s1">附件：案情简介及有关材料
<input type="text" style="width: 30px; text-align: right;" 
			name="ajysclzs" id="ajysclzs"  value="${mybean.ajysclzs}"/>件。                                             </span>
</p>
<p class="p9"></p>
<p class="p10"></p>
<p class="p11"></p>
<p class="p11"></p>
<p class="p11"></p>
<p class="p11"></p>
<p class="p12">
<span class="s1">（公    章）</span>
</p>
<p class="p9">
<span class="s1">
<input name="ajysrq" id="ajysrq"  
	class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
	 style="width: 115px;" value="${mybean.ajysrq}" >&times;年&times;月&times;日
</span>
</p>
<p class="p11"></p>
<p class="p13"></p>
<p class="p13"></p>
<p class="p13"></p>
<p class="p13"></p>
<p class="p13"></p>
<p class="p9"></p>
<p class="p9"></p>
<p class="p14">
<span class="s1">注：存档（1）。</span>
</p>
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
	             	 data-options="iconCls:'ext-icon-book_add'">另存为模块</a>
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
</div>
</html>
