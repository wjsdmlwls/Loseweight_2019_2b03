<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

     
<%@ page import = "BFboard.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
     
<%
	request.setCharacterEncoding("utf-8");
%>


<jsp:useBean id="article"  scope="page" class="BFboard.BoardDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	
    article.setReg_date(new Timestamp(System.currentTimeMillis()));
	article.setIp(request.getRemoteAddr());
	
	
    BoardDBBean dbPro = BoardDBBean.getInstance();
    dbPro.insertArticle(article); 
    
    String boardfiles = (request.getParameter("boardfiles"));
    int num=article.getNum();
    response.sendRedirect("list.jsp");
    
    
%>