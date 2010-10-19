package javaiosample;

import java.io.*;

public class FileHandler {
	public void printCurrentDir() {
		String sCurrentDir = new File(".").getAbsoluteFile().toString();
		System.out.println(sCurrentDir);
	}

	public void createNewFile(String filename) {
		try {
			File f = new File(filename);
			f.createNewFile();
		} catch(IOException e) {
			System.out.println(e + "ó·äOÇ™î≠ê∂ÇµÇ‹ÇµÇΩ");
		}
	}

	public void createNewFolder(String dirname) {
		try {
			File f = new File(dirname);
			f.mkdir();
		} catch(Exception e) {
			System.out.println(e + "ó·äOÇ™î≠ê∂ÇµÇ‹ÇµÇΩ");
		}
	}

	public void createNewFolderTree(String dirname) {
		try {
			File f = new File(dirname);
			f.mkdirs();
		} catch(Exception e) {
			System.out.println(e + "ó·äOÇ™î≠ê∂ÇµÇ‹ÇµÇΩ");
		}
	}

	public void fileExistCheck(String filename) {
		try {
			File f = new File(filename);
			if (f.exists()) {
				System.out.println(filename + " ÇÕë∂ç›ÇµÇ‹Ç∑");
			} else {
				System.out.println(filename + " ÇÕë∂ç›ÇµÇ‹ÇπÇÒ");
			}
		} finally {
		}
	}
}
