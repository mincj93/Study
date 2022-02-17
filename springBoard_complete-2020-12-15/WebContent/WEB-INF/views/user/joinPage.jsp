<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>









<script type="text/javascript">

	
	$j(document).ready(function(){
		
		// 정규식. 아이디란에 한글입력 방지.
		$j("#userID").on("keyup",function() {
			$j("#userID").val( $j("#userID").val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-히]/g, "")); 
		});
		
		// 정규식. 이름 입력란에 영어입력방지
		$j("#userName").on("keyup",function() {
			$j("#userName").val( $j("#userName").val().replace(/[a-zA-Z]/g, "")); 
		});
		
		// 정규식. 휴대전화번호에 숫자만 들어가게하기
		$j("#userPhone2, #userPhone3" ).on("keyup",function() {
			$j("#userPhone2").val( $j("#userPhone2").val().replace(/[a-zA-Zㄱ-ㅎ|ㅏ-ㅣ|가-히]/g, ""));
			$j("#userPhone3").val( $j("#userPhone3").val().replace(/[a-zA-Zㄱ-ㅎ|ㅏ-ㅣ|가-히]/g, ""));
		});
		
		// 정규식. 우편번호에 다른 문자 입력 불가. 숫자만 입력 가능하게함
		$j("#postNo").on("keyup",function() {
				$j("#postNo").val( $j("#postNo").val().replace(/[^0-9]/g, "").replace(/(^[0-9]{3})([0-9]+)?([0-9]{3})$/,"$1-$2-$3").replace("--", "-") ); 
		});
		
		var idChkResult = false;
		
		// 중복확인
		$j("#idCheckBTN").on("click", function() {
			
			
			//alert("아이디 중복확인 실행");
			
			var chkData = $j("#userID").val();	//사용자 입력값.
			
			
			//alert("사용자가 입력한 아이디값을 받아옴= " + chkData);			//https://kingchobocoding.tistory.com/11 			아이디 중복에 관한 참고
																// 정규식을 생각해보자								https://ming9mon.tistory.com/81 			정규식 관련 참고
			
			
			var IDlangCheck = RegExp(/^[A-Za-z0-9_\-]{4,15}$/);	// 아이디 유효성검사. "영문 대,소문자", "숫자",  " _ "(언더바) , " - "(찍-) 만 입력 가능, 4~15자리만 사용 가능하게 제한.
																// RegExp 는 정해진 단어인듯 하다. 다른거로 하면 에러난다.
																// 정규식객체명.test(검사할객체명) 을 해주면 정규식 검사를 한다. ex) langCheck.test(chkData)
			
			
																
																
			if(IDlangCheck.test(chkData)){						// 입력한 아이디의 정규식 검사
				//alert("아이디가 정규식을 통과함");
				idChkResult = true;
				
				if(idChkResult){									//아이디가 정규식 통과해야지만 들어옴
					//alert("아이디 정규식 통과 후 if문 실행"); 
					//alert(chkData);				//잘받음

					 $j.ajax({
						
						url : "/user/userIDCheck",
						dataType : "json",
						type : "POST",
						data : {"userID":chkData},
						success : function(data) {
							// alert("조회성공 존재하는 아이디 갯수 = " + data);	// idChkResult	값도 출력가능 true,false 둘 중 하나.
							
							if(data >= 1){					
								alert("이미 존재하는 아이디이다 == " + data);		// 조회한 데이터가 1개 이상이면 "사용불가!! 다른아이디 입력해라!"
								idChkResult = false;
								$j("#userID").focus();
								return idChkResult;
								
							}else{
								$j(".hiddenIDCheck").val(chkData);			// 최종가입 시 .hiddenIDCheck 에 넣은 값과 다시 userID.val()을 통해서 바뀌었는지 확인하려고 넣어둔다
								alert("사용 가능한 아이디 == " + data + "\nid == " + $j(".hiddenIDCheck").val());
								$j("#userID").focus();
								idChkResult = true;
								return idChkResult;
							}
							
						},
						error : function(jqXHR, textStatus, errorThrown) {
							alert("ajax 실패");
						} 
						
					});// 중복확인 ajax 
					
					
				}
				
				
			}else{
				alert("아이디는 영문, 숫자 4~15자리를 입력하세요");
				$j("#userID").focus();
				return idChkResult;
			}
																
		
		});	// 아이디 중복확인 끝 여기까지 잘됨
		
		
		
		
		

		
		
		//회원가입 최종버튼
		$j("#doJoinBTN").on("click", function(e) {
			
			e.preventDefault();	// 기본이벤트 취소. 데이터가 그대로 유지 == 된다!
			
			var inputID = $j(".hiddenIDCheck").val();
			var isChangeID = $j("#userID").val();
			
			if(inputID == isChangeID){		// 가입전 id 중복확인 한 값과 변경했는지의 여부 판단
			
				if(idChkResult == true){		// 중복확인이 먼저 실행 되었을 경우 실행되는 if문
	
					var userPW = $j("#userPW").val();	//사용자 입력 비밀번호 저장
					
					if(userPW != ""){
						
						var userPWCheckReg = RegExp(/^[A-Za-z0-9_\-]{6,12}$/);	// 비밀번호 확인 용 정규식. 영문,숫자 6~12 자만 입력가능
						
						if(userPWCheckReg.test(userPW)){
							//alert("비밀번호 정규식 통과");
							
							var secondUserPW = $j("#pwCheck").val();
							
							if(secondUserPW != ""){
							
								if(userPWCheckReg.test(secondUserPW)){
								
									if(userPW == secondUserPW){
										
										var userName = $j("#userName").val();
										if(userName != ""){
											
											var userNameCheckReg = RegExp(/^[가-히]{2,10}$/);
	
											if(userNameCheckReg.test(userName)){	//[가-힣]    정규식   '힣'  가 안되는거같다.
												
												var userPhoneNum1 = $j("#userPhone1").val();
												var userPhoneNum2 = $j("#userPhone2").val();
												var userPhoneNum3 = $j("#userPhone3").val();
												
												var pNumReg = RegExp(/^[0-9]{4}$/);
												
												//alert("번호    : " + userPhoneNum1 + " - " + userPhoneNum2 + " - " + userPhoneNum3);
												
												if(pNumReg.test(userPhoneNum2) && pNumReg.test(userPhoneNum3)){
													//alert("번호 정규식 통과   : " + userPhoneNum1 + " - " + userPhoneNum2 + " - " + userPhoneNum3);
													
													// https://dongram.tistory.com/6 하이픈 자동으로 입력하는방법
													
													var postNoReg = RegExp(/^[0-9]{3}-[0-9]{3}$/);
													var postNo = $j("#postNo").val();
														
													var $userInput = $j('#joinInput :input');
													var param = $userInput.serialize();
													alert("모든 입력값은 = " + param);
													$j.ajax({
														url : "/user/userJoin",
														dataType : "json",
														type : "POST",
														data : param,
														success : function(data, textStatus, jqXHR) {
															alert("가입완료!");
															location.href = "/";
														},
														error : function(jqXHR, textStatus, errorThrown) {
															alert("가입실패");
														}
													});
														
												}else{
													alert("휴대전화 번호는 숫자만 4개씩 입력 가능하다");
													$j("#userPhone2").focus();
													return false;
												} // 휴대전화번호 정규식 확인 if 문
												
											}else{
												alert("사용자의 이름은 한글만 2~10 자리 입력 가능합니다");
												$j("#userName").focus();
												return false;
											}// 사용자 이름 정규식 확인 if문
											
										}else{
										
											alert("사용의 이름을 입력해 주세요");
											$j("#userName").focus();
											
										} // 사용자의 이름 입력 여부 if문
									}else{
										alert("비밀번호와 비밀번호 확인의 값이 다릅니다. 다시 입력해 주세요.");
										$j("#userPW").focus();
										return false;
									}	// 비밀번호, 비밀번호 확인란의 값 비교 if문 
								}else{
									alert("비밀번호 확인란은 영문,숫자 6~12자만 가능하다");
									$j("#pwCheck").focus();
									return false;
								}	// 비밀번호 확인란 정규식 확인 if문
								
							}else{
								alert("비밀번호 확인란에 입력해주세요");
								$j("#pwCheck").focus();
								return false;
							} // 비밀번호 확인란 값확인 if문
							
							
						}else{
							alert("비밀번호는 영문,숫자 6~12자만 가능하다");
							$j("#userPW").focus();
							return false;
						}// 비밀번호 정규식 확인 if문
						
					}else if(userPW == ""){
						alert("비밀번호를 입력하세요");
						$j("#userPW").focus();
						return false;
					} // 비밀번호 입력 여부 if문
					
					
				}else{	
					$j("#userID").focus();
					alert("아이디 중복확인을 먼저 하세요");
					return false;
				} 	// 아이디 중복 확인 if문
				
			}else{
				alert("아이디를 변경하셨나요? \n아이디 중복확인을 해주세요 ");
				return false;
			}
			//alert("if 문에 return false 로 인해 실행되는지 보기위한 alert임 ");
		});	// 회원가입 최종버튼	
		
	}); // document.ready

</script>

</head>
<body>
<h1>회원가입 페이지</h1>

<div id="wrapper">


	<table align="center">
		<tr>
			<td>
				<div>
					<div style="float: left;">
						<a href="/">ListPage</a>
					</div>
					<div style="float: left; margin-left: 20px;">
						<a href="/user/loginPage">login</a>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<table id="joinInput" border="1">
					<tr>
						<td width="120" align="center">id</td><td width="300">
							<input type="text" id="userID" name="userID" placeholder="userID" maxlength="15" />  <button type="button" id="idCheckBTN">중복확인</button>
						</td>
						
					</tr>
					<tr>
						<td width="120" align="center">pw</td><td width="300"><input type="password" id="userPW" name="userPW" placeholder="userPW" maxlength="12" /></td>
					</tr>
					<tr>
						<td width="120" align="center">pw check</td><td width="300"><input type="password" id="pwCheck" placeholder="pwCheck" maxlength="12" /></td>
						<!-- 가입하기 버튼의 alert 에 안찍히는게 정상임 -->
					</tr>
					<tr>
						<td width="120" align="center">name</td><td width="300"><input type="text" id="userName" name="userName" placeholder="userName" /></td>
					</tr>
					<tr>
						<td width="120" align="center">phone</td>
						<td width="300">
							<select id="userPhone1" name="userPhone1">
								<c:forEach items="${phoneNum1List }" var="pNumList">
									<option value="${pNumList.codeId }">${pNumList.codeName }</option>
								</c:forEach>
							</select> -
							<input style="width: 40px;" type="text" id="userPhone2" name="userPhone2" placeholder="1234" maxlength="4"/> -
							<input style="width: 40px;" type="text" id="userPhone3" name="userPhone3" placeholder="5678" maxlength="4"/>
																									<!-- maxlength 를 사용해서 글자수 제한 -->
						</td>
					</tr>
					<tr>
						<td width="120" align="center">postNo</td><td width="300"><input type="text" id="postNo" name="userAddr1" placeholder="123456" maxlength="6" /></td>
					</tr>
					<tr>
						<td width="120" align="center">address</td><td width="300"><input type="text" name="userAddr2" placeholder="userAddr2" maxlength="14" /></td>
					</tr>
					<tr>
						<td width="120" align="center">company</td><td width="300"><input type="text" name="userCompany" placeholder="userCompany" maxlength="14" /></td>
					</tr>
					
				</table>
			</td>
		</tr>
		

		<tr>
			<td align="right"><a href="" id="doJoinBTN">가입하기!</a></td>
		</tr>

	</table>
	

	<input type="hidden" class="hiddenIDCheck" ></input>
</div>
</body>
</html>