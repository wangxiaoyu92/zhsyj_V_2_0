<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.askj.zfba.dto.Zfwstzgzs22DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwstzgzs22DTO dto = new Zfwstzgzs22DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwstzgzs22DTO) request.getAttribute("mybean");
	}
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>听证告知书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<style type="text/css">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{font-weight:bold;}
.s3{color:black;}
.s4{color:red;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.06944445in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-right:0.65625in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:3.7916667in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-indent:0.29166666in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
</style>

<script type="text/javascript">
	var layer;
var s = new Object();   
s.type = "";   //设为空不刷新父页面
window.returnValue = s;  
var mygrid;
var dc; // 违法行为等次
var v_dc = <%=SysmanageUtil.getAa10toJsonArray("WFXWDC")%>;
	$(function(){
		layui.use('layer',function(){
			layer =layui.layer;
		});
		dc = $("#tzgzwfxwdc").combobox({
	    	data : v_dc,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    var v_tzgzsid = $("#tzgzsid").val();
		if(v_tzgzsid==null || v_tzgzsid=="" || v_tzgzsid.length== 0){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		} else {
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		}
	});

	//保存
	function mysave(){
		var url= basePath+'pub/wsgldy/saveZfwstzgzs22';
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
			 		$("#tzgzsid").val(result.tzgzsid);
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
		    var obj = new Object();
		    var v_zfwslydjid=$("#ajdjid").val();
		    var v_tzgzsid = $("#tzgzsid").val();
			var url="<%=basePath%>pub/wsgldy/Zfwstzgzs22IndexPrint?ajdjid="
				+v_zfwslydjid+"&tzgzsid="+v_tzgzsid+"&time="+new Date().getMilliseconds();

		//创建模态窗口
		parent.sy.modalDialog({
			title:'打印',
			area:['100%','100%']
			,content :url
			,offset:'0px'
			,btn:['关闭']
		});
	}
		//保存模板
	function saveAsMoban(){
	    var obj = new Object();
	    var v_ajdjid=$("#ajdjid").val();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    var v_tzgzsid=$("#tzgzsid").val();
	    
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    }
	    
	    if (v_tzgzsid==null || v_tzgzsid=="" || v_tzgzsid.length== 0){
	    	alert('请先保存，保存成功后，才能另存为模板');
	    	return false;
	    }
	    
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
			+v_ajdjid+"&tzgzsid="+v_tzgzsid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
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
	
	//提取模板
	function tqMoban(){
	    var obj = new Object();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    
		var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
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
	
	// 违反的法律法规
	function myselectWfflfg(){
		var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
		//创建模态窗口
		parent.sy.modalDialog({
			title:'法律法规',
			area: ['100%', '100%']
			, content: url
			, param: {
				singleSelect : "true",
				tabname : "zfwstzgzs22",
				colname : "tzgzwfflfg",
				a : new Date().getMilliseconds()
			}
		},function (dialogID){
			var v_retStr = sy.getWinRet(dialogID);

			sy.removeWinRet(dialogID);//不可缺少

			if (v_retStr!=null && v_retStr.length>0){
				for (var k=0;k<=v_retStr.length-1;k++){
					var myrow=v_retStr[k];
					$("#tzgzwfflfg").val(myrow.avalue); //公司名称
				}};
		});
	}	
	// 依据的法律法规
	function myselectYjflfg(){
		var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
		//创建模态窗口
		parent.sy.modalDialog({
			title:'法律法规依据',
			area: ['100%', '100%']
			, content: url
			, param: {
				singleSelect : "true",
				tabname : "zfwstzgzs22",
				colname : "tzgzyjflfg",
				a : new Date().getMilliseconds()
			}
		},function (dialogID){
			var v_retStr = sy.getWinRet(dialogID);

			sy.removeWinRet(dialogID);//不可缺少

			if (v_retStr!=null && v_retStr.length>0){
				for (var k=0;k<=v_retStr.length-1;k++){
					var myrow=v_retStr[k];
					$("#tzgzcfyjyzgd").val(myrow.avalue); //公司名称
				}};
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
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>" />
		<input id="tzgzsid" name="tzgzsid" type="hidden" value="${mybean.tzgzsid}" />
		<p class="p1">
			<span class="s1"><input id="xzjgmc" name="xzjgmc"
					style="width:200px;" value="${mybean.xzjgmc}" /></span>
		</p>
		<p class="p2">
			<span class="s2">听证告知书</span>
		</p>
		<div align="right">
			<p class="p3">
				<span class="s3"><input id="tzgzwsbh" name="tzgzwsbh"
					style="width:200px;" value="${mybean.tzgzwsbh}" />
				</span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
			<span class="s3"><input id="tzgzdsr" name="tzgzdsr"
				style="width:200px;" value="${mybean.tzgzdsr}" />：</span>
		</p>
		<p class="p5">
			<span>我局于</span>
			<span><input name="tzgzslasj" id="tzgzslasj" class="Wdate" style="width: 150px;"value="${mybean.tzgzslasj}"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></span>
			<span>&times;年&times;月&times;日对</span>
			<span><input id="tzgzsay" name="tzgzsay"
				style="width:300px;" value="${mybean.tzgzsay}" /></span>
			<span>（案由）立案调查。经查，你（单位）</span>
			<span><input id="tzgzwfxwms" name="tzgzwfxwms"
					style="width:700px;" value="${mybean.tzgzwfxwms}" /></span>
			<span>（陈述违法事实。载明违法行为发生的时间、地点、情节等内容）。上述行为涉嫌违反了</span>
			<span><input id="tzgzwfflfg" name="tzgzwfflfg"
				style="width:500px;" value="${mybean.tzgzwfflfg}" />
				<input type="button" style="color:blue;" value="选择" onclick="myselectWfflfg();"></span>
			<span>（法律法规依据名称及条、款、项具体内容）的规定。</span>
			<textarea id="tzgzszmnr" name="tzgzszmnr" style="width: 800px;height: 50px;"
					>${mybean.tzgzszmnr}</textarea>
			<span>（列举证据形式，阐述证据所要证明的内容）。</span>
		</p>
		<p class="p5">
			<span>根据你（单位）违法行为的事实、性质、情节、社会危害程度和相关证据，参照</span>
			<span>《</span>
			<span><input id="czxzcfclbz" name="czxzcfclbz"
				style="width:200px;" value="${mybean.czxzcfclbz}" /></span>
			<span>法（条例、办法）行政处罚裁量标准》，你（单位）的违法行为</span>
			<span style="text-indent: 0in;"><input id="tzgzwfxwdc" name="tzgzwfxwdc" 
				style="width:150px;" value="${mybean.tzgzwfxwdc}"/></span>
			<span>（轻微、一般、严重或者特别严重）。依据</span>
			<span><input id="tzgzcfyjyzgd" name="tzgzcfyjyzgd"
				style="width:500px;" value="${mybean.tzgzcfyjyzgd}" />
				<input type="button" style="color:blue;" value="选择" onclick="myselectYjflfg();"></span>
			<span>（法律法规依据名称及条、款、项具体内容）的规定，我局拟对你（单位）作出</span>
			<textarea id="tzgzxzcf" name="tzgzxzcf" style="width: 800px;height: 100px;"
					>${mybean.tzgzxzcf}</textarea>
			<span>行政处罚。</span>
		</p>
		<p class="p5">
			<span>依据《中华人民共和国行政处罚法》第四十二条第一款规定，
			你（单位）有权要求举行听证。如你（单位）要求听证，应当自收到本告知书之日起3日内向本机关提出申请。
			逾期不申请听证的，视为你(单位)放弃听证权利。</span>
		</p>
		<div align="right">
			<p class="p7">
				<span class="s3">（公 章）</span>
			</p>
			<p class="p7">
				<span class="s3">&times;年&times;月&times;日<input
					name="gzgzgzrq" id="gzgzgzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 175px;" value="${mybean.gzgzgzrq}" />
				</span>
			</p>
		</div>
		<p class="p9"></p>
		<p class="p6"></p>
		<p class="p10">
			<span>行政机关地址：</span>
			<span><input id="gzgzdz" name="gzgzdz"
					style="width:200px;" value="${mybean.gzgzdz}"/></span> 
			<span>邮政编码：</span>
			<span><input id="gzgzyzbm" name="gzgzyzbm"
					class="easyui-validatebox" validtype="postalcode"
					style="width:200px;" value="${mybean.gzgzyzbm}"/></span>
		</p>
		<p class="p10">
			<span>行政机关联系人：</span>
			<span><input id="gzgzlxr" name="gzgzlxr"
					style="width:200px;" value="${mybean.gzgzlxr}"/></span>
			<span>联系电话：</span>
			<span><input id="gzgzlxdh" name="gzgzlxdh"
					class="easyui-validatebox" validtype="phoneAndMobile"
					style="width:200px;" value="${mybean.gzgzlxdh}"/></span>
		</p>
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
				</tr>
			</table>
		</div>
	</form>
</body>
</div>
</html>
