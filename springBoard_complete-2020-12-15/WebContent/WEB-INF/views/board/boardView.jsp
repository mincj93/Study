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
			var delData = $frm.serialize(); // input �±��� name����, ������� �Է°��� key = value �������� �������ش�. 
			
			var confm = confirm("�Խù��� �����ϰڽ��ϱ�?");
			
			if(confm){
				
				$j.ajax({
	
					url : "/board/boardDelete.do",
					type : "POST",
					dataType : "json",
					data : delData,
					success : function(data) {
						alert("- �����Ϸ� -" + delData + "��� ��� = " + data);
						location.href = "/board/boardList.do";
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("- �������� -");
						//history.go(0);
					}
				});
				
			}else{
				alert("���� ���");
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
					<td align="right">${logUserName } �� �α��� ���̴�!!</td>
				</tr>
				<tr>
					<td align="right"><a href="/user/userLogout">�α׾ƿ�</a></td>
					<td align="right"><a href="/board/boardWrite.do">�۾���</a></td>
					<td align="right">
						<a href="/board/boardList.do">List</a> 
						<a href="/board/${boardType}/${boardNum}/boardUpdate.do">�� ����</a>
						<input type="button" class="deleteBTN" value="�� ����">
					</td>
				</tr>
			</c:if>
			<c:if test="${logUserID == null }">			
					<td align="right"><a href="/user/loginPage">�α����ϱ�</a></td>
			</c:if>
			
			<tr>
				
			</tr>
			
		</table>
	</body>
</html>