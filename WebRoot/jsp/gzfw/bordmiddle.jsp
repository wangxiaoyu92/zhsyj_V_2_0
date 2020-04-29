<%@ page language="java" import="com.zzhdsoft.siweb.entity.Bord,java.util.*" pageEncoding="UTF-8"%>

  <div class="h20 clear"></div>  
  <!-- 新闻列表 start -->
  <div class="announcementul">
      <ul class="list">
			<%
			if (v_newsList != null && v_newsList.size() > 0) {
				for (int i = 0; i < v_newsList.size(); i++) {
					bean = (Bord) v_newsList.get(i);
					if (i % 5 == 0) {
						if (bean.getSfxsmxflag()!=null && !"".equals(bean.getSfxsmxflag()) && "2".equals(bean.getSfxsmxflag())){
							%>
                         <li class="tb"><%=bean.getNewstitle()%><span><%=bean.getNewsauthor()%></span></li>							
							<%
						}else{
							%>
                         <li class="tb"><a href="<%=contextPath %>/news/queryBordDetail?newsid=<%=bean.getNewsid()%>" title="<%=bean.getNewstitle()%>" target="_blank"><%=bean.getNewstitle()%></a><span><%=bean.getNewsauthor()%></span></li>							
							<%
						}
					} else {
						if (bean.getSfxsmxflag()!=null && !"".equals(bean.getSfxsmxflag()) && "2".equals(bean.getSfxsmxflag())){
							%>
                            <li><%=bean.getNewstitle()%><span><%=bean.getNewsauthor()%></span></li>							
							<%
						}else{
							%>
                            <li><a href="<%=contextPath %>/news/queryBordDetail?newsid=<%=bean.getNewsid()%>" title="<%=bean.getNewstitle()%>" target="_blank"><%=bean.getNewstitle()%></a><span><%=bean.getNewsauthor()%></span></li>							
							<%
						}

					}
				}
			}
			%>     
     </ul>
  </div>
  <!-- 新闻列表 end -->
         
  
  <!-- 翻页工具条 start -->
  <div class="h40 clear"></div>
  <div class="page">
  	 <span>第<%=v_currPage%>页/共<%=v_totalPage%>页&nbsp;共<%=v_totalCount%>条&nbsp;</span>     
     
     <%if (v_currPage > 1) {%>
       <span class="abled"><a href="<%=contextPath %>/news/queryBordList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize %>&cateJc=<%=v_cateJc%>&page=1" >首页</a></span>
       <span class="abled"><a href="<%=contextPath %>/news/queryBordList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize %>&cateJc=<%=v_cateJc%>&page=<%=v_currPage - 1%>" >前一页</a></span>
     <%
     	} else {
     %>
       <span class="disabled">首页</span>
       <span class="disabled">前一页</span>
     <%
     	}
     %>               
     
     <%for (v_loop_page = v_currPage - 2; (v_loop_page < v_currPage); v_loop_page++) {//显示当前页码的前2个页码
        if (v_loop_page > 0) {
     %>
       		<a href="<%=contextPath %>/news/queryBordList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize %>&cateJc=<%=v_cateJc%>&page=<%=v_loop_page%>" ><%=v_loop_page%></a>
     <%
     	}
     }
     %>               
     
     <span class="current"><%=v_currPage%></span>
     <%
     	for (v_loop_page = v_currPage + 1; ((v_loop_page <= v_currPage + 3) && (v_loop_page <= v_totalPage)); v_loop_page++) {//显示当前页码的后4个页码
     %>
       		<a href="<%=contextPath %>/news/queryBordList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize %>&cateJc=<%=v_cateJc%>&page=<%=v_loop_page%>" ><%=v_loop_page%></a>
     <%
     	}
     %>
     
     <%if (v_currPage < v_totalPage) {%>
       <span class="abled"><a href="<%=contextPath %>/news/queryBordList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize %>&cateJc=<%=v_cateJc%>&page=<%=v_currPage + 1%>" >后一页</a></span>
       <span class="abled"><a href="<%=contextPath %>/news/queryBordList?retPageStr=<%=v_retPageStr %>&pageSize=<%=v_pageSize %>&cateJc=<%=v_cateJc%>&page=<%=v_totalPage%>" >尾页</a></span>
     <%
     	} else {
     %>
       <span class="disabled">后一页</span>
       <span class="disabled">尾页</span>
     <%
     	}
     %>                                    
   </div>
   <div class="h40 clear"></div>
   <!-- 翻页工具条 end --> 
