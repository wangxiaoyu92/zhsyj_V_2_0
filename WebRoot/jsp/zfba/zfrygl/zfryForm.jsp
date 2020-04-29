<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String zfryid = StringHelper.showNull2Empty(request.getParameter("zfryid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>执法人员编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">

var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
var lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>; 
var zfryxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
var cb_zfryxb;
var zfrysfzh_old = '';//身份证修改错误时，回填原值使用。
var zfrycsrq_old = '';
var zfryxb_old = '';
$(function(){
	 
	cb_zfryxb = $('#zfryxb').combobox({
    	data : zfryxb,      
        valueField : 'id',   
        textField : 'text',
        required : true,
        editable : false,
        panelHeight : '200' 
    });
	cb_userkind = $('#userkind').combobox({
    	data : userkind,      
        valueField : 'id',   
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : '200'  
    });
	cb_lockstate = $('#lockstate').combobox({
    	data : lockstate,      
        valueField : 'id',   
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : '200' 
    });
	cbt_orgid = $('#orgid').combotree({
		 url:basePath + '/sysmanager/sysorg/querySysorgTree',   
		 required:true,
         editable:false,
         panelHeight:180,
         panelWidth:280  
	});
	
	$.ajax({
		url:basePath +"/zfba/zfrygl/queryZfly",
		dataType:"json",
		success: function(result ){ 
			data= result; 
				$('#zfryzflyid').combobox({
			         data : data,    
			         valueField : 'zfrylyid',   
				     textField : 'zfrylybm',
			         required : false,
				     editable : false,
				     panelHeight : 'auto' 
			    });  
			},
			error:function(){
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
			}
	});
		   
	if ($('#zfryid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + '/zfba/zfrygl/zfryDTO', {
			zfryid : $('#zfryid').val()
		}, 
		function(result) { 
			if (result.code=='0') {
				var mydata = result.data;
				$('#fm').form('load', mydata); 	
				getPersonPhoto($('#zfryid').val());
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

// 从数据库获取照片
function getPersonPhoto(zfryid){		
	if (zfryid != null && zfryid != "") {
		$.post(basePath + '/zfba/zfrygl/getZfryzp', {
			'zfryid':zfryid
		},
		function(result) {
			$('#zfryzp').attr('src',result.fileCtxPath + "?" + Math.random());
			if(result.code=='-1'){					
				$.messager.alert('提示', result.msg, 'error');	
			}				
		},
		'json');
	}	
}

//验证身份证号码合法性
function verifyZfrysfzh(obj) { 
	var Zfrysfzh = obj.value;
	obj.value = Zfrysfzh.toUpperCase(); 
	if (!validateCard(obj)) {
		$('#zfrysfzh').val(zfrysfzh_old);
		$('#zfrycsrq').val(zfrycsrq_old); 
		$('#zfryxb').combobox('setValue',zfryxb_old);	 
	}
}
//验证身份证号码是否已经登记过
function checkZfrysfzh(obj) { 
	var zfrysfzh = obj.value; 
	checkMaskCard(obj,'zfrycsrq','zfryxb','1','2'); 
	if (zfrysfzh != "" ) {
		$.post(basePath + '/zfba/zfrygl/isExistsZfry', {
			 'zfrysfzh':zfrysfzh
		},
		function(result) { 
			if(result.code=='0'){					
				checkMaskCard(obj,'zfrycsrq','zfryxb','1','2');
			}else{
				$.messager.alert('提示', result.msg, 'info');
				$('#zfrysfzh').val(zfrysfzh_old);
				$('#zfrycsrq').val(zfrycsrq_old);
				$('#zfryxb').combobox('setValue',zfryxb_old);				
			}
		},
		'json');	
	}
} 


//获取姓名拼音
function getPinYin() {
	var sjname = $('#zfryname').val();
	if (sjname != "") {
		$.post(basePath + '/common/sjb/getChineseSpell', {
			'sjname':sjname
		},
		function(result) {
			$('#zfrypym').val(result.sjpym);
		},
		'json');	
	}
}
//保存 执法人员页面
var submitForm = function($dialog, $grid, $pjq) { 
	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$pjq.messager.progress();	// 显示进度条
	$('#fm').form('submit',{
		url: basePath + '/zfba/zfrygl/createZfry',
		onSubmit: function(){ 
			// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
			var isValid = $(this).form('validate'); 
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
//拍照ocx
function getPhotoByOcx() {		
	var zfrysfzh = $('#zfrysfzh').val();
	if(zfrysfzh==null || zfrysfzh==""){
		$.messager.alert('提示', '身份证号不能为空！', 'info');
		return;
	}
	var form = $('#fm');		
	var zfryzp = $('#zfryzp');
	var dialog = parent.sy.modalDialog({
		title : '照片采集',
		iconCls : 'ext-icon-monitor',
		closable : true,
		width : 750,
		height : 500,
		url : basePath + '/camera/ocx/cameraOcx.jsp?aac002=' + zfrysfzh,
		buttons : [ {
			text : '确定',
			handler : function() {
				dialog.find('iframe').get(0).contentWindow.getPhotoCallBack(dialog, form, zfryzp, parent.$);
			}
		},{
			text : '取消',
			handler : function() {
				dialog.find('iframe').get(0).contentWindow.cancelCallBack(dialog, parent.$);
			}
		} ]
	},function(dialogID) {
	    sy.removeWinRet(dialogID);//不可缺少
	});
}

//拍照web
function getPhotoByWeb() {		
	var zfrysfzh = $('#zfrysfzh').val();
	if(zfrysfzh==null || zfrysfzh==""){
		$.messager.alert('提示', '身份证号不能为空！', 'info');
		return;
	}		
	var dialog = parent.sy.modalDialog({
		title : '拍照',
		width : 70,
		height : 40,
		url : basePath + 'camera/cameraWeb.jsp?aac002=' + zfrysfzh
	},function(dialogID) {
		var sss = sy.getWinRet(dialogID);
		var ssss = sss.substring(sss.lastIndexOf("/") + 1);
		sss = sss.substring(0, sss.lastIndexOf("/") + 1) + ssss;
		document.getElementById("zfryzp").src = sss + "?" + Math.random();
		document.getElementById("filepath").value = sss;
	    sy.removeWinRet(dialogID);//不可缺少
	});		
}


function selectUser(){
    var dialog = parent.sy.modalDialog({
		title : '选择人员',
		param : {
			singleSelect : "true",
			a : new Date().getMilliseconds()
		},
		width : 800,
		height : 500,
		url : basePath + 'zfba/ajla/zfPubIndex'
	},function(dialogID) {
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
			for (var k = 0; k <= v_retStr.length - 1; k++){
		    	var myrow = v_retStr[k];
		      	$("#zfryuserid").val(myrow.userid);   
		    }
	    }
	    sy.removeWinRet(dialogID);//不可缺少
	});	  
}
//关闭窗口
var closeWindow = function($dialog, $pjq){
	$dialog.dialog('destroy');
};

</script>
</head>
<body>    
	<form id="fm" method="post">
		<input name="filepath" id="filepath"  type="hidden" />
       	<sicp3:groupbox title="执法人员信息">	
       		<table class="table" style="width: 99%;">
				 <tr>
					<td style="text-align:right;"><nobr>执法人员ID</nobr></td>
					<td><input name="zfryid" id="zfryid"  style="width: 175px; " 
						class="input_readonly" readonly="readonly" value="<%=zfryid%>"/></td>
					<td style="text-align:right;"><nobr>执法人员编号</nobr></td>
					<td><input id="zfrybh " name="zfrybh" style="width: 175px" /></td>				
				 	<td rowspan="5" colspan="1">
					    <div style="width:130;height:160;" id="zfryzp_div">
					    	<img src="<%=contextPath%>/images/default.jpg" 
					    		name="zfryzp" id="zfryzp" height="140" width="110"  />
					   	</div>
			    	</td>
				 </tr>
				<tr>
					<td style="text-align:right;"><nobr>姓名</nobr></td>
					<td><input name="zfryname" id="zfryname"   style="width: 175px; " 
						class="easyui-validatebox" data-options="required:true" onblur="getPinYin()" /></td>						
					<td style="text-align:right;"><nobr>姓名拼音码</nobr></td>
					<td><input name="zfrypym" id="zfrypym"   style="width: 175px; " 
						class="input_readonly" readonly="readonly"  /></td>						
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>身份证号</nobr></td>
					<td><input name="zfrysfzh" id="zfrysfzh"   maxlength="18" style="width: 175px; " 
						class="easyui-validatebox" data-options="required:true"  
						onkeypress="onlyInputNum();" onchange="verifyZfrysfzh(this)" 
						onblur="checkZfrysfzh(this);"/>
					<td style="text-align:right;"><nobr>操作员</nobr></td>
					<td><input name="zfryczy" id="zfryczy"   readonly="readonly" style="width: 175px;"  ></td>
					</td>			
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>性别</nobr></td>
					<td><input name="zfryxb" id="zfryxb"   style="width: 175px; " 
						class="input_readonly" readonly="readonly" /></td>
					<td style="text-align:right;"><nobr>出生日期</nobr></td>
					<td><input name="zfrycsrq" id="zfrycsrq"   style="width: 175px; " 
						class="input_readonly" readonly="readonly" /></td>									
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>执法领域</nobr></td>
					<td><input name="zfryzflyid" id="zfryzflyid" style="width: 175px; "  /></td>
						<td style="text-align:right;"><nobr>手机号</nobr></td>
					<td><input name="zfrysjh" id="zfrysjh" style="width: 175px; " 
						class="easyui-validatebox"  data-options="required:true" /></td>			
				</td>					
				</tr>
				<tr>				
					<td style="text-align:right;"><nobr>证件号码</nobr></td>
					<td><input name="zfryzjhm" id="zfryzjhm" style="width: 175px; " 
						class="input_readonly" readonly="readonly" /></td>
					<td style="text-align:right;"><nobr>操作时间</nobr></td>
					<td><input name="zfryczsj" id="zfryczsj"  class="Wdate" 
						onclick="WdatePicker({minDate:'#F{$dp.$D(\'zfryczsj\')}',readOnly:true,dateFmt:'yyyy-MM-dd'})" 
						readonly="readonly" style="width: 175px;"  ></td>
					<td>
						<input type="button" value="拍 照1" id="savePhotoOcx" onclick="getPhotoByOcx();">
						<input type="button" value="拍照2" id="savePhotoWeb"  onclick="getPhotoByWeb();">
					</td>
				</tr>
				<tr id="yc">
					<td  style="text-align:right;"><nobr>用户类别:</nobr></td>
					<td><input id="userkind" name="userkind" style="width: 175px" 
						class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>
					<td style="text-align:right;"><nobr>账户锁定状态:</nobr></td>
					<td><input id="lockstate" name="lockstate" style="width: 175px" 
						class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>						
				</tr>
				<tr id="yc1">
					<td style="text-align:right;"><nobr>机构ID:</nobr></td>
					<td><input id="orgid" name="orgid" style="width: 175px" /></td>			
					<td style="text-align:right;"><nobr>统筹区:</nobr></td>
					<td><input id="aaa027" name="aaa027" style="width: 175px" 
						class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>									
				</tr>
				<tr>  
					<td style="text-align:right;"><nobr>用户id</nobr></td>
					<td  colspan="4"><input name="zfryuserid" id="zfryuserid" 
						style="width: 175px; " class="easyui-validatebox"  data-options="required:true" />
					<% if(!"view".equalsIgnoreCase(op)){%>
						<a id="btnselectcom" href="javascript:void(0)"
						class="easyui-linkbutton" iconCls="icon-search"
						onclick="selectUser()">选择用户 </a> <%} %>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>备注</nobr></td>
					<td colspan="4"><input name="zfrybz" id="zfrybz" style="width: 99%;  "/></td>									
				</tr>
			</table>
        </sicp3:groupbox>
   </form>
</body>
</html>