<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfjdspb27DTO"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}

	//案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	//执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	//附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	//处罚决定审批表
	Zfwsxzcfjdspb27DTO dto = new Zfwsxzcfjdspb27DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsxzcfjdspb27DTO) request.getAttribute("mybean");
	}
	// 审核部门负责人意见
	boolean v_xzcfjdspb_cfspshbmfzr = SysmanageUtil.isExistsFuncByBizid("xzcfjdspb_cfspshbmfzr");
	String v_xzcfjdspb_cfspshbmfzr_readonly = "";
	String v_xzcfjdspb_cfspshbmfzr_disable = "";
	if (!v_xzcfjdspb_cfspshbmfzr){
		v_xzcfjdspb_cfspshbmfzr_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_xzcfjdspb_cfspshbmfzr_disable = "disabled='disabled'";	
	}
	// 审批意见负责人签字
	boolean v_xzcfjdspb_cfspspyjfzr = SysmanageUtil.isExistsFuncByBizid("xzcfjdspb_cfspspyjfzr");
	String v_xzcfjdspb_cfspspyjfzr_readonly = "";
	String v_xzcfjdspb_cfspspyjfzr_disable = "";
	if (!v_xzcfjdspb_cfspspyjfzr){
		v_xzcfjdspb_cfspspyjfzr_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_xzcfjdspb_cfspspyjfzr_disable = "disabled='disabled'";	
	}
	// 承办部门负责人签字
	boolean v_xzcfjdspb_cfspcbbmfzrqz = SysmanageUtil.isExistsFuncByBizid("xzcfjdspb_cfspcbbmfzrqz");
	String v_xzcfjdspb_cfspcbbmfzrqz_readonly = "";
	String v_xzcfjdspb_cfspcbbmfzrqz_disable = "";
	if (!v_xzcfjdspb_cfspcbbmfzrqz){
		v_xzcfjdspb_cfspcbbmfzrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_xzcfjdspb_cfspcbbmfzrqz_disable = "disabled='disabled'";	
	}
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "ok";       
	sy.setWinRet(s); 
	$(function() {
		var v_xzcfjdspbid=$("#xzcfjdspbid").val();
		if (v_xzcfjdspbid==null || v_xzcfjdspbid=="" || v_xzcfjdspbid.length== 0){
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
					url : basePath + '/pub/wsgldy/saveZfwsxzcfjdspb',
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
							$("#xzcfjdspbid").val(result.xzcfjdspbid);
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
    var v_xzcfjdspbid=$("#xzcfjdspbid").val();
	var url="<%=basePath%>pub/wsgldy/zfwsxzcfjdspbPrintIndex?ajdjid="+v_ajdjid+"&zfwsqtbid="+v_xzcfjdspbid+"&time="+new Date().getMilliseconds();
    //创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : '打印',
			width : 700,
			height : 650,
			url : url
		});
}

  //另存为模板
function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_zfwsdmz=$("#zfwsdmz").val();
    var v_xzcfjdspbid=$("#xzcfjdspbid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    
    if (v_xzcfjdspbid==null || v_xzcfjdspbid=="" || v_xzcfjdspbid.length== 0){
    	alert('请先保存，保存成功后，才能另存为模板');
    	return false;
    }
    
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
		+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
    
    //创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : '存为模板',
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
		title : '提取模板',
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
		var v_zfwsqtbid=myrow.zfwsqtbid;
		$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
			zfwsmbid : v_zfwsmbid,
			zfwsqtbid : v_zfwsqtbid,
			xzcfjdspbid: $("#xzcfjdspbid").val(),
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

// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();   
			s.type = "ok";       
			sy.setWinRet(s); 
			parent.$("#"+sy.getDialogId()).dialog("close");    
	}
</script>
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p2{margin-top:0.108333334in;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p3{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.33333334in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:3.5729167in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
</style>

<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto">
	<body class="b1 b2 zfwsbackgroundcolor">
		<form id="myform" method="post">
			<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
			<input id="xzcfjdspbid" name="xzcfjdspbid" type="hidden"
				value="${mybean.xzcfjdspbid}" />
			<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
			<p class="p1">
				<span class="s1">行政处罚决定审批表</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p2">
				<span class="s2">案 由： <input id="ajdjay" name="ajdjay"
					style="width: 600px;" value="${mybean.ajdjay}" /> </span>
			</p>
			<p class="p2">
				<span class="s2">当事人： <input id="cfspdsr" name="cfspdsr"
					style="width: 200px;"  value="${mybean.cfspdsr}" /> </span>
			</p>
			<p class="p2">
				<span class="s2">当事人违法的主要事实和建议作出行政处罚决定的理由、依据及内容：</span>
			</p>
			<p class="p2">
				<textarea id="cfspwfss" name="cfspwfss" style="width: 800px;height: 200px;"	
				>${mybean.cfspwfss}</textarea>
			</p>
			<p class="p2">
				<span class="s2">陈述申辩及听证情况：</span>
			</p>
			<p class="p2">
				<textarea id="cssbjtzqk" name="cssbjtzqk" style="width: 800px;height: 200px;"	
				>${mybean.cssbjtzqk}</textarea>
			</p>
			<p class="p2">
				<span class="s2">当事人陈述申辩或听证意见复核及采纳情况：</span>
			</p>
			<p class="p2">
				<textarea id="dsrcssbqk" name="dsrcssbqk" style="width: 800px;height: 200px;"	
				>${mybean.dsrcssbqk}</textarea>
			</p>
			<div align="right">
				<p class="p2">
					<span class="s2"> 承办人： </span>
					<span class="s2"><input id="cfspcbrqz" name="cfspcbrqz"
						style="width: 60px;" value="${mybean.cfspcbrqz}" />、
					 <input id="cfspcbrqz2" name="cfspcbrqz2"
						style="width: 60px;" value="${mybean.cfspcbrqz2}" /> （签字） </span>
				</p>
				<p class="p2">
					<span class="s2"> &times;年&times;月&times;日 <input
						name="cfspcbrqzrq" id="cfspcbrqzrq" class="Wdate"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 175px;" value="${mybean.cfspcbrqzrq}"> </span>
				</p>
			</div>
			<p class="p2">
				<span class="s2">承办部门审查意见：</span>
			</p>
			<textarea class="easyui-validatebox bbtextarea" id="cbbmscyj"
					name="cbbmscyj" style="width: 800px;height: 200px;"
					data-options="required:false,validType:'length[0,500]'">${mybean.cbbmscyj}
			</textarea>
			<div align="right">
				<p class="p2">
					<span class="s2">承办部门负责人： <input id="cfspcbbmfzr" name="cfspcbbmfzr" 
						<%=v_xzcfjdspb_cfspcbbmfzrqz_readonly %>
						style="width: 60px;"  value="${mybean.cfspshbmfzr}" /> （签字） </span>
				</p>
				<p class="p2">
					<span class="s2"> &times;年&times;月&times;日 <input
						name="cfspcbfzrqzrq" id="cfspcbfzrqzrq" class="Wdate"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 175px;" <%=v_xzcfjdspb_cfspcbbmfzrqz_disable %>
						value="${mybean.cfspcbfzrqzrq}"> </span>
				</p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p2">
				<span>法制机构审核意见：</span>
			</p>
			<p class="p2">
				<textarea class="easyui-validatebox bbtextarea" id="cfspshbmyj"
						name="cfspshbmyj" style="width: 800px;height: 200px;"
						data-options="required:false,validType:'length[0,500]'">${mybean.cfspshbmyj}
				</textarea>
			</p>
			<div align="right">
				<p class="p2">
					<span> 负责人： <input id="cfspshbmfzr" <%=v_xzcfjdspb_cfspshbmfzr_readonly %> name="cfspshbmfzr"
						style="width: 60px;"  value="${mybean.cfspshbmfzr}" /> （签字） </span>
				</p>
				<p class="p2">
					<span> &times;年&times;月&times;日
					<input name="cfspshbmfzrrq" <%=v_xzcfjdspb_cfspshbmfzr_disable %> id="cfspshbmfzrrq" class="Wdate"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 175px;" value="${mybean.cfspshbmfzrrq}">
					</span>
				</p>
			</div>
			<p class="p4">
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p2">
				<span class="s2">审批意见： </span>
			</p>
			<p class="p2">
				<textarea class="easyui-validatebox bbtextarea" id="cfspspyj"
					name="cfspspyj" style="width: 800px;height: 200px;"
					data-options="required:false,validType:'length[0,500]'">${mybean.cfspspyj}</textarea>
			</p>
			<div align="right">
				<p class="p2">
					<span class="s2"> 负责人
					 <input id="cfspspyjfzr" <%=v_xzcfjdspb_cfspspyjfzr_readonly %> name="cfspspyjfzr"
						style="width: 60px;" value="${mybean.cfspspyjfzr}" /> （签字） </span>
				</p>
				<p class="p2">
					<span class="s2"> &times;年&times;月&times;日
					<input name="cfspspyjfzrrq" <%=v_xzcfjdspb_cfspspyjfzr_disable %> id="cfspspyjfzrrq" class="Wdate"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 175px;" value="${mybean.cfspspyjfzrrq}">
					</span>
				</p>
			</div>
			<p class="p6"></p>
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
