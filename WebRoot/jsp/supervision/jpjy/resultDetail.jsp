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
<script src="<%=basePath %>jslib/ckeditor_4.5.9/ckeditor.js"></script>
<script type="text/javascript">
var contentImpt = <%=SysmanageUtil.getAa10toJsonArray("CONTENTIMPT")%>
var comdalei = <%=v_comdalei%>;
var editor;
//  window.onload = function(){
//  editor = CKEDITOR.replace('content'); 
//  if(editor!=null){
//  toggleReadOnly();
//  getresults(editor);
 
//  }
// editor.updateElement();
       
//     }
$(function() {
// var planchecktype= $('#planchecktype').val();
var result = getTbodyInfo("JPJYQY_checkPlan","1");
// var result = getTbodyInfoHtml("JPJYQY_checkPlan","1");
if(result){
getresults();
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
                    var isFuhe="";  
					for(var i=0;i<mydata.length;i++){
						//id 已经存在
						if(mydata[i].detaildecide=="1"){
						isFuhe="&radic;";
						}else if(mydata[i].detaildecide=="2"){
						isFuhe="&times";
						}
						if($('#'+mydata[i].itemid).length>0){
						$('#result_jyqy').before("<tr  id='tr"+i+"' ><td colspan='5'>"+mydata[i].content+"</td><td colspan='2'>"+isFuhe+"</td></tr>");
						}else{//ID没有存在（单元格合并）
						$('#result_jyqy').before("<tr id='total"+i+"' ><td id="+mydata[i].itemid+" rowspan="+mydata[i].count+">"+mydata[i].itemname+"</td><td colspan='5'>"+mydata[i].content+"</td><td colspan='2'>"+isFuhe+"</td></tr>");
						}
					}
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
 function getTbodyInfo(str,value){
$.post(basePath + 'supervision/checkresult/getTbodyInfo', {
				tbodytype : str,
				tbodycode:value
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					var html;
					var starttime = '${obj.map.data.operatedate}';
					var endtime = '${obj.map.data.resultdate}';
					html=mydata.tbodyinfo.replace("Itemname",'${obj.map.data.itemname}')
					.replace("commc",'${obj.map.data.commc}').replace("comdz",'${obj.map.data.comdz}')
					.replace("comjyfw",'${obj.map.data.comxkfw}').replace("comxhz",'${obj.map.data.comxkzbh}')
					.replace("comqyfr",'${obj.map.data.comfrhyz}').replace("tex",'${obj.map.data.comgddh}')
					.replace("phone",'${obj.map.data.comyddh}').replace("comfzr",'${obj.map.data.comfzr}')
					.replace("comzlfzr","").replace("comzc","").replace("bgdh","")
					.replace("modile","").replace("comysandtyep","").replace("xyyj","")
					.replace("zyyj","");
					$('#editor').html(html);
					$('#result_jyqy').append(mydata.tfootinfo);
					}
			}, 'json');
			return true;
				}
				
	//获取计划结果评定表
 function getTbodyInfoHtml(str,value){
$.post(basePath + 'supervision/checkresult/getTbodyHtml', {
				tbodytype : str,
				tbodycode:value
			}, 
			function(result) {
			alert(result);
// 			$('#editor').html(result);
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
        		${obj.map.data.operatedate}
<!--         		<a href="javascript:view()">预览</a> -->
				<div id="editor"  >
							</div>
			</div>
	        </sicp3:groupbox>
	        </div>
	   </form>
</body>
</html>