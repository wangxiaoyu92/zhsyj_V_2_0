<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwscssbfhyjs35DTO" %>
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
	// 陈述申辩复核意见书
	Zfwscssbfhyjs35DTO dto = new Zfwscssbfhyjs35DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwscssbfhyjs35DTO) request.getAttribute("mybean");
    }	
    // 复核部门负责人签字
    boolean v_cssbfhyjs_fhbmfzrqz = SysmanageUtil.isExistsFuncByBizid("cssbfhyjs_fhbmfzrqz");
	String v_cssbfhyjs_fhbmfzrqz_readonly = "";
	String v_cssbfhyjs_fhbmfzrqz_disable = "";
	if (!v_cssbfhyjs_fhbmfzrqz){
		v_cssbfhyjs_fhbmfzrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_cssbfhyjs_fhbmfzrqz_disable = "disabled='disabled'";		
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
.p3{margin-top:0.06944445in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:2.9895833in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:3.4270833in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-align:end;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
</style>

<title>陈述申辩复核意见书</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var layer;
var mygrid;
$(function() {
	layui.use('layer',function(){
		layer = layui.layer;
	});
	var v_cssbfhyjsid = $("#cssbfhyjsid").val();
	if (v_cssbfhyjsid==null || v_cssbfhyjsid=="" || v_cssbfhyjsid.length== 0){
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
		var url= basePath+'/pub/wsgldy/saveZfwscssbfhyjs';

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
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
			 		$("#cssbfhyjsid").val(result.cssbfhyjsid);			 		
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
    var v_cssbfhyjsid = $("#cssbfhyjsid").val();
	var url="<%=basePath%>pub/wsgldy/zfwscssbfhyjsPrintIndex?ajdjid="
		+v_ajdjid+"&zfwsqtbid="+v_cssbfhyjsid+"&time="+new Date().getMilliseconds();
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
    var v_cssbfhyjsid = $("#cssbfhyjsid").val();
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    if (v_cssbfhyjsid==null || v_cssbfhyjsid=="" || v_cssbfhyjsid.length== 0){
    	alert('请先保存，保存成功后，才能另存为模板');
    	return false;
    }
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid
		+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
	//创建模态窗口
	parent.sy.modalDialog({
		title:"模板提取",
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
		<input id="cssbfhyjsid" name="cssbfhyjsid" type="hidden" value="${mybean.cssbfhyjsid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />		     
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">陈述申辩复核意见书</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s2">案&nbsp;&nbsp;由：<input type="text" id="ajdjay" name="ajdjay" 
			style="width: 710px;text-align: left;" value="${mybean.ajdjay}"/></span>
		</p>
		<p class="p4">
			<span class="s2">当事人：<input type="text" id="sbfhdsr" name="sbfhdsr"  
			style="width: 290px;text-align: left;" value="${mybean.sbfhdsr}"/>
			法定代表人（负责人）：<input type="text" id="sbfhfddbr" name="sbfhfddbr"  
			style="width: 280px;text-align: left;"value="${mybean.sbfhfddbr}"/>
			</span>
		</p>
		<p class="p4">
			<span class="s2">拟处罚意见：<input type="text" id="sbfhncfyj" name="sbfhncfyj" 
			style="width: 685px;text-align: left;" value="${mybean.sbfhncfyj}"/></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">陈述申辩基本情况：</span>
		</p>
		<textarea id="sbfhcssbjbqk" name="sbfhcssbjbqk" 
			style="width: 800px;height: 200px;">${mybean.sbfhcssbjbqk}</textarea>	
		<p class="p4">
			<span class="s2">    附件：陈述申辩笔录</span>
		</p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4">
			<span class="s2">复核部门意见：</span>
		</p>
		<textarea id="sbfhbmyj" name="sbfhbmyj" 
			style="width: 800px;height: 100px;">${mybean.sbfhbmyj}</textarea>	
		<div align="right">
			<p class="p7">
			 <span class="s2">负责人：<input type="text" id="sbfhfzrqz" name="sbfhfzrqz" 
			 style="width: 150px;" value="${mybean.sbfhfzrqz}" <%=v_cssbfhyjs_fhbmfzrqz_readonly%>/>（签字）</span>
			</p>
			<p class="p8">
				<span class="s2">&times;年&times;月&times;日<input name="sbfhfzrqzrq" id="sbfhfzrqzrq" 
				class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" <%=v_cssbfhyjs_fhbmfzrqz_disable%>
				style="width: 200px;" value="${mybean.sbfhfzrqzrq}" ></span>
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
