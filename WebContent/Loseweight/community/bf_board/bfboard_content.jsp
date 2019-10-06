<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,user.UserDAO"%>

<%@ page import="java.io.File" %>
<%@ page import = "BFboard.BF_DAO" %>
<%@ page import = "BFboard.BF_DTO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import="DBBean.jekimDB" %>    
<%@ page import="java.sql.*"%>
<%@ page import = "java.util.List" %>
<%@ page language="java" import="java.net.InetAddress" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
     	String imgs =request.getParameter("abc"); //경로 
               	String name =request.getParameter("abd"); //파일이름
               
          		String directory = application.getRealPath("/img/");
          		String files[] = new File(directory).list();
%>
<%!//댓글기능 date에도 사용 
    int pageSize = 10;
    SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
    	// 세션정보 가져오기
    		PreparedStatement pstmt = null;
            ResultSet rs = null;
            Connection conn = null;
            try {
            String id = (String) session.getAttribute("id");
            
            String jdbcUrl="jdbc:mysql://localhost:3306/loseweight_db";
        	String dbId="lw_admin";
        	String dbPass="3whakstp";
        	
            UserDAO db= new UserDAO();
            conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
         
            
            String sql = "SELECT * FROM lw_users WHERE lw_id = ?";
         
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,id);
            rs = pstmt.executeQuery();
%>
<%
	//content load
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");

	int pageSize = 10;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1) * pageSize  ;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	 
	SimpleDateFormat sdf = 
    	new SimpleDateFormat("yyyy-MM-dd HH:mm");
	//댓글 date양식

   try{
      BF_DAO dbPro = BF_DAO.getInstance(); 
      BF_DTO article =  dbPro.getArticle(num);
      count = dbPro.getArticleCount(); 
	  int ref=article.getRef();
	  int re_step=article.getRe_step();
	  int re_level=article.getRe_level();
	  
	  //ip불러오는부분
	  InetAddress inet = InetAddress.getLocalHost();
	  String svrIP = inet.getHostAddress();
	  
		//조회수 중복 체크 부분
		Cookie[] cookieFromRequest= request.getCookies();
		String cookieValue = null;
		for(int i = 0; i<cookieFromRequest.length;i++){
			cookieValue = cookieFromRequest[0].getValue();
		}
	 	// 쿠키 세션 입력
		if (session.getAttribute(num+":cookie") == null) {
		 	session.setAttribute(num+":cookie", num + ":" + cookieValue);
		}else {
			session.setAttribute(num+":cookie ex", session.getAttribute(num+":cookie"));
			if (!session.getAttribute(num+":cookie").equals(num + ":" + cookieValue )) {
			 	session.setAttribute(num+":cookie", num + ":" + cookieValue);
			}
		}
		article.setNum(num);
		article = dbPro.getArticle(num);
		
	 	// 조회수 카운트
	 	if (!session.getAttribute(num+":cookie").equals(session.getAttribute(num+":cookie ex"))) {
	 		dbPro.updateBoardreadcount(num);	
		 	article.setReadcount(article.getReadcount() + 1);
	 	}
%>
<%
	//reply search
	jekimDB usedb = new jekimDB();
	usedb.connect();
	Statement stmt=null;
	Connection con=null;
	con=DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	stmt=con.createStatement();
	
	String replylistsql1="select count(*) from bf_boardre where num="+article.getNum()+"";
	ResultSet rs2 = stmt.executeQuery(replylistsql1);
	String replylistsql2="select * from bf_boardre where num="+article.getNum()+"";
	ResultSet replylist = usedb.resultQuery(replylistsql2);
	//댓글 개수 확인후 개수만큼 select문 뿌려주려고함
	
    number = count-(currentPage-1)*pageSize;
	if(rs2.next()){ rs2.getInt(1); } rs2.close();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../../css/style.css">
<script src="../js/jquery.slim.min.js"></script>
<script type="text/javascript" src="../../lw_user/vcheck.js"></script>
</head>
<!-- stlye css -->
<style>
tr.tableline td{
	border-bottom:1px solid #ddd;
}
.board_dir:link {text-decoration:none; color:#000;}
.board_dir:visited {text-decoration:none; color:#000;}
.board_dir:active {text-decoration:none; color:#000;}
.board_dir:hover {text-decoration:none; color:#000;}
<style>
.cotent_first_line{
font-size:20px;
color:#707070;
}
.content_subject{
font-size:30px;
color:#363636;
border-bottom:1px solid #a1a1a1;
}
.cotents{
height:auto;
min-height: 500px;
word-break: break-all;
white-space: pre-wrap;
margin-top:20px;
font-size:16px;
color:#000;
line-height:25px;
}
.upload_content{
font-size: 14;
color: #7d7d7d;
border:1px solid #d8d8d8;
margin:20px 0;
padding-left:20px;
}
.downlode_ob{
text-decoration: none;
font-size: 14;
margin-left: 13;
color: #7d7d7d;
}
.downlode_ob:hover{
   color: red;
}
.all_button{
border-style:none;
color: #fff;
font-size:13px;
background-color:#666;
width:90px;
height:40px;
}
#all_button{
border-style:none;
color: #fff;
font-size:9px;
background-color:#666;
width:50px;
height:25px;
}
.reply_box{
text-align:center;
margin: 0 auto;
margin-top:100px;
margin-bottom:50px;
background: #f3f3f3;
height:200px;
width:920px;
position:relative;
padding-right:80px;
}
.reply_box_centent{
padding-top:50px;
}
.reply_button{
border-style:none;
color: #fff;
font-size:13px;
background-color:#666;
width:90px;
height:109px;
position:absolute;
}
.btn_box{
margin:0 auto;
margin-top:10px;
width:1000px;
}
.reply_content{
margin:0 auto;
width:1000px;
height:500px;
}
.test123{

border-bottom:1px solid red;
}
tr.tableline td{
	border-bottom:1px solid #ddd;
}

.noreple{
height:200px;
text-align:center;
font-size:30px;
font-weight:550;
margin:0 auto;
}
</style>
<script type="text/javascript">
$(function() {
	$(".replyedit").on("click", function() {
		$(this).parent().prev().children(".replyeditleft1").css({"display": "none","position":"absolute"});
		$(this).parent().prev().children(".replyeditleft2").css({"display": "block"});
		$(this).parent().prev().children(".replyeditleft2").attr('name','recontent2');
		$(this).parent().prev().children(".replyedit_submit").css({"display": "block"});
		$(this).parent().prev().children(".glenumname").attr('name','glenumpost');
		$(this).css({"display":"none"});
		$(this).next(".replydelete").css({"display":"none"});
		$(this).next().next(".replycancel").css({"display":"block"});
	});
	$(".replycancel").on("click", function() {
		$(this).parent().prev().children(".replyeditleft1").css({"display": "block","position":"relative"});
		$(this).parent().prev().children(".replyeditleft2").css({"display": "none"});
		$(this).parent().prev().children(".replyeditleft2").attr('name','');
		$(this).parent().prev().children(".replyedit_submit").css({"display": "none"});
		$(this).parent().prev().children(".glenumname").attr('name','');
		$(this).prev().prev(".replyedit").css({"display":"inline"});
		$(this).prev(".replydelete").css({"display":"inline"});
		$(this).css({"display":"none"});
	});
	$(".replydelete").on("click", function() {
		$(this).parent().prev().children(".glenumname").attr('name','glenumpost');
	});
	
});
function  sendProcess(f){
	f.action="board_replyedelete.jsp";
    f.submit();      
    
}
function  sendedit(f){
	f.action="board_replyedit.jsp";
    f.submit();      
    
}
</script>
<body>
	<div class="div_body">
		<jsp:include page="../community_topinclude.jsp" >
			<jsp:param name="tom" value="3"/>
			<jsp:param name="toc" value="1"/>
			<jsp:param name="imgs" value="community.png"/>
			<jsp:param name="boardname" value="BE & AT"/>
		</jsp:include>	
		<div style='width: 100%;'>
			
			<div class="div_sidecontents" >
				<div class="mypage_form">
				<div style="margin:0 auto;margin-top:5%;width:1020px">			
				</div>
					<table style="margin:0 auto;width:1100px;border-top:50px">  
					 <tr class="tableline" ><td style="border-color: #000;"colspan="5"></td></tr>
					<tr height="30">
					    <td align="left"  align="center" colspan="3">
						    <a style="font-size: 20px;font-weight: bold;"> <%=article.getSubject()%></a></td>
						    
					  </tr>
					  <tr height="30">
					    <td align="left"style="width:1;"><%=article.getWriter()%></td>
						<td style="width:1px;text-align:center;">|</td>
					    <td align="left"><%= sdf.format(article.getReg_date())%></td>
					    <td align="center" style="width:35px;">조회</td>
					    <td align="center" align="center"style="width:35px;">
						     <%=article.getReadcount()%></td>
					  </tr>
					  <tr class="tableline"><td colspan="5"></td></tr>
					  <tr>
					    <td align="left" colspan="3">
					           <pre style="height:auto;min-height: 500px; word-break: break-all; white-space: pre-wrap;"><%=article.getContent()%></pre></td>
					           
					  </tr>
					   <% if(article.getFilename0()!=null){%>
					  <tr class="tableline">
						  <td colspan="5">
						  <div id="upload" style="border:solid 1px;min-height: 100px;">
						  <% if(article.getFilename0()!=null){%>
							   <a href="<%=article.getFilepath0()%>" style="border:none" type="text/html"target="_blank"download><%=article.getFilename0()%></a><br>
							     <% if(article.getFilename1()!=null){%>
							  		 <a href="<%=article.getFilepath1()%>" style="border:none" type="text/html"download><%=article.getFilename1()%></a><br>
							  		 
							   <%}}
							     }else{%>
							   <%} %>
						 </div>
						  </td>
					  </tr>
					  <tr height="30">      
					    <td colspan="4" align="right" > 
						  <input type="button" value="글수정" class="newbutton"
					       onclick="document.location.href='bfboard_updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
						   &nbsp;&nbsp;
						  <input type="button" value="글삭제" class="newbutton"
 					       onclick="document.location.href='bfboard_deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
						   &nbsp;&nbsp;
					      <input type="button" value="답글쓰기" class="newbutton"
					       onclick="document.location.href='bfboard_writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
						   &nbsp;&nbsp;
					       <input type="button" value="글목록" class="newbutton"
					       onclick="document.location.href='bfboard_list.jsp?pageNum=<%=pageNum%>'">
					    </td>
					  </tr>
					</table>   
				</div>
			</div>
		</div>
				<div class="reply_box">
		<form action = "bfboard_reply.jsp" method="post" name="replyform">
		<div style="display:none">
			<input name="lw_id" value="<%=id%>">
			<input name="num" value="<%=article.getNum()%>">
			<input name="pageNum" value="<%=pageNum%>">
		</div>

		
		<%if(id!=null){%>
	
		<div class="reply_box_centent" style="padding-top: 25px;">
			<textarea name="recontent" style="height: 148px;"id="recontent" cols="110" rows="6"></textarea>
			<input type="submit" class="reply_button" value="댓글 등록" style="height: 148px;">
		</div>
		</div>
			<%} %>
		</form>
		</div>
			
	</div>
	<div style="padding-bottom:60px;">
		<form method="post" action="notice_replyedit.jsp" onsubmit="return writeSave()">
			<div style="display:none">
				<input name="num" value="<%=article.getNum()%>">
				<input name="pageNum" value="<%=pageNum%>">
			</div>
			<!-- 댓글 부분 -->
			<table style="margin:0 auto;width:1000px"> 
			 
						  			
	<%if(replylist.next()){
		do{
		String num2=replylist.getString("num");
		String glenum2=replylist.getString("glenum");
		String lw_id=replylist.getString("lw_id");
		String recontent=replylist.getString("recontent");
		Timestamp reg_date=replylist.getTimestamp("reg_date");
		%>
		
		 <tr height="50" >
			    <td width="600"><input style="border:none; font-weight:bold; font-size:16px;width:60px;" name="lw_id" value="<%=lw_id%>" readonly></blod><a style="font-size:12px;"><%= sdf.format(reg_date)%></a></td>
			    </tr>
			    <tr>
			    <td width="250" >
			    <input type="text" class="replyeditleft1"style="border: none;display:block; " name="recontent" id="reply<%=glenum2%>_1" value="<%=recontent%>"readonly>			    
			    <input type="text" class="replyeditleft2" style="display:none; width:100%; height:60px;" id="reply<%=glenum2%>_2" value="<%=recontent%>">		    
			    <button id="all_button" class="replyedit_submit" style="display:none; float:right;"  onClick="sendedit(this.form); writeSave();"onclick="replyedit()">등록</button>
			    <input type="hidden"class="glenumname" value="<%=glenum2%>">
				</td>			
				<td id="replybtn<%=num2%>_1" style="text-align:right;"><%if (id!=null){
						if(id.toString().equals(lw_id)){%>
						<input type="button" id="all_button"class="replyedit"value="수정">
						<input type="submit" id="all_button"class="replydelete" onClick="sendProcess(this.form); writeSave();"value="삭제">
						<input type="button" id="all_button"class="replycancel" value="수정취소" style="display:none;">
						
						<%
						}}%></td>			 
			  </tr>
			  <tr class="tableline"><td colspan="6"></td></tr>
			  
		<%}while(replylist.next());
		}else{%>
		
		<div class="noreple">댓글이 없습니다</div>
			  
		<%}%>	
	</table>
	
	</form>
	</div>
	<% 
	}catch(Exception e){
		
	}finally {
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }	 
					 %>
	 <%
		  }catch(Exception e){
			  
		  }finally {
	          if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	          if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	          if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	      }	
				%>    
		<jsp:include page="../community_footerinclude.jsp"></jsp:include>
	</div>	
</body>
</html>