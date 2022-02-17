package com.spring.board.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {

  private int totalCount;		// 페이지의 총 갯수
  private int startPage;		// 시작페이지 지정
  private int endPage;			// 끝페이지의 번호
  private boolean prev;			// 이전페이지
  private boolean next;			// 다음페이지
  

  private int displayPageNum = 10;		// 몇개의 페이징 갯수를 노출 시킬 것인지 설정한는것.
  										// 첫페이지가 1이라면 10페이지. 13페이지이면 23까지.

  private PageVo pageVo;				// 한페이지당 몇개의 데이터를 노출시킬지 생성하는것.

  public void setCri(PageVo pageVo) {
    this.pageVo = pageVo;
  }

  public void setTotalCount(int totalCount) {
    this.totalCount = totalCount;

    calcData();
  }

  private void calcData() {
	
	// 마지막페이지 구하기
    endPage = (int) (Math.ceil(pageVo.getPageNo() / (double) displayPageNum) * displayPageNum);
    				// Math.ceil 이것은 실수를 정수로 올림하는 메소드임.
    				// "소수점 숫자가 있다면 무조건 올림하여 정수로 바꿔주는것임".
    				// 1.1 을 해도 2가 되고 1.6을 해도 2가된다. 단, 1.0은 1이된다
    
    // 시작페이지
    startPage = (endPage - displayPageNum) + 1;

    int tempEndPage = (int) (Math.ceil(totalCount / (double) pageVo.getPerPageNum()));

    if (endPage > tempEndPage) {
      endPage = tempEndPage;
    }

    prev = startPage == 1 ? false : true;

    next = endPage * pageVo.getPerPageNum() >= totalCount ? false : true;

  }

  public int getTotalCount() {
    return totalCount;
  }

  public int getStartPage() {
    return startPage;
  }

  public int getEndPage() {
    return endPage;
  }

  public boolean isPrev() {
    return prev;
  }

  public boolean isNext() {
    return next;
  }

  public int getDisplayPageNum() {
    return displayPageNum;
  }

  public PageVo getPageVo() {
    return pageVo;
  }

  public String makeQuery(int page) {
	  // 예시) ?page = 4&perPageNum=5   이런 문자열이 리턴된다고한다
	  
	  // UriComponents 쿼리스트링 만들어주는 클래스라고 보면된다.
	  // key value 로 똑같이 들어간다.
	  // 물음표는 자동으로 추가된다.
    UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
        .queryParam("perPageNum", pageVo.getPerPageNum()).build();

    return uriComponents.toUriString();
  }
  
  
//  public String makeSearch(int page){
//    
//    UriComponents uriComponents =
//              UriComponentsBuilder.newInstance()
//              .queryParam("page", page)
//              .queryParam("perPageNum", pageVo.getPerPageNum())
//              .queryParam("searchType", ((SearchCriteria)pageVo).getSearchType())
//              .queryParam("keyword", ((SearchCriteria)pageVo).getKeyword())
//              .build();             
//    
//    return uriComponents.toUriString();
//  } 
}
