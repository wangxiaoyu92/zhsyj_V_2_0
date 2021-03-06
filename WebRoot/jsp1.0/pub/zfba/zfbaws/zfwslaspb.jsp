<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwslaspb2DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
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
	Zfwslaspb2DTO localZfwslaspb2DTO = new Zfwslaspb2DTO();
	if (request.getAttribute("mybean") != null) {
		localZfwslaspb2DTO = (Zfwslaspb2DTO) request
				.getAttribute("mybean");
	}
	//案件来源
	String ajly=localZfwslaspb2DTO.getAjdjajly();
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
	if($('#laspid').val()==""){
  document.getElementById("ssss").value="本案,自      年        月        日起立案，由    ${mybean.laspcbr}   主办由    ${mybean.laspcbr}  协办。" 
	  }
     

	   ly2= $('#ajdjajly').combobox({
	    	data : v_ajdjajly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	       }); 
	       
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
	   var obj = new Object();
   	   var v_ajdjid=$("#ajdjid").val();
		var url="<%=basePath%>pub/wsgldy/zfwslaspbPrintIndex?ajdjid="+v_ajdjid+"&time="+new Date().getMilliseconds();
	   
	   	//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
		},function (dialogID){
			var v_retStr = sy.getWinRet(dialogID);
			
			sy.removeWinRet(dialogID);//不可缺少
			
			if(v_retStr.type=="ok"){ //传递回的type为ok的时候才刷新页面。   
			//window.location.reload();
		    //shuaxindata();
		}
		});
	} 
 
   function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_zfwsdmz=$("#zfwsdmz").val();
    var v_laspid=$("#laspid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    
   // if (v_laspid==null || v_laspid=="" || v_laspid.length== 0){
   // 	alert('请先保存，保存成功后，才能另存为模板');
    //	return false;
   // }
    
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
    
    //创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		width : 650,
		height : 300,
		url : url
	});
}



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
			<input id="laspid" name="laspid" type="hidden"  
				value="${mybean.laspid}" />
			<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">立案审批表</span>
			</p>
			
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p3">
				<span class="s2">案 由：<span class="s3"> <input
						id="ajdjay" name="ajdjay" style="width: 600px;"
						class="zfwsInputtextReadonly" readonly="readonly"
						value="${mybean.ajdjay}" /> </span> </span>
			</p>
			<p class="p3">
				<span class="s2">当事人：<span class="s3"> <input
						id="laspdsr" name="laspdsr" style="width: 260px;"
						class="zfwsInputtextReadonly" readonly="readonly"
						value="${mybean.laspdsr}" /> </span> 法定代表人（负责人）：<span class="s3"><input
						id="wslyfddbrxm" name="wslyfddbrxm" style="width: 260px;"
						class="zfwsInputtextReadonly" readonly="readonly"
						value="${mybean.laspdsr}" /> </span> </span>
			</p>
			<p class="p4">
				<span class="s2">地 &nbsp;&nbsp;址：<span class="s3"> <input
						id="laspdz" name="laspdz" style="width: 260px;"
						class="zfwsInputtextReadonly" readonly="readonly"
						value="${mybean.laspdz}" /> </span> 联系方式：<span class="s3"> <input
						id="lasplxfs" name="lasplxfs" style="width: 260px;"
						class="zfwsInputtextReadonly" readonly="readonly"
						value="${mybean.lasplxfs}" /> </span> </span>
			</p>
			<p class="p4">
				<span class="s2">案件来源：<span class="s3"><input
						id="ajdjajly" name="ajdjajly" style="width:100px;border: none;"
						class="zfwsInputtextReadonly" readonly="readonly"
						value="${mybean.ajdjajly}" /> </span> </span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p5">
				<span class="s3">案情摘要：（简要介绍案情，指明当事人涉嫌违反法律法规具体条款）</span>
			</p>
			<p class="p4">  
			<textarea class="easyui-validatebox bbtextarea" id="laspaqzy"
				name="laspaqzy" style="width: 800px;height: 200px;"
				data-options="required:true,validType:'length[0,500]'">${mybean.laspaqzy}</textarea>
			
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
				 <input id="laspflfg" name="laspflfg" style="width: 450px;"  value="${mybean.laspflfg}" />（法律法规名称及其条、款、项）
					的规定，申请予以立案。</span>
			</p>
			<p class="p10">
				<span class="s2"> 经办人1：<input id="laspjbr" name="laspjbr"
					style="width: 90px;" class="easyui-validatebox"
					data-options=" validType:'length[0,20]'"
					value="${mybean.laspjbr}" />（签字）</span><br>
				<span class="s2"> 经办人2：<input id="laspjbr2" name="laspjbr2"
					style="width: 90px;" class="easyui-validatebox"
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
				<span class="s2">建议本案由 <input id="laspajcbr" name="laspajcbr"
					style="width: 260px;" value="${mybean.laspzbr}" /> 承办。</span>
				<span class="s2">由 <input id="laspajcbr" name="laspajcbr"
					style="width: 260px;" value="${mybean.laspcbr}" /> 协办。</span><br>
			</p>
			<p class="p10">
				<span class="s2"> 承办部门负责人：<input id="laspcbbmfzr"
					name="laspcbbmfzr" style="width: 90px;" class="easyui-validatebox"
					data-options="validType:'length[0,20]'"
					value="${mybean.laspcbbmfzr}" />（签字） </span>
			</p>
			<p class="p10">
				<span class="s2"> &times;年 &times;月&times;日 <input
					name="laspcbbmfzrqzrq" id="laspcbbmfzrqzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.laspcbbmfzrqzrq}"> </span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p12">
				<span class="s3"> 审批意见：</span>
			</p>
			<textarea id="ssss" class="easyui-validatebox bbtextarea" id="laspspyj"
				name="laspspyj" style="width: 800px;height: 200px;"
				data-options="required:false,validType:'length[0,500]'" >${mybean.laspspyj}</textarea>
			<p class="p13">
				<span class="s2"> </span>
			</p>
			<p class="p13">
				<span class="s2"> </span>
			</p>
			<p class="p10">
				<span class="s2"> 分管负责人：<input id="laspfgfzr"
					name="laspfgfzr" style="width: 90px;" class="easyui-validatebox"
					data-options="validType:'length[0,20]'"
					value="${mybean.laspfgfzr}" />（签字）</span>
			</p>
			<p class="p10">
				<span class="s2"> &times;年&times;月&times;日 <input
					name="laspfgfzrqzrq" id="laspfgfzrqzrq" class="Wdate"
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
