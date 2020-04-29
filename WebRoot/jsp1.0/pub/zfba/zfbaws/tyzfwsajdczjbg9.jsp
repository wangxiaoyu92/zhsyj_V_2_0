<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsajdczjbg9DTO,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	
/* 	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String v_zfwslydjid = StringHelper.showNull2Empty(request.getParameter("zfwsid")); */
	
	Zfwsajdczjbg9DTO dto=new Zfwsajdczjbg9DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwsajdczjbg9DTO)request.getAttribute("mybean");
    }	
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
	Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();//获取当前用户
    //String aa027=vSysUser.getAaa027();    //获取当前用户的统筹区
   
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=GB2312">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-indent:3.2083333in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
#pd1 p{text-align:end;}
#btn{clear:both;}
.lh30{line-height:30px;}
</style>
<title>案件调查终结报告</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	printView  
var mygrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;

	/* $(function(){
		if($("#ajdczjbgid").val()==""){
			$("#printBtn").linkbutton('disable');
		}
		var tcq4=tcq.substr(0,4); 
		if(tcq4=='4117'){
			$('#tang').hide();
		}
		else{
			$('#zmd').hide();
		}
		
	});	 */			
      $(function(){
		var v_ajdczjbgid=$("#ajdczjbgid").val();
		if (v_ajdczjbgid==null || v_ajdczjbgid=="" || v_ajdczjbgid.length== 0){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		} 
	});
	//保存
	function mysave(){
				var url= basePath+'pub/wsgldy/saveZfwsajdczjbg9';
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
					 		$("#ajdczjbgid").val(result.ajdczjbgid);
					 		$("#saveBtn").linkbutton('disable');
					 		$("#printBtn").linkbutton({disabled:false});
					 		alert("保存成功！");
		              	} else {
		              		parent.$.messager.alert('提示','保存失败：'+result.msg,'error');
		                }
			        }    
				});
	}
	//打印
	function myprint(){
		    var obj = new Object();
		    var v_zfwslydjid=$("#ajdjid").val(); 
		    var v_ajdczjbgid=$("#ajdczjbgid").val();  
			var url="<%=basePath%>pub/wsgldy/zfwsajdczjbg9PrintIndex?ajdjid="+v_zfwslydjid+"&zfwsqtbid="+v_ajdczjbgid+"&time="+new Date().getMilliseconds();
		   	//创建模态窗口
			var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
			});
	}
	//保存模板
	function saveAsMoban(){
	    var obj = new Object();
	    var v_ajdjid=$("#ajdjid").val();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    var v_zfwslydjid=$("#fzysspid").val();
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    } 
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
	    //创建模态窗口
		var dialog = parent.sy.modalDialog({
		title : ' ',
		width : 650,
		height : 300,
		url : url
	});
	    
	}
	//提取模板
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
			var v_zfwsqtbid = myrow.zfwsqtbid;
			$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
				zfwsmbid : v_zfwsmbid,
			zfwsqtbid : v_zfwsqtbid,
			ajdczjbgid : $("#ajdczjbgid").val(),
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
	 	 <input id="ajdjid" name="ajdjid"  type="hidden" value="<%=v_ajdjid %>" />
	 	 <input id="zfwsdmz" name="zfwsdmz"  type="hidden"  value="<%=zfwsdmz %>" />
	 	 <input id="ajdczjbgid" name="ajdczjbgid" type="hidden" value="${mybean.ajdczjbgid}"/>
		 <p class="p1">
		  <span class="s1">食品药品行政处罚文书</span>
		 </p>
		 <p class="p2">
		   <span class="s1">案件调查终结报告</span>
		 </p>
		 <p class="p3">
		   <span class="s2">案由:<input style="width:650px" name="ajdjay" value="${mybean.ajdjay}"/></span>
		 </p> 
		 <p class="p4">
			<span class="s2">违法事实：<br/>
		       <textarea class="easyui-validatebox bbtextarea"  data-options="required:true" id="dczjwfss" name="dczjwfss" style="width: 730px;height: 200px;">${mybean.dczjwfss}</textarea>
			</span>
		 </p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4">证据材料：<br/>
			<textarea class="easyui-validatebox bbtextarea"  data-options="required:true" id="dczjzjcl" name="dczjzjcl" style="width: 730px;height: 200px;">${mybean.dczjzjcl}</textarea>
		 </p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <%-- <p class="p4">处罚依据：<br/>
			<textarea class="easyui-validatebox bbtextarea"  data-options="required:true" id="dczjcfyj" name="dczjcfyj" style="width: 730px;height: 200px;">${mybean.dczjcfyj}</textarea>
		 </p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p> --%>
		
			<span class="s2"> </span>
		 </p>
		
		 <%-- <p class="p4" id="zmd">违反法律法规条款：<br/>
			<textarea class="easyui-validatebox bbtextarea"  data-options="required:true" id="dczjwfflfgtk" name="dczjwfflfgtk" style="width: 730px;height: 200px;">${mybean.dczjcfjy}</textarea>
		 </p>
		
		 <p class="p5"></p>
		 <p class="p6"> --%>
			<span class="s2">                                                  </span>
		 </p> 
		 <p class="p4">违法行为等次：<br/>
		 <textarea class="easyui-validatebox bbtextarea"  data-options="required:true" id="dczjwfxwdc" name="dczjwfxwdc" style="width: 730px;height: 200px;">${mybean.dczjcfjy}</textarea>
		 </p>
		 <p class="p5"></p>
		 <p class="p6">
			<span class="s2"></span>
		 </p>
		 <p class="p4"  id="tang">应受行政处罚的依据和种类：<br/>
		 <textarea class="easyui-validatebox bbtextarea"  data-options="required:true" id="dczjysxzcfdyjhzl" name="dczjysxzcfdyjhzl" style="width: 730px;height: 200px;">${mybean.dczjcfjy}</textarea>
		 </p>
		 <p class="p5"></p>
		 <p class="p6">
			<span class="s2"></span>
		 </p> 
		  <p class="p4">处罚建议：<br/>
		    <textarea class="easyui-validatebox bbtextarea"  data-options="required:true" id="dczjcfjy" name="dczjcfjy" style="width: 730px;height: 200px;">${mybean.dczjcfjy}</textarea>
		 </p>
		 <p class="p5"></p>
		 <p class="p6">
	<div id="pd1">
		  <p class="f1" style="float:right;">
			<span class="s2">  案件承办人1：<input id="dczjajcbrqz" name="dczjajcbrqz" style="width:70px;"  class="easyui-validatebox bbtextarea" value="${mybean.dczjajcbrqz}"/>（签字）</span>  <br>
            <span class="s2">  案件承办人2：<input id="dczjajcbrqz2" name="dczjajcbrqz2" style="width:70px;"  class="easyui-validatebox bbtextarea" value="${mybean.dczjajcbrqz2}"/>（签字）</span>
		  </p>
		  <p style="clear:both;"></p>
		  <p class="f2">
			<span class="s2" style="float:right;">                                                 &times;年&times;月&times;日：<input name="dczjajcbrqzrq" id="dczjajcbrqzrq"  class="Wdate easyui-validatebox bbtextarea"
				  onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  style="width: 175px;"  value="${mybean.dczjajcbrqzrq}" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</span>
		  </p>
	</div>
		  <p class="p7"></p> 
		  <p class="p14"></p>
		  </br></br>
			 <hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
	  <div id="btn">
				<table>
			    	<tr align="right" style="height: 60px;">
			    <td colspan=4 align="right">
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
		            <%}%>
		            
		           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		           	           	                
		           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeAndRefreshWindow();"
		           data-options="iconCls:'icon-back'">关闭</a>
				</td>  
			</table>
	  </div>
		
	  </form>
	</body>
	</div>
</html>
