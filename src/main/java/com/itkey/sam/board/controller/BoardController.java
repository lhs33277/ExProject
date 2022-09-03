package com.itkey.sam.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.model.service.BoardService;
import com.itkey.sam.boardWriter.dto.BoardWriterDTO;
import com.itkey.sam.boardWriter.model.service.BoardWriterService;

@Controller
public class BoardController {
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// Dependency Injection With BoardService
	@Autowired BoardService boardService;
	
	// PPT 2번
	@ResponseBody
	@GetMapping(value="/ajax/list.do", produces="application/json")
	public Map<String, Object> list2(HttpServletRequest request, Model model) {
		return boardService.getBoardList2(request, model);
	}
	
	@ResponseBody
	@PostMapping(value="/ajax/add.do")
	public Map<String, Object> add2(MultipartHttpServletRequest request, HttpSession session) {
		return boardService.addBoard2(request, session);
	}

	// PPT 1번

	@RequestMapping(value = "/list.do")
	public String list(Model model, HttpServletRequest request) {
		request.getSession().removeAttribute("board");
		boardService.getBoardList(model, request);
		return "board";
	}
	
	@ResponseBody
	@GetMapping("/boardCount.do")
	public Map<String, Object> boardCount() throws Exception {
		BoardDTO eDTO = new BoardDTO();
		return boardService.getBoardCount(eDTO);
	}
	
	@ResponseBody
	@GetMapping("/todayBoardCount.do")
	public Map<String, Object> todayBoardCount() {
		return boardService.getTodayBoardCount();
	}
	
	@GetMapping("/writePage.do")
	public String writePage() {
		return "write";
	}
	
	@PostMapping("/add.do")
	public String add(MultipartHttpServletRequest request, HttpSession session) throws Exception {

		boardService.addBoard(request, session);
		return "redirect:/list.do";
	}
	
	@GetMapping("/detail.do")
	public String detail(@RequestParam String boardIdx, @RequestParam int rn, Model model) {
		model.addAttribute("board", boardService.findBoard(boardIdx));
		model.addAttribute("prevBoard", boardService.findPrevBoard(rn));
		model.addAttribute("nextBoard", boardService.findNextBoard(rn));
		return "detail";
	}
	
	@GetMapping("/changePage.do")
	public String changePage(@RequestParam String boardIdx, @RequestParam String boardWriter, Model model) {
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoardIdx(boardIdx);
		boardDTO.setBoardWriter(boardWriter);
		model.addAttribute("board", boardDTO);
		return "change";
	}
	
	@PostMapping("/change.do")
	public String change(MultipartHttpServletRequest request) {
		boardService.chgBoard(request);
		return "redirect:/list.do";
	}
	
	@GetMapping("/remove.do")
	public String remove(@RequestParam String boardIdx) {
		boardService.delBoard(boardIdx);
		return "redirect:/list.do";
	}
	
	@GetMapping("/search.do")
	public String search(HttpServletRequest request, Model model) {
		boardService.search(request, model);
		return "board";
	}
	
	@GetMapping("/prevBoard.do")
	public String prevBoard(@RequestParam int rn, Model model) {
		model.addAttribute("board", boardService.findPrevBoard(rn));
		model.addAttribute("prevBoard", boardService.findPrevBoard(rn-1));
		model.addAttribute("nextBoard", boardService.findNextBoard(rn-1));
		return "detail";
	}
	
	@GetMapping("/nextBoard.do")
	public String nextBoard(@RequestParam int rn, Model model) {
		model.addAttribute("board", boardService.findNextBoard(rn));
		model.addAttribute("prevBoard", boardService.findPrevBoard(rn+1));
		model.addAttribute("nextBoard", boardService.findNextBoard(rn+1));
		return "detail";
	}
	
}
