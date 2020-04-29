<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsjccfkyjds17DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>

<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwsjccfkyjds17DTO dto = new Zfwsjccfkyjds17DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsjccfkyjds17DTO) request.getAttribute("mybean");
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
.p3{text-indent:3.1930556in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-indent:0.072916664in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-indent:0.29166666in;margin-left:0.072916664in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{text-indent:3.8645833in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{margin-right:0.36458334in;margin-top:0.108333334in;text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p9{text-indent:0.072916664in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p10{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.p11{
	text-align:right;
}
.p12{
	text-align:right;
}
.p13{
	text-align:right;
}
</style>
<title>解除查封（扣押）决定书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "ok";       
	sy.setWinRet(s); 
var mygrid;
var layer;
	$(function(){
        layui.use(['layer'], function () {
            layer=layui.layer;
        })
		var v_ajdczjbgid=$("#jccfkyjdsid").val();
		if (v_ajdczjbgid==null || v_ajdczjbgid=="" || v_ajdczjbgid.length== 0){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		} 
	});				


	//保存
	function mysave() {
		var url = basePath + 'pub/wsgldy/saveZfwsjccfkyjds17';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		parent.$.messager.progress({
			text : '正在提交....'
		}); // 显示进度条

		$('#myform').form(
				'submit',
				{
					url : url,
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
							$("#jccfkyjdsid").val(result.jccfkyjdsid);
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
	//打印
	function myprint() {
		var obj = new Object();
		var v_zfwslydjid = $("#ajdjid").val();
		var v_jccfkyjdsid = $("#jccfkyjdsid").val();
		var url = "<%=basePath%>pub/wsgldy/Zfwsjccfkyjds17IndexPrint?ajdjid="
					+v_zfwslydjid+"&zfwsqtbid="+v_jccfkyjdsid+"&time="+new Date().getMilliseconds();
		//创建模态窗口
		parent.sy.modalDialog({
			title:'打印',
             area: ['100%', '100%']
            , content: url
            ,offset:["0px"]
            , btn: [ '关闭']
        });
	}
		
	//保存模板
	function saveAsMoban(){
	    var obj = new Object();
	    var v_ajdjid=$("#ajdjid").val();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    var v_jccfkyjdsid=$("#jccfkyjdsid").val();
	    
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    }
	    
		var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
				+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
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
	
	//提取模板
	function tqMoban(){
	    var obj = new Object();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    
		var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
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
			    jccfkyjdsid : $("#jccfkyjdsid").val(),
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
		});
	}
//从单位信息表中读取
function myselectPcyzdsz(){
	var url="<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
    parent.sy.modalDialog({
        title: '从单位信息表中读取'
        , area: ['100%', '100%']
        , content: url
        , param: {
            singleSelect : "true",
            tabname : "jccfkyjds17",
            colname : "jckydjx",
            a : new Date().getMilliseconds()
        }
    }
	,function (dialogID){
		var obj = sy.getWinRet(dialogID);
		if (obj!=null && obj.length>0){
    	for (var k=0;k<=obj.length-1;k++){
     	 var myrow=obj[k];
      	$("#jckydjx").val(myrow.avalue); 
    }};
    sy.removeWinRet(dialogID);//不可缺少
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
		<input id="jccfkyjdsid" name="jccfkyjdsid" type="hidden"
			value="${mybean.jccfkyjdsid}" />
			<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
			<span class="s1">解除查封（扣押）决定书</span>
			</p>
			<p class="p3">
			<span class="s2"><input id="jckywsbh" name="jckywsbh" style="width:200px;" value="${mybean.jckywsbh}" /></span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
			<p class="p4">
			<span class="s2"><input name="jckydsr" value="${mybean.jckydsr}"/>：</span>
			</p>
			<p class="p5">
			<span class="s2">我局于<input name="jckykyrq" id="jckykyrq" class="Wdate"
				onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;" value="${mybean.jckykyrq}"/>，以
				<input style="width:200px;" name="jckykybh" value="${mybean.jckykybh}"/>《查封（扣押）决定书》对
				  <input style="width:200px;" name="jckywpqdbh" value="${mybean.jckywpqdbh}"/>
				  《查封（扣押）物品清单》所列物品予以查封（扣押），现根据
				  <input id="jckydjx" name="jckydjx" style="width:400px;" value="${mybean.jckydjx}" />
				  <input type="button" style="color:blue;" value="选择" onclick="myselectPcyzdsz();">
				  的规定，予以全部（或部分）解除查封（扣押）。</span>
			</p>
			<p class="p6">
			<span class="s2">行政机关联系人：</span> <input name="jckyxzjglxr" style="width:150px;" value="${mybean.jckyxzjglxr}"/> </span>
			<span class="s2">联系电话：</span> <input name="jckylxdh" style="width:150px;" value="${mybean.jckylxdh}"/></span>
			</p>
			<p class="p6">
			<span class="s2">附件： <input name="jckyfj" style="width:200px;" value="${mybean.jckyfj}"/></span>
			</p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p7"></p>
			<p class="p7"></p>
			<br/><br/><br/><br/>
			<p class="p11">
			<span class="s2">                                                    （公    章）</span>
			</p>
			<p class="p12">
			<span class="s2">                                                         
			&times;年&times;月&times;日:<input name="jckygzrq" id="jckygzrq" class="Wdate"
				 onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 175px;" value="${mybean.jckygzrq}" /></span>
			</p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6">
			   <span class="s2">当事人签字：<input  name="jckydsrqz" id="jckydsrqz" value="${mybean.jckydsrqz}" /></span>
			   <span>&times;年&times;月&times;日 <input name="jckydsrqzrq" id="jckydsrqzrq"  class="Wdate" 
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" 
					style="width: 175px;"  value="${mybean.jckydsrqzrq}" ></span> 
			</p> 
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p6"></p>
			<p class="p13">
				<span class="s2">注：正文3号仿宋体字，存档（1）。</span>
			</p>
			<p class="p10"></p> 
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
