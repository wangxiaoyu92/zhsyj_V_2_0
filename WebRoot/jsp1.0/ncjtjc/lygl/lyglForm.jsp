<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String lyid = StringHelper.showNull2Empty(request.getParameter("lyid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>两员编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var lysfzjlx = <%=SysmanageUtil.getAa10toJsonArray("AAC058")%>;
	var lyxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var lywhcd = <%=SysmanageUtil.getAa10toJsonArray("AAC011")%>;
	var lycynx = <%=SysmanageUtil.getAa10toJsonArray("CYNX")%>;
	var lyjkzm = <%=SysmanageUtil.getAa10toJsonArray("JKZM")%>;
	var lypxqk = <%=SysmanageUtil.getAa10toJsonArray("PXQK")%>;
	var lylylx = <%=SysmanageUtil.getAa10toJsonArray("LYLX")%>;
	var lyaae013 = <%=SysmanageUtil.getAa10toJsonArray("ZZMM")%>;
	
	var cb_lysfzjlx;
	var cb_lyxb;
	var cb_lywhcd;
	var cb_lycynx;
	var cb_lyjkzm;
	var cb_lypxqk;

	var lysfzjhm_old = '';//身份证修改错误时，回填原值使用。
	var lylyrq_old = '';
	var lyxb_old = '';
	
	$(function() {
		cb_lyaae013 = $('#aae013').combobox({
	    	data : lyaae013,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_lysfzjlx = $('#lysfzjlx').combobox({
	    	data : lysfzjlx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_lyxb = $('#lyxb').combobox({
	    	data : lyxb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_lywhcd = $('#lywhcd').combobox({
	    	data : lywhcd,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : '200' 
	    });
		
		cb_lylylx = $('#lyjktjdd').combobox({
	    	data : lylylx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : '200' 
	    });
				
		cb_lypxqk = $('#lypxqk').combobox({
	    	data : lypxqk,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
				
		if ($('#lyid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/ncjtjc/lygl/queryLyDTO', {
				lyid : $('#lyid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
					lysfzjhm_old = $('#lysfzjhm').val();
					lylyrq_old = $('#lylyrq').val();
					lyxb_old = $('#lyxb').combobox('getValue');
					getPersonPhoto($('#lyid').val());				
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
			}, 'json');

			if('<%=op%>' == 'view'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');				
				$('#savePhotoOcx').attr('disabled',true);	
				$('#savePhotoWeb').attr('disabled',true);
				$('.Wdate').attr('disabled',true);			
			}
		}else{
			cb_lysfzjlx.combobox('setValue','1');
		}

	});

	// 从数据库获取照片
	function getPersonPhoto(lyid){		
		if (lyid != null && lyid != "") {
			$.post(basePath + '/ncjtjc/lygl/getLyzp', {
				'lyid':lyid
			},
			function(result) {
				$('#lyzp').attr('src',result.fileCtxPath + "?" + Math.random());
				if(result.code=='-1'){					
					$.messager.alert('提示', result.msg, 'error');	
				}				
			},
			'json');
		}	
	}

	//验证身份证号码合法性
	function verifyLysfzh(obj) {
		var lysfzjlx = cb_lysfzjlx.combobox('getValue');
		var lysfzjhm = obj.value;
		obj.value = lysfzjhm.toUpperCase();
		if (lysfzjlx == "1") {
			if (!validateCard(obj)) {
				$('#lysfzjhm').val(lysfzjhm_old);
				$('#lylyrq').val(lylyrq_old);
				$('#lyxb').combobox('setValue',lyxb_old);	
			}
		}
	}
	//验证身份证号码是否已经登记过
	function checkLysfzh(obj) {
		var lysfzjlx = cb_lysfzjlx.combobox('getValue');
		var lysfzjhm = obj.value;
		checkMaskCard(obj,'lylyrq','lyxb','1','2'); 
		if (lysfzjhm != "" && lysfzjhm != lysfzjhm_old) {
			$.post(basePath + '/ncjtjc/lygl/isExistsLy', {
				'lysfzjlx':lysfzjlx,'lysfzjhm':lysfzjhm
			},
			function(result) {
				if(result.code=='0'){					
					checkMaskCard(obj,'lylyrq','lyxb','1','2');
				}else{
					$.messager.alert('提示', result.msg, 'info');
					$('#lysfzjhm').val(lysfzjhm_old);
					$('#lylyrq').val(lylyrq_old);
					$('#lyxb').combobox('setValue',lyxb_old);								
				}
			},
			'json');	
		}
	} 

	//根据输入的姓名自动得到拼音码
	function getPinYin() {
		var lyxm = $('#lyxm').val();
		if (lyxm != "") {
			$.post(basePath + '/common/sjb/getChineseSpell', {
				'zwname':lyxm
			},
			function(result) {
				$('#lypym').val(result.pym);
			},
			'json');	
		}
	}
	
	//拍照ocx
	function getPhotoByOcx() {		
		var lysfzjhm = $('#lysfzjhm').val();
		if(lysfzjhm==null || lysfzjhm==""){
			$.messager.alert('提示', '身份证号不能为空！', 'info');
			return;
		}
		var form = $('#fm');		
		var lyzp = $('#lyzp');
		var dialog = parent.sy.modalDialog({
			title : '照片采集',
			iconCls : 'ext-icon-monitor',
			closable : true,
			width : 750,
			height : 500,
			url : basePath + '/camera/ocx/cameraOcx.jsp?aac002=' + lysfzjhm,
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.getPhotoCallBack(dialog, form, lyzp, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.cancelCallBack(dialog, parent.$);
				}
			} ]
		});
	}

	//拍照web
	function getPhotoByWeb() {		
		var lysfzjhm = $('#lysfzjhm').val();
		if(lysfzjhm==null || lysfzjhm==""){
			$.messager.alert('提示', '身份证号不能为空！', 'info');
			return;
		}
		var url = basePath +  "camera/cameraWeb.jsp?aac002=" + lysfzjhm;
		/* var obj = new Object();
		var sss = popwindow(url,obj,800,500);  */
		var dialog = parent.sy.modalDialog({  
				width : 800,
				height : 600, 
				url : url
			},function(dialogID){
				var sss = sy.getWinRet(dialogID);  
					var ssss = sss.substring(sss.lastIndexOf("/") + 1);
					sss = sss.substring(0, sss.lastIndexOf("/") + 1) + ssss;
					document.getElementById("lyzp").src = sss + "?" + Math.random();
					document.getElementById("filepath").value = sss;		
				sy.removeWinRet(dialogID);
			}); 		
		//var sss = window.showModalDialog("<%=contextPath%>/camera/cameraWeb.jsp?aac002=" + lysfzjhm, null, "help:no;status:no;dialogWidth:70;dialogHeight:40");
	}
	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url;
		if($('#lyid').val().length > 0){
			url = basePath + '/ncjtjc/lygl/updateLy';
		}else{
			url = basePath + '/ncjtjc/lygl/addLy';
		}

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
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

	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp'; 
		/* var obj = new Object();
		var k = popwindow(url,obj,300,400); */
		var dialog = parent.sy.modalDialog({
				width : 800,
				height : 600,
				url : url
			},function(dialogID){
				var k = sy.getWinRet(dialogID);  
					if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
						$('#aaa027').val(k.aaa027);
						$('#aaa027name').val(k.aaa027name);
						$('#lyjtzz').val(k.aab301);
					}
				sy.removeWinRet(dialogID);
			});
	}
	
	function showMenu_sysorg() {
		var url = basePath + 'jsp/pub/pub/selectSysorg.jsp'; 
		/* var obj = new Object();
		var k = popwindow(url,obj,300,400); */
		var dialog = parent.sy.modalDialog({  
				width : 800,
				height : 600, 
				url : url
			},function(dialogID){
				var k = sy.getWinRet(dialogID); 
					if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
						$('#orgid').val(k.orgid);
						$('#orgname').val(k.orgname);
					}
				sy.removeWinRet(dialogID);
			});
	}

	//上传照片
	function uploadLyzp(){
		var url = basePath + "camera/upload.jsp?&time="+new Date().getMilliseconds(); 
	   /*  var obj = new Object();
		var k = popwindow(url,obj,600,500);  */
		var dialog = parent.sy.modalDialog({  
				width : 800,
				height : 600, 
				url : url
			},function(dialogID){
				var k = sy.getWinRet(dialogID); 
					if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
						$("#lyzp").attr("src", "<%=contextPath%>"+k.comfjpath);
						$("#filepath").val(k.comfjpath);
					}
				sy.removeWinRet(dialogID);
			});
	}

</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" >    
			<input name="filepath" id="filepath"  type="hidden" />
	       	<sicp3:groupbox title="两员信息">	
	       		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>两员ID:</nobr></td>
						<td><input name="lyid" id="lyid"  style="width: 175px; " class="input_readonly" readonly="readonly" value="<%=lyid%>"/></td>
						<td style="text-align:right;"><nobr>两员编号:</nobr></td>
						<td><input name="lybh" id="lybh"  style="width: 175px; " class="input_readonly"  readonly="readonly" /></td>					
						<td rowspan="5" colspan="1">
						    <div style="width:110;height:140;" id="lyzp_div">
						    	<img src="<%=contextPath%>/images/default.jpg" name="lyzp" id="lyzp" width="110" height="140"  />
						   	</div>
				    	</td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>两员姓名:</nobr></td>
						<td><input name="lyxm" id="lyxm"   style="width: 175px; " class="easyui-validatebox" data-options="required:true" onblur="getPinYin()" /></td>						
						<td style="text-align:right;"><nobr>姓名拼音码:</nobr></td>
						<td><input name="lypym" id="lypym"   style="width: 175px; " class="input_readonly" readonly="readonly"  /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>证件类型:</nobr></td>
						<td><input name="lysfzjlx" id="lysfzjlx"  value="1" style="width: 175px; " class="input_readonly" readonly="readonly" /></td>
						<td style="text-align:right;"><nobr>身份证号:</nobr></td>
						<td><input name="lysfzjhm" id="lysfzjhm"   maxlength="18" style="width: 175px; " class="easyui-validatebox" data-options="required:true"  
							onkeypress="onlyInputNum();" onchange="verifyLysfzh(this)" 
							onblur="checkLysfzh(this);"/>
						</td>			
					</tr>					
					<tr>
						<td style="text-align:right;"><nobr>性别:</nobr></td>
						<td><input name="lyxb" id="lyxb"   style="width: 175px; " class="input_readonly" readonly="readonly" /></td>
						<td style="text-align:right;"><nobr>出生日期:</nobr></td>
						<td><input name="lylyrq" id="lylyrq"   style="width: 175px; " class="input_readonly" readonly="readonly" /></td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>手机号:</nobr></td>
						<td><input name="lysjh" id="lysjh" style="width: 175px; " class="easyui-validatebox"  data-options="required:true" /></td>					
						<td style="text-align:right;"><nobr>电子邮箱:</nobr></td>
						<td><input name="lyyx" id="lyyx" style="width: 175px; "  /></td>
					</tr>
					<tr>				
						<td style="text-align:right;"><nobr>QQ:</nobr></td>
						<td><input name="lyqq" id="lyqq" style="width: 175px; "  /></td>
						<td style="text-align:right;"><nobr>微信号:</nobr></td>
						<td><input name="lywx" id="lywx" style="width: 175px; "  /></td>					
						<td>
							<input type="button" value="拍照" id="savePhotoWeb"  onclick="getPhotoByWeb();">
							<input type="button" value="选择照片" id="savePhotoOcx" onclick="uploadLyzp();">
						</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>文化程度:</nobr></td>
						<td><input name="lywhcd" id="lywhcd" style="width: 175px; "  /></td>					
						<td style="text-align:right;"><nobr>年龄:</nobr></td>
						<td colspan="2"><input name="lycynx" id="lycynx" style="width: 175px; "  /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>职务:</nobr></td>
						<td><input name="lyjkzm" id="lyjkzm" style="width: 175px; "  /></td>					
		
						<td style="text-align:right;"><nobr>两员类型:</nobr></td>
						<td colspan="4"><input name="lyjktjdd" id="lyjktjdd"   style="width: 175px; "  /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>培训情况:</nobr></td>
						<td><input name="lypxqk" id="lypxqk" style="width: 175px; "  /></td>					
						<td style="text-align:right;"><nobr>培训合格证有效期:</nobr></td>
						<td colspan="2"><input name="lypxhgzyxq" id="lypxhgzyxq" style="width: 175px; " class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>
					</tr>									
					<tr>
						<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
						<td>
							<input name="aaa027name" id="aaa027name"  style="width: 175px; " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
							</div>							
						</td>
						<td style="text-align:right;"><nobr>所属机构:</nobr></td>
						<td colspan="2">
							<input name="orgname" id="orgname"  style="width: 175px; " onclick="showMenu_sysorg();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:false" />
							<input name="orgid" id="orgid"  type="hidden"/>
							<div id="menuContent_sysorg" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_sysorg" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
							</div>							
						</td>				
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>家庭住址:</nobr></td>
						<td colspan="4"><input name="lyjtzz" id="lyjtzz"   style="width: 99%; "  /></td>
					</tr>	
					<tr>
						<td style="text-align:right;"><nobr>服务区域:</nobr></td>
						<td colspan="4"><input name="lyfwqy" id="lyfwqy"   style="width: 99%; "  /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>政治面貌:</nobr></td>
						<td colspan="4"><input name="aae013" id="aae013" style="width: 99%;  "/></td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>经办人:</nobr></td>
						<td><input name="aae011" id="aae011" style="width: 175px; "  class="input_readonly" readonly="readonly"  /></td>					
						<td style="text-align:right;"><nobr>经办时间:</nobr></td>
						<td colspan="2"><input name="aae036" id="aae036" style="width: 175px; " class="input_readonly" readonly="readonly"  /></td>
					</tr>
				</table>
	        </sicp3:groupbox>
		</form>
    </div>    
</body>
</html>