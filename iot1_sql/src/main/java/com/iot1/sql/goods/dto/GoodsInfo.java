package com.iot1.sql.goods.dto;

import org.springframework.stereotype.Component;

@Component
public class GoodsInfo {

	private int giNum;
	private String giName;
	private String giDesc;
	private int viNum;
	private String giDate;
	private String giTime;
	
	public int getGiNum() {
		return giNum;
	}
	public void setGiNum(int giNum) {
		this.giNum = giNum;
	}
	public String getGiName() {
		return giName;
	}
	public void setGiName(String giName) {
		this.giName = giName;
	}
	public String getGiDesc() {
		return giDesc;
	}
	public void setGiDesc(String giDesc) {
		this.giDesc = giDesc;
	}
	public int getViNum() {
		return viNum;
	}
	public void setViNum(int viNum) {
		this.viNum = viNum;
	}
	public String getGiDate() {
		return giDate;
	}
	public void setGiDate(String giDate) {
		this.giDate = giDate;
	}
	public String getGiTime() {
		return giTime;
	}
	public void setGiTime(String giTime) {
		this.giTime = giTime;
	}
	@Override
	public String toString() {
		return "GoodsInfo [giNum=" + giNum + ", giName=" + giName + ", giDesc=" + giDesc + ", viNum=" + viNum
				+ ", giDate=" + giDate + ", giTime=" + giTime + "]";
	}
	
	
}
