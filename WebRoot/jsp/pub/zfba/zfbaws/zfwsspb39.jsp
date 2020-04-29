<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsspb39DTO" %>
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
	// 执法文书编号
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	// 附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	// 是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	// 通用审批表
	Zfwsspb39DTO dto = new Zfwsspb39DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwsspb39DTO) request.getAttribute("mybean");
    }	
    String v_fjcszfwstitle = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcszfwstitle")),"UTF-8");
/*     // 承办人签字
    boolean v_tyspb_cbrqz = SysmanageUtil.isExistsFuncByBizid("tyspb_cbrqz");
	String v_tyspb_cbrqz_readonly = "";
	String v_tyspb_cbrqz_disable = "";
	if (!v_tyspb_cbrqz){
		v_tyspb_cbrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_tyspb_cbrqz_disable = "disabled='disabled'";		
	}
 */    // 审批表审批意见
    boolean v_tyspb_spyj = SysmanageUtil.isExistsFuncByBizid("tyspb_spyj");
	String v_tyspb_spyj_readonly = "";
	String v_tyspb_spyj_disable = "";
	if (!v_tyspb_spyj){
		v_tyspb_spyj_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_tyspb_spyj_disable="disabled='disabled'";		
	}
	// 审批表承办部门负责人
	boolean v_tyspb_cbbmfzr = SysmanageUtil.isExistsFuncByBizid("tyspb_cbbmfzr");
	String v_tyspb_cbbmfzr_readonly = "";
	String v_tyspb_cbbmfzr_disable = "";
	if (!v_tyspb_cbbmfzr){
		v_tyspb_cbbmfzr_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_tyspb_cbbmfzr_disable = "disabled='disabled'";	
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
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p4{margin-top:0.034722224in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-indent:0.29166666in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{margin-top:0.108333334in;text-align:right;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p8{text-indent:4.2291665in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p9{text-indent:2.9166667in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p10{text-indent:4.2291665in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p11{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p12{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
</style>

<title>审批表</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var layer;
var mygrid;
$(function() {
	layui.use('layer',function(){
		layer =layui.layer;
	});
	var v_tyspbid = $("#tyspbid").val();
	if (v_tyspbid==null || v_tyspbid=="" || v_tyspbid.length== 0){
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
		var url= basePath+'/pub/wsgldy/saveZfwsspb';

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
			 		$("#tyspbid").val(result.tyspbid);
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
    var v_tyspbid = $("#tyspbid").val();
    var v_zfwsdmz = $("#zfwsdmz").val();
	var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsspbPrintIndex?ajdjid="
			+v_ajdjid+"&tyspbid="+v_tyspbid+"&zfwsdmz="+v_zfwsdmz
			+"&fjcszfwstitle=<%=v_fjcszfwstitle%>&time="+new Date().getMilliseconds()));
	//创建模态窗口
	parent.sy.modalDialog({
		title:'打印',
		area : ['100%', '100%']
		,content :url
		,offset:'0px'
		,btn:['关闭']
	});
}
/**
 * 另存为模板
 */
function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid = $("#ajdjid").val();
    var v_zfwsdmz = $("#zfwsdmz").val();
    var v_tyspbid = $("#tyspbid").val();
    if (v_tyspbid==null || v_tyspbid=="" || v_tyspbid.length== 0){
    	alert('请先保存后再操作!');
    	return false;
    }
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid
		+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
	//创建模态窗口
	parent.sy.modalDialog({
		title:'另存模板',
		area : ['100%', '100%']
		,content :url
		,offset:'0px'
		,btn:['保存为文书模板','关闭']
		,btn1: function(index, layero){
			parent.window[layero.find('iframe')[0]['name']].submitForm();
		}
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
	parent.sy.modalDialog({
		title:'模板提取',
		area : ['100%', '100%']
		,content :url
		,offset:'0px'
		,btn:['关闭']
	},function (dialogID){
		var v_retStr = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少
		if (v_retStr!=null && v_retStr.type==='ok'){
			var myrow = v_retStr.data;
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
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
</script>

</head>
<div style="width: 210mm; margin: 0 auto">
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="tyspbid" name="tyspbid" type="hidden" value="${mybean.tyspbid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />		     
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">
		（<%=v_fjcszfwstitle%>）审批表</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s2">案件名称：<input type="text" id="spajmc" name="spajmc" 
			style="width: 710px;text-align: left;" value="${mybean.spajmc}"/></span>
		</p>
		<p class="p4">
			<span class="s2">审批事项：<input type="text" id="spsx" name="spsx" 
				style="width: 710px;text-align: left;" value="${mybean.spsx}"/>
			</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">报请审批的理由及依据：</span>
		</p>
		<textarea id="splyyj" name="splyyj" 
			style="width: 800px;height: 200px;">${mybean.splyyj}</textarea>
    	<p class="p6">
			<span class="s2">附件：<input type="text" id="spfj" name="spfj" 
				style="width: 710px;text-align: left;" value="${mybean.spfj}"/></span>
		</p>
		<p class="p7">
			<span class="s2">案件承办人：<input type="text" id="spajcbr1qz" name="spajcbr1qz" 
			style="width: 80px;" value="${mybean.spajcbr1qz}"/>、
			<input type="text" id="spajcbr2qz" name="spajcbr2qz" 
			style="width: 80px;" value="${mybean.spajcbr2qz}"/>
			（签字）</span>
		</p>
		<p class="p7">
			<span class="s2">&times;年&times;月&times;日<input name="spajcbrqzrq" id="spajcbrqzrq" 
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			style="width: 200px;" value="${mybean.spajcbrqzrq}" /></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p5">
			<span class="s2">承办部门意见：</span>
		</p>
		<textarea id="spcbbmyj" name="spcbbmyj" <%=v_tyspb_cbbmfzr_readonly %>
		style="width: 800px;height: 100px;">${mybean.spcbbmyj}</textarea>
		<p class="p7">
			<span class="s2">部门负责人：<input type="text" id="spbmfzrqz" name="spbmfzrqz" <%=v_tyspb_cbbmfzr_readonly %>
			style="width: 150px;text-align: left;" value="${mybean.spbmfzrqz}"/>（签字）</span>
		</p>
		<p class="p7">
			<span class="s2">&times;年&times;月&times;日<input name="spbmfzrqzrq" 
			id="spbmfzrqzrq" class="Wdate" <%=v_tyspb_cbbmfzr_disable %>
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			 style="width: 200px;" value="${mybean.spbmfzrqzrq}" ></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p11">
			<span class="s2">审批意见：</span>
		</p>
		<textarea id="spyj" name="spyj" <%=v_tyspb_spyj_readonly %>
			style="width: 800px;height: 100px;">${mybean.spyj}</textarea>
		<p class="p7">
			<span class="s2">分管负责人：<input type="text" id="spfgfzrqz" name="spfgfzrqz" <%=v_tyspb_spyj_readonly %>
			style="width: 150px;text-align: left;" value="${mybean.spfgfzrqz}"/>（签字）</span>
		</p>
		<p class="p7">
			<span class="s2">&times;年&times;月&times;日<input name="spfgfzrqzrq" id="spfgfzrqzrq" 
			class="Wdate" <%=v_tyspb_spyj_disable %>
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			style="width: 200px;" value="${mybean.spfgfzrqzrq}" ></span>
		</p>
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
