<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${check==1}">	
		<script>
		opener.location.href='/NoteBook/notice.do?pageNum='+${pageNum};
		window.close();		
		</script>
</c:if>
<c:if test="${check==0}">
	<script>
      alert("비밀번호가 맞지않습니다.\n다시 비밀번호를 확인요망!");
      history.go(-1);
 </script>
</c:if>


