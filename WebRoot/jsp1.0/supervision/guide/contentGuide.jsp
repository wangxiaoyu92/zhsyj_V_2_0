<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.askj.baseinfo.dto.PcompanyDTO,com.askj.baseinfo.dto.PcompanyXkzDTO" %>
<%@ page import="com.askj.supervision.dto.OmcheckbasisDTO" %>
<%@ page import="com.zzhdsoft.Sys" %>
<%@ page import="com.askj.baseinfo.dto.OmLawContentDTO" %>
<% 
	String contextPath = request.getContextPath();
	String  basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
			
//	// 企业信息
//	PcompanyDTO v_com = (PcompanyDTO)request.getAttribute("comInfo");
//	// 许可证信息
	List<OmcheckbasisDTO> omcheckbasisDTOList = (List<OmcheckbasisDTO>)request.getAttribute("datalist");
%>

<html>
<head>
<title>问题所属检查指南</title>

<script src="<%=contextPath%>/jslib/jquery.json-2.4.min.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="<%=contextPath%>/jslib/bootstrap-3.3.5/css/bootstrap.min.css" type="text/css">
<script src="<%=contextPath%>/jslib/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/jslib/bootstrap-3.3.5/js/bootstrap.min.js"></script>
<style >
    table td{border:none;padding: 2px 2px 2px 2px;}
</style>
</head>
<body class="devpreview sourcepreview" style="min-height: 347px; cursor: auto;">
<div class="container">
    <table>
      <thead>
	     <tr>
	         <th style="vertical-align:middle;text-align:center;"></th>
	      </tr>      
      </thead>
      <tr>
        <td>
             <b>检查项：</b>经营者持有的食品经营许可证是否合法有效。
        </td>
      </tr>
      <%
          OmcheckbasisDTO omcheckbasisDTO = new OmcheckbasisDTO();
          if(omcheckbasisDTOList.size()==0){
              omcheckbasisDTO.setBasisdesc("未配置");
              omcheckbasisDTO.setTypedesc("未配置");
              omcheckbasisDTO.setGuide("未配置");
              omcheckbasisDTO.setPunishmeasures("未配置");
              omcheckbasisDTOList.add(omcheckbasisDTO);
          }
          for (int i=0;i<omcheckbasisDTOList.size();i++){
              omcheckbasisDTO = omcheckbasisDTOList.get(i);
      %>
      <tr>
        <td>
            <b>检查依据：</b><%=omcheckbasisDTO.getBasisdesc()%>
        </td>
      </tr>
      <tr>
        <td style="padding-left:30px ">
            <div style="z-index: 300;float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b style="background-color: white">&nbsp;法条链接&nbsp;</b>


                <div style="border:1px solid #000;margin-top: -10px;padding-left: 2px;padding-top: 5px">
                    <%
                        for(OmLawContentDTO omcheckLawDTO:omcheckbasisDTO.getLawList()){
                    %>
                    <center><b>《<%=omcheckLawDTO.getLawname()%>》 <%=omcheckLawDTO.getContentcode()%></b></center>
                    </br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=omcheckLawDTO.getContent().replaceAll("　　","<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")%>
                    <%
                        }
                    %>
                </div>
            </div>
        </td>
      </tr>
      <tr>
        <td style="padding-left:30px ">
            <b>检查方式：</b><%=omcheckbasisDTO.getTypedesc()%>
        </td>
      </tr>
        <tr>
            <td style="padding-left:30px ">
                <b>检查指南：</b><%=omcheckbasisDTO.getGuide()%>
            </td>
        </tr>
        <tr>
            <td style="padding-left:30px ">
                <b>常见问题：</b><%=omcheckbasisDTO.getProblemInfo()%>
            </td>
        </tr>
        <tr>
            <td style="padding-left:30px ">
                <b>处罚措施：</b><%=omcheckbasisDTO.getPunishmeasures()%>
            </td>
        </tr>
        <%
            }
        %>
    </table>

</div>
</body>
</html>
