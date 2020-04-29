<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var itemtypeData = <%=SysmanageUtil.getAa10toJsonArray("SHIFOUBZ")%>;
        var ryxb = <%=SysmanageUtil.getAa10toJsonArray("RYXB")%>;
        var ndwjddfl = <%=SysmanageUtil.getAa10toJsonArray("NDWJDDFL")%>;


        $(function () {
            var html='';
            for(var i=0;i<itemtypeData.length;i++){
                html+='<option value="'+itemtypeData[i].id+'">'+itemtypeData[i].text+'</option>'
            }
            parent.$('#sfgk').html(html);
            html='';
            for(var i=0;i<ryxb.length;i++){
                html+='<option value="'+ryxb[i].id+'">'+ryxb[i].text+'</option>'
            }
            parent.$('#ryxb').html(html);
            html='';
            for(var i=0;i<ndwjddfl.length;i++){
                html+='<option value="'+ndwjddfl[i].id+'">'+ndwjddfl[i].text+'</option>'
            }
            parent.$('#ndwjddfl').html(html);

        });


    </script>
</head>
<body>
</body>
</html>