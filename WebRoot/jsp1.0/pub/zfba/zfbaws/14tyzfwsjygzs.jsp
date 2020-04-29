<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsjyjcjyjdgzs14DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 执法文书所在表id
	String v_zfwsqtbid = StringHelper.showNull2Empty(request.getParameter("zfwsqtbid"));
	// 执法文书编号
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	// 附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	// 是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	// 14 检验（检测、检疫、鉴定）告知书
	Zfwsjyjcjyjdgzs14DTO dto=new Zfwsjyjcjyjdgzs14DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwsjyjcjyjdgzs14DTO) request.getAttribute("mybean");
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
.p2{text-align:center;hyphenate:auto;font-family:宋体;font-size:22pt;}
.p3{text-indent:3.1930556in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-indent:0.14583333in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-indent:0.29166666in;margin-left:0.14583333in;margin-top:0.108333334in;
	text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-indent:0.4375in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-indent:0.33333334in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{margin-top:0.108333334in;text-align:end;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p9{margin-left:0.072916664in;margin-right:0.8611111in;margin-top:0.108333334in;
	text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p10{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p11{margin-top:0.108333334in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p12{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p13{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
</style>

<title>检验（检测、检疫、鉴定）告知书</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);
$(function() {
	var v_jygzsid = $("#jygzsid").val();
	if (v_jygzsid==null || v_jygzsid=="" || v_jygzsid.length== 0){
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
		// 判断开始时间与结束时间是否填写正确
		var startdate = $("#jygzksrq").val();
		var enddate = $("#jygzjsrq").val();
		var arr = startdate.split("-");    
		var starttime = new Date(arr[0],arr[1],arr[2]);    
		var starttimes = starttime.getTime();   
		  
		var arrs = enddate.split("-");    
		var lktime = new Date(arrs[0],arrs[1],arrs[2]);    
		var lktimes = lktime.getTime();   
		  
		if(starttimes > lktimes){  
			alert("请正确填写日期"); 
			return;   
		}   
		var url= basePath+'/pub/wsgldy/saveZfwsjygzs';

		// 提交
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
    // 案件登记id
    var v_ajdjid = $("#ajdjid").val();
	//创建模态窗口
	var url="<%=basePath%>pub/wsgldy/zfwsjygzsPrintIndex";
    var dialog = parent.sy.modalDialog({
    	title : '打印',
		param : {
			ajdjid : v_ajdjid,
			time : new Date().getMilliseconds()
		},
		width : 700,
		height : 650,
		url : url
    },function(dialogID) {
	    sy.removeWinRet(dialogID);//不可缺少
	});	
}
/**
 * 另存为模板
 */
function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid = $("#ajdjid").val();
    var v_zfwsdmz = $("#zfwsdmz").val();
    var v_jygzsid = $("#jygzsid").val();
    
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
/**
 * 从模板提取
 */
function tqMoban(){
    var v_zfwsdmz = $("#zfwsdmz").val();
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
	});
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
		<input id="jygzsid" name="jygzsid" type="hidden" value="${mybean.jygzsid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />		     
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">检验（检测、检疫、鉴定）告知书</span></p>
		<div align="right">
			<p class="p3"><span class="s2">                               
			<input type="text" id="jygzwsbh" name="jygzwsbh" 
			style="width: 260px;text-align: right;" value="${mybean.jygzwsbh}" />
			</span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2"><input type="text" id="commc" name="commc" 
				style="width: 150px;text-align: left;" value="${mybean.commc}"/>：</span>
		</p>
		<p class="p5">
			<span class="s2">我局决定对<input type="text" id="jygzjzwsbh" name="jygzjzwsbh" 
			style="width: 200px;text-align: left;" value="${mybean.jygzjzwsbh}"/>
			<input type="text" id="jygzjzwsmc" name="jygzjzwsmc" style="width: 200px;text-align: left;" 
			value="${mybean.jygzjzwsmc}"/>
			所记载的物品进行检验（检测、检疫、鉴定），检验（检测、检疫、鉴定）期限自
			<input name="jygzksrq" id="jygzksrq" class="Wdate" 
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"style="width: 175px;" value="${mybean.jygzksrq}" >
			&times;年&times;月&times;日至
			<input name="jygzjsrq" id="jygzjsrq" class="Wdate" 
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" style="width: 175px;" value="${mybean.jygzjsrq}" >
			&times;年&times;月&times;日
			止。根据《中华人民共和国行政强制法》第二十五条第三款的规定，查封、扣押期间不包括检测、检验、检疫或者技术鉴定的期间。因此，我局对
			<input type="text" id="jygzqzcsjdsmcjbh" name="jygzqzcsjdsmcjbh" style="width: 200px;" 
			value="${mybean.jygzqzcsjdsmcjbh}"/>
			（行政强制措施决定书名称及文号）确定的行政强制措施期限顺延至
			<input name="jygzqzcsqxsyrq" id="jygzqzcsqxsyrq" class="Wdate" 
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
			style="width: 175px;" value="${mybean.jygzqzcsqxsyrq}" >
			&times;年&times;月&times;日
			止。</span>
		</p> 
		<div align="right">
			<p class="p9">
				<span class="s2">（公   章）</span>
			</p>
			<p class="p3">
				<span class="s2">&times;年&times;月&times;日
					<input name="jygzgzrq" id="jygzgzrq"  class="Wdate" 
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 175px;" value="${mybean.jygzgzrq}" >
				</span>
			</p>
			<br>
			<br>
			<br>
		</div>      
			<p class="p7">
			   <span class="s2">当事人签字：<input  name="jygzdsrqz" id="jygzdsrqz" value="${mybean.jygzdsrqz}" /></span>
			   <span>&times;年&times;月&times;日 <input name="jygzdsrqzrq" id="jygzdsrqzrq"  class="Wdate" 
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 175px;"  value="${mybean.jygzdsrqzrq}" ></span> 
			   
			</p>
		<p class="p12">
			<span class="s2">注：正文3号仿宋体字，存档（1）。</span>
		</p>
		<p class="p13"></p>

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
