package com.itkey.sam.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.itkey.sam.boardWriter.dto.BoardWriterDTO;

public interface AdminDAO {
	
	public List<BoardWriterDTO> selectMemberList(Map<String, Object> map);
	
	public void deleteMembers(String boardWriterIdx);

	public int selectFindCountManage(Map<String, Object> map);
	public int selectFindCountAllManage(Map<String, Object> map);
	
	public List<BoardWriterDTO> selectFindListManage(Map<String, Object> map);
	public List<BoardWriterDTO> selectFindListAllManage(Map<String, Object> map);
}
