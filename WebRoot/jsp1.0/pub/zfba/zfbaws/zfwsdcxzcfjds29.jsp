<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsdcxzcfjds29DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwsdcxzcfjds29DTO dto = new Zfwsdcxzcfjds29DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsdcxzcfjds29DTO) request.getAttribute("mybean");
	}
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
	String v_userid=StringHelper.showNull2Empty(request.getParameter("userid"));
	
	String sjws=null;
	if (request.getAttribute("sjws") != null) {
		sjws= (String) request.getAttribute("sjws");
	}	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=GB2312">
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{color:black;text-decoration: underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:3.4722223in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:3.8194444in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:5pt;}
.p8{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.tr{text-align: right;}
</style>
<title>当场行政处罚决定书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var v_sjws="<%=sjws%>";
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);  
var mygrid;
var dccffddbrxb; // 法定负责人性别
var dccfyyzz; // 资质证明
var v_zzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
var v_xb = <%=SysmanageUtil.getAa10toJsonArray("RYXB")%>;
	
	$(function(){
		dccffddbrxb = $('#dccffddbrxb').combobox({
	    	data : v_xb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    dccfyyzz = $('#dccfyyzz').combobox({
	    	data : v_zzzm,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		if($("#dcxzcfjdsid").val()==""){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		}
	});

	//保存
	function mysave(){
		var url= basePath+'pub/wsgldy/saveZfwsdcxzcfjds29?sjordn=<%=sjws%>';
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
			 		$("#dcxzcfjdsid").val(result.dcxzcfjdsid);
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
	
	
	function myprint(){
	    var obj = new Object();
	    var v_ajdjid = $("#ajdjid").val();
	    var v_dcxzcfjdsid = $("#dcxzcfjdsid").val();

	    if(<%=sjws%>=='2'){
	    var url="<%=basePath%>/common/sjb/getajdjDocumentsHtml?ajdjid="
			 	+v_ajdjid+"&dcxzcfjdsid="+v_dcxzcfjdsid+"&type="+'7'+"&time="+new Date().getMilliseconds();
	    self.location=url; 
	    }else{
			var url="<%=basePath%>pub/wsgldy/Zfwsdcxzcfjds29IndexPrint?ajdjid="
				+v_ajdjid+"&dcxzcfjdsid="+v_dcxzcfjdsid+"&time="+new Date().getMilliseconds();
		    //创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : ' ',
				width : 700,
				height : 650,
				url : url
		}); 
	    }
	    
	}	
	
		//保存模板
	function saveAsMoban(){
	    var obj = new Object();
	    var v_ajdjid=$("#ajdjid").val();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    var v_dcxzcfjdsid=$("#dcxzcfjdsid").val();
	    
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    }
	    
	    if (v_dcxzcfjdsid==null || v_dcxzcfjdsid=="" || v_dcxzcfjdsid.length== 0){
	    	alert('请先保存，保存成功后，才能另存为模板');
	    	return false;
	    }
	    
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
			+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
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
	    
		var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
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
					GloballoadData(retdata);
				} else {
					parent.$.messager.alert('提示','查询模板信息失败：'+result.msg,'error');
			    }	
				parent.$.messager.progress('close');
			}, 'json');
		 }
		})
	}
	// 违反的法律法规
	function myselectWfflfg(){
		if (v_sjws!=null && v_sjws=='2'){
		    var url="<%=basePath%>/common/sjb/getflfg?time="+new Date().getMilliseconds();
	          self.location=url; 			
		}else{
		   	var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
		   	var dialog = parent.sy.modalDialog({
		   		title : '',
				param : {
				singleSelect : "true",
				tabname : "zfwsdcxzcfjds29",
				colname : "dcxzcfjdswfflfg",
				getflfg : "1",
				a : new Date().getMilliseconds()
				},
				width : 800,
				height : 600,
				url : url
		   	},function (dialogID){
		   		var v_retStr = sy.getWinRet(dialogID);
				
				sy.removeWinRet(dialogID);//不可缺少
				
				if (v_retStr!=null && v_retStr.length>0){
		   		 for (var k=0;k<=v_retStr.length-1;k++){
		     	 var myrow=v_retStr[k];
		     	 $("#dccfwfgd").val(myrow.avalue);    
		    }}; 
		   	})
		}	    
	}	
	// 依据的法律法规
	function myselectYjflfg(){
		if (v_sjws!=null && v_sjws=='2'){
		    var url="<%=basePath%>/common/sjb/getyjflfg?time="+new Date().getMilliseconds();
	          self.location=url; 			
		}else{		
			var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
			var dialog = parent.sy.modalDialog({
				title : '',
				param : {
				singleSelect : "true",
				tabname : "zfwsdcxzcfjds29",
				colname : "dcxzcfjdsyjflfg",
				getflfg : "1",
				a : new Date().getMilliseconds()
				},
				width : 800,
				height : 600,
				url : url
			},function (dialogID){
				var v_retStr = sy.getWinRet(dialogID);
				
				sy.removeWinRet(dialogID);//不可缺少
				
				if (v_retStr!=null && v_retStr.length>0){
		    		for (var k=0;k<=v_retStr.length-1;k++){
		    		var myrow=v_retStr[k];
		      		$("#dccfyjgd").val(myrow.avalue); //公司名称   
		    }};  
			})
		}
	}
	
	// 违反的法律法规
	function myselectWfflfg2(str){
	      $("#dccfwfgd").val(str);
	}	
	// 违反依据法律法规
	function myselectYjfjfg2(str){
	      $("#dccfyjgd").val(str);    
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
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
	    <input id="userid" name="userid" type="hidden" value="<%=v_userid%>"/>
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>" />
		<input id="dcxzcfjdsid" name="dcxzcfjdsid" type="hidden"
			value="${mybean.dcxzcfjdsid}" />
			
			<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
			<span class="s1">当场行政处罚决定书</span>
			</p>
			
			<p class="p3 tr">
			<span class="s2"><input id="dccfwsbh" name="dccfwsbh"
				style="width:300px;" value="${mybean.dccfwsbh}" /></span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
			<p class="p4">
			<span class="s2">当事人：</span>
			<span class="s3"><input id="dccfdsr" name="dccfdsr"
				style="width:580px;" value="${mybean.dccfdsr}" /></span>
			</p>
			<p class="p4">
			<span class="s2">营业执照或其他资质证明：</span>
			<span class="s3"><input id="dccfyyzz" name="dccfyyzz"
				style="width:200px;" value="${mybean.dccfyyzz}" /></span>
			<span class="s2">编号：</span>
			<span class="s3"><input id="dccfyyzzbh" name="dccfyyzzbh"
				style="width:200px;" value="${mybean.dccfyyzzbh}" /></span>
			</p>
			<p class="p4">
			<span class="s2">组织机构代码（身份证）号：</span>
			<span class="s3"><input id="dccfzzjgdm" name="dccfzzjgdm"
				style="width:500px;" value="${mybean.dccfzzjgdm}" 
				class="easyui-validatebox" validtype="integer"/></span>
			</p>
			<p class="p4">
			<span class="s2">法定代表人（负责人）：</span>
			<span class="s3"><input id="dccffddbr" name="dccffddbr"
				style="width:200px;" value="${mybean.dccffddbr}" /></span>
			<span class="s2">性别：</span>
			<span class="s3"><input id="dccffddbrxb" name="dccffddbrxb"
				style="width:100px;" value="${mybean.dccffddbrxb}" /></span>
				<span class="s2">职务：</span>
			<span class="s3"><input id="dccffddbrzw" name="dccffddbrzw"
				style="width:150px;" value="${mybean.dccffddbrzw}" /></span>
			</p>
			<p class="p4">
			<span class="s2">地址（住址）：</span>
			<span class="s3"><input id="dccfdz" name="dccfdz"
				style="width:300px;" value="${mybean.dccfdz}" /></span>
			<span class="s2">邮编：</span>
			<span class="s3"><input id="dccfyb" name="dccfyb"
				style="width:100px;" value="${mybean.dccfyb}" 
				class="easyui-validatebox" validtype="postalcode"/></span>
			<span class="s2">电话：</span>
			<span class="s3"><input id="dccfdh" name="dccfdh"
				style="width:100px;" value="${mybean.dccfdh}" 
				class="easyui-validatebox" validtype="phoneAndMobile "/></span>
			</p>
			<p class="p5">
			<span class="s2">    你（单位）</span>
			<span class="s3"><input id="dccfwfxw" name="dccfwfxw"
				style="width:400px;" value="${mybean.dccfwfxw}" /></span>
			<span class="s2">（违法行为）违反了</span>
			<span class="s3"><input id="dccfwfgd" name="dccfwfgd"
				style="width:400px;" value="${mybean.dccfwfgd}" />
				<input type="button" style="color:blue;" value="选择" onclick="myselectWfflfg()">
			</span>
			<span class="s2">（法律法规名称及条、款、项）的规定。依据</span>
			<span class="s3"><input id="dccfyjgd" name="dccfyjgd"
				style="width:400px;" value="${mybean.dccfyjgd}" />
				<input type="button" style="color:blue;" value="选择" onclick="myselectYjflfg()">
			</span>
			<span class="s2">（法律法规名称及条、款、项）的规定，决定对你（单位）给予以下行政处罚：</span>
			<span class="s3"><textarea id="dccfxzcf1" name="dccfxzcf1"
				style="width: 720px;height: 80px;">${mybean.dccfxzcf1}</textarea>
			</span>
			</p>
			<p class="p4"></p>
			<p class="p5">
			<span class="s2">罚款按以下方式缴纳：</span>
			</p>
			<p class="p5">
			<span class="s2">1.符合《中华人民共和国行政处罚法》第四十七条规定情形的，可以当场缴纳。</span>
			</p>
			<p class="p5">
			<span class="s2">2.自即日起15日内将罚款交到</span>
			<span class="s3"><input id="fmkjkyh" name="fmkjkyh"
				style="width:100px;" value="${mybean.fmkjkyh}" /></span>
			<span class="s2">银行，逾期不缴纳罚款的，根据《中华人民共和国行政处罚法》第五十一条第（一）项的规定，
				每日按罚款数额的3%加处罚款，并依法申请人民法院强制执行。</span>
			</p>
			<p class="p5">
			<span class="s2">如不服本处罚决定，可在接到本处罚决定书之日起60日内向</span>
			<span class="s3"><input id="sjspypjdglj" name="sjspypjdglj"
				style="width:200px;" value="${mybean.sjspypjdglj}" /></span>
			<span class="s2">（上一级）食品药品监督管理局或者</span>
			<span class="s3"><input id="sjrmzf" name="sjrmzf"
				style="width:200px;" value="${mybean.sjrmzf}" /></span>
			<span class="s2">人民政府申请行政复议，也可以于6个月内依法向
			<span class="s3"><input id="sjrmfy" name="sjrmfy"
				style="width:200px;" value="${mybean.sjrmfy}" /></span>
			<span class="s2">人民法院提起行政诉讼。</span>
			</p>
			<p class="p5">
			<span class="s2">处罚地点:<input id="dccfdd" name="dccfdd"
				style="width:280px;" value="${mybean.dccfdd}" /></span>
			</p>
			<p class="p5">
			<span class="s2">当事人：</span>
			<span class="s3"><input id="dccfdsrqz" name="dccfdsrqz"
				style="width:150px;" value="${mybean.dccfdsrqz}" /></span>（签字）                  
			<span class="s2">执法人员：</span>
			<span class="s3"><input id="dccfzfryqz" name="dccfzfryqz"
				style="width:150px;" value="${mybean.dccfzfryqz}" /></span>
			<span class="s2">、</span>
			<span class="s3"><input id="dccfzfryqz2" name="dccfzfryqz2"
				style="width:150px;" value="${mybean.dccfzfryqz2}" /></span>（签字）
			</p>
			<p class="p5">
			<span class="s2">&times;年&times;月&times;日:<input
					name="dccfdsrqzrq" id="dccfdsrqzrq"	class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 175px;" value="${mybean.dccfdsrqzrq}" /></span>
			</p>
			<p class="p6 tr">
			<span class="s2"> （公    章）</span>
			</p>
			<p class="p6 tr">
			<span class="s2">&times;年&times;月&times;日:<input
					name="dccfgzrq" id="dccfgzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 175px;" value="${mybean.dccfgzrq}" /></span>
			</p>
			<p class="p8">
			<span class="s2">注：存档（1），必要时交</span>
			<span class="s3"><input id="qzzzrmfy" name="qzzzrmfy"
				style="width:200px;" value="${mybean.qzzzrmfy}" /></span>
			<span class="s2">人民法院强制执行。</span>
			</p>
			<p class="p9"></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
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
			        
			              
			           <% if (v_canbaocun==null ||"".equals(v_canbaocun) || "1".equals(v_canbaocun)) {
			             if (sjws!=null && !"2".equals(sjws)){
			           %> 
			           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
			           <a href="javascript:void(0);" id="lcwmbBtn" class="easyui-linkbutton" onclick="saveAsMoban();"
			              data-options="iconCls:'ext-icon-book_add'">另存为模板</a>
			              
			           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
			           <a href="javascript:void(0);" id="lcwBtn" class="easyui-linkbutton" onclick="tqMoban();"
			              data-options="iconCls:'ext-icon-book_go'">从模板提取</a>
			            <%}
			           }
			            %>
			            
			           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
			           <% if (sjws!=null && !"2".equals(sjws)){ %>	           	           	                
			           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeAndRefreshWindow();"
			           data-options="iconCls:'icon-back'">关闭</a>
			            <%
			             }
			            %>			           
					</td>
				</tr>
			</table>
		</div>

	</form>
</body>
</html>
