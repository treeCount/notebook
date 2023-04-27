<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript"	src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>NoteBook 메인 페이지</title>
<link href="./css/bootstrap.min.css" rel="stylesheet">
	
<style>
.wrap {
    width: 100%;
    height: 100%;
    padding: 0;
    margin: 0;
}

.font-consult {
	font-size:18px;
	color:gray;
	position:absolute;	
	left:200px;
	top:10px;
}

.search {
	float:right;
}

.banner-list {
	float:center;
}

.navbar-nav>li {
	width: 210px;
	text-align: center;
	position: relative;
	font-size: 15px;
	font-family: Gill Sans Extrabold, sans-serif;
	font-weight: 900;
	color:black;
}
.navbar {
	box-shadow:5px 5px 5px 5px#dfdfdf;
}
.pc-banner{	
	height:420px; 
	box-shadow:5px 5px #dfdfdf;
	margin-top:28px;
}
.main-list2 {
	border-radius:5px;
	box-shadow:5px 5px 5px 5px #dfdfdf;
}

.main-list3 {
	border-radius:5px;
	box-shadow:5px 5px 5px 5px #dfdfdf;
	margin-top:10px;
}
.right-control {
	position: absolute;
	right: 0;
	top: 0;
	width: auto;
	height: auto;
	display: flex;
}

.rowSet {
	display:flex;
	margin:8px;
	padding-left:20px;
}
.row {		
	width: 200px;
	height: 274px;
	margin:5px;
}
.thumbnail{
	border: 1px solid #e1e1e1;
    height: 100%;
    width: 100%;
}
.newThumbnail{
	border: 1px solid #e1e1e1;
    height: 100%;
    width: 570px;
    display:flex;  
    margin:5px;
}
.newImg{
	 width:200px;
}
.newContent{
	padding:1px; 
	margin-left:5px;
}
.btn-right {
	float:right; 
	height:30px;
}
.carousel-inner > .item > div{
  display:inline-block;
  max-width: 100%;
  height: auto;
}
.list-icon{
	border:1px solid white;
	border-radius:10px;
	display:flex;
	margin-top:5px;	
	text-align:center;
}
.list-icon > div{
	text-align:center;
}

.footer-list {
	width:100%;
	margin-top:15px;
	
}
.content-wrap {
	display:flex;
}
.inner-col {
	margin:5px;
	border-radius:5px;
	box-shadow:5px 5px 5px 5px #dfdfdf;
	background:#e9ecef;
	padding:5px;
}
.link-group > a{
	color:gray;
	text-decoration:none;
}
.button-group {
	display:flex;
	font-size:18px;
	margin-bottom:5px;
}

.hover-menu{
	display:none;
	position:absolute;
	z-index:2;		
}
.hover-menu >li{
	display:inline-block;		
}
.hover-menu li > a{
	margin:3px;
	text-decoration:none;
	color:gray;
}
.navback {
	background-color:#292929;	 
	position:absolute; 
	width:100%; 
	height:22px; 
	z-index:1;
	display:none;
	box-shadow:5px 5px 5px #dfdfdf;
	border-radius:3px;
}
.iconbar{
	width:20px;
}
</style>
<script>

$(function(){
    $('.hovermenu').hover(function(){
        $(this).find('.hover-menu').slideDown(0);
        $('.navback').css('display','block');
    },function(){
        $(this).find('.hover-menu').slideUp(0);
        $('.navback').css('display','none');
    })
 });
 
    var currentSlide = 0;
    
    function showNextSlide() {
    	
    	var bestArticleList = "${bestArticleList}";
    	alert(bestArticleList+ " "+bestArticleList.length);
        currentSlide = (currentSlide + 5) % bestArticleList.length;
        alert(currentSlide);
        showSlides(currentSlide);
        
    }
    
    function showSlides(n) {
    	  alert("정상작동2");
    	  var i;
    	  var slides = document.getElementsByClassName("rowSet");
    	  alert(slides.length);
    	  if (n >= slides.length) {currentSlide = 0}
    	  if (n < 0) {currentSlide = slides.length-1}
    	  for (i = 0; i < slides.length; i++) {
    	    slides[i].style.display = "none";
    	  }
    	  slides[currentSlide].style.display = "flex";
    	}
  
</script>
</head>
<body>
<div class="container">
	<div class="wrap"><!-- 상단메뉴부터 이미지 배너까지 영역잡아주기 -->
		<div class="nav"><!-- 메인로고 이미지 검색창 구현 및 로그인 마이페이지 -->			
				<div class="search" style="margin-top:2px;">
				<span><a href="#" class="font-consult" style="text-decoration:none;">고객센터&nbsp;&nbsp;</a><a href="#" class="font-consult" style="text-decoration:none; left:280px;">1:1문의</a>&nbsp;&nbsp;&nbsp;</span>			
					<!-- <a href="search.jsp"><img src="./img/search.png" style="width:20px; height:20px;"></img></a> -->
					<a href="search.jsp" class="iconbar"><button type="button" class="glyphicon glyphicon-search btn btn-default" style="border-radius: 50%;"></button></a>
					
					<c:if test="${id!=null}">
					<a href="mypage.do"><button type="button" class="btn btn-default glyphicon glyphicon-user" style="border-radius: 50%;"></button></a>
					</c:if>
					<c:if test="${id==null}">
					<a href="login.jsp" class="iconbar"><button type="button" class="btn btn-default glyphicon glyphicon-user" style="border-radius: 50%;"><span style="position:absolute;">x</span></button></a>
					</c:if>
				</div>
				<br>
				<hr>				
			<div><a href="main.do"><img src="./img/logoimg.png" class="logo"></img></a>				
			</div>			
		</div>
		<!-- 상단메뉴 -->
		<nav class="navbar navbar-inverse navbar-static-top" role="navigation">
    	<div class="navbar-header">    	
    	<button type="button" class="navbar-toggle"
    										data-toggle="collapse"
    										data-target=".navbar-ex1-collapse">
    		<span class="sr-only">navigation title</span>
    		<span class="icon-bar"></span><!-- 영역설정 -->
    	</button>    	
    	<a class="navbar-brand grlphicon" href="#" disabled="disabled">
    		<span class="glyphicon glyphicon-list disabled" disabled="disabled"></span>
    	</a>
    	</div>
    	<div class="navbar-collapse">
    		<ul class="nav navbar-nav">
    			<li><a href="news.do">최신</a></li>
    			<li><a href="end.do">완결</a></li>
    			<li><a href="best.do">베스트</a></li>
    							
    		<!-- 드롭다운 부분을 추가2 -->
    		<li class="hovermenu">
				<a class="slidedown" href="#">고객지원</a>
				<!-- 이벤트 대상 -->
				<ul class="hover-menu">				
					<li><a href="notice.do">공지사항</a></li>
					<li><a href="event.do">이벤트</a></li>
					<li><a href="qna.do">Q&A</a></li>									
				</ul>
			</li>
    		
    		<!-- 드롭다운 부분을 추가3 -->
    		<li class="hovermenu">
				<a class="slidedown" href="#">내서재</a>
				<!-- 이벤트 대상 --> 
				<ul class="hover-menu">
					<li><a href="#">내작품</a></li>
					<li><a href="#">선호작품</a></li>										
				</ul>
			</li>    		
       </ul>
     </div>
     <div class="navback"></div>  	
    </nav>
    
    <!-- 애니메이션 배너부분 -->
    <div class="pc-banner">
     	 <div id="carouselBanner" class="carousel slide" data-ride="carousel">
      			<!-- Indicators -->
		      <ol class="carousel-indicators">
		        <li data-target="#carouselBanner" data-slide-to="0" class=""></li>
		        <li data-target="#carouselBanner" data-slide-to="1" class=""></li>
		        <li data-target="#carouselBanner" data-slide-to="2" class="active"></li>
		      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item">
          <img class="first-slide" src="./img/event.jpg" alt="첫 번째 슬라이드" style="height:420px; width:100%;">
          <div class="container">
            <div class="carousel-caption">
              <h1><font style="vertical-align: inherit;">
              <font style="vertical-align: inherit;">헤드라인 예시.</font>
              </font>
              </h1>              
            </div>
          </div>
        </div>
        <div class="item">
          <img class="second-slide" src="./img/event2.jpg" alt="두 번째 슬라이드" style="height:420px; width:100%;">
           <div class="container">
            	<div class="carousel-caption">
            	<h1><font style="vertical-align: inherit;">
              	<font style="vertical-align: inherit;">헤드라인 예시.2</font>
              	</font>              
            </div>
           </div>
        </div>
        <div class="item active">
          <img class="third-slide" src="./img/event3.jpg" alt="세 번째 슬라이드" style="height:420px; width:100%;">
            <div class="container">
            	<div class="carousel-caption">
            	<h1><font style="vertical-align: inherit;">
              	<font style="vertical-align: inherit;">헤드라인 예시.3</font>
              	</font>                 
            </div>
          </div>
        </div>
      </div>
      <a class="left carousel-control" href="#carouselBanner" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">
	        <font style="vertical-align: inherit;">
	        	<font style="vertical-align: inherit;">이전의</font>
	        </font>
        </span>
      </a>
      <a class="right carousel-control" href="#carouselBanner" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">다음</font></font></span>
      </a>
    </div>
  </div>
 </div>
     <!-- 중간 메뉴 -->
			<div class="pc-middle" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="wrap">
					<!-- <h1>메인2-5개씩 베스트</h1> -->
					<div id="carouselBest" class="carousel slide main-list2" data-ride="carousel"><!-- 메인2 -->						
						<div class="" style="margin:5px;  display:flex"><!-- 제목구간 -->							
							<div class="" style="width:50%; padding-left:20px; margin-top:30px; ">
								<span style="font-size:26px;"><strong>NoteBook </strong>																								
								</span>
								<font class="label label-danger"style="color:white;">Best</font>
							</div>
							<div class="" style="margin:22px; background:none; width:50%;">
								<button type="button" class="btn-right glyphicon glyphicon-menu-right" onclick="showNextSlide()"
								href="#carouselBest" data-slide="next"></button>
								<button type="button" class="btn-right glyphicon glyphicon-menu-left" 
								href="#carouselBest" data-slide="prev"></button>								
							</div>
						</div>
						<hr>
						<div class="list-main" style=" margin-top:3px; " >											
							 <ol class="carousel-indicators" style="color:gray;">
						        <li data-target="#carouselBest" data-slide-to="0" class="active"></li>
						        <li data-target="#carouselBest" data-slide-to="1" class=""></li>						        
						     </ol>
						    <div class="carousel-inner" role="list-box">
						    <!-- 페이징 처리 응용 -->
						    
														
										
							
							<c:set var="number" value="${pgList.number}"/>
							
							<div class="item rowSet active">						
   							<c:forEach var="bestArticle" items="${bestArticleList}" varStatus="status">
										<c:if test="${status.index % 4 == 0}">
											
											
										</c:if>
										<div class="row">
									<div class="thumbnail">
										<a href="'/NoteBook/best.do?bookno=${bestArticle.bookno}&pageNum=${pgList.currentPage}'"> 
										<img src="./img/${bestArticle.img}" alt="Lights" style="width: 100%"/></a>
												<div class="caption" style="padding:1px;">
													<h4><strong>${bestArticle.title}</strong></h4>
												        <p>${bestArticle.ncname} ${i} ${rowBest}</p>
												        <p>
												        <div class="list-icon">
												        	<div class="glyphicon glyphicon-user"></div>
												        	<div>&nbsp;${bestArticle.c_rcount}</div>&nbsp;&nbsp;&nbsp;&nbsp;											        	
												        	<div class="glyphicon glyphicon-thumbs-up" ></div>
												        	<div>&nbsp;${bestArticle.c_like}</div>&nbsp;&nbsp;&nbsp;&nbsp;
												        	<div class="glyphicon glyphicon-heart"></div>
												        	<div>&nbsp;${bestArticle.c_lib}</div>
												        </div>
												        </p>
												</div>
										</div>
									</div>
									

									</c:forEach>
								</div>
									
								
													

							
							
							<%-- <div class="row-set item active">
								<c:if test="${pgList.count>0}">
							<c:set var="number" value="${pgList.number}"/>
   							<c:forEach var="article" items="${articleList}">
								<div class="row">
									<div class="thumbnail">
										<a href="#"> 
										<img src="./img/${article.img}" alt="Lights" style="width: 100%"/></a>
												<div class="caption" style="padding:1px;">
													<h4><strong>${article.title}</strong></h4>
												        <p>${article.ncname}</p>
												        <p>
												        <div class="list-icon">
												        	<div class="glyphicon glyphicon-user"></div>
												        	<div>&nbsp;${article.c_rcount}</div>&nbsp;&nbsp;	&nbsp;&nbsp;											        	
												        	<div class="glyphicon glyphicon-thumbs-up" ></div>
												        	<div>&nbsp;${article.c_like}</div>&nbsp;&nbsp;&nbsp;&nbsp;
												        	<div class="glyphicon glyphicon-heart"></div>
												        	<div>&nbsp;${article.c_lib}</div>
												        </div>
												        </p>
												</div>
										</div>
									</div>							
								</c:forEach>
							</c:if>		
							</div> --%>
							
							
							</div>
						</div>
					</div>
					<!-- <h1>메인3-2개씩 베스트</h1> -->
					<div class="main-list3"><!-- 메인3 -->					
						<div>
							<div class="" style="padding-left:20px; margin-top:30px; padding:30px;"><!-- 헤더구간 -->
								<span style="font-size:26px;"><strong>NoteBook </strong>																								
								</span>
								<font class="label label-danger" style="color:white;">New</font>
								<div style="position:relative; float:right;">
									<a href="news.do" style="color:gray; text-decoration:none;"><strong>더보기 ></strong></span>
									</a>
								</div>
							</div>
							
   							<c:forEach var="newArticle" items="${newArticleList}" begin="0" end="1">
							<div style="display:flex;"><!-- 메인내용 -->
								<div class="newThumbnail">
										<a href="'news.do?bookno=${newArticle.bookno}&pageNum=${pgList2.currentPage}'"> 
										<img src="./img/${newArticle.img}" class="newImg" alt="Lights"></a>
												<div class="caption newContent">
													<h4><strong>${newArticle.title }</strong></h4>
												        <p>${newArticle.ncname }</p>
												        <p>
												        	<a href="#">#${newArticle.genre}</a><br>
												        	작품소개<br>
												        	${newArticle.subcon}<br>
												        </p>
												</div>
									</div>
									</c:forEach>
							
							
								<!-- <div class="thumbnail" style="display:flex; width:50%; margin:5px;">
										<a href="#"> 
										<img src="./img/view1.jpg" alt="Lights" style="width:200px;"></a>
												<div class="caption " style="padding:1px; margin-left:5px;">
													<h4><strong>이곳이 제목</strong></h4>
												        <p>잭슨</p>
												        <p>
												        	<a href="#" >#해쉬태그</a><br>
												        	작품소개<br>
												        	줄거리 or 소개글<br>
												        </p>
												</div>
									</div> -->
							</div>
						</div>					
					</div>
			


		<hr>
		</div>
			<div class="footer-list">
				<div class="content-wrap">
					<div class="inner-col" style="width:70%; padding-top:30px;">
						<div class="note-group">
							<div class="notebook-info">
								(주)NoteBook | 서울특별시 강남구 테헤란로1길 10 세경빌딩 3층(서울특별시 강남구 역삼동 819-10 세경) <br>|
									TEL. 1544-5935 | <span>Email. 
									<a href="#" style="text-decoration:none; color:black;">test@NoteBook.com</a></span> |사업자등록번호 : 123-45-678901 <br>| 통신판매업신고번호 : 제2000-서울강남-0123호| 대표자명 : 테스트 <br>| 인증기업
							</div>							
						</div><br>
						<p>
						<div class="copy-right">© NoteBook Corp. All rights reserved</div><p></p>
						<div class="link-group">
							<a href="/">이용약관</a>&nbsp;|&nbsp;
							<a class="strong"	href="/">개인정보처리방침</a>&nbsp;|&nbsp;												
							<a href="/">청소년보호정책</a>&nbsp;|&nbsp;							
							<a href="/">IP연구소</a>&nbsp;|&nbsp;
							<a href="/">NoteBook 창립</a>&nbsp;|&nbsp;
							<a href="/" class="strong">저작권 보호센터</a>
						</div>
						
						
					</div>
					<div class="inner-col"  style="width:30%;">
						<div class="title"><h3><strong>NoteBook 고객센터</strong></h3></div>
						<div class="tel"><h4><strong>1588-1541</strong></h4></div>
						<div>
							평일 10:00 ~ 17:00 ㅣ 점심시간 12:30 ~ 13:30 <br>주말 및 공휴일 휴무
						</div>
						<p></p>
						<div class="button-group">
							<button name="/" class="label label-default" style="width:40%; height:50px; margin:0 1.5% 0 2%;">1:1 문의</button>
							<button name="/" class="label label-default" style="width:40%; height:50px;  margin:0 18% 0 1.5%;">자주하는 질문</button>
						</div>
					</div>
				</div>
			</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>