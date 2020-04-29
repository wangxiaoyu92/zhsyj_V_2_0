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
      <%--<li><a href="<%=contextPath %>/jsp/gzfw/gdjg.jsp">各地机构</a></li>--%>
    </ul>
  </div>
  
  <div class="h20 clear"></div>
  
  <div class="about clearfix">
    <h2>安阳市药监局管理机构概况</h2>
    <div class="about_nr clearfix">
		<p><strong><span style="font-family:宋体">&nbsp;</span></strong><br></p><p>&nbsp;<strong><span style="font-family:宋体">安阳市食品药品监督管理局负责本行政区域内的食品药品监督管理工作，领导下属机构开展各项食品药品监督管理业务。其主要职责是：</span></strong>&nbsp;&nbsp;&nbsp; <br></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（一）贯彻执行国家和省食品（含食品添加剂、保健食品，下同）</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">安全、药品（含中药、民族药，下同）、医疗器械、化妆品监督管理法律、法规、规章和政策规划。拟订并组织实施全市食品、药品、医疗器械、化妆品安全规划和地方性食品安全管理办法、规定和监管程序、操作规程等规范性文件。推动建立落实食品药品安全企业主体责任、各级政府负总责的机制，建立食品药品重大信息直报制度并组织实施和监督检查，着力防范区域性、系统性食品药品安全风险。</span></span></span></span><br></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（二）依法组织实施食品行政许可和质量安全监督管理，建立食品安全隐患排查治理机制，制定全市食品安全检查年度计划、重大整顿治理方案并组织落实。建立并组织实施食品药品安全信息统一发布制度，公布重大食品安全信息。参与制定食品安全风险监测计划，根据食品安全风险监测计划参与食品安全风险监测工作。组织开展食品安全监督抽样检验工作。</span></span></span></span><br></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（三）负责实施和监督药品、医疗器械行政审批。监督实施国家药典等药品和医疗器械标准、分类管理制度。负责药品、医疗器械研制、生产、流通和使用质量安全监管。组织实施中药品种保护制度。组织开展药品监督抽验工作。建立药品不良反应、医疗器械不良事件监测体系，并开展监测和处置工作。根据化妆品监督管理办法组织实施化妆品监督管理。</span></span></span></span></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（四）负责制定食品药品、医疗器械、化妆品监督管理的稽查制度并组织实施，</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">组织查处重大违法行为。建立问题产品召回和处置制度并监督实施。</span></span></span></span></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（五）负责食品药品安全事故应急体系建设，组织和指导食</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">品药品安全事故应急处置和调查处理工作，监督事故查处落实情况。</span></span></span></span></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（六）负责制定食品药品安全科技发展规划并组织实施，推动食品药品检验检测体系、电子监管追溯体系和信息化建设。</span></span></span></span></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（七）负责开展食品药品、医疗器械、化妆品安全宣传、教育培训、对外交流与合作。推进诚信体系建设。</span></span></span></span></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（八）指导县（市）食品药品监督管理工作，负责市辖区、</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">安阳</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">市城乡一体化示范区、</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">安阳</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">高新产业技术开发区食品药品监督管理工作，规范行政执法行为，完善行政执法与刑事司法衔接机制。</span></span></span></span></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（九）承担市政府食品安全委员会日常工作。负责食品安全监督管理综合协调，推动健全协调联动机制。督促检查各县（市、区）政府履行食品安全监督管理职责并负责考核评价。</span></span></span></span></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">（十）承办</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">市政府及市政府食品安全委员会交办的其他事项。</span></span></span></span></p><p><br></p><p><br></p><p><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">&nbsp;&nbsp;&nbsp; <strong>市食品药品监督管理局</strong></span></span></span></span><strong><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">食品</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">药品稽查</span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">支</span></span></span></span></strong><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312"><strong>队</strong>:</span></span></span></span><span style="font-size:15pt"><span style="background-color:#ffffff"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">负责全市食品药品安全的稽查和违法案件查处工作。制定完善并监督实施食品药品稽查工作制度和问题产品召回处置制度，指导和监督下级稽查工作、规范行政执法行为，监督问题产品召回和处置，推动完善行政执法与刑事司法工作衔接机制。受理食品药品</span></span></span></span></span><span style="font-size:15pt"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">违法行为的投诉举报和投诉举报案件督办工作</span></span></span></span><span style="font-size:15pt"><span style="background-color:#ffffff"><span style="font-family:仿宋_GB2312"><span style="color:#000000"><span style="font-family:仿宋_GB2312">。</span></span></span></span></span><br></p>
	</div>
  </div>

  <div class="h20 clear"></div>
</div><!--mid_bg.end-->
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>