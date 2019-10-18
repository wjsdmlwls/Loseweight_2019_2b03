<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<!--slide-->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="maincss.css">
<link rel="stylesheet" href="community/include.css">
<script src="js/jquery.slim.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<!--slide end-->
<!-- modal windows -->
<script>
function loginshow() {
	   $( '#myModal_l' ).modal( 'show' );
	}
window.closeModal = function() {
   $( '#myModal_l' ).modal( 'hide' );
   location.reload();
}
</script>
<style>
.Opacity_box{
	background-color: rgba(0, 0, 0, 0.6);
}
</style>
<!-- modal windows -->
<body style="overflow:hidden;">
	<%
	String id= null;
	if(session.getAttribute("id")!=null){
		id=(String)session.getAttribute("id");
	}	
	//로그인이 성공하면 아이디값으로 세션에 접속을함.
	%>
	<div class="div_body">
	<!-- slider 영역 -->
		  <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="position: fixed; width: 100%; height: 100%;" >
			    <ol class="carousel-indicators" style="position:absolute">
			      <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
			      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
			    </ol>
			    <div class="carousel-inner" role="listbox" style="position:absolute">
			      <!-- Slide One - Set the background image for this slide in the line below -->
			      <div class="carousel-item active" style="background-image: url('img/main_img/lw_background.png')">
			        <div class="carousel-caption d-none d-md-block">
			          <h3 class="display-4">First Slide</h3>
			          <p class="lead">This is a description for the first slide.</p>
			        </div>
			      </div>
			      <!-- Slide Two - Set the background image for this slide in the line below -->
			      <div class="carousel-item" style="background-image: url('img/main_img/lw_background1.png')">
			        <div class="carousel-caption d-none d-md-block">
			          <h3 class="display-4">Second Slide</h3>
			          <p class="lead">This is a description for the second slide.</p>
			        </div>
			      </div>
			      <!-- Slide Three - Set the background image for this slide in the line below -->
			      <div class="carousel-item" style="background-image: url('img/main_img/lw_background2.png')">
			        <div class="carousel-caption d-none d-md-block">
			          <h3 class="display-4">Third Slide</h3>
			          <p class="lead">This is a description for the third slide.</p>
			        </div>
			      </div>
			    </div>
			  </div>
					<!-- slider end -->
		
		<jsp:include page="community/community_topinclude.jsp" >
			<jsp:param name="tom" value="3"/>
			<jsp:param name="toc" value="1"/>
			<jsp:param name="imgs" value="not.png"/>
			<jsp:param name="boardname" value=""/>
</jsp:include>
	</div>
	
</body>
</html>