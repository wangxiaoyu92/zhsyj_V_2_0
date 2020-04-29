<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsjcdwjclj46DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwsjcdwjclj46DTO dto = new Zfwsjcdwjclj46DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsjcdwjclj46DTO) request.getAttribute("mybean");
	}
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String v_ajzfwsid = StringHelper.showNull2Empty(request.getParameter("ajzfwsid"));
	// 执法文书代码值
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:22pt;}
.p2{text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:18pt;}
.p3{text-align:start;hyphenate:auto;font-family:宋体;font-size:18pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:18pt;}
.p5{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:18pt;}
.p6{text-align:justify;hyphenate:auto;font-family:Calibri;font-size:10pt;}
.td1{width:7.9645834in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;}
.td2{width:0.99791664in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.td3{width:1.2138889in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.td4{width:1.3215277in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.td5{width:2.125in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td6{width:1.4305556in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-right:thin solid black;}
.td7{width:0.87569445in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.td8{width:1.3215277in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td9{width:4.43125in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td10{width:0.99791664in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td11{width:6.9666667in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td12{width:0.60694444in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td13{width:0.60625in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td14{width:0.7152778in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td15{width:0.7083333in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td16{width:0.87569445in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.r1{height:0.7291667in;keep-together:always;}
.r2{height:0.65625in;keep-together:always;}
.r3{height:1.0208334in;keep-together:always;}
.r4{height:1.8854167in;keep-together:always;}
.r5{height:0.48125in;keep-together:always;}
.r6{height:0.4645833in;keep-together:always;}
.r7{height:0.4604167in;keep-together:always;}
.t1{table-layout:fixed;border-collapse:collapse;border-spacing:0;} 
.w{width: 60px;}
</style>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);
var layer;
 $(function() {
     layui.use(['layer'], function () {
         layer=layui.layer;
     })
	var v_jcwjclid=$("#jcwjclid").val();
	if (v_jcwjclid==null || v_jcwjclid=="" || v_jcwjclid.length== 0){
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
					url : basePath + '/pub/wsgldy/savejcdwjcl46',
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
							$("#jcwjclid").val(result.jcwjclid);
							$("#saveBtn").linkbutton('disable');
							$("#lcwmbBtn").linkbutton('enable');	
			 		  		$("#printBtn").linkbutton('enable');
					 		alert("保存成功！");
						} else {
							parent.$.messager.alert('提示', '保存失败：' + result.msg,
									'error');
						}
					}
				});
	}
function myprint(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_jcwjclid = $("#jcwjclid").val(); 
	var url="<%=basePath%>pub/wsgldy/zfwsjbdjb46PrintIndex?ajdjid="
		+v_ajdjid+"&jcwjclid="+v_jcwjclid+"&time="+new Date().getMilliseconds();
		//创建模态窗口
	parent.sy.modalDialog({
		title:'打印',
        area: ['100%', '100%']
        , content: url
        ,offset:["0px"]
        , btn: [ '关闭']
    });
}
  //另存为模板
   function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_zfwsdmz=$("#zfwsdmz").val();
    var v_jcwjclid=$("#jcwjclid").val();
    if (v_jcwjclid==null || v_jcwjclid=="" || v_jcwjclid.length== 0){
    	alert('文书还没有保存为空，不能另存为模板');
    	return false;
    } 
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
		+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
   //创建模态窗口
	   parent.sy.modalDialog({
           title:'另存模板',
            area: ['100%', '100%']
           , content: url
           ,offset:["0px"]
           , btn: [ '保存为模板文书','关闭']
           , btn1: function (index, layero) {
			   parent.window[layero.find('iframe')[0]['name']].submitForm();
           }
       });
}

//提取模板

function tqMoban(){
    var obj = new Object();
    var v_zfwsdmz=$("#zfwsdmz").val();
	var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
		+v_zfwsdmz+"&zfwsdmmc=<%=v_fjcsdmmc%>&time="+new Date().getMilliseconds()));
    //创建模态窗口
	parent.sy.modalDialog({
		title:'提取模板',
         area: ['100%', '100%']
        , content: url
        , offset: ["0px"]
        , btn: ['关闭']
    },function (dialogID){
		var v_retStr = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少
		if (v_retStr!=null && v_retStr.type==='ok'){
	   		var myrow=v_retStr.data;
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
        parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
</script>
</head>
<div style="width: 210mm; margin: 0 auto;" >
<body class="b1 b2 zfwsbackgroundcolor">
     <form id="myform" method="post">  
			<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
			<input id="ajzfwsid" name="ajzfwsid" type="hidden" value="<%=v_ajzfwsid%>" />
			<input id="jcwjclid" name="jcwjclid" type="hidden" value="${mybean.jcwjclid}"/>
			<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>"/>
		<table class="t1">
		<tbody>
		<tr class="r1">
			<td class="td1" colspan="11">
				<p class="p1">
					<span class="s1">汤阴县食药监局稽查队文件处理笺</span>
				</p>
			</td>
		</tr>
		<tr class="r7">
			<td class="td2" rowspan="2">
				<p class="p2">
					<span class="s2">来文 机关</span>
				</p>
			</td>
			<td class="td3" colspan="2" rowspan="2">
				<p class="p2">
					<span class="s2">举报</span>
				</p>
			</td>
			<td class="td4" colspan="2">
				<p class="p2">
					<span class="s2">文件号</span>
				</p>
			</td>
			<td class="td5" colspan="3">
				<p class="p3">
					<span class="s2"><input id="jcwjclwjbh" name="jcwjclwjbh" value="${mybean.jcwjclwjbh}"></span>
				</p>
			</td>
			<td class="td6" colspan="2">
				<p class="p2">
					<span class="s2">顺序号</span>
				</p>
			</td>
			<td class="td7">
				<p class="p3">
					<span class="s2"><input class="w"  id="jcwjclwjsxh" name="jcwjclwjsxh" value="${mybean.jcwjclwjsxh}"></span>
				</p>
			</td>
		</tr>
		<tr class="r7">
			<td class="td8" colspan="2">
				<p class="p2">
					<span class="s2">收到日期</span>
				</p>
			</td>
			<td class="td9" colspan="6">
				<p class="p3">
					<span class="s2"><input class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
		             style="width: 200px;" id="jcwjclwjsdrq" name="jcwjclwjsdrq" value="${mybean.jcwjclwjsdrq}"></span>
				</p>
			</td>
		</tr>
		<tr class="r2">
			<td class="td10">
				<p class="p2">
					<span class="s2">标题</span>
				</p>
			</td>
			<td class="td11" colspan="10">
				<p class="p3">
					<span class="s2"><textarea id="jcwjclwjbt" name="jcwjclwjbt"
		                   style="width:660px;height:50px;">${mybean.jcwjclwjbt}</textarea></span>
				</p>
			</td>
		</tr>
		<tr class="r4">
			<td class="td10">
				<p class="p4">
					<span class="s2">领导批示</span>
				</p>
			</td>
			<td class="td11" colspan="10">
				<p class="p3">
				 <textarea id="jcwjclldps" name="jcwjclldps"
		          style="width:660px;height:150px;">${mybean.jcwjclldps}</textarea>
				</p>
			</td>
		</tr>
		<tr class="r5">
			<td class="td10">
				<p class="p2">
					<span class="s2">阅者 签名</span>
				</p>
			</td>
			<td class="td12">
				<p class="p4"><input  class="w" id="jcwjclyzqm1" name="jcwjclyzqm1" value="${mybean.jcwjclyzqm1}"></p>
			</td>
			<td class="td12">
				<p class="p4"><input class="w" id="jcwjclyzqm2" name="jcwjclyzqm2" value="${mybean.jcwjclyzqm2}"></p>
			</td>
			<td class="td13">
				<p class="p4"><input class="w" id="jcwjclyzqm3" name="jcwjclyzqm3" value="${mybean.jcwjclyzqm3}"></p>
			</td>
			<td class="td14">
				<p class="p4"><input class="w" id="jcwjclyzqm4" name="jcwjclyzqm4" value="${mybean.jcwjclyzqm4}"></p>
			</td>
			<td class="td15">
				<p class="p4"><input class="w" id="jcwjclyzqm5" name="jcwjclyzqm5" value="${mybean.jcwjclyzqm5}"></p>
			</td>
			<td class="td15">
				<p class="p4"><input class="w" id="jcwjclyzqm6" name="jcwjclyzqm6" value="${mybean.jcwjclyzqm6}"></p>
			</td>
			<td class="td15">
				<p class="p4"><input class="w" id="jcwjclyzqm7" name="jcwjclyzqm7" value="${mybean.jcwjclyzqm7}"></p>
			</td>
			<td class="td14">
				<p class="p4"><input class="w" id="jcwjclyzqm8" name="jcwjclyzqm8" value="${mybean.jcwjclyzqm8}"></p>
			</td>
			<td class="td14">
				<p class="p4"><input class="w" id="jcwjclyzqm9" name="jcwjclyzqm9" value="${mybean.jcwjclyzqm9}"></p>
			</td>
			<td class="td16">
				<p class="p4"><input class="w" id="jcwjclyzqm10" name="jcwjclyzqm10" value="${mybean.jcwjclyzqm10}"></p>
			</td>
		</tr>
		<tr class="r6">
			<td class="td10">
				<p class="p4">
					<span class="s2">月日</span>
				</p>
			</td>
			<td class="td12">
				<p class="p4"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq1" name="jcwjclyzqmrq1" value="${mybean.jcwjclyzqmrq1}"></p>
			</td>
			<td class="td12">
				<p class="p4"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq2" name="jcwjclyzqmrq2" value="${mybean.jcwjclyzqmrq2}"></p>
			</td>
			<td class="td13">
				<p class="p2"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq3" name="jcwjclyzqmrq3" value="${mybean.jcwjclyzqmrq3}"></p>
			</td>
			<td class="td14">
				<p class="p4"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq4" name="jcwjclyzqmrq4" value="${mybean.jcwjclyzqmrq4}"></p>
			</td>
			<td class="td15">
				<p class="p4"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq5" name="jcwjclyzqmrq5" value="${mybean.jcwjclyzqmrq5}"></p>
			</td>
			<td class="td15">
				<p class="p4"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq6" name="jcwjclyzqmrq6" value="${mybean.jcwjclyzqmrq6}"></p>
			</td>
			<td class="td15">
				<p class="p4"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq7" name="jcwjclyzqmrq7" value="${mybean.jcwjclyzqmrq7}"></p>
			</td>
			<td class="td14">
				<p class="p4"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq8" name="jcwjclyzqmrq8" value="${mybean.jcwjclyzqmrq8}"></p>
			</td>
			<td class="td14">
				<p class="p4"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq9" name="jcwjclyzqmrq9" value="${mybean.jcwjclyzqmrq9}"></p>
			</td>
			<td class="td16">
				<p class="p4"><input class="w" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" id="jcwjclyzqmrq10" name="jcwjclyzqmrq10" value="${mybean.jcwjclyzqmrq10}"></p>
			</td>
		</tr>
		<tr class="r2">
			<td class="td10">
				<p class="p2">
					<span class="s2">备注</span>
				</p>
			</td>
			<td class="td11" colspan="10">
				<p class="p5"><textarea id="jcwjclbz" name="jcwjclbz"
		 style="width:660px;height:50px;">${mybean.jcwjclbz }</textarea></p>
			</td>
		</tr>
		</tbody>
		</table>
		<p class="p6"></p>
		</form>
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
</body>
</div>
</html>

