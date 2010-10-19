package javaiosample;

public class JavaIOSampleMain {
	public static void main(String[] args) {
		FileHandler f = new FileHandler();

		String filename = "newfile.txt";
		String dirname = ".";

		f.createNewFile(filename);
		f.createNewFolder("newfolder");
		f.createNewFolderTree("newfoldertree");
		f.fileExistCheck(filename);
		f.printCurrentDir();
		f.putTextFile(filename, "‚Ù‚°‚Ù‚°");
		f.readTextFile(filename);
		f.getListDir(dirname);
	}
}
