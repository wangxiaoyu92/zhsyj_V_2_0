$(function(){
	
	// 加载餐饮推荐企业
	//getCyEnterprise();
	// 记载菜市场推荐企业
	//getCscEnterprise();
	// 加载图片新闻内容
	getNews();
	getPvCount();
	// 加载点评信息
	//getDps();
	// 加载投诉信息
	//getTss();
	// 新闻图片处理
//	var bannerSlider = new Slider($('#banner_tabs'), {
//		time: 5000,
//		delay: 400,
//		event: 'hover',
//		auto: true,
//		mode: 'fade',
//		controller: $('#bannerCtrl'),
//		activeControllerCls: 'active'
//	});
//	$('#banner_tabs .flex-prev').click(function() {
//		bannerSlider.prev()
//	});
//	$('#banner_tabs .flex-next').click(function() {
//		bannerSlider.next()
//	});
	//导航栏加载
//	$(".menu ul li").hover(function(){
//		$(this).find(".son").stop(true,true).slideDown();
//		},function(){
//			$(this).find(".son").stop(true,true).slideUp();
//	});
});
function getPvCount(){
	$.ajax({
		type: "POST",
		url : "../enterpriseController/getPvCount.do",
		dataType: "text",
		async:true,
		success:function(result){
			$("#pvcount").html(result);
		}
		});
}

// 加载页面需要的推荐的企业
function getCyEnterprise(){
	// 加载数据
	$.ajax({
		type: "POST",
		url : "../enterpriseController/getEnterpriseByCyTj.do",
		dataType: "text",
		async:false,
		success:function(result){
			var data = eval('('+result+')');
			var outsizeStr = ""; // 特大型餐饮企业
			var bigStr = ""; // 大型餐饮企业
			var middleStr = ""; // 中型餐饮企业
			var smallStr = ""; // 小型餐饮企业
			var otherStr = "";  //其他
			var score = ""; // 积分
			var scoreimg = ""; // 积分对应的图片
			/*if(score >= 90){
				scoreimg = "<img src='../static/images/small_a1.png'/>";
			}else if(score >= 80 && score < 90){
				scoreimg = "<img src='../static/images/small_a2.png'/>";
			}else if(score >= 70 && score < 80){
				scoreimg = "<img src='../static/images/small_b1.png'/>";
			}else if(score >= 60 && score < 70){
				scoreimg = "<img src='../static/images/small_b2.png'/>";
			}else{
				scoreimg = "<img src='../static/images/small_c.png'/>";
			}*/
			// 根据得到的data数据进行遍历
			var csclogo = "<img src='../static/images/cylogo.png' />";
			$.each(data.outsize,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				outsizeStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")'>"+enterprisename+"</a>"+
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getCyLevel(entry["score"])+"</p></div> </li>";
			});
			$.each(data.big,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				bigStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")'>"+enterprisename+"</a>"+
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getCyLevel(entry["score"])+"</p></div> </li>";
			});
			$.each(data.middle,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				middleStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")'>"+enterprisename+"</a>"+
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getCyLevel(entry["score"])+"</p></div> </li>";
			});
			$.each(data.small,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				smallStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")'>"+enterprisename+"</a>"+
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getCyLevel(entry["score"])+"</p></div> </li>";
			});
			$.each(data.other,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				otherStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")'>"+enterprisename+"</a>"+
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getCyLevel(entry["score"])+"</p></div> </li>";
			});
			// 写入div中
			$("#div_outsize").html("");
			$("#div_outsize").html(outsizeStr);
			$("#div_big").html("");
			$("#div_big").html(bigStr);
			$("#div_middle").html("");
			$("#div_middle").html(middleStr);
			$("#div_small").html("");
			$("#div_small").html(smallStr);
			$("#div_other").html("");
			$("#div_other").html(otherStr);
		}
	})
}

function getCyLevel(score){
	var scoreimg = ""; // 积分对应的图片
	if(score >= 28){
		scoreimg = "<img src='../static/images/small_a1.png'/>";
	}else if(score >= 26 && score < 28){
		scoreimg = "<img src='../static/images/small_a2.png'/>";
	}else if(score >= 24 && score < 26){
		scoreimg = "<img src='../static/images/small_b1.png'/>";
	}else if(score >= 12 && score < 24){
		scoreimg = "<img src='../static/images/small_b2.png'/>";
	}else{
		scoreimg = "<img src='../static/images/small_c.png'/>";
	}
	return scoreimg;
}

// 首页加载菜市场推荐的信息
function getCscEnterprise(){
	// 加载数据
	$.ajax({
		type: "POST",
		url : "../enterpriseController/getEnterpriseByCscTj.do",
		dataType: "text",
		async:false,
		success:function(result){
			var data = eval('('+result+')');
			var pfscStr = ""; // 批发市场
			var lsscStr = ""; // 零售市场
			var csStr = ""; // 超市
			var dsStr = ""; // 电商
			var llccStr = "";
			// 根据得到的data数据进行遍历
			var csclogo = "<img src='../static/images/csclogo.png' />";
			$.each(data.pfsc,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				pfscStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")' >"+enterprisename+"</a>"+
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getStar(entry["score"])+"</p></div> </li>";
			});
			$.each(data.lssc,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				lsscStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")' >"+enterprisename+"</a>"+
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getStar(entry["score"])+"</p></div> </li>";
			});
			$.each(data.cs,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				csStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")' >"+enterprisename+"</a>"+
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getStar(entry["score"])+"</p></div> </li>";
			});
			$.each(data.ds,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				dsStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")' >"+enterprisename+"</a>"+
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getStar(entry["score"])+"</p></div> </li>";
			});
			$.each(data.llcc,function(index,entry){
				var enterprisename = entry["name"];
				if(enterprisename.length>11){
					enterprisename = enterprisename.substring(0,10)+"...";
				}
				llccStr += "<li>"+csclogo+"<a href='qyxq.jsp?id="+entry["id"]+"&systype="+entry["systype"]+"' target='self' onmouseout='hiddenDiv(\""+entry["id"]+"\")' onmouseover='showDiv(\""+entry["id"]+"\")' >"+enterprisename+"</a>" +
				"<div id='"+entry["id"]+"' style='display:none;position:absolute;border:1px solid silver;background:white;border-radius:3px;margin-left:25px;' ><p style='margin:0;padding:5px;'>负责人："+entry["legaler"]+"</p><p style='margin:0;padding:5px;'>综合指数："+getStar(entry["score"])+"</p></div> </li>";
			});
			// 写入div中
			$("#div_pfsc").html("");
			$("#div_pfsc").html(pfscStr);
			$("#div_lssc").html("");
			$("#div_lssc").html(lsscStr);
			$("#div_cs").html("");
			$("#div_cs").html(csStr);
			$("#div_ds").html("");
			$("#div_ds").html(dsStr);
			$("#div_llcc").html("");
			$("#div_llcc").html(llccStr);
		}
	})
}

function getStar(score){
	var cs = 0; // 需要循环的次数
	var xj= "";
	if(score >= 90 && score <= 100){
		cs = 5;
	}else if(score >= 80 && score < 90){
		cs = 4;
	}else if(score >= 70 && score < 80){
		cs = 3;
	}else if(score >= 60 && score < 70){
		cs = 2;
	}else{
		cs = 1;
	}
	
	for ( var i = 0; i < cs; i++) {
		xj += "<img style='float:none;margin:0;' src='images/start.jpg'/>"
	}
	return xj;
}

function showDiv(id){
	$("#"+id).show();
}
function hiddenDiv(id){
	$("#"+id).hide();
}
// 图片新闻的加载
function getNews(){
	// 加载数据
	$.ajax({
		type: "POST",
		url : "../newsController/getNewsXwggByTj.do",
		dataType: "text",
		async:false,
		success:function(result){
			
			var data = eval('('+result+')');
			var str = ""; // 新闻内容
			var ulpic = ""; // 新闻图片
			// 根据得到的data数据进行遍历
			$.each(data,function(index,entry){
				var newsname = entry["title"];
				if(entry["title"].length>22){
					newsname=entry["title"].substring(0,22)+"...";
				}
				var tppic="";
				if(entry["sysType"]=="1"){
					tppic = "http://222.184.79.76:8089/"+entry["imgurl"];
				}else if(entry["sysType"]=="2"){
					tppic = "http://222.184.79.76:8888/"+entry["imgurl"];
				}else{
					tppic = "http://222.184.79.76:8079/tmcsc/"+entry["imgurl"];
				}
				str += "<li><a href='news.jsp?newsId="+entry["id"]+"' target='self' >"+newsname+"</a></li>";
				ulpic += "<li><a title='' target='self' href='news.jsp?newsId="+entry["id"]+"'><img width='425px' height='305px' alt='' text='' src='"+tppic+"'></a>"
				+"<div class='layout2_mask'></div><div class='layout2_comt'><h2>"+newsname+"</h2></div></li>";
				/*ulpic += "<li><a title='' target='self' href='#'><img width='480px' height='305px' alt='' style='background: url("+tppic+") no-repeat center;' ></a></li>"*/
			});
			// 写入div中
			/*$("#div_news").html("");
			$("#div_news").html(str);*/
			// 写入图片
			$("#contentList2").html("");
			$("#contentList2").html(ulpic);
			$("#ul_news").html("");
			$("#ul_news").html(str);
		}
	});
//	new Marquee(
//			{
//				MSClass	  : ["slider_box2","contentList2","previewList2"],
//				Direction : 2,
//				Step	  : 0.3,
//				Width	  : 425,
//				Height	  : 305,
//				Timer	  : 30,
//				DelayTime : 5000,
//				AutoStart : true
//	});
}
//过滤html字符
function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
    str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
    str=str.replace(/ /ig,'');//去掉 
    return str;
}
// 记载15条点评内容
function getDps(){
	// 加载数据
	$.ajax({
		type: "POST",
		url : "../evaluateController/indexEvaluate.do?topcount=10",
		dataType: "text",
		async:false,
		success:function(result){
			var data = eval('('+result+')');
			var str = ""; // 信息内容
			// 根据得到的data数据进行遍历
			$.each(data,function(index,entry){
				var id = entry["id"]; // 编号
				var enterprisename = entry["name"]; // 企业名
				var content = entry["content"]; // 点评内容
				content=removeHTMLTag(content);
				if(content == null || content == ""){
					content = "暂无点评内容！";
				}else if(content.length > 30){
					content = content.substring(0,30) +"...";
				}
				if(enterprisename == null || enterprisename == ""){
					enterprisename = "淮安宏进蔬菜批发市场";
				}
				var userphone = entry["userphone"]; // 用户名
				if(userphone == null || userphone == ''){
					userphone = "游客";
				}
				var systype = entry["systype"]; // 企业类别, 根据企业类型显示不同的图标
				var dpnr = /*"用户："+userphone+",点评了企业："+*/enterprisename;
				var qylogo = ""; // 企业小图标
				if(systype == "1"){
					qylogo = "<img src='../static/images/sclogo.png' />";
				}else if(systype == "2"){
					qylogo = "<img src='../static/images/cylogo.png' />";
				}else{
					qylogo = "<img src='../static/images/csclogo.png' />";
				}
				// 处理日期
				var nDate = new Date(entry['addtime']);
				var nowdate = nDate.getDate();
				if(nowdate < 10){
					nowdate = "0"+nowdate;
				}
				var newdate = nDate.getFullYear()+"-"+(nDate.getMonth()+1)+"-"+nowdate;
				str += "<li style='border-bottom: 1px dashed #c2e2f1;'>";
				str += qylogo+"企业名称：<a href='javascript:void(0)' onclick='showdpinfo(\""+id+"\",\""+systype+"\")'>"+dpnr+"</a><br/>";
				str += "<span style='float:left;'>内容："+content+"</span><span style='float:right;padding-right:10px;'>日期："+newdate+"</span>";
				str += "</li>";
			});
			// 写入ul点评中
			$("#ul_dps").html("");
			$("#ul_dps").html(str);
		}
	})
}

// 获得最新的投诉信息
function getTss(){
	// 加载数据
	$.ajax({
		type: "POST",
		url : "../complainCentreController/indexComplain.do?topcount=10",
		dataType: "text",
		async:false,
		success:function(result){
			var data = eval('('+result+')');
			var str = ""; // 信息内容
			// 根据得到的data数据进行遍历
			$.each(data,function(index,entry){
				var id = entry["id"]; // 订单编号
				var title = entry["title"];
				if(title.length > 30){
					title = title.substring(0,30) + "...";
				}
				var enterprisename = entry["enterprisename"]; // 企业名
				//var userphone = entry["phone"]; // 用户名
				/*if(userphone == null || userphone == ''){
					userphone = "游客";
				}*/
				var systype = entry["systype"]; // 企业类别
				//var dpnr = "用户："+userphone+",点评了企业："+enterprisename;
				var qylogo = ""; // 企业小图标
				if(systype == "1"){
					qylogo = "<img src='../static/images/sclogo.png' />";
				}else if(systype == "2"){
					qylogo = "<img src='../static/images/cylogo.png' />";
				}else{
					qylogo = "<img src='../static/images/csclogo.png' />";
				}
				// 处理日期
				var nDate = new Date(entry['addtime']);
				var nowdate = nDate.getDate();
				if(nowdate < 10){
					nowdate = "0"+nowdate;
				}
				var newdate = nDate.getFullYear()+"-"+(nDate.getMonth()+1)+"-"+nowdate;
				str += "<li style='border-bottom: 1px dashed #c2e2f1;'>";
				str += qylogo+"企业名称：<a href='javascript:void(0)' onclick='showTs("+id+")' >"+enterprisename+"</a><br/>";
				str += "<span style='float:left;'>标题："+title+"</span><span style='float:right; padding-right:10px;'>日期："+newdate+"</span>"
				str += "</li>";
			});
			// 写入ul投诉中
			$("#ul_tss").html("");
			$("#ul_tss").html(str);
		}
	})
}


//弹出窗口，显示点评记录详情
function showdpinfo(dpid,systype){
	var alink = 'enterpriseDpInfo.jsp?id='+dpid+"&systype="+systype;
	// 调用layer，打开一个新的弹出窗口,  进行企业投诉
	layer.open({
        type: 2,
        title: '点评记录详情',
        offset:"auto",
        area: ['750px', '500px'],
        shadeClose: true, //点击遮罩关闭
        content: alink
  });
}

function showTs(id){
	var alink="tsxq.jsp?id="+id;
	layer.open({
        type: 2,
        area: ['750px', '500px'],
        shadeClose: true, //点击遮罩关闭
        content: alink
  });
	
}
//打开新闻新页面
function openNewsList(url){
	 url = encodeURI(url);
    url = encodeURI(url);
    window.open(url);
}

function searchNews(){
	title=$("#title").val();
	openNewsList("pfsc.jsp?name="+title);
}