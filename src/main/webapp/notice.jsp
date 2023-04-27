<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>공지사항</title>

    <!-- 부트스트랩 -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/notice.css" rel="stylesheet">
    <script type="text/javascript"	src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){   		
		//alert('notice.jsp에서의 jquery 정상작동');
    	$('#writeForm').hide();
    	if(${id=="admin"}){
    		$('#writeForm').show();
    	}
   	})
</script>
<style>
.col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, 
		.col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, 
		.col-xs-3, .col-sm-3, .col-md-3, .col-lg-3,
		.col-xs-4, .col-sm-4, .col-md-4, .col-lg-4,
		.col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, 
		.col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, 
		.col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, 
		.col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, 
		.col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, 
		.col-xs-10,.col-sm-10, .col-md-10, .col-lg-10,
		.col-xs-11,.col-sm-11, .col-md-11, .col-lg-11, 
		.col-xs-12,.col-sm-12, .col-md-12, .col-lg-12 
		{
			border:2px ridge;
			padding:15px; /* 기본의 부트스트랩의 그리드에 해당하는 */
		}
</style>
  </head>
  <body>
	<div class="container"><!-- 전체 레이아웃 감싸주기 -->
		<!-- 상단메인메뉴바부분 -->
		<!-- 헤더 한석현님 제작(상단홈아이콘,메뉴바 들어갈 위치) -->
		<!-- 헤더 한석현님 제작(상단홈아이콘,메뉴바 들어갈 위치) -->
		<div class="wrap"><!-- 상단메뉴부터 이미지 배너까지 영역잡아주기 -->
			<div class="nav"><!-- 메인로고 이미지 검색창 구현 및 로그인 마이페이지 -->
				<div class="search" style="margin-top:2px;">
					<a href="search.jsp"><button type="button" class="glyphicon glyphicon-search btn btn-default" style="border-radius: 50%;"></button></a>
					<a href="/NoteBook/login.do"><button type="button" class="btn btn-default glyphicon glyphicon-user" style="border-radius: 50%;"></button></a>					
					<a href="mypage.jsp"><button type="button" class="glyphicon glyphicon-book btn btn-default" style="border-radius: 50%;"></button></a>			
				</div>
				<br>
				<hr>				
				<div><a href="main.jsp"><img src="./img/logoimg.png" class="logo" ></img></a></div>			
			</div>
			<nav class="navbar navbar-inverse navbar-static-top" role="navigation">
    			<div class="navbar-header">    	
    				<button type="button" class="navbar-toggle"
    										data-toggle="collapse"
    										data-target=".navbar-ex1-collapse">
    					<span class="sr-only">navigation title</span>
    					<span class="icon-bar"></span><!-- 영역설정 -->
    				</button>    	
    				<a class="navbar-brand grlphicon"href="#">
    					<span class="glyphicon glyphicon-list disabled" disabled="disabled"></span>
    				</a>
    			</div>
    			<div class="collapse navbar-collapse navbar-ex1-collapse">
	    			<ul class="nav navbar-nav">
		    			<li><a href="#">최신</a></li>
		    			<li><a href="#">완결</a></li>
	    				<li><a href="#">베스트</a></li>
    							
	    				<!-- 드롭다운 부분을 추가2 -->
	    				<li class="dropdown">
						<a data-toggle="dropdown" href="#">고객지원
							<span class="caret"></span></a>
							<!-- 이벤트 대상 -->
							<ul class="dropdown-menu">
								<li><a href="#">공지사항</a></li>
								<li><a href="#">이벤트</a></li>
								<li><a href="#">Q&A</a></li>					
							</ul>
						</li>
    		
	    				<!-- 드롭다운 부분을 추가3 -->
	    				<li class="dropdown">
							<a data-toggle="dropdown" href="#">내서재
							<span class="caret"></span></a>
							<!-- 이벤트 대상 -->
							<ul class="dropdown-menu">
								<li><a href="#">내작품</a></li>
								<li><a href="#">선호작품</a></li>										
							</ul>
						</li>    		
       				</ul>
     			</div>   	
    		</nav>
		</div>
		<!-- body 내용 -->
		<div class="container row" style="padding-bottom:30px">
			<div class="col-md-12	" id="white">
				<!-- 내부 메뉴바 공지사항,qna,이벤트 jquery이용 -->
				<ul class="nav nav-tabs">
		  			<li class="active"><a href="/NoteBook/notice.do"><span>공지사항</span></a></li>
					<li><a href="#">Q&A</a></li>
					<li><a href="#">이벤트</a></li>
				</ul>
				<div>
				<h1>공지사항</h1>
				<button class="btn btn-default" type="button" id="writeForm" onclick="location.href='/NoteBook/pageWrite.do'" style="float:right">
				글작성</button>				
				<br>
			</div>
			<hr>
			<c:if test="${pgList.count==0}">
			<table class="container" border="1" cellpadding="0" cellspacing="0" align="center"> 
			   <tr>
			      <td align="center">게시판에 저장된 글이 없습니다.</td>
			   </tr>
			</table>
			</c:if>
			<c:if test="${pgList.count>0}">
			<c:set var="number" value="${pgList.number}"/>
   			<c:forEach var="article" items="${articleList}">
   			<!-- DB내용 불러와서 계속 늘어나게! -->
			<div class="col-md-12" 
				onclick="location.href='/NoteBook/noticeContent.do?noticeno=${article.noticeno}&pageNum=${pgList.currentPage}'" style="cursor:pointer; margin-bottom:1px;">
				<p id="title">${article.title}<!-- title --></p>
				<fmt:formatDate value="${article.n_date}"
    								timeStyle="medium"
    								pattern="yy-MM-dd"/><!-- n_date 날짜 일주일기준 new로 비교! -->
			</div>
			</c:forEach>
			</c:if>			
		</div>
				
		<!-- 페이징처리 위치 10페이지당 한칸 -->
		<div style="text-align: center;">
			<!-- 이전 -->
			<nav>
			<ul class="pagination">
				<c:if test="${pgList.startPage>pgList.blockSize}" >
					<li>
					<a href="/NoteBook/notice.do?pageNum=${pgList.startPage-pgList.blockSize}&search=${search}&searchtext=${searchtext}" aria-label="Previous">
			        	<span aria-hidden="true">&laquo;</span>
			      	</a>
			      	</li>
				</c:if>
				
				<c:forEach var="i" begin="${pgList.startPage}" end="${pgList.endPage}">	  
				<c:choose>  	 	
	    	 	
	    	 	<c:when test="${pgList.currentPage==i}">
					<li class="active">
						<a href="/NoteBook/notice.do?pageNum=${i}&search=${search}&searchtext=${searchtext}">
					<b>${i}</b>
					</li></a>
				</c:when>
				<c:otherwise>
					<li><a href="/NoteBook/notice.do?pageNum=${i}&search=${search}&searchtext=${searchtext}">
					${i}</a></li>
				</c:otherwise>
				
	    	 	</c:choose>
	    	 	</c:forEach>
	    	 	<!-- 다음페이지 -->
	    	 <c:if test="${pgList.endPage<pgList.pageCount}">
	    	 	<li>
		    	 	<a href="/NoteBook/notice.do?pageNum=${pgList.startPage+pgList.blockSize}&search=${search}&searchtext=${searchtext}" aria-label="Next">
		    	 		<span aria-hidden="true">&raquo;</span>
		    	 	</a>
	    	 	</li>
	    	 </c:if>
	    	 </ul>
	    	 </nav>
	    </div>
		<!-- footer -->
		<hr>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
  </body>
