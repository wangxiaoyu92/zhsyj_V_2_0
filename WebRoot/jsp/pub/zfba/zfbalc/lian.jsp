<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.workflow.Wf_node_trans" %>
<%@ page import="java.util.List,com.zzhdsoft.siweb.service.workflow.WorkflowService,java.net.URLDecoder" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ywbh"));
	String v_ywlcid = StringHelper.showNull2Empty(request.getParameter("ywlcid"));
	String v_psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
	String v_transfrom=StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_nodename=URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("nodename")),"UTF-8");
	String v_nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_fjcsdmlb = StringHelper.showNull2Empty(request.getParameter("fjcsdmlb"));
	String v_fjcsdlbh = StringHelper.showNull2Empty(request.getParameter("fjcsdlbh"));
	String v_ywbh = StringHelper.showNull2Empty(request.getParameter("ywbh"));	
	
	//获取分支节点流向值
	WorkflowService v_WorkflowService=new WorkflowService();
	List<Wf_node_trans> v_listWf_node_trans=(List<Wf_node_trans>)v_WorkflowService.queryWfnodeTransList(v_psbh,v_transfrom);	
	
	String v_nextchecked="";
	int v_transCount=0;
	if (v_listWf_node_trans!=null){
	   v_transCount=v_listWf_node_trans.size();
	   if (v_transCount==1){
		   v_nextchecked="checked='checked'";
	   }
	}	
	
%>
<!DOCTYPE html>
<html>
<head>
<title>案件受理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);
var v_b_ajdjid=$('#ajdjid').val();

$(function() {
	if ($('#ajdjid').val().length > 0) {
		$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + '/zfba/ajdj/queryAjcbr', {
			ajdjid : $('#ajdjid').val()
		}, 
		function(result) {
			if (result.code=='0') {
				var mydata = result.data;	
				$('form').form('load', mydata);			
			} else {
				$.messager.alert('提示','查询失败：'+result.msg,'error');
               }	
			$.messager.progress('close');
		}, 'json');
        getajcbr();//gu20180629
	}
		
  var v_ajslCommonURL=encodeURI(encodeURI("<%=basePath%>jsp/pub/zfba/zfbalc/ajslCommon.jsp?ajdjid=<%=v_ajdjid%>&psbh=<%=v_psbh%>&nodename=<%=v_nodename%>&nodeid=<%=v_nodeid%>&fjcsdmlb=<%=v_fjcsdmlb%>&fjcsdlbh=<%=v_fjcsdlbh%>&ywbh=<%=v_ywbh%>"));
  //$("#ajslcommonframe").attr("src",v_ajslCommonURL); 
  document.getElementById("ajslcommonframe").src=v_ajslCommonURL;
    var layer; // 弹出层
    layui.use(['layer','element'], function () {
        var element = layui.element;
        layer=layui.layer;
        var $ = layui.$, active = {
             myAjdjSetRy: function () {
                 myAjdjSetRy();
            }
        };
        $('.layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
	});
});

//选择承办人(组长)
function choose2(){
    alert(1);
	var url = basePath + 'zfba/ajdj/xzcbrIndex?';
	var dialog = sy.modalDialogEasyui({
			title : '选择承办人',
/*			param : {
				singleSelect : "true"
			},*/
			width : 800,
			height : 500,
			url : url
	},function(dialogID) {
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
		    for (var k = 0; k <= v_retStr.length - 1; k++){
				var myrow = v_retStr[k];
		      	$("#zfryzz").val(myrow.description);
      			$("#zfryzzid").val(myrow.userid);        
		    }
		}
	    sy.removeWinRet(dialogID);//不可缺少
	}); 
}


//选择承办人(组员)
function choose(){
    var url = basePath + 'zfba/ajdj/xzcbrIndex';
	var dialog = sy.modalDialogEasyui({
			title : '选择承办人',
			param : {
				singleSelect : "false"
			},
			width : 800,
			height : 500,
			url : url
	},function(dialogID) {
		var v_cbrmc="";
		var v_cbrid=0;
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
		    for (var k = 0; k <= v_retStr.length - 1; k++){
				var myrow=v_retStr[k];
			    if (v_cbrmc=="") {
			    	v_cbrmc=myrow.description
			    	v_cbrid=myrow.userid;
			    }else{
			    	v_cbrmc+=","+myrow.description;
			    	v_cbrid+=","+myrow.userid;	    	  
			    }        
		    }
		}
		$("#zfryzy").val(v_cbrmc); //组员
    	$("#zfryzyid").val(v_cbrid);
	    sy.removeWinRet(dialogID);//不可缺少
	});
} 
 
// 保存 
function saveCbr(){
    $.post(basePath + '/zfba/ajdj/saveAjcbr',{
			ajdjid:$('#ajdjid').val(),
     		zfryzz:$('#zfryzz').val(),
     		zfryzzid:$('#zfryzzid').val(),
     		zfryzy:$('#zfryzy').val(),
     		zfryzyid:$('#zfryzyid').val() 
	},
	function(result) {
		if (result.code == '0') {	
			$("#saveBtn").linkbutton('disable');
			$("#tjlcBtn").linkbutton('enable');	
			alert("保存成功！");
		} else {
			alert('保存失败：' + result.msg);
		}
	},'json');
}
 

//提交流程
function saveandtijiaoliucheng(){	 
	var isValid = $("#myfm").form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
	if(!isValid){
		return false;
	}
		
  	var v_transname = $('#xuanzeliuxiang input[name="transname"]:checked ').val();
  	if (v_transname==undefined){
		alert("请选择办理流向");
	  	return false;
  	}
    
  	var cfmMsg= "确定要提交流程吗?";
  	var v_transyy=$("#transyy").val();
  
  	var v_transval="七日内做出决定";
	var v_shifouTongguo="1";
  
  	var v_url=encodeURI(encodeURI("<%=basePath%>workflow/doWfprocess?ywlcid=<%=v_ywlcid%>&transval="+v_transval+"&shifouTongguo="+v_shifouTongguo+
                                                          "&transname="+v_transname+"&transyy="+v_transyy+"&time="+new Date().getMilliseconds()));
 	$.messager.confirm('确认', cfmMsg, function (r) {
    	if(r){
			$.messager.progress({
				text : '数据提交中....'
			});
		    $.post(basePath + '/zfba/ajdj/saveAjcbr',{
					ajdjid:$('#ajdjid').val(),
		     		zfryzz:$('#zfryzz').val(),
		     		zfryzzid:$('#zfryzzid').val(),
		     		zfryzy:$('#zfryzy').val(),
		     		zfryzyid:$('#zfryzyid').val() 
			},
			function(result) {
				if (result.code == '0') {	
					$.ajax({
						url:v_url,
						type:'post',
						async:true,
						cache:false,
						timeout: 100000,
						//data:formData,
						error:function(){
						    parent.$.messager.progress('close');
							alert("服务器繁忙，请稍后再试！");
						},
				        success: function(result){
							parent.$.messager.progress('close');
				        	result = $.parseJSON(result);  
						 	if (result.code=='0'){
						 		$.messager.alert('提示','提交流程成功！','info',function(){
						 			closeAndRefreshWindow();
				        		}); 	                        	                     
			              	} else {
			              		$.messager.alert('提示','提交流程失败：'+result.msg,'error');
			                }
				        }  
					});	
					
				} else {
					alert('提交前保存信息失败：' + result.msg);
					$.messager.progress('close');
				}
			},'json');
	    }
 	});   
}

function closeAndRefreshWindow () {
	/*var s = new Object();
	s.type = "ok";   //设为空不刷新父页面
	sy.setWinRet(s);
	//parent.$("#"+sy.getDialogId()).dialog("close");
    var index = parent.layer.getFrameIndex(window.name);
    parent.layer.close(index);*/
    window.parent.location.reload();
    var index = parent.layer.getFrameIndex(window.name);
    parent.layer.close(index);
}

function closeNoRefreshWindow () {
    var s = new Object();
    s.type = "no";   //设为空不刷新父页面
    sy.setWinRet(s);
    //parent.$("#"+sy.getDialogId()).dialog("close");
    var index = parent.layer.getFrameIndex(window.name);
    parent.layer.close(index);
}
	
//提交流程
function tijiaoliucheng(){	 
	var v_transname = $('#xuanzeliuxiang input[name="transname"]:checked ').val();
  	if (v_transname==undefined){
		alert("请选择办理流向");
	  	return false;
  	}
  	var v_ajcbr=$("#ajcbr").val();
  	if (v_ajcbr==null || v_ajcbr==""){
  	    alert("请选择案件承办人");
  	    return;
	}
    
  	var cfmMsg= "确定要提交流程吗?";
  	var v_transyy=$("#transyy").val();
  
	var v_transval="七日内做出决定";
  	var v_shifouTongguo="1";
  
  	var v_url=encodeURI(encodeURI("<%=basePath%>workflow/doWfprocess?ywlcid=<%=v_ywlcid%>&transval="+v_transval+"&shifouTongguo="+v_shifouTongguo+
                                                          "&transname="+v_transname+"&transyy="+v_transyy+"&time="+new Date().getMilliseconds()));
 	$.messager.confirm('确认', cfmMsg, function (r) {
    	if(r){
			$.messager.progress({
				text : '数据加载中....'
			});
			$.ajax({
				url:v_url,
				type:'post',
				async:true,
				cache:false,
				timeout: 100000,
				//data:formData,
				error:function(){
				    $.messager.progress('close');
					alert("服务器繁忙，请稍后再试！");
				},
		        success: function(result){
					$.messager.progress('close');
		        	result = $.parseJSON(result);  
				 	if (result.code=='0'){
				 		$.messager.alert('提示','提交流程成功！','info',function(){
				 			closeAndRefreshWindow();
		        		});
	              	} else {
	              		$.messager.alert('提示','提交流程失败：'+result.msg,'error');
	                }
		        }  
				
			});	
	    }
 	});   
}

//从单位信息表中读取
function myAjdjSetRy() {
    v_b_ajdjid=$('#ajdjid').val();
    parent.sy.modalDialogLayui({
        title: '经办人设置'
        , area: ['100%', '100%']
        ,offset:["2px","2px"]
        , content: basePath + 'jsp/zfba/ajdjSetRy.jsp'
        , param: {'ajdjid': v_b_ajdjid}
        , btn: ['保存', '关闭']
        , btn1: function (index, layero) {
            parent.window[layero.find('iframe')[0]['name']].submit();
        }
        , btn2: function (index, layero) {
            //当前页面刷新
         //   var curent = $(".layui-laypage-skip input[class='layui-input']").val();
           // refresh('', curent);
        }
    }, function (dialogID) {
        sy.removeWinRet(dialogID);//不可缺少
        getajcbr();//gu20180629
    });
}


//从单位信息表中读取
function myAjdjSetRy2(){
/*    var row = $('#mygrid').datagrid('getSelected');
    if (row) {*/
        var v_b_ajdjid = "<%=v_ajdjid%>";
        var url = basePath + "jsp/zfba/ajdjSetRy.jsp";
        var dialog = sy.modalDialogEasyui({
            title : '经办人设置',
            param : {
                ajdjid : v_b_ajdjid
            },
            width : 1050,
            height : 400,
            url : url
        },function(dialogID) {
            sy.removeWinRet(dialogID);//不可缺少
        });
/*    }else{
        $.messager.alert('提示', '请先选择要设置的案件登记记录！', 'info');
    }*/
}

function getajcbr(){
    var url = basePath + '/zfba/ajdj/queryAjdjCbrMiaoshu';
    var param = {
        ajdjid: '<%=v_ajdjid%>'
    }
    $.post(url, param, function (result) {
        if (result.code == '0') {
            var v_ajcbr = result.ajcbr;
            $("#ajcbr").val(v_ajcbr);
        }
    }, 'json');
}
</script>
</head>
<body>
	<iframe name="ajslcommonframe" id="ajslcommonframe" src=""
    	width="100%" height="800px;"  scrolling="no" frameborder="0" ></iframe>

		<table width="800px" height="60px;">
      		<tr>
		        <td colspan="2" align="right">请选择下一节点流向：</td>
		        <td colspan="6" align="left">
	     			<div id="xuanzeliuxiang">
				      <%for (Wf_node_trans v_Wf_node_trans:v_listWf_node_trans){%>
				         <input type="radio" name="transname" <%=v_nextchecked%> id="transname"  
				         value="<%=v_Wf_node_trans.getTransname() %>" 
				         style="cursor: pointer;"/><%=v_Wf_node_trans.getTransname() %>&nbsp;&nbsp;&nbsp;&nbsp;
				      <%} %>                      
	     			</div>	         
        		</td>
      		</tr>
       		<tr>
         		<td colspan="2" align="right"> 处理意见： </td>
		        <td colspan="6"  align="left">
					<textarea class="layui-textarea" id="transyy" name="transyy" style="width: 600px;"
					 rows="8" lay-verify="required"></textarea>
		        </td>
       		</tr>
			<tr>
				<td colspan="2" align="right"> 选择案件承办人： </td>
				<td colspan="5" align="left">
					<textarea class="layui-textarea" id="ajcbr" name="ajcbr" style="width: 500px;" readonly
							  rows="3" lay-verify="required"></textarea>
				</td>
				<td  colspan="1" align="left">
					<ck:permission biz="myAjdjSetRy">
						<button class="layui-btn " data-type="myAjdjSetRy" data="btn_myAjdjSetRy">选择承办人</button>
					</ck:permission>
				</td>

			</tr>
     	</table>
		<form id="myfm" name="ajdjAddDlgfm" method="post">
			<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
			<!-- <div style="text-align:left; margin-left:60px;">
              <table width="500px" >
                <tr>
                  <td >案件承办人:</td>
                  <Td>
                 <input id="zfryzz" name="zfryzz"  class="easyui-validatebox"
                     data-options="required:true"
                       readonly="readonly"
                     style="width: 300px;margin-left: 8px;"/>
                 <input id="zfryzzid" name="zfryzzid" type="hidden"
                     style="width: 300px"/>
                  </Td>
                  <td>
                     <a href="javascript:void(0)" class="easyui-linkbutton"
                         iconCls="icon-search" onclick="choose2()"> 选择 </a>
                  </td>
                </tr>

                <tr>
                  <td>案件协办人:</td>
                  <td>
                 <input id="zfryzy" name="zfryzy"  class="easyui-validatebox"
                     data-options="required:true"    readonly="readonly"
                     style="width: 300px;margin-left: 8px;"/>
                     <input id="zfryzyid" name="zfryzyid" type="hidden"
                     style="width: 300px;"/>
                  </td>
                  <td>
                 <a href="javascript:void(0)" class="easyui-linkbutton"
                         iconCls="icon-search" onclick="choose()"> 选择 </a>
                  </td>
                </tr>
              </table></div> -->
		</form>

	<div style="text-align: center;height: 100px">
		<br>
		<br>
		<a href="javascript:void(0);" id="tjlcBtn" class="easyui-linkbutton" onclick="tijiaoliucheng()"
			              data-options="iconCls:'icon-save'">提交流程</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeNoRefreshWindow();"
	              data-options="iconCls:'icon-back'">关闭</a>
	</div>
</body>
</html>