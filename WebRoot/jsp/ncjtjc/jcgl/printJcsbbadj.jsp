<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<!DOCTYPE html>
<html>
<head>
<title>打印《农村集体聚餐备案登记表》</title>
<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
<script src="<%=basePath %>jslib/ckeditor_4.7.0/ckeditor.js"></script>
<script type="text/javascript">
var editor;
$(function() {
				//加载ckeditor
					 editor = CKEDITOR.replace( 'detailinfo', {
						extraPlugins: 'colordialog,table',
						height: 470
					} );
// 					设置只读
					 CKEDITOR.on('instanceReady', function (ev) {
                editor = ev.editor;
                editor.setReadOnly(true); 
            });
});

	
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};

function InsertHTML() {
	// Get the editor instance that we want to interact with.
	var editor = CKEDITOR.instances.editor;
	var value = document.getElementById( 'htmlArea' ).value;

	// Check the active editing mode.
	if ( editor.mode == 'wysiwyg' )
	{
		// Insert HTML code.
		// http://docs.ckeditor.com/#!/api/CKEDITOR.editor-method-insertHtml
		editor.insertHtml( value );
	}
	else
		alert( 'You must be in WYSIWYG mode!' );
}
function ExecuteCommand( commandName ) {
	// Get the editor instance that we want to interact with.
	var editor = CKEDITOR.instances.editor1;

	// Check the active editing mode.
	if ( editor.mode == 'wysiwyg' )
	{
		// Execute the command.
		// http://docs.ckeditor.com/#!/api/CKEDITOR.editor-method-execCommand
		editor.execCommand( commandName );
	}
	else
		alert( 'You must be in WYSIWYG mode!' );
}
//只读
function toggleReadOnly() {
			// Change the read-only state of the editor.
			// http://docs.ckeditor.com/#!/api/CKEDITOR.editor-method-setReadOnly
			editor.setReadOnly();
		}

</script>


</head>

<body >
	<div  style="width: 99%;" >
	<sicp3:groupbox title="打印《农村集体聚餐备案登记表》" >	
        		<div class="grid-width-100">
 <textarea    name="detailinfo" id="detailinfo" style="width: 80%;height: 50%">${obj.data}</textarea>

			</div>
	        </sicp3:groupbox>
	        </div>
	   
	   
	   
	   
</body>
</html>