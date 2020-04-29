<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String query_sym=null==request.getParameter("sym")?"":request.getParameter("sym").toString();
%>
<!-- 
<div data-role="header" data-position="fixed" data-tap-toggle="false">
 <a href="#link" data-role="button" data-icon="back" data-iconpos="notext">返回</a>
  <h1>欢迎访问郑州安盛计食品溯源</h1>
 </div>
  -->
  <!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <title>安盛追溯码查询</title>   
  <link rel="stylesheet" href="jquery.mobile-1.3.2/jquery.mobile-1.3.2.css"/>
   <!-- jQuery and jQuery Mobile -->
  <script src="jquery.mobile-1.3.2/jquery-1.9.1.min.js"></script>
  <script src="jquery.mobile-1.3.2/jquery.mobile-1.3.2.min.js"></script> 
<style>
  .mytable{
  width:100%;border:1px solid #000000;border-collapse: collapse;
  }
  .mytable th{background:#e6e6e6;}
  .mytable tr,th{height:25px;}
  </style>
 <body> 
<!-- Home -->
<div data-role="page" id="page1">
    <div data-theme="b" data-role="header" data-position="fixed">
        <h3>安盛食品追溯码查询中心</h3>
    </div>

    <div data-role="content">
        <div data-role="navbar" data-iconpos="top">
            <ul>
                <li>
                    <a href="query.jsp?sym=<%=query_sym %>" data-transition="fade" data-theme="b" data-icon="home">基本信息 </a>
                </li>
                <li>
                    <a href="query_picture.jsp?sym=<%=query_sym %>" data-transition="fade" data-theme="b" data-icon="info">产品图片 </a>
                </li>
                <li>
                    <a href="query_growth.jsp?sym=<%=query_sym %>" data-transition="fade" data-theme="b" data-icon="grid">生长信息 </a>
                </li>
                <li>
                    <a href="query_jcjy.jsp?sym=<%=query_sym %>" data-transition="fade" data-theme="b" data-icon="bars">检测信息 </a>
                </li>
            </ul>
        </div>    
  </div>