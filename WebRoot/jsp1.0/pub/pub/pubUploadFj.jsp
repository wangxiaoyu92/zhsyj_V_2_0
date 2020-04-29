<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="java.util.*"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ contextPath +"/";
%>
<%
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));	
	String v_fjcsdmz = StringHelper.showNull2Empty(request.getParameter("fjcsdmz"));
	
	Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
	String v_userid = vSysUser.getUserid();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件上传组件</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
<script type="text/javascript">
	var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);
	
	var v_tabUploadFjList;
	
	var fjpath = [];
	var fjname = [];
	$(function() {
		//构造文件上传容器
		$("#uploader").pluploadQueue({
			runtimes : 'html5,flash',//设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html4
			flash_swf_url : '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.flash.swf',// Flash环境路径设置
			silverlight_xap_url : '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.silverlight.xap',//silverlight环境路径设置
			url : '<%=contextPath%>/servlet/UploadServlet?folderName=<%=v_dmlb%>',//上传文件URL
			max_file_size : '10mb',//100b, 10kb, 10mb, 1gb
			chunk_size : '1mb',//分块大小，小于这个大小的不分块
			unique_names : true,//生成唯一文件名
			// 如果可能的话，压缩图片大小
			// resize : { width : 320, height : 240, quality : 90 },
			// 指定要浏览的文件类型
			filters : [ {
				title : '图片',
				extensions : 'jpg,jpeg,png,gif'
				//extensions: "zip,doc,docx,xls,xlsx,ppt,pptx,txt,jpg,jpeg,png,gif"
			}],
			init : {
				FileUploaded : function(up, file, info) {//文件上传完毕触发
					var response = $.parseJSON(info.response);
					if (response.status) {
						fjpath.push(response.fileUrl);
						fjname.push(file.name);						
					}
				}
			}
		});
			
		//GRID列表
		v_tabUploadFjList=$('#tabUploadFjList').datagrid({
		    //title:'已上传附件列表',
		    //iconCls:'icon-ok',
		    width:990,
		    height:350,
		    pageSize:20,
		    pageList:[20,40,60],
		    nowrap:true,//True 就会把数据显示在一行里
		    striped:true,//奇偶行使用不同背景色
		    collapsible:false,
		    singleSelect:true,//True 就会只允许选中一行
		    //fit:true,//让DATAGRID自适应其父容器
		    fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
		    pagination:false,//底部显示分页栏
		    rownumbers:true,//是否显示行号
		    url:'<%=basePath%>pub/pub/querySCFjListDetail',
		    loadMsg:'数据加载中,请稍后...',   
		    //sortName:'code',
		    sortOrder:'desc',
		    remoteSort:false,
		    queryParams:{		
				ajdjid:'<%=v_ajdjid%>',
				fjcsdmz:'<%=v_fjcsdmz%>'
			},
		    columns:[[
				{title:'fjid',field:'fjid',align:'center',width:70,hidden:'true'},
				{title:'编号',field:'fjwid',align:'left',hidden:'true',width:150},
				{title:'附件参数代码值',field:'fjcsdmz',align:'left',width:150,hidden:'true'},
				{title:'附件名称',field:'fjcsdmmc',align:'left',width:200},	
				{title:'上传文件名',field:'fjname',align:'left',width:200},
				{title:'操作员',field:'fjczyxm',align:'left',width:200},
				{title:'操作时间',field:'fjczsj',align:'left',width:200},
				{field:'opt',title:'操作',align:'center',width:150,
		              formatter:function(value,rec){ 
					      var v_sysuserid = '<%=v_userid%>';
					      var v_ret = '<span style="color:blue" mce_style="color:blue"><a href="javascript:chakanFuJian('+'\''+rec.fjwid+'\',\''+rec.fjcsdmz+'\',\''+rec.fjid+'\')" mce_href="#"><img src="<%=basePath%>images/pub/view.png" align="absmiddle">查看 </a>';
						  if (rec.fjuserid==null ||rec.fjuserid=="" || v_sysuserid==rec.fjuserid){
							  v_ret = v_ret+'<a href="javascript:deleteFuJian(\''+rec.fjid+'\')" mce_href="#"><img src="<%=basePath%>images/pub/delete.gif" align="absmiddle">删除</a> </span>';
						  }
		                  return  v_ret; 
		             }   
		        } 		
			]]
	   	}); //GRID列表
			
	});/////////////////////////////////////////
	
	
	//查看附件
	function chakanFuJian(v_fjwid,v_fjcsdmz,v_fjid){
		if ((v_fjid==null) || (v_fjid=="") || (v_fjid.length==0)){
	    	alert("请选中一条记录！");
	     	return;
	   	}

		var url = "<%=contextPath %>/pub/pub/pubUploadFjViewIndex?fjwid="+v_fjwid+"&fjcsdmz="+v_fjcsdmz+"&fjid="+v_fjid+"&time="+new Date().getMilliseconds();
		var dialog = parent.sy.modalDialog({
			title : '查看附件',
			width : 800,
			height : 500,
			url : url
		});
	}
	
	
	//删除附件
	function deleteFuJian(v_fjid){
		if ((v_fjid==null) || (v_fjid=="") || (v_fjid.length==0)){
	    	alert("请选择要删除的附件");
	    	return false;
	  	}
	  
		var cfmMsg= "确定删除此条记录吗?";
	 	$.messager.confirm('确认', cfmMsg, function (r) {
	    	if(r){
				$.ajax({
		    		url: basePath+'/pub/pub/uploadFjdel',
		    		type: 'post',
		    		async: true,
		    		cache: false,
		    		timeout: 100000,
		    		data: 'fjid=' + v_fjid,
		    		dataType: 'json',
		    		error: function() {
		    			$.messager.alert('提示','服务器繁忙，请稍后再试！','info');				
		    		},
		    		success: function(result){
		    			if (result.code=='0'){	
			        		$.messager.alert('提示','删除成功','info',function(){
			        			v_tabUploadFjList.datagrid("reload");
			                }); 	                        
		              	} else {
		              		$.messager.alert('提示','删除失败:'+result.msg,'error');
		                }
			        }  
				});
	    	}
		 });
	}


	//保存
	var uploadFj = function(){								
		var status = $("#fm").validationEngine("validate");
		if (status) { //表单验证通过
			$('#btnSave').linkbutton('disable');//
			
			var uploader = $('#uploader').pluploadQueue();
			if (uploader.files.length > 0) {// 判断队列中是否有文件需要上传
				uploader.bind('StateChanged', function() {// 在所有的文件上传完毕时，提交表单
					if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
						//alert("您上传了：" + uploader.files.length + "个文件！");
						//alert(fjpath);
						//alert(fjname);
						$('#fjpath').val(fjpath);
						$('#fjname').val(fjname);

						var formData = $("#fm").serialize();						
						$.ajax({
				    		url: basePath+'pub/pub/uploadFjsave?ajdjid=<%=v_ajdjid%>&fjcsdmz=<%=v_fjcsdmz%>&fjcsdmlb=<%=v_dmlb%>',
				    		type: 'post',
				    		async: true,
				    		cache: false,
				    		timeout: 100000,
				    		data: formData,
				    		dataType: 'json',
				    		error: function() {
				    			$.messager.alert('提示','服务器繁忙，请稍后再试！','info',function(){
				    				$('#btnSave').linkbutton('enable');//
				    			});			
				    		},
				    		success: function(result){ 
							 	if (result.code=='0'){	
					        		$.messager.alert('提示','上传成功','info',function(){
					        			//showUploadFj();
					        			v_tabUploadFjList.datagrid("reload");
					                }); 	                        
				              	} else {
				              		$.messager.alert('提示','上传失败:'+result.msg,'error',function(){
				              			$('#btnSave').linkbutton('enable');//	
				    				});
				                }
					        }  
						});
					}
				});
				uploader.start();
			} else {
				alert('请至少选择一个文件进行上传！');
				$('#btnSave').linkbutton('enable');//
			}		 
		}							
	};

	//上传成功回显图片
	function showUploadFj(){
		if(fjpath.length>0){
			for(var i=0;i<fjpath.length;i++){
				$('#picbox').append("<div style=\"float:left;text-align:center;margin:0 20px 20px 0;\"><a href=" + sy.contextPath + fjpath[i] + " data-lightbox=\"fj\" ><img width=\"200px\" height=\"150px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" + sy.contextPath +  fjpath[i] + "\"/></a></div>");
			}
		}
	} 
	function closeWindow(){
		parent.$("#"+sy.getDialogId()).dialog("close");
	}
</script>
</head>
<body>
<form id="fm"  method="post">
	<input id="fjpath"  name="fjpath" type="hidden" />
	<input id="fjname"  name="fjname" type="hidden" />		
    <sicp3:groupbox title="文件上传组件">
		<table class="table" style="width: 99%;">
			<tr>
				<td colspan="2">
					<div id="uploader">您的浏览器没有安装Flash插件，或不支持HTML5！</div>
				</td>
			</tr>
		</table>
		<br/>
		<table style="width: 99%;">
	        <tr>
				<td style="text-align:center;">
					<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-upload"  onclick="uploadFj();" id="btnSave" >开始上传</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-undo"  onclick="closeWindow()" id="btnCancel" >取消</a>
				</td>
	        </tr>
		</table>
	</sicp3:groupbox>
	<sicp3:groupbox title="已上传附件">
		<table id="tabUploadFjList" style="width:100%;height:100%"></table>
	</sicp3:groupbox>    
</form>
</body>
</html>