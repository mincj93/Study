package com.spring.board.vo;

public class PageVo {		//  Criteria
	
	private int pageNo = 1;		// 모든 페이지 중 어떤 페이지를 보여줄 것인지
	private int perPageNum;     // 한 페이지에 들어갈 데이터의 양(게시물의 갯수)

	public PageVo() {
		this.pageNo = 1;
		this.perPageNum = 10;	
		
	}
	
	public void setPageNo(int pageNo) {
		if (pageNo <= 0) {
			this.pageNo = 1;
		}
		
		this.pageNo = pageNo;
	}
	
	public int getPageNo() {
		return pageNo;
	}


	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {

	    if (perPageNum <= 0 || perPageNum > 100) {
	      this.perPageNum = 5;
	      return;
	    }

	    this.perPageNum = perPageNum;
	  }

	@Override
	public String toString() {
		return "PageVo [pageNo=" + pageNo + ", perPageNum=" + perPageNum + "]";
	}
	
	
	
}
