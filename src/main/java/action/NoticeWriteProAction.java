package action;

import java.sql.Timestamp;//DB에서의 필드의 날짜자료형때문에

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import note.board.BoardDAO;
import note.board.NoticeDTO;

public class NoticeWriteProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		//1.writePro.jsp의 자바처리 구문
	     request.setCharacterEncoding("utf-8");//한글처리
	     
	     NoticeDTO article=new NoticeDTO();
	     article.setNoticeno(Integer.parseInt(request.getParameter("noticeno")));//hidden
	     article.setGrade(request.getParameter("grade"));
	     article.setTitle(request.getParameter("title"));	     
	     
	     //readcount(0)(생략),오늘날짜,원격주소ip
	     Timestamp temp=new Timestamp(System.currentTimeMillis());//컴퓨터계산(날짜,시간)
	     article.setN_date(temp);//오늘 날짜 수동저장=>~.getReg_date() ->now()
	    
	     //조회수->자동으로 0을 default
	     article.setContent(request.getParameter("content"));	    
	     
	     BoardDAO dbPro=new BoardDAO();
	     dbPro.insertArticle(article);
	     //3.공유->페이지 이동
		return "/writePro.jsp";// /list.do로 처리->/list.jsp
	}
}
