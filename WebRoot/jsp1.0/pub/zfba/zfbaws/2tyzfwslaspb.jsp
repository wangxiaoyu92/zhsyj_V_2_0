<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwslaspb2DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>

<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}

	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	//案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	//执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	//附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	//第2个文书  立案审批表
	Zfwslaspb2DTO dto = new Zfwslaspb2DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwslaspb2DTO) request.getAttribute("mybean");
	}
	//案件来源
	String ajly=dto.getAjdjajly();
	boolean v_laspb_laspcbbmfzr=SysmanageUtil.isExistsFuncByBizid("laspb_laspcbbmfzr");
	String v_laspb_laspcbbmfzr_readonly="";
	String v_laspb_laspcbbmfzr_disable="";
	if (!v_laspb_laspcbbmfzr){
		v_laspb_laspcbbmfzr_readonly="readonly='readonly' class='zfwstextReadonly'";
		v_laspb_laspcbbmfzr_disable="disabled='disabled'";		
	}
	
	boolean v_laspb_laspfgfzr=SysmanageUtil.isExistsFuncByBizid("laspb_laspfgfzr");
	String v_laspb_laspfgfzr_readonly="";
	String v_laspb_laspfgfzr_disable="";
	if (!v_laspb_laspfgfzr){
		v_laspb_laspfgfzr_readonly="readonly='readonly' class='zfwstextReadonly'";
		v_laspb_laspfgfzr_disable="disabled='disabled'";	
	}
	String g_ZFWSQZMS=SysmanageUtil.g_ZFWSQZMS;//gu20170110 执法文书签字模式(0或空目前模式，1图片模式)
	String g_qzpicpath="";
	if (SysmanageUtil.getSysuser()!=null){
		g_qzpicpath=SysmanageUtil.getSysuser().getQzpicpath();//用户签字图片存放路径
	};
			
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);

var ly="<%=ajly%>";
var ly2;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;

$(function() {
	ly2= $('#ajdjajly').combobox({
		data : v_ajdjajly,      
	    valueField : 'id',   
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : 'auto' 
	}); 
    //判断选择承办人权限
    if(<%= !v_laspb_laspcbbmfzr %>){
       $("#cbr").eq(0).hide();
    }
	       
    if (ly=='null' || ly=='' || ly==null){
    	ly2.combobox('setValue','');
    }else{
    	ly2.combobox('setValue',ly);
    } 
    var v_laspid=$("#laspid").val();
	if (v_laspid==null || v_laspid=="" || v_laspid.length== 0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	} 
	//签字图片是否显示
	qzpicShowOrHide();
});

	function mysave() {
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单url: basePath+'/pub/zfwslaspb/savezfwslaspb';
		parent.$.messager.progress({
			text : '正在提交....'
		});
		$('#myform').form(
			'submit',
			{
				url : basePath + '/pub/wsgldy/savezfwslaspb',
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
					    $("#laspid").val(result.laspid);
						$("#saveBtn").linkbutton('disable');
						$("#lcwmbBtn").linkbutton('enable');	
		 		  		$("#printBtn").linkbutton('enable');
				 		alert("保存成功！");
					} else {
						 alert('保存失败：' + result.msg);
					}
				}
			});
	}
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	}; 
	//打印
	function myprint(){
   	   	var v_ajdjid=$("#ajdjid").val();
   	   	var v_laspid=$("#laspid").val();
		var url = basePath + "pub/wsgldy/zfwslaspbPrintIndex";
	   	//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			param : {
				ajdjid : v_ajdjid,
				zfwsqtbid : v_laspid,
				time : new Date().getMilliseconds()
			},
			width : 700,
			height : 650,
			url : url
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});
	} 
 
	function saveAsMoban(){
    	var v_ajdjid=$("#ajdjid").val();
    	var v_zfwsdmz=$("#zfwsdmz").val();
    	var v_laspid=$("#laspid").val();
    
    	if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    		alert('案件登记id为空，不能另存为模板');
    		return false;
    	}
    
		var url = basePath + "pub/wsgldy/zfwsmobanIndex";
	   
	   //创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			param : {
				ajdjid : v_ajdjid,
				zfwsdmz : v_zfwsdmz,
				time : new Date().getMilliseconds()
			},
			width : 650,
			height : 300,
			url : url
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});
	}

function tqMoban(){
    var obj = new Object();
    var v_zfwsdmz=$("#zfwsdmz").val();
    
	var url = basePath + "pub/wsgldy/zfwsmobantqIndex";
    
    //创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		param : {
			zfwsdmmc : "<%=v_fjcsdmmc%>",
			zfwsdmz : v_zfwsdmz,
			time : new Date().getMilliseconds()
		},
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
				laspid: $("#laspid").val(),
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
	});
}

//从单位信息表中读取
function myselectPcyzdsz(){
	var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
	var dialog = parent.sy.modalDialog({
		title : '从单位信息表中读取',
		param : {
			singleSelect : "true",
			tabname : "zfwslaspb2",
			colname : "laspflfg",
			a : new Date().getMilliseconds()
		},
		width : 800,
		height : 600,
		url : url
	},function (dialogID){
		var obj = sy.getWinRet(dialogID);
		if (obj != null && obj.length > 0){
   			for (var k = 0;k <= obj.length - 1; k++){
    	  		var myrow = obj[k];
     	 		$("#laspflfg").val(myrow.avalue); //公司名称   
    		}
    	}   
    	sy.removeWinRet(dialogID);//不可缺少
	});
}
//选择承办人
function xzcbr(){  
	var v_ajdjid=$("#ajdjid").val();
	var url="<%=basePath%>jsp/zfba/ajdjSetRy.jsp";
	var dialog = parent.sy.modalDialog({
		title : '选择承办人',
		param : {
			singleSelect : "true",
			ajdjid : v_ajdjid,
			a : new Date().getMilliseconds()
		},
		width : 600,
		height : 560,
		url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			var d=obj.a;
			for(var i=0;i<d.length;i++){
      			var na=d[i];
           		$("#laspjyzb").val(na.zfryxm);   
           	} 
            var v=obj.b;
            for(var i=0;i<v.length;i++){
	       		var na=v[i];
          		$("#laspjyxb").val(na.zfryxm);   
            } 
            sy.removeWinRet(dialogID);//不可缺少
		});
	}
           
	function dzqm(v_kind){ 
		 if (quanjuYanZhengPassword()){
     		if (v_kind=="laspfgfzr"){
		     	document.getElementById("laspfgfzrimg").style.visibility="visible";
		        $("#laspfgfzrimg").attr("src","<%=contextPath+g_qzpicpath%>"); 
		        $("#laspfgfzr").val("<%=g_qzpicpath%>"); 
     		};
     		qzpicShowOrHide();			 
		 }
	}
	
	
	function dzqmold(v_kind){ 
		 $.messager.prompt('密码', '请输入密码', function(r){
			if (r){  
				var v_userpwd=hex_md5(r);
				$.ajax({
				     url :basePath +"/pub/wsgldy/dzqz",
				     data:{"userpwd":v_userpwd},
				     type:"post",
				     dataType:"json",
				     success:function(result){
				     	if(result.code == "0"){
				     		if (v_kind=="laspfgfzr"){
						     	document.getElementById("laspfgfzrimg").style.visibility="visible";
						        $("#laspfgfzrimg").attr("src","<%=contextPath+g_qzpicpath%>"); 
						        $("#laspfgfzr").val("<%=g_qzpicpath%>"); 
				     		};
				     		qzpicShowOrHide();

				     	}else{
				        alert(result.data);
				     	}
				     } 
				});	 
			}
		}); 
	}
	
	//控制签字图片是否显示
	function qzpicShowOrHide(){
		var v_laspfgfzr=$("#laspfgfzr").val();//立案审批分管负责人
		if (shiFouWeiKong(v_laspfgfzr)){
			document.getElementById("laspfgfzrimg").style.display="none";
			document.getElementById("btnqz_laspfgfzr").style.display="block";
		}else{
			document.getElementById("laspfgfzrimg").style.display="block";
			document.getElementById("btnqz_laspfgfzr").style.display="none";
		}
	}
	
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();
		s.type = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
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
	font-size: 10.5pt;
	color: black;
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
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}
.p33 {
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p4 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 22pt;
}

.p6 {
	text-indent: 0.29166666in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 0.29166666in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-indent: 0.29166666in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p10 {
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p11 {
	margin-right: 0.038194444in;
	margin-top: 0.108333334in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p12 {
	margin-top: 0.21666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 22pt;
}

.p13 {
	margin-top: 0.108333334in;
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p14 {
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 12pt;
}

.p15 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>

</head>
<div style="width: 210mm; margin: 0 auto">
	<body class="b1 b2 zfwsbackgroundcolor">
		<form id="myform" method="post"> 
			<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
			<input id="laspid" name="laspid" type="hidden" value="${mybean.laspid}" />
			<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">立案审批表</span>
			</p>
			<p class="p33">
             <input type="text" id="laspwsbh" name="laspwsbh" style="width: 306px; text-align: right;" value="${mybean.laspwsbh}">
            </p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p3">
				<span class="s2">案 由：<span class="s3"> <input
						id="ajdjay" name="ajdjay" style="width: 600px;" 
						value="${mybean.ajdjay}" /> </span> </span>
			</p>
			<p class="p3">
				<span class="s2">当事人：<span class="s3"> <input
						id="laspdsr" name="laspdsr" style="width: 260px;" 
						value="${mybean.laspdsr}" /> </span> 法定代表人（负责人）：<span class="s3"><input
						id="laspfddbr" name="laspfddbr" style="width: 260px;" 
						value="${mybean.laspfddbr}" /> </span> </span>
			</p>
			<p class="p4">
				<span class="s2">地 &nbsp;&nbsp;址：<span class="s3"> <input
						id="laspdz" name="laspdz" style="width: 260px;" 
						value="${mybean.laspdz}" /> </span> 联系方式：<span class="s3"> <input
						id="lasplxfs" name="lasplxfs" style="width: 260px;" 
						value="${mybean.lasplxfs}" /> </span> </span>
			</p>
			<p class="p4">
				<span class="s2">案件来源：<span class="s3"><input
						id="ajdjajly" name="ajdjajly" style="width:100px;border: none;" 
						value="${mybean.ajdjajly}" /> </span> </span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p5">
				<span class="s3">案情摘要：（简要介绍案情，指明当事人涉嫌违反法律法规具体条款）</span>
			</p>
			<p class="p4">  
			<textarea class="easyui-validatebox bbtextarea" id="laspaqzy"
				name="laspaqzy" style="width: 800px;height: 200px;" >${mybean.laspaqzy}</textarea>			
			</p>
			<p class="p6"></p>
			<p class="p4">
				<span class="s2"> </span>
			</p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p7"></p>
			<p class="p8">
				<span class="s2">经初步审查，当事人的行为涉嫌违反了
				 <input id="laspflfg" name="laspflfg" style="width: 450px;"  value="${mybean.laspflfg}" />
				 <input type="button" style="color:blue;" value="选择" onclick="myselectPcyzdsz();">（法律法规名称及其条、款、项）
					的规定，申请予以立案。</span>
			</p>
			<p class="p10">
				<span class="s2">主办人：<input id="laspjbr" name="laspjbr"
					style="width: 120px;" class="easyui-validatebox"
					data-options=" validType:'length[0,20]'"
					value="${mybean.laspjbr}" />（签字）</span><br>
				<span class="s2"> 协办人：<input id="laspjbr2" name="laspjbr2"
					style="width: 120px;" class="easyui-validatebox"
					data-options=" validType:'length[0,20]'"
					value="${mybean.laspjbr2}" />（签字）</span>
			</p>
			<p class="p10">
				<span class="s2"> &times;年&times;月&times;日 <input
					name="laspjbrqzrq" id="laspjbrqzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.laspjbrqzrq}"> </span>
			</p>
			<p class="p4"></p>
			<p class="p8">
				<span class="s2">建议本案由 <input id="laspjyzb" name="laspjyzb" <%=v_laspb_laspcbbmfzr_readonly %>
					style="width: 200px;" value="${mybean.laspjyzb}" />承办。</span>
				<span class="s2">由 <input id="laspjyxb" name="laspjyxb" <%=v_laspb_laspcbbmfzr_readonly %>
					style="width: 200px;" value="${mybean.laspjyxb}" /> 协办。
					<input type="button" style="color:green;" id="cbr"
					value="选择承办人" onclick="xzcbr()"></span><br>
			</p>
			<p class="p10">
				<span class="s2"> 承办部门负责人：<input id="laspcbbmfzr"
					name="laspcbbmfzr" <%=v_laspb_laspcbbmfzr_readonly %> style="width: 90px;" class="easyui-validatebox"
					data-options="validType:'length[0,20]'"
					value="${mybean.laspcbbmfzr}" />（签字） </span>
			</p>
			<p class="p10">
				<span class="s2"> &times;年 &times;月&times;日 <input
					name="laspcbbmfzrqzrq" <%=v_laspb_laspcbbmfzr_disable %> id="laspcbbmfzrqzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.laspcbbmfzrqzrq}"> </span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p12">
				<span class="s3"> 审批意见：</span>
			</p>
			<textarea id="ssss"<%=v_laspb_laspfgfzr_readonly %> class="easyui-validatebox bbtextarea" id="laspspyj"
				name="laspspyj" style="width: 800px;height: 200px;"
				data-options="required:false" >${mybean.laspspyj}</textarea>
			<p class="p13">
				<span class="s2"> </span>
			</p>
			<p class="p13">
				<span class="s2"> </span>
			</p>
			<p class="p10">
				<span class="s2" style="line-height: 30px;"> 分管负责人：
				  <% if ("0".equals(g_ZFWSQZMS)){ %>
 				    <input id="laspfgfzr"
					name="laspfgfzr" <%=v_laspb_laspfgfzr_readonly %> style="width: 90px;" class="easyui-validatebox"
					data-options="validType:'length[0,20]'"
					value="${mybean.laspfgfzr}" />（签字） 				  
				  <%}else{%>
				    <input style="float:right;" <%=v_laspb_laspfgfzr_disable%> type="button" id="btnqz_laspfgfzr" onclick="dzqm('laspfgfzr');" value="签字"/>
					<input type="hidden" id="laspfgfzr" name="laspfgfzr" value="${mybean.laspfgfzr}">
					<img  src="<%=contextPath%>${mybean.laspfgfzr}" id="laspfgfzrimg" style="float:right;border:none; width: 45px;height: 30px;" >
				  <%}%>
                </span>				  
			</p>
			<p class="p10">
				<span class="s2"> &times;年&times;月&times;日 <input
					name="laspfgfzrqzrq" <%=v_laspb_laspfgfzr_disable %> id="laspfgfzrqzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.laspfgfzrqzrq}"> </span>
			</p>
			<p class="p13"></p>
			<p class="p14"></p>
			<p class="p15"></p>
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
</div>

</html>
