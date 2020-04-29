<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%@ page import="com.askj.zfba.dto.Zfwstzyjs25DTO"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwstzyjs25DTO dto = new Zfwstzyjs25DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwstzyjs25DTO)request.getAttribute("mybean");
	}
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
	
	// 听证意见书主持人签字
    boolean v_tzyjs_tzzcrqz = SysmanageUtil.isExistsFuncByBizid("tzyjs_tzzcrqz");
	String v_tzyjs_tzzcrqz_readonly = "";
	String v_tzyjs_tzzcrqz_disable = "";
	if (!v_tzyjs_tzzcrqz){
		v_tzyjs_tzzcrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
		v_tzyjs_tzzcrqz_disable = "disabled='disabled'";		
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
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:2.6388888in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.t1{text-align:right;}
</style>
<title>听证意见书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var layer;
var s = new Object();   
s.type = "";   //设为空不刷新父页面
window.returnValue = s;  
var mygrid;
	
	$(function(){
		layui.use('layer',function(){
			layer=layui.layer;
		});
		if($("#tzyjsid").val()==""){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		}
	});

	//保存
	function mysave(){
		var url= basePath+'pub/wsgldy/saveZfwstzyjs25';
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
			 		$("#tzyjsid").val(result.tzyjsid);
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
		    var tzyjsid = $("#tzyjsid").val();
			var url="<%=basePath%>pub/wsgldy/Zfwstzyjs25IndexPrint?ajdjid="
				+v_zfwslydjid+"&tzyjsid="+tzyjsid+"&time="+new Date().getMilliseconds();

		//创建模态窗口
		parent.sy.modalDialog({
			title:'打印',
			area : ['100%', '100%']
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
	    var v_tzyjsid=$("#tzyjsid").val();
	    
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    }
	    
	    if (v_tzyjsid==null || v_tzyjsid=="" || v_tzyjsid.length== 0){
	    	alert('请先保存，保存成功后，才能另存为模板');
	    	return false;
	    }
	    
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
			+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();

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
	
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";      
		sy.setWinRet(s);
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
</script>
</head>
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>" />
		<input id="tzyjsid" name="tzyjsid" type="hidden"
			value="${mybean.tzyjsid}" />
			<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
			<span class="s1">听证意见书</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
			<p class="p3">
			<span class="s2">案 由：<input id="ajdjay" name="ajdjay" 
				style="width:500px;" value="${mybean.ajdjay}" /></span>
			</p>
			<p class="p4">
			<span class="s2">当事人：<input id="tzyjdsr" name="tzyjdsr" 
				style="width:200px;" value="${mybean.tzyjdsr}" /></span>
			<span class="s2">法定代表人（负责人）：<input id="tzyjfddbr" name="tzyjfddbr" 
				style="width:200px;" value="${mybean.tzyjfddbr}" /></span>
			</p>
			<p class="p4">
			<span class="s2">听证时间：<input name="tzyjtzkssj" id="tzyjtzkssj"
					class="Wdate" style="width: 140px;" 
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
					value="${mybean.tzyjtzkssj}"/>至<input
					name="tzyjtzjssj" id="tzyjtzjssj"
					class="Wdate" style="width: 140px;" 
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
					value="${mybean.tzyjtzjssj}"/></span>
			</p>
			<p class="p4">
			<span class="s2">听证主持人：<input id="tzyjtzzcr" name="tzyjtzzcr" 
				style="width:200px;" value="${mybean.tzyjtzzcr}" /></span>                             
			<span class="s2">听证方式：<input id="tzyjtzfs" name="tzyjtzfs" style="width:200px;" 
				value="${mybean.tzyjtzfs}" /></span>
			</p>
			<p class="p5">
			<span class="s2">案件基本情况：<br/>
			<textarea id="tzyjajjbqk" name="tzyjajjbqk"
					style="width: 800px;height: 150px;">${mybean.tzyjajjbqk}</textarea></span>
			</p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5">
			<span class="s2">申请人主要理由：<br/>
			<textarea id="tzyjsqrzyly" name="tzyjsqrzyly"
					style="width: 800px;height: 150px;">${mybean.tzyjsqrzyly}</textarea></span>
			</p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5">
			<span class="s2">听证意见：<br/>
			<textarea id="tzyj" name="tzyj"
					style="width: 800px;height: 150px;">${mybean.tzyj}</textarea></span>
			</p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p6"></p>
			<p class="t1">
			<span class="s2">听证主持人签字：<input id="tzyjzcrqz" name="tzyjzcrqz" <%=v_tzyjs_tzzcrqz_readonly %>
				style="width:200px;" value="${mybean.tzyjzcrqz}" />  </span>
			</p>
			<p class="t1">
			<span class="s2">&times;年&times;月&times;日:<input name="tzyjzcrqzrq" id="tzyjzcrqzrq"
					class="Wdate" style="width: 175px;" value="${mybean.tzyjzcrqzrq}" <%=v_tzyjs_tzzcrqz_disable %>
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" /></span>
			</p>
			<p class="p7"></p>
			<p class="p8"></p>
		</div>
		</div>
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
</html>
