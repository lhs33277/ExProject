package com.itkey.sam.admin.dto;

import java.util.Date;

public class AdminDTO {

	private String adminIdx;
	private String adminId;
	private String adminName;
	private String admimPw;
	private String fileIdx;
	private Date adminJoinDate;
	private String salt;
	private String delYn;
	
	
	public String getAdminIdx() {
		return adminIdx;
	}
	public void setAdminIdx(String adminIdx) {
		this.adminIdx = adminIdx;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdmimPw() {
		return admimPw;
	}
	public void setAdmimPw(String admimPw) {
		this.admimPw = admimPw;
	}
	public String getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(String fileIdx) {
		this.fileIdx = fileIdx;
	}
	public Date getAdminJoinDate() {
		return adminJoinDate;
	}
	public void setAdminJoinDate(Date adminJoinDate) {
		this.adminJoinDate = adminJoinDate;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	
	
	
}
