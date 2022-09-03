package com.itkey.sam.boardWriter.model.service;

import java.io.File;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.boardWriter.dto.BoardWriterDTO;
import com.itkey.sam.boardWriter.model.dao.BoardWriterDAO;
import com.itkey.sam.boardWriter.util.MyFileUtils;
import com.itkey.sam.boardWriter.util.SecurityUtils;
import com.itkey.sam.file.dto.FileDTO;
import com.itkey.sam.file.model.dao.FileDAO;

@Service("boardWriterService")
public class BoardWriterServiceImpl implements BoardWriterService {

	@Resource(name="boardWriterDAO") BoardWriterDAO dao;
	@Resource(name="fileDAO") FileDAO fileDAO;
	
	// PPT 2번
	
	@Override
	public void signUp2(MultipartHttpServletRequest request) {
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
		String salt = SecurityUtils.getSalt();
		String boardWriter = request.getParameter("boardWriter");
		String boardWriterName = request.getParameter("boardWriterName");
		String boardWriterPw = SecurityUtils.sha256(request.getParameter("boardWriterPw") + salt);
		String boardWriterPhone = request.getParameter("boardWriterPhone");
		String boardWriterEmail = request.getParameter("boardWriterEmail");
		
		BoardWriterDTO boardWriterDTO = new BoardWriterDTO();
		boardWriterDTO.setBoardWriter(boardWriter);
		boardWriterDTO.setBoardWriterName(boardWriterName);
		boardWriterDTO.setBoardWriterPw(boardWriterPw);
		boardWriterDTO.setBoardWriterPhone(boardWriterPhone);
		boardWriterDTO.setBoardWriterEmail(boardWriterEmail);
		boardWriterDTO.setFileIdx(fileIdx);
		boardWriterDTO.setSalt(salt);
		
		dao.insertBoardWriter(boardWriterDTO);
		
	}
		
	@Override
	public Map<String, Object> logIn2(HttpServletRequest request, HttpSession session) {
		String boardWriter = request.getParameter("boardWriter");
		Optional<String> opt = Optional.ofNullable(dao.selectSaltById(boardWriter));
		String salt = opt.orElse("zz");
		String boardWriterPw = SecurityUtils.sha256(request.getParameter("boardWriterPw") + salt);
		
		
		BoardWriterDTO boardWriterDTO = new BoardWriterDTO();
		boardWriterDTO.setBoardWriter(boardWriter);
		boardWriterDTO.setBoardWriterPw(boardWriterPw);
		
		BoardWriterDTO loginMember = dao.selectBoardWriterByIdPw(boardWriterDTO);
		
		
		session.setAttribute("loginMember", loginMember);
		
		Map<String, Object> map = new HashMap<>();
		map.put("loginMember", loginMember);
		return map;
	}
	
	@Override
	public void modifyMember2(MultipartHttpServletRequest request, HttpSession session) {
		
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
		
		BoardWriterDTO loginMember = new BoardWriterDTO();
		loginMember = (BoardWriterDTO)session.getAttribute("loginMember");
		
		String salt = SecurityUtils.getSalt();
		String boardWriter = loginMember.getBoardWriter();
		String boardWriterName = request.getParameter("boardWriterName");
		String boardWriterPw = SecurityUtils.sha256(request.getParameter("boardWriterPw") + salt);
		String boardWriterPhone = request.getParameter("boardWriterPhone");
		String boardWriterEmail = request.getParameter("boardWriterEmail");
		
		BoardWriterDTO boardWriterDTO = new BoardWriterDTO();
		boardWriterDTO.setBoardWriter(boardWriter);
		boardWriterDTO.setBoardWriterName(boardWriterName);
		boardWriterDTO.setBoardWriterPw(boardWriterPw);
		boardWriterDTO.setBoardWriterPhone(boardWriterPhone);
		boardWriterDTO.setBoardWriterEmail(boardWriterEmail);
		boardWriterDTO.setFileIdx(fileIdx);
		boardWriterDTO.setSalt(salt);
		
		dao.updateMember(boardWriterDTO);
		
		session.setAttribute("loginMember", boardWriterDTO);
	}
	
	
	
	
	
	
	
	
	
	
	// PPT 1번
	
	@Override
	public void signUp(MultipartHttpServletRequest request) {
		
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
		String salt = SecurityUtils.getSalt();
		String boardWriter = request.getParameter("boardWriter");
		String boardWriterName = request.getParameter("boardWriterName");
		String boardWriterPw = SecurityUtils.sha256(request.getParameter("boardWriterPw") + salt);
		String boardWriterPhone = request.getParameter("boardWriterPhone");
		String boardWriterEmail = request.getParameter("boardWriterEmail");
		
		BoardWriterDTO boardWriterDTO = new BoardWriterDTO();
		boardWriterDTO.setBoardWriter(boardWriter);
		boardWriterDTO.setBoardWriterName(boardWriterName);
		boardWriterDTO.setBoardWriterPw(boardWriterPw);
		boardWriterDTO.setBoardWriterPhone(boardWriterPhone);
		boardWriterDTO.setBoardWriterEmail(boardWriterEmail);
		boardWriterDTO.setFileIdx(fileIdx);
		boardWriterDTO.setSalt(salt);
		
		dao.insertBoardWriter(boardWriterDTO);
		
	}
	
	
	@Override
	public BoardWriterDTO logIn(HttpServletRequest request, HttpServletResponse response) {
		
	
		String boardWriter = request.getParameter("boardWriter");
		Optional<String> opt = Optional.ofNullable(dao.selectSaltById(boardWriter));
		String salt = opt.orElse("zz");
		String boardWriterPw = SecurityUtils.sha256(request.getParameter("boardWriterPw") + salt);
		
		
		BoardWriterDTO boardWriterDTO = new BoardWriterDTO();
		boardWriterDTO.setBoardWriter(boardWriter);
		boardWriterDTO.setBoardWriterPw(boardWriterPw);
		
		BoardWriterDTO loginMember = dao.selectBoardWriterByIdPw(boardWriterDTO);
		System.out.println("ㅇㅇ" + dao.selectBoardWriterByIdPw(boardWriterDTO));
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			if(loginMember == null) {
				out.println("<script>");
				out.println("alert('회원 정보가 없습니다.')");
				out.println("location.href='" + request.getContextPath() + "'");
				out.println("</script>");
				out.close();
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return loginMember;
		
		
	}
	
	@Override
	public Map<String, Object> idCheck(String boardWriter) {
		return dao.selectBoardWriterById(boardWriter);
	}
	
	public Map<String, Object> getMemberCount() {
		Map<String, Object> map = new HashMap<>();
		map.put("result", dao.selectMemberCount());
		return map;
	}
	
	@Override
	public Map<String, Object> getTodayMemberCount() {
		Map<String, Object> map = new HashMap<>();
		map.put("result", dao.selectTodayMemberCount());
		return map;
	}
	
	@Override
	public BoardWriterDTO modifyMember(MultipartHttpServletRequest request, HttpSession session) {
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
		
		BoardWriterDTO sessionBoardWriter = (BoardWriterDTO)session.getAttribute("loginMember");
		
		String salt = SecurityUtils.getSalt();
		String boardWriter = sessionBoardWriter.getBoardWriter();
		String boardWriterName = request.getParameter("boardWriterName");
		String boardWriterPw = SecurityUtils.sha256(request.getParameter("boardWriterPw") + salt);
		String boardWriterPhone = request.getParameter("boardWriterPhone");
		String boardWriterEmail = request.getParameter("boardWriterEmail");
		
		
		BoardWriterDTO boardWriterDTO = new BoardWriterDTO();
		boardWriterDTO.setBoardWriter(boardWriter);
		boardWriterDTO.setBoardWriterName(boardWriterName);
		boardWriterDTO.setBoardWriterPw(boardWriterPw);
		boardWriterDTO.setBoardWriterPhone(boardWriterPhone);
		boardWriterDTO.setBoardWriterEmail(boardWriterEmail);
		boardWriterDTO.setFileIdx(fileIdx);
		boardWriterDTO.setSalt(salt);
		
		dao.updateMember(boardWriterDTO);
		
		return boardWriterDTO;
	}
	
	@Override
	public void leave(String boardWriter) {
		dao.deleteMember(boardWriter);
		
	}
}
