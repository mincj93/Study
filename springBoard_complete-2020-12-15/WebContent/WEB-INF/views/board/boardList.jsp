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

		// üũ�ڽ� ��üüũ, ���� ���
		$j("#all_check").change(function() {
			if (this.checked) {
				$j("#check_item").children("input").prop("checked", true);

			} else {
				$j("#check_item").children("input").prop("checked", false);
			}
		});

		//��ü üũ���� �ϳ��� üũ �����ϸ� "��ü üũ�ڽ�"�� üũ�� ������� �ϴ°�.
		$j("#check_item").children(".boardType").click(function() {
			$j("#all_check").prop("checked", false);
		});

	
		
	
		//https://labj.tistory.com/518 ��Ʈ�ѷ��� üũ�ڽ�������
		
		// https://okky.kr/article/382049 �����ϱ�.
				
		// https://okky.kr/article/382049 �����ϱ�.
				
		
		
		
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
																							// https://okky.kr/article/382049 �����ϱ�.
				success : function(data) {				// Hashmap �� �������. Ű���� ����������
					
						console.log(data);
						
						var boardTypeLists = data.boardTypeList;			 //��Ʈ�ѷ����� ������ searchedDataMap.put("boardTypeList", boardTypeList); �� �������.
																			// codeId �� codeName �� ����ִ�.
						//alert("boardTypeLists"+boardTypeLists); //�����۵�
						
						var typeListLength = Object.keys(boardTypeLists).length;	// ����Ÿ���� ��ü ����
						//alert("typeListLength"+typeListLength);	//�����۵�
						
						//alert("boardTypeLists 0��° �ε����� �ִ� codeId�� �� = "+boardTypeLists[0].codeId + " codeName�� �� = " + boardTypeLists[0].codeName);	// �����۵�
						
						////////////////////////////////////////////////// ������� Ÿ���� ��� �����Դ� ���� �˻��� ������� ���غ��� ////////////////////////////////////////
						
						
						var searchedDatas = data.searchedData;	// Ű ���� searchedData �� ã��. �׸��� �Ҵ���
						//alert("searchedData �� = " + searchedData);	//�����۵�
						// searchedDatas ���ο� boardType=a04, boardNum=2, boardTitle=����2, boardComment=����2, --- �̷����� ��ҵ��� ����.
						
						var searchedListLength = Object.keys(searchedDatas).length;	//�˻������ ����
						//alert("�˻������ ���� = " + searchedListLength);	// �����۵�
						
						//alert("searchedDatas 0���ε����� \nboardType == " + 	searchedDatas[0].boardType + "\nboardNum = " +searchedDatas[0].boardNum + "\nboardTitle = " + searchedDatas[0].boardTitle);
						// ���������� �̾Ƴ�
						
						
						
						
						
						//empty = ���ο� �մ� ������ ����.		remove = �ƿ� html��ұ��� ������
						
						
						$j("#boardTable").empty();	// ���̺� ����
						$j("#pagingTD").empty();	// ����¡ ����
						$j("#totalDIV").empty();	// �Ѱ��� �����
						
						$j("#boardTable").append('<td width="80" align="center">Type</td><td width="40" align="center">No</td><td width="300" align="center">Title</td>');
						
						
						var idx = searchedListLength;
						$j.each(searchedDatas, function(idx){		// idx �� index������. index��ŭ �ݺ�. �׷��ٸ� "idx = �˻��� ����� ����" �� �Ǿ����. �������. ���� ����� �ǳ� ����
							
							
							
							var btypeForm;	//�ѱ۷ε� boardType �� ������ ����
							
							for(var num=0; num <typeListLength ; num++){
								
								var type= boardTypeLists[num].codeId;	// ���� ���̴�. codeName�� �ֱ����� 
								
								
								if(searchedDatas[idx].boardType == type){
									btypeForm = boardTypeLists[num].codeName;
									
									 //alert("searchedDatas[idx].boardType �� �ѱ��� Ÿ������ ��ȯ�ϸ� = " + btypeForm); // �����۵�

									 
									 $j("#boardTable").append("<tr><td align='center' class='typeTD'>"
												
												+ btypeForm +"</td><td>"
												+ searchedDatas[idx].boardNum +"</td><td>" 
												+ "<a href=/board/" +	searchedDatas[idx].boardType + "/" + searchedDatas[idx].boardNum + "/boardView.do?pageNo=${pageNo}>" 
												+ searchedDatas[idx].boardTitle + "</a></td></tr>");
									} // if�� 
								
								
								} // for��
								
							 	
							});//$j.each	�ۼ��� �� �ڵ���� 	������������ 311�� ���� ����~ 332�� ���α��� ��� �ٽ� �׷��� ���̴�. 
							
						
						
					}, // success
					
					error : function(data, jqXHR, textStatus, errorThrown) {
						
						alert("���� ���ٴ٤�����\n" + textStatus + " : " + errorThrown);
						alert("����! ���� " + data);
						
					}
				
			}); // ajax
			
		});// ��ưŬ�� 
		
	});


</script>

<style>

/* ����¡ ���� ����, �߰� ��ġ*/
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
			<td align="left">${logUserName } �� �α��� ���̴�!!</td>
		</tr>
		<tr>
				<td align="right"><a href="/user/userLogout">�α׾ƿ�</a></td>
				<td align="right"><a href="/board/boardWrite.do">�۾���</a></td>
		</tr>
		</c:if>
		

		<!-- �˻� -->
		<tr>
			<td>

				<div style="align-items: center;" class="ckbox">

					<form class="searchFRM">

						<input type="checkbox" id="all_check"> <label for="boardType1">��ü</label>

						<div style="display: inline;" id="check_item" class="check_item">
							<c:forEach items="${boardTypeList }" var="chkList">
								<input type="checkbox" class="boardType" name="boardType" value="${chkList.codeId }">
								<label>${chkList.codeName }</label>
							</c:forEach>
						</div>

						<button type="button" class="searchBTN">�˻���ư</button>
					</form>

				</div>

			</td>
		</tr>
	</table>
	<!-- �α���  https://melonpeach.tistory.com/41 ���� �������� -->
	
	
</body>
</html>