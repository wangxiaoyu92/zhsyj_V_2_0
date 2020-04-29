<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
%>
<!DOCTYPE html>
<html>
<head>
<title>园区介绍</title>
</head>
<body>
<div>
<font style="line-height:200%;">
&nbsp;&nbsp;&nbsp;&nbsp;汤阴县产业集聚区依托“国家新型工业化产业示范基地”、“全国食品工业强县”、“全国农产品加工业示范基地”等国字号金字招牌，强力实施“大招商”、“招大商”战略，截至目前，已有益海嘉里、永达肉鸡、众品食业、今麦郎面粉、健丰饼干、杜邦木糖醇、东泰制药、九州制药、科伦药业等196家国内外知名企业入驻。其中，规模以上工业企业40家，世界500强企业子公司3家，国家级重点龙头企业8家，省级重点龙头企业8家，市级重点龙头企业16家。已形成肉类、粮食、蔬菜、休闲食品四大加工产业集群，涉及畜禽肉制品、面粉、挂面、小杂粮、木糖醇、饼干、啤酒饮料、脱水蔬菜等80余个系列产品，拥有“江顺”饼干、“甲家”面粉、“永达”肉鸡、“众品”冷鲜肉等4个中国名牌，已成为食品工业带动农产品深加工的高效产业集聚区。
<br /> 
&nbsp;&nbsp;&nbsp;&nbsp;汤阴县将凭借国强盛世经济兴，乘着省委、省政府中原崛起、强力推进产业集聚区建设的东风，秉承亲商、安商、敬商、富商的理念，本着诚信第一、服务至上、优化环境、共谋发展的宗旨，汇聚一切力量，调动一切积极因素，把产业集聚区建设成为人居福地、投资宝地、发展高地，诚邀海内外宾朋精诚合作、互利共赢、共创辉煌！
</font>
</div>
</body>
</html>