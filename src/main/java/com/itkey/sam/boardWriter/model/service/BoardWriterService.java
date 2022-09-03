package com.itkey.sam.boardWriter.model.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itkey.sam.boardWriter.dto.BoardWriterDTO;

public interface BoardWriterService {
	
	// PPT 2번
	public void signUp2(MultipartHttpServletRequest request);
	public Map<String, Object> logIn2(HttpServletRequest request, HttpSession session);
	public void modifyMember2(MultipartHttpServletRequest request, HttpSession session);
	
	
	// PPT 1번
	public void signUp(MultipartHttpServletRequest request);
	public BoardWriterDTO logIn(HttpServletRequest request, HttpServletResponse response);
	public Map<String, Object> idCheck(String boardWriter);
	public Map<String, Object> getMemberCount();
	public Map<String, Object> getTodayMemberCount();
	public BoardWriterDTO modifyMember(MultipartHttpServletRequest request, HttpSession session);
	public void leave(String boardWriter);

}