<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.askj.zfba.dto.Zfwsdshz38DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwsdshz38DTO dto = new Zfwsdshz38DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsdshz38DTO) request.getAttribute("mybean");
	}
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
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
.s2{font-family:Times New Roman;font-weight:bold;color:black;}
.s3{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:仿宋;font-size:22pt;}
.p3{text-indent:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-indent:-1.6041666in;margin-left:1.6770834in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.fr{text-align:right;}
#fz{width:360px;float:left;}
#fy{width:360px;float:right;}
</style>
<title>送达回执</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s); 
var mygrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
	
	$(function(){
		var v_sdhzid = $("#sdhzid").val();
		if (v_sdhzid==null || v_sdhzid=="" || v_sdhzid.length== 0){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		}
	});
	
	$(function(){
		var v_slbz = <%=SysmanageUtil.getAa10toJsonArray("SDHZSDFS")%>;	
		
		$('#sdhzsdfs').combobox({
	    	data :v_slbz,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });		
	});
	
	
	function chageword(){
		$("#t1").html($("#xztzwsbh").val());
		$("#t2").html($("#xztzwsbh").val());
	}				

	//保存
	function mysave() {
		var url = basePath + 'pub/wsgldy/saveZfwsdshz38';
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
		var v_zfwslydjid = $("#ajdjid").val();

		var url = "<%=basePath%>pub/wsgldy/Zfwsdshz38IndexPrint?ajdjid="+v_zfwslydjid+"&time="+new Date().getMilliseconds();
		
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
	    var v_sdhzid=$("#sdhzid").val();
	    
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    }
	    
	    if (v_sdhzid==null || v_sdhzid=="" || v_sdhzid.length== 0){
	    	alert('请先保存，保存成功后，才能另存为模板');
	    	return false;
	    }
	    
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid+"&zfwsdmz="
			+v_zfwsdmz+"&time="+new Date().getMilliseconds();
			
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
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>" />
		<input id="sdhzid" name="sdhzid" type="hidden"
			value="${mybean.sdhzid}" />
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s2">送达回执</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
			<p class="p3">
				<span class="s3">受送达单位（人）：<input id="sdhzssddw" name="sdhzssddw" 
				style="width:200px;"  value="${mybean.sdhzssddw}" /></span>
			</p>
			<p class="p3">
				<span class="s3">送达文书名称及文书编号：<input id="sdhzwsmcbh" name="sdhzwsmcbh" 
				style="width:500px;" value="${mybean.sdhzwsmcbh}" /></span>
			</p>
			<div id="fz">
				<p class="p3">
					<span class="s3">送达方式：<input id="sdhzsdfs" name="sdhzsdfs" 
					style="width:100px;" value="${mybean.sdhzsdfs}"/></span></p>
				<p class="p3">
					<span class="s3">送达人：<input id="sdhzsdr" name="sdhzsdr" 
					style="width:100px;" value="${mybean.sdhzsdr}" /></p>
				<p class="p3">
					<span class="s3">受送达单位（人）：<input id="sdhzssddwqz" name="sdhzssddwqz" 
						style="width:100px;" value="${mybean.sdhzssddwqz}" /></p>
			</div>
			<div id="fy">
				<p class="p3"> 
					<span class="fr">送达地点：<input id="sdhzsddd" name="sdhzsddd" 
						style="width:100px;" value="${mybean.sdhzsddd}" /></span>
				</p>
				<p class="p3"><span>送达日期：<input name="sdhzsdqzrq" id="sdhzsdqzrq"
						class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
						style="width: 150px;" value="${mybean.sdhzsdqzrq}" /></span>
				</p>
				<p class="p3">
					<span>送达日期：<input name="sdhzssddwqzrq" id="sdhzssddwqzrq"
						class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
						style="width: 150px;" value="${mybean.sdhzssddwqzrq}" /></span>
				</p>
				<p class="p5"  >
				   <span>公章</span>
				</p>
				<p class="p5" >
			    	<span>&times;年&times;月&times;日
				       <input name="sdhzgzrq" id="sdhzgzrq" class="Wdate"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
						style="width: 150px;" value="${mybean.sdhzgzrq}" /></span>
				</p>
			</div>
			<p class="p6"></p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
			<p class="p5"> 
				<span class="s3">备注：<textarea id="sdhzbz" name="sdhzbz" 
					style="width: 730px;height: 200px;">${mybean.sdhzbz}</textarea></span>
				</p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p5"></p>
				<p class="p7"></p>
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
</div>
</html>
