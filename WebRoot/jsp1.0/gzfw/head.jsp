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
<title>食品安全公众服务平台</title>
<link href="<%=contextPath%>/jsp/gzfw/css/basic.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/jsp/gzfw/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/jslib/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
window.onload = menuFix;

function menuFix() {
    var sfEls = document.getElementById("nav").getElementsByTagName("li");
    for (var i=0; i<sfEls.length; i++) {
        sfEls[i].onmouseover=function() {
        	this.className+=(this.className.length>0? " ": "") + "sfhover";
        }
        sfEls[i].onMouseDown=function() {
        	this.className+=(this.className.length>0? " ": "") + "sfhover";
        }
        sfEls[i].onMouseUp=function() {
        	this.className+=(this.className.length>0? " ": "") + "sfhover";
        }
        sfEls[i].onmouseout=function() {
        	this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"),"");
        }
    }
}

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore){
	selObj.selectedIndex=0;
  }
}

//漂浮图片第一部分js
//公共脚本文件 main.js   
function addEvent(obj, evtType, func, cap) {
    cap = cap || false;
    if (obj.addEventListener) {
        obj.addEventListener(evtType, func, cap);
        return true;
    } else if (obj.attachEvent) {
        if (cap) {
            obj.setCapture();
            return true;
        } else {
            return obj.attachEvent("on" + evtType, func);
        }
    } else {
        return false;
    }
}

function getPageScroll() {
    var xScroll, yScroll;
    if (self.pageXOffset) {
        xScroll = self.pageXOffset;
    } else if (document.documentElement && document.documentElement.scrollLeft) {
        xScroll = document.documentElement.scrollLeft;
    } else if (document.body) {
        xScroll = document.body.scrollLeft;
    }
    if (self.pageYOffset) {
        yScroll = self.pageYOffset;
    } else if (document.documentElement && document.documentElement.scrollTop) {
        yScroll = document.documentElement.scrollTop;
    } else if (document.body) {
        yScroll = document.body.scrollTop;
    }
    arrayPageScroll = new Array(xScroll, yScroll);
    return arrayPageScroll;
}
        
function GetPageSize() {
    var xScroll, yScroll;
    if (window.innerHeight && window.scrollMaxY) {
        xScroll = document.body.scrollWidth;
        yScroll = window.innerHeight + window.scrollMaxY;
    } else if (document.body.scrollHeight > document.body.offsetHeight) {
        xScroll = document.body.scrollWidth;
        yScroll = document.body.scrollHeight;
    } else {
        xScroll = document.body.offsetWidth;
        yScroll = document.body.offsetHeight;
    }
    var windowWidth, windowHeight;
    if (self.innerHeight) {
        windowWidth = self.innerWidth;
        windowHeight = self.innerHeight;
    } else if (document.documentElement && document.documentElement.clientHeight) {
        windowWidth = document.documentElement.clientWidth;
        windowHeight = document.documentElement.clientHeight;
    } else if (document.body) {
        windowWidth = document.body.clientWidth;
        windowHeight = document.body.clientHeight;
    }
    if (yScroll < windowHeight) {
        pageHeight = windowHeight;
    } else {
        pageHeight = yScroll;
    }
    if (xScroll < windowWidth) {
        pageWidth = windowWidth;
    } else {
        pageWidth = xScroll;
    }
    arrayPageSize = new Array(pageWidth, pageHeight, windowWidth, windowHeight)
    return arrayPageSize;
}

var AdMoveConfig = new Object();
AdMoveConfig.IsInitialized = false;
AdMoveConfig.ScrollX = 0;
AdMoveConfig.ScrollY = 0;
AdMoveConfig.MoveWidth = 0;
AdMoveConfig.MoveHeight = 0;
AdMoveConfig.Resize = function() {
    var winsize = GetPageSize();
    AdMoveConfig.MoveWidth = winsize[2];
    AdMoveConfig.MoveHeight = winsize[3];
    AdMoveConfig.Scroll();
}
AdMoveConfig.Scroll = function() {
    var winscroll = getPageScroll();
    AdMoveConfig.ScrollX = winscroll[0];
    AdMoveConfig.ScrollY = winscroll[1];
}
addEvent(window, "resize", AdMoveConfig.Resize);
addEvent(window, "scroll", AdMoveConfig.Scroll);
	
function AdMove(id) {
    if (!AdMoveConfig.IsInitialized) {
        AdMoveConfig.Resize();
        AdMoveConfig.IsInitialized = true;
    }
    var obj = document.getElementById(id);
    obj.style.position = "absolute";
    var W = AdMoveConfig.MoveWidth - obj.offsetWidth;
    var H = AdMoveConfig.MoveHeight - obj.offsetHeight;
    var x = W * Math.random(), y = H * Math.random();
    var rad = (Math.random() + 1) * Math.PI / 6;
    var kx = Math.sin(rad), ky = Math.cos(rad);
    var dirx = (Math.random() < 0.5 ? 1 : -1), diry = (Math.random() < 0.5 ? 1 : -1);
    var step = 1;
    var interval;
    this.SetLocation = function(vx, vy) { x = vx; y = vy; }
    this.SetDirection = function(vx, vy) { dirx = vx; diry = vy; }
    obj.CustomMethod = function() {
        obj.style.left = (x + AdMoveConfig.ScrollX) + "px";
        obj.style.top = (y + AdMoveConfig.ScrollY) + "px";
        rad = (Math.random() + 1) * Math.PI / 6;
        W = AdMoveConfig.MoveWidth - obj.offsetWidth;
        H = AdMoveConfig.MoveHeight - obj.offsetHeight;
        x = x + step * kx * dirx;
        if (x < 0) { dirx = 1; x = 0; kx = Math.sin(rad); ky = Math.cos(rad); }
        if (x > W) { dirx = -1; x = W; kx = Math.sin(rad); ky = Math.cos(rad); }
        y = y + step * ky * diry;
        if (y < 0) { diry = 1; y = 0; kx = Math.sin(rad); ky = Math.cos(rad); }
        if (y > H) { diry = -1; y = H; kx = Math.sin(rad); ky = Math.cos(rad); }
    }
    this.Run = function() {
        var delay = 25; //移动速度   
        interval = setInterval(obj.CustomMethod, delay);
        obj.onmouseover = function() { clearInterval(interval); }
        obj.onmouseout = function() { interval = setInterval(obj.CustomMethod, delay); }
    }
}   
        
function closediv(){
	var divid = document.getElementById("ad1");
	divid.style.display = "none";
}
</script>
</head>
<body>
<div id="ad1">
    <table>
		<tr align="center">		
			<td><strong><font color="red">&nbsp;&nbsp;扫描下载手机客户端</font></strong></td>
		</tr>
		<tr align="center">
		    <td>&nbsp;&nbsp;<img src="<%=contextPath%>/jsp/gzfw/images/ty.png" width="110px" height="130px" alt="扫一扫下载"/></td>
    	</tr>
	    <tr align="center">
	        <td><a href="#" onclick="closediv()" title="点击关闭">关闭</a></td>
	    </tr>
    </table>
</div>
<script type="text/javascript" language="javascript">   
    //漂浮图片第二部分js
    var ad1 = new AdMove("ad1");
    //ad1.Run();
</script>
<div class="top_box">
  <div class="top_bg">
    <div class="top_3">
      <div class="top_3a fl">欢迎光临食品安全公众服务平台！</div>
     <!-- 和底部重复;暂时隐藏  <div class="top_3b fr">
	      <a href="<%=contextPath%>/jsp/gzfw/index.jsp" target="_self">网站首页</a>
	      &nbsp;|&nbsp;
	      <a href="<%=contextPath%>/jsp/gzfw/consult.jsp" target="_self">问题咨询</a>
	      &nbsp;|&nbsp;
	      <a href="javascript:void(0)" onclick="setHome(this,window.location)">设为首页</a>
	      &nbsp;|&nbsp;
	      <a href="javascript:void(0)" onclick="addFav(document.title,window.location)">加入收藏</a>
      </div>-->
    </div>
    <div class="top_1">
      <div class="top_1a"><img src="<%=contextPath%>/jsp/gzfw/images/bg08.jpg" width="980" height="180" usemap="#Map" border="0" />
        <map name="Map" id="Map">
          <area shape="rect" coords="13,38,182,128" href="<%=contextPath %>/jsp/gzfw/index.jsp" />
        </map>
      </div>
<!--       <div class="top_1b"> -->
<!-- 		<img src="<%=contextPath%>/jsp/gzfw/images/yuefeimiao.png" width="350" height="180"/> -->
<!--       </div> -->
<%--      <div class="top_1b">--%>
<%--		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="400" height="180">--%>
<%--          <param name="movie" value="<%=contextPath%>/jsp/gzfw/images/banner.swf" />--%>
<%--          <param name="quality" value="high" />--%>
<%--          <param name="wmode" value="transparent" />--%>
<%--          <embed src="<%=contextPath%>/jsp/gzfw/images/banner.swf" quality="high" wmode="transparent" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="400" height="180"></embed>--%>
<%--		</object>--%>
<%--      </div>--%>
    </div>
    <div class="top_2">
      <ul id="nav">
          <li class="nav_bj01"><a href="<%=contextPath %>/jsp/gzfw/index.jsp" class="nav_bj01"></a></li>
          <li class="nav_tb"><img src="<%=contextPath%>/jsp/gzfw/images/bg05.gif" width="3" height="41" /></li>
          
          <li class="nav_bj02"><a href="<%=contextPath %>/jsp/gzfw/jggk.jsp" class="nav_bj02"></a>
            <ul>
	            <li> <a href="<%=contextPath %>/jsp/gzfw/jggk.jsp">机构概况</a></li>
	            <li> <a href="<%=contextPath %>/jsp/gzfw/gdjg.jsp">各地机构</a></li>
            </ul>
          </li>
          <li class="nav_tb"><img src="<%=contextPath%>/jsp/gzfw/images/bg05.gif" width="3" height="41" /></li>
          
          <li class="nav_bj03"><a href="<%=contextPath %>/news/queryNewsList?retPageStr=fl&pageSize=20&cateJc=flfg_fl&page=1" class="nav_bj03"></a>
            <ul>
	            <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=fl&pageSize=20&cateJc=flfg_fl&page=1">法律</a></li>
	            <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=xzfg&pageSize=20&cateJc=flfg_xzfg&page=1">行政法规</a></li>
	            <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=gz&pageSize=20&cateJc=flfg_gz&page=1">规章</a></li>
	            <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=gfxwj&pageSize=20&cateJc=flfg_gfxwj&page=1">规范性文件</a></li>
            </ul>
          </li>
          <li class="nav_tb"><img src="<%=contextPath%>/jsp/gzfw/images/bg05.gif" width="3" height="41" /></li>
          
          <li class="nav_bj04"><a href="<%=contextPath %>/news/queryNewsList?retPageStr=ggtz&pageSize=20&cateJc=ggtz_sp&page=1" class="nav_bj04"></a>
            <ul>
              <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=ggtz&pageSize=20&cateJc=ggtz_sp&page=1" >食品</a></li>
              <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=ggtz&pageSize=20&cateJc=ggtz_yp&page=1" >药品</a></li>
              <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=ggtz&pageSize=20&cateJc=ggtz_bjp&page=1" >保健品</a></li>
              <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=ggtz&pageSize=20&cateJc=ggtz_hzp&page=1" >化妆品</a></li>
              <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=ggtz&pageSize=20&cateJc=ggtz_ylqx&page=1" >医疗器械</a></li>
              <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=ggtz&pageSize=20&cateJc=ggtz_zyys&page=1" >执业药师</a></li>
              <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=ggtz&pageSize=20&cateJc=ggtz_qt&page=1" >其他</a></li>
            </ul>
          </li>
          <li class="nav_tb"><img src="<%=contextPath%>/jsp/gzfw/images/bg05.gif" width="3" height="41" /></li>
          
          <li class="nav_bj09"><a href="<%=contextPath %>/news/queryNewsList?retPageStr=qxdt&pageSize=20&cateJc=qxdt&page=1" class="nav_bj09"></a>
            <ul>
	            <li> <a href="<%=contextPath %>/news/queryNewsList?retPageStr=qxdt&pageSize=20&cateJc=qxdt&page=1">县乡动态</a></li>
            </ul>
          </li>         
          <li class="nav_tb"><img src="<%=contextPath%>/jsp/gzfw/images/bg05.gif" width="3" height="41" /></li>
          
          <li class="nav_bj06"><a href="<%=contextPath %>/news/queryBordList?retPageStr=cxhhb&pageSize=20&cateJc=ggtz_sp&page=1" class="nav_bj06"></a>
            <ul>
              <li><a href="<%=contextPath %>/news/queryBordList?retPageStr=cxhhb&pageSize=20&cateJc=ggtz_sp&page=1">红黑榜</a></li>
              <li><a href="<%=contextPath %>/news/queryNewsList?retPageStr=xfgs&pageSize=20&cateJc=xfgs&page=1">消费公示</a></li>
              <li><a href="http://www.pbccrc.org.cn" target="blank">企业征信查询</a></li>
              <li><a href="http://219.154.38.19:8080" target="blank">微企信用查询</a></li>
            </ul>
          </li>          
          <li class="nav_tb"><img src="<%=contextPath%>/jsp/gzfw/images/bg05.gif" width="3" height="41" /></li>
          
          <li class="nav_bj07"><a href="<%=contextPath %>/jsp/gzfw/progress.jsp" class="nav_bj07"></a>
            <ul>
               <li><a href="<%=contextPath %>/news/queryNewsList?retPageStr=bszn&pageSize=20&cateJc=bszn&page=1">办事指南</a></li>
               <li><a href="<%=contextPath%>/jsp/gzfw/progress.jsp">执法办案进度查询</a></li>
               <li><a href="<%=contextPath%>/jsp/gzfw/progressXksp.jsp">许可审批进度查询</a></li>
            </ul>
          </li>          
          <li class="nav_tb"><img src="<%=contextPath%>/jsp/gzfw/images/bg05.gif" width="3" height="41" /></li>
          
          <li class="nav_bj08"><a href="<%=contextPath %>/jsp/gzfw/wtzx.jsp" class="nav_bj08"></a>
            <ul>
		      <li ><a href="<%=contextPath %>/jsp/gzfw/wtzx.jsp" >问题咨询</a></li>
		      <li ><a href="<%=contextPath %>/jsp/gzfw/fwts.jsp">服务投诉</a></li>
		      <li ><a href="<%=contextPath %>/jsp/gzfw/yjzq.jsp">意见征求</a></li>
		      <li ><a href="<%=contextPath %>/jsp/gzfw/mail.jsp">领导信箱</a></li>		      
            </ul>
          </li>
      </ul>
    </div>

    <div class="clear"></div>
  </div><!--top_bg.end-->
  <div class="clear"></div>
</div><!--top_box.end-->

<div class="clear"></div>
</body>
</html>