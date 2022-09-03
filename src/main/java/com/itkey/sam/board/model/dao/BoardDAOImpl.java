package com.itkey.sam.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.BoardDTO;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	
	
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// Mybatis SqlSessionTemplate
	@Autowired private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertBoard2(BoardDTO board) {
		return sqlSession.insert("insertBoard", board);
	}
	
	
	
	
	
	public List<BoardDTO> selectBoardList(Map<String, Object> map) {
		return sqlSession.selectList("selectBoardList", map);
	};

	public int selectBoardCount(BoardDTO eDTO) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + eDTO.toString());
		int result = sqlSession.selectOne("selectBoardCount", eDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	};
	
	@Override
	public int selectTodayBoardCount() {
		return sqlSession.selectOne("selectTodayBoardCount");
	}
	

	public int insertBoard(BoardDTO eDTO) throws Exception {
		logger.debug("* [DAO] Input  ◀ (Service) : " + eDTO.toString());
		int result = sqlSession.update("insertBoard", eDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	};
	
	@Override
	public BoardDTO selectBoard(String boardIdx) {
		return sqlSession.selectOne("selectBoard", boardIdx);
	}
	
	@Override
	public void updateHit(String boardIdx) {
		sqlSession.update("updateHit", boardIdx);
		
	}

	public void updateBoard(BoardDTO boardDTO) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + boardDTO.toString());
		int result = sqlSession.update("updateBoard", boardDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
	};

	public int deleteBoard(String boardIdx) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + boardIdx);
		int result = sqlSession.update("deleteBoard", boardIdx);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	};
	
	@Override
	public int selectFindCount(Map<String, Object> map) {
		
		return sqlSession.selectOne("selectFindCount", map);
	}
	
	@Override
	public int selectFindCountAll(Map<String, Object> map) {
		
		return sqlSession.selectOne("selectFindCountAll", map);
	}
	
	@Override
	public List<BoardDTO> selectFindList(Map<String, Object> map) {
		
		return sqlSession.selectList("selectFindList", map);
	}
	
	@Override
	public List<BoardDTO> selectFindListAll(Map<String, Object> map) {
		
		return sqlSession.selectList("selectFindListAll", map);
	}
	
	@Override
	public BoardDTO selectBoardByRn(int rn) {
		
		return sqlSession.selectOne("selectBoardByRn", rn);
	}

}