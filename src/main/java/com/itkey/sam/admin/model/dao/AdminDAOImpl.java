package com.itkey.sam.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.boardWriter.dto.BoardWriterDTO;

@Repository("adminDAO")
public class AdminDAOImpl implements AdminDAO {
	
	@Autowired private SqlSessionTemplate sqlSession;
	
	@Override
	public List<BoardWriterDTO> selectMemberList(Map<String, Object> map) {
		return sqlSession.selectList("selectMemberList", map);
	}
	
	@Override
	public void deleteMembers(String boardWriterIdx) {
		sqlSession.update("deleteMembers", boardWriterIdx);
		
	}
	
	@Override
	public int selectFindCountManage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectFindCountManage", map);
	}
	
	@Override
	public int selectFindCountAllManage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectFindCountAllManage", map);
	}
	
	@Override
	public List<BoardWriterDTO> selectFindListManage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectFindListManage", map);
	}
	
	@Override
	public List<BoardWriterDTO> selectFindListAllManage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectFindListAllManage", map);
	}

}
