<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script type="text/javascript">
	
	$j(document).ready(function() {
		
		//컨트롤러에서 hashmap 을 리턴할때 사용하는 메소드
		 $j("#loginBTN").on("click", function(e){
			
			e.preventDefault();	// 새로고침 막음
			
			var loginID = $j("#loginID").val(); //사용자입력 아이디
			var loginPW = $j("#loginPW").val();	//사용자입력 비번
			
			// alert("사용자가 입력한 아이디와 비번 = " + loginID + " : " + loginPW);
			
			var idRegCheck = RegExp(/^[A-Za-z0-9_\-]{4,15}$/);		// 4~15자리 아이디 정규식
			var pwRegCheck =  RegExp(/^[A-Za-z0-9_\-]{6,12}$/);		// 6~12자리 비번 정규식
			
			
			if(idRegCheck.test(loginID)){						// 입력한 아이디의 정규식 검사
				//alert("true작동 = " + idRegCheck.test(loginID));
				
				if(pwRegCheck.test(loginPW)){
					//alert("아이디와 비밀번호 모두 정규식 통과");
					
					var $frm = $j('#loginfrm :input');
					var allData = $frm.serialize();
					
					alert("컨트롤러에 보낼 allData 객체 == " + allData);
					
					$j.ajax({
						
						url : "/user/userLogin",
						dataType : "json",
						type : "POST",
						data : allData,
						success : function(data) { //  객체가 들어잇따.
							console.log(data);
								
							if(data != null){
								alert("로그인 ajax 성공 \nloginID = " + data.loginResult.loginID + "\nloginPW = " + data.loginResult.loginPW + "\nloginUserName = " + data.loginResult.userName);
								location.href="/";
							}else{
								alert("틀려먹었다");
							}
							
						},
						error : function(jqXHR, textStatus, errorThrown) {
							alert("로그인 실패");
						} 
						
					}); // 로그인 ajax 
					
				}else{
					alert("비밀번호는 6~12자리 입니다");
				}	// 비밀번호 정규식 확인 if문
			
			}else{
				alert("아이디는 영문,숫자 4~15자를 입력해야 합니다.");
			}	// 아이디 정규식 확인 if문
			
		}); // #loginBTN 
		
		
	});	// (document).ready
	
	
	
</script>


</head>
<body>

<h1>로그인 페이지</h1>

<div id="wrapper">


	<table align="center">
		<tr>
			<td>
				<div>
					<div style="float: left;">
						<a href="/">ListPage</a>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<table id="loginfrm" border="1">
					<tr>
						<td width="120" align="center">id</td><td width="300">
							<input type="text" id="loginID" name="loginID" placeholder="loginID" />
						</td>
					</tr>
					<tr>
						<td width="120" align="center">pw</td><td width="300">
							<input type="password" id="loginPW" name="loginPW" placeholder="loginPW" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td align="right"><a href="/user/userLogin" id="loginBTN">로그인버튼</a></td>
		</tr>

	</table>
	
</div>


</body>
</html>