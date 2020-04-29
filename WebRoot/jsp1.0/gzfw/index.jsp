<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.service.news.NewsService"%>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.siweb.dto.PagesDTO"%>
<%@ page import="com.zzhdsoft.siweb.entity.news.News,java.util.*" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	NewsService newsService = new NewsService();
	News newsdto = new News(); 
	PagesDTO pd = new PagesDTO();
	List newsList = null;	
%> 
<!DOCTYPE html>
<html>
<head>
<title>食药监管公众服务平台</title>
<jsp:include page="head.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath %>/jsp/gzfw/ckplayer/swfobject.js"></script>
<script type="text/javascript" src="<%=contextPath %>/jsp/gzfw/ckplayer/ckplayer.js" charset="utf-8"></script>
<div class="mid_bg">   
	<div class="top_4">
		<div class="top_4a fl">
			<script type="text/javascript">		
				thisdate = new Date()
				thismonth = thisdate.getMonth()
				thismonth = thismonth + 1
				thisday = thisdate.getDate()
				thisyear = thisdate.getYear()
				thisweek = thisdate.getDay();
				switch (thisweek){
					case 0: thisweek = "星期日"; break;
					case 1: thisweek = "星期一"; break;
					case 2: thisweek = "星期二"; break;
					case 3: thisweek = "星期三"; break;
					case 4: thisweek = "星期四"; break;
					case 5: thisweek = "星期五"; break;
					case 6: thisweek = "星期六"; break;
				}
				if (thisyear < 2000){ 
					thisyear = thisyear + 1900; 
				}
				document.write(thisyear + "年" + thismonth + "月" + thisday + "日" + "<span>" + thisweek + "</span>")
			</script>
		</div>
	    <div class="top_4b fl">晴转多云 28℃~17℃</div>
	    <div class="top_4c fr"></div>    
	</div>
</div>
</head>
<body>
<div class="mid_bg">
  <div class="h20 clear"></div>
  
  <div class="mid_s1 fl">
    <div class="tit_1">
    	<strong>公告通知</strong>
	    <span>
	    	<a href="<%=contextPath %>/news/queryNewsList?retPageStr=announcement&pageSize=20&cateJc=ggtz_sp&page=1"  target="_blank">更多</a>
	    </span>
    </div>
    <div class="mid_s1_1">
      <ul>
      	<%    	
      		newsdto.setCatejc("ggtz_sp");
     		pd.setRows(5);
     		newsList = newsService.queryNewsList(newsdto,pd);
      		if (newsList != null && newsList.size() > 0) {
      			for (int i = 0; i < newsList.size(); i++) {
      				News bean = (News) newsList.get(i);
			%>
               <li><a href="<%=contextPath %>/news/queryNewsDetail?newsid=<%=bean.getNewsid()%>" title="<%=bean.getNewstitle()%>" target="_blank">.<%=PubFunc.abbreviate(bean.getNewstitle(),2*18,"...")%></a></li>			
			<%
				}
			}
		%>            
      </ul>
    </div>
  </div>
  
  <div class="mid_s2 fl">
    <div class="tit_2">
	    <strong>视频新闻</strong>
	</div>
    <div class="mid_s2_2">
    	<!--视频
		<embed src="<%=contextPath %>/jsp/gzfw/ckplayer6.8/ckplayer.swf" 
			flashvars="f=http://127.0.0.1:8011/syjzhpt/jsp/gzfw/videos/home.flv" quality="high" width="478" 
			height="190" align="middle" allowScriptAccess="always" allowFullscreen="true" 
			type="application/x-shockwave-flash">
		</embed>-->
		<div id="a1"></div>
		<script type="text/javascript" src="<%=contextPath %>/jsp/gzfw/ckplayer6.8/ckplayer.js"  charset="utf-8"></script>

		<script type="text/javascript">
			var url = '<%=contextPath %>/upload/videos/home.flv';  
		    var flashvars={
			    //f:'http://movie.ks.js.cn/flv/other/1_0.mp4',
			    f:url,
			    c:0,
			    p:1,
			    t:15,
			    b:1
			  };
		    var video=[];
		    CKobject.embed('ckplayer6.8/ckplayer.swf','a1','ckplayer_a1','478','190',false,flashvars,video);
		</script>
    </div>
  </div>
  
  <div class="mid_s3 fl">
    <div class="tit_1">
    	<strong>服务指南</strong>
    </div>
    <div class="mid_s3_1">
      <p><strong>服务窗口办公时间：</strong><br /> 
		上午：8：00—12:00 <br />
		下午：14:30—17:30（冬）<br />
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    15:00—18:00（夏）<br /> 
	  </p>
	  <p><strong>服务窗口联系方式:</strong><br />
		办公地址：精忠路与信合路交叉口<br />
		值班电话：0372-6203552<br />
		邮箱：tangyinyj@126.com  
	  </p>
    </div>
  </div>

  <div class="h20 clear"></div>
  
  <div class="mid_s1 fl">
    <div class="tit_1">
    	<strong>法律法规</strong>
	    <span>
	    	<a href="<%=contextPath %>/news/queryNewsList?retPageStr=law&pageSize=20&cateJc=flfg_fl&page=1"  target="_blank">更多</a>
	    </span>
    </div>
    <div class="mid_s1_2">
      <ul>
      	<%    	
      		newsdto.setCatejc("flfg_fl");
     		pd.setRows(7);
     		newsList = newsService.queryNewsList(newsdto,pd);
      		if (newsList != null && newsList.size() > 0) {
      			for (int i = 0; i < newsList.size(); i++) {
      				News bean = (News) newsList.get(i);
			%>
               <li><a href="<%=contextPath %>/news/queryNewsDetail?newsid=<%=bean.getNewsid()%>" title="<%=bean.getNewstitle()%>" target="_blank">.<%=PubFunc.abbreviate(bean.getNewstitle(),2*18,"...")%></a></li>			
			<%
				}
			}
		%>            
      </ul>
    </div>
  </div>
  
  <div class="mid_s5 fl">
    <div class="tit_3">
	    <strong>区县动态</strong>
	    <span>
	    	<a href="<%=contextPath %>/news/queryNewsList?retPageStr=qxdt&pageSize=20&cateJc=qxdt&page=1"  target="_blank">更多</a>
	    </span>
    </div>
    <div class="mid_s5_1">
    	<ul>
      	<%    	
      		newsdto.setCatejc("qxdt");
     		pd.setRows(7);
     		newsList = newsService.queryNewsList(newsdto,pd);
      		if (newsList != null && newsList.size() > 0) {
      			for (int i = 0; i < newsList.size(); i++) {
      				News bean = (News) newsList.get(i);
			%>
               <li><a href="<%=contextPath %>/news/queryNewsDetail?newsid=<%=bean.getNewsid()%>" title="<%=bean.getNewstitle()%>" target="_blank">*<%=bean.getNewstitle()%></a><div class="fr"><%=bean.getNewstjsj()%></div></li>			
			<%
				}
			}
		%>            
      </ul>
    </div>
  </div>
  
  <div class="h20 clear"></div>
  <!-- 右下角四个外联图标 -->
  <div class="mid_s7 fl">
  <div class="mid_s7_1 mart10"><a href="http://as.hda.gov.cn"  target="blank"><img src="images/xzsp.gif" width="230" height="45" /></a></div>
    <div class="mid_s7_1 mart10"><a href="http://cxty.tangyin.gov.cn/"  target="blank"><img src="images/cxty.gif" width="230" height="45" /></a></div>
  
    <div class="mid_s7_1 mart10"><a href="http://xnjd.tangyin.gov.cn/"  target="blank"><img src="images/zfjds.png" width="230" height="45" /></a></div>
<!--     暂时不知道放啥，暂时隐藏<div class="mid_s7_1 mart10"><a href="#"><img src="images/p04.jpg" width="230" height="45" /></a></div> -->
      </div>
  
  <div class="mid_s2 fl">
    <div class="tit_2">
    	<strong>数据查询</strong>
    </div>
	<div class="mid_s2_3">
      <ul>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=16&tableName=TABLE16&title=<%=PubFunc.encodeGB("GSP认证企业","gb2312") %>&bcId=137264307662573304836572767979" target="blank" >GSP认证企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=34&tableName=TABLE34&title=<%=PubFunc.encodeGB("GMP认证企业","gb2312") %>&bcId=137264310575012856826507074433" target="blank">GMP认证企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=22&tableName=TABLE22&title=<%=PubFunc.encodeGB("药品生产企业","gb2312") %>&bcId=137264318387574525528845120315" target="blank">药品生产企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=13&tableName=TABLE13&title=<%=PubFunc.encodeGB("药品零售企业","gb2312") %>&bcId=137264323448453682513826398962" target="blank">药品零售企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=21&tableName=TABLE21&title=<%=PubFunc.encodeGB("药品批发企业","gb2312") %>&bcId=137264328446815566113557156539" target="blank">药品批发企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=33&tableName=TABLE33&title=<%=PubFunc.encodeGB("药品互联网信息服务","gb2312") %>&bcId=137264335357844574264280509407" target="blank">药品互联网信息服务</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=30&tableName=TABLE30&title=<%=PubFunc.encodeGB("药品互联网交易服务","gb2312") %>&bcId=137264341854669919798476328327" target="blank">药品互联网交易服务</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=35&tableName=TABLE35&title=<%=PubFunc.encodeGB("医疗机构制剂企业","gb2312") %>&bcId=139045811325182096291699213499"target="blank">医疗机构制剂企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=26&tableName=TABLE26&title=<%=PubFunc.encodeGB("保健食品生产企业","gb2312") %>&bcId=132851743601566430057731773058" target="blank">保健食品生产企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=24&tableName=TABLE24&title=<%=PubFunc.encodeGB("化妆品生产企业","gb2312") %>&bcId=132851872782882632440855575788" target="blank">化妆品生产企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=27&tableName=TABLE27&title=<%=PubFunc.encodeGB("国产非特殊用途化妆品备案","gb2312") %>&bcId=134871904442166136549430059568" target="blank">国产非特殊用途化妆品备案</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=9&tableName=TABLE9&title=<%=PubFunc.encodeGB("医疗器械经营企业","gb2312") %>&bcId=121012751014546377776465162714" target="blank">医疗器械经营企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=5&tableName=TABLE5&title=<%=PubFunc.encodeGB("一类器械生产企业","gb2312") %>&bcId=120755854469429695161361812380" target="blank">一类器械生产企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=14&tableName=TABLE14&title=<%=PubFunc.encodeGB("二三类器械生产企业","gb2312") %>&bcId=121669461337516522252087485912" target="blank">二三类器械生产企业</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=20&tableName=TABLE20&title=<%=PubFunc.encodeGB("医疗器械产品注册","gb2312") %>&bcId=123381849010429524210060297162" target="blank">医疗器械产品注册</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=31&tableName=TABLE31&title=<%=PubFunc.encodeGB("医疗器械互联网信息服务","gb2312") %>&bcId=136834750256268826473677918772" target="blank">医疗器械互联网信息服务</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=16&tableName=TABLE16&title=<%=PubFunc.encodeGB("GSP认证企业","gb2312") %>&bcId=137264307662573304836572767979" target="blank">执业药师</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=7&tableName=TABLE7&title=<%=PubFunc.encodeGB("保健食品广告","gb2312") %>&bcId=120770657356991734105670081991" target="blank">保健食品广告</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=32&tableName=TABLE32&title=<%=PubFunc.encodeGB("医疗器械广告","gb2312") %>&bcId=136851894703177153617591522431" target="blank">医疗器械广告</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=19&tableName=TABLE19&title=<%=PubFunc.encodeGB("药品广告（省外）","gb2312") %>&bcId=122957089668787681481415763007" target="blank">药品广告（省外）</a></li>
        <li><a href="http://hda.gov.cn/interplugin/face2/base.jsp?tableId=18&tableName=TABLE18&title=<%=PubFunc.encodeGB("药品广告（省内）","gb2312") %>&bcId=122957003660995128852644429587" target="blank">药品广告（省内）</a></li>
      </ul>
    </div>
  </div>
  
  <div class="mid_s3 fl">
    <div class="tit_1">
    	<strong>系统入口</strong>
    </div>
    <div class="mid_s3_3">
    	<img src="images/system.png" usemap="#Map1" />
    	<map name="Map1" id="Map1">
		  <!--安全追溯-->
		  <area shape="poly" coords="66,29,117,16,120,49,91,61,67,30" href="<%=contextPath %>/index.jsp?systemcode=zsxt" />
		  <!--安全监管-->
		  <area shape="poly" coords="127,15,124,53,153,61,175,30,128,14" href="<%=contextPath %>/index.jsp?systemcode=jgxt" />
		  <!--执法办案-->		  
		  <area shape="poly" coords="180,41,162,64,177,83,213,75,183,42" href="<%=contextPath %>/index.jsp?systemcode=zfbaxt" />
		  <!--安全诚信-->
		  <area shape="poly" coords="218,87,179,97,180,129,221,138,217,88" href="<%=contextPath %>/index.jsp?systemcode=zxxt" />
		  <!--检验检测-->
		  <area shape="poly" coords="177,132,157,159,180,190,218,150,178,133" href="<%=contextPath %>/index.jsp?systemcode=jyjcxt" />
		  <!--公众服务-->
		  <area shape="poly" coords="152,163,121,169,121,208,174,193,153,162" href="#" />
		  <!--信息资源-->
		  <area shape="poly" coords="84,162,63,192,116,208,115,167,86,162" href="<%=contextPath %>/index.jsp?systemcode=xxzyjsxt" />
		  <!--电子政务-->
		  <area shape="poly" coords="80,152,54,187,23,148,61,131,79,153" href="<%=contextPath %>/index.jsp?systemcode=dzzwxt" />
		  <!--视频监控-->
		  <area shape="poly" coords="18,79,20,140,60,124,60,92,20,80" href="<%=contextPath %>/index.jsp?systemcode=spjkxt" />
		  <!--应急指挥-->
		  <area shape="poly" coords="81,62,60,84,24,73,59,34,82,62" href="<%=contextPath %>/index.jsp?systemcode=yjzhxt" />
		</map>
    </div>
  </div>
  
  <div class="h20 clear"></div>
</div><!--mid_bg.end-->

<div class="clear"></div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>