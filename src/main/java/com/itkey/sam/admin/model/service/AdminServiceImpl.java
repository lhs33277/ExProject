package com.itkey.sam.admin.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.itkey.sam.admin.model.dao.AdminDAO;
import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.model.dao.BoardDAO;
import com.itkey.sam.boardWriter.dto.BoardWriterDTO;
import com.itkey.sam.boardWriter.model.dao.BoardWriterDAO;
import com.itkey.sam.boardWriter.util.PageUtils;
import com.itkey.sam.file.model.dao.FileDAO;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	
	@Resource(name="boardDAO") BoardDAO dao;
	@Resource(name="fileDAO") FileDAO fileDAO;
	@Resource(name="boardWriterDAO") BoardWriterDAO boardWriterDAO;
	@Resource(name="adminDAO") AdminDAO adminDAO;
	
	@Override
	public void findMemberList(Model model, HttpServletRequest request) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		int totalRecord = boardWriterDAO.selectMemberCount();
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("recordPerPage", pageUtils.getRecordPerPage());
		
		List<BoardWriterDTO> members = adminDAO.selectMemberList(map);
		
		model.addAttribute("members", members);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("paging", pageUtils.getPaging1(request.getContextPath() + "/manageMember.do"));
	}
	
	@Override
	public Map<String, Object> removeMember(String boardWriterIdx) {
		adminDAO.deleteMembers(boardWriterIdx);
		return null;
	}
	
	@Override
	public void manageSearch(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		String column = request.getParameter("column");
		String query = request.getParameter("query");

		if(column.equals("all")) {
			Map<String, Object> map = new HashMap<>();
			map.put("column", column);
			map.put("query", query);
			
			int findRecord = adminDAO.selectFindCountAllManage(map);
			
			PageUtils pageUtils = new PageUtils();
			pageUtils.setPageEntity(findRecord, page);
			
			map.put("beginRecord", pageUtils.getBeginRecord());
			map.put("recordPerPage", pageUtils.getRecordPerPage());
			
			List<BoardWriterDTO> members = adminDAO.selectFindListAllManage(map);
			
			model.addAttribute("members", members);
			model.addAttribute("totalRecord", findRecord);
			model.addAttribute("paging", pageUtils.getPaging1(request.getContextPath() + "/manageSearch.do?column=" + column + "&query=" + query));
		} 
		else 
		{
			Map<String, Object> map = new HashMap<>();
			map.put("column", column);
			map.put("query", query);
			
			int findRecord = adminDAO.selectFindCountManage(map);
			
			PageUtils pageUtils = new PageUtils();
			pageUtils.setPageEntity(findRecord, page);
			
			map.put("beginRecord", pageUtils.getBeginRecord());
			map.put("recordPerPage", pageUtils.getRecordPerPage());
			
			List<BoardWriterDTO> members = adminDAO.selectFindListManage(map);
			
			model.addAttribute("members", members);
			model.addAttribute("totalRecord", findRecord);
			model.addAttribute("paging", pageUtils.getPaging1(request.getContextPath() + "/manageSearch.do?column=" + column + "&query=" + query));
			
		}
		
	}

}
