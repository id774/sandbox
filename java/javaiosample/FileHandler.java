// FileHandler.java: File and directory operations for the I/O sample
//
// Description:
// Provide file and directory helpers for the Java I/O sample, which print the
// current directory, create files and directories, check existence, write and
// read a text file, and list a directory. JavaIOSampleMain.java uses this
// class. The source is encoded in Shift_JIS.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//

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

	public void putTextFile(String filename, String text) {
		try {
			FileWriter fw = new FileWriter(filename);
			fw.write(text);
			fw.close();
		} catch (IOException e) {
			System.out.println(e + "èëÇ´çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩ");
		}
	}

	public void readTextFile(String filename) {
		try {
			BufferedReader br = new BufferedReader(new FileReader(filename));
			String line ="";
			while ((line = br.readLine()) != null) {
				System.out.println(line);
			}
			br.close();
		} catch (IOException e) {
			System.out.println(e + "ì«Ç›çûÇ›Ç…é∏îsÇµÇ‹ÇµÇΩ");
		}
	}

	public void getListDir(String filename) {
		File fl = new File(filename);
		String[] arry = fl.list();
		for(int i = 0; i < arry.length; i++) {
			System.out.println(arry[i]);
		}
	}
}
