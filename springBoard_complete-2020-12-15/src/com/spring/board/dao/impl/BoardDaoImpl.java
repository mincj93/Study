package com.spring.board.dao.impl;

import java.util.HashMap;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BTListVO;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.SearchVo;
import com.sun.javafx.collections.MappingChange.Map;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		System.out.println("===BoardDaoImpl 의 selectBoardList 실행===");
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		System.out.println("===BoardDaoImpl 의 selectBoardCnt 실행===");
		return sqlSession.selectOne("board.boardTotal");
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		System.out.println("===BoardDaoImpl 의 selectBoard 실행===");
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		System.out.println("===BoardDaoImpl 의 boardInsert 실행===");
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		System.out.println("===BoardDaoImpl 의 boardUpDate 실행===");
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		System.out.println("===BoardDaoImpl 의 boardDelete 실행===");
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	@Override
	public List<BTListVO> boardTypeList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardTypeList");
	}
	
	@Override
	public List<BoardVo> chkBoxSearch(SearchVo searchVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.chkBoxSearch", searchVo);
	}
	
}
