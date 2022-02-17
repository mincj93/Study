package com.spring.user.dao;

import java.util.List;

import com.spring.user.vo.LoginDataVO;
import com.spring.user.vo.PhoneNumVO;
import com.spring.user.vo.UserJoinDataVO;

public interface UserDao {

	public int userInsert(UserJoinDataVO userJoinDataVO) throws Exception;
	
	public List<PhoneNumVO> getPhoneNum_1List() throws Exception;
	
	public int countID(UserJoinDataVO userJoinDataVO) throws Exception;
	
	public LoginDataVO getLoginData(LoginDataVO loginDataVO) throws Exception; //로그인
	
	
}
