<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,java.net.URLDecoder"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="com.askj.zfba.dto.Zfwszlgztzs20DTO"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	//附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	Zfwszlgztzs20DTO dto = new Zfwszlgztzs20DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwszlgztzs20DTO) request.getAttribute("mybean");
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
	font-size: 12pt;
}

.p3 {
	margin-top: 0.108333334in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p4 {
	margin-top: 0.06944445in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 12pt;
}

.p5 {
	text-indent: 0.44444445in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 12pt;
}

.p6 {
	text-indent: 0.44444445in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 12pt;
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
	text-indent: 3.7916667in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p10 {
	text-indent: 2.9166667in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p11 {
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}
.s22 {
	clear: both;
	display: block;
	float: right;
	margin-bottom: 10px
}
</style>
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var v_sjws="<%=sjws%>";
var layer;
	//未保存时不予许打印
	$(function(){
        layui.use(['layer'], function () {
            layer=layui.layer;
        })
		var v_zlgztzsid = $("#zlgztzsid").val();
		if (v_zlgztzsid==null || v_zlgztzsid=="" || v_zlgztzsid.length== 0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	}
	   if(<%=sjws%>=='2'){
	    $("#lcwmbBtn").eq(0).hide();
		$("#lcwBtn").eq(0).hide();
		$("#BtnFanhui").eq(0).hide(); 
	  } 
	});
	
	//保存
	function mysave() {
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单url: basePath+'/pub/zfwslaspb/savezfwslaspb';
		parent.$.messager.progress({
			text : '正在提交....'
		});
		$('#myform').form(
				'submit',
				{
					url : basePath + 'pub/wsgldy/saveZfwszlgztzs?sjordn=<%=sjws%>',
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
							$("#zlgztzsid").val(result.zlgztzsid);
							$("#saveBtn").linkbutton('disable');
					 		$("#lcwmbBtn").linkbutton('enable');
					 		$("#printBtn").linkbutton('enable');
							alert("保存成功！");
						} else {
							alert('保存失败：' + result.msg);
						}
					}
				});
	}
	
	//打印
	function myprint(){
	    var obj = new Object();
	    var v_ajdjid=$("#ajdjid").val();
	    var v_zlgztzsid = $("#zlgztzsid").val();
	    if(<%=sjws%>=='2'){
           var url="<%=basePath%>/common/sjb/getajdjDocumentsHtml?ajdjid="
		 	+v_ajdjid+"&zlgztzsid="+v_zlgztzsid+"&type="+'5'+"&time="+new Date().getMilliseconds();
        self.location=url; 
          }else{
		var url="<%=basePath%>pub/wsgldy/zfwszlgztzsPrintIndex?ajdjid="
			+v_ajdjid+"&zlgztzsid="+v_zlgztzsid+"&time="+new Date().getMilliseconds();
	        }
	    //创建模态窗口
		parent.sy.modalDialog({
            title:'打印',
             area: ['100%', '100%']
            , content: url
            ,offset:["0px"]
            , btn: [ '关闭']
        });
	}
	
	//保存为模板
	function saveAsMoban(){ 
		var v_ajdjid = $("#ajdjid").val();
		var v_zfwsdmz = $("#zfwsdmz").val();
		if(v_ajdjid==null||v_ajdjid==""||v_ajdjid.length==0){
			alert("案件登记id为空，不能另存为模板！");
			return false;
		}
		var url = "<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid+
				"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
		
		//创建模态窗口
		parent.sy.modalDialog({
            title:'另存模板',
             area: ['100%', '100%']
            , content: url
            ,offset:["0px"]
            , btn: [ '保存为模板文书','关闭']
            , btn1: function (index, layero) {
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
            title:'提取模板',
            area: ['100%', '100%']
            , content: url
            , offset: ["0px"]
            , btn: ['关闭']
        },function (dialogID){

			var v_retStr = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			
			
			if(v_retStr!=null && v_retStr.type=='ok'){
			var myrow = v_retStr.data;
			parent.$.messager.progress({
				"text":"数据加载中..."
			});
			var v_zfwsmbid = myrow.zfwsmbid;
			$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(),{
				'zfwsmbid':v_zfwsmbid
			},function(result){
				if(result.code=='0'){
					var retdata = result.data;
					GloballoadData(retdata);
				}else{
					parent.$.messager.alert('提示','查询模板信息失败：'+result.msg,'error');
				}
				parent.$.messager.progress('close');
			},'json');
		}
		})
	}
	<%--// 选择违反的规定--%>
	<%--function myselectPcyzdsz(){--%>
		<%--var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";--%>
        <%--sy.modalDialog({--%>
            <%--title: '违反规定'--%>
            <%--, area: ['100%', '100%']--%>
            <%--, content: url--%>
            <%--, param: {--%>
                <%--singleSelect : "true",--%>
                <%--tabname : "zfwszlgztzs20",--%>
                <%--colname : "zlgzwfgd",--%>
                <%--a : new Date().getMilliseconds()--%>
            <%--}, offset: ["0px"]--%>
        <%--}--%>
		<%--,function (dialogID){--%>
			<%--var obj = sy.getWinRet(dialogID);--%>
			<%--if (obj!=null && obj.length>0){--%>
	    	<%--for (var k=0;k<=obj.length-1;k++){--%>
	    	<%--var myrow=obj[k];--%>
	      	<%--$("#zlgzwfgd").val(myrow.avalue);    --%>
	    <%--}}; --%>
		<%--})--%>
	<%--}	--%>
	// 处罚规定
	function myselectPcyzdsz(){
		if (v_sjws!=null && v_sjws=='2'){
		    var url="<%=basePath%>/common/sjb/getpcyzdsz?time="+new Date().getMilliseconds();
	          self.location=url; 			
		}else{			
			var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
            parent.sy.modalDialog({
                title: '处罚规定'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    tabname : "zfwszlgztzs20",
                    colname : "zlgzcfgj",
                    a : new Date().getMilliseconds(),
                    yjflfg : "1"
                }
            }
			,function (dialogID){
				var obj = sy.getWinRet(dialogID);
				if (obj!=null && obj.length>0){
		 	    for (var k=0;k<=obj.length-1;k++){
		    	var myrow=obj[k];
		      	$("#zlgzcfgj").val(myrow.avalue);    
		    }}; 
		    	sy.removeWinRet(dialogID);//不可缺少
			})
		}
	}	
	
	// 违反依据法律法规 
	function myselectPcyzdsz2(str){
	      $("#zlgzcfgj").val(str);    
	}	
	
	
	// 处罚规定
	function myselectPcyzdsz3(){
		if (v_sjws!=null && v_sjws=='2'){
		    var url="<%=basePath%>/common/sjb/get3pcyzdsz?time="+new Date().getMilliseconds();
	          self.location=url; 			
		}else{			
			var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
            parent.sy.modalDialog({
                title: '处罚规定'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    singleSelect : "true",
                    tabname : "zfwszlgztzs20",
                    colname : "zlgzwfgd",
                    a : new Date().getMilliseconds(),
                    yjflfg : "1"
                }
            }
			,function (dialogID){
				var obj = sy.getWinRet(dialogID);
				if (obj!=null && obj.length>0){
		  	    for (var k=0;k<=obj.length-1;k++){
		    	var myrow=obj[k];
		      	$("#zlgzwfgd").val(myrow.avalue);    
		    }}; 
		    	sy.removeWinRet(dialogID);//不可缺少
			})
		}
	}	
	
	// 违反依据法律法规 
	function myselectPcyzdszReture3(str){
	      $("#zlgzwfgd").val(str);    
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
<div style="width: 210mm; margin: 0 auto">
	<body class="b1 b2 zfwsbackgroundcolor">
		<form id="myform" method="post">
		    <input id="userid" name="userid" type="hidden" value="<%=v_userid%>"/>
			<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
			<input id="zlgztzsid" name="zlgztzsid" type="hidden"
				value="${mybean.zlgztzsid}" />
			<input id="zfwsdmz" type="hidden" name="zfwsdmz" value="<%=v_zfwsdmz%>"/>
	<p class="p1">
		<span class="s1">食品药品行政处罚文书</span>
	</p>
	<p class="p2">
		<span class="s1">责令改正通知书</span>
	</p>
	<div align="right">
	<p class="p3">
		<span class="s2">
			<input type="text" id="zlgzwsbh" name="zlgzwsbh" 
			style="width: 260px;text-align: right;" value="${mybean.zlgzwsbh}" />
		</span>
	</p>
	</div>
	<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	<p class="p4">
		<span class="s2"> <input id="zlgzdsr" name="zlgzdsr" style="width:200px" 
		value="${mybean.zlgzdsr}"/>:</span>
	</p>
	<p class="p5">
		<span class="s2">经查，你（单位）</span>
		<span class="s2"><input id="zlgzwfxw" name="zlgzwfxw" type="text" style="width:200px;"
	 		value="${mybean.zlgzwfxw }"/></span>
	 	<span class="s2">的行为 ，违反了</span>
		<span class="s2"><input id="zlgzwfgd" name="zlgzwfgd" type="text" style="width:300px"
	 		value="${mybean. zlgzwfgd}"/>
	 		<input type="button" style="color:blue;" id="sel3" value="选择" onclick="myselectPcyzdsz3();"></span>
	 	<span class="s2">的规定。</span>
	</p>
	<p class="p6">
		<span class="s2">根据</span>
		<span class="s2"><input id="zlgzcfgj" name="zlgzcfgj" type="text"
		 style="width:300px" value="${mybean.zlgzcfgj }"/></span>
		<span class="s2"><input type="button" style="color:blue;" id="sel6" value="选择" onclick="myselectPcyzdsz();">（法律法规依据名称及条、款、项具体内容）的规定，现责令你（单位）于</span>
		<span class="s2"> &times;年 &times;月&times;日 <input
			name="zlgzwfxwjzrq" id="zlgzwfxwjzrq" class="Wdate"
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
			style="width: 175px;"value="${mybean.zlgzwfxwjzrq}"> </span>
			<span class="s2">前/立即改正违法行为。改正内容和要求如下：</span>
	</p>
	<p class="p6">
		<span class="s2">
		<textarea id="zlgzgznr" name="zlgzgznr"
		 style="width:760px;height:200px;">${mybean.zlgzgznr }</textarea></span>
	</p>
	<p class="p7"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<div align="right">
	<p class="p9" style="margin-left:35%">
		<span class="s2">（公 章）</span>
	</p>
	</div>
	<div align="right">
	<p class="p8">
		<span class="s2"> &times;年 &times;月&times;日 <input
			name="zlgzgzrq" id="zlgzgzrq" class="Wdate"
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
			style="width: 175px;"value="${mybean.zlgzgzrq}"> </span>
	</p>
	</div>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p7">
			   <span class="s2">当事人签字：<input  name="zlgzdsrqz" id="zlgzdsrqz" value="${mybean.zlgzdsrqz}" /></span>
			   <span>&times;年&times;月&times;日 <input name="zlgzdsrqzrq" id="zlgzdsrqzrq"  class="Wdate" 
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 175px;"  value="${mybean.zlgzdsrqzrq}" ></span> 
			</p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p8"></p>
	<p class="p10"></p>
	<p class="p10"></p>
	<p class="p11">
		<span class="s2"> </span>
	</p>
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
