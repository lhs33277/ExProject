package com.itkey.sam.board.dto;

import java.sql.Date;

public class BoardDTO {
	
	private int rn;
	private String boardIdx          = null;
	private String boardWriter       = null;
	private String boardTitle        = null;
	private String boardContents     = null;
	private int boardViewCount    = 0;
	private String fileIdx           = null;
	private String row           	= null;
	private String offset           = null;
	private Date boardWriteDate;
	private String boardPublicFl;
	private String boardDelYn;
	
	
	
	
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	public String getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(String boardIdx) {
		this.boardIdx = boardIdx;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContents() {
		return boardContents;
	}
	public void setBoardContents(String boardContents) {
		this.boardContents = boardContents;
	}
	public int getBoardViewCount() {
		return boardViewCount;
	}
	public void setBoardViewCount(int boardViewCount) {
		this.boardViewCount = boardViewCount;
	}
	public String getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(String fileIdx) {
		this.fileIdx = fileIdx;
	}
	public String getRow() {
		return row;
	}
	public void setRow(String row) {
		this.row = row;
	}
	public String getOffset() {
		return offset;
	}
	public void setOffset(String offset) {
		this.offset = offset;
	}
	public Date getBoardWriteDate() {
		return boardWriteDate;
	}
	public void setBoardWriteDate(Date boardWriteDate) {
		this.boardWriteDate = boardWriteDate;
	}
	public String getBoardPublicFl() {
		return boardPublicFl;
	}
	public void setBoardPublicFl(String boardPublicFl) {
		this.boardPublicFl = boardPublicFl;
	}
	public String getBoardDelYn() {
		return boardDelYn;
	}
	public void setBoardDelYn(String boardDelYn) {
		this.boardDelYn = boardDelYn;
	}
	
	
	
}