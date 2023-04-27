package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NoticeDeleteFormAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		// deleteForm.jsp?num=2&pageNum=1->deletePro.jsp(deleteArticle()호출)
		request.setCharacterEncoding("utf-8");
		
		String check=request.getParameter("check");//y
		
		int num = Integer.parseInt(request.getParameter("noticeno"));// 게시물번호
		String pageNum = request.getParameter("pageNum");// 페이지 번호
		System.out.println("DeleteFormAction의 num=>" + num + ",pageNum=>" + pageNum);
		
		request.setAttribute("num", num);
		request.setAttribute("pageNum", pageNum);
		
		return "/noticeDeleteForm.jsp";
	}

}
