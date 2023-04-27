<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"	src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<title>공지사항 상세보기</title>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/notice.css" rel="stylesheet">
<style>
.notice-header{
	width:100%; 
	height:80px;
	margin-top:1px; 
	background:#d3d3d3;
	border:1px solid white;
	border-radius:5px;
	box-shadow:1px 1px #e9e9e9;
}
.notice-content{
	background:#e9e9e9; 
	height:500px; 
	margin-top:10px; 
	border-radius:5px;
	box-shadow:1px 1px #e9e9e9;
	padding:5px;
}
.notice-footer{
	width:100%; 
	height:80px;
	margin-top:3px; 
	border-radius:5px;
	box-shadow:1px 1px #e9e9e9;
	background:#d3d3d3;
	text-align:center;
	text-color:#e9e9e9;
}
.btn-space{
	margin-right:2px;
	margin-left:2px;
}
.pre-note{
	display: block;
	white-space: pre;
  	margin: 1em 0;
}
</style>
<script type="text/javascript">
/* $(function(){	
	$('#delete').click(function(){
		var msg=call($('.username').val());
		$('#message').html(msg);
		return false;//전송 x
	})
}) */
 $(function(){
	 //alert('noticeContent에서의 jquery 정상 작동');
	 $('#delete').hide();
	 $('#update-j').hide();
	 if(${id=="admin"}){
		 $('#delete').show();
		 $('#update-j').show();
 	}
	 $('.delete').click(function(event){
		 var onclick = $(this).attr('onclick');
		 var width = $(this).attr('data-width');
		 var height = $(this).attr('data-height');
		 
		 window.open(onclick,'delete','width='+width+',height='+height+'');		 
		 event.preventDefault();
	 })
})
</script>
</head>
<body>
<!-- body 내용 -->
<div class="container">
		<div class="container row" style="padding-bottom:30px">
			<div class="col-md-12	" id="white">
				<!-- 내부 메뉴바 공지사항,qna,이벤트 jquery이용 -->
				<ul class="nav nav-tabs">
		  			<li class="active"><a href="/NoteBook/notice.do?pageNum=${pageNum}"><span>공지사항</span></a></li>
					<li><a href="#">Q&A</a></li>
					<li><a href="#">이벤트</a></li>
				</ul>
				<div>
				<h1>공지사항</h1>
				
				<button class="btn btn-default btn-space" type="button" onclick="location.href='/NoteBook/notice.do?pageNum=${pageNum}'" style="float:right">
				목록보기</button>
				<button class="btn btn-default btn-space" id="update-j" type="button" onclick="location.href='/NoteBook/pageUpdateWrite.do?noticeno=${article.noticeno}&pageNum=${pageNum}'" style="float:right">
				글수정</button>
					<button class="btn btn-default btn-space delete" id="delete" type="button" target="_blank" 
					data-width="600" data-height="400" onclick="/NoteBook/noticeDeleteForm.do?pageNum=${pageNum}&noticeno=${article.noticeno}" style="float:right">
				글삭제</button>
			</div>
			<br />
			<hr />
			<!-- 공지사항 상세내용 -->
			<div>
				<form><!-- 공지사항제목 -->
					<input type="hidden" name="noticeno" value="${noticeno}" >
					<div  class="notice-header" name=content>
						<div class="col-md-10"><h2>${article.title}</h2></div>
						<br />
						<br />
						<div class="col-md-2" style="text-align:right;"><h4><fmt:formatDate value="${article.n_date}"
    								timeStyle="medium"
    								pattern="yy-MM-dd"/>&nbsp;&nbsp;<fmt:formatDate value="${article.n_date}" pattern="E"/>요일</h4></div>
					</div>
					<hr />
					<div class="notice-content pre-note"><h4>${article.content}</h4></div>
					<hr />
					<div class="notice-footer"><h4>Copyright©NoteBook.All rights reserved.</h4></div>					
				</form>
			</div>			
		</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>