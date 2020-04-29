<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath + "/";
%>
<%
    String fjwid = StringHelper.showNull2Empty(request.getParameter("fjwid"));
    //上传文件存放的目标文件夹名称
    String folderName = StringHelper.showNull2Empty(request.getParameter("folderName"));
    if (fjwid == null || "".equalsIgnoreCase(fjwid)) {
        fjwid = "wuzhuti";
        folderName = "linshi";
    }//
    String v_fjtype = StringHelper.showNull2Empty(request.getParameter("fjtype"));
    if (v_fjtype == null || "".equals(v_fjtype)) {
        v_fjtype = "1";
    }

    String v_iframeUrl = basePath + "/pub/pub/delFjViewIndex?fjwid=" + fjwid + "&fjtype=" + v_fjtype + "&ZuoWeiIframe=1";
    String v_fjext = StringHelper.showNull2Empty(request.getParameter("fjext"));
    if (v_fjext == null || "".equals(v_fjext)) {
        v_fjext = "pic";
    }
    if ("video".equals(v_fjext)) {
        v_iframeUrl = basePath + "/pub/pub/delFjVideoIndex?fjwid=" + fjwid + "&fjtype=" + v_fjtype + "&ZuoWeiIframe=1";
    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>文件上传组件</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
    <script type="text/javascript">
        //gu20170330add 支持只传一个文件
        // var obj = window.dialogArguments;
        var uploadOne = sy.getUrlParam("uploadOne");
        var v_uploadMulti = true;

        var b_fjext = "<%=v_fjext%>";//pic video doc txt
        var v_fjextTitle = "图片";
        var v_fjextContent = "jpg,jpeg,png,gif";
        if (typeof(uploadOne) != "undefined" && uploadOne != null && uploadOne == "yes") {
            v_uploadMulti = false;
        }
        ;
        if (typeof(b_fjext) != "undefined" && b_fjext != null && b_fjext == "video") {
            v_fjextTitle = "视频";
            v_fjextContent = "flv,mp4";
        }
        ;

        var v_local_fjwid = "<%=fjwid%>";
        var v_return = new Object();
        v_return.type = "buok";
        sy.setWinRet(v_return);

        var folderName = '<%=folderName%>';
        var fjpath = [];
        var fjname = [];
        var layer;

        $(function () {
            layui.use(['layer'], function () {
                layer = layui.layer;
            })


	//上传成功回显图片
	function showUploadFj(){
		if(fjpath.length>0){
			var playerHtml = ''; 
			for(var i=0;i<fjpath.length;i++){
				var imgUrl = contextPath + "/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src=" + contextPath + fjpath[i];
				playerHtml = playerHtml + "<div style='float:left;text-align:center;margin:0 20px 20px 0;'><a onclick=\"showPic('" + imgUrl +"')\"><img width=\"200px\" height=\"150px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" + sy.contextPath +  fjpath[i] + "\"/></a></div>"; 
			}
			$('#picbox').append(playerHtml);
		}
	} 
	
	function showPic(imgUrl){
		var dialog = parent.sy.modalDialog({
				title : '查看图片',
				param : {
					proid : v_proid
				},
				width : 800,
				height : 600,
				url : imgUrl
		});
	}
	
	//关闭并刷新父窗口
/*	function closeAndRefreshWindow(){
//		sy.setWinRet(v_return);
//		parent.$("#"+sy.getDialogId()).dialog("close");

        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }*/
	
	function myrefreshfrm(){
		myfrmname.location="<%=v_iframeUrl%>";
	}
	function iframeuse(){
		v_return.type = "deleteok";
	    sy.setWinRet( v_return);
	}

	//上传成功回显图片
/*	function showUploadFj(){
		if(fjpath.length>0){
			var playerHtml = ''; 
			for(var i=0;i<fjpath.length;i++){
				var imgUrl = contextPath + "/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src=" + contextPath + fjpath[i];
				playerHtml = playerHtml + "<div style='float:left;text-align:center;margin:0 20px 20px 0;'><a onclick=\"showPic('" + imgUrl +"')\"><img width=\"200px\" height=\"150px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" + sy.contextPath +  fjpath[i] + "\"/></a></div>"; 
			}
			$('#picbox').append(playerHtml);
		}
	} */
	
/*	function showPic(imgUrl){
		var dialog = parent.sy.modalDialog({
				title : '查看图片',
				param : {
					proid : v_proid
				},
				width : 800,
				height : 600,
				url : imgUrl
		});
	}*/
	
	//关闭并刷新父窗口
	function closeAndRefreshWindow(){
		sy.setWinRet(v_return);
		parent.$("#"+sy.getDialogId()).dialog("close");
	} 
	
/*
	function iframeuse(){
		v_return.type = "deleteok";
	    sy.setWinRet( v_return);
	}*/

            //构造文件上传容器
            $("#uploader").pluploadQueue({
                multi_selection: v_uploadMulti,//gu20170330add
                runtimes: 'html5,flash',//设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html4
                flash_swf_url: '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.flash.swf',// Flash环境路径设置
                silverlight_xap_url: '<%=contextPath%>/jslib/plupload_1_5_7/plupload/js/plupload.silverlight.xap',//silverlight环境路径设置
                url: '<%=contextPath%>/servlet/UploadServlet?folderName=' + folderName,//上传文件URL
                max_file_size: '200mb',//100b, 10kb, 10mb, 1gb
                chunk_size: '1mb',//分块大小，小于这个大小的不分块
                unique_names: true,//生成唯一文件名
                // 如果可能的话，压缩图片大小
                // resize : { width : 320, height : 240, quality : 90 },
                // 指定要浏览的文件类型
                filters: [{
                    title: v_fjextTitle,
                    extensions: v_fjextContent
                    //extensions: "zip,doc,docx,xls,xlsx,ppt,pptx,txt,jpg,jpeg,png,gif"
                }],
                init: {
                    FileUploaded: function (up, file, info) {//文件上传完毕触发
                        var response = $.parseJSON(info.response);
                        if (response.status) {
                            fjpath.push(response.fileUrl);
                            fjname.push(file.name);
                        }
                    },
                    FilesAdded: function (uploader, files) {
                        if (!v_uploadMulti) {
                            if (uploader.files.length > 1) {
                                layer.alert("只能上传一个文件");
                                uploader.removeFile(files[0]);
                            }
                        }
                    }
                }
            });

            //校验表单
            $("#fm").validationEngine({
                //will validate on keyup and blur
                validationEventTriggers: "keyup blur",
                //OPENNING BOX POSITION, IMPLEMENTED: topLeft, topRight, bottomLeft,  centerRight, bottomRight
                promptPosition: "centerRight",
                //addPromptClass : "formError-noArrow formError-text",
                maxErrorsPerField: 1,
                showOneMessage: true,
                //提示信息是否自动隐藏
                autoHidePrompt: true,
                //是否使用美化过的提示框
                prettySelect: true
            });
        });

        //上传图片附件到服务器,保存记录到附件表
        function uploadFj() {
            var status = $("#fm").validationEngine("validate");
            if (status) { //表单验证通过
                var uploader = $('#uploader').pluploadQueue();
                if (uploader.files.length > 0) {// 判断队列中是否有文件需要上传
                    uploader.bind('StateChanged', function () {// 在所有的文件上传完毕时，提交表单
                        if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
                            if (v_local_fjwid == "wuzhuti") {//无主体上传图片
                                v_return.fjpath = fjpath + "";
                                v_return.fjname = fjname + "";
                                v_return.type = "ok";
                                sy.setWinRet(v_return);
                                layer.open({
                                    title: '提示'
                                    , content: '上传成功'
                                    , yes: function (index, layero) {
                                        var a=(fjpath+fjname).indexOf('-');
                                        var s=(fjpath+fjname).substring(0,a-1);
                                        myrefreshfrm(s);
                                        layer.close(index);
//                                        window.location.reload();
                                    }
                                });
                               // window.close();
                            } else {
                                $('#fjpath').val(fjpath);
                                $('#fjname').val(fjname);
                                var formData = $("#fm").serialize();
                                var v_uploadOne = "no";
                                if (!v_uploadMulti) {
                                    v_uploadOne = "yes";
                                }
                                ;
                                $.ajax({
                                    url: basePath + '/pub/pub/saveFj?fjwid=<%=fjwid %>&uploadone=' + v_uploadOne + '&fjtype=<%=v_fjtype%>',
                                    type: 'post',
                                    async: true,
                                    cache: false,
                                    timeout: 100000,
                                    data: formData,
                                    dataType: 'json',
                                    error: function () {
                                        layer.open({
                                            title: '提示'
                                            , content: '服务器繁忙，请稍后再试！'
                                            , yes: function (index, layero) {
                                                $('#btnSave').linkbutton('enable');
                                                layer.close(index);
                                            }
                                        });
                                    },
                                    success: function (result) {
                                        if (result.code == '0') {
                                            layer.open({
                                                title: '提示'
                                                , content: '上传成功'
                                                , yes: function (index, layero) {
                                                    //showUploadFj();
                                                    //document.frames('ifrmname').location.reload();
                                                    myrefreshfrm();
                                                    v_return.type = "ok";
                                                    v_return.fjpath = fjpath + "";
                                                    v_return.fjname = fjname + "";
                                                    sy.setWinRet(v_return);
                                                    layer.close(index);
                                                    window.location.reload();
                                                }
                                            });
                                        } else {
                                            layer.open({
                                                title: '提示'
                                                , content: '上传失败' + result.msg
                                                , yes: function (index, layero) {
                                                    $('#btnSave').attr("display=none");
                                                    layer.close(index);
                                                }
                                            });
                                        }
                                    }
                                });
                            }

                        }
                    });
                    uploader.start();
                } else {
                    layer.alert("请至少选择一个文件进行上传！");
                    $('#btnSave').linkbutton('enable');//
                }
            }
        }

        //关闭窗口
        function closeAndRefreshWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        //刷新myfrmname  div展示图片
        function myrefreshfrm(url) {
            myfrmname.location = "<%=v_iframeUrl%>"+"&url="+url;
        }
        function iframeuse() {
            v_return.type = "deleteok";
            sy.setWinRet(v_return);
        }

    </script>

</head>
<body>
<form id="fm" method="post">
    <input id="fjpath" name="fjpath" type="hidden"/>
    <input id="fjname" name="fjname" type="hidden"/>

    <h2 class="layui-colla-title">文件上传组件</h2>
    <table class="table" style="width: 99%;">
        <tr>
            <td colspan="2">
                <div id="uploader">您的浏览器没有安装Flash插件，或不支持HTML5！</div>
            </td>
        </tr>
    </table>
    <br/>
    <table style="width: 99%;" id="btnSave">
        <tr>
            <td style="text-align:center;">
                <input class="layui-btn" type="button" onclick="uploadFj()" value="开始上传">
            </td>
        </tr>
    </table>


    <h2 class="layui-colla-title">已上传文件</h2>

    <div id="picbox" style="width:100%;text-align:center;">
        <iframe name="myfrmname" id="myfrmid" scrolling="auto" frameborder="0" style="width:100%;height: 400px;"
                src="<%=v_iframeUrl%>"></iframe>
    </div>
</form>
</body>
</html>