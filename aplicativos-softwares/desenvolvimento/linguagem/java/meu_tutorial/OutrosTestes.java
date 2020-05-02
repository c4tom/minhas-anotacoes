import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

public class OutrosTestes {

	public static void main(final String[] args) {
		
        // OS name
        final String operatingSystem = System.getProperty("os.name");

		try {
			if (operatingSystem.contains("Windows")) {
				Runtime.getRuntime().exec("cls");
			} else {
				Runtime.getRuntime().exec("clear");
			}
		} catch (final Exception e) {

		} 
        System.out.println("Sistema Operacional: " + operatingSystem);
		
		// Temporary file
		try {
			final File tmpFile = File.createTempFile("log-", ".txt");
			System.out.println("Meu Arquivo Temporario: " + tmpFile.getAbsolutePath());
		} catch (final IOException e) {
			e.printStackTrace();
		}
		
		// Get TMP dir
	    final String property = "java.io.tmpdir";
	    final String tempDir = System.getProperty(property);
        System.out.println("Diretório temporario neste sistema operacional " + tempDir + File.separator);
        
        // File and Directory check
        final String fileName = "/tmp/aaa/bb/ccc/myfile.txt";
        checkFileAndDir(fileName);
        
        System.out.println("Current Directory:" + getCurrentDirectoryPath());
	}

	static String getCurrentDirectoryPath() {
		final String currentDir = System.getProperty("user.dir");
		return currentDir;
	}

	/**
	 * 
	 * @param fileName - Full path and filename string eg.: C:\temp\myfile.txt
	 * @return
	 */
	static void checkFileAndDir(final String fileName) {
		final File file = new File(fileName);
		final File parentDir = file.getParentFile();
		System.out.println("File: " + fileName + " - Exist: " + isFileExist(fileName));
		System.out.println("Parent Dir: " + parentDir + " - Exist: " + isDirExistFromFileName(fileName));
	}
	static boolean isFileExist(final String fileName) {
		boolean exist = false;
		final File file = new File(fileName);
		if(file.exists()) {
			exist = true;
		}
		return exist;
	}
	
	static boolean isDirExistFromFileName(final String fileName) {
		boolean exist = false;
		final File file = new File(fileName);
		final File parentDir = file.getParentFile();
		if(parentDir.exists()) {
			exist = true;
		}
		return exist;
	}
	
	/**
	 * Get content of file
	 * @param filePath Path of file
	 * @return Content of file
	 */
	static String fileGetContent(final String filePath) {
		try {
			final File file = new File(filePath);
			final byte b[] = new byte[(int)file.length()];
			final FileInputStream fis = new FileInputStream(file);
			fis.read(b);
			fis.close();

			return new String(b);
			
		} 
		catch(final FileNotFoundException e){
            System.out.print("error 1" + e.getMessage());
        }
        catch(final IOException e){
            System.out.print("error 2" + e.getMessage());
        }
        catch(final Exception e){
            System.out.print("error 3" + e.getMessage());
		}
		return "";
	}
}
