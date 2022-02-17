package com.spring.user.service;

import java.util.List;

import com.spring.user.vo.LoginDataVO;
import com.spring.user.vo.PhoneNumVO;
import com.spring.user.vo.UserJoinDataVO;

public interface UserService {
	
	public int userInsert(UserJoinDataVO userJoinDataVO) throws Exception;	// 회원가입
	
	public List<PhoneNumVO> getPhoneNum_1List() throws Exception;	// 폰번호 리스트 가져오기
	
	public int countID(UserJoinDataVO userJoinDataVO) throws Exception;			// 아이디 체크. xml파일에서 입력한 아이디와 동일한 아이디가 있다면 갯수를 찾는다.
	
	public LoginDataVO getLoginData(LoginDataVO loginDataVO) throws Exception; //로그인
}
