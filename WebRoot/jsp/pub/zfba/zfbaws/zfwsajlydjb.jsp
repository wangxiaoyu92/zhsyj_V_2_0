<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.ZfwsajlydjbDTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String v_zfwslydjid = StringHelper.showNull2Empty(request.getParameter("zfwsqtbid"));
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
	// 执法文书表主键，用于更新填写标识
	String v_ajzfwsid = StringHelper.showNull2Empty(request.getParameter("ajzfwsid"));	
	
	ZfwsajlydjbDTO localZfwsajlydjbDTO=new ZfwsajlydjbDTO();
    if (request.getAttribute("mybean") != null) {
    	localZfwsajlydjbDTO = (ZfwsajlydjbDTO) request.getAttribute("mybean");
    }	
    
System.out.println("v_zfwslydjid "+v_zfwslydjid);    
	
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 0.2in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{color:black;}
.s39{color:black;text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align: right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:-0.072916664in;margin-left:0.8020833in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-indent:0.072916664in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-indent:0.072916664in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{text-indent:0.07013889in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p9{margin-left:0.07013889in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p10{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p11{text-indent:0.29166666in;margin-top:0.16666667in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p12{text-indent:0.36458334in;margin-top:0.16666667in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p13{text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p14{text-indent:3.4270833in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p15{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
</style>
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);

var mygrid;
$(function() {
	var v_zfwslydjid=$("#zfwslydjid").val();
	if (v_zfwslydjid==null || v_zfwslydjid=="" || v_zfwslydjid.length== 0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	}
	
});////////////////


function mysave(){
		var url= basePath+'/pub/wsgldy/saveZfwsajlydjb';

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	     parent.$.messager.progress({
			text : '正在提交....'
		});	// 显示进度条
		
		$('#myform').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					parent.$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	parent.$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		var v_zfwslydjid=$("#zfwslydjid").val();
			 		if (v_zfwslydjid==null || v_zfwslydjid=="" || v_zfwslydjid.length==0){
			 			$("#zfwslydjid").val(result.zfwszhujianid);
			 		}
			 		
			 		$("#saveBtn").linkbutton('disable');			 		
			 		$("#lcwmbBtn").linkbutton('enable');	
			 		$("#printBtn").linkbutton('enable');
			 		alert("保存成功！"); 	                        	                     
              	} else {
              		parent.$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
}

	// 关闭窗口
	var closeWindow = function(){
    	window.close();
	};
	
function myprint(){
    var obj = new Object();
   // var v_zfwsqtbid=$("#zfwslydjid").val();
    var v_ajdjid ='<%=v_ajdjid%>';
    var v_zfwslydjid=$("#zfwslydjid").val();
    
	var url="<%=basePath%>pub/wsgldy/zfwsajlydjbPrintIndex?ajdjid="+v_ajdjid+"&zfwslydjid="+v_zfwslydjid+"&time="+new Date().getMilliseconds();
    
    //创建模态窗口
	var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
		});

}


function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_zfwsdmz=$("#zfwsdmz").val();
    var v_zfwslydjid=$("#zfwslydjid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    
    //if (v_zfwslydjid==null || v_zfwslydjid=="" || v_zfwslydjid.length== 0){
    //	alert('请先保存，保存成功后，才能另存为模板');
    //	return false;
    //}
    
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
   
   	//创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		width : 650,
		height : 300,
		url : url
	});
}


function tqMoban(){
    var obj = new Object();
    var v_zfwsdmz=$("#zfwsdmz").val();
    
	var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="+v_zfwsdmz+"&zfwsdmmc=<%=v_fjcsdmmc%>&time="+new Date().getMilliseconds()));
    
    
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
	   	var myrow=v_retStr[0];
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
		parent.$("#"+sy.getDialogId()).dialog("close");       
	}
</script>

</head>
<div style="width: 210mm; margin: 0 auto">
    <body class="b1 b2 zfwsbackgroundcolor">
    <form id="myform" method="post">
		  <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
		  <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
		  <input id="zfwslydjid" name="zfwslydjid" type="hidden" value="${mybean.zfwslydjid}" />
		  <input id="ajzfwsid" name="ajzfwsid" type="hidden" value="<%=v_ajzfwsid%>" />
		  <input id="ajdjajly" name="ajdjajly" type="hidden" value="${mybean.ajdjajly}" />
		  		     
<p class="p1">
<span class="s1">食品药品行政处罚文书</span>
</p>
<p class="p2">
<span class="s1">案件来源登记表</span>
</p>
<p class="p3">
<span class="s2"><input type="text" id="ajlywsbh" name="ajlywsbh" style="width: 260px;text-align: right;"  value="${mybean.ajlywsbh}"/></span>
</p>
<hr style="height:2px;border:none;border-top:2px solid #555555;" />
<p class="p4">
<span class="s2">
    案件来源：<input type="checkbox" name="ajdjajly2" id="ajdjajly2" value="1" <% if (localZfwsajlydjbDTO.getAjdjajly()!=null && localZfwsajlydjbDTO.getAjdjajly().equals("1")) {%>checked="checked"<%}%> disabled="disabled">监督检查&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="checkbox" name="ajdjajly2" id="ajdjajly2" value="2" <% if (localZfwsajlydjbDTO.getAjdjajly()!=null && localZfwsajlydjbDTO.getAjdjajly().equals("2")) {%>checked="checked"<%}%> disabled="disabled">投诉/举报&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="checkbox" name="ajdjajly2" id="ajdjajly2" value="3" <% if (localZfwsajlydjbDTO.getAjdjajly()!=null && localZfwsajlydjbDTO.getAjdjajly().equals("3")) {%>checked="checked"<%}%> disabled="disabled">上级交办&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="checkbox" name="ajdjajly2" id="ajdjajly2" value="4" <% if (localZfwsajlydjbDTO.getAjdjajly()!=null && localZfwsajlydjbDTO.getAjdjajly().equals("4")) {%>checked="checked"<%}%> disabled="disabled">下级报请&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
</p>
<p class="p5">
<span class="s2">
    <input type="checkbox" name="ajdjajly2" id="ajdjajly2" value="5" <% if (localZfwsajlydjbDTO.getAjdjajly()!=null && localZfwsajlydjbDTO.getAjdjajly().equals("5")) {%>checked="checked"<%}%> disabled="disabled">监督抽验&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="checkbox" name="ajdjajly2" id="ajdjajly2" value="6" <% if (localZfwsajlydjbDTO.getAjdjajly()!=null && localZfwsajlydjbDTO.getAjdjajly().equals("6")) {%>checked="checked"<%}%> disabled="disabled">移送&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="checkbox" name="ajdjajly2" id="ajdjajly2" value="7" <% if (localZfwsajlydjbDTO.getAjdjajly()!=null && localZfwsajlydjbDTO.getAjdjajly().equals("7")) {%>checked="checked"<%}%> disabled="disabled">其他
</span>
	</p>
	<p class="p6">
	<span class="s2">当事人：</span><span class="s3">
	<input id="ajlydsr" name="ajlydsr" data style="width: 700px;"  value="${mybean.ajlydsr}"/></span>
	</p>
	<p class="p6">
	<span class="s2">地址:</span><span class="s3"><input id="ajlydz" name="ajlydz" style="width: 393px;" 
	 value="${mybean.ajlydz}"/></span><span class="s2">
	邮编：</span><span class="s3"><input id="ajlyyb" name="ajlyyb" style="width: 300px;" 
	 value="${mybean.ajlyyb}"/></span>
	</p>
	<p class="p6">
	<span class="s2">法定代表人（负责人）/自然人:</span><span class="s3"><input id="ajlyfddbr" name="ajlyfddbr" style="width: 260px;"  value="${mybean.ajlyfddbr}"/></span><span class="s2">联系电话:</span><span class="s3"><input id="ajlylxdh" name="ajlylxdh" style="width: 260px;"  value="${mybean.ajlylxdh}"/></span>
	</p>
	<p class="p7">
	<span class="s2">法定代表人（负责人）/自然人身份证号码：</span><span class="s3"><input id="ajlyfddbrsfzh" name="ajlyfddbrsfzh" style="width: 500px;"  value="${mybean.ajlyfddbrsfzh}"/></span>
	</p>
	<p class="p8">
	<span class="s2">登记时间：</span><span class="s3">
	<input name="ajlydjsj" id="ajlydjsj"  class="Wdate" style="width: 160px;"
	onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
	readonly="readonly" style="width: 175px;" value="${mybean.ajlydjsj}" >
	</span>
	</p>
	<p class="p8">
	    基本情况介绍：（负责人，案发时间、地点，重要证据，危害后果及其影响等）
	<p>
	   <textarea id="ajlyjbqkjs" name="ajlyjbqkjs" style="width: 800px;height: 260px" 
	    class="easyui-validatebox bbtextarea">${mybean.ajlyjbqkjs}</textarea> 
	
	<p class="p12">
	<span class="s2">附件：<input id="ajlyfj" name="ajlyfj" style="width: 600px;"  value="${mybean.ajlyfj}"/></span>
	</p>
	<p class="p13">
	<span class="s2">                                  </span>
	</p>
	<p class="p13">
	    <span class="s2">                                  </span>
	</p>
	<p class="p13">
	<span class="s2">                          </span>
	</p>
	<p class="p3">
	<span class="s2">                                            记录人：<input id="ajlyjlrqz" name="ajlyjlrqz" style="width: 90px;" class="easyui-validatebox" 
							data-options="validType:'length[0,20]'" value="${mybean.ajlyjlrqz}"/>(签字)</span>
	</p>
	<p class="p3">
	<span class="s2">                               &times;年&times;月&times;日 <input name="ajlyjlrqzrq" id="ajlyjlrqzrq"  class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 175px;" value="${mybean.ajlyjlrqzrq}" ></span>
	</p>
	<p class="p13"></p>
	<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	
	<p class="p6">
	<span class="s2">处理意见：</span>
	</p>
	   <textarea class="easyui-validatebox bbtextarea" id="ajlyclyj" name="ajlyclyj" style="width: 800px;height: 200px;" 
	    data-options="required:false,validType:'length[0,500]'">${mybean.ajlyclyj}</textarea>
	<p class="p14">
	<span class="s2"> </span>
	</p>
	<p class="p14"></p>
	<p class="p14">
	<span class="s2"> </span>
	</p>
	<p class="p3">
	<span class="s2">                                                                                      负责人：<input id="ajlyfzr" name="ajlyfzr" style="width: 100px;" class="easyui-validatebox" data-options="validType:'length[0,20]'" value="${mybean.ajlyfzr}"/>(签字)   </span>
	</p>
	<p class="p3">
	<span class="s2">     &times;年&times;月&times;日<input name="ajlyfzrqzsj" id="ajlyfzrqzsj"  class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 175px;" value="${mybean.ajlyfzrqzsj}" > </span>
	</p>
	<p class="p15"></p>
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
