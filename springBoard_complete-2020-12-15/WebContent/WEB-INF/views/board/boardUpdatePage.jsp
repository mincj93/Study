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
		
		$j("#submit").on("click", function(){
			
			var $frm = $j(".UDfrm :input");
			var param = $frm.serialize();
			
			$j.ajax({
				url : "/board/boardUpdateAction.do",
				data: param,
				dataType: "json",
				type: "POST",
				success : function(data){
					alert("수정환료");
					location.href="/board/boardList.do";
				},
				error : function (jqXHR, textStatus, errorThrown) {
					alert("수정 실패");
				}
			});
			
		});
		
	});
</script>



</head>
<body>

	<h1>boardupdatepage</h1>



	<form class="UDfrm">
		<input type="hidden" name="boardType" value="${boardType }">
		<input type="hidden" name="boardNum" value="${boardNum }">
		<table align="center">
		<tr>
				<td align="right"><input id="submit" type="button" value="수정하기"></td>
			</tr>
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400"><input type="text" name="boardTitle" value="${bVo.boardTitle}"></td>
						</tr>
						<tr>
							<td height="300" align="center">Comment</td>
							<td><textarea name="boardComment" rows="30" cols="50">${bVo.boardComment}</textarea></td>
						</tr>
						<tr>
							<td align="center">Writer</td>
							<td>${bVo.creator}</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><a href="/board/boardList.do">List</a></td>
			</tr>
		</table>
	</form>
</body>
</html>