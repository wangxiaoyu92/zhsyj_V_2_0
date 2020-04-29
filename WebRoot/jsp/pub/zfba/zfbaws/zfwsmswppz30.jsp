<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.askj.zfba.dto.Zfwsmswppz30DTO"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}

	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	//执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	//附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	// 没收物品处理清单
	Zfwsmswppz30DTO dto = new Zfwsmswppz30DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsmswppz30DTO) request.getAttribute("mybean");
	}
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
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
	text-decoration: underline;
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
	font-family: Times New Roman;
	font-size: 22pt;
}

.p3 {
	margin-top: 0.108333334in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p4 {
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p5 {
	text-indent: 0.29166666in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p6 {
	text-indent: 0.2777778in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p7 {
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p8 {
	margin-top: 0.108333334in;
	/* text-align: justify; */
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p9 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10pt;
}
</style>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var layer;

	//未保存时不允许打印
	$(function(){
		layui.use('layer',function(){
			layer =layui.layer;
		});
		if($("#mswppzid").val()==""){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		} else {
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		}
	});
	//保存
	function mysave(){
		var url = basePath+'/pub/wsgldy/saveZfwsmswppz';
		//以下例子演示一个如何提交一个有效且避免重复提交的表单
		parent.$.messager.progress({
			text : '正在提交....'
		});//显示进度条
		
		$("#myform").form('submit',{
			url : url,
			onSubmit :function(){
				var isValid = $(this).form('validate');  //做form字段校验，返回true则提交，返回false则不提交
				if(!isValid){
					parent.$.messager.progress('close');  //如果表单是无效的则隐藏进度条
				}
				return isValid;
			},
			success : function(result){
				parent.$.messager.progress('close');  //隐藏进度条
				result = $.parseJSON(result);  
				if(result.code=='0'){
					$("#mswppzid").val(result.mswppzid);
					$("#saveBtn").linkbutton('disable');
					$("#lcwmbBtn").linkbutton('enable');	
	 		  		$("#printBtn").linkbutton('enable')
					alert("保存成功!");
				}else{
					alert('保存失败：'+result.msg);
				}
			}
		});
	}

	//打印
	function myprint(){
	    var obj = new Object();
	    var v_ajdjid = $("#ajdjid").val();
	    var v_mswppzid = $("#mswppzid").val();
		var url="<%=basePath%>pub/wsgldy/zfwsmswppzPrintIndex?ajdjid="
			+v_ajdjid+"&mswppzid="+v_mswppzid+"&time="+new Date().getMilliseconds();
		//创建模态窗口
		parent.sy.modalDialog({
			title:'打印',
			area : ['100%', '100%']
			,content :url
			,offset:'0px'
			,btn:['关闭']
		});
	}
	
	//保存为模板
	function saveAsMoban(){
		var obj = new Object();
		var v_ajdjid = $("#ajdjid").val();
		var v_zfwsdmz = $("#zfwsdmz").val();
		var v_mswppzid = $("#mswppzid").val();
		if(v_ajdjid==null||v_ajdjid==""||v_ajdjid.length==0){
			alert("案件登记id为空，不能另存为模板！");
			return false;
		}
		if(v_mswppzid==null||v_mswppzid==""||v_mswppzid.length==0){
			alert("请先保存，保存成功后才能作为模板使用！");
			return false;
		}
		var url = "<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
			+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();

		//创建模态窗口
		parent.sy.modalDialog({
			title:'模板提取',
			area : ['100%', '100%']
			,content :url
			,offset:'0px'
			,btn:['保存为文书模板','关闭']
			,btn1: function(index, layero){
				parent.window[layero.find('iframe')[0]['name']].submitForm();
			}
		});
	}
	
	//从模板中提取
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
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width:210mm;margin:0 auto">
	<body class="b1 b2 zfwsbackgroundcolor">
		<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
		<input id="mswppzid" name="mswppzid" type="hidden" value="${mybean.mswppzid}"/>
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>">
			<p class="p1">
				<span class="s1"><input type="text" id="xzjgmc" name="xzjgmc" 
					style="width: 300px;" value="${mybean.xzjgmc}"/></span>
			</p>
			<p class="p2">
				<span class="s1">没收物品凭证</span>
			</p>
			<div align="right">
				<p class="p3" style="overflow:auto">
					<span class="s2">
						<input type="text" id="mspzwsbh" name="mspzwsbh" 
						style="width: 260px;text-align: right;" value="${mybean.mspzwsbh}"/>
					</span>
				</p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4">
				<span class="s2">案 由：</span>
				<span class="s3"><input type="text" id="ajdjay" name="ajdjay" 
					style="width: 730px;text-align: left;" value="${mybean.ajdjay}"/></span>
			</p>
			<p class="p4">
				<span class="s2">当事人：</span>
				<span class="s3"><input type="text" id="mswpdsr" name="mswpdsr" 
					style="width: 300px;text-align: left;" value="${mybean.mswpdsr}"/></span> 
				<span class="s2">地 址：</span>
				<span class="s3"><input type="text" id="mswpdz" name="mswpdz" 
					style="width: 350px;text-align: left;" value="${mybean.mswpdz}"/></span>
			</p>
			<p class="p4">
				<span class="s2">执行机关：</span>
				<span class="s3"><input type="text" id="mswpzxjg" name="mswpzxjg" 
					style="width: 200px;text-align: left;" value="${mybean.mswpzxjg}"/>
				</span>
			</p>
			<p class="p4"></p>
			<p class="p5">
				<span class="s2">根据</span>
				<span class="s3"><input type="text" id="cfjdwsbh" name="cfjdwsbh" 
					style="width: 260px;" value="${mybean.cfjdwsbh}"/></span> 
				<span class="s2">《行政处罚决定书》的决定，对你（单位）的涉案物品进行没收。</span>
			</p>
			<p class="p6"></p>
			<p class="p5">
				<span class="s2">附件：<input type="text" id="mswpfj" name="mswpfj" 
					style="width: 580px;text-align: left;" value="${mybean.mswpfj}"/></span>
			</p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<div align="right">
				<p class="p7">
					<span class="s2">（公 章）</span>
				</p>
			</div>
			<div align="right">
			<p class="p8">
			    <span class="s2"> &times;年 &times;月&times;日 <input
						name="mspzgzrq" id="mspzgzrq" class="Wdate"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 175px;" value="${mybean.mspzgzrq}"> </span>
		        </p>
			</div>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<p class="p7">
				<span class="s2">注：存档，必要时交</span>
				<span class="s3"><input type="text" id="qzzzrmfy" name="qzzzrmfy" 
					style="width: 100px;text-align: left;" value="${mybean.qzzzrmfy}"/></span>
				<span class="s2">人民法院强制执行。</span>
			</p>
			<p class="p9"></p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	<table>
	   <tr align="right" style="height: 60px;">
	       <td  align="right">
	       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	           <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="mysave()"
	              data-options="iconCls:'icon-save'">保存</a>
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	           
	           <a href="javascript:void(0);" id="printBtn" class="easyui-linkbutton" onclick="myprint();"
	              data-options="iconCls:'icon-print'">打印</a>
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
	           
	           <a href="javascript:void(0);" id="lcwmbBtn" class="easyui-linkbutton" onclick="saveAsMoban();"
	              data-options="iconCls:'ext-icon-book_add'">另存为模板</a>
	           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	           
	           <a href="javascript:void(0);" id="lcwBtn" class="easyui-linkbutton" onclick="tqMoban();"
	              data-options="iconCls:'ext-icon-book_go'">从模板提取</a>
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
