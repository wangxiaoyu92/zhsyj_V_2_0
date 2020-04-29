<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <!-- 引入 ECharts 文件 -->
    <script src="<%=basePath%>jslib/echarts/echarts_3.0.js"></script>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    

	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
<%-- var dalei  = <%=SysmanageUtil.getAa10toJsonArray("dalei")%>;
  // 基于准备好的dom，初始化echarts实例
$(function() {

	$('#dalei').combobox({
    	data : dalei,      
        valueField : 'id',   
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : '200' 
    });  --%>
    var dalei;
$(function() {
   /*  dalei = $('#dalei').combobox({
	    	data : [{id:'SPSC',text:'食品类'},
	    	    	{id:'YPSC',text:'药品类'},
	    	    	{id:'SPSC',text:'化妆品类'},
	    	    	{id:'SPSC',text:'保健品类'},
	    	    	{id:'SPSC',text:'医疗器械类'}
	    	],      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    }); */
 parent.$.messager.progress({
				text : '数据加载中....'
			});
//获取企业类别列表
// gettypes("COMDALEI","SPSC");
// getAAa027();

// echarts();
});
//获取企业类别列表
 function gettypes(str,type){
// $.post(basePath + 'supervision/getqiyeType', {
// 				type : str
// 			}, 
 $.post(basePath + 'common/sjb/getAa10Byaaa101toJSON', {
				aaa100 : str,
				aaa101:type
 			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.rows;
					if(mydata.length>0){
					for(var i=0;i<mydata.length;i++){
					$("#plantypeareas").append("<input type='checkbox' style='width:20px'  name='plantypearea'  id='"
						+mydata[i].id+"' value='"+mydata[i].id+"'> "+mydata[i].text+"</input>");
					}
					}
				} 
			}, 'json');
			return true;
}


//获取区域
 function getAAa027(){
 $.post(basePath + 'supervision/checkPalnresultReport/getAAa027list', 
			function(result) {
				if (result.code=='0') {
					var mydata = result.rows;
					if(mydata.length>0){
					for(var i=0;i<mydata.length;i++){
					$("#areas").append("<input type='checkbox' style='width:20px'  name='areas'  id='"+mydata[i].baz001+"' value='"+mydata[i].aaa027+"'> "+mydata[i].aaa129+"</input>");
								}
					}
				} 
			}, 'json');
			return true;
}
</script>


  </head>
  
  <body>
  
<!--   <div id="plantypeareas">类别   :</div>  -->
<!-- <div id="areas">区域  :</div>  -->
  <p>年份:<input type="text" id="year" name="year"     onFocus="WdatePicker({readOnly:true,dateFmt:'yyyy'})"   class="Wdate"   />
  	   <!-- 大类:<input id='dalei'/> -->
  		 <select id="dalei" style="width: 140px; height: 22px;">
  		     <option value='SPSC'>食品类</option>
  		     <option value='YPSC'>药品类</option> 
  		     <option value='SPSC'>化妆品类</option> <!-- 由于化妆品 保健品 医疗器械类和 aa10表中的 aaa101没有明确的对应关系先默认为食品类 -->
  		     <option value='SPSC'>保健品类</option>
  		     <option value='SPSC'>医疗器械</option>
  		</select> 
  </p>
  <p>
                检查状态:
     <input type="radio"  onclick="ajax_select(this.value)" name="checkstate" value="4"/>检查完成
     <input type="radio" checked="checked"  onclick="ajax_select(this.value)" name="checkstate" value="1"/>  检查中 
     <input type="radio" onclick="ajax_select(this.value)" name="checkstate" value="2"/>检查不合格
   </p>
   <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
     <div id="container" style="height: 100%"></div>
     <script type="text/javascript">
		 var layer;
		 $(function(){
			 layui.use([ 'layer'], function () {
				 layer = layui.layer;
			 });
		 });
     var toobars = {
		    	//title : {text: '检查统计',textAlign:'left' },
		    	tooltip : {trigger: 'axis'
		    },
		    	legend: { data:[]//动态
		    },
		    toolbox: {show : false,
		        feature : {
		            dataView : {show: true, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : []//动态
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : []
		};
     
	    var dom = document.getElementById("container");
	    var myChart = echarts.init(dom);
	    myChart.showLoading({text: "图表数据正在努力加载..."});
		var options = toobars;

//异步请求
				$.ajax({
				
		            type: "post",
		            async: true,
		            url: "<%=basePath%>/supervision/checkPalnresultReport/getEcharts",
		            dataType: "json",
		            
		            success: function (result) {
		            
		                if(result.code == 0){
		                $('#year').val(result.year);
		                var data = result.data;
		                    options.xAxis[0].data = eval(data.category);
		                    options.series = eval(data.series);
		                    options.legend.data = eval(data.legend);
		                    myChart.hideLoading();
		                    myChart.setOption(options);
		                     parent.$.messager.progress('close');
		                     
		                     //点击事件
		                     clicks();
		                     
		                }
		                
		            },
		            
		            error: function (errorMsg) { 
		                alert("图表请求数据失败啦!");
		            }
		        });
//     myChart.setOption(option, true);

		function ajax_select(str,time){
		// parent.$.messager.progress({
		// 				text : '数据加载中....'
		// 			});
		 var dom = document.getElementById("container");
		 $("#container").empty();
		 var myChart = echarts.init(dom);
		 myChart.showLoading({text: "图表数据正在努力加载..."});
		 var year = time==null?$('#year').val():time;
		 var resultstate = str==null?$(':radio[name="checkstate"]:checked').val():str;
		 var dalei = $('#dalei').val();
		 var comdalei = dalei==null?$('#dalei').eq(1).val():dalei;
		 
		 var options = toobars;
		//异步请求
		$.ajax({
		
            type: "post",
            async: true,
            url: "<%=basePath%>/supervision/checkPalnresultReport/getEcharts",
            dataType: "json",
            data:{resultstate:resultstate,year:year,comdalei:comdalei},
            success: function (result) {
            
//              parent.$.messager.progress('close');
                if(result.code == 0){
                
                var data = result.data;
                    options.xAxis[0].data = eval(data.category);
                    options.series = eval(data.series);
                    options.legend.data = eval(data.legend);
                    myChart.hideLoading();
                    myChart.setOption(options);
//                    myChart.on(ecConfig.EVENT.CLICK, eConsole);
                     clicks();
                     
                }
                
            },
            
            error: function (errorMsg) {
//             parent.$.messager.progress('close');
                alert("图表请求数据失败啦!");
            }
            
        });
	}

//    var ecConfig = require('echarts/config');
    function eConsole(param) {
        switch (param.dataIndex) {
            case 0:    //柱子1
                window.location.href = "http://blog.sina.com.cn/eul";
                break;
            case 1:  //柱子2
                window.location.href = "http://www.dacai.com/desc/4778";
                break;
            case 2:  //柱子3
                window.location.href = "http://www.dacai.com/desc/4778";
                break;
            default:
                break;
               
        }


    }
	function clicks(){
		myChart.on('click', function (params) { 
			var url = basePath + 'jsp/supervision/report/resultList.jsp';
			sy.modalDialogLayui({
				title: '检查结果',
				param: {
					aaa027name: params.name,
					daleiname: params.seriesName,
					year: $('#year').val(),
					resultstate: $(':radio[name="checkstate"]:checked').val()
				},
				offset:'t',
				area: ['100%', '100%'],
				content: url,
				btn:['关闭']
			}, function (dialogID) {
				sy.removeWinRet(dialogID);//不可缺少
			});
		});
	}
    </script>
  </body>
</html>
