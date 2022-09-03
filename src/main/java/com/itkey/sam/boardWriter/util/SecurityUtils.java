package com.itkey.sam.boardWriter.util;

import java.security.MessageDigest;
import java.util.Random;

import org.apache.commons.codec.binary.Base64;

public class SecurityUtils {
	
	public static String getSalt() {
	     Random random = new Random();     
	     byte[] salt = new byte[10];

	     random.nextBytes(salt);     

	     StringBuffer sb = new StringBuffer();

	     for(int i=0; i<salt.length; i++) {
	     	sb.append(String.format("%02x", salt[i]));
	     }     

	     return sb.toString();
	  }
	
	public static String sha256(String password) {
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("SHA-256");
			md.update(password.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		// md.digest() : 입력된 비밀번호가 암호화되어있는 32바이트 크기의 배열
		byte[] bytes = md.digest();
		StringBuilder sb = new StringBuilder();
		for(byte b : bytes) {
			sb.append(String.format("%02X", b));  // %X : 대문자로 표시한 16진수, 02 : 2자리로 나타냄
		}
		return sb.toString();
	}
	
	
	// 암호화
	public static String encodeBase64(String str) {
		return new String(Base64.encodeBase64(str.getBytes()));
	}
	
	// 복호화
	public static String decodeBase64(String str) {
		return new String(Base64.decodeBase64(str.getBytes()));
	}

}
