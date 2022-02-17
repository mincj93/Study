package com.spring.board.vo;

import java.util.List;

public class SearchVo extends PageVo{		// pageNo 받아서 체크박스검색을 위한 상속
	
	private List<String> checkVal;

	
	
	public List<String> getCheckVal() {
		return checkVal;
	}



	public void setCheckVal(List<String> chkList) {
		this.checkVal = chkList;
	}



	@Override
	public String toString() {
		return "SearchVo [checkVal=" + checkVal + "]";
	}



	
	
	
}
