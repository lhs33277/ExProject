package com.itkey.sam.boardWriter.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itkey.sam.boardWriter.dto.BoardWriterDTO;
import com.itkey.sam.boardWriter.model.service.BoardWriterService;

@Controller
public class BoardWriterController {
	
	@Autowired
	BoardWriterService boardWriterService;
	
	
	// PPT 2번
	
	
	@GetMapping("/ajax/logOut.do")
	public String logOut2(HttpSession session) {
		session.removeAttribute("loginMember");
		return "redirect:/";
	}
	
	@ResponseBody
	@PostMapping(value="/ajax/signUp.do", produces="application/json")
	public void signUp2(MultipartHttpServletRequest request) {
		boardWriterService.signUp2(request);
	}
	
	@ResponseBody
	@PostMapping(value="/ajax/logIn.do", produces="application/json")
	public Map<String, Object> logIn2(HttpServletRequest request, HttpSession session) {
		return boardWriterService.logIn2(request, session);
	}
	
	@PostMapping(value="/ajax/modify.do", produces="application/json")
	public void modify2(MultipartHttpServletRequest request, HttpSession session) {
		boardWriterService.modifyMember2(request, session);
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// PPT 1번
	
	
	@GetMapping("/registerPage.do")
	public String Register() {
		return "register";
	}
	
	@GetMapping("/loginPage.do")
	public String loginPage() {
		return "login";
	}
	
	@PostMapping("/signUp.do")
	public String signIn(MultipartHttpServletRequest request) {
		boardWriterService.signUp(request);
		return "login";
	}
	
	@PostMapping("/login.do")
	public String login(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		BoardWriterDTO loginMember =  boardWriterService.logIn(request, response);
		if(loginMember != null) {
			session.setAttribute("loginMember", loginMember);
		}
		return "redirect:/list.do";
	}
	
	@GetMapping("/boardPage.do")
	public String boardPage() {
		return "board";
	}
	
	@ResponseBody
	@GetMapping("/idCheck.do")
	public Map<String, Object> idCheck(@RequestParam String boardWriter) {
		return boardWriterService.idCheck(boardWriter);
	}
	
	@ResponseBody
	@GetMapping("/memberCount.do")
	public Map<String, Object> memberCount(){
		return boardWriterService.getMemberCount();
	}
	
	@ResponseBody
	@GetMapping("/todayMemberCount.do")
	public Map<String, Object> todayMemberCount(){
		return boardWriterService.getTodayMemberCount();
	}
	
	@GetMapping("/memberModifyPage.do")
	public String memberModifyPage() {
		return "memberModify";
	}
	
	@PostMapping("memberModify.do")
	public String memberModify(MultipartHttpServletRequest request, HttpSession session) {
		BoardWriterDTO loginMember = boardWriterService.modifyMember(request, session);
		if(loginMember != null) {
			session.setAttribute("loginMember", loginMember);
		}
		return "redirect:/list.do";
	}
	
	@GetMapping("/leave.do")
	public String leave(HttpSession session) {
		BoardWriterDTO loginMember = (BoardWriterDTO)session.getAttribute("loginMember");
		String boardWriter = loginMember.getBoardWriter();
		boardWriterService.leave(boardWriter);
		session.removeAttribute("loginMember");
		return "login";
	}
	
	@GetMapping("/logOut.do")
	public String logOut(HttpSession session) {
		session.removeAttribute("loginMember");
		return "login";
	}
	
	
	
	
	
	
	

}
