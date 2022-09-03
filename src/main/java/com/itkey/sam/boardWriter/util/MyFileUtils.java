package com.itkey.sam.boardWriter.util;

import java.io.File;
import java.util.UUID;
import java.util.regex.Matcher;

public class MyFileUtils {
	public static String getUuidName(String fileName) {
		String extension;
		if(fileName.endsWith("tar.gz")) {
			extension = "tar.gz";
		} else if(fileName.endsWith("tar.bz2")) {
			extension = "tar.bz2";
		} else {
			String[] arr = fileName.split("\\.");
			extension = fileName.split("\\.")[arr.length - 1];
		}
		
		return UUID.randomUUID().toString().replaceAll("\\-", "") + "." + extension;
	}
	
	public static String getPath() {
		String sep = Matcher.quoteReplacement(File.separator);
		return "C:" + sep + "upload" + sep + "upload2";
	}
}
