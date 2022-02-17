<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>

<script type="text/javascript">
	$j(document).ready(function(){
		
		$j(".deleteBTN").on("click", function(){
			var $frm = $j(".frm :input");
			var delData = $frm.serialize(); // input 태그의 name값과, 사용자의 입력값을 key = value 형식으로 리턴해준다. 
			
			var confm = confirm("게시물을 삭제하겠습니까?");
			
			if(confm){
				
				$j.ajax({
	
					url : "/board/boardDelete.do",
					type : "POST",
					dataType : "json",
					data : delData,
					success : function(data) {
						alert("- 삭제완료 -" + delData + "결과 출력 = " + data);
						location.href = "/board/boardList.do";
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("- 삭제실패 -");
						//history.go(0);
					}
				});
				
			}else{
				alert("삭제 취소");
				return false;
			}
			
		});
	});



</script>




</head>
	<body>
		<form class="frm">
			<input type="hidden" name="boardNum" value="${boardNum }">
			<input type="hidden" name="boardType" value="${boardType }">
		</form>
		<table align="center">
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400">${board.boardTitle}</td>
						</tr>
						<tr>
							<td height="300" align="center">Comment</td>
							<td>${board.boardComment}</td>
						</tr>
						<tr>
							<td align="center">Writer</td>
							<td>${board.creator}</td>
						</tr>
					</table>
				</td>
			</tr>
			
			<c:if test="${logUserID != null}">
				<tr>
					<td align="right">${logUserName } 이 로그인 중이다!!</td>
				</tr>
				<tr>
					<td align="right"><a href="/user/userLogout">로그아웃</a></td>
					<td align="right"><a href="/board/boardWrite.do">글쓰기</a></td>
					<td align="right">
						<a href="/board/boardList.do">List</a> 
						<a href="/board/${boardType}/${boardNum}/boardUpdate.do">글 수정</a>
						<input type="button" class="deleteBTN" value="글 삭제">
					</td>
				</tr>
			</c:if>
			<c:if test="${logUserID == null }">			
					<td align="right"><a href="/user/loginPage">로그인하기</a></td>
			</c:if>
			
			<tr>
				
			</tr>
			
		</table>
	</body>
</html>