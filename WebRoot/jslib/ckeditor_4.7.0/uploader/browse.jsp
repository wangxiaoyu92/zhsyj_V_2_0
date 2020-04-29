<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>   
<%@ page import="java.io.File"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">   
<html>   
<head>   
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">   
<meta http-equiv="pragma" content="no-cache">   
<meta http-equiv="cache-control" content="no-cache">   
<meta http-equiv="expires" content="0">   
<title>浏览服务器文件</title>   
<script type="text/javascript">   
//这段函数是重点，不然不能和CKEditor互动了   
function funCallback(funcNum,fileUrl){   
    var parentWindow = ( window.parent == window ) ? window.opener : window.parent;   
    parentWindow.CKEDITOR.tools.callFunction(funcNum, fileUrl);   
    window.close();   
}   
</script>   
</head>   
<body>   
<%   
    String path = request.getContextPath() + "/";   
    String type = ""; 
    String filetype = "";
    if(request.getParameter("type") != null){//获取文件分类   
        type = request.getParameter("type").toLowerCase() + "/"; 
    	filetype = request.getParameter("type").toLowerCase();
    }
    //System.out.println(type);
    //定义文件路径，根据你的文件夹结构，可能需要做修改   
    String clientPath = "upload/news/" + type; 
    //System.out.println(clientPath);
    //System.out.println(request.getSession().getServletContext().getRealPath(clientPath));
    File root = new File(request.getSession().getServletContext().getRealPath(clientPath));   
    if(!root.exists()){   
        root.mkdirs();   
    }   
    
    String callback = request.getParameter("CKEditorFuncNum");
    
    String expStr = null;
    if("flashs".equalsIgnoreCase(filetype)){
    	expStr=".swf;";
    }
    if("flvs".equalsIgnoreCase(filetype)){
    	expStr=".flv;";
    }
    if("images".equalsIgnoreCase(filetype)){
    	expStr=".gif;.jpg;.bmp;.png;";
    }
    
  	File[] files = root.listFiles();
    //File[] files = root.listFiles(ckeditor.FileFilter.getFileExtensionFilterByExpStr(expStr));
    if(files.length > 0){   
        //for(File file:files ) {   
        //    String src = path + clientPath + file.getName();   
        //    out.println("<img width='110px' height='70px' src='" + src + "' alt='" + file.getName() + "' onclick=\"funCallback("+callback+",'"+ src +"')\">");   
        //}
        for(int i=0;i<files.length;i++){
        	String src = path + clientPath + files[i].getName();
        	if("images".equalsIgnoreCase(filetype))
        		out.println("<img width='110px' height='70px' src='" + src + "' alt='" + files[i].getName() + "' onclick=\"funCallback("+callback+",'"+ src +"')\">");
        	
        	if("flashs".equalsIgnoreCase(filetype))
        		out.println("<div onmousedown=\"funCallback("+callback+",'"+ src +"')\"><object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\"><param name=\"movie\" value=\""+src+"\"><param name=\"quality\" value=\"high\"><param name=\"WMODE\" value=\"Transparent\"><embed src=\"image/frame/user-change.swf\" width=\"30\" height=\"30\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" allowfullscreen=\"true\" allowscriptaccess=\"always\"></object></div>");
        	
        }
    }else{   
        out.println("<h3>服务器上暂时没有此类资源,请返回进行上传资源操作!<input type=button value=返回 onclick=window.close()></h3>");   
    }   
 %>   
</body>   
</html> 