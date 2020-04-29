<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>机构概况->机构概况</title>
<jsp:include page="head.jsp"></jsp:include>
</head>
<body>
<div class="clear"></div>
<div class="mid_bg">
  <div class="top_4">
	  <div class="top_4d fl" id="DangQianWeiZhi"><span>当前位置</span>&nbsp;&gt;&nbsp;机构概况&nbsp;&gt;&nbsp;机构概况</div>      
	  <div class="top_4c fr">
	  	<div class="top_4c_1 fl"><img src="<%=contextPath %>/jsp/gzfw/images/bg13.gif" width="19" height="19" /></div>
	    <div class="top_4c_2 fl"><input type="text" name="textfield" id="textfield" class="txt_1" /></div>
	    <div class="top_4c_3 fl"><a href="#" class="btn_1">搜索</a></div>
	  </div>    
  </div>
  <div class="h20 clear"></div>
  
  <div class="ntit_1">
    <ul>
      <li class="marr10"><a href="<%=contextPath %>/jsp/gzfw/jggk.jsp" class="curr">机构概况</a></li>
      <li><a href="<%=contextPath %>/jsp/gzfw/gdjg.jsp">各地机构</a></li>
    </ul>
  </div>
  
  <div class="h20 clear"></div>
  
  <div class="about clearfix">
    <h2>汤阴县食品药品监督管理局概况</h2>
    <div class="about_nr clearfix">
	    <p>根据《河南省人民政府办公厅关于印发河南省食品药品监督管理局主要职责内设机构和人员编制规定的通知》（豫政办〔2013〕82号）,我局主要工作职责如下：</p><br />
	    <p>01 贯彻执行国家食品(含食品添加剂、保健食品,下同)安全、药品(含中药、民族药,下同)、医疗器械、化妆品监督管理法律、法规,起草相关地方性法规、规章草案和政策规划并监督实施。推动建立落实食品药品安全企业主体责任、各级政府负总责的机制,建立食品药品重大信息直报制度并组织实施和监督检查,着力防范区域性、系统性食品药品安全风险。</p><br />
	    <p>02 贯彻执行国家食品(含食品添加剂、保健食品,下同)安全、药品(含中药、民族药,下同)、医疗器械、化妆品监督管理法律、法规,起草相关地方性法规、规章草案和政策规划并监督实施。推动建立落实食品药品安全企业主体责任、各级政府负总责的机制,建立食品药品重大信息直报制度并组织实施和监督检查,着力防范区域性、系统性食品药品安全风险。</p><br />
	    <p>03 贯彻执行国家食品(含食品添加剂、保健食品,下同)安全、药品(含中药、民族药,下同)、医疗器械、化妆品监督管理法律、法规,起草相关地方性法规、规章草案和政策规划并监督实施。推动建立落实食品药品安全企业主体责任、各级政府负总责的机制,建立食品药品重大信息直报制度并组织实施和监督检查,着力防范区域性、系统性食品药品安全风险。</p><br />
	    <p>04 贯彻执行国家食品(含食品添加剂、保健食品,下同)安全、药品(含中药、民族药,下同)、医疗器械、化妆品监督管理法律、法规,起草相关地方性法规、规章草案和政策规划并监督实施。推动建立落实食品药品安全企业主体责任、各级政府负总责的机制,建立食品药品重大信息直报制度并组织实施和监督检查,着力防范区域性、系统性食品药品安全风险。</p><br />
	    <p>05 贯彻执行国家食品(含食品添加剂、保健食品,下同)安全、药品(含中药、民族药,下同)、医疗器械、化妆品监督管理法律、法规,起草相关地方性法规、规章草案和政策规划并监督实施。推动建立落实食品药品安全企业主体责任、各级政府负总责的机制,建立食品药品重大信息直报制度并组织实施和监督检查,着力防范区域性、系统性食品药品安全风险。</p>
    </div>
  </div>

  <div class="h20 clear"></div>
</div><!--mid_bg.end-->
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>