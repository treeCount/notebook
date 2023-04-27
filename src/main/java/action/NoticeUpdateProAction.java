package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//추가
//BoardDAO,BoardDTO
import note.board.BoardDAO;
import note.board.FindAdminDTO;

public class NoticeUpdateProAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		//1.updatePro.jsp의 자바처리 구문
	     request.setCharacterEncoding("utf-8");//한글처리
	     //추가(수정할 페이지로 이동)
	     String no=request.getParameter("noticeno");
	     String pageNum=request.getParameter("pageNum");
	     System.out.println("NoticeUpdateProAction에서의 pageNum=>"+pageNum);
	     System.out.println("NoticeUpdateProAction에서의 noticeno=>"+no);
	     FindAdminDTO article=new FindAdminDTO();
	     
	     article.setNoticeno(Integer.parseInt(request.getParameter("noticeno")));//hidden	     
	     article.setTitle(request.getParameter("title"));
	     article.setA_passwd(request.getParameter("a_passwd"));
	     article.setContent(request.getParameter("content"));
	     article.setGrade(request.getParameter("grade"));
	     article.setA_id(request.getParameter("a_id"));
	     
	     
	     BoardDAO dbPro=new BoardDAO();
	     int check=dbPro.updateArticle(article);
	     //2.공유
	     request.setAttribute("pageNum", pageNum);//페이지이동
	     request.setAttribute("check", check);//${check}수정성공유무
	     
	     //3.공유->페이지 이동
		return "/updatePro.jsp";// /list.do로 처리->/list.jsp
	}
}
