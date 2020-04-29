<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwssxfzajysspb4DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
	}
	
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	
	Zfwssxfzajysspb4DTO dto = new Zfwssxfzajysspb4DTO();
    if (request.getAttribute("mybean") != null) {
    	dto = (Zfwssxfzajysspb4DTO)request.getAttribute("mybean");
    }	
	String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
	
	boolean v_sxfzajysspb_cbbmfzr=SysmanageUtil.isExistsFuncByBizid("sxfzajysspb_cbbmfzr");
	String v_sxfzajysspb_cbbmfzr_readonly="";
	String v_sxfzajysspb_cbbmfzr_disable="";
	if (!v_sxfzajysspb_cbbmfzr){
		v_sxfzajysspb_cbbmfzr_readonly="readonly='readonly' class='zfwstextReadonly'";
		v_sxfzajysspb_cbbmfzr_disable="disabled='disabled'";	
	}
	
	boolean v_sxfzajysspb_spfzr=SysmanageUtil.isExistsFuncByBizid("sxfzajysspb_spfzr");
	String v_sxfzajysspb_spfzr_readonly="";
	String v_sxfzajysspb_spfzr_disable="";
	if (!v_sxfzajysspb_spfzr){
		v_sxfzajysspb_spfzr_readonly="readonly='readonly' class='zfwstextReadonly'";
		v_sxfzajysspb_spfzr_disable="disabled='disabled'";	
	}
	
	boolean v_sxfzajysspb_fgfzr=SysmanageUtil.isExistsFuncByBizid("sxfzajysspb_fgfzr");
	String v_sxfzajysspb_fgfzr_readonly="";
	String v_sxfzajysspb_fgfzr_disable="";
	if (!v_sxfzajysspb_fgfzr){
		v_sxfzajysspb_fgfzr_readonly="readonly='readonly' class='zfwstextReadonly'";
		v_sxfzajysspb_fgfzr_disable="disabled='disabled'";	
	}
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=GB2312">
<style type="text/css">.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{font-family:仿宋_GB2312;color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;}
.p3{margin-top:0.108333334in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p4{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-indent:3.6458333in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-indent:4.3020835in;margin-right:0.072916664in;margin-top:0.108333334in;
	text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p7{margin-top:0.108333334in;text-align:center;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10pt;}
.p8{margin-right:0.072916664in;margin-top:0.21666667in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p9{text-indent:3.6458333in;margin-right:0.072916664in;margin-top:0.108333334in;
	text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p10{text-indent:1.75in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.p11{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.e1{text-align:end;}
</style>
<title>涉嫌犯罪案件移送审批表</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var ly2;
var layer;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
	$(function(){
        layui.use(['layer'], function () {
            layer=layui.layer;
        })
		if($("#fzysspid").val()==""){
			$("#lcwmbBtn").linkbutton('disable');	
			$("#printBtn").linkbutton('disable');
		}else{
			$("#lcwmbBtn").linkbutton('enable');	
			$("#printBtn").linkbutton('enable');
		}
		ly2= $('#ajdjajly').combobox({
	    	data : v_ajdjajly,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	       }); 
	});
	
	//保存
	function mysave() {
		var url = basePath + 'pub/wsgldy/savezfwssxfzlaysspb';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		parent.$.messager.progress({
			text : '正在提交....'
		}); // 显示进度条

		$('#myform').form('submit', {
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
					$("#fzysspid").val(result.fzysspid);
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
	function myprint() {
		var obj = new Object();
		var v_ajdjid = $("#ajdjid").val();
		var v_fzysspid = $("#fzysspid").val();
		var url = basePath + "pub/wsgldy/zfwssxfzajysspbPrintIndex";
		parent.sy.modalDialog({
            title: '打印',
             area: ['100%', '100%']
            , content: url
            , param : {
                ajdjid : v_ajdjid,
                zfwsqtbid : v_fzysspid,
                time : new Date().getMilliseconds()
            }
            ,offset:["0px"]
            , btn: [ '关闭']
        })
	}
	function saveAsMoban(){
	    var obj = new Object();
	    var v_ajdjid=$("#ajdjid").val();
	    var v_zfwsdmz=$("#zfwsdmz").val();
	    var v_fzysspid=$("#fzysspid").val();
    
	    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
	    	alert('案件登记id为空，不能另存为模板');
	    	return false;
	    } 
		var url = basePath + "pub/wsgldy/zfwsmobanIndex";
    	//创建模态窗口
		parent.sy.modalDialog({
			title:'另存模板',
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
		var url = basePath + "pub/wsgldy/zfwsmobantqIndex?zfwsdmz=";
	  	//创建模态窗口
		parent.sy.modalDialog({
			title:'模板提取',
            area: ['100%', '100%']
            , content: url
				, param : {
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
					fzysspid : $("#fzysspid").val(),
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
	
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();
		s.type = "ok";      
		sy.setWinRet(s);
        parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
</script>

</head>
	<body class="b1 b2 zfwsbackgroundcolor">
	 <form id="myform" method="post">
	 	<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid %>">
		<input id="fzysspid" name="fzysspid" type="hidden" value="${mybean.fzysspid}" />	
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz %>" />	
		<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
			<span class="s1">涉嫌犯罪案件移送审批表</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p3">
			<span class="s2" name="ajdjay">案 由: &nbsp; 
			<input name="ajdjay" style="width: 500px;" class="easyui-validatebox bbtextarea" value="${mybean.ajdjay}"/></span>
		</p>
		<p>
			    案件来源：<input id="ajdjajly" name="ajdjajly" style="width:150px;" 
						value="${mybean.ajdjajly}" />
			     
		</p>
		<p class="p4">
			<span class="s2">受移送机关：<input id="sysjg" name="sysjg" style="width: 500px;" 
			value="${mybean.sysjg}"/></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
			<span class="s2">主要案情及移送原因： </br>  
			<textarea class="easyui-validatebox bbtextarea" id="zyaqjysyy" name="zyaqjysyy" 
			style="width: 750px;height: 200px;" >${mybean.zyaqjysyy}</textarea></span>
		</p>
		<p class="p4"></p>
		<p class="p4">
			<span class="s2">附件：涉嫌犯罪案件情况调查报告。</span>
		</p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="e1" style="float:right;">
			<span class="pe2">经办人：<input id="jbr" name="jbr" style="width: 150px;" value="${mybean.jbr}"/>(签字)</span>
		</p>
		<p style="clear:both;"></p>
		<p class="e1" style="float:right;">
			<span class="d2"> &times;年&times;月&times;日<input name="jbrqzrq" id="jbrqzrq"  class="Wdate"
			 onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  style="width: 175px;" value="${mybean.jbrqzrq}" ></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
		<p class="p8">
			<span class="s2">承办部门意见：</br>
			<textarea class="easyui-validatebox bbtextarea" <%=v_sxfzajysspb_cbbmfzr_readonly%>  id="cbbmyj" name="cbbmyj" 
			style="width: 750px;height: 200px;">${mybean.cbbmyj}</textarea> </span>
		</p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="e1" style="float:right;">
			<span class="pe2">负责人：<input id="cbbmfzr" <%=v_sxfzajysspb_cbbmfzr_readonly%> name="cbbmfzr" style="width: 150px;" value="${mybean.cbbmfzr}"/>(签字)</span>
		</p>
		<p style="clear:both;"></p>
		<p class="e1" style="float:right;">
			<span class="d2"> &times;年&times;月&times;日
			<input name="cbbmfzrqzrq" id="cbbmfzrqzrq" <%=v_sxfzajysspb_cbbmfzr_disable%> class="Wdate"
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  style="width: 175px;" value="${mybean.cbbmfzrqzrq}" ></span>
		</p>  
		<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
		<p class="p8">
			<span class="s2">分管负责人意见：</br>
			<textarea class="easyui-validatebox bbtextarea" <%=v_sxfzajysspb_fgfzr_readonly%> id="fgfzryj" name="fgfzryj" style="width: 750px;height: 200px;">${mybean.fgfzryj}</textarea> </span>
		</p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="p5"></p>
		<p class="e1" style="float:right;">
			<span class="pe2">负责人：<input id="fgfzrqz" <%=v_sxfzajysspb_fgfzr_readonly%> name="fgfzrqz" style="width: 150px;" value="${mybean.fgfzrqz}"/>(签字)</span>
		</p>
		<p style="clear:both;"></p>
		<p class="e1" style="float:right;">
			<span class="d2"> &times;年&times;月&times;日
			<input name="fgfzrqzrq" id="fgfzrqzrq" <%=v_sxfzajysspb_fgfzr_disable%> class="Wdate"
			onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  style="width: 175px;" value="${mybean.fgfzrqzrq}" ></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;" >
		<p class="p4">
			<span class="s2">审批意见：</br>
			<textarea class="easyui-validatebox bbtextarea" id="spyj" name="spyj" <%=v_sxfzajysspb_spfzr_readonly%> style="width: 750px;height: 200px;" >${mybean.spyj}</textarea></span>
		</p>
		<p class="p4"></p>
		<p class="p4" >
			<span class="s2"> </span>
		</p>
		<p class="e1" style="float:right;">
			<span class="pe2">负责人：<input id="spfzr" <%=v_sxfzajysspb_spfzr_readonly%> 
			name="spfzr" style="width: 150px;" value="${mybean.spfzr}"/>(签字)</span>
		</p>
		<p style="clear:both;"></p>
		<p class="e1" style="float:right;">
			<span class="d2"> &times;年&times;月&times;日
			<input name="spfzrqzrq" id="spfzrqzrq" <%=v_sxfzajysspb_spfzr_disable%> class="Wdate"
			 onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  style="width: 175px;" value="${mybean.spfzrqzrq}" ></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;" >
		<p class="p10">
			<span class="s3"> </span>
		</p>
		<p class="p11"></p>
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
		
	  </form>
	</body>
</html>
