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
			System.out.println(e + "例外が発生しました");
		}
	}

	public void createNewFolder(String dirname) {
		try {
			File f = new File(dirname);
			f.mkdir();
		} catch(Exception e) {
			System.out.println(e + "例外が発生しました");
		}
	}

	public void createNewFolderTree(String dirname) {
		try {
			File f = new File(dirname);
			f.mkdirs();
		} catch(Exception e) {
			System.out.println(e + "例外が発生しました");
		}
	}

	public void fileExistCheck(String filename) {
		try {
			File f = new File(filename);
			if (f.exists()) {
				System.out.println(filename + " は存在します");
			} else {
				System.out.println(filename + " は存在しません");
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
			System.out.println(e + "書き込みに失敗しました");
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
			System.out.println(e + "読み込みに失敗しました");
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
