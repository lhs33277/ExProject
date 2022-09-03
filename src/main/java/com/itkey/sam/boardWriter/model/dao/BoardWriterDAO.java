package com.itkey.sam.boardWriter.model.dao;

import java.util.Map;

import com.itkey.sam.boardWriter.dto.BoardWriterDTO;

public interface BoardWriterDAO {
	public void insertBoardWriter(BoardWriterDTO boardWriterDTO);
	public BoardWriterDTO selectBoardWriterByIdPw(BoardWriterDTO boardWriterDTO);
	public Map<String, Object> selectBoardWriterById(String boardWriter);
	public String selectSaltById(String boardWriter);
	public int selectMemberCount();
	public int selectTodayMemberCount();
	public void updateMember(BoardWriterDTO boardWriterDTO);
	public void deleteMember(String boardWriter);
}
