package com.spring.user.vo;

public class LoginDataVO {
	
	private String loginID;
	private String loginPW;
	private String loginUserName;
	
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getLoginPW() {
		return loginPW;
	}
	public void setLoginPW(String loginPW) {
		this.loginPW = loginPW;
	}
	public String getUserName() {
		return loginUserName;
	}
	public void setloginUserName(String loginUserName) {
		this.loginUserName = loginUserName;
	}
	
	@Override
	public String toString() {
		return "LoginDataVO [loginID=" + loginID + ", loginPW=" + loginPW + ", loginUserName=" + loginUserName + "]";
	}
	
	

	
}
