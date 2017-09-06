package com.iot1.sql.vender.dto;

import org.springframework.stereotype.Component;

@Component
public class VenderInfo {

	private int viNum;
	private String viName;
	private String viDesc;
	private String viAddress;
	private String viPhone;
	private String viDate;
	private String viTime;
	
	public int getViNum() {
		return viNum;
	}
	public void setViNum(int viNum) {
		this.viNum = viNum;
	}
	public String getViName() {
		return viName;
	}
	public void setViName(String viName) {
		this.viName = viName;
	}
	public String getViDesc() {
		return viDesc;
	}
	public void setViDesc(String viDesc) {
		this.viDesc = viDesc;
	}
	public String getViAddress() {
		return viAddress;
	}
	public void setViAddress(String viAddress) {
		this.viAddress = viAddress;
	}
	public String getViPhone() {
		return viPhone;
	}
	public void setViPhone(String viPhone) {
		this.viPhone = viPhone;
	}
	public String getViDate() {
		return viDate;
	}
	public void setViDate(String viDate) {
		this.viDate = viDate;
	}
	public String getViTime() {
		return viTime;
	}
	public void setViTime(String viTime) {
		this.viTime = viTime;
	}
	@Override
	public String toString() {
		return "VenderInfo [viNum=" + viNum + ", viName=" + viName + ", viDesc=" + viDesc + ", viAddress=" + viAddress
				+ ", viPhone=" + viPhone + ", viDate=" + viDate + ", viTime=" + viTime + "]";
	}
	
	
}
