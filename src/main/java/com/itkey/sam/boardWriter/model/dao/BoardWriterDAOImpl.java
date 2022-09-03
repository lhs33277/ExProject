package com.itkey.sam.boardWriter.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.boardWriter.dto.BoardWriterDTO;

@Repository("boardWriterDAO")
public class BoardWriterDAOImpl implements BoardWriterDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;	
	
	@Override
	public void insertBoardWriter(BoardWriterDTO boardWriterDTO) {
		sqlSession.insert("insertBoardWriter", boardWriterDTO);
	}
	
	@Override
	public BoardWriterDTO selectBoardWriterByIdPw(BoardWriterDTO boardWriterDTO) {
		return sqlSession.selectOne("selectBoardWriterByIdPw", boardWriterDTO);
	}
	
	@Override
	public Map<String, Object> selectBoardWriterById(String boardWriter) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", sqlSession.selectOne("selectBoardWriterById", boardWriter));
		return map;
	}
	
	
	@Override
	public String selectSaltById(String boardWriter) {
		return sqlSession.selectOne("selectSaltById", boardWriter);
	}
	
	@Override
	public int selectMemberCount() {
		return sqlSession.selectOne("selectMemberCount");
	}
	
	@Override
	public int selectTodayMemberCount() {
		return sqlSession.selectOne("selectTodayMemberCount");
	}
	
	@Override
	public void updateMember(BoardWriterDTO boardWriterDTO) {
		sqlSession.update("updateMember", boardWriterDTO);
		
	}
	
	@Override
	public void deleteMember(String boardWriter) {
		sqlSession.delete("deleteMember", boardWriter);
		
	}
}
