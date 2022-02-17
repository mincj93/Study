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
		
		//��Ʈ�ѷ����� hashmap �� �����Ҷ� ����ϴ� �޼ҵ�
		 $j("#loginBTN").on("click", function(e){
			
			e.preventDefault();	// ���ΰ�ħ ����
			
			var loginID = $j("#loginID").val(); //������Է� ���̵�
			var loginPW = $j("#loginPW").val();	//������Է� ���
			
			// alert("����ڰ� �Է��� ���̵�� ��� = " + loginID + " : " + loginPW);
			
			var idRegCheck = RegExp(/^[A-Za-z0-9_\-]{4,15}$/);		// 4~15�ڸ� ���̵� ���Խ�
			var pwRegCheck =  RegExp(/^[A-Za-z0-9_\-]{6,12}$/);		// 6~12�ڸ� ��� ���Խ�
			
			
			if(idRegCheck.test(loginID)){						// �Է��� ���̵��� ���Խ� �˻�
				//alert("true�۵� = " + idRegCheck.test(loginID));
				
				if(pwRegCheck.test(loginPW)){
					//alert("���̵�� ��й�ȣ ��� ���Խ� ���");
					
					var $frm = $j('#loginfrm :input');
					var allData = $frm.serialize();
					
					alert("��Ʈ�ѷ��� ���� allData ��ü == " + allData);
					
					$j.ajax({
						
						url : "/user/userLogin",
						dataType : "json",
						type : "POST",
						data : allData,
						success : function(data) { //  ��ü�� ����յ�.
							console.log(data);
								
							if(data != null){
								alert("�α��� ajax ���� \nloginID = " + data.loginResult.loginID + "\nloginPW = " + data.loginResult.loginPW + "\nloginUserName = " + data.loginResult.userName);
								location.href="/";
							}else{
								alert("Ʋ���Ծ���");
							}
							
						},
						error : function(jqXHR, textStatus, errorThrown) {
							alert("�α��� ����");
						} 
						
					}); // �α��� ajax 
					
				}else{
					alert("��й�ȣ�� 6~12�ڸ� �Դϴ�");
				}	// ��й�ȣ ���Խ� Ȯ�� if��
			
			}else{
				alert("���̵�� ����,���� 4~15�ڸ� �Է��ؾ� �մϴ�.");
			}	// ���̵� ���Խ� Ȯ�� if��
			
		}); // #loginBTN 
		
		
	});	// (document).ready
	
	
	
</script>


</head>
<body>

<h1>�α��� ������</h1>

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
			<td align="right"><a href="/user/userLogin" id="loginBTN">�α��ι�ư</a></td>
		</tr>

	</table>
	
</div>


</body>
</html>