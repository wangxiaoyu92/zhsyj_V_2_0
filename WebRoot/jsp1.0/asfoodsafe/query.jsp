<%@ page language="java"
	pageEncoding="UTF-8"%>
<%@ include file="query_head_new.jsp"%>
<%@ page import="java.util.List,com.askj.spsy.dto.QproductDTO" %>
<%@ page import="com.askj.spsy.entity.Qproductjc,com.zzhdsoft.siweb.entity.Fj" %>
<%@ page import="com.askj.spsy.entity.Qproductszgcxx" %>
<%@ page import="com.askj.spsy.dto.QsymqrylogDTO"%>
<%
	//String path = request.getContextPath();
//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String sym=null==request.getParameter("sym")?"":request.getParameter("sym").toString();

    String sym=request.getAttribute("sym").toString();
	// 产品信息
	QproductDTO v_productInfo=(QproductDTO)request.getAttribute("productInfo");
	
	// 产品材料信息
	List<QproductDTO> v_productClInfo=(List<QproductDTO>)request.getAttribute("productClInfo");
	
	// 产品检测信息
	List<Qproductjc> v_productJcInfo=(List<Qproductjc>)request.getAttribute("productJcInfo");	
	
	// 产品生产生长信息信息
	List<Qproductszgcxx> v_productScszInfo=(List<Qproductszgcxx>)request.getAttribute("productScszInfo");
	
	// 产品图片信息
	List<Fj> v_fjlist=(List<Fj>)request.getAttribute("proPiclist");
	
	// 产品视频信息
	List<Fj> v_fjvideolist=(List<Fj>)request.getAttribute("fjvideolist");	
	
	// 产品检验检测信息
	List<Fj> v_jyjcPiclist=(List<Fj>)request.getAttribute("jyjcPiclist");	
	
	// 溯源码查询信息
	QsymqrylogDTO v_QsymqrylogDTO=(QsymqrylogDTO)request.getAttribute("QsymqrylogDTO");	
	
	Qproductszgcxx growth_bean;
	Qproductjc jcbean;
	Fj video_bean; 
	Fj fj_bean;
	String v_sym_state="";
	if (v_productInfo!=null){
		v_sym_state="ok";
	}
	

/* BsSymService service=null;
ProductDto bean=null;
List dataList=null;
List fj_dataList=null;
List growth_dataList=null;
List jc_dataList=null;
List video_dataList=null;
BsProductFj fj_bean=null;
BsProductFj video_bean=null;
BsProductInfo growth_bean=null;
BsProductJc jcbean=null;
int currFjCount=0;
String sym_state="";
String sym_query_log="";
if(!"".equals(sym)){
	service=new BsSymService();
	sym_state=service.checkSym(sym);
	if("ok".equals(sym_state)){
		sym_query_log=service.getQueryLog(sym);
		bean=service.getProductBasicInfo(sym);
		dataList=service.getProductFjInfo(sym);
		fj_dataList=service.getProductFjInfo(sym);
		growth_dataList=service.getProductGrowthInfo(sym);
		jc_dataList=service.getProductJcjyInfo(sym);
		//获取当前的产品视频
		video_dataList=service.getProductVideoFjInfo(sym);
	}
} */
%>
<base href="<%=basePath%>">
<title>二维码溯源查询</title>
<script>
<%-- 	var sym='<%=sym%>';
	var sym_state='<%=sym_state%>';
	if(sym.length==0){
		alert('请输入追溯码！');
		top.location.href='index.jsp';
	}
	if(sym.length>0 && sym_state!="ok"){
	    alert('不好意思，系统平台查询不到此追溯码，请输入有效的追溯码！');
		top.location.href='index.jsp';
	} --%>
	//data-collapsed-icon="arrow-d" data-expanded-icon="arrow-u"
	
    </script>
	<!--map qq-->
	<script charset="utf-8"
		src="http://map.qq.com/api/js?v=2.exp?v=2.exp&key=BNJBZ-PCEW4-LX4UT-XAHJP-H5JZ7-LNBFS"></script>
	<script type="text/javascript" src="<%=basePath %>jsp/asfoodsafe/js/location.js"></script>
	           
</head>

<script type="text/javascript">
  var sym_state="<%=v_sym_state%>";
  var v_local_sym="<%=sym%>";
  var v_local_path="<%=basePath%>";
  $(function(){
	  if (sym_state=="ok"){
		  mygetlocation(); 
	  }
  })   
</script>
<body class="page-swipe">

	<div data-role="content">
		<p id="tip">
			<%
				/* 	String[] logData=new String[3];
				logData[0]="0";
				logData[1]="0000-00-00 00:00:00.0";
				logData[2]="未知";
				
				if(!"★★".equals(sym_query_log) && sym_query_log.length()>2){
					logData=sym_query_log.split("★");
					out.println("商品第"+(Integer.parseInt(logData[0])+1)+"次查询,上次查询时间："+logData[1].substring(0,logData[1].length()-2)+",<br/>查询地点："+logData[2]+".");
				}else{
					out.println("商品第"+(Integer.parseInt(logData[0])+1)+"次查询.");
				} */
				if (v_QsymqrylogDTO!=null ){
					out.println("商品第"+(v_QsymqrylogDTO.getQrycount()+1)+"次查询,上次查询时间："+v_QsymqrylogDTO.getQrytime()+",<br/>查询地点："+v_QsymqrylogDTO.getQryposition()+".");
				}
			%>

		</p>

		<div data-role="collapsible-set" data-theme="b" data-content-theme="d">
			<div data-role="collapsible" data-collapsed="false"
				data-collapsed-icon="plus" data-expanded-icon="minus">
				<h3>基本信息</h3>
				<div class="block">
					<span class="left_info">追溯码</span> <span class="right_info"
						id="_code"><%=sym%></span>
				</div>
				<div class="block">
					<span class="left_info">商品名称</span> <span class="right_info"><%=v_productInfo.getProname()%></span>
				</div>
				<div class="block">
					<span class="left_info">生产企业</span> <span class="right_info"><%=v_productInfo.getCommc()%></span>
				</div>
				<%-- 			<div class="block">
					<span class="left_info">厂家网址</span>
					<span class="right_info" ><a href="<%=v_productInfo.get %>" data-rel="external"><%=bean.getComWeb() %></a></span>
			</div> --%>
				<div class="block">
					<span class="left_info">产品批次</span> <span class="right_info"><%=v_productInfo.getCppcpch()%></span>
				</div>
				<div class="block">
					<span class="left_info">产地</span> <span class="right_info"><%=v_productInfo.getComdz()%></span>
				</div>
				<div class="block">
					<span class="left_info">商品条码</span> <span class="right_info"><%=v_productInfo.getProsptm()%></span>
				</div>
				<%-- 			<div class="block" id="web_address_block">
					<span class="left_info">产品标准代号</span>
					<span class="right_info"><%=bean.getProCpbzh()%></span>
			</div> --%>
				<div class="block">
					<span class="left_info">生产日期</span> <span class="right_info"><%=v_productInfo.getCppcscrq()%></span>
				</div>
				<div class="block">
					<span class="left_info">保质期</span> <span class="right_info"><%=v_productInfo.getProbzq()%></span>
				</div>
				<div class="block">
					<span class="left_info">规格型号</span> <span class="right_info"><%=v_productInfo.getProgg()%></span>
				</div>
				<div class="block">
					<span class="left_info">包装规格</span> <span class="right_info"><%=v_productInfo.getProbzgg()%></span>
				</div>
				<div class="block">
					<span class="left_info">配料信息</span> <span class="right_info"><%=v_productInfo.getProplxx()%></span>
				</div>
			</div>

			<div data-role="collapsible" data-collapsed-icon="plus"
				data-expanded-icon="minus">
				<h3>产品图片</h3>
				<header>
					<div id="slider" class="swipe"
						style="visibility: visible;margin-top:-35px;">
						<div class="swipe-wrap">
							<%
								if(null!=v_fjlist && v_fjlist.size()>0){
									for(int i=0;i<v_fjlist.size();i++){
										fj_bean=(Fj)v_fjlist.get(i);
										System.out.println("kkkkkkkkkkkkkkkkkkkmmm "+basePath + fj_bean.getFjpath());
										out.println("<figure>");
							            out.println("<div class=\"wrap\">");
							            out.println("<div class=\"image\" style=\"background:url("+basePath + fj_bean.getFjpath()+") center no-repeat;background-size: cover\"> </div>");
							            out.println("</div>");
							            out.println("</figure>");
										//out.println("<a href=\""+basePath+fj_bean.getFjPath()+"\" title=\"\"><img src=\""+basePath+fj_bean.getFjPath()+"\"></a>");
									}
								}else{
								   out.println("<figure><div class=\"wrap\"><div class=\"image\" style=\"background:url(images/notp.jpg) center no-repeat;background-size: cover\"> </div></div></figure>");
								}
							%>

						</div>
					</div>
					<nav>
						<ul id="position">
							<li class="on"></li>
							<li class=""></li>
							<li class=""></li>
							<li class=""></li>
						</ul>
					</nav>
				</header>

				<script src="<%=basePath %>jslib/swipe/swipe.js"></script>
				<script>
var slider =
  Swipe(document.getElementById('slider'), {
    auto: 3000,
    continuous: true,
    callback: function(pos) {

      var i = bullets.length;
      while (i--) {
        bullets[i].className = ' ';
      }
      bullets[pos].className = 'on';

    }
  });
var bullets = document.getElementById('position').getElementsByTagName('li');
</script>
			</div>

			<div data-role="collapsible" data-collapsed-icon="plus"
				data-expanded-icon="minus">
				<h3>生长/生产信息</h3>
				<table width="100%" class="table_border mytable"
					bordercolor="#dddddd" cellspacing="0" border="1" cellpadding="0">
					<thead>
						<tr align=center>
							<td class="width4">操作人</td>
							<td class="width4">操作内容</td>
							<td class="width4">操作日期</td>
							<td class="width4">备注</td>
						</tr>
					</thead>
					<tbody>
						<%
							if(null!=v_productScszInfo && v_productScszInfo.size()>0){
							for(int i=0;i<v_productScszInfo.size();i++){
								growth_bean=(Qproductszgcxx)v_productScszInfo.get(i);
								out.println("<tr>");
								out.println("<td>"+growth_bean.getSzgcczr()+"</td>");
								out.println("<td>"+growth_bean.getSzgccznr()+"</td>");
								out.println("<td>"+growth_bean.getSzgcczrq()+"</td>");
								out.println("<td>"+growth_bean.getSzgcbz()+"</td>");
								out.println("</tr>");
							}
								}else{
							out.println("<tr><td colspan=\"4\">暂无生长信息</td></tr>");
								}
						%>
					</tbody>
				</table>
			</div>
			<div data-role="collapsible" data-collapsed-icon="plus"
				data-expanded-icon="minus">
				<h3>检测信息</h3>
				<table width="100%" class="table_border mytable"
					bordercolor="#dddddd" cellspacing="0" border="1" cellpadding="0">
					<tdead>
					<tr align=center>
						<td class="width4">检测项目</td>
						<td class="width4">检测结果</td>
						<td class="width4">检测单位</td>
						<td class="width4">检测时间</td>
					</tr>
					</thead>
					<tbody>
						<%
							if(null!=v_productJcInfo && v_productJcInfo.size()>0){
							for(int i=0;i<v_productJcInfo.size();i++){
								jcbean=(Qproductjc)v_productJcInfo.get(i);
								out.println("<tr>");
								out.println("<td>"+jcbean.getJcitem()+"</td>");
								out.println("<td>"+jcbean.getJcjg()+"</td>");
								out.println("<td>"+jcbean.getJcdw()+"</td>");
								out.println("<td>"+jcbean.getJcsj()+"</td>");
								out.println("</tr>");
							}
								}else{
							out.println("<tr><td colspan=\"4\">暂无检测信息</td></tr>");
								}
						%>
					</tbody>
				</table>
			</div>

			<%
				if(null!=v_fjvideolist && v_fjvideolist.size()>0){
				out.println("<div data-role=\"collapsible\" data-collapsed-icon=\"plus\" data-expanded-icon=\"minus\">");
				out.println("<h3>产品视频</h3>");
				out.println("<div id=\"a1\" style=\"width:90%\"></div>");
				out.println("<script type=\"text/javascript\" src=\""+basePath+"jslib/ckplayer/ckplayer/ckplayer.js\" charset=\"utf-8\"></script>");
				out.println("<script type=\"text/javascript\">");
				out.println("var flashvars={");
				out.println("p:1,");
				out.println("c:0,");
				out.println("h:4,");
				out.println("e:1");
				out.println("};");
				//var video=['http://www.asfoodsafe.com/ckplayer/kyswkj.mp4->video/mp4','http://movie.ks.js.cn/flv/other/1_0.mp4->video/mp4'];
				out.println("var video=[");
				String fj_path="";
				String fj_exp="";
				for(int i=0;i<v_fjvideolist.size();i++){
					video_bean=(Fj)v_fjvideolist.get(i);
					fj_path=video_bean.getFjpath();//uploads/20150107162350015.flv
					fj_exp=fj_path.substring(fj_path.lastIndexOf(".")+1,fj_path.length());
					out.print("'"+basePath+fj_path+"->video/"+fj_exp+"'");
				}
				out.println("];");
				out.println("var support=['all'];");
				out.println("CKobject.embedHTML5('a1','ckplayer_a1','90%','100%',video,flashvars,support);");
				out.println("</script>");
				out.println("</div>");	
					}
			%>



		</div>
	</div>
	

</body>
</html>