<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwscfkyjds12DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}

	//安监登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	//执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	//附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	//第12个文书 查封扣押决定书
	Zfwscfkyjds12DTO dto = new Zfwscfkyjds12DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwscfkyjds12DTO) request.getAttribute("mybean");
	}
	String sjws=null;
	if (request.getAttribute("sjws") != null) {
		sjws= (String) request.getAttribute("sjws");
	}
	String v_userid=StringHelper.showNull2Empty(request.getParameter("userid"));
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);
 $(function() {
	var v_cfkyjdsid=$("#cfkyjdsid").val();
	if (v_cfkyjdsid==null || v_cfkyjdsid=="" || v_cfkyjdsid.length== 0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	}
	// 设置默认扣押期限
	var cfkyksrq = $("#cfkyksrq").val(); // 查封扣押开始日期
	var cfkyjsrq = $("#cfkyjsrq").val(); // 查封扣押结束日期
	var currDate = new Date(); // 当前日期
	var iToDay = currDate.getDate(); 
	var iToMon = currDate.getMonth();
	var iToYear = currDate.getFullYear();
	if (cfkyksrq==null || cfkyksrq=="" || cfkyksrq.length== 0) {
		$("#cfkyksrq").val(new Date(iToYear,iToMon,(iToDay+1)).format("yyyy-MM-dd"));
		$("#cfkyjsrq").val(new Date(iToYear,iToMon,(iToDay+31)).format("yyyy-MM-dd"));
	}
	if(<%=sjws%>=='2'){
		$("#lcwmbBtn").eq(0).hide();
		$("#lcwBtn").eq(0).hide();
		$("#BtnFanhui").eq(0).hide(); 
		$("#sel").eq(0).hide(); 
    }
}); 
	function mysave() {
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单url: basePath+'/pub/zfwslaspb/savezfwslaspb';
		parent.$.messager.progress({
			text : '正在提交....'
		});
		$('#myform').form(
			'submit',
			{
				url : basePath + '/pub/wsgldy/savezfwscfkyjds?sjordn=<%=sjws%>',
				onSubmit : function() {
					var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
					if (!isValid) {
						parent.$.messager.progress('close'); // 如果表单是无效的则隐藏进度条 
					}
					return isValid;
				},
				success : function(result) {
					parent.$.messager.progress('close');// 隐藏进度条  
					result = $.parseJSON(result);
					if (result.code == '0') {
						$("#cfkyjdsid").val(result.cfkyjdsid);
						$("#saveBtn").linkbutton('disable');
						$("#lcwmbBtn").linkbutton('enable');	
		 		  		$("#printBtn").linkbutton('enable');
				 		alert("保存成功！");
					} else {
						parent.$.messager.alert('提示', '保存失败：' + result.msg,
								'error');
					}
				}
			});
	}
function myprint(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_cfkyjdsid = $("#cfkyjdsid").val();
    var sjws = <%=sjws%>;
    if(sjws=='2'){
    	var url="<%=basePath%>/common/sjb/getajdjDocumentsHtml?ajdjid="
		 	+v_ajdjid+"&cfkyjdsid="+v_cfkyjdsid+"&type="+'2'+"&time="+new Date().getMilliseconds();
		self.location=url; 
    }else{ 
		var url="<%=basePath%>pub/wsgldy/zfwscfkyjdsPrintIndex";
	    var dialog = parent.sy.modalDialog({
	    	title : '打印',
			param : {
				cfkyjdsid : v_cfkyjdsid,
				ajdjid : v_ajdjid,
				time : new Date().getMilliseconds()
			},
			width : 700,
			height : 650,
			url : url
	    },function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});
	}
}
//另存为模板
function saveAsMoban(){
	var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_zfwsdmz=$("#zfwsdmz").val();
    var v_cfkyjdsid=$("#cfkyjdsid").val();
    
    if (v_cfkyjdsid==null || v_cfkyjdsid=="" || v_cfkyjdsid.length== 0){
    	alert('文书还没有保存为空，不能另存为模板');
    	return false;
    } 
	var url = basePath + "pub/wsgldy/zfwsmobanIndex";
	//创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		param : {
			ajdjid : v_ajdjid,
			zfwsdmz : v_zfwsdmz,
			time : new Date().getMilliseconds()
		},
		width : 650,
		height : 300,
		url : url
	},function(dialogID) {
	    sy.removeWinRet(dialogID);//不可缺少
	});
}

//提取模板

function tqMoban(){
    var obj = new Object();
    var v_zfwsdmz=$("#zfwsdmz").val();
    var url = basePath + "pub/wsgldy/zfwsmobantqIndex";
    //创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		param : {
			zfwsdmmc : "<%=v_fjcsdmmc%>",
			zfwsdmz : v_zfwsdmz,
			time : new Date().getMilliseconds()
		},
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
    });
}
  //从单位信息表中读取
function myselectPcyzdsz(){
	var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
	var dialog = parent.sy.modalDialog({
		title : '从单位信息表中读取',
		param : {
			singleSelect : "true",
			tabname : "cfkyjds12",
			colname : "cfkyflmc",
			a : new Date().getMilliseconds()
		},
		width : 800,
		height : 600,
		url : url
	},function (dialogID){
		var obj = sy.getWinRet(dialogID);
		if (obj!=null && obj.length>0){
	    	for (var k=0;k<=obj.length-1;k++){
      			var myrow=obj[k];
      			$("#cfkyflmc").val(myrow.avalue); //查封扣押法律名称   
    		}
    	}    
    	sy.removeWinRet(dialogID);//不可缺少
	});
}	

// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();
		s.type = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}	
	
</script>
<style type="text/css">
.b1 {
	white-space-collapsing: preserve;
}

.b2 {
	margin: 1.0in 1.25in 1.0in 1.25in;
}

.s1 {
	font-weight: bold;
	color: black;
}

.s2 {
	color: black;
}

.s3 {
	color: black;
}

.p1 {
	text-align: center;
	hyphenate: auto;
	font-family: 黑体;
	font-size: 16pt;
}

.p2 {
	text-align: center;
	hyphenate: auto;
	font-family: 宋体;
	font-size: 22pt;
}

.p3 {
	margin-top: 0.108333334in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p4 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-indent: 0.29166666in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
	line-height: 1.5em;
}

.p6 {
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-indent: 0.29166666in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 4.0833335in;
	margin-right: 0.875in;
	margin-top: 0.108333334in;
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-indent: 4.0833335in;
	margin-right: 0.29166666in;
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p10 {
	text-indent: 3.9375in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p11 {
	text-indent: 2.84375in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p12 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto">
	<body class="b1 b2 zfwsbackgroundcolor">
		<form id="myform" method="post">
		    <input id="userid" name="userid" type="hidden" value="<%=v_userid%>"/>
			<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
			<input id="cfkyjdsid" name="cfkyjdsid" type="hidden" value="${mybean.cfkyjdsid}"/>
			<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">查封（扣押）决定书</span>
			</p>
			<div align="right">
				<p class="p3"><span class="s2">                               
				<input type="text" id="cfkywsbh" name="cfkywsbh" style="width: 260px;text-align: right;"
				 value="${mybean.cfkywsbh}"/>
				</span>
				</p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4">
				<span class="s2">当事人：</span>
				<span class="s3">
				<input  id="cfkydsr" name="cfkydsr" style="width: 260px;"
						value="${mybean.cfkydsr}" /> 
  				 </span>
				 <span	class="s2">法定代表人（负责人）：</span>
					<span class="s3"> 
					<input  id="cfkyfddbr" name="cfkyfddbr" style="width: 260px;"
						value="${mybean.cfkyfddbr}" /> 
					</span>
			</p>
			<p class="p4">
				<span class="s2">地 址：</span>
				<span class="s3">
				<input  id="cfkydz" name="cfkydz" style="width: 270px;"
						value="${mybean.cfkydz}" /> 
				 </span>
				<span
					class="s2">联系方式：</span>
					<span class="s3"> 
					<input  id="cfkylxfs" name="cfkylxfs" style="width: 260px;"
						value="${mybean.cfkylxfs}" class="easyui-validatebox" validtype="phoneAndMobile" /> 
					</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p5">
			  <span class="s2">经查，你单位（人）存在</span>
			  <span class="s3"> 
				<input id="cfkysxczwt" name="cfkysxczwt" style="width: 200px;"
				   value="${mybean.cfkysxczwt}" /> 
			  </span>
			  <span class="s2">的违法行为，依据</span>
			   <span class="s3"><input id="cfkyflmc" name="cfkyflmc" style="width: 200px;"
				   value="${mybean.cfkyflmc}" /></span>
				   <input type="button" style="color:blue;" id="sel" value="选择" onclick="myselectPcyzdsz();">
			  <span class="s2">（法律法规依据名称及条、款、项具体内容）的规定，我局决定对你单位（人）的有关物品/场所予以查封（扣押）（见《查封（扣押）物品清单》）。查封（扣押）期限为</span>
			   <span class="s3"> 
					<input id="cfkyflt" name="cfkyflt" style="width: 100px;"
						    value="${mybean.cfkyflt}" /> 
				</span>
			  <span class="s2">日，自</span>
			  <span class="s3">
				<input	name="cfkyksrq" id="cfkyksrq" class="Wdate"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 175px;" value="${mybean.cfkyksrq}">
				 年 月日至</span>
				 <span class="s3">
				 <input	name="cfkyjsrq" id="cfkyjsrq" class="Wdate"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 175px;" value="${mybean.cfkyjsrq}">
				 年 月日</span>
              <span class="s2">止。如因检验（检测、检疫、鉴定）需要顺延期限的，或因情况复杂依法需要延长期限的，我局将另行书面告知。在查封（扣押）期间，对查封扣押的场所、设施和财物，应当妥善保存，不得使用、销毁或者擅自转移。当事人不得擅自启封。</span>
			<p class="p7">
				<span class="s2">查封（扣押）物品保存地点/场所地点：
				<input id="cfkybcdd" name="cfkybcdd" style="width: 200px;"
				   value="${mybean.cfkybcdd}" /> 
				</span>
			</p>
			<p class="p7">
				<span class="s2">查封扣押物品保存条件：</span>
				<span class="s3"> 
				<input id="cfkybctj" name="cfkybctj" style="width: 300px;"
				   value="${mybean.cfkybctj}" /> 
				</span>
			</p>
			
			<p class="p7">
				<span class="s2">你单位（人）可以对本决定进行陈述和申辩。如不服本决定，可以自收到本决定书之日起六十日内向</span>
				<span class="s3"><input id="cfkyyfxsyj" name="cfkyyfxsyj" style="width: 100px;" value="${mybean.cfkyyfxsyj}" /></span>
				 <span	class="s2">行政复议受理中心或者</span>
				<span class="s3"><input id="cfkyyfxrmzf" name="cfkyyfxrmzf" style="width: 100px;"value="${mybean.cfkyyfxrmzf}" /></span>
				<span class="s2">人民政府申请行政复议，也可以自收到本决定书之日起六个月内依法直接向</span>
				 <span class="s3"><input id="cfkyyfxrmfy" name="cfkyyfxrmfy" style="width: 100px;"value="${mybean.cfkyyfxrmfy}" /></span>
				 <span	class="s2">人民法院提起行政诉讼。 </span>
			</p>
			<p class="p7">
				<span class="s2">附件：</span>
				<span class="s3">
				<input id="cfkywpqdwsbh" name="cfkywpqdwsbh" style="width: 200px;"
				   value="${mybean.cfkywpqdwsbh}" />
				</span>
				<span class="s2">《查封（扣押）物品清单》</span>
			</p>
			<p class="p7"></p>
			<p class="p4"></p>
			<p class="p8">
				<span class="s2">（公 章）</span>
			</p>
			<p class="p9">
				<span class="s2">
				<input	name="cfkygzrq" id="cfkygzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					style="width: 175px;" value="${mybean.cfkygzrq}"> 年 月 日
				 </span>
			</p>
			<p class="p10"></p>
			<p class="p11"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p12"></p>
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
