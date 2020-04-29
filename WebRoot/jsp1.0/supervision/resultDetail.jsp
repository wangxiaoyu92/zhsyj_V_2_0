<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
String v_resultid = StringHelper.showNull2Empty(request.getParameter("resultid"));  //结果id
String v_resultstate = StringHelper.showNull2Empty(request.getParameter("resultstate"));  //结果完成标识
String v_planchecktype = StringHelper.showNull2Empty(request.getParameter("planchecktype"));
String v_comdalei = StringHelper.showNull2Empty(request.getParameter("comdalei"));  //企业大类
  //计划类别
 %>
 
<!DOCTYPE html>
<html>
<head>
<title>修改计划结果信息</title>
<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
<script src="<%=basePath %>/jslib/ckeditor_4.7.0/ckeditor.js"></script>
<script type="text/javascript">
var contentImpt = <%=SysmanageUtil.getAa10toJsonArray("CONTENTIMPT")%>
var comdalei = <%=v_comdalei%>;
var editor;
var  tfool ="<p style='text-align: center;'>检查人员（签字）：<u>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "
                             +"&nbsp;</u>&nbsp; &nbsp; &nbsp;&nbsp; 食品安全管理人员（签字）： <u>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
                              +"&nbsp; &nbsp;&nbsp;</u></p>";	
//  window.onload = function(){
//  editor = CKEDITOR.replace('content'); 
//  if(editor!=null){
//  toggleReadOnly();
//  getresults(editor);
 
//  }
// editor.updateElement();
       
//     }
$(function() {
var planchecktype= $('#planchecktype').val();
var result = getTbodyInfo("checkPaln",planchecktype);
if(result){
//量化
if(planchecktype=="0"){
// $('#resultstr').remove();
getresultsScode();

}else{//日常
// $('#lianghua_tbody').remove();
// $('#lianghua_info').remove();
getresults();
}
}


   
});

	// 保存明细结果信息 
	var saveDetail = function($dialog, $grid, $pjq) {
		var url = basePath + 'supervision/checkresult/saveresultDetail';
		 $('#detailinfo').val(editor.getData());
		//提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$pjq.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$pjq.messager.alert('提示','保存成功！','info',function(){
	        			$grid.datagrid('load');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};

	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};


//获取计划结果列表
 function getresults(){
 var resultid = $('#resultid').val();
 parent.$.messager.progress({
				text : '数据加载中....'
			});
$.post(basePath + 'supervision/checkresult/resultDetailList', {
				resultid : resultid
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					if(mydata.length>0){
// 					alert(mydata.length);
                    var fuhe = "";
                    var bufuhe="";
                    var divheight="";
//                     var numObj = new Array();
//                     var tdObj = new Array();
//                      var idObj = new Array();
//                     var trheight=0;
//                      var trtotal=0;
//                      var trid=0;
//                      var tdid=0;
					for(var i=0;i<mydata.length;i++){
						//id 已经存在
						if($('#'+mydata[i].itemid).length>0){
						$('#resultstr').append("<tr  id='tr"+i+"' ><td style='text-align:center;'>"+mydata[i].contentcode+"</td><td>"+mydata[i].content+"</td><td style='text-align:center;'>"+((mydata[i].detaildecide=="1")?"☑":"□")+"是&nbsp;"+((mydata[i].detaildecide=="2")?"☑":"□")+"否</td><td style='text-align:center;'>"+((mydata[i].detaildecide=="3")?"不适用":"")+"</td></tr>");
// 						if(trheight>400){
// 							trheight=0;
// 							$('#tr'+i).before(htmlstr);
// 							}
// 						 trheight=$('#tr'+i).height();
// 						numObj. push(trheight+"&"+"tr"+i);

						}else{//ID没有存在（单元格合并）
						//if(i%2==0 && i!=0){//整除
					//$("#resultstr").append("<tr style='page-break-after: always;'><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
					//}
						$('#resultstr').append("<tr id='total"+i+"' ><td id="+mydata[i].itemid+" rowspan="+mydata[i].count+">"+mydata[i].itemname+"</td><td style='text-align:center;'>"+mydata[i].contentcode+"</td><td>"+mydata[i].content+"</td><td style='text-align:center;'>"+((mydata[i].detaildecide=="1")?"☑":"□")+"是&nbsp;"+((mydata[i].detaildecide=="2")?"☑":"□")+"否</td><td style='text-align:center;'>"+((mydata[i].detaildecide=="3")?"不适用":"")+"</td></tr>");
//                        trheight=$('#total'+i).height();
// 						numObj. push(trheight+"&"+"total"+i);
						}
					}
//                     var tdheight=0;
// 					for(var f =0;f<numObj.length-1;f++){
// 					var str = numObj[f].split("&");
// 					if(tdheight>400){
// 					alert(str[1]);
                    // 上一个
// 					$('#'+str[1]).before(htmlstr);
					//上一个
// 					$('#'+str[1]).before("</tbody></table>");
// 					tdheight=parseInt(str[0]);
// 					}
// 					tdheight=tdheight+parseInt(str[0]);
// 					}
					}
// 					加载ckeditor
					 editor = CKEDITOR.replace( 'editor', {
                        allowedContent: true,
						height: 470
					} );
					}
					parent.$.messager.progress('close');
			}, 'json');
			return true;
				}


//获取计划结果评定表
 function getresultsScode(){
 var resultid = $('#resultid').val();
 parent.$.messager.progress({
				text : '数据加载中....'
			});
$.post(basePath + 'supervision/checkresult/resultDetailList', {
				resultid : resultid
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					if(mydata.length>0){
// 					alert(mydata.length);
                    var fuhe = "";
                    var bufuhe="";
					for(var i=0;i<mydata.length;i++){
						//id 已经存在（单元格合并）
						if($('#'+mydata[i].itemid).length>0){
						$('#lianghua_info').append("<tr><td>"+mydata[i].content+"</td><td>"+mydata[i].contentscore+"</td><td>"+mydata[i].detailscore+"</td></tr>");
						}else{
						$('#lianghua_info').append("<tr ><td id="+mydata[i].itemid+" rowspan="+mydata[i].count+">"+mydata[i].itemname+"</td><td>"+mydata[i].content+"</td><td>"+mydata[i].contentscore+"</td><td>"+mydata[i].detailscore+"</td></tr>");
						}
					}
// 					 editor.innerHTML($('#content').html());
// 					 editor =  CKEDITOR.replace( 'editor' );
					
// 					editor.setReadOnly();
// 					editor.insertHtml("<div style='page-break-after: always'><span style='display:none'>&nbsp;</span></div>");
// 					     CKEDITOR.appendTo( 'editor' );
					   //textarea (replace/inline);div(appendTo)
// 					 CKEDITOR.inline( 'editor' );
					 
					 //获取html
// 					 alert(editor.getData());
					}
					//加载ckeditor
					 editor = CKEDITOR.replace( 'editor', {
						extraPlugins: 'colordialog,table',
						height: 470
					} );
					}
					parent.$.messager.progress('close');
			}, 'json');
			return true;
				}

//获取计划结果评定表
 function getTbodyInfo(str,value){
$.post(basePath + 'supervision/checkresult/getTbodyInfo', {
				tbodytype : str,
				tbodycode:value
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					var html;
					var tbodyhtml;
					var starttime = '${obj.map.data.operatedate}';
					var endtime = '${obj.map.data.resultdate}';
					if(value=="0"){
// 					同一天
					if(starttime.substring(0,10) == endtime.substring(0,10)){
					html=mydata.tbodyinfo.replace("commc",'${obj.map.data.commc}').replace("comdz",'${obj.map.data.comdz}')
					.replace("comfrhyz",'${obj.map.data.comfrhyz}').replace("comyddh",'${obj.map.data.comyddh}')
					.replace("comxkzbh",'${obj.map.data.comxkzbh}').replace("comdmlx",'${obj.map.data.comdmlx}')
					.replace("check_year",starttime.substring(0,4)).replace("check_month",starttime.substring(5,7))
					.replace("check_data",starttime.substring(8,10)).replace("check_time",starttime.substring(11,13))
					.replace("check_fen",starttime.substring(14,16)).replace("to_check_time",endtime.substring(11,13))
					.replace("to_check_fen",endtime.substring(14,16));
					}else{
					html=mydata.tbodyinfo.replace("commc",'${obj.map.data.commc}').replace("comdz",'${obj.map.data.comdz}')
					.replace("comfrhyz",'${obj.map.data.comfrhyz}').replace("comyddh",'${obj.map.data.comyddh}')
					.replace("comxkzbh",'${obj.map.data.comxkzbh}').replace("comdmlx",'${obj.map.data.comdmlx}')
					.replace("check_year",starttime.substring(0,4)).replace("check_month",starttime.substring(5,7))
					.replace("check_data",starttime.substring(8,10)).replace("check_time",starttime.substring(11,13))
					.replace("check_fen",starttime.substring(14,16)).replace("to_check_time",endtime.substring(0,13))
					.replace("to_check_fen",endtime.substring(14,16));
					}
					$('#editor').html(html);
					}else {
					html=mydata.tbodyinfo.replace("Itemname",'${obj.map.data.itemname}')
					.replace("commc",'${obj.map.data.commc}').replace("comdz",'${obj.map.data.comdz}')
					.replace("check_startime",starttime).replace("check_endtime",endtime)
					.replace("checkdz",'${obj.map.data.comdz}');
					tbodyhtml = mydata.tbody.replace("Itemname",'${obj.map.data.itemname}');
					$('#editor').html(html+tbodyhtml+tfool);
					}
					}
			}, 'json');
			return true;
				}
				
	
				
	function view(){
	window.print(editor.getData());
	}
	
	
	
// 	data-cke-title
	
</script>
</head>
<body >
	<form id="fm" method="post">
	<div  style="width: 99%;" >
	<sicp3:groupbox title="计划信息" >	
	<!-- 结果明细html -->
	<input type="hidden" name="detailinfo" id="detailinfo" value="">
	<input type="hidden" name="resultid" id="resultid" value="<%=v_resultid%>">
	<input type="hidden" name="resultstate" id="resultstate" value="<%=v_resultstate%>">
	<input type="hidden" name="planchecktype" id="planchecktype" value="<%=v_planchecktype%>">
        		<div class="grid-width-100">
        		
<!--         		<a href="javascript:view()">预览</a> -->
           
				<div id="editor"  >
				
							</div>
			</div>
	        </sicp3:groupbox>
	        </div>
	   </form>
	   
</body>
</html>