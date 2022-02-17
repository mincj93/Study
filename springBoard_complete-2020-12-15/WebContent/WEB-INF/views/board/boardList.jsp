<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">


	
	$j(document).ready(function() {

		// 체크박스 전체체크, 해제 기능
		$j("#all_check").change(function() {
			if (this.checked) {
				$j("#check_item").children("input").prop("checked", true);

			} else {
				$j("#check_item").children("input").prop("checked", false);
			}
		});

		//전체 체크에서 하나라도 체크 해제하면 "전체 체크박스"에 체크가 사라지게 하는것.
		$j("#check_item").children(".boardType").click(function() {
			$j("#all_check").prop("checked", false);
		});

	
		
	
		//https://labj.tistory.com/518 컨트롤러에 체크박스보내기
		
		// https://okky.kr/article/382049 참고하기.
				
		// https://okky.kr/article/382049 참고하기.
				
		
		
		
	 $j(".searchBTN").on("click",function(){
			
			var chkBoxValArr = [];
			
			$j("input[name='boardType']:checked").each(function(i){
				chkBoxValArr.push($j(this).val());
			});

			
			var allData = {"checkArr":chkBoxValArr};
			
			$j.ajax({
				
				url : "/board/chbox_Search.do",
				data : allData,
				type : "POST",
				dataType: "json",
				//async: false,
																							// https://okky.kr/article/382049 참고하기.
				success : function(data) {				// Hashmap 이 들어있음. 키값도 설정해줬음
					
						console.log(data);
						
						var boardTypeLists = data.boardTypeList;			 //컨트롤러에서 보내준 searchedDataMap.put("boardTypeList", boardTypeList); 가 들어있음.
																			// codeId 와 codeName 이 들어있다.
						//alert("boardTypeLists"+boardTypeLists); //정상작동
						
						var typeListLength = Object.keys(boardTypeLists).length;	// 보드타입의 전체 갯수
						//alert("typeListLength"+typeListLength);	//정상작동
						
						//alert("boardTypeLists 0번째 인덱스에 있는 codeId의 값 = "+boardTypeLists[0].codeId + " codeName의 값 = " + boardTypeLists[0].codeName);	// 정상작동
						
						////////////////////////////////////////////////// 여기까지 타입을 모두 가져왔다 이제 검색한 결과값을 구해본다 ////////////////////////////////////////
						
						
						var searchedDatas = data.searchedData;	// 키 값인 searchedData 를 찾음. 그리고 할당함
						//alert("searchedData 찍어봄 = " + searchedData);	//정상작동
						// searchedDatas 내부에 boardType=a04, boardNum=2, boardTitle=자유2, boardComment=자유2, --- 이런식의 요소들이 있음.
						
						var searchedListLength = Object.keys(searchedDatas).length;	//검색결과의 갯수
						//alert("검색결과의 갯수 = " + searchedListLength);	// 정상작동
						
						//alert("searchedDatas 0번인덱스의 \nboardType == " + 	searchedDatas[0].boardType + "\nboardNum = " +searchedDatas[0].boardNum + "\nboardTitle = " + searchedDatas[0].boardTitle);
						// 정상적으로 뽑아냄
						
						
						
						
						
						//empty = 내부에 잇는 내용을 지움.		remove = 아예 html요소까지 다지움
						
						
						$j("#boardTable").empty();	// 테이블 비우기
						$j("#pagingTD").empty();	// 페이징 비우기
						$j("#totalDIV").empty();	// 총갯수 지우기
						
						$j("#boardTable").append('<td width="80" align="center">Type</td><td width="40" align="center">No</td><td width="300" align="center">Title</td>');
						
						
						var idx = searchedListLength;
						$j.each(searchedDatas, function(idx){		// idx 는 index역할함. index만큼 반복. 그렇다면 "idx = 검색된 결과의 갯수" 가 되어야함. 만들어줌. 이제 제대로 되나 보자
							
							
							
							var btypeForm;	//한글로된 boardType 을 저장할 변수
							
							for(var num=0; num <typeListLength ; num++){
								
								var type= boardTypeLists[num].codeId;	// 비교할 값이다. codeName을 넣기위해 
								
								
								if(searchedDatas[idx].boardType == type){
									btypeForm = boardTypeLists[num].codeName;
									
									 //alert("searchedDatas[idx].boardType 을 한글형 타입으로 변환하면 = " + btypeForm); // 정상작동

									 
									 $j("#boardTable").append("<tr><td align='center' class='typeTD'>"
												
												+ btypeForm +"</td><td>"
												+ searchedDatas[idx].boardNum +"</td><td>" 
												+ "<a href=/board/" +	searchedDatas[idx].boardType + "/" + searchedDatas[idx].boardNum + "/boardView.do?pageNo=${pageNo}>" 
												+ searchedDatas[idx].boardTitle + "</a></td></tr>");
									} // if문 
								
								
								} // for문
								
							 	
							});//$j.each	작성한 위 코드들은 	현재페이지의 311번 라인 부터~ 332번 라인까지 모두 다시 그려낸 것이다. 
							
						
						
					}, // success
					
					error : function(data, jqXHR, textStatus, errorThrown) {
						
						alert("에러 난다다ㅏㅏㅏ\n" + textStatus + " : " + errorThrown);
						alert("실패! 찍어보기 " + data);
						
					}
				
			}); // ajax
			
		});// 버튼클릭 
		
	});


</script>

<style>

/* 페이징 가론 나열, 중간 위치*/
.pagingul {
	text-align: center;
}

.pagingul li {
	list-style-type: none;
	display: inline-block;
}
</style>
<body>
	<table align="center">
		<tr>
			<td>
				<div>
					<div style="float: left;">
						<a href="/user/loginPage">login</a>
					</div>
					<div style="float: left; margin-left: 20px;">
						<a href="/user/joinPage">join</a>
					</div>
					<div id="totalDIV" style="text-align: right;">total : ${totalCnt}</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<table id="boardTable" border="1">
					<tr>
						<td width="80" align="center">Type</td>
						<td width="40" align="center">No</td>
						<td width="300" align="center">Title</td>
					</tr>
						<c:forEach items="${boardList}" var="list">
							<tr id="dataTR">
								<td align="center" id="typeTD">	
									<c:forEach items="${boardTypeList }" var="btList">
											<c:if test="${list.boardType eq btList.codeId}">
												<c:out value="${btList.codeName }" />
											</c:if>
									</c:forEach>
	
								</td>
								<td>${list.boardNum}</td>
								<td><a href="/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
								</td>
							</tr>
						</c:forEach>
				</table>
			</td>
		</tr>
		<tr>
			<td id="pagingTD">
				<div class="pagingdiv">
					<ul class="pagingul">

						<c:if test="${pageMaker.prev}">
							<li><a
								href="/board/boardList.do?pageNo=${pageMaker.startPage - 1}">&laquo;</a></li>
						</c:if>

						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.pageVo.pageNo == idx?'class =active':''}"/>>
								<a href="/board/boardList.do?pageNo=${idx}">${idx}</a>
							</li>
						</c:forEach>

						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li><a href="/board/boardList.do?pageNo=${pageMaker.endPage +1}">&raquo;</a></li>
						</c:if>

					</ul>
				</div>
			</td>
		</tr>

		
		<c:if test="${logUserID != null}">
		<tr>
			<td align="left">${logUserName } 이 로그인 중이다!!</td>
		</tr>
		<tr>
				<td align="right"><a href="/user/userLogout">로그아웃</a></td>
				<td align="right"><a href="/board/boardWrite.do">글쓰기</a></td>
		</tr>
		</c:if>
		

		<!-- 검색 -->
		<tr>
			<td>

				<div style="align-items: center;" class="ckbox">

					<form class="searchFRM">

						<input type="checkbox" id="all_check"> <label for="boardType1">전체</label>

						<div style="display: inline;" id="check_item" class="check_item">
							<c:forEach items="${boardTypeList }" var="chkList">
								<input type="checkbox" class="boardType" name="boardType" value="${chkList.codeId }">
								<label>${chkList.codeName }</label>
							</c:forEach>
						</div>

						<button type="button" class="searchBTN">검색버튼</button>
					</form>

				</div>

			</td>
		</tr>
	</table>
	<!-- 로그인  https://melonpeach.tistory.com/41 여기 참고하자 -->
	
	
</body>
</html>