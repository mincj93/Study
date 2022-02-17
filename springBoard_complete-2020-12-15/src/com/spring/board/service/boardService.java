package com.spring.board.service;

import java.util.HashMap;
import java.util.List;

import com.spring.board.vo.BTListVO;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.SearchVo;
import com.sun.javafx.collections.MappingChange.Map;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;
	
	//체크박스 만들때 씀
	public List<BTListVO> boardTypeList() throws Exception;

	//검색
	public List<BoardVo> chkBoxSearch(SearchVo searchVo) throws Exception;
	
	
}
