package note.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import note.board.FindAdminDTO;
import note.board.NoticeDTO;
import note.board.DBConnectionMgr;

public class BoardDAO {

	private DBConnectionMgr pool=null;//1.연결객체선언
	//공통
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;//select
	private String sql="";//실행시킬 SQL구문 저장
	
	//2.생성자를 통해서 연결=->의존관계
	public BoardDAO() {
		try {
			pool=DBConnectionMgr.getInstance();
			System.out.println("pool=>"+pool);
		}catch(Exception e) {
		   System.out.println("DB접속 오류=>"+e);	
		}
	}
/*=========================================================*/
	//3.메서드 작성(페이징 처리를 위한 메서드 작성)=>총레코드수(=총게시물수=총회원수)
		//select count(*) from board;  select count(*) from member
		public int getArticleCount() {//getmemberCount()->MemberDAO에서 작성
			int x=0;
			try {
				con=pool.getConnection();
				System.out.println("con=>"+con);
				sql="select count(*) from notice";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {//보여주는 결과가 있다면
					x=rs.getInt(1);//변수명=rs.get자료형(필드명 또는 인덱스번호)=>필드명X
				}
			}catch(Exception e) {
				System.out.println("getArticleCount()에러발생=>"+e);
			}finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return x;
		}
	
		////1.검색에어 해당되는 총레코드수를 구하는 메서드(검색분야,검색어)
		public int getArticleSearchCount(String search, String searchtext) {//getmemberCount()->MemberDAO에서 작성
			int x=0;
			try {
				con=pool.getConnection();
				System.out.println("con=>"+con);
				//-----------------------------------------------
				if(search==null || search=="") {//검색분야 선택x
					sql="select count(*) from notice";
				}else {//검색분야(제목,작성자,제목+본문)
					if(search.equals("subject_content")) {//제목+본문
						sql="select count(*) from notice where subject like '%"+
								searchtext+"%' or content like '%"+searchtext+"%' ";
					}else {//제목 or 작성자->매개변수를 이용해서 하나의 sql통합
						sql="select count(*) from notice where "+search+" like '%"+
								searchtext+"%' ";
					}
				}
				System.out.println("getArticleSearchCount 검색sql=>"+sql);
				//-----------------------------------------------
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {//보여주는 결과가 있다면
					x=rs.getInt(1);//변수명=rs.get자료형(필드명 또는 인덱스번호)=>필드명X
				}
			}catch(Exception e) {
				System.out.println("getArticleSearchCount()에러발생=>"+e);
			}finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return x;
		}
		
	
		public List<NoticeDTO> getArticles(int start,int end){
			 List<NoticeDTO> articleList=null;//ArrayList articleList=null;//(0)
			 
			 try {
				 con=pool.getConnection();
				 /*
				  * 그룹번호가 가장 최신의 글을 중심으로 정렬하되,만약에 level이 같은 경우에는
				  * step값으로 오름차순을 통해서 몇번째 레코드번호를 기준해서 몇개까지 정렬할것인가
				  * 를 지정해주는 SQL구문
				  */
				 sql="select * from (select * from notice order by noticeno desc) where rownum between ? and ?";
				 //sql="select * from board order by ref desc,re_step limit ?,?";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, start);//mysql은 레코드순번이 내부적으로 0부터 시작
				 pstmt.setInt(2, end);//불러와서 담을 갯수(ex 10)
				 rs=pstmt.executeQuery();
				 if(rs.next()) {//보여주는 결과가 있다면
					 articleList=new ArrayList(end);//10=>end갯수만큼 데이터를 담을 공간생성
					 do {
						 NoticeDTO article=new NoticeDTO();//new MemberDTO();필드별로 담기위해서
						 article.setNoticeno(rs.getInt("noticeno"));
						 article.setGrade(rs.getString("grade"));
						 article.setN_date(rs.getTimestamp("n_date"));
						 article.setTitle(rs.getString("title"));
						 article.setContent(rs.getString("content"));
						 //추가
						 articleList.add(article);//생략하면 데이터가 저장X->for문 에러유발(NullPointerException)
					 }while(rs.next());
				 }
			 }catch(Exception e) {
				System.out.println("getArticles() 에러유발=>"+e); 
			 }finally {
				 pool.freeConnection(con, pstmt, rs);
			 }
			 return articleList;//NullPointerException 조심
		}
	
		//(2)검색어에 따른 레코드의 범위지정에 대한 메서드
		public List<NoticeDTO> getBoardArticles
											(int start,int end,String search,String searchtext){
			 List<NoticeDTO> articleList=null;//ArrayList articleList=null;//(0)
			 
			 try {
				 con=pool.getConnection();
				 //---------------------------------------------------------------------
				 if(search==null || search=="") {
					 //sql="select title,n_date from notice order by noticeno desc";
					 sql="select noticeno,content,n_date,title from (select seq,noticeno,content,n_date,title from(select rownum as seq,noticeno,content,n_date,title from (select * from notice order by noticeno desc) ) where seq>= ? ) where rownum <=?";
				 }else {//제목+본문
					 if(search.equals("subject_content")) {//제목+본문
							sql="select * from notice where subject like '%"+
									searchtext+"%' or content like '%"+searchtext+"%' order by noticeno desc where between ? and ?";
						}else {//제목 or 작성자->매개변수를 이용해서 하나의 sql통합
							sql="select * from notice where "+search+" like '%"+
									searchtext+"%' order by noticeno desc where rownum between ? and ?";
						}				 				 
				 }
				 System.out.println("getBoardArticles의 sql=>"+sql);
				 //---------------------------------------------------------------------
				 
				 
				 pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, start);//mysql은 레코드순번이 내부적으로 0부터 시작
				 pstmt.setInt(2, end);//불러와서 담을 갯수(ex 10)
				 rs=pstmt.executeQuery();
				 if(rs.next()) {//보여주는 결과가 있다면
					 articleList=new ArrayList(end);//10=>end갯수만큼 데이터를 담을 공간생성
					 do {
						 NoticeDTO article=new NoticeDTO();//new MemberDTO();필드별로 담기위해서
						 article.setNoticeno(rs.getInt("noticeno"));
						 //article.setGrade(rs.getString("grade"));
						 article.setN_date(rs.getTimestamp("n_date"));
						 article.setTitle(rs.getString("title"));
						 article.setContent(rs.getString("content"));
												
						 //추가
						 articleList.add(article);//생략하면 데이터가 저장X->for문 에러유발(NullPointerException)
					 }while(rs.next());
				 }
			 }catch(Exception e) {
				System.out.println("getBoardArticles() 에러유발=>"+e); 
			 }finally {
				 pool.freeConnection(con, pstmt, rs);
			 }
			 return articleList;//NullPointerException 조심
		}	
		//------------------------------------------------
		//(3)페이징 처리 계산 정리해주는 메서드(ListAction)
		public Hashtable pageList(String pageNum,int count) {
		    	
		    	//1.페이징 처리결과를 저장할 Hashtable객체를 선언
		    	Hashtable<String,Integer> pgList=new Hashtable<String,Integer>();
		    	//ListAction에서의 복잡한 페이징처리를 대신 처리
			     int pageSize=5;//numPerPage->페이지당 보여주는 게시물수(=레코드수) 10
			     int blockSize=3;//pagePerBlock->블럭당 보여주는 페이지수 10
			     
			    //게시판을 맨 처음 실행시키면 무조건 1페이지부터 출력
			    if(pageNum==null){
			    	pageNum="1";//default(무조건 1페이지는 선택하지 않아도 보여줘야 하기때문에),가장 최근의 글
			    }
			    int currentPage=Integer.parseInt(pageNum);//"1"->1 현재페이지(=nowPage)
			    //메서드 호출->시작 레코드번호
			    //                  (1-1)*10+1=1,(2-1)*10+1=11,(3-1)*10+1=21)
			    int startRow=(currentPage-1)*pageSize+1; //시작 레코드 번호
			    int endRow=currentPage*pageSize;//1*10=10,2*10=20,3*10=30 ->마지막 레코드번호
			    int number=0;//beginPerPage->페이지별로 시작하는 맨 처음에 나오는 게시물번호
			    System.out.println("현재 레코드수(count)=>"+count);
			    //            122-(1-1)*10=122,122-(2-1)*10=112
			    number=count-(currentPage-1)*pageSize;
			    System.out.println("페이지별 number=>"+number);
			    
			    //총페이지수,시작,종료페이지 계산
			    //                      122/10=12.2+1=>12.2+1.0=13.2=13페이지
			       int pageCount=count/pageSize+(count%pageSize==0?0:1);
			    //블럭당 페이지수 계산->10->10배수,3->3배수
			       int startPage=0;//1,2,3,,,,10 [다음 블럭 10]->11,12,,,,20
			       if(currentPage%blockSize!=0){//1~9,11~19,21~29
			    	   startPage=currentPage/blockSize*blockSize+1;
			       }else{ //10%10=0,(10,20,30)
			    		               //((10/10)-1)*10+1
			    	   startPage=((currentPage/blockSize)-1)*blockSize+1;
			       }
			       int endPage=startPage+blockSize-1;//1+10-1=10
			       System.out.println("startPage="+startPage+",endPage="+endPage);
			       if(endPage > pageCount)
			    	   endPage=pageCount;//마지막페이지=총페이지수
			       //페이징처리에 대한 계산결과->Hashtable,HashMap->ListAction전달->메모리에 저장->list.jsp
			       pgList.put("pageSize", pageSize);//<->pgList.get(키명)("pageSize")
			       pgList.put("blockSize", blockSize);
			       pgList.put("currentPage", currentPage);
			       pgList.put("startRow", startRow);
			       pgList.put("endRow", endRow);
			       pgList.put("count", count);
			       pgList.put("number", number);
			       pgList.put("startPage", startPage);
			       pgList.put("endPage", endPage);
			       pgList.put("pageCount", pageCount);
			       
			       return pgList;
		    }
	
		public void insertArticle(NoticeDTO article) {//~(MemberDTO mem)
			//1.article->신규글인지 답변글(기존 게시물번호)인지 확인
			int noticeno=article.getNoticeno();//0 신규글<->0이 아닌경우->양수(1이상~)(old)
			
			int number=0;//데이터를 저장하기위한 게시물번호(=New)
			System.out.println("insertArticle 메서드의 내부 num=>"+noticeno);//0 신규글
						
			try {
				con=pool.getConnection();
				sql="select max(noticeno) from notice";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {//보여주는 결과가 있다면
					number=rs.getInt(1)+1;//최대값+1
				}else {
					number=1;//테이블에 한개의 데이터가 없다면 최초부여값 1
				}		
				
				sql="insert into notice(noticeno,grade,title,content,n_date)values(seq_notice.NEXTVAL,?,?,?,sysdate)";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, article.getGrade());
				pstmt.setString(2, article.getTitle());
				pstmt.setString(3, article.getContent());
				
				
				int insert=pstmt.executeUpdate();
				System.out.println("게시판의 글쓰기 성공유무(insert)=>"+insert);//1 or 0
			}catch(Exception e) {
				System.out.println("insertArticle()메서드 에러유발=>"+e);
			}finally {
				pool.freeConnection(con, pstmt, rs);//rs가 왜필요?
			}
		}
	
	
		public NoticeDTO getArticle(int num) {
			
		     NoticeDTO article=null;
				 
				 try {
					 con=pool.getConnection();

					 sql="select * from notice where noticeno=?";
					 pstmt=con.prepareStatement(sql);
					 pstmt.setInt(1, num);
					 rs=pstmt.executeQuery();
					 
					 if(rs.next()) {//보여주는 결과가 있다면
						    article=this.makeArticleFromResult();						   
					 }
				 }catch(Exception e) {
					System.out.println("getArticle() 에러유발=>"+e); 
				 }finally {
					 pool.freeConnection(con, pstmt, rs);
				 }
				 return article;//content.jsp에서 받아서 출력->NullPointerException
			}
			//접근지정자가 private가 되는 경우 외부에서 호출되면 안되고 내부에서만 호출되는 메서드 작성
			private NoticeDTO makeArticleFromResult() throws Exception {
				NoticeDTO article=new NoticeDTO();//new MemberDTO();필드별로 담기위해서
				 article.setNoticeno(rs.getInt("noticeno"));
				 article.setGrade(rs.getString("grade"));
				 article.setTitle(rs.getString("title"));
				 article.setContent(rs.getString("content"));
				 article.setN_date(rs.getTimestamp("n_date"));
				 
				 return article;
			}
	
			private FindAdminDTO makeArticleFromResultUpdate() throws Exception {
				
				FindAdminDTO article= new FindAdminDTO();
				 article.setA_id(rs.getString("a_id"));
				 article.setA_passwd(rs.getString("a_passwd"));
				 article.setNoticeno(rs.getInt("noticeno"));
				 article.setGrade(rs.getString("grade"));
				 article.setTitle(rs.getString("title"));
				 article.setContent(rs.getString("content"));
				 article.setN_date(rs.getTimestamp("n_date"));
				 
				 return article;
			}
	
			public FindAdminDTO updateGetArticle(int num) {				
				
				FindAdminDTO article=null;
				 try {
					 con=pool.getConnection();
					 sql="select * from admin join notice on admin.grade = notice.grade where noticeno=?";
					 pstmt=con.prepareStatement(sql);
					 pstmt.setInt(1, num);
					 rs=pstmt.executeQuery();
					 if(rs.next()) {//보여주는 결과가 있다면													 
							 article=makeArticleFromResultUpdate();//반환형을 통해서 객체를 얻어온다.	
							 System.out.println("id=>"+article.getA_id()+",a_passwd=>"+article.getA_passwd()+"content=>"+article.getContent()+
									 ""+article.getGrade()+"글번호=>,"+article.getNoticeno()+"title=>"+article.getTitle()+article.getN_date());
					 }
				 }catch(Exception e) {
					System.out.println("updateGetArticle() 에러유발=>"+e); 
				 }finally {
					 pool.freeConnection(con, pstmt, rs);
				 }
				 return article;
			}
	
			//2)수정시켜주는 메서드 작성->본인인지 확인절차=>회원탈퇴(암호를 비교->탈퇴)와 동일하다.
			public int updateArticle(FindAdminDTO article) {//insertArticle(BoardDTO article)
				String dbpasswd="";//DB상에서 찾은 암호를 저장
				int x=-1;//게시물의 수정유무
				
				try {
					con=pool.getConnection();
					sql="select a_passwd from(select * from admin left join notice on admin.grade = notice.grade) where noticeno=?";//sql구문먼저 확인(오타)
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, article.getNoticeno());//index ~ 에러유발->작성X
					rs=pstmt.executeQuery();
					//암호를 찾았다면
					if(rs.next()) {
						dbpasswd=rs.getString("a_passwd");
						System.out.println("dbpasswd=>"+dbpasswd);
						//dbpasswd(DB상에 저장된 암호)==passwd(웹상에서 입력한 암호)
						System.out.println("updateArticle()내부 암호확인중");
						System.out.println("article.getA_passwd()=>"+article.getA_passwd());
						
						if(dbpasswd.equals(article.getA_passwd())) {//본인인증
							sql="update notice set title=?,content=?,n_date=sysdate where noticeno=?";								
							pstmt=con.prepareStatement(sql);
							pstmt.setString(1, article.getTitle());
							pstmt.setString(2, article.getContent());
							pstmt.setInt(3, article.getNoticeno());
							
							int update=pstmt.executeUpdate();
							System.out.println("게시판의 글수정 성공유무)=>"+update);
							x=1;//수정성공 성공
						}else {//암호가 틀린경우
							x=0;//수정 실패
						}
					}else {//암호가 존재하지 않은경우
						x=-1;
					}
				}catch(Exception e) {
					System.out.println("updateArticle()실행 오류=>"+e);
				}finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return x;
			}
	
	
			//게시물 삭제->delete from board where num=?
			public int deleteArticle(int num,String passwd) {//회원탈퇴 기능과 동일
				String dbpasswd="";//DB상에서 찾은 암호를 저장
				int x=-1;//게시물의 삭제유무
				
				try {
					con=pool.getConnection();
					sql="select a_passwd from(select * from admin left join notice on admin.grade = notice.grade) where noticeno=?";//sql구문먼저 확인(오타)
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, num);//index ~ 에러유발->작성X
					rs=pstmt.executeQuery();
					//암호를 찾았다면
					if(rs.next()) {
						dbpasswd=rs.getString("a_passwd");
						System.out.println("dbpasswd=>"+dbpasswd);//다 개발후에는 삭제
						//dbpasswd(DB상에 저장된 암호)==passwd(웹상에서 입력한 암호)
						if(dbpasswd.equals(passwd)) {//본인인증
							sql="delete from notice where noticeno=?";
							pstmt=con.prepareStatement(sql);
							pstmt.setInt(1, num);
							int delete=pstmt.executeUpdate();
							System.out.println("게시판의 글삭제 성공유무)=>"+delete);//1 성공, or 0 실패
							x=1;//삭제성공 
						}else {//암호가 틀린경우
							x=0;//삭제 실패
						}
					}
				}catch(Exception e) {
					System.out.println("deleteArticle()실행 오류=>"+e);//Log객체
				}finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return x;
			}
	
	
	
}
