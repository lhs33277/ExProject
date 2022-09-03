package com.itkey.sam.file.model.dao;

import com.itkey.sam.file.dto.FileDTO;

public interface FileDAO {
	public int insertFile(FileDTO fileDTO);
	public String selectFileIdxBySaved(String saved);
}
