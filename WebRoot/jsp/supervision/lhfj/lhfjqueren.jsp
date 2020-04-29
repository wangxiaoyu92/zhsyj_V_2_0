       <%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 操作类型  0自动生成1手动生成
	String v_caozuokind = StringHelper.showNull2Empty(request.getParameter("caozuokind"));
	
%>
<!DOCTYPE html>
<html>
<head>

<title>量化分级统计</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">

//量化分级年度评定等级
var v_LHFJNDPDDJ = <%=SysmanageUtil.getAa10toJsonArray("LHFJNDPDDJ")%>;
var form;
var table;
var layer;
var selectNodes;
var selectTableDataId = '';
	

$(function() {
    layui.use(['form', 'layer'], function(){
        form = layui.form;
        layer = layui.layer;
        form.render();
    });
   /* alert(<%=v_caozuokind%>);*/
		//年度是否评定等级
    initSelectData();
	
});

	

// 关闭窗口
function closeWindow(){
	parent.layer.close(parent.layer.getFrameIndex(window.name));
}

//初始化下拉框选项数据
function initSelectData() {
    var typeOptions = '';
    for (var i = 0; i < v_LHFJNDPDDJ.length; i++) {
        typeOptions += '<option value=\'' + v_LHFJNDPDDJ[i].id + '\' >' + v_LHFJNDPDDJ[i].text + '</option>';
    }
    $("#lhfjndpddj").append(typeOptions);
}
	
   function queding(){
	   var v_lhfjndpddj="";
	   var v_b_caozuokind="<%=v_caozuokind%>";
	   if ("1"==v_b_caozuokind){
		   v_lhfjndpddj=$("#lhfjndpddj").val();
		   if (v_lhfjndpddj==null){
			   alert("请选择 量化分级年度评定等级 ");
			   return false;
		   }
	   }
	   var v_sfcxsc='0';
	   if ($('#sfcxsc').attr('checked')) {
	   //if (document.getElementById("sfcxsc").checked){
		   v_sfcxsc='1';
	   };
	   //var v_ret=[{"lhfjndpddj":"\""+v_lhfjndpddj+"\"","sfcxsc":"\""+v_sfcxsc+"\""}];
	   //var retjson=[{"\"lhfjndpddj\"":"1","\"sfcxsc\"":"2"}];
	   var v_retvalue = new Object(); 
	   v_retvalue.lhfjndpddj=v_lhfjndpddj;
	   v_retvalue.sfcxsc=v_sfcxsc;

	   //var retjson = JSON.stringify(v_retvalue);//

	   sy.setWinRet(v_retvalue);
       closeWindow();
	   }
	
</script>
</head>
<body>
<form id="fm" class="layui-form" action="">
	<div class="layui-fluid">
		<div class="layui-collapse">
			<div class="layui-colla-item">
				<div class="layui-colla-content layui-show">
					<form class="layui-form" id="myqueryfm">
						<div class="layui-form-item">
							<% if ("1".equals(v_caozuokind)){ %>
							<div class="layui-inline" >
								<label class="layui-form-label" >量化分级年度评定等级</label>
								<div class="layui-input-inline" >
									<select name="lhfjndpddj" id="lhfjndpddj" ></select>
								</div>
							</div>
							<%} %>
						</div>
						<div class="layui-form-item">
							<div class="layui-inline" >
								<input type="checkbox" checked name="sfcxsc" id="sfcxsc" title="如果存在是否重新生成，选中会先删除再生成" lay-skin="primary">

							</div>
							<div class="layui-form-item" style="text-align: center;">
								<a href="javascript:void(0)" class="layui-btn"
								   iconCls="icon-search" onclick="queding()"> 确定</a>
							</div>

						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</form>
</body>
</html>