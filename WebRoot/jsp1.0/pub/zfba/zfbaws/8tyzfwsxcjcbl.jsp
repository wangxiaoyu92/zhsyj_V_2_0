<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxcjcbl8DTO" %>
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
	// 执法案件执法文书对应表id
	String v_zfwsqtbid = StringHelper.showNull2Empty(request.getParameter("zfwsqtbid"));
	// 执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	// 附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	// 是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	// 现场检查笔录
	Zfwsxcjcbl8DTO dto = new Zfwsxcjcbl8DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwsxcjcbl8DTO) request.getAttribute("mybean");
    }
    String sjws=null;
    if (request.getAttribute("sjws") != null) {
    	sjws= (String)request.getAttribute("sjws");
    	System.out.print(sjws);
    }	
    String v_userid = StringHelper.showNull2Empty(request.getParameter("userid"));
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
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;
	font-size:22pt;}
.p3{text-indent:4.375in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;
	font-size:10pt;list-style: 1.5em;}
.p5{text-indent:0.29166666in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;line-height: 1.5em;}
.p6{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-indent:-3.4368055in;margin-left:3.4368055in;margin-top:0.108333334in;
	text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
</style>
<title>现场检查笔录</title>
<meta content="X" name="author">

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);
var mygrid;
// 监督检查类别
var v_dcbljdjclb = <%=SysmanageUtil.getAa10toJsonArray("DCBLJDJCLB")%>;
$(function() {
	var v_xcjcblid = $("#xcjcblid").val();
	if (v_xcjcblid==null || v_xcjcblid=="" || v_xcjcblid.length== 0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	}
	
	v_dcbljdjclb = $('#dcbljdjclb').combobox({
		data : v_dcbljdjclb,      
		valueField : 'id',   
		textField : 'text',
		required : false,
		editable : false,
		panelHeight : 'auto' 
	});
	if(<%=sjws%>=='2'){
		$("#lcwmbBtn").eq(0).hide();
		$("#lcwBtn").eq(0).hide();
		$("#BtnFanhui").eq(0).hide(); 
    }
});
/**
 * 保存
 **/
function mysave(){
		// 判断检查开始时间与结束时间是否填写正确
		var startDate = $("#xcjcjcsjksrq").val();
		var endDate = $("#xcjcjcsjjsrq").val();
		if(startDate.length > 0 && endDate.length > 0){   
        	var startDateTemp = startDate.split(" ");   
      		var endDateTemp = endDate.split(" ");   
      		var arrStartDate = startDateTemp[0].split("-");   
      		var arrEndDate = endDateTemp[0].split("-");   
      		var arrStartTime = startDateTemp[1].split(":");   
      		var arrEndTime = endDateTemp[1].split(":");   
      		var allStartDate = new Date(arrStartDate[0],arrStartDate[1],arrStartDate[2],
      				arrStartTime[0],arrStartTime[1],arrStartTime[2]);   
      		var allEndDate = new Date(arrEndDate[0],arrEndDate[1],arrEndDate[2],arrEndTime[0],
      				arrEndTime[1],arrEndTime[2]);   
      		if(allStartDate.getTime() > allEndDate.getTime()){   
      			alert("请正确填写检查日期");
       			return;   
      		}
      	}
		var url= basePath+'/pub/wsgldy/saveZfwsxcjcbl?sjordn=<%=sjws%>';

		// 提交
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
	        	// 隐藏进度条
	        	parent.$.messager.progress('close');  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
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
 **/
function myprint(){
    var obj = new Object();
    var v_ajdjid = $("#ajdjid").val();
	var sjws = '<%=sjws%>';
    var xcjcid=$("#xcjcblid").val();
    if(sjws=='2'){
	    var url="<%=basePath%>/common/sjb/getajdjDocumentsHtml?ajdjid="
			 	+v_ajdjid+"&xcjcblid="+xcjcid+"&type="+'0'+"&time="+new Date().getMilliseconds();
	    self.location=url; 
    }else {
		var url = basePath + "pub/wsgldy/zfwsxcjcblPrintIndex";
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			param : {
				ajdjid : v_ajdjid,
				zfwsqtbid : xcjcid,
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
/**
 * 另存为模板
 */
function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid = $("#ajdjid").val();
    var v_zfwsdmz = $("#zfwsdmz").val();
    var v_xcjcblid = $("#xcjcblid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
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
/**
 * 从模板提取
 */
function tqMoban(){
    var v_zfwsdmz = $("#zfwsdmz").val();
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
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}
</script>

</head>
<div style="width: 210mm; margin: 0 auto">
    <body class="b1 b2 zfwsbackgroundcolor">
   
    <form id="myform" method="post">
        <input id="userid" name="userid" type="hidden" value="<%=v_userid%>"/>
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
		<input id="xcjcblid" name="xcjcblid" type="hidden" value="${mybean.xcjcblid}"/>
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">现场检查笔录</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">检查事由：</span>
			<span class="s3"><input type="text" id="ajdjay" name="ajdjay" 
				style="width: 700px;text-align: left;" value="${mybean.ajdjay}" /></span>
		</p>
		<p class="p4">
			<span class="s2">被检查单位（人）：</span>
			<span class="s3"><input type="text" id="commc" name="commc"  
				style="width: 650px;text-align: left;" value="${mybean.commc}" /></span>
		</p>
		<p class="p4">
			<span class="s2">检查地点：</span>
			<span class="s3"><input type="text" id="comdz" name="comdz" 
				style="width: 700px;text-align: left;" value="${mybean.comdz}" /></span>
		</p>
		<p class="p4">
			<span class="s2">法定代表人（负责人）：</span>
			<span class="s3"><input type="text" id="comfrhyz" name="comfrhyz" 
				style="width: 355px;text-align: left;"  value="${mybean.comfrhyz}" /></span>
			<span class="s2">联系方式：</span>
			<span class="s3"><input type="text" id="comyddh" name="comyddh" 
				style="width: 200px;text-align: left;" value="${mybean.comyddh}" /></span>
		</p>
		<p class="p4">
			<span class="s2">检查人：</span>
			<span class="s3"><input type="text" id="xcjcjcr" name="xcjcjcr" 
				style="width: 200px;text-align: left;" value="${mybean.xcjcjcr}"/></span>
			<span class="s2">记录人：</span>
			<span class="s3"><input type="text" id="cxjcjlr" name="cxjcjlr"
				style="width: 200px;text-align: left;" value="${mybean.cxjcjlr}"/></span>
			<span class="s2">监督检查类别：</span>
			<span class="s3"><input id="dcbljdjclb" name="dcbljdjclb"
				style="width: 135px" value="${mybean.dcbljdjclb}" /></span>
		</p>
		<p class="p4">
			<span class="s2">检查时间：</span>
			<span class="s3"><input name="xcjcjcsjksrq" id="xcjcjcsjksrq" 
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"  
				style="width: 340px;" value="${mybean.xcjcjcsjksrq}" >
			</span>
			<span class="s2">至</span>
			<span class="s3"><input name="xcjcjcsjjsrq" id="xcjcjcsjjsrq"  
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"  
				style="width: 340px;" value="${mybean.xcjcjcsjjsrq}" ></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">&nbsp;&nbsp;&nbsp;&nbsp;我们是</span>
			<span class="s3"><input type="text" id="spypjdgljmcqc" name="spypjdgljmcqc" 
				style="width: 200px;text-align: left;" value="${mybean.spypjdgljmcqc}"/></span>
			<span class="s2">的执法人员</span>
			<span class="s3"><input type="text" id="xcjczfry1" name="xcjczfry1" 
				style="width: 80px;text-align: left;" value="${mybean.xcjczfry1}"/></span>
			<span class="s2">、</span>
			<span class="s3"><input type="text" id="xcjczfry2" name="xcjczfry2" 
				style="width: 80px;text-align: left;" value="${mybean.xcjczfry2}"/></span>
			<!-- <span class="s2">，执法证件名称、</span> -->
			<span class="s2">，编号是：</span>
			<%-- <input type="text" id="zfzjmc" name="zfzjmc" 
				style="width: 120px;" value="${mybean.zfzjmc}"/>、 --%>
			<input type="text" id="xcjczfryzjbh1" name="xcjczfryzjbh1" 
				style="width: 100px;" value="${mybean.xcjczfryzjbh1}"/>、
			<input type="text" id="xcjczfryzjbh2" name="xcjczfryzjbh2" 
				style="width: 100px;" value="${mybean.xcjczfryzjbh2}"/>
			<span class="s2">，现依法向你出示，请你确认。</span>
		</p>
		<p class="p5">
			<span class="s2">我们在你单位</span>
			<span class="s3"><input id="cxjcptrzw" name="cxjcptrzw" style="width: 150px" 
				value="${mybean.cxjcptrzw}" /></span>
			<span class="s2">（职务）</span>
			<span class="s3"><input id="cxjcptrxm" name="cxjcptrxm" style="width: 80px" 
				value="${mybean.cxjcptrxm}" /></span>
			<span class="s2">（姓名）陪同下进行现场检查。依照法律规定，对于检查人员，有下列情形之一的，应当自行回避，你也有权申请检查人员回避：
			（1）系当事人或当事人的近亲属；（2）与本案有直接利害关系；（3）与当事人有其他关系，可能影响案件公正处理的。</span>
		</p>
		<p class="p5">
			<span class="s2">是否申请调查人员回避，是
			<input type="radio" name="xcjcsfsqhb" id="xcjcsfsqhb" value="1" 
			<% if (dto.getXcjcsfsqhb() != null && 
				"1".equals(dto.getXcjcsfsqhb())) {%>
			checked="checked"<%}%>>，
			否<input type="radio" name="xcjcsfsqhb" id="xcjcsfsqhb" value="0" 
			<% if ("0".equals(dto.getXcjcsfsqhb()) || 
				"".equals(dto.getXcjcsfsqhb())) {%>
			checked="checked"<%}%>>；
			签字：</span>
			<span class="s3"><input id="xcjcsfsqhbqz" name="xcjcsfsqhbqz" 
				style="width: 200px" value="${mybean.xcjcsfsqhbqz}" /></span>
		</p>
		<p class="p5">
			<span class="s2">现场检查记录： </span>
		</p>
		<textarea class="easyui-validatebox bbtextarea" id="xcjcbl" name="xcjcbl" 
			style="width: 770px;height: 200px;" >${mybean.xcjcbl}</textarea>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6">
			<span class="s2">被检查人：</span>
			<span class="s3"><input id="xcjcbjcr" name="xcjcbjcr" style="width: 150px" 
				value="${mybean.xcjcbjcr}"/></span> 
			<span class="s3"><%-- <input name="xcjcbjcrqzrq" id="xcjcbjcrqzrq" 
				class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
				style="width: 175px;" value="${mybean.xcjcbjcrqzrq}" > --%></span>
		</p>
		
		<p class="p6">
			<span class="s2">检查人：</span>
			<span class="s3"><input id="xcjczfry" name="xcjczfry" 
				style="width: 150px" value="${mybean.xcjczfry}"/></span>
			<span class="s3"><%-- <input name="xcjczfryqzrq" id="xcjczfryqzrq"
				class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
				style="width: 175px;" value="${mybean.xcjczfryqzrq}" > --%></span>
		</p>
		<p class="p6">
			<span class="s2">见证人：</span>
			<span class="s3"><input id="xcjcjzr" name="xcjcjzr" style="width: 160px" 
				value="${mybean.xcjcjzr}"/></span> 
			<span class="s3"><%-- <input name="xcjcjzrqzrq" id="xcjcjzrqzrq"
				class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
				style="width: 175px;" value="${mybean.xcjcjzrqzrq}" > --%></span>
		</p>
		<p class="p6">
			<span class="s2">记录人：</span>
			<span class="s3"><input id="xcjcjlrqz" name="xcjcjlrqz" style="width: 160px" 
				value="${mybean.xcjcjlrqz}"/></span> 
			<span class="s3"><input name="xcjcjlrqzrq" id="xcjcjlrqzrq"
				class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  
				style="width: 175px;" value="${mybean.xcjcjlrqzrq}" ></span>
		</p>
	<p class="p8"></p>
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
