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
	Zfwscaspb21DTO dto = new Zfwscaspb21DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwscaspb21DTO) request.getAttribute("mybean");
    }	
	// 撤案审批表承办部门负责人签字
    boolean v_caspb_caspbcbbmfzrqz = SysmanageUtil.isExistsFuncByBizid("caspb_caspcbcbbmfzrqz");
	String v_caspb_caspbcbbmfzrqz_readonly = "";
	String v_caspb_caspbcbbmfzrqz_disable = "";
	if (!v_caspb_caspbcbbmfzrqz){
		v_caspb_caspbcbbmfzrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_caspb_caspbcbbmfzrqz_disable = "disabled='disabled'";		
	}
	// 撤案审批表审批部门负责人签字
    boolean v_caspb_caspbspbmfzrqz = SysmanageUtil.isExistsFuncByBizid("caspb_caspcbspbmfzrqz");
	String v_caspb_caspbspbmfzrqz_readonly = "";
	String v_caspb_caspbspbmfzrqz_disable = "";
	if (!v_caspb_caspbspbmfzrqz){
		v_caspb_caspbspbmfzrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_caspb_caspbspbmfzrqz_disable = "disabled='disabled'";		
	}
	// 撤案审批表审批分管负责人签字
    boolean v_caspb_caspbspfgfzrqz = SysmanageUtil.isExistsFuncByBizid("caspb_caspcbspfgfzrqz");
	String v_caspb_caspbspfgfzrqz_readonly = "";
	String v_caspb_caspbspfgfzrqz_disable = "";
	if (!v_caspb_caspbspfgfzrqz){
		v_caspb_caspbspfgfzrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_caspb_caspbspfgfzrqz_disable = "disabled='disabled'";		
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
var ly2;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;

$(function() {  
	   ly2= $('#ajdjajly').combobox({
	    	data : v_ajdjajly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	       }); 
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
			 		$("#caspbid").val(result.caspbid);			 		
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
    var v_caspbid = $("#caspbid").val();
	var url="<%=basePath%>pub/wsgldy/zfwscaspbPrintIndex?ajdjid="
		+v_ajdjid+"&zfwsqtbid="+v_caspbid+"&time="+new Date().getMilliseconds();
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
		var v_zfwsqtbid = myrow.zfwsqtbid;
		$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
			zfwsmbid : v_zfwsmbid,
			zfwsqtbid : v_zfwsqtbid,
			caspbid: $("#caspbid").val(),
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
		<input id="caspbid" name="caspbid" type="hidden" value="${mybean.caspbid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />		     
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">撤案审批表</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s3">案&nbsp;&nbsp;由：<input type="text" id="ajdjay" name="ajdjay" 
			style="width: 710px;text-align: left;" value="${mybean.ajdjay}"/></span>
		</p>
		<p class="p3">
			<span class="s3">当事人：<input type="text" id="caspdsr" name="caspdsr" 
			style="width: 295px;text-align: left;" value="${mybean.caspdsr}"/>
                             法定代表人（负责人）：<input type="text" id="caspfddbr" name="caspfddbr" 
               style="width: 280px;text-align: left;"value="${mybean.caspfddbr}"/>
			</span>
		</p>
		<p class="p3">
			<span class="s3">地&nbsp;&nbsp;址：<input type="text" id="caspdz" name="caspdz" 
			style="width: 300px;text-align: left;" value="${mybean.caspdz}"/>
                             联系方式：<input type="text" id="casplxfs" name="casplxfs" 
              style="width: 350px;text-align: left;" value="${mybean.casplxfs}"/>
			</span>
		</p>
		<p class="p3">
			<span class="s3">案件来源：<input type="text" id="ajdjajly" name="ajdjajly" 
			style="width: 295px;text-align: left;" value="${mybean.ajdjajly}"/>
                             立案时间：<input name="casplasj" id="casplasj" 
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			style="width: 200px;" value="${mybean.casplasj}" >
			</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s3">案情调查摘要：</span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="caspaqdczy" name="caspaqdczy" 
			style="width: 800px;height: 200px;"  >${mybean.caspaqdczy}</textarea>
		<p class="p3">
			<span class="s3">撤案理由：</span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="caspcaly" name="caspcaly" 
			style="width: 800px;height: 100px;" >${mybean.caspcaly}</textarea>
		<p class="p6">
			<span class="s3">承办人1：<input type="text" id="caspcbrqz" name="caspcbrqz"
			style="width: 150px;text-align: left;" value="${mybean.caspcbrqz}"/></span><br>
		</p>	
		<p class="p6">
			<span class="s3">承办人2：<input type="text" id="caspcbrqz2" name="caspcbrqz2" 
			style="width: 150px;text-align: left;" value="${mybean.caspcbrqz2}"/>（签字）</span>
		</p>
		<p class="p6">
			<span class="s3">&times;年&times;月&times;日<input name="caspcbrqzrq" id="caspcbrqzrq" 
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
			style="width: 200px;" value="${mybean.caspcbrqzrq}" ></span>
		</p>
		<p class="p6">
			<span class="s3">承办部门负责人：<input type="text" id="caspcbbmfzr"
			name="caspcbbmfzr" style="width: 150px;text-align: left;" value="${mybean.caspcbbmfzr}"/>（签字）</span>
		</p>
		<p class="p6">
			<span class="s3">&times;年&times;月&times;日<input name="caspcbbmfzrrq" 
			id="caspcbbmfzrrq" class="Wdate"
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			  style="width: 200px;" value="${mybean.caspcbbmfzrrq}" ></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s3">审核部门意见：</span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="caspshbmyj" name="caspshbmyj" 
		style="width: 800px;height: 100px;"  >${mybean.caspshbmyj}</textarea>
		<p class="p6">
			<span class="s3">负责人：<input type="text" id="caspshfzr" name="caspshfzr" <%=v_caspb_caspbspbmfzrqz_readonly %>
			style="width: 150px;text-align: left;" value="${mybean.caspshfzr}"/>（签字）</span> 
		</p>
		<p class="p6">
			<span class="s3">&times;年&times;月&times;日<input name="caspshfzrrq" 
			id="caspshfzrrq"class="Wdate" <%=v_caspb_caspbspbmfzrqz_disable %>
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
			 style="width: 200px;" value="${mybean.caspshfzrrq}" ></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s3">审批意见：</span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="caspspyj" name="caspspyj" 
			style="width: 800px;height: 100px;">${mybean.caspspyj}</textarea>
		<p class="p6">
			<span class="s3">分管负责人：<input type="text" id="caspfzfzr" name="caspfzfzr" <%=v_caspb_caspbspfgfzrqz_readonly%>
			style="width: 150px;text-align: left;" value="${mybean.caspfzfzr}"/>（签字）</span>
		</p>
		<p class="p6">
			<span class="s3">&times;年&times;月&times;日<input name="caspfzfzrrq" id="caspfzfzrrq" 
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" <%=v_caspb_caspbspfgfzrqz_disable %>
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
