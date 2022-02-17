package com.spring.user.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.vo.BoardVo;
import com.spring.user.service.UserService;
import com.spring.user.vo.LoginDataVO;
import com.spring.user.vo.PhoneNumVO;
import com.spring.user.vo.UserJoinDataVO;

import javafx.scene.AmbientLight;
import sun.print.resources.serviceui;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	// 로그인 페이지 이동
	@RequestMapping(value = "/user/loginPage", method = RequestMethod.GET)
	public String loginPage() throws Exception {

		System.out.println("로그인 페이지 이동");

		return "/user/loginPage";
	}

	// 회원가입 페이지 이동 , 번호 리스트 가져옴
	@RequestMapping(value = "/user/joinPage", method = RequestMethod.GET)
	public String joinPage(Model model) throws Exception {

		System.out.println("회원가입 페이지 이동");

		List<PhoneNumVO> phoneNum1List = userService.getPhoneNum_1List();
		
		System.out.println("phoneNum1List 찍어보기 == "+phoneNum1List);
		model.addAttribute("phoneNum1List",phoneNum1List);
		
		return "/user/joinPage";
	}

	// 회원가입 아이디 체크
	@RequestMapping(value = "/user/userIDCheck", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(UserJoinDataVO userJoinDataVO) throws Exception {

		System.out.println("idCheck 실행");
		System.out.println("사용자 입력한 아이디 출력"+userJoinDataVO.getUserID());
		
		int count = userService.countID(userJoinDataVO);
		
		System.out.println("count 가 0이면 회원가입 가능. 1이상일 경우 중복처리하자 = " + count);

		return count;
	}

	// 회원가입 실행
	@RequestMapping(value = "/user/userJoin", method = RequestMethod.POST)
	@ResponseBody
	public int userJoin(UserJoinDataVO userJoinDataVO) throws Exception {

		System.out.println("회원가입 userJoin 실행");

		int result = userService.userInsert(userJoinDataVO);
		
		return result;
	}
	
	
	// 로그인 실행, request 객체를 통해 세션설정하기
		@RequestMapping(value = "/user/userLogin", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> userLogin(Model model, LoginDataVO loginDataVO, HttpServletRequest req) throws Exception {

			HashMap<String, Object> resultHashMap = new HashMap<String, Object>();
			
			HttpSession session = req.getSession();
			
			System.out.println("로그인 작업 실행");
			
			LoginDataVO loginResult = userService.getLoginData(loginDataVO);
			
			if(loginResult != null) {
				//세션 생성을 해주자.
				System.out.println("아이디가 존재하면 값들 나옴 = " + loginResult);
				
				System.out.println("세션설정을 시작한다");
				
				session.setAttribute("logUserID", loginResult.getLoginID());
				session.setAttribute("logUserPW", loginResult.getLoginPW()); // 사실 이건 전달 하면 안되거나 안해도 된다. 비밀번호니까. 확인만 하자.
				session.setAttribute("logUserName", loginResult.getUserName());
				
				//resultHashMap.put("resultSession", session); 세션을 같이 집어 넣고 하면 안된다.
				resultHashMap.put("loginResult", loginResult);
				
				System.out.println("세션 설정을 완료했다.");

				return resultHashMap;
				
			}else {
				System.out.println("세션 설정에 실패했다. = " + session.getAttribute("logUserID") + " : " + session.getAttribute("logUserPW") + " : " + session.getAttribute("logUserName"));


				return null;
			}
			
			
		}
		
		// 로그아웃
		@RequestMapping(value = "/user/userLogout", method = RequestMethod.GET)
		public String userLogout(HttpSession session) throws Exception{
			
			session.invalidate();
			System.out.println("모든 세션을 삭제합니다");
			
			return "redirect:/";
		}

}