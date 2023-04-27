package action;


import java.util.Collections;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import note.board.BoardDAO;
import note.board.NoteDAO;



//1.requestPro()를 공통메서드로 사용 2.객체형변환때문에(상속기법)
public class MainAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		
		String pageNum=request.getParameter("pageNum");
		//추가
		String search=request.getParameter("search");//검색분야
		String searchtext=request.getParameter("searchtext");//검색어
		System.out.println("ListAction의 매개변수 확인");
		System.out.println("pageNum=>"+pageNum
							+",search=>"+search+",searchtext=>"+searchtext);
		
		int bestCount=0;//총레코드수
		int newCount=0;
		List bestArticleList=null;//화면에 출력할 레코드를 저장할 변수
		List newArticleList=null;
		
		NoteDAO dbPro=new NoteDAO();
		bestCount=dbPro.getArticleSearchCount(search, searchtext);
		newCount=dbPro.getArticleSearchCount(search, searchtext);
		System.out.println("MainAction에서의 현재레코드수=>"+bestCount);
		
		
		//1.화면에 출력할 페이지번호,2.출력할 레코드갯수
		Hashtable<String,Integer>pgList=dbPro.MainPageList(pageNum, bestCount);
		if(bestCount>0) {
			System.out.println(pgList.get("startRow")+","+pgList.get("endRow"));
			bestArticleList=dbPro.getBestArticles(
																search,//검색분야 
																searchtext);//검색어
			
			newArticleList=dbPro.getNewsArticles(pgList.get("startRow"), //첫번째레코드번호 
					pgList.get("pageSize"), //불러올 갯수 
					search,//검색분야 
					searchtext);
			System.out.println("MainAction의 bestArticleList=>"+bestArticleList+",bestCount=>"+bestCount);
			System.out.println("MainAction의 newArticleList=>"+newArticleList+",newCount=>"+newCount);
		}else {//count=0
			bestArticleList=Collections.EMPTY_LIST;//비어있는 List객체반환
			newArticleList=Collections.EMPTY_LIST;
		}
				
		// 2.처리한 결과를 공유(서버메모리에 저장)=>이동할페이지에 공유(request
		
		request.setAttribute("search", search);// ${search}
		request.setAttribute("searchtext", searchtext);
		request.setAttribute("pgList", pgList);//10개
		request.setAttribute("bestArticleList", bestArticleList);//${articleList}
		request.setAttribute("newArticleList", newArticleList);//${articleList}
		
		
		

		return "/main.jsp";//컨트롤러가 이동시키면서 공유시켜준다->view
	}

}
