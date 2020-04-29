<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxzcfsxgzs26DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder,com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwsxzcfsxgzs26DTO dto = new Zfwsxzcfsxgzs26DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsxzcfsxgzs26DTO) request.getAttribute("mybean");
	}
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
	
	Sysuser user = SysmanageUtil.getSysuser();
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>行政处罚事先告知书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{text-decoration: underline;color: black;}
.s33{text-decoration: underline;color: black;text-indent:0in;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.35in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.35in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.35in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:4.0833335in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{text-align:justify;hyphenate:auto; font-family:宋体;font-size:12pt;}
.p15{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
</style>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
window.returnValue = s;  
var mygrid;
var wfxwdc; // 违法行为等次
var v_wfxwdc = <%=SysmanageUtil.getAa10toJsonArray("WFXWDC")%>;	
	$(function(){
		wfxwdc = $('#wfxwdc').combobox({
	    	data : v_wfxwdc,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		if($("#xzcfsxgzsid").val()==""){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		} else {
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		}
	});
	
	//保存
	function mysave(){
				var url= basePath+'pub/wsgldy/saveZfwsxzcfsxgzs26';
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
					 		$("#xzcfsxgzsid").val(result.xzcfsxgzsid);
						 	$("#saveBtn").linkbutton('disable');
							$("#lcwmbBtn").linkbutton('enable');	
			 		  		$("#printBtn").linkbutton('enable');
					 		alert("保存成功！");
		              	} else {
		              		parent.$.messager.alert('提示','保存失败：'+result.msg,'error');
		                }
			        }    
				});
	}

	function myprint(){
		    var obj = new Object();
		    var v_zfwslydjid=$("#ajdjid").val();
		    var v_xzcfsxgzsid = $("#xzcfsxgzsid").val();
			var url="<%=basePath%>pub/wsgldy/Zfwsxzcfsxgzs26IndexPrint?ajdjid="
				+v_zfwslydjid+"&xzcfsxgzsid="+v_xzcfsxgzsid+"&time="+new Date().getMilliseconds();
		    
		    
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
	    var v_xzcfsxgzsid=$("#xzcfsxgzsid").val();
	    
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    }
	    
	    if (v_xzcfsxgzsid==null || v_xzcfsxgzsid=="" || v_xzcfsxgzsid.length== 0){
	    	alert('请先保存，保存成功后，才能另存为模板');
	    	return false;
	    }
	    
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
			+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
	   
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
	    
		var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
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
	// 违反的法律法规
	function myselectWfflfg(){
		var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : '',
			param : {
			singleSelect : "true",
			tabname : "zfwsxzcfsxgzs26",
			colname : "sxgzswfflfg",
			a : new Date().getMilliseconds()
			},
			width : 800,
			height : 600,
			url : url
		},function (dialogID){
			var v_retStr = sy.getWinRet(dialogID);
			
			sy.removeWinRet(dialogID);//不可缺少
			
			if (v_retStr!=null && v_retStr.length>0){
	   			 for (var k=0;k<=v_retStr.length-1;k++){
	     		 var myrow=v_retStr[k];
	     		 $("#sxgzwfgd").val(myrow.avalue); //公司名称   
	    }}; 
		})
	}	
	// 依据的法律法规
	function myselectYjflfg(){
		var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : '',
			param : {
			singleSelect : "true",
			tabname : "zfwsxzcfsxgzs26",
			colname : "sxgzsyjflfg",
			a : new Date().getMilliseconds()
			},
			width : 800,
			height : 600,
			url : url
		},function (dialogID){
			var v_retStr = sy.getWinRet(dialogID);
			
			sy.removeWinRet(dialogID);//不可缺少
			
			if (v_retStr!=null && v_retStr.length>0){
	  		 for (var k=0;k<=v_retStr.length-1;k++){
	    	  var myrow=v_retStr[k];
	    	  $("#sxgzyjgd").val(myrow.avalue); //公司名称   
	    }};	
		})
	}
	
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}

</script>
</head>
<div style="width: 210mm; margin: 0 auto">
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>" />
		<input id="xzcfsxgzsid" name="xzcfsxgzsid" type="hidden"
			value="${mybean.xzcfsxgzsid}" />
		<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
		<span class="s1">行政处罚事先告知书</span>
		</p>
		<p class="p3">
		<span class="s2"><input id="sxgzwsbh" name="sxgzwsbh"
			style="width:230px;" value="${mybean.sxgzwsbh}" /></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
		<span class="s2"><input id="sxgzdsr" name="sxgzdsr"
			style="width:230px;" value="${mybean.sxgzdsr}" />：</span>
		</p>
		<p class="p5">
		<span class="s2">     经查，你（单位）</span>
		<span class="s3"><input id="sxgzwfxw" name="sxgzwfxw"
				style="width:600px;" value="${mybean.sxgzwfxw}" /></span>
		<span class="s2">的违法行为，违反了</span>
		<span class="s3"><input id="sxgzwfgd" name="sxgzwfgd"
				style="width:400px;" value="${mybean.sxgzwfgd}" />
				<input type="button" style="color:blue;" value="选择" onclick="myselectWfflfg()">
		</span>
		<span class="s2">的规定</span>
		<%if(!user.getAaa027().startsWith("4117")){ %>
		<span class="s2">。</span>
		</p>
		<p class="p5">
		<span class="s2">从你（单位）违法行为的事实、性质、情节、社会危害程度和证据看，
				你（单位）的违法行为属于</span>
		<span class="s33"><input id="wfxwdc" name="wfxwdc"
				value="${mybean.wfxwdc}" /></span>
		<span class="s2">（属于一般的认定为一般，属于严重的认定为严重，属于特别严重的认定为特别严重）。	</span>
		</p>
		<p class="p5">
		<%} else {%><span class="s2">，</span><%} %>
		<span class="s2">依据</span>
		<span class="s3"><input id="sxgzyjgd" name="sxgzyjgd"
				style="width:400px;" value="${mybean.sxgzyjgd}" />
				<input type="button" style="color:blue;" value="选择" onclick="myselectYjflfg()">
		</span>
		<span class="s2">的规定，我局拟对你（单位）进行以下行政处罚：
				<textarea id="sxgzxzcf" name="sxgzxzcf"
					style="width: 720px;height: 80px;">${mybean.sxgzxzcf}</textarea>
		</span>
		</p>
		<p class="p6">
		<span class="s2">     依据《中华人民共和国行政处罚法》第六条第一款、第三十一条规定，你（单位）可在收到本告知书之日起3日内到</span>
		<span class="s2"><input id="sxgzcxdd" name="sxgzcxdd"
				style="width:200px;" value="${mybean.sxgzcxdd}" /></span>
		<span class="s2">（地点）进行陈述、申辩。逾期视为放弃陈述、申辩。</span>
		</p>
		<p class="p7">
		<span class="s2">特此告知。</span>
		</p>
		<div align="right">
			<p>
			<span class="s2">（公    章）</span>
			</p>
			<p>
			<span class="s2">&times;年&times;月&times;日:<input
					name="sxgzgzrq" id="sxgzgzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 175px;" value="${mybean.sxgzgzrq}" /></span>
			</p>
		</div>
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
			              data-options="iconCls:'ext-icon-book_add'">另存为模块</a>
			              
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
