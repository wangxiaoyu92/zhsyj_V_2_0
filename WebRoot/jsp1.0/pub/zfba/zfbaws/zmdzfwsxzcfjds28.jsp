<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfjds28DTO" %>
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
	// 执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	// 附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	// 是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	// 行政处罚决定书
	Zfwsxzcfjds28DTO localZfwsxzcfjds28DTO = new Zfwsxzcfjds28DTO();
    if (request.getAttribute("mybean") != null) {
    	localZfwsxzcfjds28DTO = (Zfwsxzcfjds28DTO) request.getAttribute("mybean");
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
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;
	font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-indent:0.072916664in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-indent:0.072916664in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{text-indent:0.28055555in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p9{margin-left:0.072916664in;margin-right:0.8611111in;margin-top:0.108333334in;
	text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p10{text-indent:0.29166666in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p11{text-indent:-0.072916664in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p12{margin-right:0.29166666in;margin-top:0.108333334in;text-align:center;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p13{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p14{margin-top:0.108333334in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p15{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p16{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
</style>


<title>行政处罚决定书</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);
var mygrid;
var v_cfjdfddbrxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
var v_zzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
$(function() {
	var v_xzcfjdsid = $("#xzcfjdsid").val();
	if (v_xzcfjdsid==null || v_xzcfjdsid=="" || v_xzcfjdsid.length== 0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	}
	 v_cfjdfddbrxb = $('#cfjdfddbrxb').combobox({
	    	data : v_cfjdfddbrxb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	 v_zzzm = $('#cfjdyyzz').combobox({
	    	data : v_zzzm,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
});
/**
 * 保存
 */
function mysave(){
		var url= basePath+'/pub/wsgldy/saveZfwsxzcfjds';

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
			 		$("#xzcfjdsid").val(result.xzcfjdsid);			 		
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
function myprint(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_xzcfjdsid=$("#xzcfjdsid").val();
	var url="<%=basePath%>pub/wsgldy/zfwsxzcfjdsPrintIndex?ajdjid="+v_ajdjid+"&zfwsqtbid="+v_xzcfjdsid+"&time="+new Date().getMilliseconds();
    
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
    var v_xzcfjdsid = $("#xzcfjdsid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    
    if (v_xzcfjdsid==null || v_xzcfjdsid=="" || v_xzcfjdsid.length== 0){
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
		var v_zfwsqtbid = myrow.zfwsqtbid;
		$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
			zfwsmbid : v_zfwsmbid,
			zfwsqtbid : v_zfwsqtbid,
			xzcfjdsid: $("#xzcfjdsid").val(),
			ajdjid : $("#ajdjid").val()
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
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
		<input id="xzcfjdsid" name="xzcfjdsid" type="hidden" value="${mybean.xzcfjdsid}"/>
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">行政处罚决定书</span></p>
		<div align="right">
			<p class="p3"><span class="s2">                               
				<input type="text" id="cfjdwsbh" name="cfjdwsbh" class="easyui-validatebox" 
				data-options="required:true" style="width: 260px;text-align: right;"
				<%if(localZfwsxzcfjds28DTO.getCfjdwsbh()!=null && !"".equals(localZfwsxzcfjds28DTO.getCfjdwsbh())){%> 
				value="${mybean.cfjdwsbh}"<%}else{%>value="（××）食药监×罚〔年份〕×号"<%}%>/>
				</span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">当事人：<input type="text" id="cfjddsr" name="cfjddsr" style="width: 720px;
			text-align: left;" value="${mybean.cfjddsr}"/></span>
		</p>
		<p class="p4">
			<span class="s2">地址（住址）：
				<input type="text" id="cfjddz" name="cfjddz"  
				style="width: 305px;text-align: left;" value="${mybean.cfjddz}"/>
			</span>
			<span class="s2">邮编：
				<input type="text" id="cfjdyb" name="cfjdyb"  
				style="width: 300px;text-align: left;" value="${mybean.cfjdyb}"/>
			</span>
		</p>
		<p class="p4">
			<span class="s2">营业执照或其他资质证明：
				<input type="text" id="cfjdyyzz" name="cfjdyyzz"  
				style="width: 255px;text-align: left;" value="${mybean.cfjdyyzz}"/>
			</span>
			<span class="s2">编号：
				<input type="text" id="cfjdyyzzbh" name="cfjdyyzzbh" 
				style="width: 300px;text-align: left;" value="${mybean.cfjdyyzzbh}"/>
			</span>
		</p>
		<p class="p4">
			<span class="s2">组织机构代码（身份证）号：
				<input type="text" id="cfjdzzjgdm" name="cfjdzzjgdm" 
				style="width: 605px;text-align: left;" value="${mybean.cfjdzzjgdm}"/>
			</span>
		</p>
		<p class="p4">
			<span class="s2">法定代表人（负责人）：
				<input type="text" id="cfjdfddbr" name="cfjdfddbr"  
				style="width: 240px;text-align: left;" value="${mybean.cfjdfddbr}"/>
			</span>
			<span class="s2">性别：
				<input type="text" id="cfjdfddbrxb" name="cfjdfddbrxb"  
				style="width: 90px;text-align: left;" value="${mybean.cfjdfddbrxb}"/>
			</span>
			<span class="s2">职务：
				<input type="text" id="cfjdfddbrzw" name="cfjdfddbrzw"  
				style="width: 200px;text-align: left;" value="${mybean.cfjdfddbrzw}"/>
			</span>
		</p>
		<p class="p4">
			<span class="s2">违法事实：
				<textarea class="easyui-validatebox bbtextarea"
					data-options="required:true" id="cfjdwfss" name="cfjdwfss"
					style="width: 780px;height: 100px;">${mybean.cfjdwfss}</textarea>
			</span>
		</p>
		<p class="p5"></p>
		<p class="p6">
			<span class="s2">相关证据：
				<textarea class="easyui-validatebox bbtextarea"
					data-options="required:true" id="cfjdxgzj" name="cfjdxgzj"
					style="width: 780px;height: 100px;">${mybean.cfjdxgzj}</textarea>
			</span>
		</p>
		<p class="p7"><span class="s2">  </span></p>
		<p class="p8">
			<span class="s2">你（单位）的上述行为已违反了
			<input type="text" id="cfjdwfgd" name="cfjdwfgd"
			style="width: 565px;text-align: left;" value="${mybean.cfjdwfgd}"/>
			（法律法规名称及条、款、项）的规定：
			<input type="text" id="cfjdwfgdtk" name="cfjdwfgdtk"
			style="width: 545px;text-align: left;" value="${mybean.cfjdwfgdtk}"/>
			（法律法规具体条、款、项内容）。</span>
		</p>
		<p class="p10">
			<span class="s2">行政处罚依据和种类：</span>
		</p>
		<p class="p10">
			<span class="s2">依据
			<input type="text" id="cfjdyjgd" name="cfjdyjgd"
			style="width: 570px;text-align: left;" value="${mybean.cfjdyjgd}"/>
			（法律法规名称及条、款、项）的规定：
			<input type="text" id="cfjdyjgdtk" name="cfjdyjgdtk"
			style="width: 570px;text-align: left;" value="${mybean.cfjdyjgdtk}"/>
			（法律法规具体条、款、项内容）。</span>
		</p>
		<p class="p10">
			<span class="s2">本局决定对你（单位）给予以下行政处罚：
				<textarea class="easyui-validatebox bbtextarea"
					data-options="required:true,validType:'length[0,500]'" id="cfjdxzcf" name="cfjdxzcf"
					style="width: 780px;height: 80px;">${mybean.cfjdxzcf}</textarea>
			</span>
		</p>
		<p class="p10">
			<span class="s2">请在接到本处罚决定书之日起15日内将罚没款缴到
			<input type="text" id="cfjdjkyh" name="cfjdjkyh" 
			style="width: 100px;text-align: left;" value="${mybean.cfjdjkyh}"/>
			银行。逾期不缴纳罚没款的，根据《中华人民共和国行政处罚法》第五十一条第一项的规定，
			每日按罚款数额的3%加处罚款，并将依法申请<input type="text" name="qzzzrmfy" value="${mybean.qzzzrmfy}"/>人民法院强制执行。</span>
		</p>
		<p class="p10">
			<span class="s2">如不服本处罚决定，可在接到本处罚决定书之日起60日内向<input type="text" name="sjspypjdglj" value="${mybean.sjspypjdglj}"/>
			（上一级）食品药品监督管理局或者<input type="text" name="sjrmzf" value="${mybean.sjrmzf}"/>
			人民政府申请行政复议，也可以于3个月内依法向<input type="text" name="sjrmfy" value="${mybean.sjrmfy}"/>人民法院提起行政诉讼。</span>
		</p>
		<div align="right">
			<p class="p9">
			<span class="s2">（公    章）</span>
			</p>
			<p class="p3">
				<span class="s2">&times;年&times;月&times;日<input
						name="cfjdgzrq" id="cfjdgzrq" data-options="required:true"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 175px;" value="${mybean.cfjdgzrq}" />
					</span>
			</p>
		</div>
		<p class="p14"></p>
		<p class="p14"></p>
		<p class="p14"></p>
		<p class="p15">
			<span class="s2">注：正文3号仿宋体字，存档（1），必要时交${mybean.qzzzrmfy}人民法院强制执行（1）。</span>
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
		           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeAndRefreshWindow()"
		              data-options="iconCls:'icon-back'">关闭</a>
		       </td>
		   </tr>
		</table>
    </form>
    </body>
</div>
</html>
