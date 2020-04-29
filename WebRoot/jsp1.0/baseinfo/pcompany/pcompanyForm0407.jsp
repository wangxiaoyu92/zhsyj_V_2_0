<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
<%@ page import="com.zzhdsoft.siweb.dto.FjDTO"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));  //企业id
	String sh = StringHelper.showNull2Empty(request.getParameter("sh"));  //审核
%>
<!DOCTYPE html>
<html>
<head>
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	// 企业大类
	//var comdalei = <%=SysmanageUtil.getAa10ComdaleiGrant("COMDALEI","")%>;
	// 企业小类
	var comxiaolei = <%=SysmanageUtil.getAa10toJsonArray("COMXIAOLEI")%>;
	// 店面类型
	var comdmlx = <%=SysmanageUtil.getAa10toJsonArray("COMDMLX")%>;
	// 特色菜系
	var comtscx = <%=SysmanageUtil.getAa10toJsonArray("COMTSCX")%>;
	// 审核标志
	var comshbz = <%=SysmanageUtil.getAa10toJsonArray("CAE092")%>;
	// 检验检测单位标志
	var comjyjcbz = <%=SysmanageUtil.getAa10toJsonArray("COMJYJCBZ")%>;
	// 资质证明
	var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
	//var cb_comdalei; // 企业大类
	//var cb_comxiaolei; // 企业小类
	var cb_comshbz; // 企业审核标志
	var cb_comjyjcbz; // 企业检验检测标志
	var cb_comshengdm; // 省代码
	var cb_comdmlx; // 店面类型
	var cb_comtscx; // 特色菜系
	var cb_comzzzm; // 资质证明
	var grid;
	$(function() {
<%-- 		// 企业大类
		cb_comdalei = $('#comdalei').combobox({
			data:comdalei,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			multiple:true,
			panelHeight : '200',
			onSelect:function(record){
               myshowOrHide(record.id);
               var v_url='<%=basePath%>/pub/pub/getComxiaoleiFromComdalei?aaa102='+record.id;
               $('#comxiaolei').combobox('clear');	
               $('#comxiaolei').combobox('reload',v_url);	
			} 
		}); --%>

/* 		// 企业小类
		cb_comxiaolei = $('#comxiaolei').combobox({
			data:comxiaolei,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		}); */
		// 审核标志
		cb_comshbz = $('#comshbz').combobox({
			data:comshbz,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});
		// 店面类型
		cb_comdmlx = $('#comdmlx').combobox({
			data:comdmlx,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		});
		// 特色菜系
		cb_comtscx = $('#comtscx').combobox({
			data:comtscx,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});
		// 资质证明
		cb_comzzzm = $('#comzzzm').combobox({
			data:comzzzm,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight : '200' 
		});
		// 检验检测部门标志
		cb_comjyjcbz = $('#comjyjcbz').combobox({
			data:comjyjcbz,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		});
	    // 获取所在地区(默认选择省份)
		//getArea("comshengdm", "0");

		if ($('#comid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + 'pcompany/queryPcompanyDTO', {
				comid : $('#comid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;					
					$('form').form('load', mydata);
					//$('#comdalei').combobox('setValues',eval("["+mydata.comdalei2+"]"));
					var qymtzpath = $("#qymtzpath").val();
		            if (qymtzpath != "") {
		            	$("#qymtz").attr("src", "<%=contextPath%>"+qymtzpath);
		            };					
					
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
	            }	
				parent.$.messager.progress('close');
				showUploadFj($('#comid').val());			            
			}, 'json');

			if('<%=op%>' == 'view'||'<%=sh%>' == 'exam'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');				
				$('.Wdate').attr('disabled',true);	
				//cb_comdalei.combobox('disable',true);		
				cb_comshbz.combobox('disable',true);		
				cb_comjyjcbz.combobox('disable',true);
				$("#selectArea").css('display','none');
				$("#btn_save").css('display','none');
				getXkz(false);
				$("a").each(function(index,object){
					object.removeAttribute("onclick");

				});
			}else{
				getXkz(true);
			}
		}else{ 
		}; 
		myshowxkzgrid();
		myshowOrHide(""); 
		
		var xkz_grid = $('#xkz_grid').datagrid({
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,
			pagination : true,// 底部显示分页栏
			pageSize : 3,
			pageList : [3,6,12,24,48],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
			idField: 'comxkzid', //该列是一个唯一列
			sortOrder: 'desc',
			frozenColumns : [[ {
				width : '100',
				title : '证ID',
				field : 'comxkzid',
				hidden : true
			},
			{
				width : '200',
				title : '资质证明',
				field : 'comxkzlx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(comzzzm,value);
			    },
				editor : {
					type : 'combobox',
					options:{
						data:comzzzm,
						valueField:'id',
						textField:'text',
						required:true
					}
				}
			},
			{
			width : '100',
			title : '编号(注册号)',
			field : 'comxkzbh',
			hidden : false,
			editor : {
				type : 'textarea',
				options : {
					required : true
				}
			}
			}]],
			columns : [ [ {
				width : '100',
				title : '有效期起',
				field : 'comxkyxqq',
				hidden : false,
				editor : {
					type : 'datebox',
					options : {
						required : false
					}
				}
			},{
				width : '100',
				title : '有效期止',
				field : 'comxkyxqz',
				hidden : false,
				editor : {
					type : 'datebox',
					options : {
						required : false
					}
				}
			},{
				width : '200',
				title : '许可范围(经营范围)',
				field : 'comxkfw',
				hidden : false,
				editor : {
					type : 'textarea',
					options : {
						required : true
					}
				}
			},
			{
				width : '150',
				title : '主体业态',
				field : 'comxkzztyt',
				hidden : false,
				editor : {
					type : 'textarea'
				}
			},
			{
				width : '250',
				title : '经营场所',
				field : 'comxkzjycs',
				hidden : false,
				editor : {
					type : 'textarea'
				}
			},
			{
				width : '100',
				title : '组成形式',
				field : 'comxkzzcxs',
				hidden : false,
				editor : {
					type : 'textarea'
					}
			}
			 ] ],
			onDblClickRow:function(){//双击事件 查看、修改等操作
				if (op!='view' ){
					var selected = xkz_grid.datagrid('getSelected');
					if(selected){
						mydatagrid_edit(xkz_grid);
						mydatagrid_exceptEndEditing(xkz_grid);
					}
				}
			},
			//工具栏
			toolbar: _toolbar
		});		
		
	});/////////////////////////////////////////
	
	function myshowxkzgrid(){
		var v_comid="nocomid";
		var v_comid2=$('#comid').val();
		if (v_comid2!=null && ""!=v_comid2){
			v_comid=v_comid2;
		}
		$("#xkz_grid").datagrid({
			url :'<%=basePath%>pcompany/queryPcompanyXkzDTO',
			queryParams : { 'comid' : v_comid }
		});		
	}
	
	//判断4品1械
	function mycheckSpyx(prm_comdalei){
		var v_ret="9";
		var v_comdalei;
		if (prm_comdalei!=null && prm_comdalei!=""){
			v_comdalei=prm_comdalei.split("|");
			for (var i=0;i<v_comdalei.length;i++){
				if (v_comdalei[i].indexOf("101")>=0){
					v_ret= "1";
					break;
				}
			}			
		}
		return v_ret;
	}
	
	function myshowOrHide(prm_comdalei){
	  var v_dalei;
	  v_dalei=prm_comdalei;
	  if (v_dalei.length==0){
	    v_dalei=$("#comdalei").combobox("getValue");
	  }
	   //if(v_dalei=="6" || v_dalei=="7"|| v_dalei=="13"|| v_dalei=="14"|| v_dalei=="15"|| v_dalei=="16"|| v_dalei=="17"){
	   var v_spyx=mycheckSpyx(prm_comdalei);
	   if (v_spyx=="1"){  
		   document.getElementById("cyqyyincang").style.display="";
	   }else{
	     document.getElementById("cyqyyincang").style.display="none";
	   }	  
	}
	/* // 所在地区
	function getArea(areaId, parentid) {
		parent.$.messager.progress({ text : '数据加载中....' });
		$("#"+areaId).combotree({
			 url:basePath + '/pcompany/queryPcomdqTree?parentid='+parentid,   
			 required:true,
	         editable:false,
	         panelHeight:180,
	         panelWidth:280,
	         onSelect:function(node){
	         	if (areaId == "comshengdm") {
		         	$("#comshengmc").val(node.text);
		         	getArea("comshidm", node.id);
	         	} else if (areaId == "comshidm") {
	         		$("#comshimc").val(node.text);
	         		getArea("comxiandm", node.id); 
	         	} else if (areaId == "comxiandm") {
	         		$("#comxianmc").val(node.text);
	         		getArea("comxiangdm", node.id);
	         	} else if (areaId == "comxiangdm") { 
	         		$("#comxiangmc").val(node.text);
	         		getArea("comcundm", node.id);
	         	} else if (areaId == "comcundm") {
	         		$("#comcunmc").val(node.text);
	         	}
	         },
	         onLoadSuccess:function(){	         
	         	parent.$.messager.progress('close');
	         }  
		});
	} */

	// 保存企业信息 
	var savePcompany = function() {
		//选择了检验检测标志是  移动电话必须填写
		var v_comjyjcbz = $("#comjyjcbz").combobox("getValue");
		var v_comyddh =$("#comyddh").val();
		
		if (v_comjyjcbz!=null && v_comjyjcbz=="1"){
			if (v_comyddh==null ||v_comyddh==""){
				alert("选择了检验检测标志为 是  移动电话必须填写");
				return false;
			}
		}
		
		var url = basePath + 'pcompany/savePcompany';
		console.log("log");
		console.error("error");
		console.info("info");
		//提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	console.info("resultddddddddddd");
	        	$.messager.progress('close');// 隐藏进度条  
	        	console.info("result"+result);
	        	result = $.parseJSON(result);  
	        	console.info("result2"+result);
	        	alert(result.code);
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

	//企业信息审核通过
	var examPass = function($dialog, $grid, $pjq) {
		var url = basePath + 'pcompany/examPass';

		//提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
	        },
	        success: function(result){
	        	$pjq.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$pjq.messager.alert('提示','审核已通过！','info',function(){
	        			$grid.datagrid('load');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','提交失败！：'+result.msg,'error');
                }
	        }    
		});
	};
	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};
	
	// 从地区下拉树中读取
	function myselectarea(){
		var obj = new Object();
		obj.singleSelect="true";	//
	    var v_retSt = myShow2ModalDialog("<%=basePath%>pub/pub/selectareaIndex?a="+new Date().getMilliseconds(),obj,
	        800,600);
		if (v_retSt != null){
	        $("#comshengmc").val(v_retSt.comshengmc); // 省名称
	        $("#comshimc").val(v_retSt.comshimc); // 市名称
	        $("#comxianmc").val(v_retSt.comxianmc); // 县名称
	        $("#comxiangmc").val(v_retSt.comxiangmc); // 乡名称
	        $("#comcunmc").val(v_retSt.comcunmc); // 村名称
	        $("#comshengdm").val(v_retSt.comshengdm); // 省代码
	        $("#comshidm").val(v_retSt.comshidm); // 市代码
	        $("#comxiandm").val(v_retSt.comxiandm); // 县代码
	        $("#comxiangdm").val(v_retSt.comxiangdm); // 乡代码
	        $("#comcundm").val(v_retSt.comcundm); // 村代码
	    }     
	}
	
	//地图定位获取经纬度
	function myselectjwd(){
		var v_address=$("#comdz").val();		
		var obj = new Object();			
		var v_url=encodeURI(encodeURI("<%=basePath%>jsp/pub/pub/pubMap.jsp?address="+v_address+"&a="+new Date().getMilliseconds()));
	    var v_retSt = pop2window(v_url,obj,900,700);	    
		if (v_retSt != null){
           $("#comjdzb").val(v_retSt.jdzb);
           $("#comwdzb").val(v_retSt.wdzb);	 	
	    }     
	}
	
	//验证身份证的正确性
	function checkSfz(){
		var sfz=$('#comfrsfzh').val();
		var reg=/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/;
		if(reg.test(sfz)){
			return true;
		}else{
			alert("身份证格式错误，请重新输入");
			$('#comfrsfzh').focus();
			return false;
			}
	} 
	
	function showMenu_aaa027() {
		var v_opkind="addcompany";
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp?opkind='+v_opkind; 
		var obj = new Object();
		var k = pop2window(url,obj,300,400);
		if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
			$('#aaa027').val(k.aaa027);
			$('#aaa027name').val(k.aaa027name);
			$('#comdz').val(k.aab301);
		}
	}
	
	//上传附件【这个是原来的，不用了。】
	function uploadFuJian(){
	    var obj = new Object();
	    var style = "help:no;status:no;scroll:yes;dialogWidth:600px;dialogHeight:500px;"
	    	+ "dialogTop:100px;dialogLeft:400px;resizable:no;center:no";   
	    var v_comdm = $("#comdm").val();
		var k = window.showModalDialog("<%=basePath%>jsp/baseinfo/pcompany/uploadcompany.jsp?comdm="+v_comdm+"&time="
			+new Date().getMilliseconds(),obj, style);  
		if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){ //传递回的type为ok的时候才刷新页面。 
			if (k.uploadurl == "/upload/company") {
				$("#comfjfile").attr("src", "<%=contextPath%>"+k.comfjpath);
				$("#comfjpath").val(k.comfjpath);
			}
		}
	}
	
	// 上传图片附件
	function uploadFjView(){
		var comid = $('#comid').val();
		if (comid.length > 0) {
			var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=company&fjwid="+row.comid; 
			var obj = new Object();
			var retVal = pop2window(url,obj,900,700); 
			if(retVal != null){
				if(retVal.type == 'ok'){
					//
				}
			}
		}else{
			$.messager.alert('提示', '请先保存企业信息！', 'info');
		}
	}
	
	//获取上传的图片
	function showUploadFj(comid){
		if(comid!='' && comid!=null){
			$.post(basePath + '/pub/pub/queryFjViewList', {
				'fjwid':comid
			},
			function(result) {
				var mydata = result.data;
				if(mydata!=null){
					var playerHtml = ''; 
					for(var i=0;i<mydata.length;i++){
						var imgUrl = contextPath + "/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src=" + contextPath + mydata[i].fjpath;
						playerHtml = playerHtml + "<div style='float:left;text-align:center;margin:0 20px 20px 0;'><a onclick=\"showPic('" + imgUrl +"')\"><img width=\"200px\" height=\"150px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" + sy.contextPath +  mydata[i].fjpath + "\"/></a></div>"; 
					}
					$('#picbox').append(playerHtml);
				}else{
					$('#picbox').append("暂未上传图片！");
				}			
			},'json');			
		}
	} 
	
	//预览图片
	function showPic(imgUrl){
		var obj = new Object();					
		pop2window(imgUrl,obj,800,600);
	}
	
	
	function mygetcomxiaolei(prm_comdalei){
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		var v_url='<%=basePath%>/pub/pub/getComxiaoleiFromComdalei';
		$.post(v_url, {
			aaa102 : prm_comdalei
		}, 
		function(result) {
			if (result.code=='0') {
				var mydata = result.data;
				$('#comxiaolei').combobox('setValue',mydata);
			} else {
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
            }	
			parent.$.messager.progress('close');
			showUploadFj($('#comid').val());			            
		}, 'json');
	};	
	
	
	//从单位信息表中读取
	function mySelectComfenlei(){
		 
		var obj = new Object();
		obj.singleSelect="true";	//
		var v_mycomdaleicode=$("#comdalei").val();
		var v_mycomxiaoleicode=$("#comxiaolei").val();
		obj.mycomdaleicode=v_mycomdaleicode;
		obj.mycomxiaoleicode=v_mycomxiaoleicode;

	    var v_retObj=myShow2ModalDialog("<%=basePath%>pub/pub/selectComfenleiIndex?a="+new Date().getMilliseconds(),obj,
	        430,530);
	    if (v_retObj!=null){
	    	$("#comdalei").val(v_retObj.comdaleicode);
	    	$("#comdaleiname").val(v_retObj.comdaleiname);
	    	$("#comxiaolei").val(v_retObj.comxiaoleicode);
	    	$("#comxiaoleiname").val(v_retObj.comxiaoleiname);
	    }
	    myshowOrHide(v_retObj.comdaleicode);
	}
	
	// 上传图片附件
	function uploadFjView(prm_fjtype){
        var v_fjwid=$("#comid").val();
		var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=company&fjwid="+v_fjwid+"&fjtype="+prm_fjtype; 
		var obj = new Object();
		obj.uploadOne="yes";//yes 或 no
		var retVal = pop2window(url,obj,900,700); 
		if(retVal != null){
			if(retVal.type == 'ok'){
				if (prm_fjtype=="4"){//企业门头照
				  $("#qymtzpath").val(retVal.fjpath);
				  $("#qymtzname").val(retVal.fjname);	
				  $("#qymtz").attr("src", "<%=contextPath%>"+retVal.fjpath);
				}
			} 
			if(retVal.type == 'deleteok'){
				var v_defaultpic="/images/default.jpg";
				if (prm_fjtype=="4"){//企业门头照
				  $("#qymtzpath").val("");
				  $("#qymtzname").val("");	
				  $("#qymtz").attr("src", "<%=contextPath%>"+v_defaultpic);
				}
			}			
		}

	};
	
</script>

<script type="text/javascript">
	function getXkz(_flag){
		var _toolbar = [{
			iconCls: 'icon-add',
			text: '增加',
			handler: function() {
				mydatagrid_append(xkz_grid);
			}
		},
			'-', {
				iconCls: 'icon-edit',
				text: '修改',
				handler: function() {
					mydatagrid_edit(xkz_grid);
				}
			},
			'-', {
				iconCls: 'icon-remove',
				text: '删除',
				handler: function() {
					var row = xkz_grid.datagrid('getSelected');
					if(row.comxkzid=='' || row.comxkzid==null){
						mydatagrid_remove(xkz_grid);
					}else{
						delXkz();
					}
				}
			},
			'-', {
				iconCls: 'icon-undo',
				text: '取消',
				handler: function() {
					mydatagrid_reject(xkz_grid);
				}
			},
			'-', {
				iconCls: 'icon-save',
				text: '保存',
				handler: function() {
					if(mydatagrid_endEditing(xkz_grid)){
						addXkz();
					}
				}
			}];
		if(!_flag){
			_toolbar = [];
		}
	}

	// 提交保存
	var addXkz = function() {
		var rows = xkz_grid.datagrid("getRows");
		if(rows.length>0){
			var succJsonStr = $.toJSON(rows);
			$.messager.progress();	// 显示进度条
			$.post(basePath + 'pcompany/savePcompanyXkzDTO', {
				comid : $('#comid').val(),
				succJsonStr : succJsonStr
			}, function(result) {
				if (result.code == '0') {
					$.messager.alert('提示', '操作成功', 'info',function(){
						xkz_grid.datagrid('reload');
					});
				} else {
					$.messager.alert('提示', '操作失败:' + result.msg, 'error');
				}
				$.messager.progress('close');
			}, 'json');
		}else{
			$.messager.alert('提示', '没有要保存的记录！', 'info');
		}
	};

	// 删除
	var delXkz = function() {
		var row = xkz_grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗?',function(r) {
				if (r) {
					$.post(basePath + 'pcompany/delPcompanyXkzDTO', {
								comxkzid: row.comxkzid
							},
							function(result) {
								if (result.code == '0') {
									$.messager.alert('提示','删除成功！','info',function(){
										xkz_grid.datagrid('reload');
									});
								} else {
									$.messager.alert('提示', "删除失败：" + result.msg, 'error');
								}
							},
							'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	}
</script>
</head>

<body >
	<form id="fm" method="post" >
		<sicp3:groupbox title="企业基本信息">
			<input name="comfjpath" id="comfjpath"  type="hidden" />
        	<input type="hidden" name="comid" id="comid" value="<%=v_comid %>">
        	<input type="hidden" name="comdm" id="comdm">
        	<input type="hidden" name="comfwnfww" id="comfwnfww">
        		<table class="table" style="width:98%;height: 98%">
        		   <tr style="display: none">
        		     <td width="12%"></td>
        		     <td width="38%"></td>
        		     <td width="15%"></td>
        		     <td width="35%"></td>
        		   </tr>        		
					<tr>
						<td style="text-align:right;"><nobr><font class="myred">*</font>企业名称:</nobr></td>
						<td colspan="2">
						<input id="commc" name="commc" style="width: 400px" 
						  class="easyui-validatebox" data-options="required:true" />
						</td>
						<td rowspan="6" colspan="1" style="text-align: center;">
						    <div style="width:140;height:160;text-align: center;" id="qymtzzhaopian_div" >
						    	<img src="<%=contextPath%>/images/default.jpg" name="qymtz" id="qymtz" height="130" width="150"/>
						   	</div>
						   	<a id="btnselectcom" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-upload"
							onclick="uploadFjView(4)">选择企业门头照</a> 
							<input type="hidden" id="qymtzpath" name="qymtzpath">	
							<input type="hidden" id="qymtzname" name="qymtzname">	
			    		</td>						
					</tr>
					<tr>
                        <td style="text-align:right;">
                           <font class="myred">*</font>企业大类:
                        </td>						
                        <td colspan="1">
                           <input class="easyui-validatebox"  id="comdaleiname" name="comdaleiname" 
                            style="width: 400px;" readonly="readonly" 
                             data-options="required:true" />
                           <input type="hidden" id=comdalei name="comdalei"/>
                           
                        </td>
                        <td rowspan="2" style="text-align: center;">
							<a href="javascript:void(0)" class="easyui-linkbutton" 
							id="mySelectComfenlei"  data-options="size:'large',iconAlign:'top'"
								 onclick="mySelectComfenlei()">选择分类 </a>                        
                        </td>
					</tr>
					<tr>
                        <td style="text-align:right;">企业小类:
                        </td>
                        <td colspan="1">
                          <input id="comxiaoleiname" name="comxiaoleiname" 
                          style="width: 400px;" readonly="readonly" class="easyui-validatebox"  />
                          <input type="hidden" id=comxiaolei name="comxiaolei"/>
                        </td>	                        
					</tr>
																	
					<tr>
						<td style="text-align:right;">
						   <nobr><font class="myred">*</font>所属统筹区:</nobr></td>
						<td colspan="2">
							<input name="aaa027name" id="aaa027name"  style="width: 200px; " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
							</div>							
						</td>

					</tr>
					<tr>
						<td style="text-align:right;"><nobr><font class="myred">*</font>企业地址:</nobr></td>
						<td colspan="2"><input id="comdz" name="comdz" style="width: 400px" 
						class="easyui-validatebox" data-options="required:true"/></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>企业生产地址:</nobr></td>
						<td colspan="2"><input id="comscdz" name="comscdz" style="width: 400px" 
						class="easyui-validatebox" /></td>	
					</tr>					
					<tr>
                      <td style="text-align:right;"><nobr><font class="myred">*</font>地图定位:</nobr></td>
					  <td colspan="2">
					     经度坐标：<input id="comjdzb" name="comjdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
					     纬度坐标：<input id="comwdzb" name="comwdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
								<a href="javascript:void(0)" class="easyui-linkbutton" id="dtdw" 
									iconCls="icon-search" onclick="myselectjwd()">选择经纬度 </a>					     
					  </td>
					</tr>
					<tr>
	 					<td style="text-align:right;"><nobr>检验检测单位标志:</nobr></td>
	 					<td colspan="3"><input id="comjyjcbz" name="comjyjcbz" style="width: 200px" 
	 					class="easyui-combobox" data-options="required:false"/>
	 					</td>					
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>企业法人/业主:</nobr></td>
						<td>
						<input id="comfrhyz" name="comfrhyz" style="width: 200px" 
						class="easyui-validatebox" />
						</td>
						<td style="text-align:right;"><nobr>法人/业主身份证号:</nobr></td>
						<td><input id="comfrsfzh" name="comfrsfzh" style="width: 200px" 
						class="easyui-validatebox" data-options="validType:'idcard'"/></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>注册资金(万元):</nobr></td>
						<td ><input id="comzczj" name="comzczj" style="width: 200px" 
						class="easyui-validatebox" data-options="required:false"/></td>
						<td style="text-align:right;"><nobr>企业负责人:</nobr></td>
						<td><input id="comfzr" name="comfzr" style="width: 200px" 
						class="easyui-validatebox"  /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>组织机构代码:</nobr></td>
						<td><input id="comzzjgdm" name="comzzjgdm" style="width: 200px" 
						class="easyui-validatebox" data-options="required:false"/></td>
						<td style="text-align:right;"><nobr>企业成立日期:</nobr></td>
						<td><input id="comclrq" name="comclrq" style="width: 200px" 
						class="easyui-datebox"/></td>
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>固定电话:</nobr></td>
						<td><input id="comgddh" name="comgddh" style="width: 200px" 
						class="easyui-validatebox" /></td>						
						<td style="text-align:right;"><nobr>移动电话:</nobr></td>
						<td><input id="comyddh" name="comyddh" style="width: 200px" 
						class="easyui-validatebox" data-options="validType:'mobile'"/></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>电子邮箱:</nobr></td>
						<td><input id="comemail" name="comemail" style="width: 200px" 
						class="easyui-validatebox" data-options="validType:'email'"/></td>						
						<td style="text-align:right;"><nobr>邮政编码:</nobr></td>
						<td><input id="comyzbm" name="comyzbm" style="width: 200px" 
						class="easyui-validatebox" data-options="validType:'length[0,6]'" /></td>						
					</tr>
					<%--<tr>--%>
						<%--<td style="text-align:right;"><nobr>资质证明:</nobr></td>--%>
						<%--<td><input id="comzzzm" name="comzzzm" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>							--%>
						<%--<td style="text-align:right;"><nobr>资质证明编号:</nobr></td>--%>
						<%--<td><input id="comzzzmbh" name="comzzzmbh" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>														--%>
					<%--</tr>--%>

					<tr>
						<td style="text-align:right;"><nobr>从业人数:</nobr></td>
						<td><input id="comcyrs" name="comcyrs" style="width: 200px" 
						class="easyui-validatebox" data-options="required:false"/></td>	
						<td style="text-align:right;"><nobr>专/兼职管理人员数:</nobr></td>
						<td><input id="comzjzglrs" name="comzjzglrs" style="width: 200px" 
						class="easyui-validatebox" data-options="required:false"/></td>																	
					</tr>	
					<tbody style="display:none" id="cyqyyincang">
						<tr>
							<td style="text-align:right;"><nobr>餐厅面积:</nobr></td>
							<td><input id="comctmj" name="comctmj" style="width: 200px" 
							class="easyui-validatebox" data-options="required:false"/></td>								
							<td style="text-align:right;"><nobr>厨房面积:</nobr></td>
							<td><input id="comcfmj" name="comcfmj" style="width: 200px" 
							class="easyui-validatebox" data-options="required:false"/></td>								
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>总面积:</nobr></td>
							<td><input id="comzmj" name="comzmj" style="width: 200px" 
							class="easyui-validatebox" data-options="required:false"/></td>
							<td style="text-align:right;"><nobr>店面类型:</nobr></td>
							<td><input id="comdmlx" name="comdmlx" style="width: 200px" 
							class="easyui-validatebox" data-options="required:false"/></td>																
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>就餐人数:</nobr></td>
							<td><input id="comjcrs" name="comjcrs" style="width: 200px" 
							class="easyui-validatebox" data-options="required:false"/></td>								
							<td style="text-align:right;"><nobr>持健康证人数:</nobr></td>
							<td><input id="comcjkzrs" name="comcjkzrs" style="width: 200px" 
							class="easyui-validatebox" data-options="required:false"/></td>								
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>特色菜系:</nobr></td>
							<td><input id="comtscx" name="comtscx" style="width: 200px" 
							class="easyui-validatebox" data-options="required:false"/></td>			
							<td style="text-align:right;"><nobr>特色菜:</nobr></td>
							<td><input id="comtsc" name="comtsc" style="width: 200px" 
							class="easyui-validatebox" data-options="required:false"/></td>												
						</tr>
					</tbody>	
					
					<tbody style="display:none" id="qyUserYincang">
						<tr>
							<td style="text-align:right;"><nobr>厂商识别码:</nobr></td>
							<td>
							  <input id="comcssbm" name="comcssbm" style="width: 200px" 
							  class="easyui-validatebox" data-options="required:false"/>
							</td>								
							<td style="text-align:right;"><nobr>企业投诉电话:</nobr></td>
							<td>
							  <input id="comtsdh" name="comtsdh" style="width: 200px" 
							  class="easyui-validatebox" data-options="required:false"/>
							</td>								
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>企业正门方向:</nobr></td>
							<td><input id="comzmfx" name="comzmfx" style="width: 200px" 
							class="easyui-validatebox" /></td>
							<td style="text-align:right;"><nobr>前一年度固定资产（现值）:</nobr></td>
							<td><input id="comqyndgdzcxz" name="comqyndgdzcxz" style="width: 200px" 
							class="easyui-validatebox" /></td>																
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>前一年度流动资金:</nobr></td>
							<td><input id="comqyndldzj" name="comqyndldzj" style="width: 200px" 
							class="easyui-validatebox" data-options="required:false"/></td>								
							<td style="text-align:right;"><nobr>前一年度总产值:</nobr></td>
							<td><input id="comqyndzcz" name="comqyndzcz" style="width: 200px" 
							class="easyui-validatebox" /></td>								
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>前一年度年销售额:</nobr></td>
							<td><input id="comqyndnxse" name="comqyndnxse" style="width: 200px" 
							class="easyui-validatebox"/></td>			
							<td style="text-align:right;"><nobr>前一年度缴税金额:</nobr></td>
							<td><input id="comqyndyjse" name="comqyndyjse" style="width: 200px" 
							class="easyui-validatebox"/></td>												
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>前一年度年利润:</nobr></td>
							<td><input id="comqyndnlr" name="comqyndnlr" style="width: 200px" 
							class="easyui-validatebox"/></td>			
							<td style="text-align:right;"><nobr>是否通过HACCP认证:</nobr></td>
							<td><input id="comsftghaccp" name="comsftghaccp" style="width: 200px" 
							class="easyui-validatebox"/></td>												
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>HACCP认证证书编号:</nobr></td>
							<td><input id="comhaccpbh" name="comhaccpbh" style="width: 200px" 
							class="easyui-validatebox"/></td>			
							<td style="text-align:right;"><nobr>HACCP发证单位名:</nobr></td>
							<td><input id="comhaccpfzdw" name="comhaccpfzdw" style="width: 200px" 
							class="easyui-validatebox"/></td>												
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>ISO9000证书编号:</nobr></td>
							<td><input id="comiso9000bh" name="comiso9000bh" style="width: 200px" 
							class="easyui-validatebox"/></td>			
							<td style="text-align:right;"><nobr>ISO9000发证单位名:</nobr></td>
							<td><input id="comiso9000fzdw" name="comiso9000fzdw" style="width: 200px" 
							class="easyui-validatebox"/></td>												
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>占地面积:</nobr></td>
							<td><input id="comzdmj" name="comzdmj" style="width: 200px" 
							class="easyui-validatebox"/></td>			
							<td style="text-align:right;"><nobr>建筑面积:</nobr></td>
							<td><input id="comjzmj" name="comjzmj" style="width: 200px" 
							class="easyui-validatebox"/></td>												
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>营业时间:</nobr></td>
							<td><input id="comyysj" name="comyysj" style="width: 200px" 
							class="easyui-validatebox"/></td>			
							<td style="text-align:right;"><nobr> 企业风险等级:</nobr></td>
							<td><input id="comfxdj" name="comfxdj" style="width: 200px" 
							class="easyui-validatebox"/></td>												
						</tr>
					</tbody>						
						

<!-- 					<tr> -->
<!-- 						<td style="text-align:right;"><nobr>所在地区:</nobr></td> -->
<!-- 						<td colspan="3"> -->
<!-- 							<div id="comAreaMc"> -->
<!-- 								<input id="comshengmc" name="comshengmc" style="width: 80px;" readonly="readonly"/> -->
<!-- 								<input id="comshimc" name="comshimc" style="width: 80px;" readonly="readonly"/> -->
<!-- 								<input id="comxianmc" name="comxianmc" style="width: 80px;" readonly="readonly"/> -->
<!-- 								<input id="comxiangmc" name="comxiangmc" style="width: 100px;" readonly="readonly"/> -->
<!-- 								<input id="comcunmc" name="comcunmc" style="width: 100px;" readonly="readonly"/> -->
<!-- 								<input id="comshengdm" name="comshengdm" style="width: 100px; display: none;" /> -->
<!-- 								<input id="comshidm" name="comshidm" style="width: 100px; display: none;" /> -->
<!-- 								<input id="comxiandm" name="comxiandm" style="width: 100px; display: none;" /> -->
<!-- 								<input id="comxiangdm" name="comxiangdm" style="width: 100px; display: none;" /> -->
<!-- 								<input id="comcundm" name="comcundm" style="width: 100px; display: none;" /> -->
<!-- 								<a href="javascript:void(0)" class="easyui-linkbutton" id="selectArea"  -->
<!-- 									iconCls="icon-search" onclick="myselectarea()">选择地区 </a> -->
<!-- 							</div> -->
<!-- 						</td> -->
<!-- 					</tr> -->					
					
<!-- 					<tr> -->
<!-- 						<td style="text-align:right;height:160;"><nobr>公司图片预览:</nobr></td> -->
<!-- 						<td colspan="3"> -->
<!-- 						    <div style="width:130;height:160;" id="comfjfile_div"> -->
<!-- 						    	<img src="<%=contextPath%>/images/default.jpg" name="comfjfile" id="comfjfile"  -->
<!-- 						    		height="140" width="110" /> -->
						    		
<!-- 						   	</div> -->
<!-- 						   	<input type="button" onclick="uploadFuJian()" value="选择图片" > -->
<!-- 			    	    </td>									 -->
<!-- 					</tr>  														 -->
					

				    <%--<tr>--%>
				      <%--<td colspan="4" height="60px;">--%>
						    <%--<div align="right" >--%>
							<%--<a href="javascript:void(0)" class="easyui-linkbutton"--%>
									<%--iconCls="icon-save" onclick="savePcompany();"> 保存 </a>	--%>
									<%--&nbsp;&nbsp;&nbsp;&nbsp;--%>
							<%--<a href="javascript:void(0)" class="easyui-linkbutton"--%>
									<%--iconCls="icon-back" onclick="javascript:window.close();"> 取消 </a>--%>
									<%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		--%>
							<%--</div>				      --%>
				      <%--</td>--%>
				    <%--</tr>																--%>
				</table>
			</sicp3:groupbox>
			<%-- <sicp3:groupbox title="资质证明信息"> --%>
				<div id="xkz_grid" style="width: 980px;"></div>
				<div align="right" >
					<a href="javascript:void(0)" id='btn_save' class="easyui-linkbutton"
					   iconCls="icon-save" onclick="savePcompany();"> 保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" class="easyui-linkbutton"
					   iconCls="icon-back" onclick="javascript:window.close();"> 关闭 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			<%-- </sicp3:groupbox> --%>

			<%-- <sicp3:groupbox title="企业图片"> --%>
				<div id="picbox" style="width:100%;text-align:center;">
		        
				</div>
			<%-- </sicp3:groupbox>	 --%>			

	   </form>
</body>
</html>