package com.itkey.sam.admin.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itkey.sam.admin.model.service.AdminService;
import com.itkey.sam.board.model.service.BoardService;
import com.itkey.sam.boardWriter.model.service.BoardWriterService;

@Controller
public class AdminController {
	
	@Autowired BoardService boardService;
	@Autowired BoardWriterService boardWriterService;
	@Autowired AdminService adminService;

	@ResponseBody
	@PutMapping(value="/boards/{boardIdx}", produces="application/json")
	public Map<String, Object> removeBoard(@PathVariable String boardIdx){
		return boardService.removeBoard(boardIdx);
	}
	
	@GetMapping("/removeOne.do")
	public String removeOne(@RequestParam String boardIdx) {
		boardService.removeBoard(boardIdx);
		return "redirect:/list.do";
	}
	
	@GetMapping("/manageMember.do")
	public String manageMemberPage(Model model, HttpServletRequest request) {
		adminService.findMemberList(model, request);
		return "manageMember";
	}
	
	@ResponseBody
	@PutMapping(value="/members/{boardWriterIdx}", produces="application/json")
	public Map<String, Object> removeMember(@PathVariable String boardWriterIdx){
		return adminService.removeMember(boardWriterIdx);
	}
	
	@GetMapping("/removeMemberOne.do")
	public String removeMemberOne(@RequestParam String boardWriterIdx) {
		adminService.removeMember(boardWriterIdx);
		return null;
	}
	
	@GetMapping("/manageSearch.do")
	public String manageSearch(HttpServletRequest request, Model model) {
		adminService.manageSearch(request, model);
		return "manageMember";
	}
	
}
