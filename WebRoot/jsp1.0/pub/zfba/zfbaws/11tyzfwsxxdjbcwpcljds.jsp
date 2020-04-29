<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxxdjbcwpcljds11DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwsxxdjbcwpcljds11DTO dto = new Zfwsxxdjbcwpcljds11DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsxxdjbcwpcljds11DTO) request.getAttribute("mybean");
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
	text-align:end;
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
	font-family: 仿宋_GB2312;
	font-size: 10pt;
	text-align:right;
}

.p4 {
	margin-top: 0.21666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p5 {
	text-indent: 2;
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
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p11 {
	text-align: end;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10pt;
}
</style>
<title>先行登记保存物品处理决定书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);
	
	$(function(){
		if($("#xxcljdsid").val()==""){
			$("#printBtn").linkbutton('disable');
			$("#lcwmbBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		} 
	});

	//保存
	function mysave(){
			var url= basePath+'pub/wsgldy/saveZfwsxxdjbcwpcljds11';
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
				 		$("#xxcljdsid").val(result.xxcljdsid);
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
	
	function myprint(){
	    var v_id=$("#ajdjid").val();
	    var v_xxcljdsid = $("#xxcljdsid").val();
	    var url="<%=basePath%>pub/wsgldy/ZfwsxxdjbcwpcljdsIndexPrint";
	    var dialog = parent.sy.modalDialog({
	    	title : '打印',
			param : {
				xxcljdsid : v_xxcljdsid,
				ajdjid : v_id,
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
	    var v_xxcljdsid=$("#xxcljdsid").val();
	    
	    if (v_xxcljdsid==null || v_xxcljdsid=="" || v_xxcljdsid.length== 0){
	    	alert('请先保存，保存成功后，才能另存为模板');
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
		<input id="xxcljdsid" name="xxcljdsid" type="hidden"
			value="${mybean.xxcljdsid}" />
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">先行登记保存物品处理决定书</span>
			</p>
			<p class="p3">
				<span class="s2"><input id="xxclwsbh" name="xxclwsbh" style="width: 200px;"
					value="${mybean.xxclwsbh}" /></span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
			<p class="p4">
				<span class="s3"><input id="xxcldsr" name="xxcldsr" style="width: 200px;"
					value="${mybean.xxcldsr}" />：</span>
			</p>
			<p class="p5">
				<span class="s3">依据《中华人民共和国行政处罚法》第三十七条第二款的规定，本机关对
				 &times;年&times;月&times;日 <input name="xxcltzsnyr" id="xxcltzsnyr" 
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" class="Wdate"
				style="width: 175px;" value="${mybean.xxcltzsnyr}"/>
				<input id="xxcltzswsbh" name="xxcltzswsbh" style="width: 200px;"
					value="${mybean.xxcltzswsbh}" />
				《先行登记保存物品通知书》中《先行登记保存物品清单》载明的物品，作出以下处理决定：<br/>
				<textarea id="xxclwbnr" name="xxclwbnr" style="width: 730px;height: 100px;">${mybean.xxclwbnr}</textarea>
				</span>
			</p>
			<p class="p6"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p8">
				<span class="s3">附件：
				<input id="xxclfjxx" name="xxclfjxx" style="width: 580px;"
					value="${mybean.xxclfjxx}" />
				</span>
			</p>
			<p class="p9"></p>
			<p class="p6">
				<span class="s3"> </span>
			</p>
			</br></br>
			<div align="right">
				<p class="p10">
					<span class="s3"> （公 章）</span>
				</p>
				<p class="p10">
					<span class="s3"> &times;年&times;月&times;日 :<input
					name="xxclgzrq" id="xxclgzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 175px;" value="${mybean.xxclgzrq}"/></span>
					<span class="s4"></span>
				</p>
				<br>
			<br>
			<br>
			<p class="p7">
			  <span class="s2">当事人：<input name="xxcldsrqz" id="xxcldsrqz" value="${mybean.xxcldsrqz}"/>
			  （签字或盖章）&times; 年&times;月&times;日<input name="xxcldsrqzrq" id="xxcldsrqzrq" 
			  	onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" class="Wdate"
					style="width: 175px;"  value="${mybean.xxcldsrqzrq}"/></span>
			</p>
			<p class="p7">
			  <span class="s2">执法人员:<input name="xxclzfry1" id="xxclzfry1" value="${mybean.xxclzfry1}"/></span>
			  <span class="s2">执法证号<input name="xxclzfzh1" id="xxclzfzh1" value="${mybean.xxclzfzh1}"/></span>
			</p>
			<p class="p7"> 
			  <span class="s2" style="margin-left: 52px;"><input name="xxclzfry2" id="xxclzfry2" value="${mybean.xxclzfry2}"/></span>
			  <span class="s2">执法证号<input name="xxclzfzh2" id="xxclzfzh2" value="${mybean.xxclzfzh2}"/></span>
			</p>
			<p class="p7">
			  <span class="s2" style="margin-left: 240px;">
			  &times; 年&times;月&times;日:<input name="xxclzfryqzrq" id="xxclzfryqzrq" 
			  	onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" class="Wdate"
					style="width: 175px;" value="${mybean.xxclzfryqzrq}"  /></span>
			   
			</p>
			</div>
			<p class="p6"></p> 
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p11">
				<span class="s3">注：正文3号仿宋体字，存档（1）。</span>
			</p>
			<p class="p12"></p>
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
</html>
