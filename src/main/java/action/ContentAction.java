package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//추가
import note.board.*;

//content.do?num=3&pageNum=1
public class ContentAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		// 1.content.jsp에서 처리한 자바코드를 대신실행
		// 글상세보기=>게시판(쇼핑물 상품의 정보를 자세히(SangDetial.jsp?sangid=3&pageNum=1))
		int num = Integer.parseInt(request.getParameter("noticeno"));// 게시물번호 정수
		String pageNum = request.getParameter("pageNum");// 페이지 번호
		System.out.println("contentAction의 pageNum=>" + pageNum + ",noticeno=>" + num);
		
		BoardDAO dbPro = new BoardDAO();
		NoticeDTO article = dbPro.getArticle(num);
		
		int noticeno = article.getNoticeno(); 
		System.out.println("content.do의 매개변수 확인용");
		System.out.println("noticeno=>" + noticeno);

		// 2.실행결과 서버메모리에 저장
		request.setAttribute("noticeno", noticeno);// ${키명}
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("article", article);// ${article.ref}~
		// ${ref}
		// 3.페이지를 공유
		return "/noticeContent.jsp"; // 경로에 맞게 설계 /member/~.jsp
	}

}
