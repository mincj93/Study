package com.spring.user.vo;

public class PhoneNumVO {
	
	public String codeId;
	public String codeName;
	
	public String getCodeId() {
		return codeId;
	}
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	
	@Override
	public String toString() {
		return "PhoneNumVO [codeId=" + codeId + ", codeName=" + codeName + "]";
	}
	
	

}
