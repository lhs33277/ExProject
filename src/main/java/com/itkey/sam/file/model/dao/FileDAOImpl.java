package com.itkey.sam.file.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.file.dto.FileDTO;

@Repository("fileDAO")
public class FileDAOImpl implements FileDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertFile(FileDTO fileDTO) {
		return sqlSession.insert("insertFile", fileDTO);
	}
	
	@Override
	public String selectFileIdxBySaved(String saved) {
		return sqlSession.selectOne("selectFileIdxBySaved", saved);
	}

}
