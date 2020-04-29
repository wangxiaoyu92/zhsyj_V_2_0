<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_zdhddjid = StringHelper.showNull2Empty(request.getParameter("zdhddjid"));
	System.out.println("op"+op);
%>
<!DOCTYPE html>
<html>
<head>
<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>

<script type="text/javascript">
var mygrid;

$(function() {	   
		if ($('#zdhddjid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/zdhd/queryZdhddjDTO', {
				zdhddjid : $('#zdhddjid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;	
					$('form').form('load', mydata);			
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
			}, 'json');

			if('<%=op%>' == 'view'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');					
			}
		}
		
});

	// 保存 
	var submitForm = function() {
		var url;
		if($('#ajdjid').val().length > 0){
			url = basePath + '/zfba/ajdj/saveAjdj';
		}else{
			url = basePath + '/zfba/ajdj/saveAjdj';
		}

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#ajdjAddDlgfm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						 closeAndRefreshWindow(); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	};
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = "ok";      
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}
//从单位信息表中读取
 function myselectcom(){
	var url = "<%=basePath%>pub/pub/selectcomIndex?op=view";
		var dialog = parent.sy.modalDialog({
		title : '选择企业',
		param : {
		a : new Date().getMilliseconds(),
		singleSelect:"true"
		},
		width : 800,
		height : 450,
		url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);
			if (obj == null || obj == ''){
				return
			}
			if (obj.type == "ok") {
				var myrow = obj.data;
				$("#commc").val(myrow.commc); //公司名称s
				$("#comid").val(myrow.comid); //公司代码
			}
		sy.removeWinRet(dialogID);//不可缺少	
		});
}

//从单位信息表中读取
function myselectay(){
	var url="<%=basePath%>pub/pub/selectayIndex";
	var dialog = parent.sy.modalDialog({
		title : '选择单位信息',
		param : {
		a : new Date().getMilliseconds(),
		singleSelect:"true",
		},
		width : 800,
		height : 600,
		url : url
	},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj != null && obj.length > 0) {
			for (var k=0;k<=obj.length-1;k++){
	      	var myrow = obj[k];
	      	$("#ajdjay").val(myrow.wfxwms); // 案件登记案由   
	      	$("#wfxwbh").val(myrow.wfxwbh); // 违法行为编号         
    	}
		}
		sy.removeWinRet(dialogID);//不可缺少	
	})
}

// 关闭窗口
var closeWindow = function($dialog, $pjq){
   	$dialog.dialog('destroy');
};


//地图定位获取经纬度
function myselectjwd(){
	var v_address=$("#zdhddd").val();	
	var url="<%=basePath%>jsp/pub/pub/pubMap.jsp?op=view";
	var dialog = parent.sy.modalDialog({
		title : '选择经纬度',
		param : {
		a : new Date().getMilliseconds(),
		address:v_address,
		},
		width : 900,
		height : 700,
		url : url
	},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj != null){
       $("#zdhdjdzb").val(obj.jdzb);
       $("#zdhdwdzb").val(obj.wdzb);	 	
    }     
    sy.removeWinRet(dialogID);//不可缺少	
	});
}

//选择重大活动检查人员
function myselectZdhdjcry(prm_rykind){
	var v_zdhdjcryidlist="";
    var v_zdhdjcryidstrlist="";
	var url="<%=basePath%>jsp/pub/pub/selectuser.jsp";
	var dialog = parent.sy.modalDialog({
		title : '选择重大活动检查人员',
		param : {
		a : new Date().getMilliseconds(),
		singleSelect:"false",
		},
		width : 1000,
		height : 600,
		url : url
	},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj!=null && obj.length>0){
	    for (var k=0;k<=obj.length-1;k++){
	    	var myrow = obj[k];
	    	if (k==0){
	    		v_zdhdjcryidlist=myrow.userid;
	    		v_zdhdjcryidstrlist=myrow.description;
	    	}else{
	    		v_zdhdjcryidlist=v_zdhdjcryidlist+","+myrow.userid;
	    		v_zdhdjcryidstrlist=v_zdhdjcryidstrlist+","+myrow.description;	    		
	    	}    
	    }
	    $("#zdhdjcryidlist").val(v_zdhdjcryidlist);
	    $("#zdhdjcryidliststr").val(v_zdhdjcryidstrlist);
    };      
	})
}

//选择重大活动检查计划
function myselectCheckplan(){
	var url="<%=basePath%>jsp/pub/pub/selectCheckPlan.jsp?op=view";
	var dialog = parent.sy.modalDialog({
		title : '选择重大活动检查计划',
		param : {
		a : new Date().getMilliseconds(),
		singleSelect:"true"
		},
		width : 900,
		height : 460,
		url : url
	},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj!=null && obj.length>0){
	    for (var k=0;k<=obj.length-1;k++){
	    	var myrow = obj[k];  
		    $("#planid").val(myrow.planid);
		    $("#plantitle").val(myrow.plantitle);	    	
	    }
    };   
	})
}


// 保存 
var submitForm = function() {
	var url = basePath + '/zdhd/saveZdhddj';
	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$.messager.progress();	// 显示进度条
	$('#zdhddjAddDlgfm').form('submit',{
		url: url,
		onSubmit: function(){ 
			var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
			if(!isValid){
				$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
			}					
			return isValid;
        },
        success: function(result){
        	$.messager.progress('close');// 隐藏进度条  
        	result = $.parseJSON(result);  
		 	if (result.code=='0'){
		 		$.messager.alert('提示','保存成功！','info',function(){
					 window.returnValue="ok";
					 window.close(); 
        		}); 	                        	                     
          	} else {
          		$.messager.alert('提示','保存失败：'+result.msg,'error');
            }
        }    
	});
};


</script>
</head>
<body>
    
<form id="zdhddjAddDlgfm" name="zdhddjAddDlgfm" method="post">
  <input id="zdhddjid" name="zdhddjid" type="hidden" value="<%=v_zdhddjid%>"/>
      		<table class="table" style="width: 900px;">
      		   <tr style="display: none">
      		     <td width="15%"></td>
      		     <td width="35%"></td>
      		     <td width="15%"></td>
      		     <td width="35%"></td>
      		   </tr>
			<tr>	
                <input type="hidden" id="comid" name="comid"/>			
				<td style="text-align:right;"><nobr>企业名称:</nobr></td>
				<td colspan="3"><input id="commc" name="commc" style="width: 500px;" class="easyui-validatebox input_readonly" 
				  readonly="readonly"/>
				<% if(!"view".equalsIgnoreCase(op)){%>
					<a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="myselectcom()">选择企业 </a>	
						<%} %>					
				</td>									
			</tr>
			<tr>		
				<td style="text-align:right;"><nobr>企业联系人:</nobr></td>
				<td><input id="zdhdlxr" name="zdhdlxr" style="width: 200px" class="easyui-validatebox" 
				data-options="required:false,validType:'length[0,20]'" /></td>						
				<td style="text-align:right;"><nobr>企业联系电话:</nobr></td>
				<td><input id="zdhdlxdh" name="zdhdlxdh" style="width: 200px" class="easyui-validatebox" 
				data-options="required:false,validType:'length[0,20]'"/></td>			
			</tr>					
			
			<tr>
				<td style="text-align:right;" ><nobr>重大活动名称:</nobr></td>
				<td colspan="3"><input id="zdhdmc" name="zdhdmc" style="width: 580px" class="easyui-validatebox" 
				data-options="required:true,validType:'length[0,200]'"/></td>		
			</tr>					
			<tr>
				<td style="text-align:right;"><nobr>承接重大活动开始时间:</nobr></td>
				<td><input id="zdhdkssj" name="zdhdkssj" style="width: 200px" class="easyui-datetimebox"  data-options="required:true"/></td>
				<td style="text-align:right;"><nobr>承接重大活动结束时间:</nobr></td>
				<td><input id="zdhdjssj" name="zdhdjssj" style="width: 200px" class="easyui-datetimebox"  data-options="required:true"/></td>							
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
				<td >
					<input name="aaa027name" id="aaa027name"  style="width: 200px; " onclick="showMenu_aaa027();" 
					   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
					<input name="aaa027" id="aaa027"  type="hidden"/>
					<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
						<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
					</div>							
				</td>
			</tr>
			<tr>
				<td style="text-align:right;"><nobr>重大活动地点:</nobr></td>
				<td colspan="3"><input id="zdhddd" name="zdhddd" style="width: 700px" class="easyui-validatebox"/></td>	
			</tr>
			<tr>
                    <td style="text-align:right;"><nobr>地图定位:</nobr></td>
			  <td colspan="3">
			     经度坐标：<input id="zdhdjdzb" name="zdhdjdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
			     纬度坐标：<input id="zdhdwdzb" name="zdhdwdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
						<a href="javascript:void(0)" class="easyui-linkbutton" id="dtdw" 
							iconCls="icon-search" onclick="myselectjwd()">选择经纬度 </a>					     
			  </td>
			</tr>
			
			<tr>
				<td style="text-align:right;"><nobr>重大活动备注:</nobr></td>
				<td colspan="3"><input id="zdhdbeizhu" name="zdhdbeizhu" style="width: 700px" class="easyui-validatebox"/></td>	
			</tr>					
			<tr>
				<td style="text-align:right;"><nobr>重大活动检查开始时间:</nobr></td>
				<td><input id="zdhdjckssj" name="zdhdjckssj" style="width: 200px" class="easyui-datetimebox"  data-options="required:true"/></td>
			</tr>
			
			<tr>
				<td style="text-align:right;"><nobr>重大活动检查人员:</nobr></td>
				<td colspan="3">
				   <input type="hidden" id="zdhdjcryid" name="zdhdjcryid" />
				   <input type="hidden" id="zdhdjcryidlist" name="zdhdjcryidlist" />
				   <input id="zdhdjcryidliststr" name="zdhdjcryidliststr" style="width: 500px" class="easyui-validatebox input_readonly" readonly="readonly" />
					<% if(!"view".equalsIgnoreCase(op)){%>
						<a id="btnselectZdhdjcry" href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="myselectZdhdjcry()">选择检查人员 </a>	
					<%} %>							   
				</td>	
			</tr>
			
			<tr>
				<td style="text-align:right;"><nobr>检查计划:</nobr></td>
				<td colspan="3">
				   <input type="hidden" id="planid" name="planid" />
				   <input id="plantitle" name="plantitle" style="width: 500px" class="easyui-validatebox input_readonly" readonly="readonly" />
					<% if(!"view".equalsIgnoreCase(op)){%>
						<a id="btnselectCheckplan" href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-search" onclick="myselectCheckplan()">选择检查计划 </a>	
					<%} %>							   
				</td>	
			</tr>															
			
			<tr>
			  <td colspan="4" style="height: 50px;" >
			    <div align="right">
			    <% if(!"view".equalsIgnoreCase(op)){%>
				<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveZdhddj"
						iconCls="icon-save" onclick="submitForm();"> 保存 </a>	
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%} %>			
				<a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-back" onclick="closeAndRefreshWindow();"> 取消 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
				</div>														     
			  </td>
			</tr>									
		</table>
  </form>

</body>
</html>