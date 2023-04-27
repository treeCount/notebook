package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NoticeWriteAction implements CommandAction{
	
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		int noticeno=0; String grade="1";

		// content.do에서 매개변수가 전달
		if (request.getParameter("noticeno") != null) {// 0은 아니고 ,음수X=>양수 1이상
			noticeno = Integer.valueOf(request.getParameter("noticeno"));
			
			System.out.println("content.jsp에서 넘어온 매개변수확인");
			System.out.println("noticeno=>" + noticeno);
		}
		//2.실행결과->서버의 메모리에 저장=>공유해서 이동
			request.setAttribute("noticeno", noticeno);//${num}
			request.setAttribute("grade", grade);
			
		return "/pageWrite.jsp";
	}
}
