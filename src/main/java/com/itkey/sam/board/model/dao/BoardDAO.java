package com.itkey.sam.board.model.dao;

import java.util.List;
import java.util.Map;

import com.itkey.sam.board.dto.BoardDTO;

public interface BoardDAO {
	
	public int insertBoard2(BoardDTO board);

	/**
	 * 게시판 정보 조회
	 * @param eDTO 조회조건
	 * @return 결과 목록
	 */
	public List<BoardDTO> selectBoardList(Map<String, Object> map);

	/**
	 * 게시판 정보 데이터 갯수 조회
	 * @param eDTO 조회조건
	 * @return 데이터 갯수
	 */
	public int selectBoardCount(BoardDTO eDTO);
	public int selectTodayBoardCount();
	

	/**
	 * 게시판 정보 생성
	 * @param eDTO 생성할 데이터
	 * @return 입력 데이터 개수 (selectKey 를 사용하여 key 를 딴 경우 입력 DTO에 해당 key 사용)
	 * @throws Exception
	 */
	public int insertBoard(BoardDTO eDTO) throws Exception;
	
	public BoardDTO selectBoard(String boardIdx);
	public void updateHit(String boardIdx);

	/**
	 * 게시판 정보 수정
	 * @param eDTO 수정할 데이터
	 * @return 성공여부 (수정된 데이터 개수)
	 * @throws Exception
	 */
	public void updateBoard(BoardDTO boardDTO);

	/**
	 * 게시판 정보 삭제
	 * @param eDTO 삭제할 데이터 키값
	 * @return 성공여부 (삭제된 데이터 개수)
	 * @throws Exception
	 */
	public int deleteBoard(String boardIdx);
	
	public int selectFindCount(Map<String, Object> map);
	public int selectFindCountAll(Map<String, Object> map);
	
	public List<BoardDTO> selectFindList(Map<String, Object> map);
	public List<BoardDTO> selectFindListAll(Map<String, Object> map);
	
	public BoardDTO selectBoardByRn(int rn);

}