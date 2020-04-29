<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsajdczjbg9DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
			+ request.getServerPort() + request.getContextPath() + "/";
	}
	
	Zfwsajdczjbg9DTO dto=new Zfwsajdczjbg9DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwsajdczjbg9DTO)request.getAttribute("mybean");
    }	
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
   
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
var layer;
     $(function(){
         layui.use(['layer'], function () {
             layer=layui.layer;
         })
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
					$("#lcwmbBtn").linkbutton('enable');	
	 		  		$("#printBtn").linkbutton('enable');
			 		alert("保存成功！");
              	} else {
              		parent.$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}
	//打印
	function myprint(){
		var v_zfwslydjid=$("#ajdjid").val(); 
	    var v_ajdczjbgid=$("#ajdczjbgid").val(); 
		var url = basePath + "pub/wsgldy/zfwsajdczjbg9PrintIndex";
		//创建模态窗口
		parent.sy.modalDialog({
            title: '另存模板',
            area: ['100%', '100%']
            , content: url
            , param : {
                ajdjid : v_zfwslydjid,
                zfwsqtbid : v_ajdczjbgid,
                time : new Date().getMilliseconds()
            }
            ,offset:["0px"]
            , btn: [ '关闭']
        })
		   
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
		var url = basePath + "pub/wsgldy/zfwsmobanIndex";
		//创建模态窗口
		parent.sy.modalDialog({
            title: '另存模板',
             area: ['100%', '100%']
            , content: url
            , param: {
                ajdjid : v_ajdjid,
                zfwsdmz : v_zfwsdmz,
                time : new Date().getMilliseconds()
            }
            ,offset:["0px"]
            , btn: [ '保存为模板文书','关闭']
            , btn1: function (index, layero) {
				parent.window[layero.find('iframe')[0]['name']].submitForm();
            }
        });
	}
	//提取模板
	function tqMoban(){
	    var obj = new Object();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    var url = basePath + "pub/wsgldy/zfwsmobantqIndex";
	    //创建模态窗口
		parent.sy.modalDialog({
                title: '模板提取',
            area: ['100%', '100%']
            , content: url
            , param: {
                zfwsdmmc : "<%=v_fjcsdmmc%>",
                zfwsdmz : v_zfwsdmz,
                time : new Date().getMilliseconds()
            }
            , offset: ["0px"]
            , btn: ['关闭']
        },
		function (dialogID){
			var v_retStr = sy.getWinRet(dialogID);
			
			sy.removeWinRet(dialogID);//不可缺少
			
			if (v_retStr!=null && v_retStr.type ==='ok'){
			   	var myrow=v_retStr.data;
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
		 <p class="p3">
			<span class="s2">当事人基本情况：<br/>
			<textarea id="dczjdsrjbqk" name="dczjdsrjbqk" 
			style="width: 730px;height: 200px;">${mybean.dczjdsrjbqk}</textarea>
			<br/>（当事人是自然人的，应写明当事人姓名、性别、年龄、身份证号码、工作单位、住所等；当事人是法人或者非法人企业及其分支机构
			<br/>&nbsp;的，写明该法人或者非法人企业及其分支机构的名称、地址、法定代表人或负责人姓名、职务等）</span>
		 </p>
		 <p class="p4"></p>
		 <p class="p4">
			<span class="s2">违法事实和证据：<br/>
		       <textarea class="easyui-validatebox bbtextarea"
		       id="dczjwfss" name="dczjwfss" style="width: 730px;height: 200px;">${mybean.dczjwfss}</textarea>
			</span>
		 </p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 (当事人违法的事实和证据，违反的法律法规依据名称及条、款、项具体内容)
		 <p class="p4">处罚裁量等次：<br/>
			<textarea id="dczjcfyj" name="dczjcfyj" style="width: 730px;height: 200px;">${mybean.dczjcfyj}</textarea>
		 </p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 <p class="p4"></p>
		 (根据违法事实、性质、情节和社会危害程度，参照《××法（条例、办法）行政处罚裁量标准》，确定违法行为适用的行政处罚裁量等次)
		 <p class="p4">处罚依据及建议：<br/>
		    <textarea id="dczjcfjy" name="dczjcfjy" style="width: 730px;height: 200px;">${mybean.dczjcfjy}</textarea>
		 </p>
		 <p class="p5"></p>
		 （拟处罚的法律法规依据及行政处罚建议）
		<div id="pd1" align="right">
			  <p class="f1">
				<span class="s2">  案件承办人1：<input id="dczjajcbrqz" name="dczjajcbrqz" 
					style="width:170px;" value="${mybean.dczjajcbrqz}"/>（签字）</span>  <br>
	            <span class="s2">  案件承办人2：<input id="dczjajcbrqz2" name="dczjajcbrqz2" 
	            	style="width:170px;" value="${mybean.dczjajcbrqz2}"/>（签字）</span>
			  </p>
			  <p style="clear:both;"></p>
			  <p class="f2">
				<span class="s2"> &times;年&times;月&times;日：
				<input name="dczjajcbrqzrq" id="dczjajcbrqzrq"  class="Wdate"
					  onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
					  style="width: 175px;"  value="${mybean.dczjajcbrqzrq}" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
		              data-options="iconCls:'ext-icon-book_add'">另存为模板</a>
		              
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
