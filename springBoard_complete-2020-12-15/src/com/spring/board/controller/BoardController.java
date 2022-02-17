package com.spring.board.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BTListVO;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageMaker;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.SearchVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	// 리스트 페이지 이동, 목록 불러오기 기능
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)	// 시작페이지 설정 -> web.xml 에 해줌
	public String boardList(Locale locale, Model model, @ModelAttribute("pageVo") PageVo pageVo, HttpServletRequest request) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		HttpSession session = request.getSession();	// usercontroller에서 생성한 세션 가져옴
		String logUserID = (String)session.getAttribute("logUserID");		// Object 형태로 오기 때문에 형변환함
		String logUserName = (String)session.getAttribute("logUserName");
		// System.out.println("로그인이 되었다면!! 세션에 있는 logUserID 값을 출력 == " + logUserID); 정상동작함
		
		//세션 세팅이 된 값들이 null 이 아닐경우 실행 (로그인)
		if(logUserID != null && logUserName != null) {
			model.addAttribute("logUserID",logUserID);
			model.addAttribute("logUserName",logUserName);
		}
		
		
		
		
		// 모든 게시물 가져오기
		boardList = boardService.SelectBoardList(pageVo);
		
		// 총게시물 갯수
		int totalCnt = boardService.selectBoardCnt();		
		
		// 체크박스 위한 list
		List<BTListVO> boardTypeList = new ArrayList<BTListVO>();
		boardTypeList = boardService.boardTypeList();
		
		
		
		
		//페이징
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(pageVo); 
		pageMaker.setTotalCount(totalCnt);
		
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", pageVo.getPageNo());
		
		//페이지
		model.addAttribute("pageMaker", pageMaker);	
		
		// 체크박스 codeId, codeName 보냄
		model.addAttribute("boardTypeList",boardTypeList);
		
		return "/board/boardList";
	}
	
	// 상세보기 페이지, 불러오기
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		System.out.println("boardVO 찍기=====================");
		System.out.println(boardVo);
		
		return "/board/boardView";
	}
	
	//새 글 작성페이지 이동
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		List<BTListVO> boardTypeList = new ArrayList<BTListVO>();
		boardTypeList = boardService.boardTypeList();
		
		
		model.addAttribute("boardTypeList",boardTypeList);

			
		
		
		return "/board/boardWrite";
	}
	
	// 새 글 작성 기능
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{

		int resultCnt = boardService.boardInsert(boardVo);	// 리턴값은 숫자
		
		

		System.out.println("===============================");
		System.out.println("===============================");
		System.out.println("resultCnt 찍어보기 = " + resultCnt);
		System.out.println("boardVo 찍어보기 = " + boardVo);
		System.out.println("===============================");
		System.out.println("===============================");
		
		
		
		System.out.println();
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg); 
		
		return callbackMsg;
	}
	
	// 수정페이지 이동
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdatePage(Locale locale, Model model, 
			@PathVariable("boardType") String boardType, @PathVariable("boardNum") int boardNum) throws Exception{
		
			BoardVo boardVo = new BoardVo();
			boardVo = boardService.selectBoard(boardType, boardNum);
			
			model.addAttribute("boardType", boardType);
			model.addAttribute("boardNum", boardNum);
			model.addAttribute("bVo", boardVo);
		
		
		return "/board/boardUpdatePage";
	}
	
	// 수정하기 기능
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public int boardUpdate(BoardVo boardVo) throws Exception {
			
		System.out.println("컨트롤러 수정 시작");
		
			int i = boardService.boardUpdate(boardVo);
			
		
		return i;
	}
	
	
	// 삭제기능
	@RequestMapping(value = "/board/boardDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public int boardDelete(BoardVo boardVo) throws Exception{
		
		System.out.println("컨트롤러 삭제 시작");
		System.out.println("==========boardVo 찍어보기==========");
		System.out.println(boardVo);
		int i = boardService.boardDelete(boardVo);
		
		return i;
	}
	
			
		// modelandview 객체로 전달해도 모델의 역할을 수행한다. 굳이 view페이지를 세팅해서 넘길필요가 있는지는 두고봐야한다.
		// 메소드의 매개변수에 ModelAndView mav 대입을 해주면, 선언과 동시에 사용 가능한 상태로 나타남.
		
																						// 검색 // 참고 https://m.blog.naver.com/PostView.nhn?blogId=ex122388&logNo=221069066674&proxyReferer=https:%2F%2Fwww.google.com%2F
		//검색														// web.xml 내부에 <url-pattern> 에 적힌 그대로 작성되지 않으면 실행되지 않는다.
		@RequestMapping(value = "/board/chbox_Search.do", method = RequestMethod.POST) 
		@ResponseBody																	// 까먹지말자. ajax 데이터 받으려면 필요하다. 멍청아.
		public HashMap<String, Object> boardSearch(Model model,@RequestParam(value="checkArr[]") List<String> chkList,
				@ModelAttribute("pageVo") PageVo pageVo) throws Exception {
			
			HashMap<String, Object> searchedDataMap = new HashMap<String, Object>();
			
			
			
			SearchVo searchVo = new SearchVo();											// chkList
			searchVo.setCheckVal(chkList);												// 체크박스의 값들을 세팅함
			//-----------------문제없음
			
			List<BoardVo> listBVO = boardService.chkBoxSearch(searchVo);	// 검색결과임. list형 객체에 담앗음	
			int listSize = listBVO.size();									// 검색결과의 갯수
			
			searchedDataMap.put("searchedData", listBVO);					// List<BoardVo> listBVO 를 담음
			
			System.out.println("출력출력출력출력===="+listBVO);
			
//			BoardVo newBoardVo = new BoardVo();
			
			System.out.println("컨트롤러에서 검색결과 갯수 == " + listSize);
			// 넘겨주기전에 boardType을 여기서 바꿀 수 있나?	결론 : 바꿔 넘기면 주소 바뀌어서 조회를 못한다.
			
			// 체크박스, 타입비교하고 변경을 위한 boardTypeList
			List<BTListVO> boardTypeList = boardService.boardTypeList();
			
			searchedDataMap.put("boardTypeList", boardTypeList);		// List<BTListVO> boardTypeList 를 담음
			
			System.out.println("boardTypeList 출력하기 = "+ boardTypeList);
			
//			for(int i = 0; i<listSize; i++) {	// 검색결과의 갯수만큼 돌림
//				
//				String str1 = listBVO.get(i).getBoardType();
//				
//				for(int k =0; k<BTListSize ; k++) {
//					String str2= boardTypeList.get(k).getCodeId();
//					String forTypeSet= boardTypeList.get(k).getCodeName();
//					if(str1.equals(str2)) {
//						System.out.println(str1 + " === " + str2 + "그래서 세팅을 할 값은 !!!! == " + forTypeSet);
//						// 이제 forTypeSet 을   List<BoardVo> listBVO 의 값에 바꾸어 끼워 넣어주자
//						listBVO.get(i).setBoardType(forTypeSet);
//						
//						// 세팅을 했으니 찍어본다
//						System.out.println("최종--listBVO "+i+" 번째의 boardType값을 보자. 한글로 되었을까? == " + listBVO.get(i));
//					}
//				}
//				
//			}
//			
//			System.out.println("타입 변경한 값 전체 listBVO 찍기 == " + listBVO);	못씀. 결국엔 주소가 변경되어서 내용을 읽지 못함
			
			
			
			
			
			
			model.addAttribute("pageNo", pageVo.getPageNo());
			
			
			return searchedDataMap;
			// List<BoardVo> listBVO
			// List<BTListVO> boardTypeList
			// 두가지를 담은 Map을 리턴함		searchedDataMap.put("searchedData", listBVO); , searchedDataMap.put("boardTypeList", boardTypeList);
		}
		



		
}
