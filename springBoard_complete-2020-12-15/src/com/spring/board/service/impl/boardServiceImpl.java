package com.spring.board.service.impl;

import java.util.HashMap;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BTListVO;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.SearchVo;
import com.sun.javafx.collections.MappingChange.Map;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		System.out.println("===boardServiceImpl 의 selectBoardList 실행===");
		
		return boardDao.selectBoardList(pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		System.out.println("===boardServiceImpl 의 selectBoardCnt 실행===");

		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		System.out.println("===boardServiceImpl 의 selectBoard 실행===");

		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		System.out.println("===boardServiceImpl 의 boardInsert 실행===");

		return boardDao.boardInsert(boardVo);
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		System.out.println("===boardServiceImpl 의 boardUpdate 실행===");

		return boardDao.boardUpdate(boardVo);
	}
	
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		System.out.println("===boardServiceImpl 의 boardDelete 실행===");

		return boardDao.boardDelete(boardVo);
	}

	@Override
	public List<BTListVO> boardTypeList() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardTypeList();
	}

	@Override
	public List<BoardVo> chkBoxSearch(SearchVo searchVo)  throws Exception {
		System.out.println("cccccccccccccccccccccccccccccccccvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvaaaaaaaaaaaaaaa");
		System.out.println(searchVo);
		System.out.println("cccccccccccccccccccccccccccccccccvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvaaaaaaaaaaaaaaa");
		return boardDao.chkBoxSearch(searchVo);
	}
	
}
