import java.io.File;
import java.io.IOException;

public class OutrosTestes {

	public static void main(String[] args) {
		
        // OS name
        final String operatingSystem = System.getProperty("os.name");

		try {
			if (operatingSystem.contains("Windows")) {
				Runtime.getRuntime().exec("cls");
			} else {
				Runtime.getRuntime().exec("clear");
			}
		} catch (Exception e) {

		} 
        System.out.println("Sistema Operacional: " + operatingSystem);
		
		// Temporary file
		try {
			File tmpFile = File.createTempFile("log-", ".txt");
			System.out.println("Meu Arquivo Temporario: " + tmpFile.getAbsolutePath());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// Get TMP dir
	    String property = "java.io.tmpdir";
	    String tempDir = System.getProperty(property);
        System.out.println("Diretório temporario neste sistema operacional " + tempDir + File.separator);
        
        // File and Directory check
        String fileName = "/tmp/aaa/bb/ccc/myfile.txt";
        checkFileAndDir(fileName);
        
        System.out.println("Current Directory:" + getCurrentDirectoryPath());
	}

	static String getCurrentDirectoryPath() {
		String currentDir = System.getProperty("user.dir");
		return currentDir;
	}

	/**
	 * 
	 * @param fileName - Full path and filename string eg.: C:\temp\myfile.txt
	 * @return
	 */
	static void checkFileAndDir(String fileName) {
		File file = new File(fileName);
		File parentDir = file.getParentFile();
		System.out.println("File: " + fileName + " - Exist: " + isFileExist(fileName));
		System.out.println("Parent Dir: " + parentDir + " - Exist: " + isDirExistFromFileName(fileName));
	}
	static boolean isFileExist(String fileName) {
		boolean exist = false;
		File file = new File(fileName);
		if(file.exists()) {
			exist = true;
		}
		return exist;
	}
	
	static boolean isDirExistFromFileName(String fileName) {
		boolean exist = false;
		File file = new File(fileName);
		File parentDir = file.getParentFile();
		if(parentDir.exists()) {
			exist = true;
		}
		return exist;
	}
    
    

}
