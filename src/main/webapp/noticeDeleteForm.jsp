<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<script type="text/javascript"	src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<script language="JavaScript">            
  $(function(){
	  if($('#noticeRead').click(function(){
		  opener.location.href='/NoteBook/notice.do?pageNum='+${pageNum};
		  window.close();
	  }))
	  
	  function deleteSave(){
		 if($('passwd').value=='' && $('.passwd').value==null){
			  alert('비밀번호를 입력해주세요.');
			  $('passwd').focus();
		  }	 
	  }
  })
</script>
</head>

<body bgcolor="#d3d3d3">
<center><b>글삭제</b>
<br>
<form method="POST" name="delForm"  action="/NoteBook/noticeDeletePro.do?pageNum=${pageNum}&num=${num}" onsubmit="return deleteSave()"> 
 <table border="1" align="center" cellspacing="0" cellpadding="0" width="360" border-radius="5px">
  <tr height="30">
     <td align=center  bgcolor="#e9e9e9">
       <b>비밀번호를 입력해 주세요.</b></td>
  </tr>
  <tr height="30">
     <td align=center >비밀번호 :
       <input type="password" name="passwd" size="8" maxlength="12" background="#d3d3d3">
	   <%-- 
	   <input type="hidden" name="num" value="<%=num%>">
	   <input type="hidden" name="pageNum" value="<%=pageNum%>">
	   --%>
  </td>
 </tr>
 <tr height="30">
    <td align=center bgcolor="#e9e9e9">
      <input type="submit" class="btn btn-default" value="글삭제" >
      <input type="button" class="btn btn-default" id="noticeRead" value="글목록">     
   </td>
 </tr>  
</table> 
</form>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html> 
