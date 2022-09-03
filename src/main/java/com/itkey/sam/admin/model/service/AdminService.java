package com.itkey.sam.admin.model.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.itkey.sam.boardWriter.dto.BoardWriterDTO;

public interface AdminService {
	public void findMemberList(Model model, HttpServletRequest request);
	
	public Map<String, Object> removeMember(String boardWriterIdx);

	public void manageSearch(HttpServletRequest request, Model model);
}
