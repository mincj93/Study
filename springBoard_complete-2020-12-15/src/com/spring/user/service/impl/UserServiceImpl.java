package com.spring.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.user.dao.UserDao;
import com.spring.user.service.UserService;
import com.spring.user.vo.LoginDataVO;
import com.spring.user.vo.PhoneNumVO;
import com.spring.user.vo.UserJoinDataVO;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDao	userDao;

	@Override
	public int userInsert(UserJoinDataVO userJoinDataVO) throws Exception {
		
		return userDao.userInsert(userJoinDataVO);
	}

	@Override
	public List<PhoneNumVO> getPhoneNum_1List() throws Exception {
		// TODO Auto-generated method stub
		return userDao.getPhoneNum_1List();
	}

	@Override
	public int countID(UserJoinDataVO userJoinDataVO) throws Exception {
		// TODO Auto-generated method stub
		return userDao.countID(userJoinDataVO);
	}

	@Override
	public LoginDataVO getLoginData(LoginDataVO loginDataVO) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getLoginData(loginDataVO);
	}

}
