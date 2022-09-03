package com.itkey.sam.board.model.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.model.dao.BoardDAO;
import com.itkey.sam.boardWriter.dto.BoardWriterDTO;
import com.itkey.sam.boardWriter.util.MyFileUtils;
import com.itkey.sam.boardWriter.util.PageUtils;
import com.itkey.sam.boardWriter.util.PageUtils2;
import com.itkey.sam.file.dto.FileDTO;
import com.itkey.sam.file.model.dao.FileDAO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/* 
	 * Follow can be used for DI
	 * @Autowired BoardDAO dao;
	 */
	
	// Dependency Injection With BoardDAO
	@Resource(name="boardDAO") BoardDAO dao;
	@Resource(name="fileDAO") FileDAO fileDAO;
	
	
	// PPT 2번
	@Override
	public Map<String, Object> getBoardList2(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		BoardDTO eDTO = new BoardDTO();
		int totalRecord = dao.selectBoardCount(eDTO);
		
		PageUtils2 pageUtils = new PageUtils2();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("recordPerPage", pageUtils.getRecordPerPage());
		map.put("endRecord", pageUtils.getEndRecord());
		
		
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("boards", dao.selectBoardList(map));
		map2.put("p", pageUtils);
		
		
		return map2;
	}
		
	
	
	@Override
	public Map<String, Object> addBoard2(MultipartHttpServletRequest request, HttpSession session) {
		
		MultipartFile file = request.getFile("up");
		String fileIdx = null;
		try {
			
			if(file != null && file.isEmpty() == false) {
				
				String origin = file.getOriginalFilename();
				origin = origin.substring(origin.lastIndexOf("\\") + 1);
				
				String saved = MyFileUtils.getUuidName(origin);
				
				String path = MyFileUtils.getPath();
				
				File dir = new File(path);
				if(dir.exists() == false) {
					dir.mkdirs();
				}
				
				File file2 = new File(dir, saved);
				
				
				
					
					file.transferTo(file2);
					
					FileDTO fileDTO = new FileDTO();
					fileDTO.setFileOriginalName(origin);
					fileDTO.setFileChangedName(saved);
					fileDTO.setFilePath(path);
					
					fileDAO.insertFile(fileDTO);
					fileIdx = fileDAO.selectFileIdxBySaved(saved);
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		BoardWriterDTO boardWriterDTO = (BoardWriterDTO)session.getAttribute("loginMember");
		String boardWriter = boardWriterDTO.getBoardWriter();
		String boardTitle = request.getParameter("boardTitle");
		String boardContents = request.getParameter("boardContents");
		String boardPublicFl = request.getParameter("boardPublicFl");

		BoardDTO board = new BoardDTO();
		board.setBoardWriter(boardWriter);
		board.setBoardTitle(boardTitle);
		board.setBoardContents(boardContents);
		board.setBoardPublicFl(boardPublicFl);
		board.setFileIdx(fileIdx);
		board.setBoardViewCount(0);
		
		Map<String, Object> map = new HashMap<>();
		map.put("res", dao.insertBoard2(board));
		
		return map;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	// PPT 1번

	public void getBoardList(Model model, HttpServletRequest request){
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		BoardDTO eDTO = new BoardDTO();
		int totalRecord = dao.selectBoardCount(eDTO);
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("recordPerPage", pageUtils.getRecordPerPage());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<BoardDTO> boards = dao.selectBoardList(map);
		
		model.addAttribute("boards", boards);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("paging", pageUtils.getPaging1(request.getContextPath() + "/list.do"));
		
	};
	
	public Map<String, Object> getBoardCount(BoardDTO eDTO) throws Exception {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + eDTO.toString());
		int result = (Integer)dao.selectBoardCount(eDTO);
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + result);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	};
	
	@Override
	public Map<String, Object> getTodayBoardCount() {
		 Map<String, Object> map = new HashMap<>();
		 map.put("result", dao.selectTodayBoardCount());
		return map;
	}

	public int addBoard(MultipartHttpServletRequest request, HttpSession session) throws Exception {
		
		MultipartFile file = request.getFile("up");
		String fileIdx = null;
		try {
			
			if(file != null && file.isEmpty() == false) {
				
				String origin = file.getOriginalFilename();
				origin = origin.substring(origin.lastIndexOf("\\") + 1);
				
				String saved = MyFileUtils.getUuidName(origin);
				
				String path = MyFileUtils.getPath();
				
				File dir = new File(path);
				if(dir.exists() == false) {
					dir.mkdirs();
				}
				
				File file2 = new File(dir, saved);
				
				
				
					
					file.transferTo(file2);
					
					FileDTO fileDTO = new FileDTO();
					fileDTO.setFileOriginalName(origin);
					fileDTO.setFileChangedName(saved);
					fileDTO.setFilePath(path);
					
					fileDAO.insertFile(fileDTO);
					fileIdx = fileDAO.selectFileIdxBySaved(saved);
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		String boardTitle = request.getParameter("boardTitle");
		BoardWriterDTO boardWriterDTO = (BoardWriterDTO)session.getAttribute("loginMember");
		String boardWriter = boardWriterDTO.getBoardWriter();
		String boardContents = request.getParameter("boardContents");
		String boardPublicFl = request.getParameter("boardPublicFi");
		
		BoardDTO eDTO = new BoardDTO();
		eDTO.setBoardWriter(boardWriter);
		eDTO.setBoardTitle(boardTitle);
		eDTO.setBoardContents(boardContents);
		eDTO.setBoardViewCount(0);
		eDTO.setBoardPublicFl(boardPublicFl);
		eDTO.setFileIdx(fileIdx);
		
		
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + eDTO.toString());
		int result = dao.insertBoard(eDTO);
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + result);
		return result;
	};
	
	@Override
	public BoardDTO findBoard(String boardIdx) {
		dao.updateHit(boardIdx);
		return dao.selectBoard(boardIdx);
	}

	public void chgBoard(MultipartHttpServletRequest request){
		MultipartFile file = request.getFile("up");
		String fileIdx = null;
		try {
			
			if(file != null && file.isEmpty() == false) {
				
				String origin = file.getOriginalFilename();
				origin = origin.substring(origin.lastIndexOf("\\") + 1);
				
				String saved = MyFileUtils.getUuidName(origin);
				
				String path = MyFileUtils.getPath();
				
				File dir = new File(path);
				if(dir.exists() == false) {
					dir.mkdirs();
				}
				
				File file2 = new File(dir, saved);
				
				
				
					
					file.transferTo(file2);
					
					FileDTO fileDTO = new FileDTO();
					fileDTO.setFileOriginalName(origin);
					fileDTO.setFileChangedName(saved);
					fileDTO.setFilePath(path);
					
					fileDAO.insertFile(fileDTO);
					fileIdx = fileDAO.selectFileIdxBySaved(saved);
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		String boardIdx = request.getParameter("boardIdx");
		String boardTitle = request.getParameter("boardTitle");
		String boardContents = request.getParameter("boardContents");
		
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoardIdx(boardIdx);
		boardDTO.setBoardTitle(boardTitle);
		boardDTO.setBoardContents(boardContents);
		boardDTO.setFileIdx(fileIdx);
		
		dao.updateBoard(boardDTO);
		

	};

	public int delBoard(String boardIdx) {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + boardIdx);
		int result = dao.deleteBoard(boardIdx);
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + result);
		return result;
	};
	
	@Override
	public void search(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		
		if(column.equals("all")) {
			Map<String, Object> map = new HashMap<>();
			map.put("column", column);
			map.put("query", query);
			
			int findRecord = dao.selectFindCountAll(map);
			
			PageUtils pageUtils = new PageUtils();
			pageUtils.setPageEntity(findRecord, page);
			
			map.put("beginRecord", pageUtils.getBeginRecord());
			map.put("recordPerPage", pageUtils.getRecordPerPage());
			map.put("endRecord", pageUtils.getEndRecord());
			
			List<BoardDTO> boards = dao.selectFindListAll(map);
			
			model.addAttribute("boards", boards);
			model.addAttribute("totalRecord", findRecord);
			model.addAttribute("paging", pageUtils.getPaging1(request.getContextPath() + "/search.do?column=" + column + "&query=" + query));
		} 
		else 
		{
			Map<String, Object> map = new HashMap<>();
			map.put("column", column);
			map.put("query", query);
			
			int findRecord = dao.selectFindCount(map);
			
			PageUtils pageUtils = new PageUtils();
			pageUtils.setPageEntity(findRecord, page);
			
			map.put("beginRecord", pageUtils.getBeginRecord());
			map.put("recordPerPage", pageUtils.getRecordPerPage());
			map.put("endRecord", pageUtils.getEndRecord());
			
			List<BoardDTO> boards = dao.selectFindList(map);
			
			model.addAttribute("boards", boards);
			model.addAttribute("totalRecord", findRecord);
			model.addAttribute("paging", pageUtils.getPaging1(request.getContextPath() + "/search.do?column=" + column + "&query=" + query));
			
		}
		
		
	}
	
	@Override
	public Map<String, Object> removeBoard(String boardIdx) {
		Map<String, Object> map = new HashMap<>();
		map.put("res", dao.deleteBoard(boardIdx));
		return null;
	}
	
	@Override
	public BoardDTO findPrevBoard(int rn) {
		rn = rn - 1;
		return dao.selectBoardByRn(rn);
	}
	
	@Override
	public BoardDTO findNextBoard(int rn) {
		rn = rn + 1;
		return dao.selectBoardByRn(rn);
	}
	
	

}