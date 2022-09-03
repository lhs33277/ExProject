package com.itkey.sam.boardWriter.dto;

import java.sql.Date;

public class BoardWriterDTO {
	private int boardWriterIdx;
	private String boardWriter;
	private String boardWriterName;
	private String boardWriterPw;
	private String boardWriterPhone;
	private String boardWriterEmail;
	private String fileIdx;
	private Date boardWriterJoinDate;
	private String salt;
	private String delYn;
	
	
	public int getBoardWriterIdx() {
		return boardWriterIdx;
	}
	public void setBoardWriterIdx(int boardWriterIdx) {
		this.boardWriterIdx = boardWriterIdx;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardWriterName() {
		return boardWriterName;
	}
	public void setBoardWriterName(String boardWriterName) {
		this.boardWriterName = boardWriterName;
	}
	public String getBoardWriterPw() {
		return boardWriterPw;
	}
	public void setBoardWriterPw(String boardWriterPw) {
		this.boardWriterPw = boardWriterPw;
	}
	public String getBoardWriterPhone() {
		return boardWriterPhone;
	}
	public void setBoardWriterPhone(String boardWriterPhone) {
		this.boardWriterPhone = boardWriterPhone;
	}
	public String getBoardWriterEmail() {
		return boardWriterEmail;
	}
	public void setBoardWriterEmail(String boardWriterEmail) {
		this.boardWriterEmail = boardWriterEmail;
	}
	public String getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(String fileIdx) {
		this.fileIdx = fileIdx;
	}
	public Date getBoardWriterJoinDate() {
		return boardWriterJoinDate;
	}
	public void setBoardWriterJoinDate(Date boardWriterJoinDate) {
		this.boardWriterJoinDate = boardWriterJoinDate;
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
