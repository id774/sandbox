// JavaIOSampleMain.java: Entry point of the Java I/O sample
//
// Description:
// Create newfile.txt, newfolder, and newfoldertree in the current directory,
// then check, write, and read the file and list the directory through
// FileHandler. The source is encoded in Shift_JIS.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     From the java directory:
//         javac -encoding Shift_JIS javaiosample/*.java
//         java javaiosample.JavaIOSampleMain
//
// Requirements:
// - A JDK
//

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
