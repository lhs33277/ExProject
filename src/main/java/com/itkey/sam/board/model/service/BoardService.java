package com.itkey.sam.board.model.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itkey.sam.board.dto.BoardDTO;

/**
 * Service for SAMPLE_BOARD_TB table : 게시판 정보
**/
public interface BoardService {
	
	// PPT 2번
	public Map<String, Object> getBoardList2(HttpServletRequest request, Model model);
	public Map<String, Object> addBoard2(MultipartHttpServletRequest request, HttpSession session);
	
	
	
	
	// PPT 1번

	/**
	 * 게시판 정보 조회
	 * @param eDTO 조회 조건
	 * @return 결과 목록
	 */
	public void getBoardList(Model model, HttpServletRequest request);

	
	/**
	 * 게시판 정보 데이터 갯수 조회
	 * @param eDTO 조회 조건
	 * @return  데이터 갯수
	 */
	public Map<String, Object> getBoardCount(BoardDTO eDTO) throws Exception;
	public Map<String, Object> getTodayBoardCount();
	
	public BoardDTO findBoard(String boardIdx);
	

	/**
	 * 게시판 정보 추가
	 * @param eDTO 생성할 데이터
	 * @return 입력 데이터 개수 (selectKey 를 사용하여 key 를 딴 경우 입력 DTO에 해당 key 사용)
	 * @throws Exception
	 */
	public int addBoard(MultipartHttpServletRequest request, HttpSession session) throws Exception;

	/**
	 * 게시판 정보 수정
	 * @param eDTO 수정할 데이터
	 * @return 성공여부 (수정된 데이터 개수)
	 * @throws Exception
	 */
	public void chgBoard(MultipartHttpServletRequest request);

	/**
	 * 게시판 정보 삭제
	 * @param eDTO 삭제할 데이터 키값
	 * @return 성공여부 (삭제된 데이터 개수)
	 * @throws Exception
	 */
	public int delBoard(String boardIdx);
	
	public void search(HttpServletRequest request, Model model);
	
	public Map<String, Object> removeBoard(String boardIdx);
	
	public BoardDTO findPrevBoard(int rn);
	public BoardDTO findNextBoard(int rn);
}
