<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwscaspb21DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
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
	// 撤案审批表
	Zfwscaspb21DTO localZfwscaspb21DTO = new Zfwscaspb21DTO();
    if (request.getAttribute("mybean") != null) {
    	localZfwscaspb21DTO = (Zfwscaspb21DTO) request.getAttribute("mybean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{font-family:Times New Roman;font-size:22pt;font-weight:bold;color:black;}
.s3{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:仿宋;font-size:10pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.p6{text-indent:4.375in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
</style>
<title>撤案审批表</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "ok";       
	sy.setWinRet(s);    
var mygrid;
$(function() {
	var v_caspbid = $("#caspbid").val();
	if (v_caspbid==null || v_caspbid=="" || v_caspbid.length== 0){
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
		var url= basePath+'/pub/wsgldy/saveZfwscaspb';

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
    
	var url="<%=basePath%>pub/wsgldy/zfwscaspbPrintIndex?ajdjid="
			+v_ajdjid+"&time="+new Date().getMilliseconds();
			
	//创建模态窗口
	var dialog = parent.sy.modalDialog({
			title : '打印',
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
    var v_caspbid = $("#caspbid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    
    if (v_caspbid==null || v_caspbid=="" || v_caspbid.length== 0){
    	alert('请先保存，保存成功后，才能另存为模板');
    	return false;
    }
    
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid
		+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
    
    //创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : '存为模板',
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
		title : '模板提取',
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
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="caspbid" name="caspbid" type="hidden" value="${mybean.caspbid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />		     
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">撤案审批表</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s3">案&nbsp;&nbsp;由：<input type="text" id="ajdjay" name="ajdjay" 
			class="zfwsInputtextReadonly" readonly="readonly" 
			style="width: 710px;text-align: left;" value="${mybean.ajdjay}"/></span>
		</p>
		<p class="p3">
			<span class="s3">当事人：<input type="text" id="commc" name="commc" 
			class="zfwsInputtextReadonly" readonly="readonly" 
			style="width: 295px;text-align: left;" value="${mybean.commc}"/>
                             法定代表人（负责人）：<input type="text" id="comfrhyz" name="comfrhyz" 
              class="zfwsInputtextReadonly" readonly="readonly" 
               style="width: 280px;text-align: left;"value="${mybean.comfrhyz}"/>
			</span>
		</p>
		<p class="p3">
			<span class="s3">地&nbsp;&nbsp;址：<input type="text" id="comdz" name="comdz" 
			class="zfwsInputtextReadonly" readonly="readonly"
			style="width: 300px;text-align: left;" value="${mybean.comdz}"/>
                             联系方式：<input type="text" id="comyddh" name="comyddh" 
              class="zfwsInputtextReadonly" readonly="readonly" 
              style="width: 350px;text-align: left;" value="${mybean.comyddh}"/>
			</span>
		</p>
		<p class="p3">
			<span class="s3">案件来源：<input type="text" id="ajdjajlystr" name="ajdjajlystr" 
			class="zfwsInputtextReadonly" readonly="readonly" 
			style="width: 295px;text-align: left;" value="${mybean.ajdjajlystr}"/>
                             立案时间：<input type="text" id="liansj" name="liansj" 
             class="zfwsInputtextReadonly" readonly="readonly"
             style="width: 340px;text-align: left;" value="${mybean.liansj}"/>
			</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s3">案情调查摘要：</span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="caspaqdczy" name="caspaqdczy" 
			style="width: 800px;height: 200px;" 
    		data-options="required:true">${mybean.caspaqdczy}</textarea>
		<p class="p3">
			<span class="s3">撤案理由：</span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="caspcaly" name="caspcaly" 
			style="width: 800px;height: 100px;" 
    		data-options="required:true">${mybean.caspcaly}</textarea>
		<p class="p6">
			<span class="s3">承办人：<input type="text" id="caspcbrqz" name="caspcbrqz" 
			class="easyui-validatebox" data-options="required:true" 
			style="width: 150px;text-align: left;" value="${mybean.caspcbrqz}"/>（签字）</span>
		</p>
		<p class="p6">
			<span class="s3">&times;年&times;月&times;日<input name="caspcbrqzrq" id="caspcbrqzrq" 
			placeholder="承办人签字日期" class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			class="easyui-validatebox" data-options="required:true" 
			style="width: 200px;" value="${mybean.caspcbrqzrq}" ></span>
		</p>
		<p class="p6">
			<span class="s3">承办部门负责人：<input type="text" id="caspcbbmfzr" 
			name="caspcbbmfzr" class="easyui-validatebox" data-options="required:true" 
			style="width: 150px;text-align: left;" value="${mybean.caspcbbmfzr}"/>（签字）</span>
		</p>
		<p class="p6">
			<span class="s3">&times;年&times;月&times;日<input name="caspcbbmfzrrq" 
			id="caspcbbmfzrrq" placeholder="部门负责人签字日期" class="Wdate" 
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" class="easyui-validatebox" 
			data-options="required:true" style="width: 200px;" value="${mybean.caspcbbmfzrrq}" ></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s3">审核部门意见：</span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="caspshbmyj" name="caspshbmyj" 
		style="width: 800px;height: 100px;" 
    		data-options="required:true">${mybean.caspshbmyj}</textarea>
		<p class="p6">
			<span class="s3">负责人：<input type="text" id="caspshfzr" name="caspshfzr" 
			class="easyui-validatebox" data-options="required:true" 
			style="width: 150px;text-align: left;" value="${mybean.caspshfzr}"/>（签字）</span>
		</p>
		<p class="p6">
			<span class="s3">&times;年&times;月&times;日<input name="caspshfzrrq" 
			id="caspshfzrrq" placeholder="负责人签字日期" class="Wdate" 
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" class="easyui-validatebox" 
			data-options="required:true" style="width: 200px;" value="${mybean.caspshfzrrq}" ></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s3">审批意见：</span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="caspspyj" name="caspspyj" 
			style="width: 800px;height: 100px;" 
    		data-options="required:true">${mybean.caspspyj}</textarea>
		<p class="p6">
			<span class="s3">分管负责人：<input type="text" id="caspfzfzr" name="caspfzfzr" 
			class="easyui-validatebox" data-options="required:true" 
			style="width: 150px;text-align: left;" value="${mybean.caspfzfzr}"/>（签字）</span>
		</p>
		<p class="p6">
			<span class="s3">&times;年&times;月&times;日<input name="caspfzfzrrq" id="caspfzfzrrq" 
			placeholder="分管负责人签字日期" class="Wdate" 
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			class="easyui-validatebox" data-options="required:true" 
			style="width: 200px;" value="${mybean.caspfzfzrrq}" ></span>
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
