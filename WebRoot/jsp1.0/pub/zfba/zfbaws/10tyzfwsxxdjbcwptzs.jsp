<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="java.net.URLDecoder,com.askj.zfba.dto.Zfwsxxdjbcwptzs10DTO"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwsxxdjbcwptzs10DTO dto = new Zfwsxxdjbcwptzs10DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsxxdjbcwptzs10DTO) request.getAttribute("mybean");
	}
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 执法文书代码值
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=GB2312">
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
	color: black;
	text-decoration: underline;
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
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
	text-align:end;
}

.p4 {
	margin-top: 0.21666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p5 {
	text-indent: -0.072916664in;
	margin-left: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
	line-height:24px;
}

.p6 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p7 {
	text-indent: 0.36458334in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p8 {
	text-indent: 0.4375in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p9 {
	text-indent: -5.1041665in;
	margin-left: 5.1041665in;
	margin-top: 0.108333334in;
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p10 {
	text-indent: 0.06944445in;
	margin-top: 0.108333334in;
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p11 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10pt;
}
.p12 {
	text-indent: 0.15in;
	margin-left: 0.3041665in;
	margin-top: 0.108333334in;
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}
</style>
<title>先行登记保存物品通知书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);
var mygrid;
	$(function(){
		if($("#xxdjbcwptzsid").val()==""){
			$("#printBtn").linkbutton('disable');
			$("#lcwmbBtn").linkbutton('disable');	
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		} 
	});
	
	//保存
	function mysave(){
		var url= basePath+'pub/wsgldy/saveZfwsxxdjbcwptzs';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条
		
		$('#myform').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					parent.$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	parent.$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$("#xxdjbcwptzsid").val(result.xxdjbcwptzsid);
			 		$("#saveBtn").linkbutton('disable');
			 		$("#lcwmbBtn").linkbutton('enable');
			 		$("#printBtn").linkbutton({disabled:false});
			 		alert("保存成功！");
              	} else {
              		parent.$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}
	// 打印
	function myprint(){
	    var v_id = $("#xxdjbcwptzsid").val();
	    var v_ajdjid = $("#ajdjid").val();
	    var url="<%=basePath%>pub/wsgldy/zfwsxxdjbcwptzs10PrintIndex";
	    var dialog = parent.sy.modalDialog({
	    	title : '打印',
			param : {
				xxdjbcwptzsid : v_id,
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
	
	//保存模板
	function saveAsMoban(){
	    var obj = new Object();
	    var v_ajdjid=$("#ajdjid").val();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    var v_xxdjbcwptzsid=$("#xxdjbcwptzsid").val();
	    
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
	
	//提取模板
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
				var myrow = v_retStr[0];
				parent.$.messager.progress({
					text : '数据加载中....'
				});
				var v_zfwsmbid=myrow.zfwsmbid;
				$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
					zfwsmbid : v_zfwsmbid
				},function(result) {
				if (result.code=='0') {			
					var retdata =result.data;
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
			tabname : "fwsxxdjbcwptzs10",
			colname : "xztzwfflfg",
			a : new Date().getMilliseconds()
		},
		width : 800,
		height : 600,
		url : url
	},function (dialogID){
		var obj = sy.getWinRet(dialogID); 
		sy.removeWinRet(dialogID);//不可缺少
		if (obj!=null && obj.length>0){
    		for (var k=0;k<=obj.length-1;k++){
       			var myrow=obj[k];
      			$("#xztzwfflfg").val(myrow.avalue); 
    		}
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
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>" />
		<input id="xxdjbcwptzsid" name="xxdjbcwptzsid" type="hidden"
			value="${mybean.xxdjbcwptzsid}" />
		<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
			<span class="s1">先行登记保存物品通知书</span>
		</p>
		<div align="right">
			<p class="p3">
				<span class="s2"><input id="xztzwsbh" name="xztzwsbh"
					style="width:250px;" value="${mybean.xztzwsbh}"/></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both">
		<p class="p5">
			<span class="s2"><input id="xztzdsr" name="xztzdsr"
				style="width:200px;" value="${mybean.xztzdsr}" />:
			</span>
		</p>
		<p class="p5">
		<span class="s2">你（单位）由于</span>
		<span class="s2"><input id="xztzwfxw" name="xztzwfxw" style="width:200px;" value="${mybean.xztzwfxw}" /></span>
		<span class="s2">行为，涉嫌违反了</span>
		<span class="s2"><input id="xztzwfflfg" name="xztzwfflfg" style="width:200px;" value="${mybean.xztzwfflfg}"/>
		      <input type="button" style="color:blue;" value="选择" onclick="myselectPcyzdsz();"></span>
		<span class="s2">（法律法规依据名称及条、款、项具体内容）的规定。根据《中华人民共和国行政处罚法》第三十七条第二款规定，我局决定对你(单位)的有关物品［见</span>
		<span class="s2"><input id="xztzwpqdwsbh" name="xztzwpqdwsbh" style="width:200px;" value="${mybean.xztzwpqdwsbh}" value="××）食药监×登保〔年份〕×号"/></span>
		<span class="s2">《先行登记保存物品清单》］予以先行登记保存。在此期间，不得损毁、销毁或者转移。</span>
		</p>
		<p class="p6"></p>
		<p class="p7">
			<span class="s2">保存地点：<input id="xztzbcdd" name="xztzbcdd"
				style="width:550px;" value="${mybean.xztzbcdd}" />
			</span>
		</p>
		<p class="p7">
			<span class="s2">保存条件：<input id="xztzbctj" name="xztzbctj"
				style="width:550px;" value="${mybean.xztzbctj}" /> </span>
		</p>
		<p class="p7">
			<span class="s2">保存期限：自<input id="xztzbcqxksrq" name="xztzbcqxksrq"
			    onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width:175px;" value="${mybean.xztzbcqxksrq}" />至
				<input id="xztzbcqxjsrq" name="xztzbcqxjsrq"
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width:175px;" value="${mybean.xztzbcqxjsrq}" /></span>
		</p>
		<p class="p6">
			<span class="s2"> </span>
		</p>
		<p class="p7">
			<span class="s2">附件：<input id="xztzfjxx" name="xztzfjxx"
				style="width:550px;" value="${mybean.xztzfjxx}" />
			</span>
		</p>
		<p class="p6"></p>
		<p class="p8"></p>
		<div align="right">
			<p class="p3">
				<span class="s2"> （公 章）</span>
			</p>
			<p class="p3">
				<span class="s2"> &times; 年&times;月&times;日:<input
					name="xztzgzrq" id="xztzgzrq" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 175px;" value="${mybean.xztzgzrq}" />
				</span>
			</p>
			<p class="p7">
			  <span class="s2">当事人：<input name="xztzdsrqz" id="xztzdsrqz" value="${mybean.xztzdsrqz}"/>
			  （签字或盖章）&times; 年&times;月&times;日<input name="xztzdsrqzrq" id="xztzdsrqzrq" 
			  onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 175px;"  value="${mybean.xztzdsrqzrq}"/></span>
			</p>
			<p class="p7">
			  <span class="s2">执法人员:<input name="xztzzfryqz1" id="xztzzfryqz1" value="${mybean.xztzzfryqz1}"/></span>
			  <span class="s2">执法证号<input name="xztzzfzh1" id="xztzzfzh1" value="${mybean.xztzzfzh1}"/></span>
			</p>
			<p class="p7"> 
			  <span class="s2" style="margin-left: 52px;">
			  <input name="xztzzfryqz2" id="xztzzfryqz2" value="${mybean.xztzzfryqz2}"/></span>
			  <span class="s2">执法证号<input name="xztzzfzh2" id="xztzzfzh2" value="${mybean.xztzzfzh2}"/></span>
			</p>
			<p class="p7">
			  <span class="s2" style="margin-left: 240px;">
			  &times; 年&times;月&times;日:<input name="xztzzfryqzrq" id="xztzzfryqzrq" 
			  	onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 175px;" value="${mybean.xztzzfryqzrq}"  /></span>
			   
			</p>
		</div>  
		<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
		<p class="p10">
			<span class="s2">注：正文3号仿宋体字，存档（1）。 </span>
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
</html>
