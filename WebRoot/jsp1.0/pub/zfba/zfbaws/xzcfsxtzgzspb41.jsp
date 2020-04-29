<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfsxtzgzspb41DTO" %>
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
	// 行政处罚事先（听证）告知审批表
	Zfwsxzcfsxtzgzspb41DTO dto = new Zfwsxzcfsxtzgzspb41DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwsxzcfsxtzgzspb41DTO) request.getAttribute("mybean");
    }	
    // 承办人签字
    boolean v_xzcfsxgzspb_cbrqz = SysmanageUtil.isExistsFuncByBizid("xzcfsxgzspb_cbrqz");
	String v_xzcfsxgzspb_cbrqz_readonly = "";
	String v_xzcfsxgzspb_cbrqz_disable = "";
	if (!v_xzcfsxgzspb_cbrqz){
		v_xzcfsxgzspb_cbrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_xzcfsxgzspb_cbrqz_disable = "disabled='disabled'";		
	}
	// 承办人部门负责人签字
    boolean v_xzcfsxgzspb_cbbmfzrqz = SysmanageUtil.isExistsFuncByBizid("xzcfsxgzspb_cbbmfzrqz");
	String v_xzcfsxgzspb_cbbmfzrqz_readonly = "";
	String v_xzcfsxgzspb_cbbmfzrqz_disable = "";
	if (!v_xzcfsxgzspb_cbbmfzrqz){
		v_xzcfsxgzspb_cbbmfzrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_xzcfsxgzspb_cbbmfzrqz_disable = "disabled='disabled'";		
	}
	// 法制机构负责人签字
    boolean v_xzcfsxgzspb_fzjgfzrqz = SysmanageUtil.isExistsFuncByBizid("xzcfsxgzspb_fzjgfzrqz");
	String v_xzcfsxgzspb_fzjgfzrqz_readonly = "";
	String v_xzcfsxgzspb_fzjgfzrqz_disable = "";
	if (!v_xzcfsxgzspb_fzjgfzrqz){
		v_xzcfsxgzspb_fzjgfzrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_xzcfsxgzspb_fzjgfzrqz_disable = "disabled='disabled'";		
	}
	// 审批负责人签字
    boolean v_xzcfsxgzspb_spfzrqz = SysmanageUtil.isExistsFuncByBizid("xzcfsxgzspb_spfzrqz");
	String v_xzcfsxgzspb_spfzrqz_readonly = "";
	String v_xzcfsxgzspb_spfzrqz_disable = "";
	if (!v_xzcfsxgzspb_spfzrqz){
		v_xzcfsxgzspb_spfzrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_xzcfsxgzspb_spfzrqz_disable = "disabled='disabled'";		
	}
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{font-size:10pt;color:black;}
.s3{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p2{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p33{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:12pt;}
.p5{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-indent:3.5729167in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
</style>

<title>行政处罚事先（听证）告知审批表</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s); 

$(function() {  
	var v_sxtzgzspbid = $("#sxtzgzspbid").val();
	if (v_sxtzgzspbid==null || v_sxtzgzspbid=="" || v_sxtzgzspbid.length== 0){
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
		var url= basePath+'/pub/wsgldy/saveZfwsxzcfsxtzgzspb';

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
			 		$("#sxtzgzspbid").val(result.sxtzgzspbid);			 		
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
    // id
    var v_ajdjid = $("#ajdjid").val();
    var v_sxtzgzspbid = $("#sxtzgzspbid").val();
	var url="<%=basePath%>pub/wsgldy/zfwsxzcfsxtzgzspbPrintIndex?ajdjid="
		+v_ajdjid+"&zfwsqtbid="+v_sxtzgzspbid+"&time="+new Date().getMilliseconds();
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
    var v_sxtzgzspbid = $("#sxtzgzspbid").val();
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    if (v_sxtzgzspbid==null || v_sxtzgzspbid=="" || v_sxtzgzspbid.length== 0){
    	alert('请先保存，保存成功后，才能另存为模板');
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
		var v_zfwsqtbid = myrow.zfwsqtbid;
		$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
			zfwsmbid : v_zfwsmbid,
			zfwsqtbid : v_zfwsqtbid,
			sxtzgzspbid: $("#sxtzgzspbid").val(),
			ajdjid : $("#ajdjid").val()
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
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="sxtzgzspbid" name="sxtzgzspbid" type="hidden" value="${mybean.sxtzgzspbid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />		     
		<p class="p1"><span class="s1">行政处罚事先（听证）告知审批表</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p2">
			<span class="s2">案&nbsp;&nbsp;由：<input type="text" id="sxtzgzay" name="sxtzgzay" 
			style="width: 710px;text-align: left;" value="${mybean.sxtzgzay}"/></span>
		</p>
		<p class="p3">
			<span class="s3">当事人：<input type="text" id="sxtzgzdsr" name="sxtzgzdsr" 
				style="width: 710px;text-align: left;" value="${mybean.sxtzgzdsr}"/>
			</span>
		</p>
		<p class="p3">
			<span class="s3">主要违法事实：</span>
		</p>
		<textarea id="zywfss" name="zywfss" 
			style="width: 800px;height: 100px;" >${mybean.zywfss}</textarea>
		<p class="p5">
			<span class="s3">承办人员处罚意见：    </span>
		</p>
		<textarea id="cbrycfyj" name="cbrycfyj" 
			style="width: 800px;height: 100px;" >${mybean.cbrycfyj}</textarea>
		<div align="right">
			<p class="p33">
				<span class="s3">承办人：</span>
				<span class="s3"><input type="text" id="cbrqz1" name="cbrqz1" 
					style="width: 150px;"  value="${mybean.cbrqz1}" <%=v_xzcfsxgzspb_cbrqz_readonly %>/></span>
				<span class="s3">、</span>
				<span class="s3"><input type="text" id="cbrqz2" name="cbrqz2" 
					style="width: 150px;"  value="${mybean.cbrqz2}" <%=v_xzcfsxgzspb_cbrqz_readonly %>/></span>
			</p>
			<p class="p33">
				<span class="s3">&times;年&times;月&times;日<input name="cbrqzrq" id="cbrqzrq" 
					class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 200px;" value="${mybean.cbrqzrq}" <%=v_xzcfsxgzspb_cbrqz_disable %>></span>
			</p>
		</div>	
		<p class="p3">
			<span class="s3">承办部门审查意见：</span>
		</p>
		<textarea id="cbbmscyj" name="cbbmscyj" 
			style="width: 800px;height: 100px;" >${mybean.cbbmscyj}</textarea>	
		<div align="right">
			<p class="p33">
				<span class="s3">承办部门负责人：</span>
				<span class="s3"><input type="text" id="cbbmfzrqz" name="cbbmfzrqz" 
					style="width: 150px;"  value="${mybean.cbbmfzrqz}" <%=v_xzcfsxgzspb_cbbmfzrqz_readonly %>/></span>
			</p>
			<p class="p33">
				<span class="s3">&times;年&times;月&times;日<input name="cbbmfzrqzrq" id="cbbmfzrqzrq" 
					class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 200px;" value="${mybean.cbbmfzrqzrq}" <%=v_xzcfsxgzspb_cbbmfzrqz_disable%> ></span>
			</p>
		</div>	
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span>法制机构审核意见：</span>
		</p>
		<textarea id="fzjgshyj" name="fzjgshyj" 
			style="width: 800px;height: 100px;" >${mybean.fzjgshyj}</textarea>	
		<div align="right">
			<p class="p33">
				<span class="s3">负责人：</span>
				<span class="s3"><input type="text" id="fzjgfzrqz" name="fzjgfzrqz" 
					style="width: 150px;"  value="${mybean.fzjgfzrqz}" <%=v_xzcfsxgzspb_fzjgfzrqz_readonly %>/></span>
			</p>
			<p class="p33">
				<span class="s3">&times;年&times;月&times;日<input name="fzjgfzrqzrq" id="fzjgfzrqzrq" 
					class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 200px;" value="${mybean.fzjgfzrqzrq}" <%=v_xzcfsxgzspb_fzjgfzrqz_disable %> ></span>
			</p>
		</div>	
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span>审批意见：</span>
		</p>
		<textarea id="spyj" name="spyj" 
			style="width: 800px;height: 100px;" >${mybean.spyj}</textarea>	
		<div align="right">
			<p class="p33">
				<span class="s3">负责人：</span>
				<span class="s3"><input type="text" id="spbmfzrqz" name="spbmfzrqz" 
					style="width: 150px;"  value="${mybean.spbmfzrqz}" <%=v_xzcfsxgzspb_spfzrqz_readonly %>/></span>
			</p>
			<p class="p33">
				<span class="s3">&times;年&times;月&times;日<input name="spbmfzrqzrq" id="spbmfzrqzrq" 
					class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 200px;" value="${mybean.spbmfzrqzrq}" <%=v_xzcfsxgzspb_spfzrqz_disable %>></span>
			</p>
		</div>
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
