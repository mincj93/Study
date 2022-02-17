package com.spring.user.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.user.dao.UserDao;
import com.spring.user.vo.LoginDataVO;
import com.spring.user.vo.PhoneNumVO;
import com.spring.user.vo.UserJoinDataVO;

@Repository
public class UserDaoImpl implements UserDao {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int userInsert(UserJoinDataVO userJoinDataVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("user.userInsert",userJoinDataVO);
	}

	@Override
	public List<PhoneNumVO> getPhoneNum_1List() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("user.getPhoneNum_1List");
	}

	@Override
	public int countID(UserJoinDataVO userJoinDataVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.countUserID",userJoinDataVO);
	}

	@Override
	public LoginDataVO getLoginData(LoginDataVO loginDataVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.getUserData", loginDataVO);
	}

}
