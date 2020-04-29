<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsfzjgshyjs47DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() 
		 	+ ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	
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
	// 法制机构审核意见书
	Zfwsfzjgshyjs47DTO dto = new Zfwsfzjgshyjs47DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwsfzjgshyjs47DTO) request.getAttribute("mybean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.2479167in 1.0in 1.2479167in;}
.s1{font-family:宋体;font-weight:bold;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p3{text-indent:-0.14583333in;margin-left:0.14583333in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.14583333in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.21875in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.21875in;text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.td1{width:0.95416665in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td2{width:5.029861in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td3{width:1.9159722in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td4{width:1.4006945in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td5{width:1.7131945in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td6{width:0.9423611in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td7{width:4.0875in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td8{width:5.029861in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.r1{height:0.27986112in;keep-together:always;}
.r2{height:0.28680557in;keep-together:always;}
.r3{height:0.5729167in;keep-together:always;}
.r4{height:2.5819445in;keep-together:always;}
.r5{height:0.34861112in;}
.r6{height:0.27847221in;}
.r7{height:0.10069445in;}
.r8{height:1.5791667in;keep-together:always;}
.r9{height:1.6055555in;keep-together:always;}
.r10{height:0.24166666in;keep-together:always;}
.t1{table-layout:fixed;border-collapse:collapse;border-spacing:0;}
</style>


<title>法制机构审核意见书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s); 
var mygrid;
$(function() {
		var v_fzjgshyjsid = $("#fzjgshyjsid").val();
		if (v_fzjgshyjsid == null || v_fzjgshyjsid == "" || v_fzjgshyjsid.length == 0){
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
		var url= basePath+"/pub/wsgldy/saveZfwsfzjgshyjs";

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
			 		$("#fzjgshyjsid").val(result.fzjgshyjsid);
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
    var v_fzjgshyjsid = $("#fzjgshyjsid").val();
	var url="<%=basePath%>pub/wsgldy/zfwsfzjgshyjsPrintIndex?ajdjid="
			+v_ajdjid+"&zfwsqtbid="+v_fzjgshyjsid+"&time="+new Date().getMilliseconds();
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
    var v_fzjgshyjsid = $("#fzjgshyjsid").val();
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
<body class=" b1  b2  zfwsbackgroundcolor" >
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="fzjgshyjsid" name="fzjgshyjsid" type="hidden" value="${mybean.fzjgshyjsid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />
		<p class="p1">
			<span>河南省食品药品行政处罚案件法制机构</span><span class="s1">审核意见书</span>
		</p>
		<table class="t1">
			<tbody>
				<tr class="r1">
					<td class="td1">
						<p class="p2">
							<span>案    由</span>
						</p>
					</td>
					<td class="td2" colspan="4">
						<p class="p3"><input id="shyjsay" name="shyjsay"
							style="width: 480px;" value="${mybean.shyjsay}" /></p>
					</td>
				</tr>
				<tr class="r2">
					<td class="td1">
						<p class="p2">
							<span>立 案 号</span>
						</p>
					</td>
					<td class="td2" colspan="4">
						<p class="p3"><input id="shyjslah" name="shyjslah" 
							style="width: 480px;" value="${mybean.shyjslah}" /></p>
					</td>
				</tr>
				<tr class="r2">
					<td class="td1">
						<p class="p2">
							<span>当 事 人</span>
						</p>
					</td>
					<td class="td3" colspan="2">
						<p class="p4"><input id="shyjsdsr" name="shyjsdsr" value="${mybean.shyjsdsr}" /></p>
					</td>
					<td class="td4">
						<p class="p2">
							<span>承办人</span>
						</p>
					</td>
					<td class="td5">
						<p class="p4"><input id="shyjscbr" name="shyjscbr" value="${mybean.shyjscbr}" /></p>
					</td>
				</tr>
				<tr class="r3">
					<td class="td1">
						<p class="p2">
							<span>送审机构</span>
						</p>
					</td>
					<td class="td3" colspan="2">
						<p class="p4"><input id="shyjsssjg" name="shyjsssjg" value="${mybean.shyjsssjg}" /></p>
					</td>
					<td class="td4">
						<p class="p2">
							<span>送审时间</span>
						</p>
					</td>
					<td class="td5">
						<p class="p4"><input name="shyjssssj" id="shyjssssj" class="Wdate" 
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" value="${mybean.shyjssssj}" /></p>
					</td>
				</tr>
				<tr class="r4">
					<td class="td1">
						<p class="p2"></p>
						<p class="p2"></p>
						<p class="p5">
							<span>合议意见</span>
						</p>
					</td>
					<td class="td2" colspan="4">
						<p class="p4"><textarea class="easyui-validatebox bbtextarea" 
							style="width: 480px;height: 240px;"
							id="shyjshyyj" name="shyjshyyj" >${mybean.shyjshyyj}</textarea></p>
					</td>
				</tr>
				<tr class="r5">
					<td class="td1" rowspan="5">
						<p class="p6"><span>审</span></p>
						<p class="p6"><span>核</span></p>
						<p class="p6"><span>内</span></p>
						<p class="p6"><span>容</span></p>
					</td>
					<td class="td6">
						<p class="p2">
							<span>事实</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><input id="shyjsshss" name="shyjsshss"style="width: 380px;" value="${mybean.shyjsshss}" /></p>
					</td>
				</tr>
				<tr class="r6">
					<td class="td6">
						<p class="p2">
							<span>证据</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><input id="shyjsshzj" name="shyjsshzj"style="width: 380px;" value="${mybean.shyjsshzj}" /></p>
					</td>
				</tr>
				<tr class="r7">
					<td class="td6">
						<p class="p2">
							<span>依据</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><input id="shyjsshyj" name="shyjsshyj"style="width: 380px;" value="${mybean.shyjsshyj}" /></p>
					</td>
				</tr>
				<tr class="r7">
					<td class="td6">
						<p class="p2">
							<span>程序</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><input id="shyjsshcx" name="shyjsshcx"style="width: 380px;" value="${mybean.shyjsshcx}" /></p>
					</td>
				</tr>
				<tr class="r7">
					<td class="td6">
						<p class="p2">
							<span>处理</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><input id="shyjsshcl" name="shyjsshcl"style="width: 380px;" value="${mybean.shyjsshcl}" /></p>
					</td>
				</tr>
				<tr class="r8">
					<td class="td1">
						<p class="p6"><span>法  制</span></p>
						<p class="p7"></p>
						<p class="p6"><span>机  构</span></p>
						<p class="p7"></p>
						<p class="p6"><span>意  见</span></p>
					</td>
					<td class="td8" colspan="4">
						<p class="p4"><textarea class="easyui-validatebox bbtextarea" 
						style="width: 480px;height: 150px;"
							id="shyjsfzjgyj" name="shyjsfzjgyj" >${mybean.shyjsfzjgyj}</textarea></p>
					</td>
				</tr>
				<tr class="r9">
					<td class="td1">
						<p class="p6"><span>领  导</span></p>
						<p class="p6"></p>
						<p class="p6"><span>审  批</span></p>
						<p class="p6"></p>
						<p class="p6"><span>意  见</span></p>
					</td>
					<td class="td2" colspan="4">
						<p class="p2"><textarea class="easyui-validatebox bbtextarea" 
						style="width: 480px;height: 140px;"
							id="shyjsldspyj" name="shyjsldspyj" >${mybean.shyjsldspyj}</textarea></p>
					</td>
				</tr>
				<tr class="r10">
					<td class="td1">
						<p class="p6">
							<span>备  注</span>
						</p>
					</td>
					<td class="td2" colspan="4">
						<p class="p2">
							<span>此文书一式二联，第一联交办案机构。</span>
						</p>
					</td>
				</tr>
			</tbody>
		</table>
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
