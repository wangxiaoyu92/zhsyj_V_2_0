<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfqzzxsqs33DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 执法文书编号
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	// 附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	// 是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	// 行政处罚强制执行申请书
	Zfwsxzcfqzzxsqs33DTO localZxsqs33DTO = new Zfwsxzcfqzzxsqs33DTO();
    if (request.getAttribute("mybean") != null) {
    	localZxsqs33DTO = (Zfwsxzcfqzzxsqs33DTO) request.getAttribute("mybean");
    }	
	
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{font-family:仿宋_GB2312;color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-align:end;hyphenate:auto;font-family:仿宋;font-size:10pt;}
.p4{text-indent:0.072916664in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-indent:0.21875in;margin-left:0.14305556in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-indent:0.29166666in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{text-indent:0.36458334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p9{text-indent:0.29166666in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p10{margin-top:0.034722224in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p11{margin-right:0.072916664in;text-align:end;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p12{margin-right:0.29166666in;text-align:end;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p13{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p14{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p15{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p16{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
</style>

<title>行政处罚强制执行申请书</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);
var mygrid;
$(function() {
	var v_xzcfqzzxsqsid = $("#xzcfqzzxsqsid").val();
	if (v_xzcfqzzxsqsid==null || v_xzcfqzzxsqsid=="" || v_xzcfqzzxsqsid.length== 0){
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
		var url= basePath+'/pub/wsgldy/saveZfwsxzcfqzzxsqs';

	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条
		
		$('#myform').form('submit',{
			url: url,
			onSubmit: function(){ 
				// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
				var isValid = $(this).form('validate'); 
				if(!isValid){
					// 如果表单是无效的则隐藏进度条
					parent.$.messager.progress('close');	 
				}					
				return isValid;
	        },
	        success: function(result){
	        	parent.$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
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
    // id
    var v_ajdjid = $("#ajdjid").val();
    
	var url="<%=basePath%>pub/wsgldy/zfwsxzcfqzzxsqsPrintIndex?ajdjid="
			+v_ajdjid+"&time="+new Date().getMilliseconds();
   
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
    var v_xzcfqzzxsqsid = $("#xzcfqzzxsqsid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    
    if (v_xzcfqzzxsqsid==null || v_xzcfqzzxsqsid=="" || v_xzcfqzzxsqsid.length== 0){
    	alert('请先保存，保存成功后，才能另存为模板');
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
		<input id="xzcfqzzxsqsid" name="xzcfqzzxsqsid" type="hidden" value="${mybean.xzcfqzzxsqsid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />		     
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">行政处罚强制执行申请书</span></p>
		<div align="right">
			<p class="p3"><span class="s2">                               
			<input type="text" id="qzsqwsbh" name="qzsqwsbh" class="easyui-validatebox" data-options="required:true" 
			style="width: 260px;text-align: right;"
			<%if(localZxsqs33DTO.getQzsqwsbh()!=null && !"".equals(localZxsqs33DTO.getQzsqwsbh())){%> 
			value="${mybean.qzsqwsbh}"<%}else{%>value="（××）食药监×罚强申〔年份〕×号"<%}%>/>
			</span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">申请人：<input type="text" id="qzsqsqr" name="qzsqsqr" 
			class="zfwsInputtextReadonly" readonly="readonly"
			style="width: 720px;text-align:left;" value="${mybean.qzsqsqr}"/></span>
		</p>
		<p class="p4">
			<span class="s2">地址：<input type="text" id="qzsqsqrdz" name="qzsqsqrdz" style="width: 320px;
			text-align: left;" value="${mybean.qzsqsqrdz}"/>
			联系人：<input type="text" id="qzsqsqrlxr" name="qzsqsqrlxr" style="width: 140px;
			text-align: left;" value="${mybean.qzsqsqrlxr}"/>
			联系方式：<input type="text" id="qzsqsqrlxfs" name="qzsqsqrlxfs" style="width: 150px;
			text-align: left;" value="${mybean.qzsqsqrlxfs}"/>
			</span>
		</p>
		<p class="p4">
			<span class="s2">法定代表人：<input type="text" id="qzsqsqrfddbr" name="qzsqsqrfddbr" style="width: 260px;
			text-align: left;" value="${mybean.qzsqsqrfddbr}"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			职务：<input type="text" id="qzsqsqrfddbrzw" name="qzsqsqrfddbrzw" style="width: 200px;
			text-align: left;" value="${mybean.qzsqsqrfddbrzw}"/>
			</span>
		</p>
		<p class="p4">
			<span class="s2">委托代理人：<input type="text" id="qzsqwtdlr" name="qzsqwtdlr" style="width: 260px;
			text-align: left;" value="${mybean.qzsqwtdlr}"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			职务：<input type="text" id="qzsqwtdlrzw" name="qzsqwtdlrzw" style="width: 200px;
			text-align: left;" value="${mybean.qzsqwtdlrzw}"/>
			</span>
		</p>
		<p class="p4">
			<span class="s2">被申请人：<input type="text" id="qzsqbsqr" name="qzsqbsqr" 
			class="zfwsInputtextReadonly" readonly="readonly"
			style="width: 710px;text-align: left;" value="${mybean.qzsqbsqr}"/></span>
		</p>
		<p class="p4">
			<span class="s2">法定代表人（负责人）：<input type="text" id="qzsqbsqrfddbr" name="qzsqbsqrfddbr" 
			class="zfwsInputtextReadonly" readonly="readonly"
			style="width: 200px;text-align: left;" value="${mybean.qzsqbsqrfddbr}"/>
			职务：<input type="text" id="qzsqbsqrzw" name="qzsqbsqrzw" 
			class="zfwsInputtextReadonly" readonly="readonly"
			style="width: 150px;text-align: left;" value="${mybean.qzsqbsqrzw}"/>
			联系电话：<input type="text" id="qzsqbsqrlxdh" name="qzsqbsqrlxdh"
			class="zfwsInputtextReadonly" readonly="readonly" 
			style="width: 150px;text-align: left;" value="${mybean.qzsqbsqrlxdh}"/>
			</span>
		</p>
		<p class="p4">
			<span class="s2">${mybean.tcdq}人民法院：</span>
		</p>
		<p class="p5">
			<span class="s2">申请人<input type="text" id="qzsqsqr" name="qzsqsqr"
			class="zfwsInputtextReadonly" readonly="readonly" 
			style="width: 300px;text-align: left;" value="${mybean.qzsqsqr}"/>
			于<input type="text" id="xzcfjdrq" name="xzcfjdrq"
			class="zfwsInputtextReadonly" readonly="readonly" 
			style="width: 100px;text-align: left;" value="${mybean.xzcfjdrq}"/>
			对被申请人${mybean.qzsqbsqr}
			作出<input type="text" id="cfjdwsbh" name="cfjdwsbh"
			class="zfwsInputtextReadonly" readonly="readonly" 
			style="width: 280px;text-align: left;" value="${mybean.cfjdwsbh}"/>行政处罚决定，
			并已于
			<input type="text" id="xzcfgzrq" name="xzcfgzrq"
			class="zfwsInputtextReadonly" readonly="readonly" 
			style="width: 100px;text-align: left;" value="${mybean.xzcfgzrq}"/>依法送达被申请人。</span>
		</p>
		<p class="p6">
			<span class="s2">被申请人在法定期限内未履行该决定。申请人依据《中华人民共和国行政强制法》规定，
			于<input type="text"	class="zfwsInputtextReadonly" readonly="readonly" 
			style="width: 100px;text-align: left;" value="${mybean.xzcfgzrq}"/>
			催告当事人履行行政处罚决定，被申请人逾期仍未履行。</span>
		</p>
		<p class="p6">
			<span class="s2">根据《中华人民共和国行政处罚法》第五十一条第三项的规定，特申请贵院对下列行政处罚决定予以强制执行： </span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="qzsqqzzxcf1" name="qzsqqzzxcf1" 
		style="width: 800px;height: 200px;" 
    		data-options="required:true">${mybean.qzsqqzzxcf1}</textarea>
		<p class="p9"><span class="s2"> </span></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<div align="right">
			<p class="p11">
				<span class="s2"> 行政机关负责人：
				<input type="text" style="width: 150px; text-align: left;" name="qzsqxzjgfzr" id="qzsqxzjgfzr" 
				data-options="required:true" value="${mybean.qzsqxzjgfzr}">（签字）　</span>
			</p>
			<p class="p12">
				<span class="s2">（公    章）</span>
			</p>
			<p class="p13">
				<span class="s2">&times;年&times;月&times;日
				<input name="qzsqgzrq" id="qzsqgzrq"  class="Wdate" 
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;" value="${mybean.qzsqgzrq}" >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</span>
			</p>
		</div>
		<p class="p14"></p>
		<p class="p14"></p>
		<p class="p15">
			<span class="s2">注：正文3号仿宋体字，存档（1）。</span>
		</p>
		<p class="p16"></p>
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
