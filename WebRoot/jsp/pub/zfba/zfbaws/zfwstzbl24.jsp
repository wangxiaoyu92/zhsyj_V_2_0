<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwstzbl24DTO" %>
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
	// 文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	// 附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	// 是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	// 执法文书表主键，用于更新填写标识
	String v_ajzfwsid = StringHelper.showNull2Empty(request.getParameter("ajzfwsid"));
	// 听证笔录
	Zfwstzbl24DTO dto = new Zfwstzbl24DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwstzbl24DTO) request.getAttribute("mybean");
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
.s3{color:black;text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:4.5833335in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{margin-top:0.108333334in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
</style>

<title>听证笔录</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var layer;
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s); 
var mygrid;
// 委托代理人性别
var v_wtdlrxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
//法定代表人性别
var v_tzblfddbrxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
$(function() {
	layui.use('layer',function(){
		layer =layui.layer;
	});
	var v_tzblid = $("#tzblid").val();
	if (v_tzblid==null || v_tzblid=="" || v_tzblid.length== 0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	}
    v_wtdlrxb = $('#tzblwtdlrxb').combobox({
    	data : v_wtdlrxb,      
        valueField : 'id',   
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : 'auto' 
    });
    v_tzblfddbrxb = $('#tzblfddbrxb').combobox({
    	data : v_tzblfddbrxb,      
        valueField : 'id',   
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : 'auto' 
    });
});
/**
 * 保存
 */
function mysave(){
		// 判断听证开始时间与结束时间是否填写正确
		var startDate = $("#tzbltzkssj").val();
		var endDate = $("#tzbltzjssj").val();
		if(startDate.length > 0 && endDate.length > 0){   
        	var startDateTemp = startDate.split(" ");   
      		var endDateTemp = endDate.split(" ");   
      		var arrStartDate = startDateTemp[0].split("-");   
      		var arrEndDate = endDateTemp[0].split("-");   
      		var arrStartTime = startDateTemp[1].split(":");   
      		var arrEndTime = endDateTemp[1].split(":");   
      		var allStartDate = new Date(arrStartDate[0],arrStartDate[1],arrStartDate[2],
      			arrStartTime[0],arrStartTime[1],arrStartTime[2]);   
      		var allEndDate = new Date(arrEndDate[0],arrEndDate[1],arrEndDate[2],
      			arrEndTime[0],arrEndTime[1],arrEndTime[2]);   
      		if(allStartDate.getTime() > allEndDate.getTime()){   
      			alert("请正确填写听证日期");
       			return;   
      		}
      	}
		var url= basePath+'/pub/wsgldy/saveZfwstzbl';

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条
		
		$('#myform').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate'); 
				if(!isValid){
					parent.$.messager.progress('close'); 
				}					
				return isValid;
	        },
	        success: function(result){
	        	parent.$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$("#tzblid").val(result.tzblid);			 		
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
    var v_tzblid=$("#tzblid").val();
    
	var url="<%=basePath%>pub/wsgldy/zfwstzblPrintIndex?ajdjid="
		+v_ajdjid+"&zfwsqtbid="+v_tzblid+"&time="+new Date().getMilliseconds();
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
    var v_tzblid = $("#tzblid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    
    if (v_tzblid==null || v_tzblid=="" || v_tzblid.length== 0){
    	alert('请先保存，保存成功后，才能另存为模板');
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
			var v_zfwsqtbid = myrow.zfwsqtbid;
			$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
						zfwsmbid : v_zfwsmbid,
						zfwsqtbid : v_zfwsqtbid,
						tzblid: $("#tzblid").val(),
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
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
		<input id="tzblid" name="tzblid" type="hidden" value="${mybean.tzblid}"/>
		<input id="ajzfwsid" name="ajzfwsid" type="hidden" value="<%=v_ajzfwsid%>" />
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">听证笔录 </span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">案由：</span>
			<span class="s3"><input type="text" id="ajdjay" name="ajdjay" 
			style="width: 730px;text-align: left;" value="${mybean.ajdjay}"/></span>
		</p>
		<p class="p4">
			<span class="s2">当事人：</span>
			<span class="s3"><input type="text" id="tzbldsr" name="tzbldsr" 
			style="width: 720px;text-align: left;" value="${mybean.tzbldsr}"/></span>
		</p>
		<p class="p4">
			<span class="s2">法定代表人（负责人）：</span>
			<span class="s3"><input type="text" id="tzblfddbr" name="tzblfddbr" 
			style="width: 150px;text-align: left;" value="${mybean.tzblfddbr}"/></span>
			<span class="s2">性别：</span>
			<span class="s3"><input type="text" id="tzblfddbrxb" name="tzblfddbrxb" 
			style="width: 60px;text-align: left;" value="${mybean.tzblfddbrxb}"/></span>
			<span class="s2">年龄：</span>
			<span class="s3"><input type="text" id="tzblfddbrnl" name="tzblfddbrnl" 
			class="easyui-validatebox" validtype="integer"
			style="width: 60px;text-align: left;" value="${mybean.tzblfddbrnl}"/></span>
			<span class="s2">联系方式：</span>
			<span class="s3"><input type="text" id="tzblfddbrlxfs" name="tzblfddbrlxfs" 
			class="easyui-validatebox" validtype="phoneAndMobile"
			style="width: 150px;text-align: left;" value="${mybean.tzblfddbrlxfs}"/></span>
		</p>
		<p class="p4">
			<span class="s2">地址：</span>
			<span class="s3"><input type="text" id="tzbldz" name="tzbldz" 
			style="width: 730px;text-align: left;" value="${mybean.tzbldz}"/></span>
		</p>
		<p class="p4">
			<span class="s2">委托代理人：</span>
			<span class="s3"><input type="text" id="tzblwtdlr" name="tzblwtdlr" 
				style="width: 150px;text-align: left;" value="${mybean.tzblwtdlr}"/></span>
			<span class="s2">性别：</span>
			<span class="s3"><input type="text" id="tzblwtdlrxb" name="tzblwtdlrxb" 
				style="width: 50px;text-align: left;" value="${mybean.tzblwtdlrxb}"/></span>
			<span class="s2">年龄：</span>
			<span class="s3"><input type="text" id="tzblwtdlrnl" name="tzblwtdlrnl" 
			class="easyui-validatebox" validtype="integer"
				style="width: 50px;text-align: left;" value="${mybean.tzblwtdlrnl}"/></span>
			<span class="s2">职务：</span>
			<span class="s3"><input type="text" id="tzblwtdlrzw" name="tzblwtdlrzw" 
				style="width: 80px;text-align: left;" value="${mybean.tzblwtdlrzw}"/></span>
			<span class="s2">联系方式：</span>
			<span class="s3"><input type="text" id="tzblwtdlrlxfs" name="tzblwtdlrlxfs" 
			class="easyui-validatebox" validtype="phoneAndMobile"
				style="width: 140px;text-align: left;" value="${mybean.tzblwtdlrlxfs}"/></span>
		</p>
		<p class="p4">
			<span class="s2">工作单位：</span>
			<span class="s3"><input type="text" id="tzblwtdlrgzdw" name="tzblwtdlrgzdw" 
				style="width: 355px;text-align: left;" value="${mybean.tzblwtdlrgzdw}"/></span>
			<span class="s2">地址：</span>
			<span class="s3"><input type="text" id="tzblwtdlrdz" name="tzblwtdlrdz" 
				style="width: 300px;text-align: left;" value="${mybean.tzblwtdlrdz}"/></span>
		</p>
		<p class="p4">
			<span class="s2">案件承办人：</span>
			<span class="s3"><input type="text" id="tzblajcbr1" name="tzblajcbr1" 
			style="width: 200px;text-align: left;" value="${mybean.tzblajcbr1}"/></span>
			<span class="s2">部门：</span>
			<span class="s3"><input type="text" id="tzblajcbr1bm" name="tzblajcbr1bm" 
			style="width: 180px;text-align: left;" value="${mybean.tzblajcbr1bm}"/></span>
			<span class="s2">职务：</span>
			<span class="s3"><input id="tzblajcbr1zw" name="tzblajcbr1zw" 
			style="width: 175px" value="${mybean.tzblajcbr1zw}" /></span>
		</p>
		<p class="p4">
			<span class="s2">案件承办人：</span>
			<span class="s3"><input type="text" id="tzblajcbr2" name="tzblajcbr2" 
			style="width: 200px;text-align: left;" value="${mybean.tzblajcbr2}"/></span>
			<span class="s2">部门：</span>
			<span class="s3"><input type="text" id="tzblajcbr2bm" name="tzblajcbr2bm" 
			style="width: 180px;text-align: left;" value="${mybean.tzblajcbr2bm}"/></span>
			<span class="s2">职务：</span>
			<span class="s3"><input type="text" id="tzblajcbr2zw" name="tzblajcbr2zw" 
			style="width: 175px" value="${mybean.tzblajcbr2zw}" /></span>
		</p>
		<p class="p4">
			<span class="s2">听证主持人：</span>
			<span class="s3"><input type="text" id="tzbltzzcr" name="tzbltzzcr" 
				style="width: 320px;text-align: left;" value="${mybean.tzbltzzcr}"/></span>
			<span class="s2">记录人：</span>
			<span class="s3"><input type="text" id="tzbljlr" name="tzbljlr" 
				style="width: 310px;text-align: left;" value="${mybean.tzbljlr}"/></span>
		</p>
		<p class="p4">
			<span class="s2">听证时间：</span>
			<span class="s3"><input name="tzbltzkssj" id="tzbltzkssj"  
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
			style="width: 335px;" value="${mybean.tzbltzkssj}" ></span>
			<span class="s2">至</span>
			<span class="s3"><input name="tzbltzjssj" id="tzbltzjssj"  
			class="Wdate"  class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
			style="width: 335px;" value="${mybean.tzbltzjssj}" ></span>
		</p>
		<p class="p4">
			<span class="s2">听证方式：</span>
			<span class="s3"><input type="text" id="tzbltzfs" name="tzbltzfs" 
				style="width: 700px;text-align: left;" value="${mybean.tzbltzfs}"/></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p6">
			<span class="s2">记录：</span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="tzbljl" 
			name="tzbljl" style="width: 770px;height: 200px;" >${mybean.tzbljl}</textarea>
		<p class="p6">
			<span class="s2">当事人或委托代理人：<input id="tzbldsrqz" name="tzbldsrqz" 
				style="width: 150px" value="${mybean.tzbldsrqz}"/>（签字）
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                                                                            
			<input name="tzbldsrqzrq" id="tzbldsrqzrq"  
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
			style="width: 175px;" value="${mybean.tzbldsrqzrq}" >
			&times;年&times;月&times;日</span>
		</p>
		<p class="p6">
			<span class="s2">案件承办人：<input id="tzblajcbrqz" name="tzblajcbrqz" 
			style="width: 150px" value="${mybean.tzblajcbrqz}"/>（签字）
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                                                                            
			<input name="tzblajcbrrq" id="tzblajcbrrq"  
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
			style="width: 175px;" value="${mybean.tzblajcbrrq}" >
			&times;年&times;月&times;日</span>
		</p>
		<p class="p6">
			<span class="s2">听证主持人：<input id="tzbltzzcrqz" name="tzbltzzcrqz" 
			style="width: 150px" value="${mybean.tzbltzzcrqz}"/>（签字）
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                                             
			<input name="tzbltzzcrqzrq" id="tzbltzzcrqzrq"  
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
			style="width: 175px;" value="${mybean.tzbltzzcrqzrq}" >
			&times;年&times;月&times;日</span>
		</p>
		<p class="p6">
			<span class="s2">记录人：<input id="tzbljlrqz" name="tzbljlrqz" 
			style="width: 150px" value="${mybean.tzbljlrqz}"/>（签字）
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                                             
			<input name="tzbljlrqzrq" id="tzbljlrqzrq"  
			class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
			style="width: 175px;" value="${mybean.tzbljlrqzrq}" >
			&times;年&times;月&times;日</span>
		</p>
		<p class="p6">
			<span class="s2">注：听证笔录经当事人审核无误后逐页签字，修改处签字或按指纹，
			并在笔录上注明对笔录真实性的意见。案件承办人和听证主持人在笔录上签字。</span>
		</p>
		<p class="p7"></p>
		
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
