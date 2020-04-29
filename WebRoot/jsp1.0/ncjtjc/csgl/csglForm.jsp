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
	String csid = StringHelper.showNull2Empty(request.getParameter("csid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>厨师编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var cssfzjlx = <%=SysmanageUtil.getAa10toJsonArray("AAC058")%>;
	var csxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var cswhcd = <%=SysmanageUtil.getAa10toJsonArray("AAC011")%>;
	var cscynx = <%=SysmanageUtil.getAa10toJsonArray("CYNX")%>;
	var csjkzm = <%=SysmanageUtil.getAa10toJsonArray("JKZM")%>;
	var cspxqk = <%=SysmanageUtil.getAa10toJsonArray("PXQK")%>;
	var cb_cssfzjlx;
	var cb_csxb;
	var cb_cswhcd;
	var cb_cscynx;
	var cb_csjkzm;
	var cb_cspxqk;

	var cssfzjhm_old = '';//身份证修改错误时，回填原值使用。
	var cscsrq_old = '';
	var csxb_old = '';
	
	$(function() {
		cb_cssfzjlx = $('#cssfzjlx').combobox({
	    	data : cssfzjlx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_csxb = $('#csxb').combobox({
	    	data : csxb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_cswhcd = $('#cswhcd').combobox({
	    	data : cswhcd,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : '200' 
	    });
		cb_cscynx = $('#cscynx').combobox({
	    	data : cscynx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_csjkzm = $('#csjkzm').combobox({
	    	data : csjkzm,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_cspxqk = $('#cspxqk').combobox({
	    	data : cspxqk,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
				
		if ($('#csid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/ncjtjc/csgl/queryCsDTO', {
				csid : $('#csid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
					cssfzjhm_old = $('#cssfzjhm').val();
					cscsrq_old = $('#cscsrq').val();
					csxb_old = $('#csxb').combobox('getValue');
					getPersonPhoto($('#csid').val());				
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
			cb_cssfzjlx.combobox('setValue','1');
		}

	});

	// 从数据库获取照片
	function getPersonPhoto(csid){		
		if (csid != null && csid != "") {
			$.post(basePath + '/ncjtjc/csgl/getCszp', {
				'csid':csid
			},
			function(result) {
				$('#cszp').attr('src',result.fileCtxPath + "?" + Math.random());
				if(result.code=='-1'){					
					$.messager.alert('提示', result.msg, 'error');	
				}				
			},
			'json');
		}	
	}

	//验证身份证号码合法性
	function verifyCssfzh(obj) {
		var cssfzjlx = cb_cssfzjlx.combobox('getValue');
		var cssfzjhm = obj.value;
		obj.value = cssfzjhm.toUpperCase();
		if (cssfzjlx == "1") {
			if (!validateCard(obj)) {
				$('#cssfzjhm').val(cssfzjhm_old);
				$('#cscsrq').val(cscsrq_old);
				$('#csxb').combobox('setValue',csxb_old);	
			}
		}
	}
	//验证身份证号码是否已经登记过
	function checkCssfzh(obj) {
		var cssfzjlx = cb_cssfzjlx.combobox('getValue');
		var cssfzjhm = obj.value;
		checkMaskCard(obj,'cscsrq','csxb','1','2'); 
		if (cssfzjhm != "" && cssfzjhm != cssfzjhm_old) {
			$.post(basePath + '/ncjtjc/csgl/isExistsCs', {
				'cssfzjlx':cssfzjlx,'cssfzjhm':cssfzjhm
			},
			function(result) {
				if(result.code=='0'){					
					checkMaskCard(obj,'cscsrq','csxb','1','2');
				}else{
					$.messager.alert('提示', result.msg, 'info');
					$('#cssfzjhm').val(cssfzjhm_old);
					$('#cscsrq').val(cscsrq_old);
					$('#csxb').combobox('setValue',csxb_old);								
				}
			},
			'json');	
		}
	} 

	//根据输入的姓名自动得到拼音码
	function getPinYin() {
		var csxm = $('#csxm').val();
		if (csxm != "") {
			$.post(basePath + '/common/sjb/getChineseSpell', {
				'zwname':csxm
			},
			function(result) {
				$('#cspym').val(result.pym);
			},
			'json');	
		}
	}
	
	//拍照ocx
	function getPhotoByOcx() {		
		var cssfzjhm = $('#cssfzjhm').val();
		if(cssfzjhm==null || cssfzjhm==""){
			$.messager.alert('提示', '身份证号不能为空！', 'info');
			return;
		}
		var form = $('#fm');		
		var cszp = $('#cszp');
		var dialog = parent.sy.modalDialog({
			title : '照片采集',
			iconCls : 'ext-icon-monitor',
			closable : true,
			width : 750,
			height : 500,
			url : basePath + '/camera/ocx/cameraOcx.jsp?aac002=' + cssfzjhm,
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.getPhotoCallBack(dialog, form, cszp, parent.$);
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
		var cssfzjhm = $('#cssfzjhm').val();
		if(cssfzjhm==null || cssfzjhm==""){
			$.messager.alert('提示', '身份证号不能为空！', 'info');
			return;
		}
		var url = basePath + "/camera/cameraWeb.jsp";
		var dialog = parent.sy.modalDialog({ 
				width : 400,
				height : 500,
				param : {
					aac002 : cssfzjhm
				}, 
				url : url
			});
		/* var obj = new Object();
		var sss = popwindow(url,obj,800,500);  	 */	
		//var sss = window.showModalDialog("<%=contextPath%>/camera/cameraWeb.jsp?aac002=" + cssfzjhm, null, "help:no;status:no;dialogWidth:70;dialogHeight:40");
		var ssss = sss.substring(sss.lastIndexOf("/") + 1);
		sss = sss.substring(0, sss.lastIndexOf("/") + 1) + ssss;
		document.getElementById("cszp").src = sss + "?" + Math.random();
		document.getElementById("filepath").value = sss;		
	}
	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url;
		if($('#csid').val().length > 0){
			url = basePath + '/ncjtjc/csgl/updateCs';
		}else{
			url = basePath + '/ncjtjc/csgl/addCs';
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
		var dialog = parent.sy.modalDialog({ 
				width : 400,
				height : 500, 
				url : url
			} ,function(dialogID){
				var k = sy.getWinRet(dialogID); 
				if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
					$('#aaa027').val(k.aaa027);
					$('#aaa027name').val(k.aaa027name);
					$('#csjtzz').val(k.aab301);
				}
				sy.removeWinRet(dialogID);
			});
		/* var obj = new Object();
		var k = popwindow(url,obj,300,400); */
		
	}
	 
	function showMenu_sysorg() {
		var url = basePath + 'jsp/pub/pub/selectSysorg.jsp'; 
		var dialog = parent.sy.modalDialog({ 
				width : 300,
				height : 400,  
				url : url
			} ,function(dialogID){
				var k = sy.getWinRet(dialogID); 
				if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
					$('#orgid').val(k.orgid);
					$('#orgname').val(k.orgname);
				}
				sy.removeWinRet(dialogID);
			});
			
		
	} 
	//上传照片
	function uploadCszp(){
		var url = basePath + "camera/upload.jsp?&time="+new Date().getMilliseconds(); 
	    /* var obj = new Object();
		var k = popwindow(url,obj,600,500);  */
		var dialog = parent.sy.modalDialog({ 
		        title : '上传照片',
				width : 980,
				height : 500, 
				url : url
			},function(dialogID){ 				
				if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
					$("#cszp").attr("src", "<%=contextPath%>"+k.comfjpath);
					$("#filepath").val(k.comfjpath);
				}
			});
	}

</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" >    
			<input name="filepath" id="filepath"  type="hidden" />
	       	<sicp3:groupbox title="厨师信息">	
	       		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>厨师ID:</nobr></td>
						<td><input name="csid" id="csid"  style="width: 175px; " class="input_readonly" readonly="readonly" value="<%=csid%>"/></td>
						<td style="text-align:right;"><nobr>厨师编号:</nobr></td>
						<td><input name="csbh" id="csbh"  style="width: 175px; " class="input_readonly"  readonly="readonly" /></td>					
						<td rowspan="5" colspan="1">
						    <div style="width:110;height:140;" id="cszp_div">
						    	<img src="<%=contextPath%>/images/default.jpg" name="cszp" id="cszp" width="110" height="140"  />
						   	</div>
				    	</td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>厨师姓名:</nobr></td>
						<td><input name="csxm" id="csxm"   style="width: 175px; " class="easyui-validatebox" data-options="required:true" onblur="getPinYin()" /></td>						
						<td style="text-align:right;"><nobr>姓名拼音码:</nobr></td>
						<td><input name="cspym" id="cspym"   style="width: 175px; " class="input_readonly" readonly="readonly"  /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>证件类型:</nobr></td>
						<td><input name="cssfzjlx" id="cssfzjlx"  value="1" style="width: 175px; " class="input_readonly" readonly="readonly" /></td>
						<td style="text-align:right;"><nobr>身份证号:</nobr></td>
						<td><input name="cssfzjhm" id="cssfzjhm"   maxlength="18" style="width: 175px; " class="easyui-validatebox" data-options="required:true"  
							onkeypress="onlyInputNum();" onchange="verifyCssfzh(this)" 
							onblur="checkCssfzh(this);"/>
						</td>			
					</tr>					
					<tr>
						<td style="text-align:right;"><nobr>性别:</nobr></td>
						<td><input name="csxb" id="csxb"   style="width: 175px; " class="input_readonly" readonly="readonly" /></td>
						<td style="text-align:right;"><nobr>出生日期:</nobr></td>
						<td><input name="cscsrq" id="cscsrq"   style="width: 175px; " class="input_readonly" readonly="readonly" /></td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>手机号:</nobr></td>
						<td><input name="cssjh" id="cssjh" style="width: 175px; " class="easyui-validatebox"  data-options="required:true" /></td>					
						<td style="text-align:right;"><nobr>电子邮箱:</nobr></td>
						<td><input name="csyx" id="csyx" style="width: 175px; "  /></td>
					</tr>
					<tr>				
						<td style="text-align:right;"><nobr>QQ:</nobr></td>
						<td><input name="csqq" id="csqq" style="width: 175px; "  /></td>
						<td style="text-align:right;"><nobr>微信号:</nobr></td>
						<td><input name="cswx" id="cswx" style="width: 175px; "  /></td>					
						<td>
							<input type="button" value="拍照" id="savePhotoWeb"  onclick="getPhotoByWeb();">
							<input type="button" value="选择照片" id="savePhotoOcx" onclick="uploadCszp();">
						</td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>文化程度:</nobr></td>
						<td><input name="cswhcd" id="cswhcd" style="width: 175px; "  /></td>					
						<td style="text-align:right;"><nobr>从业年限:</nobr></td>
						<td colspan="2"><input name="cscynx" id="cscynx" style="width: 175px; "  /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>健康证明:</nobr></td>
						<td><input name="csjkzm" id="csjkzm" style="width: 175px; "  /></td>					
						<td style="text-align:right;"><nobr>健康证明有效期:</nobr></td>
						<td colspan="2"><input name="csjkzyxq" id="csjkzyxq" style="width: 175px; "  class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>健康查体地点:</nobr></td>
						<td colspan="4"><input name="csjktjdd" id="csjktjdd"   style="width: 99%; "  /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>培训情况:</nobr></td>
						<td><input name="cspxqk" id="cspxqk" style="width: 175px; "  /></td>					
						<td style="text-align:right;"><nobr>培训合格证有效期:</nobr></td>
						<td colspan="2"><input name="cspxhgzyxq" id="cspxhgzyxq" style="width: 175px; " class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>
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
						<td colspan="4"><input name="csjtzz" id="csjtzz"   style="width: 99%; "  /></td>
					</tr>	
					<tr>
						<td style="text-align:right;"><nobr>服务区域:</nobr></td>
						<td colspan="4"><input name="csfwqy" id="csfwqy"   style="width: 99%; "  /></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>备注:</nobr></td>
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