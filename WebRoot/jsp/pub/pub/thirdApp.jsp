<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/7/20
  Time: 18:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>三方应用集成平台</title>
    <SCRIPT language=JavaScript>
        function Run(strPath)
        {
            alert(strPath);
            try
            {
                var objShell = new ActiveXObject("wscript.shell");
                objShell.Run(strPath);
                objShell = null;
            }
            catch(e)
            {
                alert('找不到文件"'+strPath+'"(或它的组件之一)。请确定路径和文件名是否正确.')
            }
        }

        function checkExplorer(){
            if ((navigator.userAgent.indexOf('MSIE') >= 0)
                    && (navigator.userAgent.indexOf('Opera') < 0)){
            }else if (navigator.userAgent.indexOf('Firefox') >= 0){
                alert('三方应用不支持Firefox')
            }else if (navigator.userAgent.indexOf('Opera') >= 0){
                alert('三方应用不支持Opera')
            }else{
                alert('三方应用不支持非IE内核浏览器！')
            }
        }
    </SCRIPT>
</head>
<body onload="checkExplorer()">
<input type="text" id="dir" value="C:/Program Files (x86)/Video Legend/KKP/Program/KKP.exe"/></br>
<a href="#" onclick="Run('file:///C:/Program Files (x86)/Video Legend/KKP/Program/KKP.exe')">博码</a>
<a href="#" onclick="Run('file:///D:/Program%20Files/Tencent/QQ/QQProtect/Bin/QQProtect.exe')">农业局视频</a>
<br/>
</body>
</html>
