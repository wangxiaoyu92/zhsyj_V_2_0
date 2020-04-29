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
	String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>执法人员编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var zfryxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
var zfryzfly = <%=SysmanageUtil.getAa10toJsonArrayXz("ZFRYLYBM")%>;
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
        panelHeight : 'auto' 
    });
	cb_sjsfzjlx = $('#zfryzflybmComBo').combotree({
    	data : zfryzfly,      
        valueField : 'id',   
        textField : 'text',
        required : false,
        editable : false,
        panelHeight : 'auto',
        multiple:true,
        cascadeCheck: false 
    });
    
	if ($('#userid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + '/zfba/zfrygl/pzfryDTO', {
			userid : $('#userid').val()
		}, 
		function(result) { 
			if (result.code=='0') {
				var mydata = result.data;
				$('#fm').form('load', mydata); 	
			     var v_aa=$('#zfryzflybm').val(); 
	             var v_cc=[];
	             v_cc=v_aa.split(',');
	  
	             $("#zfryzflybmComBo").combotree("setValues", v_cc);
				 var zfryzppath = $("#zfryzppath").val();
	             if (zfryzppath != "") {
	            	$("#zfryzp").attr("src", "<%=contextPath%>"+zfryzppath);
	             };	                
	    
			} else {
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	        }	
			parent.$.messager.progress('close');
		}, 'json');
		if('<%=op%>' == 'view'){	
			$('form :input').addClass('input_readonly');
			$('form :input').attr('readonly','readonly');
			$("#btnselectZfryzp").css('display','none');
			$('#zjh').show();		
	      }
	}
});

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
function getPinYin()  { 
	var zfrypym = $('#description').val();
	if (zfrypym != "") {
		$.post(basePath + '/zfba/zfrygl/getPY', {
			'zfrypym':zfrypym
		},
		function(data) { 
			$('#zfrypym').val(data);
		},
		'json');	
	}
}
//更新执法人员    也就是插入到Pzfry表
var submitForm = function($dialog, $grid, $pjq) { 
	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$pjq.messager.progress();	// 显示进度条
	$('#fm').form('submit',{
		url: basePath + '/zfba/zfrygl/reZfry',
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
		 		    //此方法返回后全选当前页所有下拉列
        			//$grid.datagrid('reload');
        			//此方法返回后选中当前页
        			$grid.datagrid('load');
        			$dialog.dialog('destroy');  
        		}); 	                        	                     
          	} else {
          		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
            }
        }    
	});
};


//关闭窗口
var closeWindow = function($dialog, $pjq){
	$dialog.dialog('destroy');
};

// 上传图片附件
function uploadFjViewCanNoId(prm_fjtype){
	var v_fjwid=$("#zfryid").val();
	var url = basePath + 'pub/pub/uploadFjViewIndex';
	var dialog = parent.sy.modalDialog({
			title : '上传附件',
			param : {
				folderName : "zfrypic",
				fjwid : v_fjwid,
				fjtype : "10",
				uploadOne : "yes"
			},
			width : 900,
			height : 700,
			url : url
	},function(dialogID) {
		var retVal = sy.getWinRet(dialogID);
		if(retVal != null){
			if(retVal.type == 'ok'){
				if (prm_fjtype=="10"){//企业门头照
				  $("#zfryzppath").val(retVal.fjpath);
				  $("#zfryzpname").val(retVal.fjname);	
				  $("#zfryzp").attr("src", "<%=contextPath%>"+retVal.fjpath);
				}
			} 
			if(retVal.type == 'deleteok'){
				var v_defaultpic="/images/default.jpg";
				if (prm_fjtype=="10"){//企业门头照
				  $("#zfryzppath").val("");
				  $("#zfryzpname").val("");	
				  $("#zfryzp").attr("src", "<%=contextPath%>"+v_defaultpic);
				}
			}			
		}
	    sy.removeWinRet(dialogID);//不可缺少
	});
}
</script>
</head>
<body>    

	<form id="fm" method="post">
	<input name="zfryzflybm" id="zfryzflybm" type="hidden"/>
		<input name="filepath" id="filepath"  type="hidden" />
       	<input name="userid" id="userid"  type="hidden" style="width: 175px; " class="input_readonly" 
       		readonly="readonly" value="<%=userid%>"/> 
       	<input type="hidden" id="zfryid" name="zfryid">
       	<sicp3:groupbox title="执法人员信息">	
       	    
       		<table class="table" style="width: 99%;">
				 <tr>
					<td style="text-align:right;"><nobr>执法人员登录账号</nobr></td>
					<td><input id="username" name="username" style="width: 175px" 
					  class="easyui-validatebox" data-options="required:true"/></td>				
                    <td colspan="2" rowspan="6" style="text-align: center;">
                       <div style="width:130;height:160;text-align: center;" id="ryzhaopian_div" >
				    	<img src="<%=contextPath%>/images/default.jpg" name="zfryzp" id="zfryzp" 
				    		height="140" width="120" onclick="g_showBigPic(this.src);"/>
					   </div>
					   	<a id="btnselectZfryzp" href="javascript:void(0)"
						class="easyui-linkbutton" iconCls="icon-search"
						onclick="uploadFjViewCanNoId(10)">选择人员照片</a> 
						<input type="hidden" id="zfryzppath" name="zfryzppath">	
						<input type="hidden" id="zfryzpname" name="zfryzpname">                    
                    </td> 
				 </tr>
				 <tr>
					<td style="text-align:right;"><nobr>执法人员姓名</nobr></td>
					<td><input name="description" id="description"   style="width: 175px; " class="easyui-validatebox" 
					  data-options="required:true"  onblur="getPinYin()" /></td>				 
				 </tr>
				 <tr>
				  	<td style="text-align:right;"><nobr>姓名拼音码</nobr></td>
					<td><input name="zfrypym" id="zfrypym"   style="width: 175px; " 
						class="input_readonly" readonly="readonly"  /></td>
                 </tr>
                 <tr>											
					<td style="text-align:right;"><nobr>性别</nobr></td>
					<td><input name="zfryxb" id="zfryxb"   style="width: 175px; "  /></td>
					</td>			
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>身份证号</nobr></td>
					<td><input name="zfrysfzh" id="zfrysfzh"   maxlength="18" style="width: 175px; " 
					 class="easyui-validatebox" 
					onkeypress="onlyInputNum();" onchange="verifyZfrysfzh(this)" 
						onblur="checkZfrysfzh(this);"/> 
				</tr>
				<tr>		
					<td style="text-align:right;"><nobr>出生日期</nobr></td>
					<td><input name="zfrycsrq" id="zfrycsrq"   style="width: 175px; " 
					class="input_readonly" readonly="readonly" /></td>									
				</tr>
				<tr>				
					<td style="text-align:right;"><nobr>执法领域</nobr></td>
				    <td><select id="zfryzflybmComBo"  name="zfryzflybmComBo"   style="width:175px;"></select></td>
					<td style="text-align:right;"><nobr>手机号</nobr></td>
					<td><input name="mobile" id="mobile" style="width: 175px; "  
						data-options="required:true,validType:['length[0,20]','phoneAndMobile']" /></td>			
				</tr> 
				<tr>				
					<td style="text-align:right;"><nobr>手机号2</nobr></td>
				    <td><input id="mobile2"  name="mobile2"   data-options="validType:['length[0,20]','phoneAndMobile']" 
				    	style="width:175px;"/></td>
					<td style="text-align:right;"><nobr>固定电话</nobr></td>
					<td><input name="telephone" id="telephone" style="width: 175px; "  /></td>			
				</tr> 				
				<tr>
					<td  style="text-align:right;"><nobr>职务:</nobr></td>
					<td><input id="zfryzw" name="zfryzw" style="width: 175px" class="easyui-validatebox" 
						data-options="validType:'comboboxNoEmpty'" /></td>
					<td style="text-align:right;"><nobr>机构名称:</nobr></td>
					<td><input id="orgname" name="orgname" style="width: 175px" /></td>			
				</tr>
				 
				<tr>
				<td  style="text-align:right;"><nobr> 证件号码:</nobr></td>
					<td><input id="zfryzjhm" name="zfryzjhm" style="width: 175px" 
						class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>
				</tr>	
				<tr> 
					<td style="text-align:right;"><nobr>备注</nobr></td>
					<td colspan="3"><input name="zfrybz" id="zfrybz" style="width: 99%;  "/></td>									
				</tr>
			</table>
        </sicp3:groupbox>
   </form>
</body>
</html>