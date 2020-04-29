<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
<%@ page import="com.zzhdsoft.siweb.dto.FjDTO"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
	String v_userdalei=sysuser.getUserdalei();//1非企业用户2企业用户
	
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
	String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));  //企业id
	String sh = StringHelper.showNull2Empty(request.getParameter("sh"));  //审核
	String v_comid2="nocomid";
	if (v_comid!=null && !"".equalsIgnoreCase(v_comid)){
		v_comid2=v_comid;
	}
	String v_iframeUrl = basePath + "/jsp/baseinfo/pcompany/pcomZzzm.jsp?op=view&comid="+v_comid2;
	String v_piciframeUrl = basePath + "/pub/pub/delFjViewIndex?op=view&fjwid="+v_comid2+"&fjtype=1&ZuoWeiIframe=1";
	
%>
<!DOCTYPE html>
<html>
<head>
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
var v_comspjkbz = <%=SysmanageUtil.getAa10toJsonArray("COMSPJKBZ")%>;
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
	//var comjyjcbz = <%=SysmanageUtil.getAa10toJsonArray("COMJYJCBZ")%>;
	// 资质证明
	//var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
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
		
	    $('#comspjkbz').combobox({
	    	data : v_comspjkbz,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });		

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
/* 		cb_comshbz = $('#comshbz').combobox({
			data:comshbz,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight:'200'
		}); */
		// 店面类型
		cb_comdmlx = $('#comdmlx').combobox({
			data:comdmlx,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'200' 
		});
		// 特色菜系
		cb_comtscx = $('#comtscx').combobox({
			data:comtscx,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight:'200' 
		});
		// 资质证明
/* 		cb_comzzzm = $('#comzzzm').combobox({
			data:comzzzm,
			valueField:'id',
			textField:'text',
			required:true,
			edittable:false,
			panelHeight:'200' 
		}); */
		// 检验检测部门标志
/* 		cb_comjyjcbz = $('#comjyjcbz').combobox({
			data:comjyjcbz,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight : '200' 
		}); */
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
							            
			}, 'json');

			if('<%=op%>' == 'view'||'<%=sh%>' == 'exam'){	
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');				
				$('.Wdate').attr('disabled',true);	
				//cb_comdalei.combobox('disable',true);		
				//cb_comshbz.combobox('disable',true);		
				//cb_comjyjcbz.combobox('disable',true);
				$("#selectArea").css('display','none');
				$("#btn_save").css('display','none');
				$("a").each(function(index,object){
					if (object.id!="btn_close"){
						object.removeAttribute("onclick");
					};
				});
				//showUploadFj($('#comid').val());
			};
		}else{ 
		}; 
		myshowOrHide(""); 
	});/////////////////////////////////////////
	
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
	};
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
		//gu20170507 var v_comjyjcbz = $("#comjyjcbz").combobox("getValue");
		var v_comjyjcbz ='0';
		var v_comyddh =$("#comyddh").val();
		
		if (v_comjyjcbz!=null && v_comjyjcbz=="1"){
			if (v_comyddh==null ||v_comyddh==""){
				alert("选择了检验检测标志为 是  移动电话必须填写");
				return false;
			}
		}
		
		var url = basePath + 'pcompany/savePcompany';
		
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
	        	$.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						sy.setWinRet("ok")
						closeWindow();
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
	    var url = "<%=basePath%>pub/pub/selectareaIndex?a="+new Date().getMilliseconds();
		var dialog = parent.sy.modalDialog({
			title : ' ',
			param : {
				singleSelect : "true"
			},
			width : 800,
			height : 600,
			url : url
		},function (dialogID){
			var v_retSt = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

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
		});
	}
	
	//地图定位获取经纬度
	function myselectjwd(){
		var v_address=$("#comdz").val();
		var url=encodeURI(encodeURI("<%=basePath%>jsp/pub/pub/pubMap.jsp?address="+v_address+"&a="+new Date().getMilliseconds()));
		var dialog = parent.sy.modalDialog({
			title : '选择经纬度',
			width : 900,
			height : 700,
			url : url
		},function (dialogID) {
			var v_retSt = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if (v_retSt != null) {
				$("#comjdzb").val(v_retSt.jdzb);
				$("#comwdzb").val(v_retSt.wdzb);
			}
		});
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
		var dialog = parent.sy.modalDialog({
			title : '选择地址',
			width : 300,
			height : 400,
			url : url
		},function (dialogID) {
			var k = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
				$('#aaa027').val(k.aaa027);
				$('#aaa027name').val(k.aaa027name);
				$('#comdz').val(k.aab301);
			}
		});

	}
	
	//上传附件【这个是原来的，不用了。】
	function uploadFuJian(){
	    var v_comdm = $("#comdm").val();
		var url = "<%=basePath%>jsp/baseinfo/pcompany/uploadcompany.jsp?comdm="+v_comdm+"&time="
			+new Date().getMilliseconds();

		var dialog = parent.sy.modalDialog({
			title : '上传附件',
			width : 600,
			height : 500,
			url : url
		},function (dialogID) {
			var k = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){ //传递回的type为ok的时候才刷新页面。
				if (k.uploadurl == "/upload/company") {
					$("#comfjfile").attr("src", "<%=contextPath%>"+k.comfjpath);
					$("#comfjpath").val(k.comfjpath);
				}
			}
		});

	}
	
	// 上传图片附件
	function uploadFjView(){
		var comid = $('#comid').val();
		if (comid.length > 0) {
			var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=company&fjwid="+row.comid;
			var dialog = parent.sy.modalDialog({
				title : '上传图片附件',
				width : 900,
				height : 700,
				url : url
			},function (dialogID) {
				var k = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少

				if(k != null){
					if(k.type == 'ok'){
						//
					}
				}
			});

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
		var dialog = parent.sy.modalDialog({
			title : '图片预览',
			width : 800,
			height : 600,
			url : imgUrl
		});
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
		var v_mycomdaleicode=$("#comdalei").val();
		var v_mycomxiaoleicode=$("#comxiaolei").val();
		var obj = new Object();
		obj.singleSelect="true";	//

		obj.mycomdaleicode=v_mycomdaleicode;
		obj.mycomxiaoleicode=v_mycomxiaoleicode;

	    var url="<%=basePath%>pub/pub/selectComfenleiIndex?a="+new Date().getMilliseconds();
		var dialog = parent.sy.modalDialog({
			title : '选择分类',
			param :obj,
			width : 430,
			height : 530,
			url : url
		},function (dialogID) {
			var v_retObj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if (v_retObj!=null){
				$("#comdalei").val(v_retObj.comdaleicode);
				$("#comdaleiname").val(v_retObj.comdaleiname);
				$("#comxiaolei").val(v_retObj.comxiaoleicode);
				$("#comxiaoleiname").val(v_retObj.comxiaoleiname);
			}
			myshowOrHide(v_retObj.comdaleicode);
		});

	}
	
	// 上传图片附件
	function uploadFjViewCanNoId(prm_fjtype){
        var v_fjwid=$("#comid").val();
		var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=company&fjwid="+v_fjwid+"&fjtype="+prm_fjtype; 
		var obj = new Object();
		obj.uploadOne="yes";//yes 或 no
		var dialog = parent.sy.modalDialog({
			title : '上传图片附件',
			param :obj,
			width : 900,
			height : 700,
			url : url
		},function (dialogID) {
			var retVal = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

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
		});


	};
	
	//从单位信息表中读取
	function myselectAjdjXgry(prm_rykind){
		var obj = new Object();
			obj.singleSelect="false";
		var v_useridstr=$("#comrcjdglryid").val();	
	    var url = "<%=basePath%>jsp/pub/pub/selectuserMore.jsp?useridstr="+v_useridstr+"&a="+new Date().getMilliseconds();
		var v_comrcjdglryid="";
		var v_comrcjdglryname="";
		var dialog = parent.sy.modalDialog({
			title : '单位信息',
			param :obj,
			width : 1000,
			height : 600,
			url : url
		},function (dialogID) {
			var v_retStr = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少

			if (v_retStr!=null && v_retStr.length>0){
				for (var k=0;k<=v_retStr.length-1;k++){
					var myrow = v_retStr[k];
					if (""==v_comrcjdglryid){
						v_comrcjdglryid=myrow.userid;
						v_comrcjdglryname=myrow.description;
					}else{
						v_comrcjdglryid=v_comrcjdglryid+","+myrow.userid;
						v_comrcjdglryname=v_comrcjdglryname+","+myrow.description;
					}
				}
				$("#comrcjdglry").val(v_comrcjdglryname);
				$("#comrcjdglryid").val(v_comrcjdglryid);
			};
		});


	};

	var closeWindow = function(){
		parent.$("#"+sy.getDialogId()).dialog("close");
	};
	
	function myclearRcjdgly(){
		$("#comrcjdglry").val('');
		$("#comrcjdglryid").val('');
	};
				
</script>
</head>
<body >
	<form id="fm" method="post" >
		<sicp3:groupbox title="企业基本信息">
			<input type="hidden" name="comfjpath" id="comfjpath"   />
        	<input type="hidden" name="comid" id="comid" value="<%=v_comid %>">
        	<input type="hidden" name="comdm" id="comdm">
        	<input type="hidden" name="comfwnfww" id="comfwnfww" value="0">
        	<input type="hidden" name="comxkzbh" id="comxkzbh">
        	<input type="hidden" name="comfrxb" id="comfrxb">
        	<input type="hidden" name="comfrzw" id="comfrzw">
        	<input type="hidden" name="comcz" id="comcz">
        	<input type="hidden" name="comzclb" id="comzclb">
        	<input type="hidden" name="comdzcczymc" id="comdzcczymc">
        	<input type="hidden" name="comdzcsj" id="comdzcsj">
        	<input type="hidden" name="comshbz" id="comshbz">
        	<input type="hidden" name="comshr" id="comshr">
        	<input type="hidden" name="comshsj" id="comshsj">
        	<input type="hidden" name="comshwtgyy" id="comshwtgyy">
        	<input type="hidden" name="comqyxz" id="comqyxz">
        	<input type="hidden" name="comlrcomid" id="comlrcomid">
        	<input type="hidden" name="comghsorxhs" id="comghsorxhs">
        	<input type="hidden" name="combxbz" id="combxbz">
        	<input type="hidden" name="comhhbbz" id="comhhbbz">
        	<input type="hidden" name="comsyqylx" id="comsyqylx">
        	<input type="hidden" name="comywtz" id="comywtz">
        	<input type="hidden" name="combeizhu" id="combeizhu">
        	<input type="hidden" name="orgid" id="orgid">
        	<input type="hidden" name="commcjc" id="commcjc">
        	<input type="hidden" name="comjyjcbz" id="comjyjcbz">
        	<input type="hidden" name="orderno" id="orderno">
        	<input type="hidden" name="sjdatatime" id="sjdatatime">
        	<input type="hidden" name="sjdatacomid" id="sjdatacomid">
        	<input type="hidden" name="sjdatacomdm" id="sjdatacomdm">
        		
        		<table class="table" style="width:98%;height: 98%">
					<tr>
						<td style="text-align:right;"><nobr><font class="myred">*</font>企业名称:</nobr></td>
						<td colspan="2">
						<input id="commc" name="commc" style="width: 400px" 
						  class="easyui-validatebox" data-options="required:true" />
						</td>
						<td rowspan="6" colspan="1" style="text-align: center;">
						    <div style="width:140;height:160;text-align: center;" id="qymtzzhaopian_div" >
						    	<img src="<%=contextPath%>/images/default.jpg" name="qymtz" id="qymtz" height="130" width="150"
						    	  onclick="g_showBigPic(this.src);" />
						   	</div>
						   	<a id="btnselectcom" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-upload"
							onclick="uploadFjViewCanNoId(4)">选择企业门头照</a> 
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
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							视频企业标志:<input id="comspjkbz" name="comspjkbz" style="width: 150px" class="easyui-validatebox"  />						
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
	 					<td style="text-align:right;"><nobr>选择日常监督管理人员:</nobr></td>
	 					<td colspan="3">
	 					<input id="comrcjdglry" name="comrcjdglry" style="width: 400px" 
	 					class="easyui-validatebox" readonly="readonly" data-options="required:false"/>
	 					<input type="hidden" id="comrcjdglryid" name="comrcjdglryid">
	 					<% if ("1".equals(v_userdalei)){%>
							<a href="javascript:void(0)" class="easyui-linkbutton" id="btn_rcjdglry" 
								iconCls="icon-search" onclick="myselectAjdjXgry(1)">选择人员 </a>	
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton" id="btn_rcjdglry" 
								iconCls="icon-no" onclick="myclearRcjdgly()">清除 </a>	
						<%} %>								 					
	 					</td>					
					</tr>					
<!-- 					<tr >
	 					<td style="text-align:right;"><nobr>检验检测单位标志:</nobr></td>
	 					<td colspan="3"><input  id="comjyjcbz" name="comjyjcbz" style="width: 200px" 
	 					class="easyui-combobox" data-options="required:false"/>
	 					</td>					
					</tr> -->
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
					<tr>
						<td style="text-align:right;"><nobr>企业QQ:</nobr></td>
						<td><input id="comqq" name="comqq" style="width: 200px" 
						class="easyui-validatebox" /></td>						
						<td style="text-align:right;"><nobr>企业网址:</nobr></td>
						<td><input id="comwz" name="comwz" style="width: 200px" 
						class="easyui-validatebox" data-options="validType:'length[0,200]'" /></td>						
					</tr>					
					<tr>
						<td style="text-align:right;"><nobr>从业人数:</nobr></td>
						<td><input id="comcyrs" name="comcyrs" style="width: 200px" 
						class="easyui-validatebox" data-options="required:false"/></td>	
						<td style="text-align:right;"><nobr>专/兼职管理人员数:</nobr></td>
						<td><input id="comzjzglrs" name="comzjzglrs" style="width: 200px" 
						class="easyui-validatebox" data-options="required:false"/></td>																	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>企业简介:</nobr></td>
						<td colspan="3">
							<textarea class="easyui-validatebox" id="comjianjie" name="comjianjie" style="width: 800px;" 
						 	rows="6" data-options="required:false,validType:'length[0,2000]'"></textarea>
						</td>	
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
				</table>
			</sicp3:groupbox>

			    <% if (op!=null && "view".equalsIgnoreCase(op)){ %>
			    <p  class="prowcolor">企业资质证明信息</p>
			    <iframe name="myfrmname" id="myfrmid" scrolling="auto" frameborder="0" 
			    style="width:98%;height: 350px;" src="<%=v_iframeUrl%>">
			    </iframe>
			    <p  class="prowcolor">企业图片</p>
				<div id="picbox" style="width:98%;text-align:center;">	
				   <iframe name="mypiciframename" id="mypiciframeid" 
				   scrolling="auto" frameborder="0" style="width:100%;height: 350px;" 
				   src="<%=v_piciframeUrl%>"></iframe>
				</div>				
				<%} %>
				<div align="right">
				     <p style="margin:3px;">&nbsp;</p>
					<a href="javascript:void(0)" id='btn_save' class="easyui-linkbutton"
					   iconCls="icon-save" onclick="savePcompany();"> 保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a id="btn_close" href="javascript:void(0)" class="easyui-linkbutton"
					   iconCls="icon-back" onclick="closeWindow()"> 关闭 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>

	   </form>
</body>
</html>