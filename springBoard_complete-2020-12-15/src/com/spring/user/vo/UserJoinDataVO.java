package com.spring.user.vo;

public class UserJoinDataVO {

	private String userID;
	private String userPW;
	private String userName;
	private String userPhone1;	//010
	private String userPhone2;	//3105
	private String userPhone3;	//2676
	private String userAddr1;	//postNo
	private String userAddr2;	//address
	private String userCompany;
	
	
	@Override
	public String toString() {
		return "UserJoinDataVO [userID=" + userID + ", userPW=" + userPW + ", userName=" + userName + ", userPhone1="
				+ userPhone1 + ", userPhone2=" + userPhone2 + ", userPhone3=" + userPhone3 + ", userAddr1=" + userAddr1
				+ ", userAddr2=" + userAddr2 + ", userCompany=" + userCompany + "]";
	}
	
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPW() {
		return userPW;
	}
	public void setUserPW(String userPW) {
		this.userPW = userPW;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPhone1() {
		return userPhone1;
	}
	public void setUserPhone1(String userPhone1) {
		this.userPhone1 = userPhone1;
	}
	public String getUserPhone2() {
		return userPhone2;
	}
	public void setUserPhone2(String userPhone2) {
		this.userPhone2 = userPhone2;
	}
	public String getUserPhone3() {
		return userPhone3;
	}
	public void setUserPhone3(String userPhone3) {
		this.userPhone3 = userPhone3;
	}
	public String getUserAddr1() {
		return userAddr1;
	}
	public void setUserAddr1(String userAddr1) {
		this.userAddr1 = userAddr1;
	}
	public String getUserAddr2() {
		return userAddr2;
	}
	public void setUserAddr2(String userAddr2) {
		this.userAddr2 = userAddr2;
	}
	public String getUserCompany() {
		return userCompany;
	}
	public void setUserCompany(String userCompany) {
		this.userCompany = userCompany;
	}
	
	
	
}
