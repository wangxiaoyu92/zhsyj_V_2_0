<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxxclwptzs16DTO" %>
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
	// 执法文书先行处理物品通知书
	Zfwsxxclwptzs16DTO dto = new Zfwsxxclwptzs16DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwsxxclwptzs16DTO) request.getAttribute("mybean");
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
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:3.1930556in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;margin-left:0.072916664in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.36458334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.29166666in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:2.7881944in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{margin-left:0.072916664in;margin-right:0.8611111in;margin-top:0.108333334in;
	text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{margin-right:0.29166666in;margin-top:0.108333334in;text-align:center;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-indent:4.0631943in;margin-right:0.29166666in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-indent:0.06944445in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
</style>


<title>先行处理物品通知书</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var layer;
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);
var mygrid;
$(function() {
	layui.use('layer',function(){
		layer =layui.layer;
	});
	var v_xxclwptzsid = $("#xxclwptzsid").val();
	if (v_xxclwptzsid==null || v_xxclwptzsid=="" || v_xxclwptzsid.length== 0){
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
		var url= basePath+'/pub/wsgldy/saveZfwsxxclwptzs';

		// 提交保存
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
			 		$("#xxclwptzsid").val(result.xxclwptzsid);
			 		$("#saveBtn").linkbutton('disable');			 		
			 		$("#lcwmbBtn").linkbutton('enable');	
			 		$("#printBtn").linkbutton('enable');
			 		alert("保存成功！");
              	} else {
              		alert("保存失败！"+result.msg);
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
    // 执法文书代码值
    var v_zfwsdmz = $("#zfwsdmz").val();
    // 先行处理物品通知书id
    var v_xxclwptzsid = $("#xxclwptzsid").val();
	var url="<%=basePath%>pub/wsgldy/zfwsxxclwptzsPrintIndex?ajdjid="
			+v_ajdjid+"&xxclwptzsid="+v_xxclwptzsid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();

	//创建模态窗口
	sy.modalDialog({
		area : ['700px', '380px']
		,content :url
		,offset:'5px'
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
    var v_xxclwptzsid = $("#xxclwptzsid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid
		+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
	//创建模态窗口
	sy.modalDialog({
		area : ['700px', '380px']
		,content :url
		,offset:'5px'
		,btn:['保存为文书模板','关闭']
		,btn1: function(index, layero){
			window[layero.find('iframe')[0]['name']].submitForm();
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
	sy.modalDialog({
		area : ['900px', '380px']
		,content :url
		,offset:'5px'
		,btn:['关闭']
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
		<input id="xxclwptzsid" name="xxclwptzsid" type="hidden" value="${mybean.xxclwptzsid}" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>" />		     
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">先行处理物品通知书</span></p>
		<div align="right">
			<p class="p3"><span class="s2">                               
			<input type="text" id="xxclwsbh" name="xxclwsbh"style="width: 260px;text-align: right;"
			<%if(dto.getXxclwsbh()!=null && !"".equals(dto.getXxclwsbh())){%>
			 value="${mybean.xxclwsbh}"<%}else{%>value="（××）食药监×检告〔年份〕×号"<%}%>/>
			</span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2"><input type="text" id="xxcldsr" name="xxcldsr" 
			style="width: 150px;text-align: left;" value="${mybean.xxcldsr}"/>：</span>
		</p>
		<p class="p5">
			<span class="s2">我局于<input name="xxclcfkyrq" id="xxclcfkyrq"  class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 175px;" value="${mybean.xxclcfkyrq}" >
			&times;年&times;月&times;日以
			<input type="text" id="xxclcfkyjdsbh" name="xxclcfkyjdsbh" 
			style="text-align: left;width: 200px;" value="${mybean.xxclcfkyjdsbh}"/>
			《查封（扣押）决定书》查封（扣押）了你（单位）的物品。为防止造成不必要的损失，
			根据《食品药品行政处罚程序规定》第二十九条第二款的规定，本局决定对
			<input type="text" id="xxclwplb" name="xxclwplb" 
				style="width: 150px;text-align: left;" value="${mybean.xxclwplb}"/>
			物品予以先行处理。</span>
		</p>
		<p class="p6">
			<span class="s2">处理方式：<input type="text" id="xxclclfs" name="xxclclfs"
			style="width: 550px;text-align: left;" value="${mybean.xxclclfs}"/> </span>
		</p>
		<p class="p7"></p>
		<p class="p6">
			<span class="s2">附件：<input type="text" id="xxclfj" name="xxclfj"
			style="width: 550px;text-align: left;" value="${mybean.xxclfj}"/></span>
		</p>
		<p class="p8"></p>
		<p class="p9"></p>
		<p class="p10"></p>
		<p class="p9"></p>
		<p class="p9"></p>
		<p class="p9"></p>
		<div align="right">
			<p class="p9">
			<span class="s2">（公   章）</span>
			</p>
			<p class="p3">
				<span class="s2">&times;年&times;月&times;日
					<input name="xxclgzrq" id="xxclgzrq"  class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 175px;" value="${mybean.xxclgzrq}" >
				</span>
			</p>
		</div>
		<p class="p12"></p>
		<p class="p12"></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<p class="p10"></p>
		<p class="p13">
			<span class="s2">注：正文3号仿宋体字，存档（1）。</span>
		</p>
		<p class="p14"></p>


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
