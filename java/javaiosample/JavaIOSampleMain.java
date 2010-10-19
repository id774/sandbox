package javaiosample;

public class JavaIOSampleMain {
	public static void main(String[] args) {
		FileHandler f = new FileHandler();
		f.createNewFile("newfile.txt");
		f.createNewFolder("newfolder");
		f.createNewFolderTree("newfoldertree");
		f.fileExistCheck("newfile.txt");
		f.printCurrentDir();
	}
}
